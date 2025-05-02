#See Extracting_Demographics_BioMe_043025.R for initial pulls and counts
#This script follows suit for the newest pulls

library(data.table)
#Read in key files
Encounter_Subset_Cohort_ids <- fread("Encounters_Main_Cohort_050225.csv") 
Lab_Subset_Cohort_ids <- fread("Labs_Main_Cohort_050225.csv")
Phecode_Subset_Cohort_ids <- fread("Phecode_Main_Cohort_050225.csv")
Main_Cohort <- fread("Main_Cohort_Adults_050225.csv")

#Extract Main Cohort Age
mean(Main_Cohort$Age)
# 62.11354
sd(Main_Cohort$Age)
# 17.24474
median(Main_Cohort$Age)
# 64
IQR(Main_Cohort$Age)
# 28
range(Main_Cohort$Age)
# 18 92

#CAD+ Extract ICD
Subset_CAD_A <- Encounter_Subset_Cohort_ids[which(Encounter_Subset_Cohort_ids$dx_code1 == "I25.0" | Encounter_Subset_Cohort_ids$dx_code1 == "I25.1" | Encounter_Subset_Cohort_ids$dx_code1 == "I25.10" | Encounter_Subset_Cohort_ids$dx_code1 == "I25.11" | Encounter_Subset_Cohort_ids$dx_code1 == "I25.118" | Encounter_Subset_Cohort_ids$dx_code1 == "I25.119" | Encounter_Subset_Cohort_ids$dx_code1 == "I25.81" | Encounter_Subset_Cohort_ids$dx_code1 == "I25.82" | Encounter_Subset_Cohort_ids$dx_code1 == "I25.83" | Encounter_Subset_Cohort_ids$dx_code1 == "I25.84" | Encounter_Subset_Cohort_ids$dx_code1 == "414.0" | Encounter_Subset_Cohort_ids$dx_code1 == "414.01" | Encounter_Subset_Cohort_ids$dx_code1 == "414.02" | Encounter_Subset_Cohort_ids$dx_code1 == "414.03" | Encounter_Subset_Cohort_ids$dx_code1 == "414.04"),]
dim(Subset_CAD_A)
# 150266    180
Primary_Dx_YN_Subset_CAD_A <- Subset_CAD_A[which(Subset_CAD_A$primary_dx_yn == "Y"),]
dim(Primary_Dx_YN_Subset_CAD_A)
# 43682   180
summary(as.factor(Primary_Dx_YN_Subset_CAD_A$GENDER))
# Female   Male 
# 19726  23956
mean(Primary_Dx_YN_Subset_CAD_A$Age)
# 76.86949
sd(Primary_Dx_YN_Subset_CAD_A$Age)
# 9.761093
median(Primary_Dx_YN_Subset_CAD_A$Age)
# 77
IQR(Primary_Dx_YN_Subset_CAD_A$Age)
# 14
Primary_Dx_YN_Subset_CAD_A$Primary_Dx_Year <- format(as.Date(Primary_Dx_YN_Subset_CAD_A$encounter_date, format="%m/%d/%Y"), "%Y")
range(Primary_Dx_YN_Subset_CAD_A$Primary_Dx_Year)
# "2006" "2024"
Primary_Dx_YN_Subset_CAD_A$Primary_Dx_Year <- as.numeric(Primary_Dx_YN_Subset_CAD_A$Primary_Dx_Year)
Primary_Dx_YN_Subset_CAD_A$CAD_Dx_Age <- Primary_Dx_YN_Subset_CAD_A$Primary_Dx_Year - Primary_Dx_YN_Subset_CAD_A$YEAR_OF_BIRTH
range(Primary_Dx_YN_Subset_CAD_A$CAD_Dx_Age)
# 22 90
mean(Primary_Dx_YN_Subset_CAD_A$CAD_Dx_Age)
# 68.66725
sd(Primary_Dx_YN_Subset_CAD_A$CAD_Dx_Age)
# 9.662263
median(Primary_Dx_YN_Subset_CAD_A$CAD_Dx_Age)
# 69
IQR(Primary_Dx_YN_Subset_CAD_A$CAD_Dx_Age)
# 14
Premature_CAD_A <- Primary_Dx_YN_Subset_CAD_A[which(Primary_Dx_YN_Subset_CAD_A$Age < 55),]
dim(Premature_CAD_A)
# 749 183

