#Goal is to generate race/ethnicity counts. File will be updated when new pathway is sent for Mount Sinai Million
library(data.table)
data.table 1.16.0 using 48 threads (see ?getDTthreads).  Latest news: r-datatable.com
Sema4 <- fread("/sc/arion/projects/igh/data/Regen_Questionaire_Ethnicity_info.Collapsed_V2.txt")
Regen <- fread("/sc/arion/projects/igh/data/Regen_Questionaire_Ethnicity_info.Collapsed_V2.txt")
Sema4 <- fread("/sc/arion/projects/igh/data/Sema4_Questionaire_Ethnicity_info.Collapsed_V2.txt")
dim(Regen)
# 32101    22
colnames(Regen)
dim(Sema4)
# 23818    21
colnames(Sema4)
#Mostly the same structure set up for columns
Combine_Sets_2 <- rbind(setDT(Regen), setDT(Sema4), fill=TRUE)
dim(Combine_Sets_2)
# 55919    23
#This method appears to work! 
length(unique(Combine_Sets_2$MASKED_MRN))
# 51079
55919 - 51079
# 4840
#4840 were shared between dataframes
Unique_ids_Race_Sets <- Combine_Sets_2[match(intersect(unique(Combine_Sets_2$MASKED_MRN), Combine_Sets_2$MASKED_MRN), Combine_Sets_2$MASKED_MRN),]
dim(Unique_ids_Race_Sets)
# 51079    23
#Now we have set this in a manner that only the unique participants remain
#Next is to see how many of these participants are in the genetic merged with questionniare dataset
Main_Cohort <- fread("Main_Cohort_Adults_050225.csv")
Race_Ethnic_Genetic_Questionnaire_Match_up <- merge(Main_Cohort, Unique_ids_Race_Sets, by.x="masked_mrn", by.y="MASKED_MRN")
dim(Race_Ethnic_Genetic_Questionnaire_Match_up)
# 47525   194
#Dropped to this number, but can find an updated version of the data for Mount Sinai Million, which is a point to note for downstream analyses
summary(as.factor(Race_Ethnic_Genetic_Questionnaire_Match_up$new_eth_designation))
#African-American/African    East/South-East_Asian        European_American 
 #                   9950                     1663                    14292 
# Hispanic_Latin_American                   Jewish        Multiple_Selected 
    #               16510                       32                      678 
   #      Native_American                    Other              South_Asian 
  #                   102                     2925                     1205 
 #                unknown 
#                     168 

#Percentages
9950/47525
# 0.2093635 is the African-American/African proportion
1663/47525
# 0.03499211 is the East/South-East_Asian proportion
14292/47525
# 0.3007259 is the European_American proportion
16510/47525
# 0.3473961 is the Hispanic_Latin_American proportion
32/47525
# 0.0006733298 is the Jewish proportion
678/47525
# 0.01426618 is the Mutiple_Selected proportion
102/47525
# 0.002146239 is the Native_American proportion
2925/47525
# 0.06154655 is the Other proporotion 
1205/47525
# 0.02535508 is the South_asian proportion
168/47525
# 0.003534982 is the Uknown proportion
21+4+34+1+30+6+3
# 99
q()
