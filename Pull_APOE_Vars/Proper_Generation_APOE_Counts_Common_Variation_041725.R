#This R script has the purpose of generating APOE variant counts based on common variant haplotypes
library(data.table)
library(openxlsx)
Recode_File_APOE_Counts <- fread("V2_APOE_Genotype_Pull_B_041725.raw")
colnames(Recode_File_APOE_Counts)
dim(Recode_File_APOE_Counts)
Full_BioMe_gcounts <- read.xlsx("Full_BioMe_Selected_APOE_gcounts_041425.xlsx")
dim(Full_BioMe_gcounts)
colnames(Full_BioMe_gcounts)
summary(as.factor(Recode_File_APOE_Counts$rs429358_T))
summary(as.factor(Recode_File_APOE_Counts$rs7412_C))
#352 is the e2/e2 haplotype and the 1357 is the e4/e4 haplotype, which matches the gcounts file (a check to show that those numbers are correct)
#NA of 12 participants for the rs7412 genotype and NA of 122 for the rs429358 genotype
NArs429358 <- Recode_File_APOE_Counts[is.na(Recode_File_APOE_Counts$rs429358_T),]
dim(NArs429358)
#Now we pulled out those participants
NArs7412 <- Recode_File_APOE_Counts[is.na(Recode_File_APOE_Counts$rs7412_C),]
dim(NArs7412)
Check_NA_Overlap <- NArs429358[match(intersect(NArs7412$IID, NArs429358$IID), NArs429358$IID),]
dim(Check_NA_Overlap)
#Only 2 individuals from both missingness groups overlap. This means there are 130 additional participants that are missing from the data that need to be extracted
#Likely 132 participants total with missingness that will need to be dropped
DropA_Recode_File_APOE_Counts <- Recode_File_APOE_Counts[match(setdiff(Recode_File_APOE_Counts$IID, NArs429358$IID), Recode_File_APOE_Counts$IID),]
dim(DropA_Recode_File_APOE_Counts)
DropB_Recode_File_APOE_Counts <- DropA_Recode_File_APOE_Counts[match(setdiff(DropA_Recode_File_APOE_Counts$IID, NArs7412$IID), DropA_Recode_File_APOE_Counts$IID),]
dim(DropB_Recode_File_APOE_Counts)
#Now all 132 participants have been dropped
#Now we can actually generate the proper numbers
summary(as.factor(DropB_Recode_File_APOE_Counts$rs429358_T))
summary(as.factor(DropB_Recode_File_APOE_Counts$rs7412_C))
#The minor haplotypes of e2/e2 and e4/e4 still stand as is
#Next is to calculate and extract the e3/e3 haplotype from this set
e3_e3_Extraction <- DropB_Recode_File_APOE_Counts[which(DropB_Recode_File_APOE_Counts$rs429358_T == 2 & DropB_Recode_File_APOE_Counts$rs7412_C == 2),]
dim(e3_e3_Extraction)
#36,339 participants have both major alleles for the snps rs429358(TT) and rs7412(CC)
e4_e3_Extraction <- DropB_Recode_File_APOE_Counts[which(DropB_Recode_File_APOE_Counts$rs429358_T == 1 & DropB_Recode_File_APOE_Counts$rs7412_C == 2),]
e2_e3_Extraction <- DropB_Recode_File_APOE_Counts[which(DropB_Recode_File_APOE_Counts$rs429358_T == 2 & DropB_Recode_File_APOE_Counts$rs7412_C == 1),]
dim(e4_e3_Extraction)
dim(e2_e3_Extraction)
e2_e2 <- DropB_Recode_File_APOE_Counts[which(DropB_Recode_File_APOE_Counts$rs7412_C == 0), ]
e4_e4 <- DropB_Recode_File_APOE_Counts[which(DropB_Recode_File_APOE_Counts$rsrs429358_T == 0), ]
e2_e4_Extraction <- DropB_Recode_File_APOE_Counts[which(DropB_Recode_File_APOE_Counts$rs429358_T == 1 & DropB_Recode_File_APOE_Counts$rs7412_C == 1),]
dim(e2_e4_Extraction)
dim(e2_e2_Extraction)
dim(e4_e4_Extraction)
nrow(e2_e2_Extraction) + nrow(e4_e4_Extraction) + nrow(e3_e3_Extraction) + nrow(e2_e3_Extraction) + nrow(e2_e4_Extraction) + nrow(e4_e3_Extraction)
#This equals 58,254 participants which are the total number of participants without missingness from both rsids used to generate the APOE common variable haplotypes
q()
