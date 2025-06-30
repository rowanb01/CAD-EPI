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
PGC_Second_Travis_Catalog$Theta_var1 <- exp(Beta0_var + (Beta1_var*PGC_Second_Travis_Catalog$PC1) + (Beta2_var*PGC_Second_Travis_Catalog$PC2) + (Beta3_var*PGC_Second_Travis_Catalog$PC3) + (Beta4_var*PGC_Second_Travis_Catalog$PC4))
PGC_Second_Travis_Catalog$Theta_mu1 <- Beta0_mu + (Beta1_mu*PGC_Second_Travis_Catalog$PC1) + (Beta2_mu*PGC_Second_Travis_Catalog$PC2) + (Beta3_mu*PGC_Second_Travis_Catalog$PC3) + (Beta4_mu*PGC_Second_Travis_Catalog$PC4)
PGC_Second_Travis_Catalog$Readjusted_CAD_PRS <- (PGC_Second_Travis_Catalog$PGS003446 - PGC_Second_Travis_Catalog$Theta_mu1)/sqrt(PGC_Second_Travis_Catalog$Theta_var1)
summary(PGC_Second_Travis_Catalog$Readjusted_CAD_PRS)
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# -5.3251 -1.0819 -0.2437 -0.3707  0.5214  4.4279
dim(PGC_Second_Travis_Catalog[which(PGC_Second_Travis_Catalog$Readjusted_CAD_PRS > -5),])
# 41216  4844  
41220 - 41216
# 4
#Pipeline for CAD includes dropping samples with a z-score of -5 < z < +5; in this case this dropped 562 samples from use
PGC_Third_Travis_Catalog <- PGC_Second_Travis_Catalog[which(PGC_Second_Travis_Catalog$Readjusted_CAD_PRS > -5),]
summary(PGC_Third_Travis_Catalog$Readjusted_CAD_PRS)
#Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# -4.8860 -1.0816 -0.2435 -0.3702  0.5214  4.4279  
#Create density plots in comparison to the standard plot (also summary by ancestry)
ggplot(PGC_Third_Travis_Catalog, aes(x=Readjusted_CAD_PRS)) + geom_density()
savePlot("Combined_Travis_Ancestry_Density_Plot_063025.png")
ggplot(PGC_Third_Travis_Catalog, aes(x=Readjusted_CAD_PRS, color=Ancestry)) + geom_density()
summary(as.factor(PGC_Third_Travis_Catalog$Ancestry))
#  AFR   AMR   EAS   EUR   SAS 
# 10838 10870  1783 16214  1511
AFR_PGC_Third_Travis_Catalog <- PGC_Third_Travis_Catalog[which(PGC_Third_Travis_Catalog$Ancestry == "AFR"),]
AMR_PGC_Third_Travis_Catalog <- PGC_Third_Travis_Catalog[which(PGC_Third_Travis_Catalog$Ancestry == "AMR"),]
EUR_PGC_Third_Travis_Catalog <- PGC_Third_Travis_Catalog[which(PGC_Third_Travis_Catalog$Ancestry == "EUR"),]
EAS_PGC_Third_Travis_Catalog <- PGC_Third_Travis_Catalog[which(PGC_Third_Travis_Catalog$Ancestry == "EAS"),]
SAS_PGC_Third_Travis_Catalog <- PGC_Third_Travis_Catalog[which(PGC_Third_Travis_Catalog$Ancestry == "SAS"),]
summary(AFR_PGC_Third_Travis_Catalog$Readjusted_CAD_PRS)
#   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# -3.6373  0.0142  0.6326  0.6412  1.2466  3.8872  
summary(AMR_PGC_Third_Travis_Catalog$Readjusted_CAD_PRS)
#   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# -4.8860 -2.5103 -1.4506 -0.9929  0.5793  4.4279 
summary(EUR_PGC_Third_Travis_Catalog$Readjusted_CAD_PRS)
#   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# -3.1860 -0.7724 -0.3414 -0.3346  0.1066  2.2288
summary(EAS_PGC_Third_Travis_Catalog$Readjusted_CAD_PRS)
#   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#  -4.825  -3.272  -2.863  -2.868  -2.436  -1.005 
summary(SAS_PGC_Third_Travis_Catalog$Readjusted_CAD_PRS)
#   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# -2.6354 -0.9955 -0.5845 -0.5810 -0.1614  1.5664
#Check PC Plots
ggplot() + geom_point(data=PGC_Third_Travis_Catalog, aes(x=PC1,y=PC2, colour = Ancestry), size=3) + scale_colour_manual(values=c("#3E8E72",'#D6EADF','#EAC4D5', "#95B8D1", "#3F61A2"))+ theme_classic() + theme(panel.border = element_rect(colour = "black",size=1,fill=NA)) + xlab("PC1") + ylab("PC2") + theme(legend.title = element_blank())
savePlot("PC1_PC2_PGC_Third_Travis_Catalog_063025.png")
ggplot() + geom_point(data=PGC_Third_Travis_Catalog, aes(x=PC1,y=PC3, colour = Ancestry), size=3) + scale_colour_manual(values=c("#3E8E72",'#D6EADF','#EAC4D5', "#95B8D1", "#3F61A2"))+ theme_classic() + theme(panel.border = element_rect(colour = "black",size=1,fill=NA)) + xlab("PC1") + ylab("PC3") + theme(legend.title = element_blank())
savePlot("PC1_PC3_PGC_Third_Travis_Catalog_063025.png")
ggplot() + geom_point(data=PGC_Third_Travis_Catalog, aes(x=PC1,y=PC4, colour = Ancestry), size=3) + scale_colour_manual(values=c("#3E8E72",'#D6EADF','#EAC4D5', "#95B8D1", "#3F61A2"))+ theme_classic() + theme(panel.border = element_rect(colour = "black",size=1,fill=NA)) + xlab("PC1") + ylab("PC4") + theme(legend.title = element_blank())
savePlot("PC1_PC4_PGC_Third_Travis_Catalog_063025.png")
ggplot() + geom_point(data=PGC_Third_Travis_Catalog, aes(x=PC2,y=PC3, colour = Ancestry), size=3) + scale_colour_manual(values=c("#3E8E72",'#D6EADF','#EAC4D5', "#95B8D1", "#3F61A2"))+ theme_classic() + theme(panel.border = element_rect(colour = "black",size=1,fill=NA)) + xlab("PC2") + ylab("PC3") + theme(legend.title = element_blank())
savePlot("PC2_PC3_PGC_Third_Travis_Catalog_063025.png")
ggplot() + geom_point(data=PGC_Third_Travis_Catalog, aes(x=PC2,y=PC4, colour = Ancestry), size=3) + scale_colour_manual(values=c("#3E8E72",'#D6EADF','#EAC4D5', "#95B8D1", "#3F61A2"))+ theme_classic() + theme(panel.border = element_rect(colour = "black",size=1,fill=NA)) + xlab("PC2") + ylab("PC4") + theme(legend.title = element_blank())
savePlot("PC2_PC4_PGC_Third_Travis_Catalog_063025.png")
ggplot() + geom_point(data=PGC_Third_Travis_Catalog, aes(x=PC3,y=PC4, colour = Ancestry), size=3) + scale_colour_manual(values=c("#3E8E72",'#D6EADF','#EAC4D5', "#95B8D1", "#3F61A2"))+ theme_classic() + theme(panel.border = element_rect(colour = "black",size=1,fill=NA)) + xlab("PC3") + ylab("PC4") + theme(legend.title = element_blank())
savePlot("PC3_PC4_PGC_Third_Travis_Catalog_063025.png")
q()
