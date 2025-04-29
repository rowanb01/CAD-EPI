#This R script has the purpose of generating APOE variant counts based on common variant haplotypes
library(data.table)
library(openxlsx)
Recode_File_APOE_Counts <- fread("Redone_V2_APOE_Genotype_Pull_B_042925.raw")
colnames(Recode_File_APOE_Counts)
dim(Recode_File_APOE_Counts)
Old_raw_counts <- fread("V2_APOE_Genotype_Pull_B_041725.raw")
summary(as.factor(Old_raw_counts$rs429358_T))
#This worked before because everything was coded into 0, 1, 2, NAs instead of dosages, which created a new set of problems for simply pulling out code
rs429358_T <- Recode_File_APOE_Counts$rs429358_T
rs429358_T_Recoded <- car::recode(rs429358_T, "0:0.49 = 0; 0.5:1.49 = 1; 1.49:2 = 2")
summary(as.factor(rs429358_T_Recoded))
1363 + 14067 + 42956
range(Recode_File_APOE_Counts$rs429358_T)
range(Recode_File_APOE_Counts$rs7412_C)
rs7412_C <- Recode_File_APOE_Counts$rs7412_C
rs7412_C_Recoded <- car::recode(rs7412_C, "0:0.49 = 0; 0.5:1.49 = 1; 1.49:2 = 2")
summary(as.factor(rs7412_C_Recoded))
Recode_File_APOE_Counts$V2_rs429358_T <- rs429358_T_Recoded
Recode_File_APOE_Counts$V2_rs7412_C <- rs7412_C_Recoded
e3_e3_Extraction <- Recode_File_APOE_Counts[which(Recode_File_APOE_Counts$V2_rs429358_T == 2 & Recode_File_APOE_Counts$V2_rs7412_C == 2),]
e4_e3_Extraction <- Recode_File_APOE_Counts[which(Recode_File_APOE_Counts$V2_rs429358_T == 1 & Recode_File_APOE_Counts$V2_rs7412_C == 2),]
e2_e3_Extraction <- Recode_File_APOE_Counts[which(Recode_File_APOE_Counts$V2_rs429358_T == 2 & Recode_File_APOE_Counts$V2_rs7412_C == 1),]
e2_e4_Extraction <- Recode_File_APOE_Counts[which(Recode_File_APOE_Counts$V2_rs429358_T == 1 & Recode_File_APOE_Counts$V2_rs7412_C == 1),]
e2_e2_Extraction <- Recode_File_APOE_Counts[which(Recode_File_APOE_Counts$V2_rs7412_C == 0),]
e4_e4_Extraction <- Recode_File_APOE_Counts[which(Recode_File_APOE_Counts$V2_rs429358_T == 0),]
nrow(e2_e2_Extraction) + nrow(e2_e3_Extraction) + nrow(e2_e4_Extraction) + nrow(e3_e3_Extraction) + nrow(e4_e3_Extraction) + nrow(e4_e4_Extraction)
#The numbers add up!
dim(e2_e2_Extraction)
dim(e2_e3_Extraction)
dim(e2_e4_Extraction)
dim(e3_e3_Extraction)
dim(e4_e3_Extraction)
dim(e4_e4_Extraction)
q()
