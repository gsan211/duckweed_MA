library(ggplot2)
libary(data.table)


#figure 1 plotting mutant base frequency in illumina vs sanger sequencing data

df = fread(../illumina_sanger.txt, header =T)
ggplot(df, aes(x = sanger_Freq, y = illumina_freq ))+
  geom_point(size = 4) +theme_bw(base_size = 15)+
  theme(panel.grid.minor.x=element_blank(),panel.grid.minor.y=element_blank(),panel.grid.major.x=element_blank(), panel.grid.major.y=element_blank())+
  xlab("Mutant frequency Sanger")+ylab("Mutatant frequency Illumina")+
  geom_smooth(method='lm', colour="black", se = FALSE)
