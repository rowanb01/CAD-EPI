#Goal is to create the new Main Cohort based on the Sinead methodology
library(data.table)
#Sinead race ethnicty sample size check
Autsome_Sinead <- fread("Autosome_Sinead_Race_Ethnicity_Binary_CAD_for_FlashPCA_Stage1_062925.fam")
dim(Autsome_Sinead)
# 47324     6
Sinead_Race_Ethnicity_Labeled_Main_Cohort <- fread("Main_Cohort_Adults_Race_Ethnicity_Update_060625.csv")
Sinead_Race_Ethnicity_Labeled_Main_Cohort$NewID <- paste(Sinead_Race_Ethnicity_Labeled_Main_Cohort$ID_1, Sinead_Race_Ethnicity_Labeled_Main_Cohort$ID_1, sep="_")
Sinead_Update_QC <- Sinead_Race_Ethnicity_Labeled_Main_Cohort[match(intersect(Autsome_Sinead$V2, Sinead_Race_Ethnicity_Labeled_Main_Cohort$NewID), Sinead_Race_Ethnicity_Labeled_Main_Cohort$NewID),]
dim(Sinead_Update_QC)
# 47324   174
summary(as.factor(Sinead_Update_QC$new_eth_designation))
#African-American/African    East/South-East_Asian        European_American
#                    9488                     1796                    14972
# Hispanic_Latin_American                   Jewish        Multiple_Selected
#                   15962                       30                      707
#         Native_American                    Other              South_Asian
#                      92                     3002                     1275
fwrite(Sinead_Update_QC, "Updated_Sinead_Travis_QC_equivalent_Main_Cohort")
q()
