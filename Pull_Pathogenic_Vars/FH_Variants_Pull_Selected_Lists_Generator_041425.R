#The goal is to generate a file that has the intial gene lists pulled for FH followed by a series of subsetting
library(data.table)
library(openxlsx)
#Read in proper chromsome files for 3 outputs, LDLR, APOB, PCSK9
#This is just for the high end of the results
Chr19 <- fread("/sc/arion/projects/igh/kennylab/christa/mapping_ibd/exomes/vep/chr19_vep.bed")
Chr2 <- fread("/sc/arion/projects/igh/kennylab/christa/mapping_ibd/exomes/vep/chr2_vep.bed")
Chr1 <- fread("/sc/arion/projects/igh/kennylab/christa/mapping_ibd/exomes/vep/chr1_vep.bed")
colnames(Chr19)
head(Chr19,2)
Test_LDLR <- Chr19[which(Chr19$V8 == "ENSG00000130164")]
dim(Test_LDLR)
head(Test_LDLR, 3)
#Needs renaming at some point but the proper spots are pulled out for LDLR
Test_APOB <- Chr2[which(Chr2$V8 == "ENSG00000084674")]
dim(Test_APOB)
head(Test_APOB, 3)
Test_PCSK9 <- Chr1[which(Chr1$V8 == "ENSG00000169174")]
dim(Test_PCSK9)
#Not as many as the others but this looks like it worked
head(Test_PCSK9, 3)
summary(as.factor(Test_APOB$V25))
summary(as.factor(Test_LDLR$V25))
summary(as.factor(Test_PCSK9$V25))
#Next thing is to generate the colnames for the files and go from there with saving the results as a large file followed by saving the subsets to pathogenic/likely pathogenic
colnames(Test_LDLR) <- c("0","1","2","Location","Uploaded_variation","Existing_variation","SYMBOL","Gene","Protein_position","Amino_acids","Codons","gnomADe_AF","gnomADe_AFR_AF","gnomADe_AMR_AF","gnomADe_ASJ_AF","gnomADe_EAS_AF","gnomADe_FIN_AF","gnomADe_MID_AF","gnomADe_NFE_AF","gnomADe_REMAINING_AF","gnomADe_SAS_AF","Consequence","CLIN_SIG","ClinVar","ClinVar_CLNSIG","ClinVar_CLNREVSTAT","PHENOTYPES","IMPACT","SIFT","PolyPhen","REVEL","am_class","PrimateAI")
colnames(Test_APOB) <- c("0","1","2","Location","Uploaded_variation","Existing_variation","SYMBOL","Gene","Protein_position","Amino_acids","Codons","gnomADe_AF","gnomADe_AFR_AF","gnomADe_AMR_AF","gnomADe_ASJ_AF","gnomADe_EAS_AF","gnomADe_FIN_AF","gnomADe_MID_AF","gnomADe_NFE_AF","gnomADe_REMAINING_AF","gnomADe_SAS_AF","Consequence","CLIN_SIG","ClinVar","ClinVar_CLNSIG","ClinVar_CLNREVSTAT","PHENOTYPES","IMPACT","SIFT","PolyPhen","REVEL","am_class","PrimateAI")
colnames(Test_PCSK9) <- c("0","1","2","Location","Uploaded_variation","Existing_variation","SYMBOL","Gene","Protein_position","Amino_acids","Codons","gnomADe_AF","gnomADe_AFR_AF","gnomADe_AMR_AF","gnomADe_ASJ_AF","gnomADe_EAS_AF","gnomADe_FIN_AF","gnomADe_MID_AF","gnomADe_NFE_AF","gnomADe_REMAINING_AF","gnomADe_SAS_AF","Consequence","CLIN_SIG","ClinVar","ClinVar_CLNSIG","ClinVar_CLNREVSTAT","PHENOTYPES","IMPACT","SIFT","PolyPhen","REVEL","am_class","PrimateAI")
#Now the colnames have been added in
Spreadsheet_Full_Christa_Set_Pull_041425 <- list("LDLR" = Test_LDLR, "APOB" = Test_APOB, "PCSK9" = Test_PCSK9)
write.xlsx(Spreadsheet_Full_Christa_Set_Pull_041425, "Requested_high_risk_varaints_FH_All_Variants_in_Gene_Pull_041425.xlsx")
#Above method worked
#Now to do the subsetting
Pathogenic_LDLR <- Test_LDLR[which(Test_LDLR$ClinVar_CLNSIG == "Pathogenic/Likely_pathogenic"),]
dim(Pathogenic_LDLR)
rm(Pathogenic_LDLR)
Pathogenic_LDLR <- Test_LDLR[which(Test_LDLR$ClinVar_CLNSIG == "Pathogenic/Likely_pathogenic" | Test_LDLR$ClinVar_CLNSIG == "Pathogenic"),]
dim(Pathogenic_LDLR)
rm(Pathogenic_LDLR)
Pathogenic_LDLR <- Test_LDLR[which(Test_LDLR$ClinVar_CLNSIG == "Pathogenic/Likely_pathogenic" | Test_LDLR$ClinVar_CLNSIG == "Pathogenic" & Test_LDLR$ClinVar_CLNSIG != "Conflicting_classifications_of_pathogenicity"),]
dim(Pathogenic_LDLR)
#Based on pull the classifications don't intersect. I will have a slight test to check this pull
head(Test_LDLR[which(Test_LDLR$ClinVar_CLNSIG == "Conflicting_classifications_of_pathogenicity"),], 2)
head(Pathogenic_LDLR, 2)
#Can check the ids briefly for overlap
Conflicting_Evidence_LDLR <- Test_LDLR[which(Test_LDLR$ClinVar_CLNSIG == "Conflicting_classifications_of_pathogenicity"),]
Conflicting_Evidence_APOB <- Test_APOB[which(Test_APOB$ClinVar_CLNSIG == "Conflicting_classifications_of_pathogenicity"),]
Conflicting_Evidence_PCSK9 <- Test_PCSK9[which(Test_PCSK9$ClinVar_CLNSIG == "Conflicting_classifications_of_pathogenicity"),]
Spreadsheet_Conflicting_Evidence_Selected <- list("LDLR" = Conflicting_Evidence_LDLR, "APOB" = Conflicting_Evidence_APOB, "PCSK9" = Conflicting_Evidence_PCSK9)
write.xlsx(Spreadsheet_Conflicting_Evidence_Selected, "Requested_high_risk_varaints_FH_Conflicting_Evidence_041425.xlsx")
Pathogenic_APOB <- Test_APOB[which(Test_APOB$ClinVar_CLNSIG == "Pathogenic/Likely_pathogenic" | Test_APOB$ClinVar_CLNSIG == "Pathogenic" & Test_APOB$ClinVar_CLNSIG != "Conflicting_classifications_of_pathogenicity"),]
Pathogenic_PCSK9 <- Test_PCSK9[which(Test_PCSK9$ClinVar_CLNSIG == "Pathogenic/Likely_pathogenic" | Test_PCSK9$ClinVar_CLNSIG == "Pathogenic" & Test_PCSK9$ClinVar_CLNSIG != "Conflicting_classifications_of_pathogenicity"),]
Spreadsheet_Pathogenic_Selected <- list("LDLR" = Pathogenic_LDLR, "APOB" = Pathogenic_APOB, "PCSK9" = Pathogenic_PCSK9)
write.xlsx(Spreadsheet_Pathogenic_Selected, "Requested_high_risk_varaints_FH_Pathogenic_Likely_Pathogenic_041425.xlsx")
q()
