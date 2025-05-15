#File is for storing plink commands

#Command used to load version of plink for analyses (Plink v2.00a2.3LM 64-bit Intel)
ml plink2/2.3

#From 051525
plink2 --bfile /sc/arion/projects/igh/data/MSM/data/common_variants/combined/batch_001/variants/SINAI_MILLION_SUBSET_QC --keep-allele-order --geno 0.1 --hwe 1e-6 --indep-pairwise 50 5 0.1 --mac 100 --maf 0.01 --make-bed --mind 0.1 --out For_New_PC_Generation_Genotype_Data_1st_Round_051525

plink2 --bfile For_New_PC_Generation_Genotype_Data_1st_Round_051525 --extract For_New_PC_Generation_Genotype_Data_1st_Round_051525.prune.in --keep-allele-order --make-bed --out Remaining_Samples_QCed_For_New_PC_Generation_Genotype_Data_1st_Round_051525

plink2 --bfile Remaining_Samples_QCed_For_New_PC_Generation_Genotype_Data_1st_Round_051525 --pca --out PCs_Genotype_For_New_PC_Generation_Genotype_Data_1st_Round_051525

#From 050725
plink2 --bfile /sc/arion/projects/MSM/data/WES/combined/batch_001/plink/All/SINAI_MILLION_ALL_PASS --extract Protective_PCSK9_Variant_List_050725.txt --geno-counts --out Protective_PCSK9_Vars_gcounts_050725

plink2 --bfile /sc/arion/projects/MSM/data/WES/combined/batch_001/plink/All/SINAI_MILLION_ALL_PASS --extract Protective_PCSK9_Variant_List_050725.txt --recode A --out Protective_PCSK9_Vars_Recode_050725

#From 042925
plink2 --bgen /sc/arion/projects/MSM/data/common_variants/combined/batch_001/imputed_TOPMED/bgen/MSM_TOPMED.chr19.8bit.bgen ref-first --sample /sc/arion/projects/MSM/data/common_variants/combined/batch_001/imputed_TOPMED/bgen/MSM_TOPMED.chr19.sample --geno-counts --extract APOE_SNP_rsids_Build_Haplotype_MSM_TOPMED_bed_bim_fam_1st_Try_04142025.txt  --out RedoneA_APOE_initial_Pull_042925

plink2 --bgen /sc/arion/projects/MSM/data/common_variants/combined/batch_001/imputed_TOPMED/bgen/MSM_TOPMED.chr19.8bit.bgen ref-first --sample /sc/arion/projects/MSM/data/common_variants/combined/batch_001/imputed_TOPMED/bgen/MSM_TOPMED.chr19.sample --recode A  --extract APOE_SNP_rsids_Build_Haplotype_MSM_TOPMED_bed_bim_fam_1st_Try_04142025.txt --out Redone_V2_APOE_Genotype_Pull_B_042925

#From 041725
plink2 --bfile /sc/arion/projects/MSM/data/WES/combined/batch_001/plink/All/SINAI_MILLION_ALL_PASS --extract BioMe_Exome_LDLR_Pathogenic_Vars_041725.txt --geno-counts --out LDLR_Pathogenic_Known_BioMe_Vars_041725

plink2 --bfile /sc/arion/projects/MSM/data/WES/combined/batch_001/plink/All/SINAI_MILLION_ALL_PASS --extract BioMe_Exome_APOB_Pathogenic_Vars_041725.txt --geno-counts --out APOB_Pathogenic_Known_BioMe_Vars_041725

plink2 --bfile /sc/arion/projects/MSM/data/WES/combined/batch_001/plink/All/SINAI_MILLION_ALL_PASS --extract BioMe_Exome_PCSK9_Pathogenic_Vars_041725.txt --geno-counts --out PCSK9_Pathogenic_Known_BioMe_Vars_041725

#For recoding purposes to generate more direct counts if desired
plink2 --bfile /sc/arion/projects/MSM/data/WES/combined/batch_001/plink/All/SINAI_MILLION_ALL_PASS --extract BioMe_Exome_LDLR_Pathogenic_Vars_041725.txt --recode A --out LDLR_Pathogenic_Known_BioMe_Vars_Recode_041725

plink2 --bfile /sc/arion/projects/MSM/data/WES/combined/batch_001/plink/All/SINAI_MILLION_ALL_PASS --extract BioMe_Exome_APOB_Pathogenic_Vars_041725.txt --recode A --out APOB_Pathogenic_Known_BioMe_Vars_Recode_041725

plink2 --bfile /sc/arion/projects/MSM/data/WES/combined/batch_001/plink/All/SINAI_MILLION_ALL_PASS --extract BioMe_Exome_PCSK9_Pathogenic_Vars_041725.txt --recode A --out PCSK9_Pathogenic_Known_BioMe_Vars_Recode_041725

plink2 --bfile /sc/private/regen/IPM-general/Kenny_Lab/MSM/bgen/MSM_TOPMED_allchr_KING --recode A  --extract APOE_SNP_rsids_Build_Haplotype_MSM_TOPMED_bed_bim_fam_1st_Try_04142025.txt  --out V2_APOE_Genotype_Pull_B_041725

#From 04/14/25
plink2 --bfile /sc/private/regen/IPM-general/Kenny_Lab/MSM/bgen/MSM_TOPMED_allchr_unrelated --geno-counts --extract APOE_SNP_rsids_Build_Haplotype_MSM_TOPMED_bed_bim_fam_1st_Try_04142025.txt  --out APOE_initial_Pull_041425


