#The goal of this file is to try to work through extracting the sites used for eMERGE with the sites found in the array data for BioMe
library(data.table)
Array <- fread("/sc/arion/projects/igh/data/MSM/data/common_variants/combined/batch_001/variants/SINAI_MILLION_SUBSET_QC.bim")
dim(Array)
# 506550      6
colnames(Array)
# "V1" "V2" "V3" "V4" "V5" "V6"
head(Array, 5)
#      V1          V2    V3     V4     V5     V6
#   <int>      <char> <int>  <int> <char> <char>
#1:     1 rs116452738     0 899450      A      G
#2:     1   rs4970383     0 903175      A      C
#3:     1  rs28678693     0 903285      C      T
#4:     1   rs4475691     0 911428      T      C
#5:     1 rs151325546     0 914993      G      A
#Plink failed to extract from this file because the ids were not m atching between the Array and the sites file (Array is rsids while sites file is CHR:POS:A1:A2)
colnames(Array) <- c("CHR", "SNP", "CPM", "POS", "A1", "A2")
colnames(Array)
# "CHR" "SNP" "CPM" "POS" "A1"  "A2" 
Array$ID1 <- paste(Array$CHR, Array$POS, Array$A1, Array$A2, sep=":")
head(Array, 5)
#     CHR         SNP   CPM    POS     A1     A2          ID1
#   <int>      <char> <int>  <int> <char> <char>       <char>
#1:     1 rs116452738     0 899450      A      G 1:899450:A:G
#2:     1   rs4970383     0 903175      A      C 1:903175:A:C
#3:     1  rs28678693     0 903285      C      T 1:903285:C:T
#4:     1   rs4475691     0 911428      T      C 1:911428:T:C
#5:     1 rs151325546     0 914993      G      A 1:914993:G:A
Array$ID2 <- paste(Array$CHR, Array$POS, Array$A2, Array$A1, sep=":")
head(Array, 5)
#     CHR         SNP   CPM    POS     A1     A2          ID1          ID2
#   <int>      <char> <int>  <int> <char> <char>       <char>       <char>
#1:     1 rs116452738     0 899450      A      G 1:899450:A:G 1:899450:G:A
#2:     1   rs4970383     0 903175      A      C 1:903175:A:C 1:903175:C:A
#3:     1  rs28678693     0 903285      C      T 1:903285:C:T 1:903285:T:C
#4:     1   rs4475691     0 911428      T      C 1:911428:T:C 1:911428:C:T
#5:     1 rs151325546     0 914993      G      A 1:914993:G:A 1:914993:A:G
#Now to read in the file sent from Chris
eMERGE_Sites <- fread("eMERGE_prs_adjustment_files_from_Chris_060425/eMERGE_prs_adjustment.pc.sites", header=F)
colnames(eMERGE_Sites)
# "V1"
dim(eMERGE_Sites)
# 321392      1
dim(Array[match(intersect(eMERGE_Sites$V1, Array$ID1), Array$ID1),])
# 739   8
dim(Array[match(intersect(eMERGE_Sites$V1, Array$ID2), Array$ID2),])
# 742   8
Data_Ark_Array <- fread("/sc/arion/projects/data-ark/CBIPM/Microarray/combined/imputed_TOPMED_V2/plink/GSA_GDA_V2_TOPMED_HG38.bim")
dim(Data_Ark_Array)
# 60491206        6
colnames(Data_Ark_Array)
# "V1" "V2" "V3" "V4" "V5" "V6"
head(Data_Ark_Array, 5)
#      V1              V2    V3     V4     V5     V6
#   <int>          <char> <int>  <int> <char> <char>
#1:     1 chr1:101016:A:G     0 101016      G      A
#2:     1 chr1:275732:C:T     0 275732      T      C
#3:     1 chr1:608590:G:A     0 608590      A      G
#4:     1 chr1:664066:A:C     0 664066      C      A
#5:     1 chr1:701185:A:G     0 701185      G      A
colnames(Data_Ark_Array) <- c("CHR", "SNP", "CPM", "POS", "A1", "A2")
Data_Ark_Array$ALt_SNP1 <- paste(Data_Ark_Array$CHR, Data_Ark_Array$POS, Data_Ark_Array$A1, Data_Ark_Array$A2, sep=":")
Data_Ark_Array$ALt_SNP2 <- paste(Data_Ark_Array$CHR, Data_Ark_Array$POS, Data_Ark_Array$A2, Data_Ark_Array$A1, sep=":")
dim(Data_Ark_Array[match(intersect(eMERGE_Sites$V1, Data_Ark_Array$ALt_SNP1), Data_Ark_Array$ALt_SNP1),])
# 2506    8
dim(Data_Ark_Array[match(intersect(eMERGE_Sites$V1, Data_Ark_Array$ALt_SNP2), Data_Ark_Array$ALt_SNP2),])
# 2456    8
#In both of these cases, the issue lies in not being able to pull the results from the array sites
#Will try this with the info file for the bgen data 
Info_File <- fread("/sc/arion/projects/igh/data/MSM/data/common_variants/combined/batch_001/imputed_TOPMED/addition/info/GSA_GSX_INFO_TOPMED.txt")
dim(Info_File)
# 83496273       19
colnames(Info_File)
# [1] "alternate_ids"          "rsid"                   "chromosome"            
# [4] "position"               "alleleA"                "alleleB"               
# [7] "minor_allele"           "major_allele"           "minor_allele_frequency"
#[10] "GSA1_MAF"               "GSA1_R2"                "GSA2_MAF"              
#[13] "GSA2_R2"                "GSX1_MAF"               "GSX1_R2"               
#[16] "GSX2_MAF"               "GSX2_R2"                "impute_info"           
#[19] "FULL_R2"    
head(Info_File, 5)
#        alternate_ids         rsid chromosome position alleleA alleleB
#               <char>       <char>     <char>    <int>  <char>  <char>
#1:    chr1:125346:G:C            .       chr1   125346       G       C
#2:    chr1:125408:C:G            .       chr1   125408       C       G
#3:   chr1:133202:AC:A rs1384665348       chr1   133202      AC       A
#4:    chr1:133401:G:A rs1028943631       chr1   133401       G       A
#5: chr1:139393:GCCA:G rs1248602387       chr1   139393    GCCA       G
#   minor_allele major_allele minor_allele_frequency    GSA1_MAF  GSA1_R2
#         <char>       <char>                  <num>       <num>    <num>
#1:            C            G            4.54764e-05 3.32114e-05 0.624819
#2:            G            C            2.37197e-05 1.76623e-05 0.552035
#3:            A           AC            3.55305e-05 2.93635e-05 0.622572
#4:            A            G            5.16599e-05 4.48180e-05 0.507679
#5:            G         GCCA            4.59344e-05 4.05917e-05 0.585404
#      GSA2_MAF  GSA2_R2    GSX1_MAF  GSX1_R2    GSX2_MAF  GSX2_R2 impute_info
#         <num>    <num>       <num>    <num>       <num>    <num>       <num>
#1: 3.97111e-05 0.533673 3.50386e-05 0.538254 7.97789e-05 0.445545    0.526050
#2: 1.41307e-05 0.234177 2.56501e-05 0.543903 3.91101e-05 0.587198    0.513130
#3: 5.02776e-05 0.588265 3.65620e-05 0.307535 2.58608e-05 0.235424    0.471891
#4: 6.07810e-05 0.671947 3.90420e-05 0.575207 6.73445e-05 0.638950    0.623738
#5: 4.36853e-05 0.605949 6.02990e-05 0.372500 4.03500e-05 0.668902    0.543027
#     FULL_R2
#       <num>
#1: 0.5355728
#2: 0.4793283
#3: 0.4384490
#4: 0.5984457
#5: 0.5581888
Info_File$CHRNUM <- gsub("chr", "", Info_File$chromosome)
head(Info_File$CHRNUM, 5)
# "1" "1" "1" "1" "1"
#Good, the method worked
Info_File$DIFF_ID1 <- gsub("chr", "", Info_File$alternate_ids)
head(Info_File$DIFF_ID1, 5)
#[1] "1:125346:G:C"    "1:125408:C:G"    "1:133202:AC:A"   "1:133401:G:A"
#[5] "1:139393:GCCA:G"
#Method worked
dim(Info_File[match(intersect(eMERGE_Sites$V1, Info_File$DIFF_ID1), Info_File$DIFF_ID1),])
# 2870   21
#These were the most thus far with the files, but the issue of not pulling all the sites remains. Will try 2 different apporaches and see if that salvages anything worthwhile
Info_File$DIFF_ID2 <- paste(Info_File$CHRNUM, Info_File$position, Info_File$alleleA, Info_File$alleleB, sep=":")
Info_File$DIFF_ID3 <- paste(Info_File$CHRNUM, Info_File$position, Info_File$alleleB, Info_File$alleleA, sep=":")
dim(Info_File[match(intersect(eMERGE_Sites$V1, Info_File$DIFF_ID2), Info_File$DIFF_ID2),])
# 2870   23
#The same number as ID1, showing this is how the alternative_ids column was generated
dim(Info_File[match(intersect(eMERGE_Sites$V1, Info_File$DIFF_ID3), Info_File$DIFF_ID3),])
# 2914   23
#Still have the issue that even if the renamed snp ids were retained, these are not nearly the amount for PC pruning used in eMERGE, meaning that there are issues with how the data is extracted from eMERGE and our PCs because majority of the variants are not in the BioMe genomic dataset
#Only other thing to test is if the other snps are even if the other coordinates exist to begin with
Info_File$Coordinate <- paste(Info_File$CHRNUM, Info_File$position, sep=":")
head(Info_File$Coordinate, 5)
# "1:125346" "1:125408" "1:133202" "1:133401" "1:139393"
Check_Sites <- data.frame(do.call('rbind', strsplit(as.character(eMERGE_Sites$V1), ':', fixed=TRUE)))
dim(Check_Sites)
# 321392      4
colnames(Check_Sites)
# "X1" "X2" "X3" "X4"
head(Check_Sites, 4)
#  X1     X2 X3 X4
#1  1 737263  A  G
#2  1 754429  G  T
#3  1 761764  A  G
#4  1 762320  C  T
colnames(Check_Sites) <- c("CHR", "POS", "A1", "A2")
Check_Sites$Coordinate <- paste(Check_Sites$CHR, Check_Sites$POS, sep=":")
dim(Info_File[match(intersect(Check_Sites$Coordinate, Info_File$Coordinate), Info_File$Coordinate),])
# 12985    24
(12985/321392)*100
# 4.040237
#This was a lost cost, with only 4% of the snps having the same coordinates as the emerge pc snps
q()
