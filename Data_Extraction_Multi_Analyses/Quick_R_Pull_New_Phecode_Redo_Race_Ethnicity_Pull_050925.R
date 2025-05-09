#The goal is to generate the new pull of phecodes and the race/ethnicity table based on the most updated data from Sinead
library(data.table)
library(openxlsx)
Full_phecode_set <- fread("phecodeX_ICD_CM_map_flat.csv")
dim(Full_phecode_set)
# 79597     7
colnames(Full_phecode_set)
CAD_Redo <- Full_phecode_set[which(Full_phecode_set$phecode == "CV_404"),]
dim(CAD_Redo)
#  16  7
head(CAD_Redo, 5)
write.xlsx(CAD_Redo, "Ischemic_Heart_Disease_Pull_050925.xlsx")
#Race/Ethnicity update (thanks Sinead for sending me the updated file location today)
New_Labels_A <- fread("/sc/private/regen/IPM-general/Kenny_Lab/MSM_QC_v2/ethnicity_labels/MSM_Questionaire_Ethnicity_info.Collapsed.txt")
dim(New_Labels_A)
# 62024     4
Main_Cohort <- fread("Main_Cohort_Adults_050225.csv")
colnames(New_Labels_A)
dim(Main_Cohort[match(intersect(New_Labels_A$subject_id, Main_Cohort$subject_id.y), Main_Cohort$subject_id.y),])
# 49859   172
 Race_Ethnic_Genetic_Questionnaire_Match_up <- merge(New_Labels_A, Main_Cohort, by.x = "subject_id", by.y= "subject_id.y")
dim(Race_Ethnic_Genetic_Questionnaire_Match_up)
# 51393   175
length(unique(Race_Ethnic_Genetic_Questionnaire_Match_up$sample_name))
# 49884
V2_Race_Ethnic_Genetic_Questionnaire_Match_up <- Race_Ethnic_Genetic_Questionnaire_Match_up[match(intersect(unique(Race_Ethnic_Genetic_Questionnaire_Match_up$sample_name), Race_Ethnic_Genetic_Questionnaire_Match_up$sample_name), Race_Ethnic_Genetic_Questionnaire_Match_up$sample_name),]
dim(V2_Race_Ethnic_Genetic_Questionnaire_Match_up)
# 49884   175
#Next is to subset these by race/ethnicity new designation
summary(as.factor(V2_Race_Ethnic_Genetic_Questionnaire_Match_up$new_eth_designation))
#African-American/African    East/South-East_Asian        European_American
#                   10113                     1820                    15204
# Hispanic_Latin_American                   Jewish        Multiple_Selected
#                   17591                       30                      713
#         Native_American                    Other              South_Asian
#                      92                     3022                     1299 
q()
