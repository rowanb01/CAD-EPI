#The goal of this script is to pull out the requested additional points and edits to demographic data in terms of icd and phecode repulls

library(openxlsx)
library(data.table)
Encounter_Subset_Cohort_ids <- fread("Encounters_Main_Cohort_050225.csv") 
Lab_Subset_Cohort_ids <- fread("Labs_Main_Cohort_050225.csv")
Phecode_Subset_Cohort_ids <- fread("Phecode_Main_Cohort_050225.csv")
Main_Cohort <- fread("Main_Cohort_Adults_050225.csv")

Phecode_CAD_Pos <- Phecode_Subset_Cohort_ids[which(Phecode_Subset_Cohort_ids$CV_404.2 == 1),]
dim(Phecode_CAD_Pos)
#  7498
Premature_Phecode_CAD <- Phecode_CAD_Pos[which(Phecode_CAD_Pos$Age < 55),]
dim(Premature_Phecode_CAD)
# 209

#CAD Pulls ICD
Subset_CAD_A <- Encounter_Subset_Cohort_ids[which(Encounter_Subset_Cohort_ids$dx_code1 == "I25.0" | Encounter_Subset_Cohort_ids$dx_code1 == "I25.1" | Encounter_Subset_Cohort_ids$dx_code1 == "I25.10" | Encounter_Subset_Cohort_ids$dx_code1 == "I25.11" | Encounter_Subset_Cohort_ids$dx_code1 == "I25.118" | Encounter_Subset_Cohort_ids$dx_code1 == "I25.119" | Encounter_Subset_Cohort_ids$dx_code1 == "I25.81" | Encounter_Subset_Cohort_ids$dx_code1 == "I25.82" | Encounter_Subset_Cohort_ids$dx_code1 == "I25.83" | Encounter_Subset_Cohort_ids$dx_code1 == "I25.84" | Encounter_Subset_Cohort_ids$dx_code1 == "414.0" | Encounter_Subset_Cohort_ids$dx_code1 == "414.01" | Encounter_Subset_Cohort_ids$dx_code1 == "414.02" | Encounter_Subset_Cohort_ids$dx_code1 == "414.03" | Encounter_Subset_Cohort_ids$dx_code1 == "414.04"),]
dim(Subset_CAD_A)
# 150266    180
Primary_Dx_YN_Subset_CAD_A <- Subset_CAD_A[which(Subset_CAD_A$primary_dx_yn == "Y"),]
dim(Primary_Dx_YN_Subset_CAD_A)
# 43682   181
dim(Primary_Dx_YN_Subset_CAD_A[which(Primary_Dx_YN_Subset_CAD_A$dx_code1 == "I25.0"),])
#0 181
dim(Primary_Dx_YN_Subset_CAD_A[which(Primary_Dx_YN_Subset_CAD_A$dx_code1 == "I25.1"),])
#0 181
dim(Primary_Dx_YN_Subset_CAD_A[which(Primary_Dx_YN_Subset_CAD_A$dx_code1 == "I25.10"),])
#36,960 181
dim(Primary_Dx_YN_Subset_CAD_A[which(Primary_Dx_YN_Subset_CAD_A$dx_code1 == "I25.11"),])
#0 181
dim(Primary_Dx_YN_Subset_CAD_A[which(Primary_Dx_YN_Subset_CAD_A$dx_code1 == "I25.118"),])
#1,462 181
dim(Primary_Dx_YN_Subset_CAD_A[which(Primary_Dx_YN_Subset_CAD_A$dx_code1 == "I25.119"),])
#1,804 181
dim(Primary_Dx_YN_Subset_CAD_A[which(Primary_Dx_YN_Subset_CAD_A$dx_code1 == "I25.81"),])
#0 181
dim(Primary_Dx_YN_Subset_CAD_A[which(Primary_Dx_YN_Subset_CAD_A$dx_code1 == "I25.82"),])
#1 181
dim(Primary_Dx_YN_Subset_CAD_A[which(Primary_Dx_YN_Subset_CAD_A$dx_code1 == "I25.83"),])
#2,072 181
dim(Primary_Dx_YN_Subset_CAD_A[which(Primary_Dx_YN_Subset_CAD_A$dx_code1 == "I25.84"),])
#1,383 181
dim(Primary_Dx_YN_Subset_CAD_A[which(Primary_Dx_YN_Subset_CAD_A$dx_code1 == "414.0"),])
#0 181
dim(Primary_Dx_YN_Subset_CAD_A[which(Primary_Dx_YN_Subset_CAD_A$dx_code1 == "414.01"),])
#0 181
dim(Primary_Dx_YN_Subset_CAD_A[which(Primary_Dx_YN_Subset_CAD_A$dx_code1 == "414.02"),])
#0 181
dim(Primary_Dx_YN_Subset_CAD_A[which(Primary_Dx_YN_Subset_CAD_A$dx_code1 == "414.03"),])
#0 181
dim(Primary_Dx_YN_Subset_CAD_A[which(Primary_Dx_YN_Subset_CAD_A$dx_code1 == "414.04"),])
#0 181

