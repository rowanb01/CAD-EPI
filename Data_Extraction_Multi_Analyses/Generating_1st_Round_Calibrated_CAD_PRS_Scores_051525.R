#The goal of this script is to check the samples all align and then to perform the adjustments from the All of Us workspace for this dataset in general
library(data.table)
Main_Cohort <- fread("Main_Cohort_Adults_050225.csv")
PGC_Catalog <- fread("/sc/private/regen/IPM-general/Kenny_Lab/MSM/pgsc/results/ALL_aggregated_scores.txt.gz")
PCs_Kept <- fread("PCs_Genotype_For_New_PC_Generation_Genotype_Data_1st_Round_051525.eigenvec")
dim(PCs_Kept)
# 58386    12
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
dim(Remaining_PGC_Catalog_Main_Cohort_Subset[match(intersect(PCs_Kept$IID, Remaining_PGC_Catalog_Main_Cohort_Subset$IID), Remaining_PGC_Catalog_Main_Cohort_Subset$IID)])
# 43413  4831
#Wonderful! All of the samples are retained in the match set, instead of losing the additional 10k samples as shown from the previous run
Kept_PCs <- PCs_Kept[match(intersect(Remaining_PGC_Catalog_Main_Cohort_Subset$IID, PCs_Kept$IID), PCs_Kept$IID),]
dim(Kept_PCs)
# 43413    12
head(Remaining_PGC_Catalog_Main_Cohort_Subset$IID, 5)
head(Kept_PCs$IID, 5)
#since the order of the participants are the same, add in the PCs
Remaining_PGC_Catalog_Main_Cohort_Subset$PC1 <- Kept_PCs$PC1
Remaining_PGC_Catalog_Main_Cohort_Subset$PC2 <- Kept_PCs$PC2
Remaining_PGC_Catalog_Main_Cohort_Subset$PC3 <- Kept_PCs$PC3
Remaining_PGC_Catalog_Main_Cohort_Subset$PC4 <- Kept_PCs$PC4
Remaining_PGC_Catalog_Main_Cohort_Subset$PC5 <- Kept_PCs$PC5
Remaining_PGC_Catalog_Main_Cohort_Subset$PC6 <- Kept_PCs$PC6
Remaining_PGC_Catalog_Main_Cohort_Subset$PC7 <- Kept_PCs$PC7
Remaining_PGC_Catalog_Main_Cohort_Subset$PC8 <- Kept_PCs$PC8
Remaining_PGC_Catalog_Main_Cohort_Subset$PC9 <- Kept_PCs$PC9
Remaining_PGC_Catalog_Main_Cohort_Subset$PC10 <- Kept_PCs$PC10
#Next is to set up data for the dot products of the test data (BioMe) PCs with the training data weights for betas of mu and betas of variance 
#The intercepts were also already calculated from the training data and the adjustments will be made based on the dot product of m and the dot product of var added to the intercept of mu and the intercept of var (var has an additional step of exponeniating the sum)
summary(Remaining_PGC_Catalog_Main_Cohort_Subset$PGS003446)
#    Min.  1st Qu.   Median     Mean  3rd Qu.     Max.
# -110.193  -22.687   -5.929  -11.179    6.187   79.331
#Thankfully there is no missingness for this PRS result
#The above PRS is the CAD PRS
#Will also follow equations for generating the new mu and new variance based on equations found in paper from emerge on the 10 PRS
Test_PCs <- c(Remaining_PGC_Catalog_Main_Cohort_Subset$PC1, Remaining_PGC_Catalog_Main_Cohort_Subset$PC2, Remaining_PGC_Catalog_Main_Cohort_Subset$PC3, Remaining_PGC_Catalog_Main_Cohort_Subset$PC4)
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
CAD_PRS_adjusted_scores <- (Remaining_PGC_Catalog_Main_Cohort_Subset$PGS003446 - Theta_mu)/sqrt(Theta_var)
typeof(CAD_PRS_adjusted_scores)
# "double"
summary(CAD_PRS_adjusted_scores)
#   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
#  17959   19800   20152   20042   20407   21946
length(CAD_PRS_adjusted_scores)
# 43413
#This is the new calculation based on the 1st attempt of figuring out the adjusted PRS results
#Will have chart of the summary of results before and after the transformation as well as the histograms of before and after the transformation for CAD
hist(Remaining_PGC_Catalog_Main_Cohort_Subset$PGS003446, main="CAD PRS of BioMe Samples A")
hist(CAD_PRS_adjusted_scores, main="CAD Adjusted PRS of BioMe Samples A")
q()
