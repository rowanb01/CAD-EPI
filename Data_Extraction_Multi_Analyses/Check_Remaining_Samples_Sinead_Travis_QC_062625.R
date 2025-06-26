#The goal is to have the code used to check numbers after trying Travis QC steps
library(data.table)
AFR <- fread("Sinead_Data_Travis_QC/Similar_QC_AFR_Main_Adult_Cohort_062625.fam")
colnames(AFR)
EUR <- fread("Sinead_Data_Travis_QC/Similar_QC_EUR_Main_Adult_Cohort_062625.fam")
EAS <- fread("Sinead_Data_Travis_QC/Similar_QC_EAS_Main_Adult_Cohort_062625.fam")
SAS <- fread("Sinead_Data_Travis_QC/Similar_QC_SAS_Main_Adult_Cohort_062625.fam")
HIS <- fread("Sinead_Data_Travis_QC/Similar_QC_HIS_Main_Adult_Cohort_062625.fam")
JEWISH <- fread("Sinead_Data_Travis_QC/Similar_QC_JEWISH_Main_Adult_Cohort_062625.fam")
NAT_AMER <- fread("Sinead_Data_Travis_QC/Similar_QC_NAT_AMER_Main_Adult_Cohort_062625.fam")
Multi_Ethn <- fread("Sinead_Data_Travis_QC/Similar_QC_MULTI_ETH_Main_Adult_Cohort_062625.fam")
Other <- fread("Sinead_Data_Travis_QC/Similar_QC_OTH_Main_Adult_Cohort_062625.fam")
objects()
nrow(AFR)
# 10110
nrow(EUR)
# 15198
nrow(EAS)
# 1819
nrow(SAS)
# 1299
nrow(HIS)
# 17577
nrow(JEWISH)
# 30
nrow(NAT_AMER)
# 92
nrow(Multi_Ethn)
# 3022
nrow(Other)
# 3022
dim(MULTI_Eth_IDs)
# 712   2
write.table(MULTI_Eth_IDs, "Multiethnic_American_Main_Adult_Cohort_Sinead_Race_Assignment_062425.txt", col.names=T, row.names=F, quote=F, sep="\t")
Multi_Ethn <- fread("Sinead_Data_Travis_QC/Similar_QC_MULTI_ETH_Main_Adult_Cohort_062625.fam")
dim(Multi_Ethn)
# 712   6
nrow(AFR) + nrow(EUR) + nrow(EAS) + nrow(SAS) + nrow(HIS) + nrow(JEWISH) + nrow(NAT_AMER) + nrow(Multi_Ethn) + nrow(Other)
# 49859
#Data matches what we wanted before with Sinead's methods, so her QC prevails
q()
