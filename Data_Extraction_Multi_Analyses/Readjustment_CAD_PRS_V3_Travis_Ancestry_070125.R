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
Travis_Projections <- fread("BioMe_Full_eMERGE_LiftOver_Travis_Ancestry_Projections_070125")
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
PGC_Second_Travis_Catalog$Theta_var1 <- exp(Beta0_var + (Beta1_var*PGC_Second_Travis_Catalog$PC1) + (Beta2_var*PGC_Second_Travis_Catalog$PC2) + (Beta3_var*PGC_Second_Travis_Catalog$PC3) + (Beta4_var*PGC_Second_Travis_Catalog$PC4))
PGC_Second_Travis_Catalog$Theta_mu1 <- Beta0_mu + (Beta1_mu*PGC_Second_Travis_Catalog$PC1) + (Beta2_mu*PGC_Second_Travis_Catalog$PC2) + (Beta3_mu*PGC_Second_Travis_Catalog$PC3) + (Beta4_mu*PGC_Second_Travis_Catalog$PC4)
PGC_Second_Travis_Catalog$Readjusted_CAD_PRS <- (PGC_Second_Travis_Catalog$PGS003446 - PGC_Second_Travis_Catalog$Theta_mu1)/sqrt(PGC_Second_Travis_Catalog$Theta_var1)
summary(PGC_Second_Travis_Catalog$Readjusted_CAD_PRS)
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# -3.80733 -0.37949  0.24750  0.02985  0.69349  3.37487 
#With 305745 snps together, we have the range of -5 < z < 5 for all the samples!
summary(PGC_Second_Travis_Catalog$PGS003446)
#    Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
#-110.193  -23.384   -6.155  -11.661    5.912   79.331 
#Definitely recalibrated things from the raw PRS
summary(as.factor(PGC_Second_Travis_Catalog$Ancestry))
#  AFR   AMR   EAS   EUR   SAS
#10838 10873  1784 16214  1511
AFR_PGC_Second_Travis_Catalog <- PGC_Second_Travis_Catalog[which(PGC_Second_Travis_Catalog$Ancestry == "AFR"),]
AMR_PGC_Second_Travis_Catalog <- PGC_Second_Travis_Catalog[which(PGC_Second_Travis_Catalog$Ancestry == "AMR"),]
EUR_PGC_Second_Travis_Catalog <- PGC_Second_Travis_Catalog[which(PGC_Second_Travis_Catalog$Ancestry == "EUR"),]
EAS_PGC_Second_Travis_Catalog <- PGC_Second_Travis_Catalog[which(PGC_Second_Travis_Catalog$Ancestry == "EAS"),]
SAS_PGC_Second_Travis_Catalog <- PGC_Second_Travis_Catalog[which(PGC_Second_Travis_Catalog$Ancestry == "SAS"),]
summary(AFR_PGC_Second_Travis_Catalog$Readjusted_CAD_PRS)
#   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
#-2.9832 -0.1362  0.3489  0.3541  0.8319  2.8812
summary(AMR_PGC_Second_Travis_Catalog$Readjusted_CAD_PRS)
#   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
#-3.8073 -1.6331 -0.7328 -0.5092  0.6453  3.3749
summary(EUR_PGC_Second_Travis_Catalog$Readjusted_CAD_PRS)
#   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
#-1.6219  0.1331  0.4133  0.4207  0.7068  2.1484
summary(EAS_PGC_Second_Travis_Catalog$Readjusted_CAD_PRS)
#   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
# -3.426  -2.348  -2.098  -2.095  -1.817  -0.890
summary(SAS_PGC_Second_Travis_Catalog$Readjusted_CAD_PRS)
#   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
#-1.5014 -0.3652 -0.1059 -0.1021  0.1682  1.2869
#Only one super off is the EAS in terms of centering. The rest have nice output
ggplot(PGC_Second_Travis_Catalog, aes(x=Readjusted_CAD_PRS)) + geom_density()
savePlot("Combined_Travis_Ancestry_Density_Plot_070125.png")
ggplot(PGC_Second_Travis_Catalog, aes(x=Readjusted_CAD_PRS, color=Ancestry)) + geom_density()
savePlot("Ancestry_Specific_Travis_Ancestry_Density_Plot_070125.png")
ggplot(PGC_Second_Travis_Catalog, aes(x=Readjusted_CAD_PRS)) + geom_density()
ggplot(PGC_Second_Travis_Catalog, aes(x=PGS003446)) + geom_density()
savePlot("Combined_Travis_Ancestry_Raw_PRS_Density_Plot_070125.png")
ggplot(PGC_Second_Travis_Catalog, aes(x=PGS003446, color=Ancestry)) + geom_density()
savePlot("Ancestry_Specific_Raw_PRS_Density_Plot_070125.png")
ggplot() + geom_point(data=PGC_Second_Travis_Catalog, aes(x=PC1,y=PC2, colour = Ancestry), size=3) + scale_colour_manual(values=c("#3E8E72",'#D6EADF','#EAC4D5', "#95B8D1", "#3F61A2"))+ theme_classic() + theme(panel.border = element_rect(colour = "black",size=1,fill=NA)) + xlab("PC1") + ylab("PC2") + theme(legend.title = element_blank())
savePlot("PC1_PC2_PGC_Second_Travis_Catalog_070125.png")
ggplot() + geom_point(data=PGC_Second_Travis_Catalog, aes(x=PC1,y=PC3, colour = Ancestry), size=3) + scale_colour_manual(values=c("#3E8E72",'#D6EADF','#EAC4D5', "#95B8D1", "#3F61A2"))+ theme_classic() + theme(panel.border = element_rect(colour = "black",size=1,fill=NA)) + xlab("PC1") + ylab("PC3") + theme(legend.title = element_blank())
savePlot("PC1_PC3_PGC_Second_Travis_Catalog_070125.png")
ggplot() + geom_point(data=PGC_Second_Travis_Catalog, aes(x=PC1,y=PC4, colour = Ancestry), size=3) + scale_colour_manual(values=c("#3E8E72",'#D6EADF','#EAC4D5', "#95B8D1", "#3F61A2"))+ theme_classic() + theme(panel.border = element_rect(colour = "black",size=1,fill=NA)) + xlab("PC1") + ylab("PC4") + theme(legend.title = element_blank())
savePlot("PC1_PC4_PGC_Second_Travis_Catalog_070125.png")
ggplot() + geom_point(data=PGC_Second_Travis_Catalog, aes(x=PC2,y=PC3, colour = Ancestry), size=3) + scale_colour_manual(values=c("#3E8E72",'#D6EADF','#EAC4D5', "#95B8D1", "#3F61A2"))+ theme_classic() + theme(panel.border = element_rect(colour = "black",size=1,fill=NA)) + xlab("PC2") + ylab("PC3") + theme(legend.title = element_blank())
savePlot("PC2_PC3_PGC_Second_Travis_Catalog_070125.png")
ggplot() + geom_point(data=PGC_Second_Travis_Catalog, aes(x=PC2,y=PC4, colour = Ancestry), size=3) + scale_colour_manual(values=c("#3E8E72",'#D6EADF','#EAC4D5', "#95B8D1", "#3F61A2"))+ theme_classic() + theme(panel.border = element_rect(colour = "black",size=1,fill=NA)) + xlab("PC2") + ylab("PC4") + theme(legend.title = element_blank())
savePlot("PC2_PC4_PGC_Second_Travis_Catalog_070125.png")
ggplot() + geom_point(data=PGC_Second_Travis_Catalog, aes(x=PC3,y=PC4, colour = Ancestry), size=3) + scale_colour_manual(values=c("#3E8E72",'#D6EADF','#EAC4D5', "#95B8D1", "#3F61A2"))+ theme_classic() + theme(panel.border = element_rect(colour = "black",size=1,fill=NA)) + xlab("PC3") + ylab("PC4") + theme(legend.title = element_blank())
savePlot("PC3_PC4_PGC_Second_Travis_Catalog_070125.png")
#That was disappointing with the PCs that were generated, which were better with older versions of the data
q()
