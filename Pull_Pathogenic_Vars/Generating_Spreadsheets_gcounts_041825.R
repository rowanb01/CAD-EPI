#Shows how the gcounts were created. The additional add ins were from Ref and Alternative alleles onwards from the gcounts, which has code in plink stored elsewhere

library(openxlsx)
PCSK9 <- read.table("PCSK9_Pathogenic_Known_BioMe_Vars_041725.gcount", header=F, sep="\t")
LDLR <- read.table("LDLR_Pathogenic_Known_BioMe_Vars_041725.gcount", header=F, sep="\t")
APOB <- read.table("APOB_Pathogenic_Known_BioMe_Vars_041725.gcount", header=F, sep="\t")
Full_BioMe_gcounts <- read.xlsx("Full_BioMe_Selected_APOE_gcounts_041425.xlsx")
colnames(Full_BioMe_gcounts)
colnames(APOB) <- c("CHROM", "ID", "REF", "ALT", "HOM_REF_CT", "HET_REF_ALT_CTS", "TWO_ALT_GENO_CTS", "HAP_REF_CT", "HAP_ALT_CTS", "MISSING_CT")
colnames(LDLR) <- c("CHROM", "ID", "REF", "ALT", "HOM_REF_CT", "HET_REF_ALT_CTS", "TWO_ALT_GENO_CTS", "HAP_REF_CT", "HAP_ALT_CTS", "MISSING_CT")
colnames(PCSK9) <- c("CHROM", "ID", "REF", "ALT", "HOM_REF_CT", "HET_REF_ALT_CTS", "TWO_ALT_GENO_CTS", "HAP_REF_CT", "HAP_ALT_CTS", "MISSING_CT")
Sheet <- list("APOB" = APOB, "LDLR" = LDLR, "PCSK9" = PCSK9)
write.xlsx(Sheet, "Gcount_Summary_of_key_Pathogenic_Draws_ClinVar_BioMe_Pull_041825.xlsx")
q()

