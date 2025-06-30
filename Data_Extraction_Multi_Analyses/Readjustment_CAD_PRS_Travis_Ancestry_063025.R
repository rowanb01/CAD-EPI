#Goal of this script is to generate the CAD flashPCA based results for PRS adjustment
library(data.table)
library(ggplot2)
Travis_Ancestry <- fread("Travis_Ancestry_Matched_PostQC_Main_Cohort_062425.csv")
PGC_Catalog <- fread("/sc/private/regen/IPM-general/Kenny_Lab/MSM/pgsc/results/ALL_aggregated_scores.txt.gz")
dim(Travis_Ancestry)
#43804   173
dim(PGC_Catalog)
#50518  4831
Travis_Catalog_Subset <- Travis_Ancestry[match(intersect(PGC_Catalog$IID, Travis_Ancestry$ID_1), Travis_Ancestry$ID_1),]
PGC_Travis_Catalog <- PGC_Catalog[match(intersect(Travis_Catalog_Subset$ID_1, PGC_Catalog$IID), PGC_Catalog$IID),]
dim(PGC_Travis_Catalog)
# 41478  4831
dim(Travis_Catalog_Subset)
# 41478   173
Travis_Projections <- fread("BioMe_Travis_Ancestry_Projections_062925")
dim(Travis_Projections)
# 43534     7
colnames(Travis_Projections)
Travis_Catalog_Subset$NewID <- paste(Travis_Catalog_Subset$ID_1, Travis_Catalog_Subset$ID_1, sep="_")
Subset_Travis_Projections <- Travis_Projections[match(intersect(Travis_Catalog_Subset$NewID, Travis_Projections$IID), Travis_Projections$IID),]
dim(Subset_Travis_Projections)
# 41220     7
#Only a loss of 258 samples, which is acceptable
Travis_Second_Subset_Catalog <- Travis_Catalog_Subset[match(intersect(Subset_Travis_Projections$IID, Travis_Catalog_Subset$NewID), Travis_Catalog_Subset$NewID),]
dim(Travis_Second_Subset_Catalog)
# 41220   174
PGC_Second_Travis_Catalog <- PGC_Travis_Catalog[match(intersect(Travis_Second_Subset_Catalog$ID_1, PGC_Travis_Catalog$IID), PGC_Travis_Catalog$IID),]
dim(PGC_Second_Travis_Catalog)
head(PGC_Second_Travis_Catalog$IID, 5)
head(Subset_Travis_Projections$IID, 5)
head(PGC_Second_Travis_Catalog$IID, 5)
#All are in the same order, which is key
PGC_Second_Travis_Catalog$Ancestry <- Travis_Second_Subset_Catalog$Est_Ethnicity
PGC_Second_Travis_Catalog$PC1 <- Subset_Travis_Projections$PC1
PGC_Second_Travis_Catalog$PC2 <- Subset_Travis_Projections$PC2
PGC_Second_Travis_Catalog$PC3 <- Subset_Travis_Projections$PC3
PGC_Second_Travis_Catalog$PC4 <- Subset_Travis_Projections$PC4
PGC_Second_Travis_Catalog$PC5 <- Subset_Travis_Projections$PC5
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
#Setup the equation to recalibrate the PRS
PGC_Second_Travis_Catalog$Theta_var1 <- (Beta1_var*PGC_Second_Travis_Catalog$PC1) + (Beta1_var*PGC_Second_Travis_Catalog$PC2) + (Beta1_var*PGC_Second_Travis_Catalog$PC3) + (Beta1_var*PGC_Second_Travis_Catalog$PC4)
PGC_Second_Travis_Catalog$Theta_var2 <- (Beta2_var*PGC_Second_Travis_Catalog$PC1) + (Beta2_var*PGC_Second_Travis_Catalog$PC2) + (Beta2_var*PGC_Second_Travis_Catalog$PC3) + (Beta2_var*PGC_Second_Travis_Catalog$PC4)
PGC_Second_Travis_Catalog$Theta_var3 <- (Beta3_var*PGC_Second_Travis_Catalog$PC1) + (Beta3_var*PGC_Second_Travis_Catalog$PC2) + (Beta3_var*PGC_Second_Travis_Catalog$PC3) + (Beta3_var*PGC_Second_Travis_Catalog$PC4)
PGC_Second_Travis_Catalog$Theta_var4 <- (Beta4_var*PGC_Second_Travis_Catalog$PC1) + (Beta4_var*PGC_Second_Travis_Catalog$PC2) + (Beta4_var*PGC_Second_Travis_Catalog$PC3) + (Beta4_var*PGC_Second_Travis_Catalog$PC4)
PGC_Second_Travis_Catalog$Theta_varSum <- PGC_Second_Travis_Catalog$Theta_var1 + PGC_Second_Travis_Catalog$Theta_var2 + PGC_Second_Travis_Catalog$Theta_var3 + PGC_Second_Travis_Catalog$Theta_var4
PGC_Second_Travis_Catalog$Theta_varComplete <- exp(Beta0_var + PGC_Second_Travis_Catalog$Theta_varSum)
PGC_Second_Travis_Catalog$Theta_mu1 <- (Beta1_mu*PGC_Second_Travis_Catalog$PC1) + (Beta1_mu*PGC_Second_Travis_Catalog$PC2) + (Beta1_mu*PGC_Second_Travis_Catalog$PC3) + (Beta1_mu*PGC_Second_Travis_Catalog$PC4)
PGC_Second_Travis_Catalog$Theta_mu2 <- (Beta2_mu*PGC_Second_Travis_Catalog$PC1) + (Beta2_mu*PGC_Second_Travis_Catalog$PC2) + (Beta2_mu*PGC_Second_Travis_Catalog$PC3) + (Beta2_mu*PGC_Second_Travis_Catalog$PC4)
PGC_Second_Travis_Catalog$Theta_mu3 <- (Beta3_mu*PGC_Second_Travis_Catalog$PC1) + (Beta3_mu*PGC_Second_Travis_Catalog$PC2) + (Beta3_mu*PGC_Second_Travis_Catalog$PC3) + (Beta3_mu*PGC_Second_Travis_Catalog$PC4)
PGC_Second_Travis_Catalog$Theta_mu4 <- (Beta4_mu*PGC_Second_Travis_Catalog$PC1) + (Beta4_mu*PGC_Second_Travis_Catalog$PC2) + (Beta4_mu*PGC_Second_Travis_Catalog$PC3) + (Beta4_mu*PGC_Second_Travis_Catalog$PC4)
PGC_Second_Travis_Catalog$Theta_muSum <- PGC_Second_Travis_Catalog$Theta_mu1 + PGC_Second_Travis_Catalog$Theta_mu2 + PGC_Second_Travis_Catalog$Theta_mu3 + PGC_Second_Travis_Catalog$Theta_mu4
PGC_Second_Travis_Catalog$Theta_muComplete <- Beta0_mu + PGC_Second_Travis_Catalog$Theta_muSum
PGC_Second_Travis_Catalog$Readjusted_CAD_PRS <- (PGC_Second_Travis_Catalog$PGS003446 - PGC_Second_Travis_Catalog$Theta_muSum)/sqrt(PGC_Second_Travis_Catalog$Theta_varComplete)
summary(PGC_Second_Travis_Catalog$Readjusted_CAD_PRS)
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# -6.922  -2.893  -1.993  -2.206  -1.412   2.015 
dim(PGC_Second_Travis_Catalog[which(PGC_Second_Travis_Catalog$Readjusted_CAD_PRS > -5),])
# 40658  4844  
41220 - 40658
# 562 
#Pipeline for CAD includes dropping samples with a z-score of -5 < z < +5; in this case this dropped 562 samples from use
PGC_Third_Travis_Catalog <- PGC_Second_Travis_Catalog[which(PGC_Second_Travis_Catalog$Readjusted_CAD_PRS > -5),]
summary(PGC_Third_Travis_Catalog$Readjusted_CAD_PRS)
#Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# -5.000  -2.835  -1.977  -2.162  -1.403   2.015 
#Create density plots in comparison to the standard plot (also summary by ancestry)
ggplot(PGC_Third_Travis_Catalog, aes(x=Readjusted_CAD_PRS)) + geom_density()
savePlot("Combined_Travis_Ancestry_Density_Plot_063025.png")
ggplot(PGC_Third_Travis_Catalog, aes(x=Readjusted_CAD_PRS, color=Ancestry)) + geom_density()
summary(as.factor(PGC_Third_Travis_Catalog$Ancestry))
#  AFR   AMR   EAS   EUR   SAS 
#10833 10463  1637 16214  1511 
AFR_PGC_Third_Travis_Catalog <- PGC_Third_Travis_Catalog[which(PGC_Third_Travis_Catalog$Ancestry == "AFR"),]
AMR_PGC_Third_Travis_Catalog <- PGC_Third_Travis_Catalog[which(PGC_Third_Travis_Catalog$Ancestry == "AMR"),]
EUR_PGC_Third_Travis_Catalog <- PGC_Third_Travis_Catalog[which(PGC_Third_Travis_Catalog$Ancestry == "EUR"),]
EAS_PGC_Third_Travis_Catalog <- PGC_Third_Travis_Catalog[which(PGC_Third_Travis_Catalog$Ancestry == "EAS"),]
SAS_PGC_Third_Travis_Catalog <- PGC_Third_Travis_Catalog[which(PGC_Third_Travis_Catalog$Ancestry == "SAS"),]
summary(AFR_PGC_Third_Travis_Catalog$Readjusted_CAD_PRS)
#   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# -4.9603 -2.9743 -2.4221 -2.3962 -1.8419  0.6915  
summary(AMR_PGC_Third_Travis_Catalog$Readjusted_CAD_PRS)
#   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# -4.999  -3.762  -2.725  -2.562  -1.426   2.015 
summary(EUR_PGC_Third_Travis_Catalog$Readjusted_CAD_PRS)
#   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# -4.2216 -1.9940 -1.6279 -1.6220 -1.2488  0.5374
summary(EAS_PGC_Third_Travis_Catalog$Readjusted_CAD_PRS)
#   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#  -5.000  -4.463  -4.121  -4.082  -3.731  -2.362 
summary(SAS_PGC_Third_Travis_Catalog$Readjusted_CAD_PRS)
#   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# -3.664  -1.799  -1.432  -1.431  -1.053   0.575
q()
