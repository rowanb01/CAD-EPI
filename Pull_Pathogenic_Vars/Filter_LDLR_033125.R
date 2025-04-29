#The code below was selected after trial and error to produce the lines that matter for filtering ClinVar variants and saving the results in an easy to use manner
library(data.table)
library(openxlsx)
LDLR_Prefiltered <- fread("LDLR_Clinvar_Results_Prefiltered.txt")
colnames(LDLR_Prefiltered)
summary(as.factor(LDLR_Prefiltered[,14]))
summary(as.factor(LDLR_Prefiltered[,16]))
LDLR_SNP_P_LP <- LDLR_Prefiltered[which(LDLR_Prefiltered[,16] == "Likely pathogenic" | LDLR_Prefiltered[,16] == "Pathogenic" | LDLR_Prefiltered[,16] == "Pathogenic/Likely pathogenic" & LDLR_Prefiltered[,16] != "Conflicting classifications of pathogenicity"),]
#LDLR_SNP_P_LP <- LDLR_Prefiltered[which(LDLR_Prefiltered[,19] != ""),]
#Too stringent of a filter
LDLR_SNP_P_LP[,1]
LDLR_SNP_P_LP[,8]
LDLR_SNP_P_LP[,9]
LDLR_SNP_P_LP[,16]
write.xlsx(LDLR_SNP_P_LP, "LDLR_Filtered_Variant_List_033125.xlsx")
write.table(LDLR_SNP_P_LP, "LDLR_Filtered_Variant_List_033125.txt", row.names=F, col.names=T, sep="\t")
q()
