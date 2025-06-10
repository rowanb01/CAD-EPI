#Script shows how the unique main chort was created at the moment (will go through id checks eventually)
library(data.table)
Main_Cohort <- fread("Main_Cohort_Adults_Unique_IDs_051625.csv")
New_Labels_A <- fread("/sc/private/regen/IPM-general/Kenny_Lab/MSM_QC_v2/ethnicity_labels/MSM_Questionaire_Ethnicity_info.Collapsed.txt")
dim(New_Labels_A)
# 62024     4
dim(Main_Cohort[match(intersect(New_Labels_A$subject_id, Main_Cohort$subject_id.y), Main_Cohort$subject_id.y),])
# 49859   172
V2_Main_Cohort <- Main_Cohort[match(intersect(New_Labels_A$subject_id, Main_Cohort$subject_id.y), Main_Cohort$subject_id.y),]
dim(V2_Main_Cohort)
# 49859   172
New_Labels_B <- New_Labels_A[match(intersect(V2_Main_Cohort$subject_id.y, New_Labels_A$subject_id), New_Labels_A$subject_id),]
dim(New_Labels_B)
# 49859     4
head(New_Labels_B$subject_id, 5)
head(V2_Main_Cohort$subject_id.y, 5)
V2_Main_Cohort$new_eth_designation <- New_Labels_B$new_eth_designation
summary(as.factor(V2_Main_Cohort$new_eth_designation))
#African-American/African    East/South-East_Asian        European_American
#                   10110                     1819                    15198
# Hispanic_Latin_American                   Jewish        Multiple_Selected
#                   17577                       30                      712
#         Native_American                    Other              South_Asian
#                      92                     3022                     1299
fwrite(V2_Main_Cohort, "Main_Cohort_Adults_Race_Ethnicity_Update_060625.csv")
q()

