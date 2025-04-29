#File is for building the subset files based on self-reported ancestry for the variant pulls before the committee meeting on March 31st, 2025
library(data.table)
Link_FileA <- fread("/sc/private/regen/IPM-general/Kenny_Lab/MSM_QC_v2/msm_with_biome_mmrns/PCA_data_annotated_with_Masked_MRNs_no_duplicates.eigenvec")
dim(Link_FileA) #47,098 participants
colnames(Link_FileA)
 [1] "MILLION_ID" "MM"         "#FID"       "PC1"        "PC2"
 [6] "PC3"        "PC4"        "PC5"        "PC6"        "PC7"
[11] "PC8"        "PC9"        "PC10"
Main_File <- fread("/sc/arion/projects/igh/data/pgs_catalog/superpop_scores_103024/scores/ALL_aggregated_scores.txt.gz")
dim(Main_File) #50,518 participants
head(Main_File$IID,5)
Try_Link_MainA <- Main_File[match(intersect(Link_FileA$MILLION_ID, Main_File$IID), Main_File$IID)]
dim(Try_Link_MainA) #43,081 participants
#It linked, which is all I care about for downstream analyses for the variants
#I can create the next set of files for additional subsetting for the variant counts now that I have a link to the main file I am using
summary(as.factor(Try_Link_MainA$Ancestry))
#One last check for linking files
Fam <- fread("/sc/arion/projects/MSM/data/WES/combined/batch_001/plink/All/SINAI_MILLION_ALL_PASS.fam")
head(Fam, 5)
#All are linked or should be
Fam_Try_Link_MainA <- Fam[match(intersect(Try_Link_MainA$IID, Fam$V1), Fam$V1),]
dim(Fam_Try_Link_MainA) #43,069 participants
#Small drop in size from the Link_File based on Sinead's work and MainA linked file
Try_Fam_Link_MainA <- Try_Link_MainA[match(intersect(Fam_Try_Link_MainA$V1, Try_Link_MainA$IID), Try_Link_MainA$IID),]
dim(Try_Fam_Link_MainA) #43,069 participants
#Now we have the match that matters for all of the linkings
summary(as.factor(Try_Fam_Link_MainA$Ancestry))
# AFR   AMR   EAS   EUR   SAS
# 15781  5986  1818 17889  1595
summary(as.factor(Try_Fam_Link_MainA$SequencedGender))
# Female   Male
# 24445  18624
#Now we generate the subset files for the additional plink commands
#Subset to IIDs for each, specifically these will be FID and IID for plink extractions
head(Fam$V1, 5)
head(Fam$V2, 5)
Try_Fam_Link_MainA$FID <- Try_Fam_Link_MainA$IID
#Rerun with new setting
Female_Try_Fam_Link_MainA <- Try_Fam_Link_MainA[which(Try_Fam_Link_MainA$SequencedGender == "Female"),]
Male_Try_Fam_Link_MainA <- Try_Fam_Link_MainA[which(Try_Fam_Link_MainA$SequencedGender == "Male"),]
AFR_Try_Fam_Link_MainA <- Try_Fam_Link_MainA[which(Try_Fam_Link_MainA$Ancestry == "AFR"),]
AMR_Try_Fam_Link_MainA <- Try_Fam_Link_MainA[which(Try_Fam_Link_MainA$Ancestry == "AMR"),]
EUR_Try_Fam_Link_MainA <- Try_Fam_Link_MainA[which(Try_Fam_Link_MainA$Ancestry == "EUR"),]
EAS_Try_Fam_Link_MainA <- Try_Fam_Link_MainA[which(Try_Fam_Link_MainA$Ancestry == "EAS"),]
SAS_Try_Fam_Link_MainA <- Try_Fam_Link_MainA[which(Try_Fam_Link_MainA$Ancestry == "SAS"),]
Subset_Combined <- Try_Fam_Link_MainA[,c("FID", "IID")]
dim(Subset_Combined)
colnames(Subset_Combined)
head(Subset_Combined, 5)
Subset_Female <- Female_Try_Fam_Link_MainA[,c("FID", "IID")]
Subset_Male <- Male_Try_Fam_Link_MainA[,c("FID", "IID")]
Subset_AFR <- AFR_Try_Fam_Link_MainA[,c("FID", "IID")]
Subset_AMR <- AMR_Try_Fam_Link_MainA[,c("FID", "IID")]
Subset_EUR <- EUR_Try_Fam_Link_MainA[,c("FID", "IID")]
Subset_EAS <- EAS_Try_Fam_Link_MainA[,c("FID", "IID")]
Subset_SAS <- SAS_Try_Fam_Link_MainA[,c("FID", "IID")]
write.table(Subset_Combined, "Combined_Variant_Pull_Key_Samples_033125.txt", row.names=F, col.names=T, sep="\t")
write.table(Subset_Female, "Female_Variant_Pull_Key_Samples_033125.txt", row.names=F, col.names=T, sep="\t")
write.table(Subset_Male, "Male_Variant_Pull_Key_Samples_033125.txt", row.names=F, col.names=T, sep="\t")
write.table(Subset_AFR, "AFR_Variant_Pull_Key_Samples_033125.txt", row.names=F, col.names=T, sep="\t")
write.table(Subset_AMR, "AMR_Variant_Pull_Key_Samples_033125.txt", row.names=F, col.names=T, sep="\t")
write.table(Subset_EUR, "EUR_Variant_Pull_Key_Samples_033125.txt", row.names=F, col.names=T, sep="\t")
write.table(Subset_EAS, "EAS_Variant_Pull_Key_Samples_033125.txt", row.names=F, col.names=T, sep="\t")
write.table(Subset_SAS, "SAS_Variant_Pull_Key_Samples_033125.txt", row.names=F, col.names=T, sep="\t")
q()
