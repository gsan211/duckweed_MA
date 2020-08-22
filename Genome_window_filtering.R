#!/usr/bin/Rscript

library(data.table)
library(windowscanr)
library(dplyr)

#input file for relevant genotype, contains coordinates + base quality info for heterozygotes (which provides enough info to filter genomic regions by # hets)
rolwinWGS <- fread("../Duckweed/BCFtool_allsites/queries/GPL7_list_V1.txt", header = FALSE, sep = ' ')

df <- aggregate(rolwinWGS$V2, by = list(rolwinWGS$V1), max)

#filter out any contigs with less than 100bp, neccessary only for poor L. minor assembly
goodcont <- df[df$x > 100,] 

#filter contigs from initial input
test <- rolwinWGS[rolwinWGS$V1 %in% goodcont$Group.1]


#alternative filtering functions for rolling window input
#fractcov = function(X) {M = sum(X > 10 & X < 30)/length(X); M}
#fractqual = function(X) {M = sum( X > 280)/length(X); M}
#modmean = function(X) {M = sum( X == 1)/1000; M}


rolwinWGSout <- winScan(x = test, 
                   groups = "V1", 
                   position = "V2", 
                   values = c("V3"), 
                   win_size = 1000,
                   win_step = 100,
                   funs = c("mean")) 

#allow only windows with a max of 6 observed heterozygotes within 1000bp
out = rolwinWGSout[rolwinWGSout$V3_n < 6,]
write.table(out, "GPL7_hets_filtering", sep="\t", col.names = T, row.names = F, quote = F)

########################################################################
# optional can merge overlapping windows to speed things up downstream #
########################################################################

library(GenomicRanges)
#create grange dataframe for package
dt <- makeGRangesFromDataFrame(out, seqnames.field = "V1", start.field = "win_start", end.field = "win_end")
#merge overlapping ranges
df <- reduce(dt)
#convert back to df
dc <- data.frame(df)
dc$width <- NULL
dc$strand <- NULL
write.table(dc, "../TargetsWGGPL7_hets_5max.txt", sep="\t", col.names = F, row.names = F, quote = F)

