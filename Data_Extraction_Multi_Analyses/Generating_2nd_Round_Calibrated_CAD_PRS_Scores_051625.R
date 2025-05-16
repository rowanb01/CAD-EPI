#The goal of this script is to check the samples all align and then to perform the adjustments from the All of Us workspace for this dataset in general
library(data.table)
Main_Cohort <- fread("Main_Cohort_Adults_050225.csv")
PGC_Catalog <- fread("/sc/private/regen/IPM-general/Kenny_Lab/MSM/pgsc/results/ALL_aggregated_scores.txt.gz")
Sinead_PCA <- fread("/sc/private/regen/IPM-general/Kenny_Lab/MSM_QC_v2/pcs/MSM_1KGP_HGDP_pca.eigenvec")
dim(Sinead_PCA)
# 58427    12
dim(PGC_Catalog)
# 50518  4831
dim(Main_Cohort)
# 51636   172
length(unique(Main_Cohort))
# 172
length(unique(Main_Cohort$ID_1))
# 50161
length(unique(Main_Cohort$masked_mrn))
# 50161
#Now we have proper numbers and know to remove the numbers that are lacking for the length of thte dataframe for Main_Cohort
Remaining_PGC_Catalog_Main_Cohort_Subset <- PGC_Catalog[match(intersect(Main_Cohort$ID_1, PGC_Catalog$IID), PGC_Catalog$IID),] 
dim(Remaining_PGC_Catalog_Main_Cohort_Subset)
# 43413  4831
#This matches previous script info, which is the goal
dim(Remaining_PGC_Catalog_Main_Cohort_Subset[match(intersect(Sinead_PCA$IID, Remaining_PGC_Catalog_Main_Cohort_Subset$IID), Remaining_PGC_Catalog_Main_Cohort_Subset$IID)])
# 43145  4831
#Drops sample size from 43,413 participants to 43,145 participants
Kept_PCs <- Sinead_PCA[match(intersect(Remaining_PGC_Catalog_Main_Cohort_Subset$IID, Sinead_PCA$IID), Sinead_PCA$IID),]
dim(Kept_PCs)
# 43145    12
#Matches the previous dimensions of Sinead_PCA subset
Renewed_PGC_Catalog_Main_Cohort_Subset <- Remaining_PGC_Catalog_Main_Cohort_Subset[match(intersect(Kept_PCs$IID, Remaining_PGC_Catalog_Main_Cohort_Subset$IID), Remaining_PGC_Catalog_Main_Cohort_Subset$IID),]
dim(Renewed_PGC_Catalog_Main_Cohort_Subset)
# 43145  4831
#Now it matches the rows for Kept_PCs
head(Renewed_PGC_Catalog_Main_Cohort_Subset$IID, 5)
head(Kept_PCs$IID, 5)
#Can add the PCs since the order is the same
Renewed_PGC_Catalog_Main_Cohort_Subset$PC1 <- Kept_PCs$PC1
Renewed_PGC_Catalog_Main_Cohort_Subset$PC2 <- Kept_PCs$PC2
Renewed_PGC_Catalog_Main_Cohort_Subset$PC3 <- Kept_PCs$PC3
Renewed_PGC_Catalog_Main_Cohort_Subset$PC4 <- Kept_PCs$PC4
Renewed_PGC_Catalog_Main_Cohort_Subset$PC5 <- Kept_PCs$PC5
Renewed_PGC_Catalog_Main_Cohort_Subset$PC6 <- Kept_PCs$PC6
Renewed_PGC_Catalog_Main_Cohort_Subset$PC7 <- Kept_PCs$PC7
Renewed_PGC_Catalog_Main_Cohort_Subset$PC8 <- Kept_PCs$PC8
Renewed_PGC_Catalog_Main_Cohort_Subset$PC9 <- Kept_PCs$PC9
Renewed_PGC_Catalog_Main_Cohort_Subset$PC10 <- Kept_PCs$PC10
#Next is to set up data for the dot products of the test data (BioMe) PCs with the training data weights for betas of mu and betas of variance 
#The intercepts were also already calculated from the training data and the adjustments will be made based on the dot product of m and the dot product of var added to the intercept of mu and the intercept of var (var has an additional step of exponeniating the sum)
summary(Remaining_PGC_Catalog_Main_Cohort_Subset$PGS003446)
#    Min.  1st Qu.   Median     Mean  3rd Qu.     Max.
# -110.193  -22.687   -5.929  -11.179    6.187   79.331
#Thankfully there is no missingness for this PRS result
#The above PRS is the CAD PRS
summary(Renewed_PGC_Catalog_Main_Cohort_Subset$PGS003446)
#  Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
# -110.193  -22.637   -5.929  -11.190    6.167   79.331 
#Extremely similar to Remaining_PGC_Catalog_Main_Cohort_Subset for the CAD PRS summary, meaning the loss of samples did not drastically alter the results
#Will also follow equations for generating the new mu and new variance based on equations found in paper from emerge on the 10 PRS
Test_PCs <- c(Renewed_PGC_Catalog_Main_Cohort_Subset$PC1, Renewed_PGC_Catalog_Main_Cohort_Subset$PC2, Renewed_PGC_Catalog_Main_Cohort_Subset$PC3, Renewed_PGC_Catalog_Main_Cohort_Subset$PC4)
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
CAD_PRS_adjusted_scores <- (Renewed_PGC_Catalog_Main_Cohort_Subset$PGS003446 - Theta_mu)/sqrt(Theta_var)
typeof(CAD_PRS_adjusted_scores)
# "double"
summary(CAD_PRS_adjusted_scores)
#   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
#   -9.428  -7.602  -7.254  -7.363  -7.001  -5.476 
length(CAD_PRS_adjusted_scores)
# 43145
#This is the new calculation based on the 2nd attempt of figuring out the adjusted PRS results
#Will have chart of the summary of results before and after the transformation as well as the histograms of before and after the transformation for CAD
hist(Renewed_PGC_Catalog_Main_Cohort_Subset$PGS003446, main="CAD PRS of BioMe Samples A")
hist(CAD_PRS_adjusted_scores, main="CAD Adjusted PRS of BioMe Samples A")
q()
