#The goal of this script is to generate counts and overlap of variants of interest so precise numbers are known for each variant
library(data.table)
library(openxlsx)
Protective_Vars_Raw <- read.delim("Protective_PCSK9_Vars_Recode_050725.raw", header=T, sep="\t")
summary(as.factor(Temp_Raw$X1.55039774.C.T_C))
#    0     1     2  NA's 
#  666  8949 48313  1062 
summary(as.factor(Temp_Raw$X1.55039812.G.A_G))
#    0     1     2  NA's 
#    9   967 57903   111 
Gcount_Protective_PCSK9 <- fread("Protective_PCSK9_Vars_gcounts_050725.gcount")
dim(Gcount_Protective_PCSK9)
  2 10
Gcount_Protective_PCSK9
#   #CHROM             ID    REF    ALT HOM_REF_CT HET_REF_ALT_CTS
#    <int>         <char> <char> <char>      <int>           <int>
#1:      1 1:55039774:C:T      C      T      48313            8949
#2:      1 1:55039812:G:A      G      A      57903             967
#   TWO_ALT_GENO_CTS HAP_REF_CT HAP_ALT_CTS MISSING_CT
#              <int>      <int>       <int>      <int>
#1:              666          0           0       1062
#2:                9          0           0        111
#We are looking for those with the number of the variant that is het_ref_alt_cts, which are those with 1 for each variant
Main_Cohort <- fread("Main_Cohort_Adults_050225.csv")
dim(Main_Cohort)
# 51636   172
Main_Exome_Protective_PCSK9 <- Protective_Vars_Raw[match(intersect(Main_Cohort$ID_1, Protective_Vars_Raw$FID), Protective_Vars_Raw$FID),]
dim(Main_Exome_Protective_PCSK9)
# 50161     8
#That worked for extracting the dataset back down to what is between the exome data and the protective variants
Main_Exome_Protective_PCSK9 <- Temp_Raw[match(intersect(Main_Cohort$ID_1, Temp_Raw$FID), Temp_Raw$FID),]
dim(Main_Exome_Protective_PCSK9)
# 50161     8
summary(as.factor(Temp_Raw$X1.55039774.C.T_C))
#    0     1     2  NA's 
#  666  8949 48313  1062 
summary(as.factor(Main_Exome_Protective_PCSK9$X1.55039774.C.T_C))
#    0     1     2  NA's 
#  550  7415 41184  1012 
summary(as.factor(Main_Exome_Protective_PCSK9$X1.55039812.G.A_G))
#    0     1     2  NA's 
#    8   863 49183   107 
Test_Keep_Vars <- Main_Exome_Protective_PCSK9[which(Main_Exome_Protective_PCSK9$X1.55039774.C.T_C == 1 | Main_Exome_Protective_PCSK9$X1.55039812.G.A_G == 1),]
dim(Test_Keep_Vars)
# 8236    8
#The above is the solution to drawing out the exome subsets to finding the counts of the data of interest
write.table(Test_Keep_Vars, "Protective_Vars_in_Main_Cohort_050725.R", col.names=T, row.names=F, sep="\t")
#Now to repeat this process with the Main cohort and the pathogenic variant lists
LDLR_Pathogenic_Kept_Sheet <- read.xlsx("Requested_high_risk_varaints_FH_Pathogenic_Likely_Pathogenic_Known_Exome_041825.xlsx", sheet=1)
APOB_Pathogenic_Kept_Sheet <- read.xlsx("Requested_high_risk_varaints_FH_Pathogenic_Likely_Pathogenic_Known_Exome_041825.xlsx", sheet=3)
PCSK9_Pathogenic_Kept_Sheet <- read.xlsx("Requested_high_risk_varaints_FH_Pathogenic_Likely_Pathogenic_Known_Exome_041825.xlsx", sheet=4)
dim(LDLR_Pathogenic_Kept_Sheet)
# 55 41
dim(APOB_Pathogenic_Kept_Sheet)
# 11 41
dim(PCSK9_Pathogenic_Kept_Sheet)
#  2 41
LDLR_Raw_Pathogenic <- read.delim("LDLR_Pathogenic_Known_BioMe_Vars_Recode_041725.raw", header=T, sep="\t")
APOB_Raw_Pathogenic <- read.delim("APOB_Pathogenic_Known_BioMe_Vars_Recode_041725.raw", header=T, sep="\t")
PCSK9_Raw_Pathogenic <- read.delim("PCSK9_Pathogenic_Known_BioMe_Vars_Recode_041725.raw", header=T, sep="\t")
dim(PCSK9_Raw_Pathogenic)
# 58990     8
dim(LDLR_Raw_Pathogenic)
# 58990    61
dim(APOB_Raw_Pathogenic)
# 58990    17
colnames(LDLR_Raw_Pathogenic)
#  "FID"                                    
#  "IID"                                    
#  "PAT"                                    
#  "MAT"                                    
# "SEX"                                    
# "PHENOTYPE"                              
#  "X19.11100234.T.C_T"                     
#  "X19.11100236.C.G_C"                     
# "X19.11100346.G.A_G"                     
# "X19.11102741.G.A_G"                     
# "X19.11102787.G.A_G"                     
# "X19.11105408.G.A_G"                     
# "X19.11105436.C.T_C"                     
# "X19.11105496.G.A_G"                     
# "X19.11105528.G.A_G"                     
# "X19.11105550.G.A_G"                     
# "X19.11105556.ATGG.A_ATGG"               
# "X19.11105565.C.CCGACTGCAAGGACAAATCTGA_C"
# "X19.11105567.G.A_G"                     
# "X19.11105568.A.G_A"                     
# "X19.11105572.C.A_C"                     
# "X19.11105585.GAC.G_GAC"                 
# "X19.11105588.G.C_G"                     
# "X19.11106631.A.C_A"                     
# "X19.11106642.G.T_G"                     
# "X19.11107436.G.A_G"                     
# "X19.11107484.G.A_G"                     
# "X19.11110688.C.G_C"                     
# "X19.11110738.G.A_G"                     
# "X19.11111513.G.C_G"                     
# "X19.11111571.G.A_G"                     
# "X19.11111582.T.G_T"                     
# "X19.11113268.G.A_G"                     
# "X19.11113292.C.G_C"                     
# "X19.11113307.C.T_C"                     
# "X19.11113337.C.T_C"                     
# "X19.11113338.G.A_G"                     
# "X19.11113343.G.A_G"                     
# "X19.11113348.C.G_C"                     
# "X19.11113534.G.A_G"                     
# "X19.11113566.TC.T_TC"                   
# "X19.11113608.G.A_G"                     
# "X19.11113620.G.A_G"                     
# "X19.11113743.G.A_G"                     
# "X19.11116125.G.A_G"                     
# "X19.11116153.G.A_G"                     
# "X19.11116198.A.G_A"                     
# "X19.11116880.A.G_A"                     
# "X19.11116900.C.T_C"                     
# "X19.11116928.G.A_G"                     
# "X19.11116936.C.T_C"                     
# "X19.11120143.C.T_C"                     
# "X19.11120197.GAT.G_GAT"                 
# "X19.11120435.C.T_C"                     
# "X19.11120436.C.T_C"                     
# "X19.11123248.C.T_C"                     
# "X19.11123263.C.T_C"                     
# "X19.11129534.T.TG_T"                    
# "X19.11129598.C.A_C"                     
# "X19.11129599.C.T_C"                     
# "X19.11129606.A.G_A"                     

