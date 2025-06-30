#Shows the KING commands used to generate the relatedness between groups of people per ethnicity and race
ml king/2.3.2

king -b Sinead_Data_Travis_QC/Similar_QC_AFR_Main_Adult_Cohort_062625.bed --related --degree 2 --prefix Similar_Related_AFR

king -b Sinead_Data_Travis_QC/Similar_QC_EUR_Main_Adult_Cohort_062625.bed --related --degree 2 --prefix Similar_Related_EUR

king -b Sinead_Data_Travis_QC/Similar_QC_HIS_Main_Adult_Cohort_062625.bed --related --degree 2 --prefix Similar_Related_HIS

king -b Sinead_Data_Travis_QC/Similar_QC_EAS_Main_Adult_Cohort_062625.bed --related --degree 2 --prefix Similar_Related_EAS

king -b Sinead_Data_Travis_QC/Similar_QC_SAS_Main_Adult_Cohort_062625.bed --related --degree 2 --prefix Similar_Related_SAS

king -b Sinead_Data_Travis_QC/Similar_QC_JEWISH_Main_Adult_Cohort_062625.bed --related --degree 2 --prefix Similar_Related_JEWISH

king -b Sinead_Data_Travis_QC/Similar_QC_MULTI_ETH_Main_Adult_Cohort_062625.bed --related --degree 2 --prefix Similar_Related_MULTI_ETH

king -b Sinead_Data_Travis_QC/Similar_QC_NAT_AMER_Main_Adult_Cohort_062625.bed --related --degree 2 --prefix Similar_Related_NAT_AMR

king -b Sinead_Data_Travis_QC/Similar_QC_OTH_Main_Adult_Cohort_062625.bed --related --degree 2 --prefix Similar_Related_OTHER



