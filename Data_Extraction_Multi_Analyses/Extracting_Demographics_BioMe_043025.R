#The goal of this script is to generate the initial data extractions for the main cohort and pick variables that can be extracted from the additonal cohorts for comparison
library(data.table)
#Read in the files that were subset and merged with the mapper ids
Encounter_Subset_Cohort_ids <- fread("Encounters_Main_Cohort_043025.csv")
Lab_Subset_Cohort_ids <- fread("Labs_Main_Cohort_043025.csv")
Phecode_Subset_Cohort_ids <- fread("Phecode_Main_Cohort_043025.csv")
Genetic_Common_Exome_with_questionnaire_with_ids <- fread("Main_Cohort_043025.csv")

#Age
Genetic_Common_Exome_with_questionnaire_with_ids$Age <- 2025 - Genetic_Common_Exome_with_questionnaire_with_ids$YEAR_OF_BIRTH
range(Genetic_Common_Exome_with_questionnaire_with_ids$Age)
# 11 92
mean(Genetic_Common_Exome_with_questionnaire_with_ids$Age)
# 61.94497
median(Genetic_Common_Exome_with_questionnaire_with_ids$Age)
# 63
dim(Genetic_Common_Exome_with_questionnaire_with_ids)
# 51823   172
#Need to subset to remove pediatric ages from the results
Adult_Genetic_Common_Exome_with_questionnaire_with_ids <- Genetic_Common_Exome_with_questionnaire_with_ids[which(Genetic_Common_Exome_with_questionnaire_with_ids$Age >= 18),]
dim(Adult_Genetic_Common_Exome_with_questionnaire_with_ids)
# 51636   172
range(Adult_Genetic_Common_Exome_with_questionnaire_with_ids$Age)
# 18 92
mean(Adult_Genetic_Common_Exome_with_questionnaire_with_ids$Age)
# 62.11354
median(Adult_Genetic_Common_Exome_with_questionnaire_with_ids$Age)
# 64
#Used for pulling out age and CAD_Dx_Age since the subset already excludes pediatric age (same mindset applies for MI)
Subset_CAD_A <- Encounter_Subset_Cohort_ids[which(Encounter_Subset_Cohort_ids$dx_code1 == "I25.0" | Encounter_Subset_Cohort_ids$dx_code1 == "I25.1" | Encounter_Subset_Cohort_ids$dx_code1 == "I25.10" | Encounter_Subset_Cohort_ids$dx_code1 == "I25.11" | Encounter_Subset_Cohort_ids$dx_code1 == "I25.118" | Encounter_Subset_Cohort_ids$dx_code1 == "I25.119" | Encounter_Subset_Cohort_ids$dx_code1 == "I25.81" | Encounter_Subset_Cohort_ids$dx_code1 == "I25.82" | Encounter_Subset_Cohort_ids$dx_code1 == "I25.83" | Encounter_Subset_Cohort_ids$dx_code1 == "I25.84" | Encounter_Subset_Cohort_ids$dx_code1 == "414.0" | Encounter_Subset_Cohort_ids$dx_code1 == "414.01" | Encounter_Subset_Cohort_ids$dx_code1 == "414.02" | Encounter_Subset_Cohort_ids$dx_code1 == "414.03" | Encounter_Subset_Cohort_ids$dx_code1 == "414.04"),]
dim(Subset_CAD_A)
# 150266    180
Primary_Dx_YN_Subset_CAD_A <- Subset_CAD_A[which(Subset_CAD_A$primary_dx_yn == "Y"),]
dim(Primary_Dx_YN_Subset_CAD_A)
# 43682   180
Primary_Dx_YN_Subset_CAD_A$Age <- 2025 - Primary_Dx_YN_Subset_CAD_A$YEAR_OF_BIRTH
range(Primary_Dx_YN_Subset_CAD_A$Age)
# 37 92
mean(Primary_Dx_YN_Subset_CAD_A$Age)
# 76.86949
median(Primary_Dx_YN_Subset_CAD_A$Age)
# 77
Primary_Dx_YN_Subset_CAD_A$Primary_Dx_Year <- format(as.Date(Primary_Dx_YN_Subset_CAD_A$CAD_Primary_Dx_Encounter_Date, format="%m/%d/%Y"), "%Y")
range(Primary_Dx_YN_Subset_CAD_A$Primary_Dx_Year)
# NA NA
Primary_Dx_YN_Subset_CAD_A$Primary_Dx_Year <- format(as.Date(Primary_Dx_YN_Subset_CAD_A$encounter_date, format="%m/%d/%Y"), "%Y")
range(Primary_Dx_YN_Subset_CAD_A$Primary_Dx_Year)
# "2006" "2024"
Primary_Dx_YN_Subset_CAD_A$Primary_Dx_Year <- as.numeric(Primary_Dx_YN_Subset_CAD_A$Primary_Dx_Year)
Primary_Dx_YN_Subset_CAD_A$CAD_Dx_Age <- Primary_Dx_YN_Subset_CAD_A$Primary_Dx_Year - Primary_Dx_YN_Subset_CAD_A$YEAR_OF_BIRTH
range(Primary_Dx_YN_Subset_CAD_A$CAD_Dx_Age)
# 22 90
mean(Primary_Dx_YN_Subset_CAD_A$CAD_Dx_Age)
# 68.66725
median(Primary_Dx_YN_Subset_CAD_A$CAD_Dx_Age)
# 69
Subset_MI_A <- Encounter_Subset_Cohort_ids[which(Encounter_Subset_Cohort_ids$dx_code1 == "I21.0" | Encounter_Subset_Cohort_ids$dx_code1 == "I21.01" | Encounter_Subset_Cohort_ids$dx_code1 == "I21.02" | Encounter_Subset_Cohort_ids$dx_code1 == "I21.09" | Encounter_Subset_Cohort_ids$dx_code1 == "I21.11" | Encounter_Subset_Cohort_ids$dx_code1 == "I21.19" | Encounter_Subset_Cohort_ids$dx_code1 == "I21.21" | Encounter_Subset_Cohort_ids$dx_code1 == "I21.29" | Encounter_Subset_Cohort_ids$dx_code1 == "I21.3" | Encounter_Subset_Cohort_ids$dx_code1 == "I21.4" | Encounter_Subset_Cohort_ids$dx_code1 == "I21.9" | Encounter_Subset_Cohort_ids$dx_code1 == "I21.A1" | Encounter_Subset_Cohort_ids$dx_code1 == "I21.A9"),]
dim(Subset_MI_A)
# 6175  180
Primary_Dx_YN_Subset_MI_A <- Subset_MI_A[which(Subset_MI_A$primary_dx_yn == "Y"),]
dim(Primary_Dx_YN_Subset_MI_A)
# 1454  180
Primary_Dx_YN_Subset_MI_A$Age <- 2025 - Primary_Dx_YN_Subset_MI_A$YEAR_OF_BIRTH
range(Primary_Dx_YN_Subset_MI_A$Age)
# 30 92
mean(Primary_Dx_YN_Subset_MI_A$Age)
# 72.19532
median(Primary_Dx_YN_Subset_MI_A$Age)
# 72
Primary_Dx_YN_Subset_MI_A$Primary_Dx_Year <- format(as.Date(Primary_Dx_YN_Subset_MI_A$encounter_date, format="%m/%d/%Y"), "%Y")
range(Primary_Dx_YN_Subset_MI_A$Primary_Dx_Year)
# "2007" "2024"
Primary_Dx_YN_Subset_MI_A$Primary_Dx_Year <- as.numeric(Primary_Dx_YN_Subset_MI_A$Primary_Dx_Year)
Primary_Dx_YN_Subset_MI_A$MI_Dx_Age <- Primary_Dx_YN_Subset_MI_A$Primary_Dx_Year - Primary_Dx_YN_Subset_MI_A$YEAR_OF_BIRTH
range(Primary_Dx_YN_Subset_MI_A$MI_Dx_Age)
# 22 89
mean(Primary_Dx_YN_Subset_MI_A$MI_Dx_Age)
# 65.24347
median(Primary_Dx_YN_Subset_MI_A$MI_Dx_Age)
# 66