#Begin the process of generating results that be used for counts across the pathogenic variants (individual tables and combined table in the same style as the Protective variant method)
#LDLR Extraction
LDLR_Pathogenic <- LDLR_Raw_Pathogenic[match(intersect(Main_Cohort$ID_1, LDLR_Raw_Pathogenic$FID), LDLR_Raw_Pathogenic$FID),]
dim(LDLR_Pathogenic)
# 50161    61

V2_LDLR_Pathogenic <- LDLR_Pathogenic[which(LDLR_Pathogenic$X19.11100234.T.C_T  == 1 | LDLR_Pathogenic$X19.11100236.C.G_C  == 1 | LDLR_Pathogenic$X19.11100346.G.A_G  == 1 | LDLR_Pathogenic$X19.11102741.G.A_G  == 1 | LDLR_Pathogenic$X19.11102787.G.A_G  == 1 | LDLR_Pathogenic$X19.11105408.G.A_G  == 1 | LDLR_Pathogenic$X19.11105436.C.T_C  == 1 | LDLR_Pathogenic$X19.11105496.G.A_G  == 1 | LDLR_Pathogenic$X19.11105528.G.A_G  == 1 | LDLR_Pathogenic$X19.11105550.G.A_G  == 1 | LDLR_Pathogenic$X19.11105556.ATGG.A_ATGG  == 1 | LDLR_Pathogenic$X19.11105565.C.CCGACTGCAAGGACAAATCTGA_C  == 1 | LDLR_Pathogenic$X19.11105567.G.A_G  == 1 | LDLR_Pathogenic$X19.11105568.A.G_A  == 1 | LDLR_Pathogenic$X19.11105572.C.A_C  == 1 | LDLR_Pathogenic$X19.11105585.GAC.G_GAC  == 1 | LDLR_Pathogenic$X19.11105588.G.C_G  == 1 | LDLR_Pathogenic$X19.11106631.A.C_A  == 1 | LDLR_Pathogenic$X19.11106642.G.T_G  == 1 | LDLR_Pathogenic$X19.11107436.G.A_G  == 1 | LDLR_Pathogenic$X19.11107484.G.A_G  == 1 | LDLR_Pathogenic$X19.11110688.C.G_C  == 1 | LDLR_Pathogenic$X19.11110738.G.A_G  == 1 | LDLR_Pathogenic$X19.11111513.G.C_G  == 1 | LDLR_Pathogenic$X19.11111571.G.A_G  == 1 | LDLR_Pathogenic$X19.11111582.T.G_T  == 1 | LDLR_Pathogenic$X19.11113268.G.A_G  == 1 | LDLR_Pathogenic$X19.11113292.C.G_C  == 1 | LDLR_Pathogenic$X19.11113307.C.T_C  == 1 | LDLR_Pathogenic$X19.11113337.C.T_C  == 1 | LDLR_Pathogenic$X19.11113338.G.A_G  == 1 | LDLR_Pathogenic$X19.11113343.G.A_G  == 1 | LDLR_Pathogenic$X19.11113348.C.G_C  == 1 | LDLR_Pathogenic$X19.11113534.G.A_G  == 1 | LDLR_Pathogenic$X19.11113566.TC.T_TC  == 1 | LDLR_Pathogenic$X19.11113608.G.A_G  == 1 | LDLR_Pathogenic$X19.11113620.G.A_G  == 1 | LDLR_Pathogenic$X19.11113743.G.A_G  == 1 | LDLR_Pathogenic$X19.11116125.G.A_G  == 1 | LDLR_Pathogenic$X19.11116153.G.A_G  == 1 | LDLR_Pathogenic$X19.11116198.A.G_A  == 1 | LDLR_Pathogenic$X19.11116880.A.G_A  == 1 | LDLR_Pathogenic$X19.11116900.C.T_C  == 1 | LDLR_Pathogenic$X19.11116928.G.A_G  == 1 | LDLR_Pathogenic$X19.11116936.C.T_C  == 1 | LDLR_Pathogenic$X19.11120143.C.T_C  == 1 | LDLR_Pathogenic$X19.11120197.GAT.G_GAT  == 1 | LDLR_Pathogenic$X19.11120435.C.T_C  == 1 | LDLR_Pathogenic$X19.11120436.C.T_C  == 1 | LDLR_Pathogenic$X19.11123248.C.T_C  == 1 | LDLR_Pathogenic$X19.11123263.C.T_C  == 1 | LDLR_Pathogenic$X19.11129534.T.TG_T == 1 | LDLR_Pathogenic$X19.11129598.C.A_C == 1 | LDLR_Pathogenic$X19.11129599.C.T_C == 1 | LDLR_Pathogenic$X19.11129606.A.G_A == 1),]
dim(V2_LDLR_Pathogenic)
# 100  61

