#Pull out the appropriate pathogenic variants from the BioMe database
library(openxlsx)
Requested_Pathogenic_FH_Variants_LDLR <- read.xlsx("Requested_high_risk_varaints_FH_Pathogenic_Likely_Pathogenic_041425.xlsx", sheet="LDLR")
Requested_Pathogenic_FH_Variants_APOB <- read.xlsx("Requested_high_risk_varaints_FH_Pathogenic_Likely_Pathogenic_041425.xlsx", sheet="APOB")
Requested_Pathogenic_FH_Variants_PCSK9 <- read.xlsx("Requested_high_risk_varaints_FH_Pathogenic_Likely_Pathogenic_041425.xlsx", sheet="PCSK9")
dim(Requested_Pathogenic_FH_Variants_PCSK9)
dim(Requested_Pathogenic_FH_Variants_APOB)
dim(Requested_Pathogenic_FH_Variants_LDLR)
LDLR_Extracted_Variants <- Requested_Pathogenic_FH_Variants_LDLR$Uploaded_variation
APOB_Extracted_Variants <- Requested_Pathogenic_FH_Variants_APOB$Uploaded_variation
PCSK9_Extracted_Variants <- Requested_Pathogenic_FH_Variants_PCSK9$Uploaded_variation
write.table(LDLR_Extracted_Variants, "BioMe_Exome_LDLR_Pathogenic_Vars_041725.txt", col.names=F, row.names=F, quote=F)
write.table(APOB_Extracted_Variants, "BioMe_Exome_APOB_Pathogenic_Vars_041725.txt", col.names=F, row.names=F, quote=F)
write.table(PCSK9_Extracted_Variants, "BioMe_Exome_PCSK9_Pathogenic_Vars_041725.txt", col.names=F, row.names=F, quote=F)
q()
