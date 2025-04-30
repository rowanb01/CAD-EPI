#The goal of this script is to pull out the years of birth variable and the encounters variable for diagnosis and go from there with producing new ages
library(data.table)
Questionnaire <- fread("/sc/private/regen/data/BioMe/BRSSPD/2024-07-01/Questionnaire.csv")
dim(Questionnaire)
#67,481 participants in Questionnaire
colnames(Questionnaire)            
Encounters <- fread("/sc/private/regen/data/BioMe/BRSSPD/2024-07-01/Encounter_Diagnosis.csv")
dim(Encounters)
#14,745,483 records are in encounters
colnames(Encounters)
summary(as.factor(Encounters$dx_name))
colnames(Encounters)
summary(as.factor(Encounters$dx_code1))
summary(as.factor(Encounters$dx_code_type)) 
#ICD10 has a total of 14,618,956 records while ICD9 has 126,527 records
Subset_CAD_A <- Encounters[which(Encounters$dx_code1 == "I25.0" | Encounters$dx_code1 == "I25.1" | Encounters$dx_code1 == "I25.10" | Encounters$dx_code1 == "I25.11" | Encounters$dx_code1 == "I25.118" | Encounters$dx_code1 == "I25.119" | Encounters$dx_code1 == "I25.81" | Encounters$dx_code1 == "I25.82" | Encounters$dx_code1 == "I25.83" | Encounters$dx_code1 == "I25.84"),]
dim(Subset_CAD_A)
#176,066 records pulled
#The pulling above is for CAD based on ICD10 calls. Next is to perform the same pulling but for CAD ICD9 
Subset_CAD_A <- Encounters[which(Encounters$dx_code1 == "I25.0" | Encounters$dx_code1 == "I25.1" | Encounters$dx_code1 == "I25.10" | Encounters$dx_code1 == "I25.11" | Encounters$dx_code1 == "I25.118" | Encounters$dx_code1 == "I25.119" | Encounters$dx_code1 == "I25.81" | Encounters$dx_code1 == "I25.82" | Encounters$dx_code1 == "I25.83" | Encounters$dx_code1 == "I25.84" | Encounters$dx_code1 == "414.0" | Encounters$dx_code1 == "414.01" | Encounters$dx_code1 == "414.02" | Encounters$dx_code1 == "414.03" | Encounters$dx_code1 == "414.04"),]
dim(Subset_CAD_A)
#176,067 records pulled
#Only managed to add 1 additional person from ICD10 pulls
range(Subset_CAD_A$primary_dx_yn)
range(Subset_CAD_A$encounter_date)
range(Subset_CAD_A$contact_date)
Primary_Dx_YN_Subset_CAD_A <- Subset_CAD_A[which(Subset_CAD_A$primary_dx_yn == "Y"),]
dim(Primary_Dx_YN_Subset_CAD_A)
#52,884 records pulled in total
#Now to check for mapping structures and the like
Genetic_Samples <- fread("/sc/arion/projects/igh/data/MSM/data/common_variants/combined/batch_001/imputed_TOPMED/bgen/MSM_TOPMED.chr19.sample")
Potential_Linker_File <- fread("/sc/arion/projects/igh/data/MSM/id_maps/subject_sample_mmrn_map_032025.txt")
dim(Genetic_Samples)
#58,387 total participants
dim(Potential_Linker_File)
#63,279 total participants
Kept_Genetic_Samples <- Genetic_Samples[match(intersect(Potential_Linker_File$sample_name, Genetic_Samples$ID_1), Genetic_Samples$ID_1),]
dim(Kept_Genetic_Samples)
#58,371 match overall
Kept_Sample_Matching_Algorithm <- Potential_Linker_File[match(intersect(Kept_Genetic_Samples$ID_1, Potential_Linker_File$sample_name), Potential_Linker_File$sample_name),]
dim(Kept_Sample_Matching_Algorithm)
#58,371 matched overall
Genetic_with_Linker_File <- cbind(Kept_Genetic_Samples, Kept_Sample_Matching_Algorithm)
dim(Kept_Sample_Matching_Algorithm)
#58,371 participants matched overall which means the merge worked!
Overlap_Genetic_Data_with_Primary_Dx_YN_Subset_CAD_A <- Primary_Dx_YN_Subset_CAD_A[match(intersect(Genetic_with_Linker_File$subject_id, Primary_Dx_YN_Subset_CAD_A$subject_id), Primary_Dx_YN_Subset_CAD_A$subject_id),]
dim(Overlap_Genetic_Data_with_Primary_Dx_YN_Subset_CAD_A)
#6,028 participants match overall
#Overlap_Genetic_Data_with_Primary_Dx_YN_Subset_CAD_A <- Primary_Dx_YN_Subset_CAD_A[match(intersect(Genetic_with_Linker_File$masked_mrn, Primary_Dx_YN_Subset_CAD_A$masked_mrn), Primary_Dx_YN_Subset_CAD_A$masked_mrn),]
#dim(Overlap_Genetic_Data_with_Primary_Dx_YN_Subset_CAD_A)
#6,024 participants match overall; used subject_id since it has the most results verbatim (by 4 samples)
#Need to check for size of the unique ids because these numbers dropped dramatically for CAD
nrow(Primary_Dx_YN_Subset_CAD_A)
#52,884 participants in the Primary dataset
length(unique(Primary_Dx_YN_Subset_CAD_A$subject_id))
#6815 are unique so this is not entirely off based on the matching and the like
#Next is to extract information on myocardial infarction
dim(Encounters[which(Encounters$dx_code1 == "I21.A"),])
#0 with this alone for ICD10 myocardial infarction
nrow(Encounters[which(Encounters$dx_code1 == "I21.B"),])
nrow(Encounters[which(Encounters$dx_code1 == "I21.B1"),])
nrow(Encounters[which(Encounters$dx_code1 == "I21.A1"),])
nrow(Encounters[which(Encounters$dx_code1 == "I21.A9"),])
nrow(Encounters[which(Encounters$dx_code1 == "410.0"),])
nrow(Encounters[which(Encounters$dx_code1 == "410.1"),])
nrow(Encounters[which(Encounters$dx_code1 == "410.2"),])
nrow(Encounters[which(Encounters$dx_code1 == "410.3"),])
nrow(Encounters[which(Encounters$dx_code1 == "410.4"),])
nrow(Encounters[which(Encounters$dx_code1 == "410.5"),])
nrow(Encounters[which(Encounters$dx_code1 == "410.6"),])
nrow(Encounters[which(Encounters$dx_code1 == "410.7"),])
nrow(Encounters[which(Encounters$dx_code1 == "410.8"),])
nrow(Encounters[which(Encounters$dx_code1 == "410.9"),])
#Results of ICD9s for MI (410.#) are all 0, so the encounters do not contain those codes
Subset_MI_A <- Encounters[which(Encounters$dx_code1 == "I21.0" | Encounters$dx_code1 == "I21.01" | Encounters$dx_code1 == "I21.02" | Encounters$dx_code1 == "I21.09" | Encounters$dx_code1 == "I21.11" | Encounters$dx_code1 == "I21.19" | Encounters$dx_code1 == "I21.21" | Encounters$dx_code1 == "I21.29" | Encounters$dx_code1 == "I21.3" | Encounters$dx_code1 == "I21.4" | Encounters$dx_code1 == "I21.9" | Encounters$dx_code1 == "I21.A1" | Encounters$dx_code1 == "I21.A9"),]
dim(Subset_MI_A)
#6,862 pulled
Primary_Dx_YN_Subset_MI_A <- Subset_MI_A[which(Subset_MI_A$primary_dx_yn == "Y"),]
dim(Primary_Dx_YN_Subset_MI_A)
#This reduced the load to 1629 records
Overlap_Genetic_Data_with_Primary_Dx_YN_Subset_MI_A <- Primary_Dx_YN_Subset_MI_A[match(intersect(Genetic_with_Linker_File$subject_id, Primary_Dx_YN_Subset_MI_A$subject_id), Primary_Dx_YN_Subset_MI_A$subject_id),]
dim(Overlap_Genetic_Data_with_Primary_Dx_YN_Subset_MI_A)
#down to 675 participants
#Now to create the age variables based on these results
Remaining_Samples_CAD_Pull <- Questionnaire[match(intersect(Overlap_Genetic_Data_with_Primary_Dx_YN_Subset_CAD_A$subject_id, Questionnaire$subject_id), Questionnaire$subject_id),]
dim(Remaining_Samples_CAD_Pull)
#Turns out there is an overlap of 6026 participants
Remaining_Samples_MI_Pull <- Questionnaire[match(intersect(Overlap_Genetic_Data_with_Primary_Dx_YN_Subset_MI_A$subject_id, Questionnaire$subject_id), Questionnaire$subject_id),]
dim(Remaining_Samples_MI_Pull)
#There are 675 participants pulled, meaning all of the MI cases are extracted
CAD_Revamped <- Overlap_Genetic_Data_with_Primary_Dx_YN_Subset_CAD_A[match(intersect(Remaining_Samples_CAD_Pull$subject_id, Overlap_Genetic_Data_with_Primary_Dx_YN_Subset_CAD_A$subject_id), Overlap_Genetic_Data_with_Primary_Dx_YN_Subset_CAD_A$subject_id),]
dim(CAD_Revamped)
#6026 again so the numbers match!
Remaining_Samples_CAD_Pull$CAD_Primary_Dx_Encounter_Date <- CAD_Revamped$encounter_date
Remaining_Samples_CAD_Pull$Age <- 2025 - Remaining_Samples_CAD_Pull$YEAR_OF_BIRTH
range(Remaining_Samples_CAD_Pull$Age)
#range of 31 to 92 years old; will have to come up with filter for this stage in terms of age cutoffs
range(Remaining_Samples_CAD_Pull$CAD_Primary_Dx_Encounter_Date)
#Need to convert date string into year numerically
Remaining_Samples_CAD_Pull$CAD_Primary_Dx_Year <- format(as.Date(Remaining_Samples_CAD_Pull$CAD_Primary_Dx_Encounter_Date, format="%m/%d/%Y"), "%Y")
range(Remaining_Samples_CAD_Pull$CAD_Primary_Dx_Year)
#Now the formating is proper in terms of dates being converted to year. Now to make this a numeric variable. Range from 2006 to 2024
Remaining_Samples_CAD_Pull$CAD_Primary_Dx_Year <- as.numeric(Remaining_Samples_CAD_Pull$CAD_Primary_Dx_Year)
range(Remaining_Samples_CAD_Pull$CAD_Primary_Dx_Year)
#perfect! Now to create the diagnosis age for CAD
Remaining_Samples_CAD_Pull$Age_CAD_Primary_Dx <- Remaining_Samples_CAD_Pull$CAD_Primary_Dx_Year - Remaining_Samples_CAD_Pull$YEAR_OF_BIRTH
range(Remaining_Samples_CAD_Pull$Age_CAD_Primary_Dx)
#Again will need age cutoff but have a range of 22 to 90
#Repeat this for MI cases
Remaining_Samples_MI_Pull$MI_Primary_Dx_Encounter_Date <- Overlap_Genetic_Data_with_Primary_Dx_YN_Subset_MI_A$encounter_date
Remaining_Samples_MI_Pull$Age <- 2025 - Remaining_Samples_MI_Pull$YEAR_OF_BIRTH
range(Remaining_Samples_MI_Pull$Age)
#Range of 30 to 92; will have to come up with age cutoff
range(Remaining_Samples_MI_Pull$MI_Primary_Dx_Encounter_Date)
#2011 to 2013 in terms of year but will need to change to year from date
Remaining_Samples_MI_Pull$MI_Primary_Dx_Year <- format(as.Date(Remaining_Samples_MI_Pull$MI_Primary_Dx_Encounter_Date, format="%m/%d/%Y"), "%Y")
range(Remaining_Samples_MI_Pull$MI_Primary_Dx_Year)
#Now the formating is proper in terms of dates being converted to year. Now to make this a numeric variable. Range from 2006 to 2024
Remaining_Samples_MI_Pull$MI_Primary_Dx_Year <- as.numeric(Remaining_Samples_MI_Pull$MI_Primary_Dx_Year)
range(Remaining_Samples_MI_Pull$MI_Primary_Dx_Year)
#perfect! Now to create the diagnosis age for MI; Range from 2006 to 2024
Remaining_Samples_MI_Pull$Age_MI_Primary_Dx <- Remaining_Samples_MI_Pull$MI_Primary_Dx_Year - Remaining_Samples_MI_Pull$YEAR_OF_BIRTH
range(Remaining_Samples_MI_Pull$Age_MI_Primary_Dx)
#range from 22 to 89 and again will need to make an age cutoff range
Common_Vars_Overlap_Questionnaire <- Questionnaire[match(intersect(Genetic_with_Linker_File$subject_id, Questionnaire$subject_id), Questionnaire$subject_id),]
dim(Common_Vars_Overlap_Questionnaire)
#There are 57,651 participants retained
Common_Vars_Overlap_Questionnaire$Age <- 2025 - Common_Vars_Overlap_Questionnaire$YEAR_OF_BIRTH
range(Common_Vars_Overlap_Questionnaire$Age)
#Range from 11 to 92; will have to come up with age cutoffs for this study
#Next will be to save the results and rerun things for ease of pace
mean(Common_Vars_Overlap_Questionnaire$Age)
#61 is the mean age
mean(Remaining_Samples_CAD_Pull$Age)
#76 is the mean age
mean(Remaining_Samples_CAD_Pull$Age_CAD_Primary_Dx)
#68 is the mean age
mean(Remaining_Samples_MI_Pull$Age)
#74 is the mean age
mean(Remaining_Samples_MI_Pull$Age_MI_Primary_Dx)
#67 is the mean age
median(Common_Vars_Overlap_Questionnaire$Age)
#63 is the median age
median(Remaining_Samples_CAD_Pull$Age)
#77 is the median age
median(Remaining_Samples_CAD_Pull$Age_CAD_Primary_Dx)
#69 is the median age
median(Remaining_Samples_MI_Pull$Age)
#75 ia the median age
median(Remaining_Samples_MI_Pull$Age_MI_Primary_Dx)
#68 is the median age
q()