summary(as.factor(LDLR_Pathogenic$X19.11100234.T.C_T))
#    2  NA's 
#    50158     3 
summary(as.factor(LDLR_Pathogenic$X19.11100236.C.G_C))
#    1     2 
#    3 50158 
summary(as.factor(LDLR_Pathogenic$X19.11100346.G.A_G))
#    1     2  NA's 
#    1 50152     8 
summary(as.factor(LDLR_Pathogenic$X19.11102741.G.A_G))
#    1     2  NA's 
#    1 50159     1 
summary(as.factor(LDLR_Pathogenic$X19.11102787.G.A_G))
#    1     2  NA's 
#    5 50144    12 
summary(as.factor(LDLR_Pathogenic$X19.11105408.G.A_G))
#    1     2  NA's 
#    1 50159     1 
summary(as.factor(LDLR_Pathogenic$X19.11105436.C.T_C))
#    1     2  NA's 
#    7 50153     1 
summary(as.factor(LDLR_Pathogenic$X19.11105496.G.A_G))
#    1     2 
#    8 50153 
summary(as.factor(LDLR_Pathogenic$X19.11105528.G.A_G))
#    1     2  NA's 
#    1 50145    15 
summary(as.factor(LDLR_Pathogenic$X19.11105550.G.A_G))
#    1     2  NA's 
#    1 50156     4 
summary(as.factor(LDLR_Pathogenic$X19.11105556.ATGG.A_ATGG))
#    1     2  NA's 
#    4 50105    52 
summary(as.factor(LDLR_Pathogenic$X19.11105565.C.CCGACTGCAAGGACAAATCTGA_C))
#    2  NA's 
#    50158     3 
summary(as.factor(LDLR_Pathogenic$X19.11105567.G.A_G))
#    1     2  NA's 
#    2 50151     8 
summary(as.factor(LDLR_Pathogenic$X19.11105568.A.G_A))
#    1     2  NA's 
#    1 50144    16 
summary(as.factor(LDLR_Pathogenic$X19.11105572.C.A_C))
#    1     2  NA's 
#    1 49618   542 
summary(as.factor(LDLR_Pathogenic$X19.11105585.GAC.G_GAC))
#    2  NA's 
#    49157  1004 
summary(as.factor(LDLR_Pathogenic$X19.11105588.G.C_G))
#    1     2  NA's 
#    2 50150     9 
summary(as.factor(LDLR_Pathogenic$X19.11106631.A.C_A))
#    1     2 
#    1 50160 
summary(as.factor(LDLR_Pathogenic$X19.11106642.G.T_G))
#    1     2 
#    1 50160 
summary(as.factor(LDLR_Pathogenic$X19.11107436.G.A_G))
#    1     2 
#    5 50156 
summary(as.factor(LDLR_Pathogenic$X19.11107484.G.A_G))
#    1     2 
#    2 50159 
summary(as.factor(LDLR_Pathogenic$X19.11110688.C.G_C))
#    1     2 
#    1 50160 
summary(as.factor(LDLR_Pathogenic$X19.11110738.G.A_G))
#    1     2  NA's 
#    5 50153     3 
summary(as.factor(LDLR_Pathogenic$X19.11111513.G.C_G))
#    1     2  NA's 
#    2 50151     8 
summary(as.factor(LDLR_Pathogenic$X19.11111571.G.A_G))
#    1     2  NA's 
#    1 50116    44 
summary(as.factor(LDLR_Pathogenic$X19.11111582.T.G_T))
#    1     2  NA's 
#    1 50064    96 
summary(as.factor(LDLR_Pathogenic$X19.11113268.G.A_G))
#    1     2  NA's 
#    1 50142    18 
summary(as.factor(LDLR_Pathogenic$X19.11113292.C.G_C))
#    1     2  NA's 
#    1 50158     2 
summary(as.factor(LDLR_Pathogenic$X19.11113307.C.T_C))
#    1     2 
#    2 50159 
summary(as.factor(LDLR_Pathogenic$X19.11113337.C.T_C))
#    1     2  NA's 
#    2 50158     1 
summary(as.factor(LDLR_Pathogenic$X19.11113338.G.A_G))
#    1     2  NA's 
#    1 50159     1 
summary(as.factor(LDLR_Pathogenic$X19.11113343.G.A_G))
#    1     2  NA's 
#    1 50157     3 
summary(as.factor(LDLR_Pathogenic$X19.11113348.C.G_C))
#    1     2  NA's 
#    1 50159     1 
summary(as.factor(LDLR_Pathogenic$X19.11113534.G.A_G))
#    1     2  NA's 
#    1 50150    10 
summary(as.factor(LDLR_Pathogenic$X19.11113566.TC.T_TC))
#    1     2  NA's 
#    1 50154     6 
summary(as.factor(LDLR_Pathogenic$X19.11113608.G.A_G))
#    1     2  NA's 
#    3 50157     1 
summary(as.factor(LDLR_Pathogenic$X19.11113620.G.A_G))
#    1     2 
#    1 50160 
summary(as.factor(LDLR_Pathogenic$X19.11113743.G.A_G))
#    1     2  NA's 
#    2 50144    15 
summary(as.factor(LDLR_Pathogenic$X19.11116125.G.A_G))
#    2  NA's 
#   50146    15 
summary(as.factor(LDLR_Pathogenic$X19.11116153.G.A_G))
#    1     2  NA's 
#    1 50158     2 
summary(as.factor(LDLR_Pathogenic$X19.11116198.A.G_A))
#    1     2  NA's 
#    5 50144    12 
summary(as.factor(LDLR_Pathogenic$X19.11116880.A.G_A))
#    1     2  NA's 
#    1 50156     4 
summary(as.factor(LDLR_Pathogenic$X19.11116900.C.T_C))
#    1     2  NA's 
#    3 50152     6 
summary(as.factor(LDLR_Pathogenic$X19.11116928.G.A_G))
#    1     2  NA's 
#    2 50157     2 
summary(as.factor(LDLR_Pathogenic$X19.11116936.C.T_C))
#    2  NA's 
#   50154     7 
summary(as.factor(LDLR_Pathogenic$X19.11120143.C.T_C))
#    1     2  NA's 
#    4 50154     3 
summary(as.factor(LDLR_Pathogenic$X19.11120197.GAT.G_GAT))
#    1     2  NA's 
#    1 50122    38 
summary(as.factor(LDLR_Pathogenic$X19.11120435.C.T_C))
#    1     2  NA's 
#    1 50154     6 
summary(as.factor(LDLR_Pathogenic$X19.11120436.C.T_C))
#    1     2  NA's 
#    1 50155     5 
summary(as.factor(LDLR_Pathogenic$X19.11123248.C.T_C))
#    1     2  NA's 
#    1 50147    13 
summary(as.factor(LDLR_Pathogenic$X19.11123263.C.T_C))
#    1     2  NA's 
#    3 50150     8 
summary(as.factor(LDLR_Pathogenic$X19.11129534.T.TG_T))
#    1     2  NA's 
#    1 50158     2 
summary(as.factor(LDLR_Pathogenic$X19.11129598.C.A_C))
#   2  NA's 
#  50157  4 
summary(as.factor(LDLR_Pathogenic$X19.11129599.C.T_C))
#    1     2  NA's 
#    1 50157     3 
summary(as.factor(LDLR_Pathogenic$X19.11129606.A.G_A))
#    1     2  NA's 
#    1 50156     4 