#Phecode and specifically hypertension pull
dim(Phecode_Subset_Cohort_ids)
#  50719  3384
Hypertension_Phecode_Pull <- Phecode_Subset_Cohort_ids[which(Phecode_Subset_Cohort_ids$CV_401 == 1),]
dim(Hypertension_Phecode_Pull)
#23592  3384

#Hypertension icd pull
Hypertension_icd_Pull <- Encounter_Subset_Cohort_ids[which(Encounter_Subset_Cohort_ids$dx_code1 == "I10" | Encounter_Subset_Cohort_ids$dx_code1 == "I11" | Encounter_Subset_Cohort_ids$dx_code1 == "I12" | Encounter_Subset_Cohort_ids$dx_code1 == "I13" | Encounter_Subset_Cohort_ids$dx_code1 == "I14" | Encounter_Subset_Cohort_ids$dx_code1 == "I15" | Encounter_Subset_Cohort_ids$dx_code1 == "I16" | Encounter_Subset_Cohort_ids$dx_code1 == "401.0" | Encounter_Subset_Cohort_ids$dx_code1 == "401.1" | Encounter_Subset_Cohort_ids$dx_code1 == "401.9"),]
dim(Hypertension_icd_Pull)
# 698782    180
 Primary_Dx_Hypertension_icd_Pull <- Hypertension_icd_Pull[which(Hypertension_icd_Pull$primary_dx_yn == "Y"),]
