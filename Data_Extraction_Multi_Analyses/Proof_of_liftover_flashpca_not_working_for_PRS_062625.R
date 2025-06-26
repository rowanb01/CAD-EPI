#Script shows that we cannot use the eMERGE algorithm for our phenotypes (we can still generate our own results based on the same PRS selected by the eMERGE algorightm)
library(data.table)
Main_Cohort <- fread("Travis_Ancestry_Matched_PostQC_Main_Cohort_062425.csv")
PGC_Catalog <- fread("/sc/private/regen/IPM-general/Kenny_Lab/MSM/pgsc/results/ALL_aggregated_scores.txt.gz")
dim(PGC_Catalog)
# 50518  4831
dim(Main_Cohort)
# 43804   173
dim(Main_Cohort[match(intersect(PGC_Catalog$IID, Main_Cohort$Individual.ID), Main_Cohort$Individual.ID),])
# 41478   173
#The drop is ~2k, which is reasonable
dim(PGC_Catalog[match(intersect(Main_Cohort$Individual.ID, PGC_Catalog$IID), PGC_Catalog$IID),])
# 41478  4831
#Stayed the same for the sample size which is a good start
New_PGC_Catalog <- PGC_Catalog[match(intersect(Main_Cohort$Individual.ID, PGC_Catalog$IID), PGC_Catalog$IID),]
dim(Main_Cohort[match(intersect(New_PGC_Catalog$IID, Main_Cohort$Individual.ID), Main_Cohort$Individual.ID),])
# 41478   173
#Stayed the same sample size, which is what we want
New_Main_Cohort <- Main_Cohort[match(intersect(New_PGC_Catalog$IID, Main_Cohort$Individual.ID), Main_Cohort$Individual.ID),]
dim(New_Main_Cohort)
# 41478   173
head(New_Main_Cohort$Individual.ID, 5)
head(New_PGC_Catalog$IID, 5)
#These are the same samples this time, which is another great sign
#Now to bring in the BioMe PCs that were projected from the eMERGE liftover PCs
BioME_Emerge_PCs <- fread("BioMe_Projections_062625")
dim(BioME_Emerge_PCs)
# 49859     7
colnames(BioME_Emerge_PCs)
head(BioME_Emerge_PCs$IID, 5)
#I need an extra stage of separating the BioMe IIDs and then go from there for seeing which ids overlap
New_PGC_Catalog$ProjectionID <- paste(New_PGC_Catalog$IID, New_PGC_Catalog$IID, sep="_")
dim(BioME_Emerge_PCs[match(intersect(New_PGC_Catalog$ProjectionID, BioME_Emerge_PCs$IID), BioME_Emerge_PCs$IID),])
# 41220     7
#Only lost ~200 samples, which is a nice lost all things considered
Updated_BioME_Emerge_PCs <- BioME_Emerge_PCs[match(intersect(New_PGC_Catalog$ProjectionID, BioME_Emerge_PCs$IID), BioME_Emerge_PCs$IID),]
Updated_New_PGC_Catalog <- New_PGC_Catalog[match(intersect(Updated_BioME_Emerge_PCs$IID, New_PGC_Catalog$ProjectionID), New_PGC_Catalog$ProjectionID),]
dim(Updated_New_PGC_Catalog)
# 41220  4832
#same sample size!
head(Updated_BioME_Emerge_PCs$IID, 5)
head(Updated_New_PGC_Catalog$ProjectionID, 5)
#These are the same samples
Updated_New_PGC_Catalog$PC1 <- Updated_BioME_Emerge_PCs$PC1
Updated_New_PGC_Catalog$PC2 <- Updated_BioME_Emerge_PCs$PC2
Updated_New_PGC_Catalog$PC3 <- Updated_BioME_Emerge_PCs$PC3
Updated_New_PGC_Catalog$PC4 <- Updated_BioME_Emerge_PCs$PC4
Test_PCs <- c(Updated_New_PGC_Catalog$PC1, Updated_New_PGC_Catalog$PC2, Updated_New_PGC_Catalog$PC3, Updated_New_PGC_Catalog$PC4)
#Enter in the training data betas for mu and var from the emerge dataset for CAD
Beta0_mu <- -10.302799265832947
Beta1_mu <- 47.75280019761359
Beta2_mu <- -142.1603090905824
Beta3_mu <- -66.88021262596445
Beta4_mu <- -2.7111266249134536
Beta0_var <- 5.552277872513402
Beta1_var <- -2.1048710664018953
Beta2_var <- -1.29692410171927
Beta3_var <- 2.0416512705051066
Beta4_var <- -1.199808278311739
#Now to make the vectors for mu and var matching the number of PCs (4)
Training_mu <- c(Beta1_mu, Beta2_mu, Beta3_mu, Beta4_mu)
Training_var <- c(Beta1_var, Beta2_var, Beta3_var, Beta4_var)
#Now for the dot product of the vectors between test pcs and the mu and var
StageA_mu <- sum(Test_PCs * Training_mu)
StageA_var <- sum(Test_PCs * Training_var)
Theta_mu <- Beta0_mu + StageA_mu
Theta_var <- exp(Beta0_var + StageA_var)
CAD_PRS_Readjusted_scores <- (Updated_New_PGC_Catalog$PGS003446 - Theta_mu)/sqrt(Theta_var)
summary(Updated_New_PGC_Catalog$PGS003446)
#    Min.  1st Qu.   Median     Mean  3rd Qu.     Max.
#-110.193  -23.384   -6.155  -11.661    5.912   79.331
#Unadjusted CAD PRS
summary(CAD_PRS_Readjusted_scores)
#   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
#      0       0       0       0       0       0
length(CAD_PRS_Readjusted_scores)
# 41220
#The adjusted score has an issue, since this should be something that has some values. The centering is correct at zero but it cannot all be 0
summary(as.factor(New_Main_Cohort$Est_Ethnicity))
#  AFR   AMR   EAS   EUR   SAS
#10881 10952  1797 16323  1525
#Will have to do work with flashpca on its own based on All of Us and BioMe data, where snps are matched between the 2 platforms and we go from there for generating the proper pcs. We will not be able to use eMERGE PRS because of the issues that occurred during liftover and settings with BioMe (FlashPCA needs exact snps and some of the snps could not be liftover even manually due to the way)
q()
