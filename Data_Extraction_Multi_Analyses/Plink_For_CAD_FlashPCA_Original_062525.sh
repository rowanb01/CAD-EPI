#This shows the list of the plink commands used to produce the files used in the flashPCA analysis along with the flashPCA command used for the original Main Cohort subset to Sinead stated ancestry

ml plink2/2.3

#Subset to the matched snps from the pc sites
for i in {1..22}; do plink2 --bgen /sc/arion/projects/MSM/data/common_variants/combined/batch_001/imputed_TOPMED/bgen/MSM_TOPMED.chr${i}.8bit.bgen ref-first --sample /sc/arion/projects/MSM/data/common_variants/combined/batch_001/imputed_TOPMED/bgen/MSM_TOPMED.chr${i}.sample --keep For_CAD_Samples_062425.txt --extract rsid_version_Updated_hg38_intersects_BioMe_eMERGE_prs_adjustment.pc.sites --export vcf --out VCF_CAD_for_FlashPCA_Original/CAD_chr${i}_062525; done

#Convert the vcfs into binary files
for i in {1..22}; do plink2 --vcf VCF_CAD_for_FlashPCA_Original/CAD_chr${i}_062525.vcf --make-bed --out Binary_CAD_for_FlashPCA_Original/Binary_CAD_chr${i}_062525; done

#Reconvert since the original files have duplicates that are problematic due to rsids not having all of the variants covered in the first place
for i in {1..22}; do plink --bfile Binary_CAD_for_FlashPCA_Original/Binary_CAD_chr${i}_062525 --extract Extract_rsids_for_CAD_062525.txt --make-bed --out Binary_CAD_for_FlashPCA_Original/Updated_Binary_CAD_for_FlashPCA_chr${i}_062625; done

#Failed attempt to merge the files that created the missnp file
plink --bfile Binary_CAD_for_FlashPCA_Original/Updated_Binary_CAD_for_FlashPCA_chr1_062625 --merge-list Original_for_CAD_mergelist_V3.txt --make-bed --out Autosome_Binary_CAD_for_FlashPCA_062625

#Use the failed Autosome file to remove the multiallelic snps that are causing issues
for i in {1..22}; do plink --bfile Binary_CAD_for_FlashPCA_Original/Updated_Binary_CAD_for_FlashPCA_chr${i}_062625 --exclude Autosome_Binary_CAD_for_FlashPCA_062625-merge.missnp --make-bed --out Binary_CAD_for_FlashPCA_Original/SecondRound_Updated_Binary_CAD_for_FlashPCA_chr${i}_062625; done

#Now merge the files
plink --bfile Binary_CAD_for_FlashPCA_Original/SecondRound_Updated_Binary_CAD_for_FlashPCA_chr1_062625 --merge-list Original_for_CAD_mergelist_V4.txt --make-bed --out Autosome_Binary_CAD_for_FlashPCA_062625

#FlashPCA commands for creating the BioMe projections
ml flashpca/2.0
flashpca --bfile Autosome_Binary_CAD_for_FlashPCA_062625 --project --inmeansd Proper_rsid_version_Updated_hg38_intersects_BioMe_eMERGE_prs_adjustment.pc.meansd --outproj BioMe_Projections_062625 --inload Proper_rsid_version_Updated_hg38_intersects_BioMe_eMERGE_prs_adjustment.pc.loadings -v


