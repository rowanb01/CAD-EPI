#The goal of this file was to help with comparing the way ancestry is calculated based on how we are using the method and how Travis used it for the PGC Catalog

#There needs to be a point that QC was not done on the Sinead numbers and my ownMain Cohort dataset, while Travis accounted for missing genotypes, imputation quality, and relatedness as well as sex ambiguity in his analyses for the pgc catalog.

library(data.table)
Sema4 <- fread("/sc/arion/projects/igh/data/Sema4_Questionaire_Ethnicity_info.Collapsed_V2.txt")
Regen <- fread("/sc/arion/projects/igh/data/Regen_Questionaire_Ethnicity_info.Collapsed_V2.txt")
Combine_Sets_2 <- rbind(setDT(Regen), setDT(Sema4), fill=TRUE)
Unique_ids_Race_Sets <- Combine_Sets_2[match(intersect(unique(Combine_Sets_2$MASKED_MRN), Combine_Sets_2$MASKED_MRN), Combine_Sets_2$MASKED_MRN),]
dim(Unique_ids_Race_Sets)
#[1] 51079    23
summary(as.factor(Unique_ids_Race_Sets$new_eth_designation))
#African-American/African    East/South-East_Asian        European_American
#                   10485                     1816                    15637
# Hispanic_Latin_American                   Jewish        Multiple_Selected
#                   17675                       35                      797
#         Native_American                    Other              South_Asian
#                      93                     3031                     1327
#                 unknown
#                     183 
dim(Unique_ids_Race_Sets[which(Unique_ids_Race_Sets$new_eth_designation != "Other" & Unique_ids_Race_Sets$new_eth_designation != "Multiple_Selected" & Unique_ids_Race_Sets$new_eth_designation != "Other"),])
#[1] 47251    23
q()
