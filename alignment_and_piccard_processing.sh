for ind in CC_B_ CC_C_ CC_D_ 
do

bwa mem ../Spirodela_genomic.fna ../fastq_CC/${ind}R1.fastq.gz../fastq_CC/${ind}R2.fastq.gz | samtools view -Sb -> ../CC_firstmap/${ind}bwa.bam
#samtools view -h -o ../CC_firstmap/${ind}bwa.sam ../CC_firstmap/${ind}bwa.bam

java -jar ../libs/picard.jar AddOrReplaceReadGroups I= ../CC_firstmap/${ind}bwa.bam O= ../CC_firstmap/${ind}_add.bam SO=coordinate RGID=${ind} RGLB=${ind} RGPL=Illumina RGPU=1 RGSM=${ind} TMP_DIR=../tmp
samtools index ../CC_firstmap/${ind}add.bam

java -jar ../libs/picard.jar MarkDuplicates ../CC_firstmap/${ind}_add.bam O= ../CC_firstmap/${ind}_ddpl.bam  CREATE_INDEX=true VALIDATION_STRINGENCY=SILENT M= ../CC_firstmap/${ind}_ddpl.metrics MAX_FILE_HANDLES_FOR_READ_ENDS_MAP= 3000

done
