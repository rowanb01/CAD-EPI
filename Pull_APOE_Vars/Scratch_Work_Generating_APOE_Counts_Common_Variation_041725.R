#This R script has the purpose of generating scratch code for the APOE variant count generation
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
352+6196+36339+12776+1357
#Still missing some members, which means I will need to recount a few
Test_Remaining_SamplesA <- DropB_Recode_File_APOE_Counts[match(setdiff(DropB_Recode_File_APOE_Counts$IID, e3_e3_Extraction$IID), DropB_Recode_File_APOE_Counts$IID),]
dim(Test_Remaining_SamplesA)
#Down to 21915
Test_Remaining_SamplesB <- Test_Remaining_SamplesA[match(setdiff(Test_Remaining_SamplesA$IID, e4_e3_Extraction$IID), Test_Remaining_SamplesA$IID),]
dim(Test_Remaining_SamplesB)
#Now we are down to 9,139 samples
Test_Remaining_SamplesC <- Test_Remaining_SamplesB[match(setdiff(Test_Remaining_SamplesB$IID, e2_e3_Extraction$IID), Test_Remaining_SamplesB$IID),]
dim(Test_Remaining_SamplesC)
#Now we are down to 2943 samples
summary(as.factor(Test_Remaining_SamplesC$rs429358_T))
summary(as.factor(Test_Remaining_SamplesC$rs7412_C))
e2_e2_Extraction <- Test_Remaining_SamplesC[which(Test_Remaining_SamplesC$rs7412_C == 0),] 
Test_Remaining_SamplesD <- Test_Remaining_SamplesC[match(setdiff(Test_Remaining_SamplesC$IID, e2_e2_Extraction$IID), Test_Remaining_SamplesC$IID), ]
dim(e2_e2_Extraction)
dim(Test_Remaining_SamplesD)
e4_e4_ExtractionA <- Test_Remaining_SamplesD[which(Test_Remaining_SamplesD$rs429358_T == 0),] 
dim(e4_e4_ExtractionA)
#That stayed the same, showing there is no overlap for that portion either
Test_Remaining_SamplesE <- Test_Remaining_SamplesD[match(setdiff(Test_Remaining_SamplesD$IID, e4_e4_ExtractionA$IID), Test_Remaining_SamplesD$IID), ]
dim(Test_Remaining_SamplesE)
summary(as.factor(Test_Remaining_SamplesE))
summary(as.factor(Test_Remaining_SamplesE$rs429358_T))
summary(as.factor(Test_Remaining_SamplesE$rs7412_C))
#Now we have the proper numbers accounting for the genotypes in a proper manner
q()
