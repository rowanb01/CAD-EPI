#Goal of this script is to create the cohort files for extracting the desired variables from BioMe
library(data.table)
Phecodes <- fread("/sc/arion/projects/igh/data/phecodeTable_BioMe_withSexPhecode_MinCount1.tsv")
Questionnaire <- fread("/sc/private/regen/data/BioMe/BRSSPD/2024-07-01/Questionnaire.csv")
Mapping_Original <- fread("/sc/arion/projects/igh/kennylab/data/biome/pheno/ID_Masked_Mrn_Mapping.csv")
Id_Mapper_Current <- fread("/sc/arion/projects/igh/data/MSM/id_maps/subject_sample_mmrn_map_032025.txt")
dim(Id_Mapper_Current)
# 63279     3
dim(Phecodes)
# 54775  3214
dim(Questionnaire)
# 67481   158
Id_Current_Original <- merge(Id_Mapper_Current, Mapping_Original, by.x="masked_mrn", by.y="MASKED_MRN")
dim(Id_Current_Original)
# 54821     5
Genetic_Samples_Common <- fread("/sc/arion/projects/igh/data/MSM/data/common_variants/combined/batch_001/imputed_TOPMED/bgen/MSM_TOPMED.chr19.sample")
dim(Genetic_Samples_Common)
# 58387     3
Genetic_Samples_Exome <- fread("/sc/arion/projects/MSM/data/WES/combined/batch_001/plink/All/SINAI_MILLION_ALL_PASS.fam")
dim(Genetic_Samples_Exome)
# 58990     6
colnames(Genetic_Samples_Exome)
colnames(Genetic_Samples_Common)
head(Genetic_Samples_Exome, 5)
#V1 and V2 are the same as ID_1 ID_2 basically
Genetic_Common_Exome <- merge(Genetic_Samples_Common, Genetic_Samples_Exome, by.x="ID_1", by.y="V1")
dim(Genetic_Common_Exome)
# 58373     8
#Pull out the intersection between the id samples and the questionnaire
Id_Current_Original$extra1_SUBJECT_ID <- Id_Current_Original$SUBJECT_ID
Id_Current_Original$extra2_SUBJECT_ID <- Id_Current_Original$SUBJECT_ID
colnames(Id_Current_Original)
#This should prevent the issues with the past merging issues since the exact same column is duplicated 
Questionnaire_with_ids <- merge(Questionnaire, Id_Current_Original, by="masked_mrn")
Phecodes_with_questionnaire_with_ids <- merge(Phecodes, Questionnaire_with_ids, by.x="id", by.y="extra1_SUBJECT_ID")
dim(Questionnaire_with_ids)
# 55756   164
dim(Phecodes_with_questionnaire_with_ids)
# 54542  3377
Encounters <- fread("/sc/private/regen/data/BioMe/BRSSPD/2024-07-01/Encounter_Diagnosis.csv")
colnames(Encounters)
head(Encounters$subject_id, 5)
# "RGN176835" "RGN184871" "RGN35803"  "RGN54317"  "RGN167276"
head(Encounters$masked_mrn, 5)
#  9622236 10682839  1278781  1307034  8211876
dim(Encounters)
# 14745483       10
Genetic_Common_Exome_with_questionnaire_with_ids <- merge(Genetic_Common_Exome, Questionnaire_with_ids, by.x="ID_1", by.y="sample_name")
dim(Genetic_Common_Exome_with_questionnaire_with_ids)
#If someone tries to generate this by SUBJECT_ID then the number drops drastically (30,632). Likely the old mapper is needed becaues those are the ids used when the phenotype files were generated. The sample_name is for the more recent generation of Boime
#Main cohort has 51,823 participants 
Encounter_Subset_Cohort_ids <- merge(Encounters, Genetic_Common_Exome_with_questionnaire_with_ids, by="masked_mrn")
dim(Encounter_Subset_Cohort_ids)
# 12705271      180
Phecode_Subset_Cohort_ids <- merge(Phecodes, Genetic_Common_Exome_with_questionnaire_with_ids, by.x="id", by.y="extra1_SUBJECT_ID") 
dim(Phecode_Subset_Cohort_ids)
# 50719  3384
length(unique(Encounter_Subset_Cohort_ids$subject_id))
# 49451
#49,451 unique ids within the repeated entries
Labs <- fread("/sc/arion/projects/kennylab/labwas/data/medians_by_encounter_type_100samp_1000obs/hospital_20240521_Medians_and_Age_at_Median_all_labs.txt")
dim(Labs)
# 95982702       17
colnames(Labs)
head(Labs$subject_id, 5)
head(Labs$masked_mrn, 5)
Lab_Subset_Cohort_ids <- merge(Labs, Genetic_Common_Exome_with_questionnaire_with_ids, by.x="PERSON_ID", by.y="masked_mrn")
dim(Lab_Subset_Cohort_ids)
# 47234  1081
#Now to save the main files and run analyses (data_extraction) on them
fwrite(Encounter_Subset_Cohort_ids, "Encounters_Main_Cohort_043025.csv")
fwrite(Lab_Subset_Cohort_ids, "Labs_Main_Cohort_043025.csv")
fwrite(Phecode_Subset_Cohort_ids, "Phecode_Main_Cohort_043025.csv")                                                                
fwrite(Genetic_Common_Exome_with_questionnaire_with_ids, "Main_Cohort_043025.csv")
q()