#MI+ Extract ICD
Subset_MI_A <- Encounter_Subset_Cohort_ids[which(Encounter_Subset_Cohort_ids$dx_code1 == "I21.0" | Encounter_Subset_Cohort_ids$dx_code1 == "I21.01" | Encounter_Subset_Cohort_ids$dx_code1 == "I21.02" | Encounter_Subset_Cohort_ids$dx_code1 == "I21.09" | Encounter_Subset_Cohort_ids$dx_code1 == "I21.11" | Encounter_Subset_Cohort_ids$dx_code1 == "I21.19" | Encounter_Subset_Cohort_ids$dx_code1 == "I21.21" | Encounter_Subset_Cohort_ids$dx_code1 == "I21.29" | Encounter_Subset_Cohort_ids$dx_code1 == "I21.3" | Encounter_Subset_Cohort_ids$dx_code1 == "I21.4" | Encounter_Subset_Cohort_ids$dx_code1 == "I21.9" | Encounter_Subset_Cohort_ids$dx_code1 == "I21.A1" | Encounter_Subset_Cohort_ids$dx_code1 == "I21.A9"),]
dim(Subset_MI_A)
# 6175  180
Primary_Dx_YN_Subset_MI_A <- Subset_MI_A[which(Subset_MI_A$primary_dx_yn == "Y"),]
dim(Primary_Dx_YN_Subset_MI_A)
# 1454  180
summary(as.factor(Primary_Dx_YN_Subset_MI_A$GENDER))
# Female   Male 
#   810    644 
mean(Primary_Dx_YN_Subset_MI_A$Age)
# 72.19532
sd(Primary_Dx_YN_Subset_MI_A$Age)
# 11.93434 
median(Primary_Dx_YN_Subset_MI_A$Age)
# 72
IQR(Primary_Dx_YN_Subset_MI_A$Age)
# 18
Primary_Dx_YN_Subset_MI_A$Primary_Dx_Year <- format(as.Date(Primary_Dx_YN_Subset_MI_A$encounter_date, format="%m/%d/%Y"), "%Y")
range(Primary_Dx_YN_Subset_MI_A$Primary_Dx_Year)
# "2007" "2024"
Primary_Dx_YN_Subset_MI_A$Primary_Dx_Year <- as.numeric(Primary_Dx_YN_Subset_MI_A$Primary_Dx_Year)
Primary_Dx_YN_Subset_MI_A$MI_Dx_Age <- Primary_Dx_YN_Subset_MI_A$Primary_Dx_Year - Primary_Dx_YN_Subset_MI_A$YEAR_OF_BIRTH
range(Primary_Dx_YN_Subset_MI_A$MI_Dx_Age)
# 22 89
mean(Primary_Dx_YN_Subset_MI_A$MI_Dx_Age)
# 65.24347
sd(Primary_Dx_YN_Subset_MI_A$MI_Dx_Age)
# 12.21238
median(Primary_Dx_YN_Subset_MI_A$MI_Dx_Age)
# 66
IQR(Primary_Dx_YN_Subset_MI_A$MI_Dx_Age)
# 19
Premature_MI <- Primary_Dx_YN_Subset_MI_A[which(Primary_Dx_YN_Subset_MI_A$Age < 55),]
dim(Premature_MI)
# 122 183

#Phecode CAD+
Phecode_CAD_Pos <- Phecode_Subset_Cohort_ids[which(Phecode_Subset_Cohort_ids$CV_403.1 == 1),]
dim(Phecode_CAD_Pos)
# 220 3385
Premature_Phecode_CAD <- Phecode_CAD_Pos[which(Phecode_CAD_Pos$Age < 55),]
dim(Premature_Phecode_CAD)
# 8 3385

#Phecode MI+
Phecode_MI_Pos <- Phecode_Subset_Cohort_ids[which(Phecode_Subset_Cohort_ids$CV_404.1 == 1),]
dim(Phecode_MI_Pos)
# 1520 3385
Premature_Phecode_MI <- Phecode_MI_Pos[which(Phecode_MI_Pos$Age < 55),]
dim(Premature_Phecode_MI)
# 65 3385

#LDL-C Extracts
Test_Lab_Subset <- Lab_Subset_Cohort_ids[which(Lab_Subset_Cohort_ids$CHOLESTEROL_IN_LDL_indiv_median > 0),]
dim(Test_Lab_Subset)
# 37157  1081
range(Test_Lab_Subset$CHOLESTEROL_IN_LDL_indiv_median)
# 3 250
mean(Test_Lab_Subset$CHOLESTEROL_IN_LDL_indiv_median)
# 101.6712
median(Test_Lab_Subset$CHOLESTEROL_IN_LDL_indiv_median)
# 100
png("Median_LDL-C_Hisotgram_050225.png")
hist(Test_Lab_Subset$CHOLESTEROL_IN_LDL_indiv_median)
dev.off()
range(Test_Lab_Subset$Age)
# 22 92
mean(Test_Lab_Subset$Age)
# 63.04882
sd(Test_Lab_Subset$Age)
# 16.26188
median(Test_Lab_Subset$Age)
# 64
IQR(Test_Lab_Subset$Age)
# 26
range(Test_Lab_Subset$CHOLESTEROL_IN_LDL_median_age)
# 9.245722 100.813142
mean(Test_Lab_Subset$CHOLESTEROL_IN_LDL_median_age)
# 53.35616
sd(Test_Lab_Subset$CHOLESTEROL_IN_LDL_median_age)
# 16.29017
median(Test_Lab_Subset$CHOLESTEROL_IN_LDL_median_age)
# 54.28337
IQR(Test_Lab_Subset$CHOLESTEROL_IN_LDL_median_age)
# 24.93087
summary(as.factor(Test_Lab_Subset$GENDER))
# Female    Male Unknown 
#  22025   15128       4 

q()

