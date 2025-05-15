#This script shows why there is a need for regenerating PCs so more samples are captured and then we can rerun the analysis based on the Main Cohort samples for PGC in general since the ids do deplete. We can check numbers since the PGC Catalog already has a smaller number of samples than genetic samples in general
library(data.table)
PGC_Catalog <- fread("/sc/private/regen/IPM-general/Kenny_Lab/MSM/pgsc/results/ALL_aggregated_scores.txt.gz")
PCs_All <- fread("/sc/arion/projects/MSM/data/common_variants/combined/batch_001/imputed_TOPMED/addition/PC/MSM_PCA.txt")
Main_Cohort <- fread("Main_Cohort_Adults_050225.csv")
dim(Main_Cohort)
# 51636   172
dim(PCs_All)
# 59932    22
dim(PGC_Catalog)
# 50518  4831
head(PCs_All$IID, 5)
colnames(PCs_All)
head(PCs_All$IID, 5)
#Those 2 match with IIDs
head(Main_Cohort$ID_1, 5)
head(Main_Cohort$subject_id.x, 5)
head(Main_Cohort$extra1_SUBJECT_ID, 5)
head(Main_Cohort$ID_2, 5)
ID_Map <- fread("/sc/arion/projects/igh/data/MSM/id_maps/subject_sample_mmrn_map_032025.txt")
dim(ID_Map)
# 63279     3
head(ID_Map, 3)
dim(ID_Map[match(intersect(PCs_All$IID, ID_Map$sample_name), ID_Map$sample_name),])
# 31690     3
Mapping_Original <- fread("/sc/arion/projects/igh/kennylab/data/biome/pheno/ID_Masked_Mrn_Mapping.csv")
dim(ID_Map[match(intersect(PCs_All$IID, Mapping_Original$SUBJECT_ID), Mapping_Original$SUBJECT_ID),])
# 31671     3
colnames(Main_Cohort)
head(Main_Cohort$V2, 5)
head(Main_Cohort$ID_1, 5)
#A quick check before remerging things
Genetic_Samples_Common <- fread("/sc/arion/projects/igh/data/MSM/data/common_variants/combined/batch_001/imputed_TOPMED/bgen/MSM_TOPMED.chr19.sample")
colnames(Genetic_Samples_Common)
head(Genetic_Samples_Common$ID_1, 5)
dim(Mapping_Original[match(intersect(PCs_All$IID, Mapping_Original$SUBJECT_ID), Mapping_Original$SUBJECT_ID),])
# 31671     3
dim(PCs_All[match(intersect(Main_Cohort$ID_1, PCs_All$IID), PCs_All$IID),])
# 29543    22
dim(PCs_All[match(intersect(ID_Map$sample_name, PCs_All$IID), PCs_All$IID),])
# 31690    22
dim(merge(Main_Cohort, PCs_All, by.x="ID_1", by.y="IID"))
# 30687   193
length(unique(PCs_All$IID))
# 59932
length(unique(PGC_Catalog$IID))
# 50518
dim(PCs_All[match(intersect(PCs_All$IID, PGC_Catalog$IID), PGC_Catalog$IID),])# 25204    22
dim(Mapping_Original[match(intersect(PCs_All$IID, Mapping_Original$SUBJECT_ID), Mapping_Original$SUBJECT_ID),])
# 31671     3
dim(Mapping_Original[match(intersect(PGC_Catalog$IID, Mapping_Original$SUBJECT_ID), Mapping_Original$SUBJECT_ID),])
# 25175     3
dim(Mapping_Original[match(intersect(PGC_Catalog$IID, Mapping_Original$SUBJECT_ID), Mapping_Original$),])
dim(Main_Cohort[match(intersect(PGC_Catalog$IID, Main_Cohort$ID_1), Main_Cohort$ID_1),])
# 43413   172
#Majority are kept with the Main_Cohort and the PGC_Catalog, but most are lost with PCs_All, which means it is something else to merge or match files with that approach
dim(ID_Map[match(intersect(Main_Cohort$ID_1, ID_Map$sample_name), ID_Map$sample_name),])
# 50161     3
dim(ID_Map[match(intersect(Main_Cohort$masked_mrn, ID_Map$masked_mrn), ID_Map$masked_mrn),])
# 50161     3
dim(merge(Main_Cohort, ID_Map, by="masked_mrn"))
# 51702   174
dim(Main_Cohort)
# 51636   172
dim(ID_Map)
# 63279     3
#merge method does not merge on unique only and contains nas. For calculations,it is preferred to match to the unique samples, which the df[match(intersect(), ),] method of coding provides
Id_Current_Original <- merge(ID_Map, Mapping_Original, by.x="masked_mrn", by.y="MASKED_MRN")
dim(Id_Current_Original)
# 54821     5
dim(merge(Main_Cohort, Id_Current_Original, by="masked_mrn"))
# 52230   176
length(unique(Main_Cohort$masked_mrn))
# 50161
#This is why the match intersect matches up because these are the unique ids being pulled
length(unique(Id_Current_Original$masked_mrn))
# 54436
length(unique(Id_Current_Original$sample_name))
# 54520
dim(ID_Map[match(intersect(PCs_All$IID, ID_Map$sample_name), ID_Map$sample_name),])
# 31690     3
dim(Id_Current_Original[match(intersect(PCs_All$IID, Id_Current_Original$sample_name), Id_Current_Original$sample_name),])
# 31570     5
dim(Id_Current_Original[match(intersect(PCs_All$IID, Id_Current_Original$SUBJECT_ID), Id_Current_Original$SUBJECT_ID),])
# 31570     5
#same as before, so there is an issue with some of the labels used because the numbers drop based on labeling
objects()
dim(Genetic_Samples_Common[match(intersect(Genetic_Samples_Common$),),])
dim(Genetic_Samples_Common[match(intersect(PCs_All$IID, Genetic_Samples_Common$ID_1), Genetic_Samples_Common$ID_1),])
# 30159     3
#The genetic id is not matching with the PCs much at all with a loss of 20K participants
dim(Genetic_Samples_Common[match(intersect(PGC_Catalog$IID, Genetic_Samples_Common$ID_1), Genetic_Samples_Common$ID_1),])
# 50518     3
#The PGC catalog has what we need in terms of the right amount of samples matching the genetic data ids. This means something is wrong with the way the PCs were calcualted because they use genetic data but lack the information on same naming structure for the PC labels to what we have in the genetic data
dim(Main_Cohort[match(intersect(PGC_Catalog$IID, Main_Cohort$ID_1), Main_Cohort$ID_1),])
# 43413   172
length(unique(Main_Cohort$ID_1))
# 50161
#There is a drop of samples because of matching to the questionnaire and finding the data for other parts, but that will do for now and we will run PRSCSx for that GWAS most likely over the following week. Trying to reproduce the PRS would take too long and the QC was overdone for All of Us to generate, which needs to be a slide about that for other PRS calculations in general
Catalog_Kept_Participants_Main_Cohort <- Main_Cohort[match(intersect(PGC_Catalog$IID, Main_Cohort$ID_1), Main_Cohort$ID_1),]
dim(Catalog_Kept_Participants_Main_Cohort)
# 43413   172
Sample_Keep <- Catalog_Kept_Participants_Main_Cohort[,c(1:2)]
dim(Sample_Keep)
# 43413     2
colnames(Sample_Keep)
# "ID_1" "ID_2"
colnames(Sample_Keep) <- c("FID", "IID")
write.table(Sample_Keep, "Pull_1st_Round_Main_Cohort_PGC_Catalog_IDs_051525.txt", quote=F, row.names=F, col.names=T, sep="\t")
length(unique(Main_Cohort$ID_1)) - nrow(Sample_Keep)
# 6748
#The above is the number of samples lost between the Main Cohort and the PGC catalog dataset. Will need to explore more on how it was calculated so that there are more explanations to what the loss of samples were done prior to redoing the PGC Catalog run
q()
