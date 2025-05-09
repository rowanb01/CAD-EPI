#Redoing pulls with the minimum age as well as unique for ICD and other variable pulls

library(openxlsx)
library(data.table)
Encounter_Subset_Cohort_ids <- fread("Encounters_Main_Cohort_maskedmrn_subjectid_dxcode1_Age_ageatdiagnosis_050825.csv")
Original_Encounters <- fread("Encounters_Main_Cohort_050225.csv")
Lab_Subset_Cohort_ids <- fread("Labs_Main_Cohort_050225.csv")
Phecode_Subset_Cohort_ids <- fread("Phecode_Main_Cohort_050225.csv")
Main_Cohort <- fread("Main_Cohort_Adults_050225.csv")

#Phecode CAD+
Phecode_CAD_Pos <- Phecode_Subset_Cohort_ids[which(Phecode_Subset_Cohort_ids$CV_404 == 1),]
dim(Phecode_CAD_Pos)
# 7919 3385
Premature_Phecode_CAD <- Phecode_CAD_Pos[which(Phecode_CAD_Pos$Age < 55),]
dim(Premature_Phecode_CAD)
# 242 3385

#CAD+ Extract ICD
Subset_CAD_A <- Encounter_Subset_Cohort_ids[which(Encounter_Subset_Cohort_ids$dx_code1 == "I25.0" | Encounter_Subset_Cohort_ids$dx_code1 == "I25.1" | Encounter_Subset_Cohort_ids$dx_code1 == "I25.10" | Encounter_Subset_Cohort_ids$dx_code1 == "I25.11" | Encounter_Subset_Cohort_ids$dx_code1 == "I25.118" | Encounter_Subset_Cohort_ids$dx_code1 == "I25.119" | Encounter_Subset_Cohort_ids$dx_code1 == "I25.81" | Encounter_Subset_Cohort_ids$dx_code1 == "I25.82" | Encounter_Subset_Cohort_ids$dx_code1 == "I25.83" | Encounter_Subset_Cohort_ids$dx_code1 == "I25.84" | Encounter_Subset_Cohort_ids$dx_code1 == "414.0" | Encounter_Subset_Cohort_ids$dx_code1 == "414.01" | Encounter_Subset_Cohort_ids$dx_code1 == "414.02" | Encounter_Subset_Cohort_ids$dx_code1 == "414.03" | Encounter_Subset_Cohort_ids$dx_code1 == "414.04"),]
dim(Subset_CAD_A)
# 11,130    180
length(unique(Subset_CAD_A))
# 7,356
I25.0 <- Subset_CAD_A[which(Subset_CAD_A$dx_code1 == "I25.0"),]
#0 181
length(unique(I25.0$subject_id))
# 0 
I25.1 <- Subset_CAD_A[which(Subset_CAD_A$dx_code1 == "I25.1"),]
#0 181
length(unique(I25.1$subject_id))
# 0
I25.10 <- Subset_CAD_A[which(Subset_CAD_A$dx_code1 == "I25.10"),]
#36,960 181
length(unique(I25.10$subject_id))
# 7,137
I25.11 <- Subset_CAD_A[which(Subset_CAD_A$dx_code1 == "I25.11"),]
#0 181
length(unique(I25.11$subject_id))
# 0
I25.118 <- Subset_CAD_A[which(Subset_CAD_A$dx_code1 == "I25.118"),]
#1,462 181
length(unique(I25.118$subject_id))
# 870
I25.119 <- Subset_CAD_A[which(Subset_CAD_A$dx_code1 == "I25.119"),]
#1,804 181
length(unique(I25.119$subject_id))
# 1,109
I25.81 <- Subset_CAD_A[which(Subset_CAD_A$dx_code1 == "I25.81"),]
#0 181
length(unique(I25.81$subject_id))
# 0
I25.82 <- Subset_CAD_A[which(Subset_CAD_A$dx_code1 == "I25.82"),]
#1 181
length(unique(I25.82$subject_id))
# 5
I25.83 <- Subset_CAD_A[which(Subset_CAD_A$dx_code1 == "I25.83"),]
#2,072 181
length(unique(I25.83$subject_id))
# 1,152
I25.84 <- Subset_CAD_A[which(Subset_CAD_A$dx_code1 == "I25.84"),]
#1,383 181
length(unique(I25.84$subject_id))
# 857
ICD9_414.0 <- Subset_CAD_A[which(Subset_CAD_A$dx_code1 == "414.0"),]
#0 181
length(unique(ICD9_414.0$subject_id))
# 0
ICD9_414.01 <- Subset_CAD_A[which(Subset_CAD_A$dx_code1 == "414.01"),]
#0 181
length(unique(ICD9_414.01$subject_id))
# 0
ICD9_414.02 <- Subset_CAD_A[which(Subset_CAD_A$dx_code1 == "414.02"),]
#0 181
length(unique(ICD9_414.02$subject_id))
# 0
ICD9_414.03 <- Subset_CAD_A[which(Subset_CAD_A$dx_code1 == "414.03"),]
#0 181
length(unique(ICD9_414.03$subject_id))
# 0
ICD9_414.04 <- Subset_CAD_A[which(Subset_CAD_A$dx_code1 == "414.04"),]
#0 181
length(unique(ICD9_414.04$subject_id))
# 0
Subset_CAD_B <- Subset_CAD_A[match(intersect(unique(Subset_CAD_A$subject_id), Subset_CAD_A$subject_id), Subset_CAD_A$subject_id),]
dim(Subset_CAD_B)
# 7,356    5

