#The goal of this script is to generate the liftover of the snps from hg19 eMERGE to hg38.
library(data.table)
library(rtracklayer)
library(GenomicRanges)
chain_file <- "/sc/arion/projects/buxbaj01a/rowanb01/Bryce_Scratch_Work/Reanalzying_Updated_Samples/Rerun_Analyses_January24/Generating_LiftOverSumstats_hg19_to_hg38/hg19ToHg38.over.chain"
chain <- import.chain(chain_file)
Emerge_Original_Files <- fread("eMERGE_prs_adjustment_files_from_Chris_060425/eMERGE_prs_adjustment.pc.sites", header=F)
New_FileA <- data.frame(do.call('rbind', strsplit(Emerge_Original_Files$Original_ID, ':', fixed=TRUE)))
dim(New_FileA)
#321392      4
colnames(New_FileA) <- c("CHR", "POS", "A1", "A2")
New_FileA$Original_ID <- Emerge_Original_Files$Original_ID
New_FileB <- New_FileA[,c(1,5,2,3,4)]
colnames(New_FileB)
#"CHR"         "Original_ID" "POS"         "A1"          "A2" 
New_FileB$POS <- as.numeric(New_FileB$POS)
GWAS_Ranges <- GRanges(seqnames = Rle(New_FileB$CHR),  ranges = IRanges(start = New_FileB$POS - 1, end = New_FileB$POS))
seqlevelsStyle(GWAS_Ranges) <- 'UCSC'
head(GWAS_Ranges, 5)
#GRanges object with 5 ranges and 0 metadata columns:
#      seqnames        ranges strand
#         <Rle>     <IRanges>  <Rle>
#  [1]     chr1 737262-737263      *
#  [2]     chr1 754428-754429      *
#  [3]     chr1 761763-761764      *
#  [4]     chr1 762319-762320      *
#  [5]     chr1 773997-773998      *
#  -------
#  seqinfo: 22 sequences from an unspecified genome; no seqlengths
mcols(GWAS_Ranges)$CHR <- New_FileB$CHR
mcols(GWAS_Ranges)$Original_ID <- New_FileB$Original_ID
mcols(GWAS_Ranges)$POS <- New_FileB$POS
mcols(GWAS_Ranges)$A1 <- New_FileB$A1
mcols(GWAS_Ranges)$A2 <- New_FileB$A2
seqlevelsStyle(GWAS_Ranges) <- 'UCSC'
head(GWAS_Ranges, 5)
liftover_output <- liftOver(GWAS_Ranges, chain)
head(liftover_output, 5)
df_liftover_outputA <- data.frame(liftover_output@unlistData)
head(df_liftover_outputA, 5)
#  seqnames  start    end width strand CHR  Original_ID    POS A1 A2
#1     chr1 801882 801883     2      *   1 1:737263:A:G 737263  A  G
#2     chr1 819048 819049     2      *   1 1:754429:G:T 754429  G  T
#3     chr1 826383 826384     2      *   1 1:761764:A:G 761764  A  G
#4     chr1 826939 826940     2      *   1 1:762320:C:T 762320  C  T
#5     chr1 838617 838618     2      *   1 1:773998:C:T 773998  C  T
dim(df_liftover_outputA)
#[1] 321334     10
nrow(New_FileA) - nrow(df_liftover_outputA)
#[1] 58
#There are 58 variants lost in the liftover process
df_liftover_outputA$RedoneSeqnames <- gsub("chr", "", df_liftover_outputA$seqnames)
head(df_liftover_outputA$RedoneSeqnames, 5)
#[1] "1" "1" "1" "1" "1"
#Alleles stay the same for the variants across hg19 and hg38, which is excellent
df_liftover_outputA$New_ID <- paste(df_liftover_outputA$RedoneSeqnames, df_liftover_outputA$end, df_liftover_outputA$A1, df_liftover_outputA$A2, sep=":")
head(df_liftover_outputA$New_ID, 5)
#[1] "1:801883:A:G" "1:819049:G:T" "1:826384:A:G" "1:826940:C:T" "1:838618:C:T"
fwrite(df_liftover_outputA, "Liftover_Results_eMERGE_SNPs_for_PCs_062025.csv")
#Now to find the 58 missing snps for manual reupdating occurs
Missing_Subset <- New_FileA[match(setdiff(New_FileA$Original_ID, df_liftover_outputA$Original_ID), New_FileA$Original_ID),]
dim(Missing_Subset)
#[1] 58  5
#Perfect!
fwrite(Missing_Subset, "Manually_Add_Missing_Subset_List_062025.csv")
q()
