ml plink

#Subsetting by ancestry
plink --bfile /sc/arion/projects/igh/data/MSM/data/common_variants/combined/batch_001/variants/SINAI_MILLION_SUBSET_QC --keep African_American_Main_Adult_Cohort_Sinead_Race_Assignment_062425.txt --make-bed --out Sinead_Settings_Ancestry/AFR_Sinead_Settings_Main_Adult_Cohort_062625

plink --bfile /sc/arion/projects/igh/data/MSM/data/common_variants/combined/batch_001/variants/SINAI_MILLION_SUBSET_QC --keep European_American_Main_Adult_Cohort_Sinead_Race_Assignment_062425.txt --make-bed --out Sinead_Settings_Ancestry/EUR_Sinead_Settings_Main_Adult_Cohort_062625

plink --bfile /sc/arion/projects/igh/data/MSM/data/common_variants/combined/batch_001/variants/SINAI_MILLION_SUBSET_QC --keep East_Asian_American_Main_Adult_Cohort_Sinead_Race_Assignment_062425.txt --make-bed --out Sinead_Settings_Ancestry/EAS_Sinead_Settings_Main_Adult_Cohort_062625

plink --bfile /sc/arion/projects/igh/data/MSM/data/common_variants/combined/batch_001/variants/SINAI_MILLION_SUBSET_QC --keep Southeast_Asian_American_Main_Adult_Cohort_Sinead_Race_Assignment_062425.txt --make-bed --out Sinead_Settings_Ancestry/SAS_Sinead_Settings_Main_Adult_Cohort_062625

plink --bfile /sc/arion/projects/igh/data/MSM/data/common_variants/combined/batch_001/variants/SINAI_MILLION_SUBSET_QC --keep Hispanic_American_Main_Adult_Cohort_Sinead_Race_Assignment_062425.txt --make-bed --out Sinead_Settings_Ancestry/HIS_Sinead_Settings_Main_Adult_Cohort_062625

plink --bfile /sc/arion/projects/igh/data/MSM/data/common_variants/combined/batch_001/variants/SINAI_MILLION_SUBSET_QC --keep Jewish_American_Main_Adult_Cohort_Sinead_Race_Assignment_062425.txt --make-bed --out Sinead_Settings_Ancestry/JEWISH_Sinead_Settings_Main_Adult_Cohort_062625

plink --bfile /sc/arion/projects/igh/data/MSM/data/common_variants/combined/batch_001/variants/SINAI_MILLION_SUBSET_QC --keep Native_American_Main_Adult_Cohort_Sinead_Race_Assignment_062425.txt --make-bed --out Sinead_Settings_Ancestry/NAT_AMER_Sinead_Settings_Main_Adult_Cohort_062625

plink --bfile /sc/arion/projects/igh/data/MSM/data/common_variants/combined/batch_001/variants/SINAI_MILLION_SUBSET_QC --keep Multiethnic_American_Main_Adult_Cohort_Sinead_Race_Assignment_062425.txt --make-bed --out Sinead_Settings_Ancestry/MultiEth_Sinead_Settings_Main_Adult_Cohort_062625

plink --bfile /sc/arion/projects/igh/data/MSM/data/common_variants/combined/batch_001/variants/SINAI_MILLION_SUBSET_QC --keep Other_Ethnicities_Main_Adult_Cohort_Sinead_Race_Assignment_062425.txt --make-bed --out Sinead_Settings_Ancestry/Other_Sinead_Settings_Main_Adult_Cohort_062625

#Travis QCs
plink --bfile Sinead_Settings_Ancestry/EUR_Sinead_Settings_Main_Adult_Cohort_062625 --maf 0.01 --hwe 1e-6 --mind 0.5 --geno 0.05 --make-bed --out Sinead_Data_Travis_QC/Similar_QC_EUR_Main_Adult_Cohort_062625

plink --bfile Sinead_Settings_Ancestry/AFR_Sinead_Settings_Main_Adult_Cohort_062625 --maf 0.01 --hwe 1e-6 --mind 0.5 --geno 0.05 --make-bed --out Sinead_Data_Travis_QC/Similar_QC_AFR_Main_Adult_Cohort_062625

plink --bfile Sinead_Settings_Ancestry/EAS_Sinead_Settings_Main_Adult_Cohort_062625 --maf 0.01 --hwe 1e-6 --mind 0.5 --geno 0.05 --make-bed --out Sinead_Data_Travis_QC/Similar_QC_EAS_Main_Adult_Cohort_062625

plink --bfile Sinead_Settings_Ancestry/SAS_Sinead_Settings_Main_Adult_Cohort_062625 --maf 0.01 --hwe 1e-6 --mind 0.5 --geno 0.05 --make-bed --out Sinead_Data_Travis_QC/Similar_QC_SAS_Main_Adult_Cohort_062625

plink --bfile Sinead_Settings_Ancestry/HIS_Sinead_Settings_Main_Adult_Cohort_062625 --maf 0.01 --hwe 1e-6 --mind 0.5 --geno 0.05 --make-bed --out Sinead_Data_Travis_QC/Similar_QC_HIS_Main_Adult_Cohort_062625

plink --bfile Sinead_Settings_Ancestry/JEWISH_Sinead_Settings_Main_Adult_Cohort_062625 --maf 0.01 --hwe 1e-6 --mind 0.5 --geno 0.05 --make-bed --out Sinead_Data_Travis_QC/Similar_QC_JEWISH_Main_Adult_Cohort_062625

plink --bfile Sinead_Settings_Ancestry/NAT_AMER_Sinead_Settings_Main_Adult_Cohort_062625 --maf 0.01 --hwe 1e-6 --mind 0.5 --geno 0.05 --make-bed --out Sinead_Data_Travis_QC/Similar_QC_NAT_AMER_Main_Adult_Cohort_062625

plink --bfile Sinead_Settings_Ancestry/MultiEth_Sinead_Settings_Main_Adult_Cohort_062625 --maf 0.01 --hwe 1e-6 --mind 0.5 --geno 0.05 --make-bed --out Sinead_Data_Travis_QC/Similar_QC_MULTI_ETH_Main_Adult_Cohort_062625

plink --bfile Sinead_Settings_Ancestry/Other_Sinead_Settings_Main_Adult_Cohort_062625 --maf 0.01 --hwe 1e-6 --mind 0.5 --geno 0.05 --make-bed --out Sinead_Data_Travis_QC/Similar_QC_OTH_Main_Adult_Cohort_062625


