#The goal of this script is to try to produce a version of the extraction just for snps needed in FlashPCA
library(data.table)
Auto_LiftOver_eMERGE_PCs <- fread("Liftover_Results_eMERGE_SNPs_for_PCs_062025.csv")
Info_File <- fread("/sc/arion/projects/igh/data/MSM/data/common_variants/combined/batch_001/imputed_TOPMED/addition/info/GSA_GSX_INFO_TOPMED.txt")
Info_File$CHRNUM <- gsub("chr", "", Info_File$chromosome)
Info_File$DIFF_ID1 <- gsub("chr", "", Info_File$alternate_ids)
Info_File$DIFF_ID2 <- paste(Info_File$CHRNUM, Info_File$position, Info_File$alleleA, Info_File$alleleB, sep=":")
Info_File$DIFF_ID3 <- paste(Info_File$CHRNUM, Info_File$position, Info_File$alleleB, Info_File$alleleA, sep=":")
Auto_AddinA <- Info_File[match(intersect(Auto_LiftOver_eMERGE_PCs$New_ID, Info_File$DIFF_ID2), Info_File$DIFF_ID2),]
dim(Auto_AddinA)
#152762 23
Auto_AddinB <- Info_File[match(intersect(Auto_LiftOver_eMERGE_PCs$New_ID, Info_File$DIFF_ID3), Info_File$DIFF_ID3),]
dim(Auto_AddinB)
#152983 23
KeepforFlashPCA <- rbind(Auto_AddinA, Auto_AddinB)
dim(KeepforFlashPCA)
# 305745     23
Resubset_Liftover_AutoA <- Auto_LiftOver_eMERGE_PCs[match(intersect(KeepforFlashPCA$DIFF_ID2, Auto_LiftOver_eMERGE_PCs$New_ID), Auto_LiftOver_eMERGE_PCs$New_ID),]
Resubset_Liftover_AutoB <- Auto_LiftOver_eMERGE_PCs[match(intersect(KeepforFlashPCA$DIFF_ID3, Auto_LiftOver_eMERGE_PCs$New_ID), Auto_LiftOver_eMERGE_PCs$New_ID),]
V2_Resubset_Liftover_AutoA <- Resubset_Liftover_AutoA[,c("Original_ID", "New_ID")]
V2_Resubset_Liftover_AutoB <- Resubset_Liftover_AutoB[,c("Original_ID", "New_ID")]
CombinedLiftOver <- rbind(V2_Resubset_Liftover_AutoA, V2_Resubset_Liftover_AutoB)
dim(CombinedLiftOver[match(intersect(unique(CombinedLiftOver$New_ID), CombinedLiftOver$New_ID), CombinedLiftOver$New_ID),])
# 305745      2
dim(CombinedLiftOver)
# 305745      2
#Now to read in the other files for flashpca and update them
PC_Loadings_eMERGE <- fread("eMERGE_prs_adjustment_files_from_Chris_060425/eMERGE_prs_adjustment.pc.loadings")
dim(PC_Loadings_eMERGE)
# 321392      7
MeanSD_eMERGE <- fread("eMERGE_prs_adjustment_files_from_Chris_060425/eMERGE_prs_adjustment.pc.meansd")
dim(MeanSD_eMERGE)
# 321392      4
Reset_PC_Loadings_eMERGE <- PC_Loadings_eMERGE[match(intersect(CombinedLiftOver$Original_ID, PC_Loadings_eMERGE$SNP), PC_Loadings_eMERGE$SNP),]
dim(Reset_PC_Loadings_eMERGE)
# 305745      7
Reset_MeanSD_eMERGE <- MeanSD_eMERGE[match(intersect(CombinedLiftOver$Original_ID, MeanSD_eMERGE$SNP), MeanSD_eMERGE$SNP),]
dim(Reset_MeanSD_eMERGE)
# 305745      4
head(CombinedLiftOver_Intersect_InfoFile$Original_ID, 5)
# "1:773998:C:T" "1:846808:C:T" "1:852133:C:T" "1:855359:C:T" "1:879576:C:T"
head(Reset_PC_Loadings_eMERGE$SNP, 5)
# "1:773998:C:T" "1:846808:C:T" "1:852133:C:T" "1:855359:C:T" "1:879576:C:T"
head(Reset_MeanSD_eMERGE$SNP, 5)
# "1:773998:C:T" "1:846808:C:T" "1:852133:C:T" "1:855359:C:T" "1:879576:C:T"
#All the same size of true snps and has the same order
Reset_PC_Loadings_eMERGE$SNP <- CombinedLiftOver_Intersect_InfoFile$New_ID
Reset_MeanSD_eMERGE$SNP <- CombinedLiftOver_Intersect_InfoFile$New_ID
Newsites <- CombinedLiftOver_Intersect_InfoFile$New_ID
write.table(Reset_PC_Loadings_eMERGE, "Norsid_V2_hg38_intersects_BioMe_eMERGE_prs_adjustment.pc.loadings", col.names=T, row.names=F, quote=F, sep="\t")
write.table(Reset_MeanSD_eMERGE, "Norsid_V2_hg38_intersects_BioMe_eMERGE_prs_adjustment.pc.meansd", col.names=T, row.names=F, quote=F, sep="\t")
write.table(Newsites, "Norsid_V2_hg38_intersects_BioMe_eMERGE_prs_adjustment.pc.sites", col.names=F, row.names=F, quote=F, sep="\t")
write.table(CombinedLiftOver_Intersect_InfoFile, "Masterfile_for_FlashPCA_intersects_Info_File_062925.txt", col.names=T, row.names=F, quote=F, sep="\t")
q()

