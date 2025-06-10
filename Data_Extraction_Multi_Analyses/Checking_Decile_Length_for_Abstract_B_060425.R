#The goal of this script is to check the length of the CAD PRS currently based on PGC for the abstract draft B, which is sent to Eimear

library(data.table)
library(dplyr)
Main_Cohort <- fread("Main_Cohort_Adults_050225.csv")
PGC_Catalog <- fread("/sc/private/regen/IPM-general/Kenny_Lab/MSM/pgsc/results/ALL_aggregated_scores.txt.gz")
Sinead_PCA <- fread("/sc/private/regen/IPM-general/Kenny_Lab/MSM_QC_v2/pcs/MSM_1KGP_HGDP_pca.eigenvec")
dim(Sinead_PCA)
# 58427    12
dim(PGC_Catalog)
# 50518  4831
dim(Main_Cohort)
# 51636   172
length(unique(Main_Cohort$ID_1))
# 50161
length(unique(Main_Cohort$masked_mrn))
# 50161
Remaining_PGC_Catalog_Main_Cohort_Subset <- PGC_Catalog[match(intersect(Main_Cohort$ID_1, PGC_Catalog$IID), PGC_Catalog$IID),] 
dim(Remaining_PGC_Catalog_Main_Cohort_Subset)
# 43413  4831
Kept_PCs <- Sinead_PCA[match(intersect(Remaining_PGC_Catalog_Main_Cohort_Subset$IID, Sinead_PCA$IID), Sinead_PCA$IID),]
dim(Kept_PCs)
# 43145    12
Renewed_PGC_Catalog_Main_Cohort_Subset <- Remaining_PGC_Catalog_Main_Cohort_Subset[match(intersect(Kept_PCs$IID, Remaining_PGC_Catalog_Main_Cohort_Subset$IID), Remaining_PGC_Catalog_Main_Cohort_Subset$IID),]
dim(Renewed_PGC_Catalog_Main_Cohort_Subset)
# 43145  4831
head(Renewed_PGC_Catalog_Main_Cohort_Subset$IID, 5)
head(Kept_PCs$IID, 5)
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
summary(Renewed_PGC_Catalog_Main_Cohort_Subset$PGS003446)
#    Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
# -110.193  -22.637   -5.929  -11.190    6.167   79.331 
Renewed_PGC_Catalog_Main_Cohort_Subset$decile <- ntile(Renewed_PGC_Catalog_Main_Cohort_Subset$PGS003446, 10)
range(Renewed_PGC_Catalog_Main_Cohort_Subset$decile)
#  1 10
#That is why the same answer kept appearing
nrow(Renewed_PGC_Catalog_Main_Cohort_Subset[which(Renewed_PGC_Catalog_Main_Cohort_Subset$decile == 10)])
# 4314
nrow(Renewed_PGC_Catalog_Main_Cohort_Subset[which(Renewed_PGC_Catalog_Main_Cohort_Subset$decile == 1)])
# 4315
q()

