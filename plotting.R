library(ggplot2)
libary(data.table)


#figure 1 plotting mutant base frequency in illumina vs sanger sequencing data
df = fread(../illumina_sanger.txt, header =T)
p <- ggplot(df, aes(x=ref_sanger, y=sanger_Freq	))+ geom_boxplot(fill='#A4A4A4', color="black", outlier.shape = NA)+
    geom_jitter(shape=16, position=position_jitter(0.2))+ theme_classic()+
   scale_y_continuous(trans='log10')+ylab("Mutation rate per bp. per gen. (Log10 scale)")+
  theme(text = element_text(size=15))
  
p