dim(Primary_Dx_Hypertension_icd_Pull)
# 192550    180
length(unique(Primary_Dx_Hypertension_icd_Pull$subject_id))
# 17346


#Lab values check with median LDL-c
length(na.omit(Lab_Subset_Cohort_ids$CHOLESTEROL_IN_LDL_indiv_median))
# 37158
range(na.omit(Lab_Subset_Cohort_ids$CHOLESTEROL_IN_LDL_indiv_median))
# -19 250
mean(na.omit(Lab_Subset_Cohort_ids$CHOLESTEROL_IN_LDL_indiv_median))
# 101.6679
median(na.omit(Lab_Subset_Cohort_ids$CHOLESTEROL_IN_LDL_indiv_median))
# 100
#Need to subset since there is no way to have a negative 
Test_Lab_Subset <- Lab_Subset_Cohort_ids[which(Lab_Subset_Cohort_ids$CHOLESTEROL_IN_LDL_indiv_median > 0),]
dim(Test_Lab_Subset)
# 37157  1081
range(Test_Lab_Subset$CHOLESTEROL_IN_LDL_indiv_median)
#   3 250
mean(Test_Lab_Subset$CHOLESTEROL_IN_LDL_indiv_median)
# 101.6712
median(Test_Lab_Subset$CHOLESTEROL_IN_LDL_indiv_median)
# 100

#Remaining Demographics that are not genetic (Sex, self-reported race/ethnicity)

summary(as.factor(Adult_Genetic_Common_Exome_with_questionnaire_with_ids$GENDER))
# Female    Male Unknown
#  30252   21375       9

summary(as.factor(Adult_Genetic_Common_Exome_with_questionnaire_with_ids$RACE))
American Indian or Alaska Native                            Asian 
      #                       643                                3 
     #  Black or African American                         Hispanic 
    #                        6237                               11 
   #              Other (Specify)          Unknown or Not Reported 
  #                         24331                             3987 
 #              White / Caucasian                             NA's 
#                           16417                                7 

summary(as.factor(Adult_Genetic_Common_Exome_with_questionnaire_with_ids$RACE_OTHER))
           #                   AI                     Asian Indian 
          #                   643                                2 
         #                     BL Black/Caucasian/Sephardic Jewish 
        #                    6223                                1 
       #               Ecuadorian                         Guyanese 
      #                         1                                1 
     #                         OT                     PUERTO RICAN 
    #                       24338                                2 
   #                           UN                               WH 
  #                          3985                            16411 
 #                           NA's 
