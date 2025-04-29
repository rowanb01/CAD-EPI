#The code below was selected after trial and error to produce the lines that matter for filtering ClinVar variants and saving the results in an easy to use manner
library(data.table)
library(openxlsx)
APOB_Prefiltered <- fread("APOB_Clinvar_Results_Prefiltered.txt")
colnames(APOB_Prefiltered)
summary(as.factor(APOB_Prefiltered[,14]))
summary(as.factor(APOB_Prefiltered[,16]))
APOB_SNP_P_LP <- APOB_Prefiltered[which(APOB_Prefiltered[,16] == "Likely pathogenic" | APOB_Prefiltered[,16] == "Pathogenic" | APOB_Prefiltered[,16] == "Pathogenic/Likely pathogenic" & APOB_Prefiltered[,16] != "Conflicting classifications of pathogenicity"),]
APOB_SNP_P_LP[,1]
APOB_SNP_P_LP[,8]
APOB_SNP_P_LP[,9]
APOB_SNP_P_LP[,16]
write.xlsx(APOB_SNP_P_LP, "APOB_Filtered_Variant_List_033125.xlsx")
write.table(APOB_SNP_P_LP, "APOB_Filtered_Variant_List_033125.txt", row.names=F, col.names=T, sep="\t")
q()