Original_Subset_CAD_A <- Original_Encounters[which(Original_Encounters$dx_code1 == "I25.0" | Original_Encounters$dx_code1 == "I25.1" | Original_Encounters$dx_code1 == "I25.10" | Original_Encounters$dx_code1 == "I25.11" | Original_Encounters$dx_code1 == "I25.118" | Original_Encounters$dx_code1 == "I25.119" | Original_Encounters$dx_code1 == "I25.81" | Original_Encounters$dx_code1 == "I25.82" | Original_Encounters$dx_code1 == "I25.83" | Original_Encounters$dx_code1 == "I25.84" | Original_Encounters$dx_code1 == "414.0" | Original_Encounters$dx_code1 == "414.01" | Original_Encounters$dx_code1 == "414.02" | Original_Encounters$dx_code1 == "414.03" | Original_Encounters$dx_code1 == "414.04"),]
dim(Original_Subset_CAD_A)
# 150,266 181
length(unique(Original_Subset_CAD_A$subject_id))
# 7,356
Original_Subset_CAD_B <- Original_Subset_CAD_A[match(intersect(unique(Original_Subset_CAD_A$subject_id), Original_Subset_CAD_A$subject_id), Original_Subset_CAD_A$subject_id),]
dim(Original_Subset_CAD_B)
# 7,356  181
summary(as.factor(Original_Subset_CAD_B$GENDER))
# Female   Male Unknown
# 3,414  3,941  1
mean(Subset_CAD_B$Age)
# 76.86949
sd(Subset_CAD_B$Age)
# 9.761093
median(Subset_CAD_B$Age)
# 77
IQR(Subset_CAD_B$Age)
# 14
range(Subset_CAD_B$age_at_diagnosis)
# 22 90
mean(Subset_CAD_B$age_at_diagnosis)
# 68.66725
sd(Subset_CAD_B$age_at_diagnosis)
# 9.662263
median(Subset_CAD_B$age_at_diagnosis)
# 69
IQR(Subset_CAD_B$age_at_diagnosis)
# 14
Premature_CAD_A <- Subset_CAD_A[which(Subset_CAD_A$Age < 55),]
dim(Premature_CAD_A)
# 334 5
length(unique(Premature_CAD_A$subject_id))
# 240