#                              29 

#An alternative potentially, but still will pick RACE for now

summary(as.factor(Adult_Genetic_Common_Exome_with_questionnaire_with_ids$ETHNICITY))
 #   Hispanic or Latino Not Hispanic or Latino                   NA's
#                    24                     48                  51564

#summary(as.factor(Adult_Genetic_Common_Exome_with_questionnaire_with_ids$ETHICITY_2))
#We are not trying to go into the depth of work for these many participants for this project (will pick ETHNICITY for now)

summary(as.factor(Adult_Genetic_Common_Exome_with_questionnaire_with_ids$ETHNICITY_OTHER))
     #  West Indian              Black              Irish           Guyanese
        #       160                145                127                101
       #  Caribbean           Jamaican            Russian   Italian American
      #          99                 89                 72                 71
     #     American       Puerto Rican            Haitian            Italian
    #            61                 61                 57                 57
   #  South America           European             Polish        Trinidadian
   #             57                 48                 47                 35
  #           Asian             German          Brazilian          Ashkenazi
 #               32                 32                 30                 26
#  Eastern European             Europe   Italian-American        East Indian
          #      26                 24                 24                 21
         # Egyptian     Irish American   Pacific Islander             Guyana
          #      20                 20                 19                 17
         # Romanian     Middle Eastern              Greek          Hungarian
           #     16                 15                 14                 14
          # Missing           Armenian         Phillipino   American Italian
         #       14                 13                 13                 12
        # Fillipino            Spanish          Carribean            English
        #        12                 12                 11                 11
       # Philippino          Ukrainian           Albanian           Croatian
            #    10                 10                  9                  9
           # French   Ashkenazi Jewish           Caribean    Central America
            #     9                  8                  8                  8
           #  Human  Northern European          Philipino     Black American
          #       8                  8                  8                  7
         # guyanese             Indian       Irish German            Israeli
         #        7                  7                  7                  7
        #  Japanese           Lebanese           Scottish     South American
       #          7                  7                  7                  7
      #     Swedish              Cuban              Haiti      Irish/ German
     #            7                  6                  6                  6
    # Italian Irish   pacific islander            Persian             polish
     #            6                  6                  6                  6
    #      Ukranian            African      Ashkenazi Jew         Australian
   #              6                  5                  5                  5
  #  Black-American          Dominican              Dutch     Eastern Europe
           #      5                  5                  5                  5
          #  Hebrew             Latina      North African         Portuguese
         #        5                  5                  5                  5
        #    Russia           Sicilian            Unknown        West Africa
       #          5                  5                  5                  5
      # west indian          Barbadian         Brazillian Caribbean American
      #           5                  4                  4                  4
     #   Carribbean           Catholic Dominican Republic          Ethiopian
    #             4                  4                  4                  4
   #       Filipino           Garifuna       German Irish              irish
  #               4                  4                  4                  4
 #    Irish English     Irish-American            (Other)               NA's
#                 4                  4                827              48729

#The above is an alternative we can consider     


#Now to repeat these subsets (RACE, ETHNICITY, Sex, Age for the requested subtypes)
#Only looking at current age, not age of diagnosis at disease