#MI Pulls ICD
Subset_MI_A <- Encounter_Subset_Cohort_ids[which(Encounter_Subset_Cohort_ids$dx_code1 == "I21.0" | Encounter_Subset_Cohort_ids$dx_code1 == "I21.01" | Encounter_Subset_Cohort_ids$dx_code1 == "I21.02" | Encounter_Subset_Cohort_ids$dx_code1 == "I21.09" | Encounter_Subset_Cohort_ids$dx_code1 == "I21.11" | Encounter_Subset_Cohort_ids$dx_code1 == "I21.19" | Encounter_Subset_Cohort_ids$dx_code1 == "I21.21" | Encounter_Subset_Cohort_ids$dx_code1 == "I21.29" | Encounter_Subset_Cohort_ids$dx_code1 == "I21.3" | Encounter_Subset_Cohort_ids$dx_code1 == "I21.4" | Encounter_Subset_Cohort_ids$dx_code1 == "I21.9" | Encounter_Subset_Cohort_ids$dx_code1 == "I21.A1" | Encounter_Subset_Cohort_ids$dx_code1 == "I21.A9"),]
dim(Subset_MI_A)
#6,175 181
dim(Encounter_Subset_Cohort_ids[which(Encounter_Subset_Cohort_ids$dx_code1 == "I21.0"),])
# 86 181
dim(Encounter_Subset_Cohort_ids[which(Encounter_Subset_Cohort_ids$dx_code1 == "I21.01"),])
# 86 181
dim(Encounter_Subset_Cohort_ids[which(Encounter_Subset_Cohort_ids$dx_code1 == "I21.02"),])
# 216 181
dim(Encounter_Subset_Cohort_ids[which(Encounter_Subset_Cohort_ids$dx_code1 == "I21.09"),])
# 75 181
dim(Encounter_Subset_Cohort_ids[which(Encounter_Subset_Cohort_ids$dx_code1 == "I21.11"),])
# 181 181
dim(Encounter_Subset_Cohort_ids[which(Encounter_Subset_Cohort_ids$dx_code1 == "I21.19"),])
# 51 181
dim(Encounter_Subset_Cohort_ids[which(Encounter_Subset_Cohort_ids$dx_code1 == "I21.21"),])
# 43 181
dim(Encounter_Subset_Cohort_ids[which(Encounter_Subset_Cohort_ids$dx_code1 == "I21.29"),])
# 220 181
dim(Encounter_Subset_Cohort_ids[which(Encounter_Subset_Cohort_ids$dx_code1 == "I21.3"),])
# 508 181
dim(Encounter_Subset_Cohort_ids[which(Encounter_Subset_Cohort_ids$dx_code1 == "I21.4"),])
# 3,000 181
dim(Encounter_Subset_Cohort_ids[which(Encounter_Subset_Cohort_ids$dx_code1 == "I21.9"),])
# 1,747 181
dim(Encounter_Subset_Cohort_ids[which(Encounter_Subset_Cohort_ids$dx_code1 == "I21.A1"),])
# 31 181
dim(Encounter_Subset_Cohort_ids[which(Encounter_Subset_Cohort_ids$dx_code1 == "I21.A9"),])
# 17 181

#Hypertension Phecode
Hypertension_Phecode_Pull <- Phecode_Subset_Cohort_ids[which(Phecode_Subset_Cohort_ids$CV_401 == 1),]
dim(Hypertension_Phecode_Pull)
#23590  3385

