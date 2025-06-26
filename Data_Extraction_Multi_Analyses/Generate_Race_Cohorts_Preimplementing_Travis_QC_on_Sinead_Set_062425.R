#The goal of this script is to compare the final sample size once ancestry labels and the like are used for Travis data and the data used for the Main Cohort
#This script also tracks down the numbers when using the data from Travis and themain cohort
library(data.table)
Sinead_Race_Ethnicity_Labeled_Main_Cohort <- fread("Main_Cohort_Adults_Race_Ethnicity_Update_060625.csv")
#49859   173
Adult_Main_Cohort <- fread("Main_Cohort_Adults_Unique_IDs_051625.csv")
dim(Adult_Main_Cohort)
#50161   172
Travis_Ancestry_PCA_Assignments <- fread("/sc/private/regen/IPM-general/Kenny_Lab/MSM/info/MSM_AssignedAncestry_PCA.txt")
dim(Travis_Ancestry_PCA_Assignments)
colnames(Travis_Ancestry_PCA_Assignments)
#"Individual.ID" "Est_Ethnicity"
class(Travis_Ancestry_PCA_Assignments$Est_Ethnicity)
#"character"
summary(as.factor(Travis_Ancestry_PCA_Assignments$Est_Ethnicity))
#  AFR   AMR   EAS   EUR   SAS  NA's
#11869 15589  2395 19154  1898  2713
53618 - 2713
#50905
PGC_Catalog <- fread("/sc/private/regen/IPM-general/Kenny_Lab/MSM/pgsc/results/ALL_aggregated_scores.txt.gz")
dim(Travis_Ancestry_PCA_Assignments[which(Travis_Ancestry_PCA_Assignments$Est_Ethnicity != "NA's"),])
#50905     2
#This method works for subsetting
V2_Travis_Ancestry_PCA_Assignments <- Travis_Ancestry_PCA_Assignments[which(Travis_Ancestry_PCA_Assignments$Est_Ethnicity != "NA's"),]
dim(V2_Travis_Ancestry_PCA_Assignments)
#50905     2
Travis_Ancestry_Confirmed_Adult_Main_Cohort <- Adult_Main_Cohort[match(intersect(Adult_Main_Cohort$ID_1, Ancestry_Matched_IDs_to_PGC_Catalog$Individual.ID), Ancestry_Matched_IDs_to_PGC_Catalog$Individual.ID),]
dim(Travis_Ancestry_Confirmed_Adult_Main_Cohort)
#41151   172
Adult_Main_PGC_Catalog_Confirmed_Cohort <- Adult_Main_Cohort[match(intersect(PGC_Catalog$IID, Adult_Main_Cohort$ID_1), Adult_Main_Cohort$ID_1),]
dim(Adult_Main_PGC_Catalog_Confirmed_Cohort)
#43413   172
Temp_Merge <- merge(V2_Travis_Ancestry_PCA_Assignments, Adult_Main_Cohort, by.x="Individual.ID", by.y="ID_2")
dim(Temp_Merge)
#43804   173
Reduced_Temp_Merge <- Temp_Merge[match(intersect(unique(Temp_Merge$Individual.ID), Temp_Merge$Individual.ID), Temp_Merge$Individual.ID),]
dim(Reduced_Temp_Merge)
#43804   173
summary(as.factor(Reduced_Temp_Merge$Est_Ethnicity))
#  AFR   AMR   EAS   EUR   SAS
#10892 13086  1849 16428  1549 
fwrite(Reduced_Temp_Merge, "Travis_Ancestry_Matched_PostQC_Main_Cohort_062425.csv")
nrow(Reduced_Temp_Merge) - nrow(Adult_Main_PGC_Catalog_Confirmed_Cohort)
#391
#There are 391 more participants with ancestry and an assigned cohort than what was completed for the PGC Catalog reuslts based on these files.
nrow(Sinead_Race_Ethnicity_Labeled_Main_Cohort) - nrow(Reduced_Temp_Merge)
#6055
#This is before any qc is done on the Sinead based numbers, but the participants remaining between the postQC work from Travis and the work done here is important to note. Will want to check numbers after some qc has been completed
summary(as.factor(Sinead_Race_Ethnicity_Labeled_Main_Cohort$new_eth_designation))
#African-American/African    East/South-East_Asian        European_American
#                   10110                     1819                    15198
# Hispanic_Latin_American                   Jewish        Multiple_Selected
#                   17577                       30                      712
#         Native_American                    Other              South_Asian
#                      92                     3022                     1299
	 
