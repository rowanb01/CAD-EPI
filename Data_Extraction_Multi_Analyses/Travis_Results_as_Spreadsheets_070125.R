#Convert the tables Travis produced with some of those cutoffs into spreadsheets that could be replicated for me to eventually change into a diagram
library(data.table)
library(openxlsx)
Travis_Table_QC_Variants_ancestry_specific <- fread("/sc/arion/projects/igh/data/MSM/qc_data_local/MSM/tables/MSM_ancestry-specific_QC.txt")
Travis_Table_QC_TopMed_all <- fread("/sc/arion/projects/igh/data/MSM/qc_data_local/MSM/tables/MSM_allAncestry_QC.txt")
dim(Travis_Table_QC_Variants_ancestry_specific)
# 10  4
write.table(Travis_Table_QC_Variants_ancestry_specific, "Redone_Travis_Table_QC_Variants_Samples_Ancestry_Specific.txt", col.names=T, row.names=F, quote=F, sep="\t")
#Copying from text files aren't going to work
write.xlsx(Travis_Table_QC_Variants_ancestry_specific, "Redone_Travis_Table_QC_Variants_Samples_Ancestry_Specific.xlsx")
write.xlsx(Travis_Table_QC_TopMed_all, "Redone_Travis_Table_QC_Variants_imputed_data_QC.xlsx")
q()


