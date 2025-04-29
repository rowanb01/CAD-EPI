#File is for storing plink commands

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