#APOB Extraction
APOB_Pathogenic <- APOB_Raw_Pathogenic[match(intersect(Main_Cohort$ID_1, APOB_Raw_Pathogenic$FID), APOB_Raw_Pathogenic$FID),]
dim(APOB_Pathogenic)
# 50161    17

V2_APOB_Pathogenic <- APOB_Pathogenic[which(APOB_Pathogenic$X2.21005155.TG.T_TG  == 1 | APOB_Pathogenic$X2.21005468.A.C_A  == 1 | APOB_Pathogenic$X2.21006288.C.T_C  == 1 | APOB_Pathogenic$X2.21006289.G.A_G  == 1 | APOB_Pathogenic$X2.21007748.TGAAAA.T_TGAAAA  == 1 | APOB_Pathogenic$X2.21010615.G.A_G  == 1 | APOB_Pathogenic$X2.21011303.A.AG_A  == 1 | APOB_Pathogenic$X2.21013379.G.A_G  == 1 | APOB_Pathogenic$X2.21019880.T.TAG_T  == 1 | APOB_Pathogenic$X2.21029900.G.A_G  == 1 | APOB_Pathogenic$X2.21038086.C.A_C == 1),]
dim(V2_APOB_Pathogenic)
# 45 17

summary(as.factor(APOB_Pathogenic$X2.21005155.TG.T_TG))
#    1     2 
#    1 50160 
summary(as.factor(APOB_Pathogenic$X2.21005468.A.C_A))
#    1     2 
#    1 50160
summary(as.factor(APOB_Pathogenic$X2.21006288.C.T_C))
#    1     2 
#   31 50130 
summary(as.factor(APOB_Pathogenic$X2.21006289.G.A_G))
#    1     2 
#    4 50157 
summary(as.factor(APOB_Pathogenic$X2.21007748.TGAAAA.T_TGAAAA))
#    1     2  NA's 
#    2 50157     2 
summary(as.factor(APOB_Pathogenic$X2.21010615.G.A_G))
#    1     2 
#    1 50160
summary(as.factor(APOB_Pathogenic$X2.21011303.A.AG_A))
#    1     2 
#    1 50160
summary(as.factor(APOB_Pathogenic$X2.21013379.G.A_G))
#    1     2 
#    1 50160
summary(as.factor(APOB_Pathogenic$X2.21019880.T.TAG_T))
#     1     2  NA's 
#    1 50149    11 
summary(as.factor(APOB_Pathogenic$X2.21029900.G.A_G))
#    1     2  NA's 
#    1 50141    19 
summary(as.factor(APOB_Pathogenic$X2.21038086.C.A_C))
#    1     2 
#    1 50160 

