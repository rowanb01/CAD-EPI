#This is to generate the alt ids and run that portion of the scripts so that we have what we need for the flashpca

#Generate the alt reference file
for i in {1..22}; do plink2 --bgen /sc/arion/projects/MSM/data/common_variants/combined/batch_001/imputed_TOPMED/bgen/MSM_TOPMED.chr${i}.8bit.bgen ref-first --sample /sc/arion/projects/MSM/data/common_variants/combined/batch_001/imputed_TOPMED/bgen/MSM_TOPMED.chr${i}.sample --keep For_CAD_Samples_062425.txt --set-all-var-ids @:#:\$a:\$r --new-id-max-allele-len 1000 --export bgen-1.2 --out MSM_TOPMED_ALT_Renamed_chr${i}; done

#Travis labeled code
for i in {1..22}; do plink2 --bgen MSM_TOPMED_ALT_Renamed_chr${i}.bgen ref-first --sample MSM_TOPMED_ALT_Renamed_chr${i}.sample --keep CAD_Samples_Travis_Ancestry_062725.txt --extract Norsid_V2_hg38_intersects_BioMe_eMERGE_prs_adjustment.pc.sites --export vcf --out VCF_CAD_for_FlashPCA_Original/Norsid_V3_CAD_Travis_Ancestry_chr${i}_063025; done

#Sinead Labeled Code
for i in {1..22}; do plink2 --bgen MSM_TOPMED_ALT_Renamed_chr${i}.bgen ref-first --sample MSM_TOPMED_ALT_Renamed_chr${i}.sample --keep CAD_Samples_Full_QC_Sinead_Race_Ethnicity_Labeled_062725.txt --extract Norsid_V2_hg38_intersects_BioMe_eMERGE_prs_adjustment.pc.sites --export vcf --out VCF_CAD_for_FlashPCA_Original/Norsid_V3_CAD_Sinead_Race_Ethnicity_chr${i}_063025; done

#Sinead Race and Ethnicity setting up for flashpca
for i in {1..22}; do plink2 --vcf VCF_CAD_for_FlashPCA_Original/Norsid_V3_CAD_Sinead_Race_Ethnicity_chr${i}_063025.vcf --make-bed --out Binary_CAD_for_FlashPCA_Original/Norsid_V3_CAD_Sinead_Race_Ethnicity_Binary_chr${i}_070125; done

plink --bfile Binary_CAD_for_FlashPCA_Original/Norsid_V3_CAD_Sinead_Race_Ethnicity_Binary_chr1_070125 --merge-list CAD_Sinead_Race_Ethnicity_Ancestry_mergelist_V3.txt --make-bed --out Autosome_Sinead_Race_Ethnicity_Binary_CAD_for_FlashPCA_Stage3_070125

flashpca --bfile Autosome_Sinead_Race_Ethnicity_Binary_CAD_for_FlashPCA_Stage3_070125 --project --inmeansd Norsid_V2_hg38_intersects_BioMe_eMERGE_prs_adjustment.pc.meansd --outproj BioMe_Full_eMERGE_LiftOver_Sinead_Race_Ethnicity_Projections_070125 --inload Norsid_V2_hg38_intersects_BioMe_eMERGE_prs_adjustment.pc.loadings -v

#Travis ancestry setting up for flashpca
for i in {1..22}; do plink2 --vcf VCF_CAD_for_FlashPCA_Original/Norsid_V3_CAD_Travis_Ancestry_chr${i}_063025.vcf --make-bed --out Binary_CAD_for_FlashPCA_Original/Norsid_V3_CAD_Travis_Ancestry_Binary_chr${i}_070125; done

plink --bfile Binary_CAD_for_FlashPCA_Original/Norsid_V3_CAD_Travis_Ancestry_Binary_chr1_070125 --merge-list CAD_Travis_Ancestry_mergelist_V3.txt --make-bed --out Autosome_Travis_Ancestry_Binary_CAD_for_FlashPCA_Stage3_070125

flashpca --bfile Autosome_Travis_Ancestry_Binary_CAD_for_FlashPCA_Stage3_070125 --project --inmeansd Norsid_V2_hg38_intersects_BioMe_eMERGE_prs_adjustment.pc.meansd --outproj BioMe_Full_eMERGE_LiftOver_Travis_Ancestry_Projections_070125 --inload Norsid_V2_hg38_intersects_BioMe_eMERGE_prs_adjustment.pc.loadings -v



