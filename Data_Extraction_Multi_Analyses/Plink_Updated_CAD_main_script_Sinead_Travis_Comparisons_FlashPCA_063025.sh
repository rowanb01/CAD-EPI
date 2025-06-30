#Load scripts together
ml plink2/2.3
ml plink
ml flashpca/2.0

#Generate bgen and sample files with no rsid or . into  CHR:POS:A1:A2
for i in {1..22}; do plink2 --bgen /sc/arion/projects/MSM/data/common_variants/combined/batch_001/imputed_TOPMED/bgen/MSM_TOPMED.chr${i}.8bit.bgen ref-first --sample /sc/arion/projects/MSM/data/common_variants/combined/batch_001/imputed_TOPMED/bgen/MSM_TOPMED.chr${i}.sample --keep For_CAD_Samples_062425.txt --set-all-var-ids @:#:\$r:\$a --new-id-max-allele-len 1000 --export bgen-1.2 --out MSM_TOPMED_Renamed_chr${i}; done

#
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

#Travis QCs on Sinead Race Ethnicity Setting
plink --bfile Sinead_Settings_Ancestry/EUR_Sinead_Settings_Main_Adult_Cohort_062625 --maf 0.01 --hwe 1e-6 --mind 0.5 --geno 0.05 --make-bed --out Sinead_Data_Travis_QC/Similar_QC_EUR_Main_Adult_Cohort_062625

plink --bfile Sinead_Settings_Ancestry/AFR_Sinead_Settings_Main_Adult_Cohort_062625 --maf 0.01 --hwe 1e-6 --mind 0.5 --geno 0.05 --make-bed --out Sinead_Data_Travis_QC/Similar_QC_AFR_Main_Adult_Cohort_062625

plink --bfile Sinead_Settings_Ancestry/EAS_Sinead_Settings_Main_Adult_Cohort_062625 --maf 0.01 --hwe 1e-6 --mind 0.5 --geno 0.05 --make-bed --out Sinead_Data_Travis_QC/Similar_QC_EAS_Main_Adult_Cohort_062625

plink --bfile Sinead_Settings_Ancestry/SAS_Sinead_Settings_Main_Adult_Cohort_062625 --maf 0.01 --hwe 1e-6 --mind 0.5 --geno 0.05 --make-bed --out Sinead_Data_Travis_QC/Similar_QC_SAS_Main_Adult_Cohort_062625

plink --bfile Sinead_Settings_Ancestry/HIS_Sinead_Settings_Main_Adult_Cohort_062625 --maf 0.01 --hwe 1e-6 --mind 0.5 --geno 0.05 --make-bed --out Sinead_Data_Travis_QC/Similar_QC_HIS_Main_Adult_Cohort_062625

plink --bfile Sinead_Settings_Ancestry/JEWISH_Sinead_Settings_Main_Adult_Cohort_062625 --maf 0.01 --hwe 1e-6 --mind 0.5 --geno 0.05 --make-bed --out Sinead_Data_Travis_QC/Similar_QC_JEWISH_Main_Adult_Cohort_062625

plink --bfile Sinead_Settings_Ancestry/NAT_AMER_Sinead_Settings_Main_Adult_Cohort_062625 --maf 0.01 --hwe 1e-6 --mind 0.5 --geno 0.05 --make-bed --out Sinead_Data_Travis_QC/Similar_QC_NAT_AMER_Main_Adult_Cohort_062625

plink --bfile Sinead_Settings_Ancestry/MultiEth_Sinead_Settings_Main_Adult_Cohort_062625 --maf 0.01 --hwe 1e-6 --mind 0.5 --geno 0.05 --make-bed --out Sinead_Data_Travis_QC/Similar_QC_MULTI_ETH_Main_Adult_Cohort_062625

plink --bfile Sinead_Settings_Ancestry/Other_Sinead_Settings_Main_Adult_Cohort_062625 --maf 0.01 --hwe 1e-6 --mind 0.5 --geno 0.05 --make-bed --out Sinead_Data_Travis_QC/Similar_QC_OTH_Main_Adult_Cohort_062625

#Travis labeled code
for i in {1..22}; do plink2 --bgen MSM_TOPMED_Renamed_chr${i}.bgen ref-first --sample MSM_TOPMED_Renamed_chr${i}.sample --keep CAD_Samples_Travis_Ancestry_062725.txt --extract Norsid_V2_hg38_intersects_BioMe_eMERGE_prs_adjustment.pc.sites --export vcf --out VCF_CAD_for_FlashPCA_Original/Norsid_V2_CAD_Travis_Ancestry_chr${i}_063025; done

#Sinead Labeled Code
for i in {1..22}; do plink2 --bgen MSM_TOPMED_Renamed_chr${i}.bgen ref-first --sample MSM_TOPMED_Renamed_chr${i}.sample --keep CAD_Samples_Full_QC_Sinead_Race_Ethnicity_Labeled_062725.txt --extract Norsid_V2_hg38_intersects_BioMe_eMERGE_prs_adjustment.pc.sites --export vcf --out VCF_CAD_for_FlashPCA_Original/Norsid_V2_CAD_Sinead_Race_Ethnicity_chr${i}_063025; done

#Sinead Race and Ethnicity setting up for flashpca
for i in {1..22}; do plink2 --vcf VCF_CAD_for_FlashPCA_Original/Norsid_V2_CAD_Sinead_Race_Ethnicity_chr${i}_063025.vcf --make-bed --out Binary_CAD_for_FlashPCA_Original/Norsid_V2_CAD_Sinead_Race_Ethnicity_Binary_chr${i}_063025; done

plink --bfile Binary_CAD_for_FlashPCA_Original/Norsid_V2_CAD_Sinead_Race_Ethnicity_Binary_chr1_063025 --merge-list CAD_Travis_Ancestry_mergelist_V2.txt --make-bed --out Autosome_Sinead_Race_Ethnicity_Binary_CAD_for_FlashPCA_Stage2_063025

flashpca --bfile Autosome_Sinead_Race_Ethnicity_Binary_CAD_for_FlashPCA_Stage2_063025 --project --inmeansd Norsid_V2_hg38_intersects_BioMe_eMERGE_prs_adjustment.pc.meansd --outproj BioMe_Sinead_Race_Ethnicity_Projections_063025 --inload Norsid_V2_hg38_intersects_BioMe_eMERGE_prs_adjustment.pc.loadings -v

#Travis ancestry setting up for flashpca
for i in {1..22}; do plink2 --vcf VCF_CAD_for_FlashPCA_Original/Norsid_V2_CAD_Travis_Ancestry_chr${i}_063025.vcf --make-bed --out Binary_CAD_for_FlashPCA_Original/Norsid_V2_CAD_Travis_Ancestry_Binary_chr${i}_063025; done

plink --bfile Binary_CAD_for_FlashPCA_Original/Norsid_V2_CAD_Travis_Ancestry_Binary_chr1_063025 --merge-list CAD_Travis_Ancestry_mergelist_V2.txt --make-bed --out Autosome_Travis_Ancestry_Binary_CAD_for_FlashPCA_Stage2_063025

flashpca --bfile Autosome_Travis_Ancestry_Binary_CAD_for_FlashPCA_Stage2_063025 --project --inmeansd Norsid_V2_hg38_intersects_BioMe_eMERGE_prs_adjustment.pc.meansd --outproj BioMe_Travis_Ancestry_Projections_063025 --inload Norsid_V2_hg38_intersects_BioMe_eMERGE_prs_adjustment.pc.loadings -v