#MI+ Extract ICD
Subset_MI_A <- Encounter_Subset_Cohort_ids[which(Encounter_Subset_Cohort_ids$dx_code1 == "I21.0" | Encounter_Subset_Cohort_ids$dx_code1 == "I21.01" | Encounter_Subset_Cohort_ids$dx_code1 == "I21.02" | Encounter_Subset_Cohort_ids$dx_code1 == "I21.09" | Encounter_Subset_Cohort_ids$dx_code1 == "I21.11" | Encounter_Subset_Cohort_ids$dx_code1 == "I21.19" | Encounter_Subset_Cohort_ids$dx_code1 == "I21.21" | Encounter_Subset_Cohort_ids$dx_code1 == "I21.29" | Encounter_Subset_Cohort_ids$dx_code1 == "I21.3" | Encounter_Subset_Cohort_ids$dx_code1 == "I21.4" | Encounter_Subset_Cohort_ids$dx_code1 == "I21.9" | Encounter_Subset_Cohort_ids$dx_code1 == "I21.A1" | Encounter_Subset_Cohort_ids$dx_code1 == "I21.A9"),]
dim(Subset_MI_A)
# 1,348  180
length(unique(Subset_MI_A$subject_id))
# 1,126
I21.0 <- Encounter_Subset_Cohort_ids[which(Encounter_Subset_Cohort_ids$dx_code1 == "I21.0"),]
length(unique(I21.0$subject_id))
# 86 181
I21.01 <- Encounter_Subset_Cohort_ids[which(Encounter_Subset_Cohort_ids$dx_code1 == "I21.01"),]
length(unique(I21.01$subject_id))
# 86 181
I21.02 <- Encounter_Subset_Cohort_ids[which(Encounter_Subset_Cohort_ids$dx_code1 == "I21.02"),]
length(unique(I21.02$subject_id))
# 216 181
I21.09 <- Encounter_Subset_Cohort_ids[which(Encounter_Subset_Cohort_ids$dx_code1 == "I21.09"),]
length(unique(I21.09$subject_id))
# 75 181
I21.11 <- Encounter_Subset_Cohort_ids[which(Encounter_Subset_Cohort_ids$dx_code1 == "I21.11"),]
length(unique(I21.11$subject_id))
# 181 181
I21.19 <- Encounter_Subset_Cohort_ids[which(Encounter_Subset_Cohort_ids$dx_code1 == "I21.19"),]
length(unique(I21.19$subject_id))
# 51 181
I21.21 <- Encounter_Subset_Cohort_ids[which(Encounter_Subset_Cohort_ids$dx_code1 == "I21.21"),]
length(unique(I21.21$subject_id))
# 43 181
I21.29 <- Encounter_Subset_Cohort_ids[which(Encounter_Subset_Cohort_ids$dx_code1 == "I21.29"),]
length(unique(I21.29$subject_id))
# 220 181
I21.3 <- Encounter_Subset_Cohort_ids[which(Encounter_Subset_Cohort_ids$dx_code1 == "I21.3"),]
length(unique(I21.3$subject_id))
# 508 181
I21.4 <- Encounter_Subset_Cohort_ids[which(Encounter_Subset_Cohort_ids$dx_code1 == "I21.4"),]
length(unique(I21.4$subject_id))
# 3,000 181
I21.9 <- Encounter_Subset_Cohort_ids[which(Encounter_Subset_Cohort_ids$dx_code1 == "I21.9"),]
length(unique(I21.9$subject_id))
# 1,747 181
I21.A1 <- Encounter_Subset_Cohort_ids[which(Encounter_Subset_Cohort_ids$dx_code1 == "I21.A1"),]
length(unique(I21.A1$subject_id))
# 31 181
I21.A9 <- Encounter_Subset_Cohort_ids[which(Encounter_Subset_Cohort_ids$dx_code1 == "I21.A9"),]
length(unique(I21.A9$subject_id))
# 17 181
Subset_MI_B <- Subset_MI_A[match(intersect(unique(Subset_MI_A$subject_id), Subset_MI_A$subject_id), Subset_MI_A$subject_id),]
dim(Subset_MI_B$subject_id)
# 1,126    5

Original_Subset_MI_A <- Original_Encounters[which(Original_Encounters$dx_code1 == "I21.0" | Original_Encounters$dx_code1 == "I21.01" | Original_Encounters$dx_code1 == "I21.02" | Original_Encounters$dx_code1 == "I21.09" | Original_Encounters$dx_code1 == "I21.11" | Original_Encounters$dx_code1 == "I21.19" | Original_Encounters$dx_code1 == "I21.21" | Original_Encounters$dx_code1 == "I21.29" | Original_Encounters$dx_code1 == "I21.3" | Original_Encounters$dx_code1 == "I21.4" | Original_Encounters$dx_code1 == "I21.9" | Original_Encounters$dx_code1 == "I21.A1" | Original_Encounters$dx_code1 == "I21.A9"),]
dim(Original_Subset_MI_A)
# 6,175  181
length(unique(Original_Subset_MI_A$subject_id))
# 1,126
Original_Subset_MI_B <- Original_Subset_MI_A[match(intersect(unique(Original_Subset_MI_A$subject_id), Original_Subset_MI_A$subject_id), Original_Subset_MI_A$subject_id),]
dim(Original_Subset_MI_B)
# 1,126  181
#Matches the size that is the same size as the MI_A subset 
summary(as.factor(Original_Subset_MI_B$GENDER))
# Female   Male
#   570    556
mean(Subset_MI_B$Age)
# 74.53375
sd(Subset_MI_B$Age)
# 12.15186
median(Subset_MI_B$Age)
# 75
IQR(Subset_MI_B$Age)
# 18
range(Subset_MI_B$age_at_diagnosis)
# 19 89
mean(Subset_MI_B$age_at_diagnosis)
# 65.91208
sd(Subset_MI_B$age_at_diagnosis)
# 12.27204
median(Subset_MI_B$age_at_diagnosis)
# 67
IQR(Subset_MI_B$age_at_diagnosis)
# 18
Premature_MI <- Subset_MI_A[which(Subset_MI_A$Age < 55),]
dim(Premature_MI)
# 95 5
length(unique(Premature_MI$subject_id))
#68

#Phecode MI+
Phecode_MI_Pos <- Phecode_Subset_Cohort_ids[which(Phecode_Subset_Cohort_ids$CV_404.1 == 1),]
dim(Phecode_MI_Pos)
# 1520 3385
Premature_Phecode_MI <- Phecode_MI_Pos[which(Phecode_MI_Pos$Age < 55),]
dim(Premature_Phecode_MI)
# 65 3385
q()