#Hypertension pulls icd
Hypertension_icd_Pull <- Encounter_Subset_Cohort_ids[which(Encounter_Subset_Cohort_ids$dx_code1 == "I10" | Encounter_Subset_Cohort_ids$dx_code1 == "I11" | Encounter_Subset_Cohort_ids$dx_code1 == "I12" | Encounter_Subset_Cohort_ids$dx_code1 == "I13" | Encounter_Subset_Cohort_ids$dx_code1 == "I14" | Encounter_Subset_Cohort_ids$dx_code1 == "I15" | Encounter_Subset_Cohort_ids$dx_code1 == "I16" | Encounter_Subset_Cohort_ids$dx_code1 == "401.0" | Encounter_Subset_Cohort_ids$dx_code1 == "401.1" | Encounter_Subset_Cohort_ids$dx_code1 == "401.9"),]
dim(Hypertension_icd_Pull)
# 698782    181
Primary_Dx_Hypertension_icd_Pull <- Hypertension_icd_Pull[which(Hypertension_icd_Pull$primary_dx_yn == "Y"),]
dim(Primary_Dx_Hypertension_icd_Pull)
# 192550    181
length(unique(Primary_Dx_Hypertension_icd_Pull$subject_id))
# 17346
I10 <- Encounter_Subset_Cohort_ids[which(Encounter_Subset_Cohort_ids$dx_code1 == "I10"),]
I10 <- I10[which(I10$primary_dx_yn == "Y"),]
length(unique(I10$subject_id))
# 17,271
I11 <- Encounter_Subset_Cohort_ids[which(Encounter_Subset_Cohort_ids$dx_code1 == "I11"),]
I11 <- I11[which(I11$primary_dx_yn == "Y"),]
length(unique(I11$subject_id))
# 0
I12 <- Encounter_Subset_Cohort_ids[which(Encounter_Subset_Cohort_ids$dx_code1 == "I12"),]
I12 <- I12[which(I12$primary_dx_yn == "Y"),]
length(unique(I12$subject_id))
# 0
I13 <- Encounter_Subset_Cohort_ids[which(Encounter_Subset_Cohort_ids$dx_code1 == "I13"),]
I13 <- I13[which(I13$primary_dx_yn == "Y"),]
length(unique(I13$subject_id))
# 0
I14 <- Encounter_Subset_Cohort_ids[which(Encounter_Subset_Cohort_ids$dx_code1 == "I14"),]
I14 <- I14[which(I14$primary_dx_yn == "Y"),]
length(unique(I14$subject_id))
# 0
I15 <- Encounter_Subset_Cohort_ids[which(Encounter_Subset_Cohort_ids$dx_code1 == "I15"),]
I15 <- I15[which(I15$primary_dx_yn == "Y"),]
length(unique(I15$subject_id))
# 0
I16 <- Encounter_Subset_Cohort_ids[which(Encounter_Subset_Cohort_ids$dx_code1 == "I16"),]
I16 <- I16[which(I16$primary_dx_yn == "Y"),]
length(unique(I16$subject_id))
# 0
ID_401.0 <- Encounter_Subset_Cohort_ids[which(Encounter_Subset_Cohort_ids$dx_code1 == "401.0"),]
ID_401.0 <- ID_401.0[which(ID_401.0$primary_dx_yn == "Y"),]
length(unique(ID_401.0$subject_id))
# 0
ID_401.1 <- Encounter_Subset_Cohort_ids[which(Encounter_Subset_Cohort_ids$dx_code1 == "401.1"),]
ID_401.1 <- ID_401.1[which(I10$primary_dx_yn == "Y"),]
length(unique(ID_401.1$subject_id))
# 1
ID_401.9 <- Encounter_Subset_Cohort_ids[which(Encounter_Subset_Cohort_ids$dx_code1 == "401.9"),]
ID_401.9 <- ID_401.9[which(I10$primary_dx_yn == "Y"),]
length(unique(ID_401.9$subject_id))
# 1,268

#Proportions based on these numbers

#Discuss about CAD ICD10 I25.10 prior to computing proportion for this variable in particular
dim(Phecode_CAD_Pos)/dim(Phecode_Subset_Cohort_ids)
#0.1483812

dim(Phecode_Subset_Cohort_ids)
#50,532

dim(Hypertension_Phecode_Pull)/dim(Phecode_Subset_Cohort_ids)
#0.4668329

length(unique(Primary_Dx_Hypertension_icd_Pull$subject_id))/length(unique(Encounter_Subset_Cohort_ids$subject_id))
#0.3520958

#Save spreadsheets and link them to the file of interest about what the phecodes encompass (trying to put that sheet in a google slides would be too taxing on time since it is pages worth of ICD codes used for those)
Main_Phecode_Table <- fread("Phecode_mapX_filtered.csv")
dim(Main_Phecode_Table)
# 79597     7
colnames(Main_Phecode_Table)
CAD_Main_Phecode_Table <- Main_Phecode_Table[which(Main_Phecode_Table$phecode == "CV_404.2"),]
MI_Main_Phecode_Table <- Main_Phecode_Table[which(Main_Phecode_Table$phecode == "CV_404.1"),]
Hypertension_Main_Phecode_Table <- Main_Phecode_Table[which(Main_Phecode_Table$phecode == "CV_401"),]
Spreadsheet_Phecode_Full <- list("CAD" = CAD_Main_Phecode_Table, "MI" = MI_Main_Phecode_Table, "Hypertension" = Hypertension_Main_Phecode_Table)
write.xlsx(Spreadsheet_Phecode_Full, "Phecode_Subset_Dataset_Hypertension_CAD_MI_050525.xlsx")
q()

