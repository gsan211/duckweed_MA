#!/usr/bin/Rscript

library(data.table)
library(windowscanr)
library(dplyr)

#input file for relevant lines with depth and quality information for bases
rolwinWGS <- fread("../Duckweed/BCFtool_allsites/queries/list_V1.txt", header = FALSE, sep = ' ')

df <- aggregate(rolwinWGS$V2, by = list(rolwinWGS$V1), max)

#filter out any contig with less than 100bp, neccessary only for poor L. minor assembly
goodcont <- df[df$x > 100,] 

#filter contigs from initial input
test <- rolwinWGS[rolwinWGS$V1 %in% goodcont$Group.1]


#possible filtering functions for rolling window input
fractcov = function(X) {M = sum(X > 10 & X < 30)/length(X); M}
fractqual = function(X) {M = sum( X > 280)/length(X); M}
modmean = function(X) {M = sum( X == 1)/1000; M}


rolwinWGSout <- winScan(x = test, 
                   groups = "V1", 
                   position = "V2", 
                   values = c("V3"), 
                   win_size = 1000,
                   win_step = 100,
                   funs = c("mean")) 


write.table(rolwinWGSout, "GPL7_hets_filtering", sep="\t", col.names = T, row.names = F, quote = F)
