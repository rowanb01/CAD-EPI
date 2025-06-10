#This is using an updated MSM for the dataset (8/20/24 subset)
library(data.table)
Questionnaire <- fread("/sc/arion/projects/MSM/data/phenotypes/2024-08-20/Questionnaire.txt")
Mapping_Original <- fread("/sc/arion/projects/igh/kennylab/data/biome/pheno/ID_Masked_Mrn_Mapping.csv")
Id_Mapper_Current <- fread("/sc/arion/projects/igh/data/MSM/id_maps/subject_sample_mmrn_map_032025.txt")
Genetic_Samples_Common <- fread("/sc/arion/projects/igh/data/MSM/data/common_variants/combined/batch_001/imputed_TOPMED/bgen/MSM_TOPMED.chr19.sample")
Genetic_Samples_Exome <- fread("/sc/arion/projects/MSM/data/WES/combined/batch_001/plink/All/SINAI_MILLION_ALL_PASS.fam")
dim(Id_Mapper_Current)
# 63279     3
dim(Questionnaire)
# 116268    158
Id_Current_Original <- merge(Id_Mapper_Current, Mapping_Original, by.x="masked_mrn", by.y="MASKED_MRN")
dim(Id_Current_Original)
# 54821     5
dim(Genetic_Samples_Common)
# 58387     3
dim(Genetic_Samples_Exome)
# 58990     6
Genetic_Common_Exome <- merge(Genetic_Samples_Common, Genetic_Samples_Exome, by.x="ID_1", by.y="V1")
dim(Genetic_Common_Exome)
# 58373     8
#Pull out the intersection between the id samples and the questionnaire
Id_Current_Original$extra1_SUBJECT_ID <- Id_Current_Original$SUBJECT_ID
Id_Current_Original$extra2_SUBJECT_ID <- Id_Current_Original$SUBJECT_ID
colnames(Id_Current_Original)
colnames(Questionnaire)
Id_Current_Original$extra1_sample_name <- Id_Current_Original$sample_name
Id_Current_Original$extra2_sample_name <- Id_Current_Original$sample_name
Questionnaire_with_ids <- merge(Questionnaire, Id_Current_Original, by="sample_name")
dim(Questionnaire_with_ids)
# 107224    166
length(unique(Questionnaire_with_ids$sample_name))
# 54282
Genetic_Common_Exome_with_questionnaire_with_ids <- merge(Genetic_Common_Exome, Questionnaire_with_ids, by.x="ID_1", by.y="sample_name")
dim(Genetic_Common_Exome_with_questionnaire_with_ids)
# 99710   173
length(unique(Genetic_Common_Exome_with_questionnaire_with_ids$extra1_sample_name))
# 50504
Genetic_Common_Exome_with_questionnaire_with_ids$Age <- 2025 - Genetic_Common_Exome_with_questionnaire_with_ids$YEAR_OF_BIRTH
range(Genetic_Common_Exome_with_questionnaire_with_ids$Age)
# 11 91
Adult_Genetic_Common_Exome_with_questionnaire_with_ids <- Genetic_Common_Exome_with_questionnaire_with_ids[which(Genetic_Common_Exome_with_questionnaire_with_ids$Age >= 18),]
dim(Adult_Genetic_Common_Exome_with_questionnaire_with_ids)
# 99331   174
length(unique(Adult_Genetic_Common_Exome_with_questionnaire_with_ids$extra1_sample_name))
# 50317
PGC_Catalog <- fread("/sc/private/regen/IPM-general/Kenny_Lab/MSM/pgsc/results/ALL_aggregated_scores.txt.gz")
dim(PGC_Catalog)
# 50518  4831
Remaining_PGC_Catalog_Main_Cohort_Subset <- PGC_Catalog[match(intersect(Adult_Genetic_Common_Exome_with_questionnaire_with_ids$ID_1, PGC_Catalog$IID), PGC_Catalog$IID),]
dim(Remaining_PGC_Catalog_Main_Cohort_Subset)
# 43532  4831
#I can safely say that doing things Travis way with the updated dataset only gives us ~ 100 more samples. The extra update does not help with this issue in terms of questionnaire
q()