#PCSK9 Pathogenic Extraction
PCSK9_Pathogenic <- PCSK9_Raw_Pathogenic[match(intersect(Main_Cohort$ID_1, PCSK9_Raw_Pathogenic$FID), PCSK9_Raw_Pathogenic$FID),]
dim(PCSK9_Pathogenic)
# 50161     8

V2_PCSK9_Pathogenic <- PCSK9_Pathogenic[which(PCSK9_Pathogenic$X1.55039931.G.A_G ==1 | PCSK9_Pathogenic$X1.55052398.G.A_G == 1),]
dim(V2_PCSK9_Pathogenic)
# 8 8

summary(as.factor(PCSK9_Pathogenic$X1.55039931.G.A_G))
#    1     2  NA's 
#    7 50152     2 
summary(as.factor(PCSK9_Pathogenic$X1.55052398.G.A_G))
#    1     2
#    1 50160 

#Need to create an aggregate score for the high risk variants
dim(V2_LDLR_Pathogenic[match(intersect(V2_LDLR_Pathogenic$FID, V2_APOB_Pathogenic$FID), V2_LDLR_Pathogenic$FID),])
#  0 61
dim(V2_LDLR_Pathogenic[match(intersect(V2_LDLR_Pathogenic$FID, V2_PCSK9_Pathogenic$FID), V2_LDLR_Pathogenic$FID),])
#  0 61
dim(V2_APOB_Pathogenic[match(intersect(V2_PCSK9_Pathogenic$FID, V2_APOB_Pathogenic$FID), V2_APOB_Pathogenic$FID),])
#  0 17
#Based on the lack of intersects, we can just add the samples together
nrow(V2_LDLR_Pathogenic) + nrow(V2_APOB_Pathogenic) + nrow(V2_PCSK9_Pathogenic)
# 153
q()
