#The code below was selected after trial and error to produce the lines that matter for filtering ClinVar variants and saving the results in an easy to use manner
library(data.table)
library(openxlsx)
PCSK9_Prefiltered <- fread("PCSK9_Clinvar_Results_Prefiltered.txt")
colnames(PCSK9_Prefiltered)
summary(as.factor(PCSK9_Prefiltered[,14]))
summary(as.factor(PCSK9_Prefiltered[,16]))
PCSK9_SNP_P_LP <- PCSK9_Prefiltered[which(PCSK9_Prefiltered[,16] == "Benign" | PCSK9_Prefiltered[,16] == "Likely benign" | PCSK9_Prefiltered[,16] == "Benign/Likely benign" & PCSK9_Prefiltered[,16] != "Conflicting classifications of pathogenicity"),]
PCSK9_SNP_P_LP[,1]
PCSK9_SNP_P_LP[,8]
PCSK9_SNP_P_LP[,9]
PCSK9_SNP_P_LP[,16]
write.xlsx(PCSK9_SNP_P_LP, "PCSK9_Protective_Filtered_Variant_List_033125.xlsx")
write.table(PCSK9_SNP_P_LP, "PCSK9_Protective_Filtered_Variant_List_033125.txt", row.names=F, col.names=T, sep="\t")
q()
