#Goal of script is to genrate files that have the same snps used for flashpca
library(data.table)
FlashPCA <- fread("FlashPCA_hg38_Subset_TopMed_Info_File_062525.txt")
dim(FlashPCA)
#152768     24
dim(FlashPCA[match(intersect(unique(FlashPCA$rsid), FlashPCA$rsid), FlashPCA$rsid),])
#152753     24
summary(as.factor(FlashPCA$CHRNUM))
dim(FlashPCA[which(FlashPCA$rsid != "."),])
#152752     24
No_Missing_RSIDs <- FlashPCA[which(FlashPCA$rsid != "."),]
dim(No_Missing_RSIDs)
#152752     24
write.table(No_Missing_RSIDs, "Unique_rsids_FlashPCA_hg38_Subset_TopMed_Info_File_062525.txt", col.names=T, row.names=F, quote=T, sep="\t")
NewRSIDList <- No_Missing_RSIDs$rsid
write.table(NewRSIDList, "Extract_rsids_for_CAD_062525.txt", col.names=F, row.names=F, quote=F, sep="\t")
write.table(No_Missing_RSIDs, "Unique_rsids_FlashPCA_hg38_Subset_TopMed_Info_File_062525.txt", col.names=T, row.names=F, quote=F, sep="\t")
summary(as.factor(No_Missing_RSIDs$CHRNUM))
dim(No_Missing_RSIDs[match(intersect(unique(No_Missing_RSIDs$rsid), No_Missing_RSIDs$rsid), No_Missing_RSIDs$rsid),])
#152752     24
Merged_Autosome_File <- fread("Autosome_Binary_CAD_for_FlashPCA_062625.bim")
dim(Merged_Autosome_File)
#151847      6
colnames(Merged_Autosome_File)
dim(No_Missing_RSIDs[match(intersect(Merged_Autosome_File$V2, No_Missing_RSIDs$rsid), No_Missing_RSIDs$rsid),])
#151847     24
Worked_for_Merging_FlashPCA <- No_Missing_RSIDs[match(intersect(Merged_Autosome_File$V2, No_Missing_RSIDs$rsid), No_Missing_RSIDs$rsid),]
MeanSD_Pre <- fread("rsid_version_Updated_hg38_intersects_BioMe_eMERGE_prs_adjustment.pc.meansd")
Loadings_Pre <- fread("rsid_version_Updated_hg38_intersects_BioMe_eMERGE_prs_adjustment.pc.loadings")
Loadings_Post <- Loadings_Pre[match(intersect(Worked_for_Merging_FlashPCA$rsid, Loadings_Pre$SNP), Loadings_Pre$SNP),]
dim(Loadings_Post)
#151847      7
dim(MeanSD_Post)
#151847      4
dim(Worked_for_Merging_FlashPCA)
#151847     24
write.table(Loadings_Post, "Proper_rsid_version_Updated_hg38_intersects_BioMe_eMERGE_prs_adjustment.pc.loadings", col.names=T, row.names=F, quote=F, sep="\t")
write.table(MeanSD_Post, "Proper_rsid_version_Updated_hg38_intersects_BioMe_eMERGE_prs_adjustment.pc.meansd", col.names=T, row.names=F, quote=F, sep="\t")
Proper_sites <- Worked_for_Merging_FlashPCA$rsid
write.table(Proper_sites, "Proper_rsid_version_Updated_hg38_intersects_BioMe_eMERGE_prs_adjustment.pc.sites", col.names=F, row.names=F, quote=F, sep="\t")
q()
