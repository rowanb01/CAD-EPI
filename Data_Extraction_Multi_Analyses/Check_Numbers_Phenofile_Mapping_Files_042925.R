#Goal is to see if these numbers are right with others comparing it themselves or pointing out errors in code
library(data.table)
Questionnaire <- fread("/sc/private/regen/data/BioMe/BRSSPD/2024-07-01/Questionnaire.csv")
Phenotypes_FileA <- fread("/sc/arion/projects/igh/data/phecodeTable_BioMe_withSexPhecode_MinCount1.tsv")
head(Phenotypes_FileA$id, 5)
head(Questionnaire$subject_id, 5)
head(Questionnaire$masked_mrn, 5)
Mapping_Original <- fread("/sc/arion/projects/igh/kennylab/data/biome/pheno/ID_Masked_Mrn_Mapping.csv")
dim(Mapping_Original)
Id_Mapper_Current <- fread("/sc/arion/projects/igh/data/MSM/id_maps/subject_sample_mmrn_map_032025.txt")
dim(Id_Mapper_Current)
#The current file has more mappings than the original mapping file
colnames(Id_Mapper_Current)
Pheno_Current_Match <- Phenotypes_FileA[match(intersect(Id_Mapper_Current$sample_name, Phenotypes_FileA$id), Phenotypes_FileA$id),]
colnames(Id_Mapper_Current)
dim(Pheno_Current_Match)
#Drops down to 31,554 participants
colnames(Mapping_Original)
Mapping_Check <- Mapping_Original[match(intersect(Id_Mapper_Current$masked_mrn, Mapping_Original$MASKED_MRN), Mapping_Original$MASKED_MRN),]
dim(Mapping_Check)
#That is not a bad dropoff
#Especially given the difference in samples overall from the original (the rate limiter) to the new dataset
#54,446 participants are retained based on matching the mapped files on masked men
Id_Original_Subset <- Id_Mapper_Current[match(intersect(Mapping_Check$MASKED_MRN, Id_Mapper_Current$masked_mrn), Id_Mapper_Current$masked_mrn),]
Pheno_Original_Match <- Phenotypes_FileA[match(intersect(Id_Original_Subset$sample_name, Phenotypes_FileA$id), Phenotypes_FileA$id),]
dim(Pheno_Original_Match)
#Overall, the drop is by 140 participants, which is not bad but still quite a drop
#Total number of participants is 31,414 once this procedure is done
q()
