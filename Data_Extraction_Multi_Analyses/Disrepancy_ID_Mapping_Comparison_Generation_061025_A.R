#The goal of the script is to generate spreadsheets that show the differences in ids selected between PGC Catalog and the Main Cohort
library(data.table)
library(openxlsx)
Main_Cohort <- fread("Main_Cohort_Adults_Unique_IDs_051625.csv")
PGC_Catalog <- fread("/sc/private/regen/IPM-general/Kenny_Lab/MSM/pgsc/results/ALL_aggregated_scores.txt.gz")
ID_Map <- fread("/sc/arion/projects/igh/data/MSM/id_maps/subject_sample_mmrn_map_032025.txt")
dim(ID_Map)
# 63279     3
head(ID_Map, 5)
head(Main_Cohort$subject_id.x, 5)
head(Main_Cohort$subject_id.y, 5)
#Similar from this point of view
head(Main_Cohort$ID_1, 5)
head(Main_Cohort$ID_2, 5)
#The same results
#subject id is the regeneron ids, ID_ is the sample name for ID_Map
colnames(PGC_Catalog)[1:15]
#The 1st 15 have some value, but for comparisons I would need IID, Ancestry, and SequencedGender (pull the first 4, only need columns 1,2, and 4)
head(PGC_Catalog$IID, 5)
dim(ID_Map[match(intersect(PGC_Catalog$IID, ID_Map$sample_name), ID_Map$sample_name),])
# 50506     3
dim(PGC_Catalog)
# 50518  4831
#Loss between the ID_Map and PGC_Catalog is 12
dim(Main_Cohort)
# 50161   172
#Main_Cohort is the smaller subset
dim(ID_Map[match(intersect(Main_Cohort$masked_mrn, ID_Map$masked_mrn), ID_Map$masked_mrn),])
# 50161     3
#ID_Map contains both the PGC samples and the Main Cohort samples
Subset_ID_Map_by_PGC_Catalog <- ID_Map[match(intersect(PGC_Catalog$IID, ID_Map$sample_name), ID_Map$sample_name),]
dim(Subset_ID_Map_by_PGC_Catalog)
# 50506     3
#This is correct
dim(Subset_ID_Map_by_PGC_Catalog[match(intersect(Main_Cohort$masked_mrn, Subset_ID_Map_by_PGC_Catalog$masked_mrn), Subset_ID_Map_by_PGC_Catalog$masked_mrn),])# 43413     3
#Still having the drop issue, meaning different samples are being pulled by the ID_Map
dim(Subset_ID_Map_by_PGC_Catalog[match(setdiff(Subset_ID_Map_by_PGC_Catalog$sample_name, Main_Cohort$ID_1), Subset_ID_Map_by_PGC_Catalog$sample_name),])
# 7093    3
#These should be the 7093 particioants that are not included in the Main_Cohort matching
Disconnected_ID_Map_Main_Cohort_PGC_Catalog <- Subset_ID_Map_by_PGC_Catalog[match(setdiff(Subset_ID_Map_by_PGC_Catalog$sample_name, Main_Cohort$ID_1), Subset_ID_Map_by_PGC_Catalog$sample_name),]
dim(Disconnected_ID_Map_Main_Cohort_PGC_Catalog)
# 7093    3
#This is true for the disconnected ids
head(Disconnected_ID_Map_Main_Cohort_PGC_Catalog, 5)
dim(Disconnected_ID_Map_Main_Cohort_PGC_Catalog[match(intersect(Main_Cohort$subject_id.y, Disconnected_ID_Map_Main_Cohort_PGC_Catalog$subject_id), Disconnected_ID_Map_Main_Cohort_PGC_Catalog$subject_id),])
# 0 3
dim(Disconnected_ID_Map_Main_Cohort_PGC_Catalog[match(intersect(Main_Cohort$masked_mrn, Disconnected_ID_Map_Main_Cohort_PGC_Catalog$masked_mrn), Disconnected_ID_Map_Main_Cohort_PGC_Catalog$masked_mrn),])
# 0 3
dim(Disconnected_ID_Map_Main_Cohort_PGC_Catalog[match(intersect(Main_Cohort$ID_1, Disconnected_ID_Map_Main_Cohort_PGC_Catalog$sample_name), Disconnected_ID_Map_Main_Cohort_PGC_Catalog$sample_name),])
# 0 3
dim(Disconnected_ID_Map_Main_Cohort_PGC_Catalog[match(intersect(Main_Cohort$ID_2, Disconnected_ID_Map_Main_Cohort_PGC_Catalog$sample_name), Disconnected_ID_Map_Main_Cohort_PGC_Catalog$sample_name),])
# 0 3
#Still having the drop issue, meaning different samples are being pulled by the ID_Map
dim(Main_Cohort[match(intersect(Subset_ID_Map_by_PGC_Catalog$sample_name, Main_Cohort$ID_1), Main_Cohort$ID_1),])
# 43413   172
#Makes sense with the trend
dim(Main_Cohort[match(setdiff(Main_Cohort$ID_1, Subset_ID_Map_by_PGC_Catalog$sample_name), Main_Cohort$ID_1),])
# 6748  172
#Issue with total lost samples accounted for in another script reshown
nrow(Subset_ID_Map_by_PGC_Catalog) - nrow(Main_Cohort)
# 345
#Amount dropped between the 2 dataframes if everything was linked properly
dim(Main_Cohort[match(setdiff(Main_Cohort$masked_mrn, Subset_ID_Map_by_PGC_Catalog$masked_mrn), Main_Cohort$masked_mrn),])
# 6748  172
dim(Main_Cohort[match(setdiff(Main_Cohort$subject_id.y, Subset_ID_Map_by_PGC_Catalog$subject_id), Main_Cohort$subject_id.y),])
# 6748  172
dim(Main_Cohort[match(setdiff(Main_Cohort$subject_id.x, Subset_ID_Map_by_PGC_Catalog$subject_id), Main_Cohort$subject_id.x),])
# 6756  172
#More lost with x than y but otherwise the trend continues (8 more lost with.x for subject id)
Disconnected_Main_Cohort_by_Subset_ID_Map_by_PGC_Catalog <- Main_Cohort[match(setdiff(Main_Cohort$masked_mrn, Subset_ID_Map_by_PGC_Catalog$masked_mrn), Main_Cohort$masked_mrn),]
dim(Disconnected_Main_Cohort_by_Subset_ID_Map_by_PGC_Catalog)
# 6748  172
nrow(Disconnected_ID_Map_Main_Cohort_PGC_Catalog) - nrow(Disconnected_Main_Cohort_by_Subset_ID_Map_by_PGC_Catalog)
# 345
#The drop by 345 participants that naturally happens due to the difference in Main Cohort and PGC_Catalog is retained, so this loss is acceptable
Remapped_Lost_Main_Cohort_ID_Map <- ID_Map[match(intersect(Disconnected_Main_Cohort_by_Subset_ID_Map_by_PGC_Catalog$masked_mrn, ID_Map$masked_mrn), ID_Map$masked_mrn)]
dim(Remapped_Lost_Main_Cohort_ID_Map)
# 6748    3
#These ids are now retained
dim(Subset_ID_Map_by_PGC_Catalog[match(intersect(Remapped_Lost_Main_Cohort_ID_Map$sample_name, Subset_ID_Map_by_PGC_Catalog$sample_name), Subset_ID_Map_by_PGC_Catalog$sample_name),])
# 0 3
dim(Subset_ID_Map_by_PGC_Catalog[match(intersect(Remapped_Lost_Main_Cohort_ID_Map$masked_mrn, Subset_ID_Map_by_PGC_Catalog$masked_mrn), Subset_ID_Map_by_PGC_Catalog$masked_mrn),])
# 0 3
dim(Subset_ID_Map_by_PGC_Catalog[match(intersect(Remapped_Lost_Main_Cohort_ID_Map$subject_id, Subset_ID_Map_by_PGC_Catalog$subject_id), Subset_ID_Map_by_PGC_Catalog$subject_id),])
# 0 3
objects()
dim(Disconnected_ID_Map_Main_Cohort_PGC_Catalog)
# 7093    3
dim(Remapped_Lost_Main_Cohort_ID_Map)
# 6748    3
head(Disconnected_ID_Map_Main_Cohort_PGC_Catalog, 5)
summary(as.factor(Main_Cohort$PLATFORM))
#Regeneron     Sema4
#    29435     20726
#Platform from the questionnaire has no missingness
summary(as.factor(Disconnected_Main_Cohort_by_Subset_ID_Map_by_PGC_Catalog$PLATFORM))
#Regeneron     Sema4
#     4822      1926
#Unfortunately, the platform piece does not all lie on one platform or the other, which would be a simplier way to solve this issue
fwrite(Disconnected_ID_Map_Main_Cohort_PGC_Catalog, "PGC_Catalog_Not_in_Main_Cohort_IDs_061025.csv")
fwrite(Remapped_Lost_Main_Cohort_ID_Map, "Main_Cohort_Not_in_PGC_Catalog_061025.csv")
Spreadsheet_A <- list("PGC_Missing" = Disconnected_ID_Map_Main_Cohort_PGC_Catalog, "Main_Missing" = Remapped_Lost_Main_Cohort_ID_Map)
write.xlsx(Spreadsheet_A, "ID_Map_Disrepancy_Checks_A_061025.xlsx")
summary(as.factor(PGC_Catalog$SequencedGender))
#Female   Male 
# 28941  21577 
summary(as.factor(Main_Cohort$GENDER))
# Female    Male Unknown 
#  29310   20842       9 
head(Remapped_Lost_Main_Cohort_ID_Map, 5)
head(Disconnected_Main_Cohort_by_Subset_ID_Map_by_PGC_Catalog$ID_1, 5)
V2_Remapped_Lost_Main_Cohort_ID_Map <- Remapped_Lost_Main_Cohort_ID_Map
V2_Remapped_Lost_Main_Cohort_ID_Map$Shortened_Sample_Name <- Disconnected_Main_Cohort_by_Subset_ID_Map_by_PGC_Catalog$SUBJECT_ID
V2_Remapped_Lost_Main_Cohort_ID_Map$Gender <- Disconnected_Main_Cohort_by_Subset_ID_Map_by_PGC_Catalog$GENDER
Redone_PGC_Catalog <- PGC_Catalog[match(intersect(Disconnected_ID_Map_Main_Cohort_PGC_Catalog$sample_name, PGC_Catalog$IID), PGC_Catalog$IID),]
dim(Redone_PGC_Catalog)
# 7093 4831
#That is correct
head(Redone_PGC_Catalog$IID, 5)
head(Disconnected_ID_Map_Main_Cohort_PGC_Catalog, 5)
#same order
V2_Disconnected_ID_Map_Main_Cohort_PGC_Catalog <- Disconnected_ID_Map_Main_Cohort_PGC_Catalog
V2_Disconnected_ID_Map_Main_Cohort_PGC_Catalog$Gender <- Redone_PGC_Catalog$SequencedGender
Spreadsheet_B <- list("PGC_Missing" = V2_Disconnected_ID_Map_Main_Cohort_PGC_Catalog, "Main_Missing" = V2_Remapped_Lost_Main_Cohort_ID_Map)
write.xlsx(Spreadsheet_B, "ID_Map_Disrepancy_Checks_B_061025.xlsx")
q()
