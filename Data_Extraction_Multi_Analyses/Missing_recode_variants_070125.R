#The goal of this script is to extract what was not pushed through in snps from the eMERGE snps
library(data.table)
PCloadings <- fread("Norsid_V2_hg38_intersects_BioMe_eMERGE_prs_adjustment.pc.loadings")
dim(PCloadings)
#305745      7
head(PCloadings, 5)
Loadings_Split <- data.frame(do.call(rbind, strsplit(PCloadings$SNP, ":")))
dim(Loadings_Split)
#305745      4
colnames(Loadings_Split) <- c("CHR", "POS", "A1", "A2")
Loadings_Split$CHR <- as.numeric(Loadings_Split$CHR)
Loadings_Split$POS <- as.numeric(Loadings_Split$POS)
dim(Loadings_Split)
#305745      4
colnames(Loadings_Split) <- c("CHR", "POS", "A1", "A2")
Loadings_Split$CHR <- as.numeric(Loadings_Split$CHR)
Loadings_Split$POS <- as.numeric(Loadings_Split$POS)
Reloaded <- cbind(PCloadings,Loadings_Split)
dim(Reloaded)
#305745     11
Chr22_Extract <- Reloaded[which(Reloaded$CHR == 22),]
dim(Chr22_Extract)
#4700   11
NotPulled_chr22 <- Chr22_Extract[match(setdiff(Chr22_Extract$SNP, ActuallyPulled_chr22$SNP), Chr22_Extract$SNP),]
dim(NotPulled_chr22)
#2311   11
#Perfect, these are the snps that are not pulled from chromosome 22 for a smaller subset to fix
Missing_chr22 <- NotPulled_chr22$SNP
write.table(Missing_chr22, "Not_Pulled_chr22_070125.txt", col.names=F, row.names=F, quote=F, sep="\t")
#Now to use this process for all of the snps that are missing from the eMerge PCs that were found with liftover
Full_Autosome_Actually_Pulled <- fread("Autosome_Sinead_Race_Ethnicity_Binary_CAD_for_FlashPCA_Stage2_063025.bim")
dim(Full_Autosome_Actually_Pulled)
# 152762      6
colnames(Full_Autosome_Actually_Pulled)
colnames(Full_Autosome_Actually_Pulled) <- c("CHR", "SNP", "CM", "POS", "A1", "A2")
Notpulled_Full <- Reloaded[match(setdiff(Reloaded$SNP, Full_Autosome_Actually_Pulled$SNP), Reloaded$SNP),]
dim(Notpulled_Full)
# 152983     11
Full_NotPulled_List <- Notpulled_Full$SNP
write.table(Full_NotPulled_List, "Notpulled_Full_Autosome_eMERGE_LiftOver_Sites_List_0701225.txt", col.names=F, row.names=F, quote=F, sep="\t")
q()
