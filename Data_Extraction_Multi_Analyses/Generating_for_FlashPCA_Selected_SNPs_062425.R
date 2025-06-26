#The goal is to generate the files needed for subsetting the data to what will be used in FlashPCA and then subset the results to the FlashPCA as well

#Get the data into a subset state
library(data.table)
Auto_LiftOver_eMERGE_PCs <- fread("Liftover_Results_eMERGE_SNPs_for_PCs_062025.csv")
Manual_LiftOver_eMERGE_PCs <- fread("Manually_List_Presplit_for_eMERGE_PCs_Generation_in_BioMe_062325.txt")
dim(Manual_LiftOver_eMERGE_PCs)
#86  2
colnames(Manual_LiftOver_eMERGE_PCs)
#"NewID"      "OriginalID"
Array <- fread("/sc/arion/projects/igh/data/MSM/data/common_variants/combined/batch_001/variants/SINAI_MILLION_SUBSET_QC.bim")
Data_Ark_Array <- fread("/sc/arion/projects/data-ark/CBIPM/Microarray/combined/imputed_TOPMED_V2/plink/GSA_GDA_V2_TOPMED_HG38.bim")
colnames(Data_Ark_Array) <- c("CHR", "SNP", "CPM", "POS", "A1", "A2")
Info_File <- fread("/sc/arion/projects/igh/data/MSM/data/common_variants/combined/batch_001/imputed_TOPMED/addition/info/GSA_GSX_INFO_TOPMED.txt")
dim(Array)
#506550      6
dim(Data_Ark_Array)
#60491206        6
dim(Info_File)
#83496273       19
colnames(Info_File)
colnames(Array)
colnames(Array) <- c("CHR", "SNP", "CPM", "POS", "A1", "A2")
colnames(Auto_LiftOver_eMERGE_PCs)
dim(Auto_LiftOver_eMERGE_PCs)
#321334     12
Array$ID1 <- paste(Array$CHR, Array$POS, Array$A1, Array$A2, sep=":")
Array$ID2 <- paste(Array$CHR, Array$POS, Array$A2, Array$A1, sep=":")
Data_Ark_Array$ALt_SNP1 <- paste(Data_Ark_Array$CHR, Data_Ark_Array$POS, Data_Ark_Array$A1, Data_Ark_Array$A2, sep=":")
Data_Ark_Array$ALt_SNP2 <- paste(Data_Ark_Array$CHR, Data_Ark_Array$POS, Data_Ark_Array$A2, Data_Ark_Array$A1, sep=":")
dim(Data_Ark_Array[match(intersect(Auto_LiftOver_eMERGE_PCs$New_ID, Data_Ark_Array$ALt_SNP1), Data_Ark_Array$ALt_SNP1),])
#152951      8
dim(Data_Ark_Array[match(intersect(Auto_LiftOver_eMERGE_PCs$New_ID, Data_Ark_Array$ALt_SNP2), Data_Ark_Array$ALt_SNP2),])
#153642      8
152951 + 153642
#306593
321334 - 306593
#14741
#14,741 snps lost from the liftover results and the data ark topmed imputed results
dim(Array[match(intersect(Auto_LiftOver_eMERGE_PCs$New_ID, Array$ID1), Array$ID1),])
#74942     8
dim(Array[match(intersect(Auto_LiftOver_eMERGE_PCs$New_ID, Array$ID2), Array$ID2),])
#74777     8
74942+74777
#149719
#Have to use imputed data to just have a larger portion of the variants retained
Info_File$CHRNUM <- gsub("chr", "", Info_File$chromosome)
head(Info_File$CHRNUM, 5)
Info_File$DIFF_ID1 <- gsub("chr", "", Info_File$alternate_ids)
head(Info_File$DIFF_ID1, 5)
Info_File$DIFF_ID2 <- paste(Info_File$CHRNUM, Info_File$position, Info_File$alleleA, Info_File$alleleB, sep=":")
Info_File$DIFF_ID3 <- paste(Info_File$CHRNUM, Info_File$position, Info_File$alleleB, Info_File$alleleA, sep=":")
dim(Info_File[match(intersect(Auto_LiftOver_eMERGE_PCs$New_ID, Info_File$DIFF_ID1), Info_File$DIFF_ID1),])
#152762     23
dim(Info_File[match(intersect(Auto_LiftOver_eMERGE_PCs$New_ID, Info_File$DIFF_ID2), Info_File$DIFF_ID2),])
#152762     23
dim(Info_File[match(intersect(Auto_LiftOver_eMERGE_PCs$New_ID, Info_File$DIFF_ID3), Info_File$DIFF_ID3),])
#152983     23
152762 + 152983
#305745
321334 - 305745
#15589
#The info file TopMed imputed has 15,589 snps lost, which is more than the data ark file
Fam_Data_Ark <- fread("/sc/arion/projects/data-ark/CBIPM/Microarray/combined/imputed_TOPMED_V2/plink/GSA_GDA_V2_TOPMED_HG38.fam")
dim(Fam_Data_Ark)
colnames(Fam_Data_Ark)
head(Fam_Data_Ark, 5)
rm(Fam_Data_Ark)#Can't use those fam ids unfortunately
dim(Info_File[match(intersect(Manual_LiftOver_eMERGE_PCs$NewID, Info_File$DIFF_ID1), Info_File$DIFF_ID1),])
#6 23
dim(Info_File[match(intersect(Manual_LiftOver_eMERGE_PCs$NewID, Info_File$DIFF_ID2), Info_File$DIFF_ID2),])
#6 23
dim(Info_File[match(intersect(Manual_LiftOver_eMERGE_PCs$NewID, Info_File$DIFF_ID3), Info_File$DIFF_ID3),])
#18 23
Manual_AddinA <- Info_File[match(intersect(Manual_LiftOver_eMERGE_PCs$NewID, Info_File$DIFF_ID2), Info_File$DIFF_ID2),]
Manual_AddinB <- Info_File[match(intersect(Manual_LiftOver_eMERGE_PCs$NewID, Info_File$DIFF_ID3), Info_File$DIFF_ID3),]
Auto_AddinA <- Info_File[match(intersect(Auto_LiftOver_eMERGE_PCs$New_ID, Info_File$DIFF_ID1), Info_File$DIFF_ID1),]
Auto_AddinB <- Info_File[match(intersect(Auto_LiftOver_eMERGE_PCs$New_ID, Info_File$DIFF_ID2), Info_File$DIFF_ID2),]
KeepforFlashPCA <- rbind(Auto_AddinA, Auto_AddinB, Manual_AddinA, Manual_AddinB)
colnames(Manual_LiftOver_eMERGE_PCs)
colnames(Auto_LiftOver_eMERGE_PCs)
Resubset_Liftover_AutoA <- Auto_LiftOver_eMERGE_PCs[match(intersect(KeepforFlashPCA$DIFF_ID1, Auto_LiftOver_eMERGE_PCs$New_ID), Auto_LiftOver_eMERGE_PCs$New_ID),]
Resubset_Liftover_AutoB <- Auto_LiftOver_eMERGE_PCs[match(intersect(KeepforFlashPCA$DIFF_ID2, Auto_LiftOver_eMERGE_PCs$New_ID), Auto_LiftOver_eMERGE_PCs$New_ID),]
Resubset_Liftover_ManualA <- Manual_LiftOver_eMERGE_PCs[match(intersect(KeepforFlashPCA$DIFF_ID1, Manual_LiftOver_eMERGE_PCs$NewID), Manual_LiftOver_eMERGE_PCs$NewID),]
Resubset_Liftover_ManualB <- Manual_LiftOver_eMERGE_PCs[match(intersect(KeepforFlashPCA$DIFF_ID2, Manual_LiftOver_eMERGE_PCs$NewID), Manual_LiftOver_eMERGE_PCs$NewID),]
dim(KeepforFlashPCA)
# 305548     23
#Need to add in the original id value so that the rest of the pcs can be subset for downstream analysis (this will link things and allow me to take the weights that were generated from the subset and move on from there)
dim(Resubset_Liftover_ManualA)
# 6 2
dim(Resubset_Liftover_ManualB)
# 6 2
V2_Resubset_Liftover_AutoA <- Resubset_Liftover_AutoA[,c("Original_ID", "New_ID")]
V2_Resubset_Liftover_AutoB <- Resubset_Liftover_AutoB[,c("Original_ID", "New_ID")]
summary(as.factor(KeepforFlashPCA$CHRNUM))
#All autosomes are covered by this snps used for the PCA
V2_Resubset_Liftover_AutoB <- Resubset_Liftover_AutoB[,c("New_ID", "Original_ID")]
V2_Resubset_Liftover_AutoA <- Resubset_Liftover_AutoA[,c("New_ID", "Original_ID")]
colnames(V2_Resubset_Liftover_AutoA) <- c("NewID", "OriginalID")
colnames(V2_Resubset_Liftover_AutoB) <- c("NewID", "OriginalID")
CombinedLiftOver <- rbind(V2_Resubset_Liftover_AutoA, V2_Resubset_Liftover_AutoB, Resubset_Liftover_ManualA, Resubset_Liftover_ManualB)
dim(CombinedLiftOver)
# 305536      2
dim(CombinedLiftOver[match(intersect(unique(CombinedLiftOver$OriginalID), CombinedLiftOver$OriginalID), CombinedLiftOver$OriginalID),])
# 152768      2
Kept_CombinedLiftOver <- CombinedLiftOver[match(intersect(unique(CombinedLiftOver$OriginalID), CombinedLiftOver$OriginalID), CombinedLiftOver$OriginalID),]
dim(KeepforFlashPCA[match(intersect(unique(KeepforFlashPCA$DIFF_ID1), KeepforFlashPCA$DIFF_ID1), KeepforFlashPCA$DIFF_ID1),])
# 152786     23
Kept_KeepforFlashPCA <- KeepforFlashPCA[match(intersect(unique(KeepforFlashPCA$DIFF_ID1), KeepforFlashPCA$DIFF_ID1), KeepforFlashPCA$DIFF_ID1),]
dim(Kept_KeepforFlashPCA)
# 152786     23
dim(Kept_KeepforFlashPCA[match(intersect(unique(Kept_CombinedLiftOver$NewID), Kept_KeepforFlashPCA$DIFF_ID1), Kept_KeepforFlashPCA$DIFF_ID1),])
# 152768     23
Kept_V2_KeepforFlashPCA <- Kept_KeepforFlashPCA[match(intersect(unique(Kept_CombinedLiftOver$NewID), Kept_KeepforFlashPCA$DIFF_ID1), Kept_KeepforFlashPCA$DIFF_ID1),]
dim(Kept_V2_KeepforFlashPCA)
# 152768     23
head(Kept_V2_KeepforFlashPCA$DIFF_ID1, 5)
head(Kept_CombinedLiftOver$NewID, 5)
Kept_V2_KeepforFlashPCA$OriginalID <- Kept_CombinedLiftOver$OriginalID
write.table(Kept_V2_KeepforFlashPCA, "FlashPCA_hg38_Subset_TopMed_Info_File_062525.txt", col.names=T, row.names=F, quote=F, sep="\t")
#Now to read in the other files for flashpca and update them
PC_Loadings_eMERGE <- fread("eMERGE_prs_adjustment_files_from_Chris_060425/eMERGE_prs_adjustment.pc.loadings")
dim(PC_Loadings_eMERGE)
# 321392      7
MeanSD_eMERGE <- fread("eMERGE_prs_adjustment_files_from_Chris_060425/eMERGE_prs_adjustment.pc.meansd")
dim(MeanSD_eMERGE)
# 321392      4
colnames(PC_Loadings_eMERGE)
colnames(MeanSD_eMERGE)
Reset_PC_Loadings_eMERGE <- PC_Loadings_eMERGE[match(intersect(Kept_V2_KeepforFlashPCA$OriginalID, PC_Loadings_eMERGE$SNP), PC_Loadings_eMERGE$SNP),]
Reset_MeanSD_eMERGE <- MeanSD_eMERGE[match(intersect(Kept_V2_KeepforFlashPCA$OriginalID, MeanSD_eMERGE$SNP), MeanSD_eMERGE$SNP),]
dim(Reset_PC_Loadings_eMERGE)
# 152768      7
dim(Reset_MeanSD_eMERGE)
# 152768      4
head(Reset_PC_Loadings_eMERGE$SNP, 5)
head(Kept_V2_KeepforFlashPCA$OriginalID, 5)
Reset_PC_Loadings_eMERGE$SNP <- Kept_V2_KeepforFlashPCA$DIFF_ID1
Reset_MeanSD_eMERGE$SNP <- Kept_V2_KeepforFlashPCA$DIFF_ID1
write.table(Reset_PC_Loadings_eMERGE, "Updated_hg38_intersects_BioMe_eMERGE_prs_adjustment.pc.loadings", col.names=T, row.names=F, quote=F, sep="\t")
write.table(Reset_MeanSD_eMERGE, "Updated_hg38_intersects_BioMe_eMERGE_prs_adjustment.pc.meansd", col.names=T, row.names=F, quote=F, sep="\t")
Reset_pc_sites_eMERGE <- Kept_V2_KeepforFlashPCA$DIFF_ID1
write.table(Reset_pc_sites_eMERGE, "Updated_hg38_intersects_BioMe_eMERGE_prs_adjustment.pc.sites", col.names=T, row.names=F, quote=F, sep="\t")
#Now to add in the same method of saving results but with the ids as rsids
Reset_PC_Loadings_eMERGE$SNP <- Kept_V2_KeepforFlashPCA$rsid
Reset_MeanSD_eMERGE$SNP <- Kept_V2_KeepforFlashPCA$rsid
write.table(Reset_PC_Loadings_eMERGE, "rsid_version_Updated_hg38_intersects_BioMe_eMERGE_prs_adjustment.pc.loadings", col.names=T, row.names=F, quote=F, sep="\t")
write.table(Reset_MeanSD_eMERGE, "rsid_version_Updated_hg38_intersects_BioMe_eMERGE_prs_adjustment.pc.meansd", col.names=T, row.names=F, quote=F, sep="\t")
q()
