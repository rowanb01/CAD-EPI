#Repulling now to add percentages and update phecode files and main cohort to unique ids 
library(openxlsx)
library(data.table)
Encounter_Subset_Cohort_ids <- fread("Encounters_Main_Cohort_maskedmrn_subjectid_dxcode1_Age_ageatdiagnosis_050825.csv")
Original_Encounters <- fread("Encounters_Main_Cohort_050225.csv")
Lab_Subset_Cohort_ids <- fread("Labs_Main_Cohort_050225.csv")
Phecode_Subset_Cohort_ids <- fread("Phecode_Main_Cohort_050225.csv")
Main_Cohort <- fread("Main_Cohort_Adults_050225.csv")
length(unique(Main_Cohort))
# 172
length(unique(Main_Cohort$masked_mrn))
# 50161
summary(as.factor(Main_Cohort$GENDER))
# Female    Male Unknown 
#  30252   21375       9 
dim(Main_Cohort)
# 51636   172
Revamped_Cohort <- Main_Cohort[match(intersect(unique(Main_Cohort$masked_mrn), Main_Cohort$masked_mrn), Main_Cohort$masked_mrn),]
dim(Revamped_Cohort)
# 50161   172
summary(as.factor(Revamped_Cohort$GENDER))
# Female    Male Unknown 
#  29310   20842       9 
29310/50161
# 0.5843185
20842/50161
# 0.4155021
9/50161
# 0.0001794223
3414/29310
# 0.116479
570/29310
# 0.01944729
22025/29310
# 0.75145
3941/20842
# 0.1890893
556/20842
# 0.0266769
15128/20842
# 0.725842
10113+1820+15204+17591+30+713+92+3022+1299
# 49884
#Adds up properly for race check in terms of sum of results
10113/49884
# 0.2027303
1820/49884
# 0.03648464
15204/49884
# 0.3047871
17591/49884
# 0.3526381
30/49884
# 0.0006013952
713/49884
# 0.01429316
92/49884
# 0.001844279
3022/49884
# 0.06058055
1299/49884
# 0.02604041
1363/50161
# 0.0271725
12825/50161
# 0.2556767
153/50161
# 0.003050178
6206/50161
# 0.1237216
352/50161
# 0.007017404
8236/50161
# 0.1641913
length(unique(Phecode_Subset_Cohort_ids$masked_mrn))
# 49296
length(unique(Encounter_Subset_Cohort_ids$masked_mrn))
# 49265
dim(Encounter_Subset_Cohort_ids)
# 2355232       5
dim(Phecode_Subset_Cohort_ids)
# 50532  3385
Revamped_Phecode_Subset_Cohort_ids <- Phecode_Subset_Cohort_ids[match(intersect(unique(Phecode_Subset_Cohort_ids$masked_mrn), Phecode_Subset_Cohort_ids$masked_mrn), Phecode_Subset_Cohort_ids$masked_mrn),]
dim(Revamped_Phecode_Subset_Cohort_ids)
# 49296  3385
#Phecodes are now set to the unique ids as well
fwrite(Revamped_Cohort, "Main_Cohort_Adults_Unique_IDs_051625.csv")
fwrite(Revamped_Phecode_Subset_Cohort_ids, "Phecode_Main_Cohort_Adults_Unique_IDs_051625.csv")
q()
