library(ggplot2)
libary(data.table)


#figure 1 plotting mutant base frequency in illumina vs sanger sequencing data

df = fread(../fig1_illumina_sanger_data.txt, header =T)
ggplot(df, aes(x = sanger_Freq, y = illumina_freq ))+
  geom_point(size = 4) +theme_bw(base_size = 15)+
  theme(panel.grid.minor.x=element_blank(),panel.grid.minor.y=element_blank(),panel.grid.major.x=element_blank(), panel.grid.major.y=element_blank())+
  xlab("Mutant frequency Sanger")+ylab("Mutatant frequency Illumina")+
  geom_smooth(method='lm', colour="black", se = FALSE)

#figure 3 plotting mutation rates in two species of duckweed across 2 different treatments (control vs. salt stress)
df = fread(../fig3_ma_data.txt, header=F)
require(ggplot2)
ggplot(df, aes(x = V4, y = V1, colour = factor(V5), group=V5)) +
  geom_point(size = 4,position=position_dodge(width=0.6)) +
  geom_errorbar(aes(ymax = V2, ymin = V3, width = 0.3),position=position_dodge(width=0.6))+
  #ggtitle("Power 0.2")+
  theme_bw()+
  theme(legend.position = c(0.9, 0.8))+
  #geom_point(aes(colour = factor(V4)))+
  scale_color_manual(values=c("black", "darkorange3"))+
  xlab("Mutation Accumulation lines")+ylab("Mutation rate (per bp. per gen.)")+
  theme(legend.title = element_blank())+
  theme(panel.grid.minor.x=element_blank(),panel.grid.minor.y=element_blank(),panel.grid.major.x=element_blank(), panel.grid.major.y=element_blank())

#figure 4 plotting mutation rates in two species of duckweed across 2 different treatments (control vs. salt stress), with the 2 S. polyrhiza genotypes being separate
df = fread(../fig4_ma_data.txt, header=F)
require(ggplot2)
ggplot(df, aes(x = V4, y = V1, colour = factor(V5), group=V5)) +
  geom_point(size = 4,position=position_dodge(width=0.6)) +
  geom_errorbar(aes(ymax = V2, ymin = V3, width = 0.3),position=position_dodge(width=0.6))+
  #ggtitle("Power 0.2")+
  theme_bw()+
  theme(legend.position = c(0.9, 0.8))+
  #geom_point(aes(colour = factor(V4)))+
  scale_color_manual(values=c("black", "darkorange3"))+
  xlab("Mutation Accumulation lines")+ylab("Mutation rate (per bp. per gen.)")+
  theme(legend.title = element_blank())+
  theme(panel.grid.minor.x=element_blank(),panel.grid.minor.y=element_blank(),panel.grid.major.x=element_blank(), panel.grid.major.y=element_blank())
