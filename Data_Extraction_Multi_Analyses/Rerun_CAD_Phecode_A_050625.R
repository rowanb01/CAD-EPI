#A quick rerun of the phecode for today. Will need to check numbers with Christa, since it appears that something is different between methods used
library(openxlsx)
library(data.table)
Encounter_Subset_Cohort_ids <- fread("Encounters_Main_Cohort_050225.csv") 
Lab_Subset_Cohort_ids <- fread("Labs_Main_Cohort_050225.csv")
Phecode_Subset_Cohort_ids <- fread("Phecode_Main_Cohort_050225.csv")
Main_Cohort <- fread("Main_Cohort_Adults_050225.csv")

Phecode_CAD_Pos <- Phecode_Subset_Cohort_ids[which(Phecode_Subset_Cohort_ids$CV_404 == 1),]
dim(Phecode_CAD_Pos)
# 7919 3385 
Premature_Phecode_CAD <- Phecode_CAD_Pos[which(Phecode_CAD_Pos$Age < 55),]
dim(Premature_Phecode_CAD)
# 242 3385
q()