#Now to switch gears and make id list for each ancestry by the Sinead method. We can then go through and produce our results based on whether or not those lists pass the QC qualifications necessary
Sinead_AFR_Cohort <- Sinead_Race_Ethnicity_Labeled_Main_Cohort[which(Sinead_Race_Ethnicity_Labeled_Main_Cohort$new_eth_designation == "African-American/African"),]
Sinead_EAS_Cohort <- Sinead_Race_Ethnicity_Labeled_Main_Cohort[which(Sinead_Race_Ethnicity_Labeled_Main_Cohort$new_eth_designation == "East/South-East_Asian"),]
Sinead_EUR_Cohort <- Sinead_Race_Ethnicity_Labeled_Main_Cohort[which(Sinead_Race_Ethnicity_Labeled_Main_Cohort$new_eth_designation == "European_American"),]
Sinead_HIS_Cohort <- Sinead_Race_Ethnicity_Labeled_Main_Cohort[which(Sinead_Race_Ethnicity_Labeled_Main_Cohort$new_eth_designation == "Hispanic_Latin_American"),]
Sinead_JEW_Cohort <- Sinead_Race_Ethnicity_Labeled_Main_Cohort[which(Sinead_Race_Ethnicity_Labeled_Main_Cohort$new_eth_designation == "Jewish"),]
Sinead_MULTI_Cohort <- Sinead_Race_Ethnicity_Labeled_Main_Cohort[which(Sinead_Race_Ethnicity_Labeled_Main_Cohort$new_eth_designation == "Multiple_Selected"),]
Sinead_NATIVE_Cohort <- Sinead_Race_Ethnicity_Labeled_Main_Cohort[which(Sinead_Race_Ethnicity_Labeled_Main_Cohort$new_eth_designation == "Native_American"),]
Sinead_OTHER_Cohort <- Sinead_Race_Ethnicity_Labeled_Main_Cohort[which(Sinead_Race_Ethnicity_Labeled_Main_Cohort$new_eth_designation == "Other"),]
Sinead_SAS_Cohort <- Sinead_Race_Ethnicity_Labeled_Main_Cohort[which(Sinead_Race_Ethnicity_Labeled_Main_Cohort$new_eth_designation == "South_Asian"),]
AFR_IDs <- Sinead_AFR_Cohort[,c("ID_1", "ID_2")]
EUR_IDs <- Sinead_EUR_Cohort[,c("ID_1", "ID_2")]
EAS_IDs <- Sinead_EAS_Cohort[,c("ID_1", "ID_2")]
HIS_IDs <- Sinead_HIS_Cohort[,c("ID_1", "ID_2")]
JEWISH_IDs <- Sinead_JEW_Cohort[,c("ID_1", "ID_2")]
MULTI_Eth_IDs <- Sinead_MULTI_Cohort[,c("ID_1", "ID_2")]
NATIVE_AMER_IDs <- Sinead_NATIVE_Cohort[,c("ID_1", "ID_2")]
OTHER_AMER_IDs <- Sinead_OTHER_Cohort[,c("ID_1", "ID_2")]
SAS_IDs <- Sinead_SAS_Cohort[,c("ID_1", "ID_2")]
colnames(AFR_IDs) <- c("FID", "IID")
colnames(EUR_IDs) <- c("FID", "IID")
colnames(EAS_IDs) <- c("FID", "IID")
colnames(HIS_IDs) <- c("FID", "IID")
colnames(JEWISH_IDs) <- c("FID", "IID")
colnames(MULTI_Eth_IDs) <- c("FID", "IID")
colnames(NATIVE_AMER_IDs) <- c("FID", "IID")
colnames(OTHER_AMER_IDs) <- c("FID", "IID")
colnames(SAS_IDs) <- c("FID", "IID")
write.table(AFR_IDs, "African_American_Main_Adult_Cohort_Sinead_Race_Assignment_062425.txt", col.names=T, row.names=F, quote=F, sep="\t")
write.table(EUR_IDs, "European_American_Main_Adult_Cohort_Sinead_Race_Assignment_062425.txt", col.names=T, row.names=F, quote=F, sep="\t")
write.table(EAS_IDs, "East_Asian_American_Main_Adult_Cohort_Sinead_Race_Assignment_062425.txt", col.names=T, row.names=F, quote=F, sep="\t")
write.table(HIS_IDs, "Hispanic_American_Main_Adult_Cohort_Sinead_Race_Assignment_062425.txt", col.names=T, row.names=F, quote=F, sep="\t")
write.table(JEWISH_IDs, "Jewish_American_Main_Adult_Cohort_Sinead_Race_Assignment_062425.txt", col.names=T, row.names=F, quote=F, sep="\t")
write.table(MULTI_Eth_IDs, "Multiethnic_American_Main_Adult_Cohort_Sinead_Race_Assignment_062425.txt", col.names=T, row.names=F, quote=F, sep="\t")
write.table(NATIVE_AMER_IDs, "Native_American_Main_Adult_Cohort_Sinead_Race_Assignment_062425.txt", col.names=T, row.names=F, quote=F, sep="\t")
write.table(OTHER_AMER_IDs, "Other_Ethnicities_Main_Adult_Cohort_Sinead_Race_Assignment_062425.txt", col.names=T, row.names=F, quote=F, sep="\t")
write.table(OTHER_AMER_IDs, "Southeast_Asian_American_Main_Adult_Cohort_Sinead_Race_Assignment_062425.txt", col.names=T, row.names=F, quote=F, sep="\t")
write.table(SAS_IDs, "Southeast_Asian_American_Main_Adult_Cohort_Sinead_Race_Assignment_062425.txt", col.names=T, row.names=F, quote=F, sep="\t")
#General samples for CAD PRS
Sample_List <- Sinead_Race_Ethnicity_Labeled_Main_Cohort[,c("ID_1", "ID_2")]
colnames(Sample_List) <- c("FID", "IID")
write.table(Sample_List, "For_CAD_Samples_062425.txt", col.names=T, row.names=F, quote=F, sep="\t")
q()