Encounter_Subset_Cohort_ids$Age <- 2025 - Encounter_Subset_Cohort_ids$YEAR_OF_BIRTH
range(Encounter_Subset_Cohort_ids$Age)
# 11 92
#Need to shorten this down to the ages that are in adulthood
Adult_Encounter_Subset_Cohort_ids <- Encounter_Subset_Cohort_ids[which(Encounter_Subset_Cohort_ids$Age >= 18),]
dim(Adult_Encounter_Subset_Cohort_ids)
# 12694738      181
length(unique(Adult_Encounter_Subset_Cohort_ids$subject_id))
# 49265
Keep_Adult_Encounter_Subset_Cohort_ids <- Adult_Encounter_Subset_Cohort_ids[match(intersect(unique(Adult_Encounter_Subset_Cohort_ids$subject_id), Adult_Encounter_Subset_Cohort_ids$subject_id), Adult_Encounter_Subset_Cohort_ids$subject_id),]
dim(Keep_Adult_Encounter_Subset_Cohort_ids)
# 49265   181
#Now to do the normal distribution since the multiple entries are removed
range(Keep_Adult_Encounter_Subset_Cohort_ids$Age)
# 18 92
mean(Keep_Adult_Encounter_Subset_Cohort_ids$Age)
# 61.92345
median(Keep_Adult_Encounter_Subset_Cohort_ids$Age)
# 63
summary(as.factor(Keep_Adult_Encounter_Subset_Cohort_ids$RACE))
# American Indian or Alaska Native                            Asian 
     #                        604                                3 
    #   Black or African American                         Hispanic 
   #                         5901                                9 
    #             Other (Specify)          Unknown or Not Reported 
  #                         23237                             3751 
 #              White / Caucasian                             NA's 
#                           15753                                7 
	   
summary(as.factor(Keep_Adult_Encounter_Subset_Cohort_ids$ETHNICITY))
  #  Hispanic or Latino Not Hispanic or Latino                   NA's 
   #                 19                     31                  49215 
summary(as.factor(Keep_Adult_Encounter_Subset_Cohort_ids$GENDER))
# Female    Male Unknown 
#  28863   20393       9 

Lab_Subset_Cohort_ids$Age <- 2025 - Lab_Subset_Cohort_ids$YEAR_OF_BIRTH
range(Lab_Subset_Cohort_ids$Age)
# 21 92
mean(Lab_Subset_Cohort_ids$Age)
# 62.17843
dim(Lab_Subset_Cohort_ids)
# 47234  1081
median(Lab_Subset_Cohort_ids$Age)
# 63
summary(as.factor(Lab_Subset_Cohort_ids$GENDER))
# Female    Male Unknown 
#  28062   19166       6 
summary(as.factor(Lab_Subset_Cohort_ids$RACE))
#American Indian or Alaska Native                            Asian 
      #                       562                                3 
     #  Black or African American                         Hispanic 
    #                        5924                               11 
   #              Other (Specify)          Unknown or Not Reported 
  #                         22257                             3449 
 #              White / Caucasian                             NA's 
#                           15027                                1

summary(as.factor(Lab_Subset_Cohort_ids$ETHNICITY))
 #   Hispanic or Latino Not Hispanic or Latino                   NA's 
#                   24                     48                  47162 

dim(Phecode_Subset_Cohort_ids)
# 50719  3384
Phecode_Subset_Cohort_ids$Age <- 2025 - Phecode_Subset_Cohort_ids$YEAR_OF_BIRTH
range(Phecode_Subset_Cohort_ids$Age)
# 11 92
#Need to shorten this down to the ages that are in adulthood
Adult_Phecode_Subset_Cohort_ids <- Phecode_Subset_Cohort_ids[which(Phecode_Subset_Cohort_ids$Age >= 18),]
dim(Adult_Phecode_Subset_Cohort_ids)
# 50532  3385
range(Adult_Phecode_Subset_Cohort_ids$Age)
# 18 92
mean(Adult_Phecode_Subset_Cohort_ids$Age)
# 62.02531
median(Adult_Phecode_Subset_Cohort_ids$Age)
# 63
summary(as.factor(Adult_Phecode_Subset_Cohort_ids$GENDER))
# Female    Male Unknown 
#  29694   20829       9 
summary(as.factor(Adult_Phecode_Subset_Cohort_ids$RACE))
#American Indian or Alaska Native                            Asian 
      #                       616                                3 
     #  Black or African American                         Hispanic 
    #                        6106                               11 
   #              Other (Specify)          Unknown or Not Reported 
  #                         23855                             3793 
 #              White / Caucasian                             NA's 
#                           16141                                7 

summary(as.factor(Adult_Phecode_Subset_Cohort_ids$ETHNICITY))
 #   Hispanic or Latino Not Hispanic or Latino                   NA's 
#                    24                     48                  50460 

q()



