df = read.csv('/bmi/F8/pheno/BMI_F8_phenotypes_30Jun2020_CHRX_JAB_factored.csv',as.is=T)
dose = read.table('/bmi/F8/conditional/snpVCFs/conditionalSNPs_pass1_ALL_concat.raw',as.is=T,header=T)
cond = read.csv('/bmi/F8/conditional/BMI_singleSNP_30Jun2020_1stPASS_conditionalList.csv',as.is=T)
cond$snpID = with(cond,paste0('chr',chr,'.',pos,'.',ref,'.',alt,'_0'))
head(cond)
table(cond$snpID %in% names(dose))
row.names(dose) = dose$FID
dose = dose[,names(dose) %in% cond$snpID]

#string for null model
paste(unlist(names(dose)),collapse=',')

##"chr11.27657463.GT.G_0,chr12.49853685.G.A_0,chr13.53533448.G.T_0,chr16.53767042.T.C_0,chr18.60161902.T.C_0,chr19.47077985.C.T_0,chr1.177920345.A.G_0,chr22.29906934.C.T_0,chr2.24927427.A.G_0,chr2.621558.C.T_0,chr3.186108951.T.G_0,chr4.45179317.A.T_0,chr5.75707853.T.C_0,chr6.50830813.C.T_0,chr8.76051002.C.A_0,chrX.118803350.G.T_0,chrX.31836665.G.C_0"

df = merge(df,dose,by.x='sample.id',by.y='row.names')
write.csv(df,file='/bmi/F8/BMI_F8_phenotypes_30Jun2020_CHRX_JAB_PASS1_internal_conditional.csv',row.names=F)
system('dx upload /bmi/F8/BMI_F8_phenotypes_30Jun2020_CHRX_JAB_PASS1_internal_conditional.csv --destination=cdbg_bmi:/phenotype/BMI_F8_phenotypes_30Jun2020_CHRX_JAB_PASS1_internal_conditional.csv')
dim(dose)





df = read.csv('/bmi/F8/pheno/BMI_F8_phenotypes_30Jun2020_JAB.csv',as.is=T)
dose = read.table('/bmi/F8/conditional/snpVCFs/conditionalSNPs_pass1_ALL_concat.raw',as.is=T,header=T)
cond = read.csv('/bmi/F8/conditional/BMI_singleSNP_30Jun2020_1stPASS_conditionalList.csv',as.is=T)
cond$snpID = with(cond,paste0('chr',chr,'.',pos,'.',ref,'.',alt,'_0'))
head(cond)
table(cond$snpID %in% names(dose))
row.names(dose) = dose$FID
dose = dose[,names(dose) %in% cond$snpID]

#string for null model
paste(unlist(names(dose)),collapse=',')

##"chr11.27657463.GT.G_0,chr12.49853685.G.A_0,chr13.53533448.G.T_0,chr16.53767042.T.C_0,chr18.60161902.T.C_0,chr19.47077985.C.T_0,chr1.177920345.A.G_0,chr22.29906934.C.T_0,chr2.24927427.A.G_0,chr2.621558.C.T_0,chr3.186108951.T.G_0,chr4.45179317.A.T_0,chr5.75707853.T.C_0,chr6.50830813.C.T_0,chr8.76051002.C.A_0,chrX.118803350.G.T_0,chrX.31836665.G.C_0"

df = merge(df,dose,by.x='sample.id',by.y='row.names')
write.csv(df,file='/bmi/F8/BMI_F8_phenotypes_30Jun2020_CHRX_JAB_PASS1_internal_conditional.csv',row.names=F)
system('dx upload /bmi/F8/BMI_F8_phenotypes_30Jun2020_CHRX_JAB_PASS1_internal_conditional.csv --destination=cdbg_bmi:/phenotype/BMI_F8_phenotypes_30Jun2020_CHRX_JAB_PASS1_internal_conditional.csv')
dim(dose)
