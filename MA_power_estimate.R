setwd(../duckweedMA)
library(reshape2)
library(data.table)
library(stringr)
library(tidyr)
library(dplyr)


#randomly sample values fromn each row (however many sample per row next to d)
sample = fread(../sites_power_estimation.txt)
sample$V1<- NULL
sample2 <-t(apply(sample, 1, function(d) sample(d, 1)))

#convert row to column
df2 <- dcast(melt(as.matrix(sample2)), Var2~paste0('r', Var1), value.var='value')

#step to account for the possible occurence of sequencing errors that match real mutation in a different line
#count , and . to figure out how many MA lines have alernate alleles
df2$com <- str_count(df2$r1, "\\,")
df2$dot <- str_count(df2$r1, "\\.")
allclean <- df2[df2$com == 1,]
onealt <- df2[df2$com == 2 & df2$dot == 1,]
#subsample onealt df to account for error/mutant coincidence, as prob that sequencing error matches mutations is 1/3
onealt_red <- onealt %>% sample_frac(.666)

df3 <- rbind(allclean, onealt_red)

sim <- colsplit(df3$r1, ',', names = c('ref', 'alt'))

#function for drawing from binomial distribution in a dataframe, 0.28 is expected frequency for spirodela, 0.34 for lemna minor
bd <- function(x, p = 0.28){rbinom(1, x , 0.28)}
#for applying to df
sim$binom <- mapply(bd, sim$ref)

#4 read cutoff used in analysis here
sim_pass <- sim[sim$binom > 4,]
nrow(sim_pass)

#final power estimate
nrow(sim_pass)/500000

