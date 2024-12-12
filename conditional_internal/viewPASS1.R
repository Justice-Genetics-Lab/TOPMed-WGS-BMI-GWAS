library(data.table)

cond = fread('/bmi/F8/conditional/BMI_singleSNP_30Jun2020_1stPASS_conditionalList.csv',data.table=F)

sig_res = list()
all_res = list()
i = 0
for(snp in cond$snpID){
    i = i+1
    snpus = gsub(':','_',snp)
    cat(snpus)
    cur = fread(cmd = sub('@',snpus,'zcat /bmi/F8/conditional/PASS1_results/bmi_30Jun2020_internalConditional_PASS1_30Jun2020_@.csv.gz'),data.table=F)
    cur$MAF = pmin(cur$freq,1-cur$freq)
    cur = subset(cur,MAF > 0.005)
    cur$nSNPsInRegion = NROW(cur)
    cur$nSigSNPsInRegion = NROW(cur[cur$Score.pval < 5e-9,])
    print(NROW(cur[cur$Score.pval < 5e-9,]))
    cur = cur[order(cur$Score.pval),]
    all_res[[i]] = cur
    sig_res[[i]] = cur[1,,drop=F]
}

## Create table for reporting conditional results in paper
conditionalSNPs = do.call(rbind,sig_res)
allSNPs = do.call(rbind,all_res)

threshold = 0.05/NROW(allSNPs)
write.csv(conditionalSNPs , file='/bmi/F8/conditional/BMI_singleSNP_30Jun2020_2ndPASS_conditionalList_prefilter.csv')
write.csv(conditionalSNPs[conditionalSNPs$Score.pval < threshold,] , file='/chru_subs/analysis_Commons/phenotypes/bmi/F8/conditional/BMI_singleSNP_30Jun2020_2ndPASS_conditionalList.csv')


orig = fread(cmd='zcat /bmi/F8/BMI_singleSNP_17Dec2019.csv.gz',data.table=F)
origsig = orig[orig$Score.pval < .001,]

names(conditionalSNPs) = paste0('cond1_',names(conditionalSNPs))
origConditionalSNPs = merge(orig,conditionalSNPs,by.x='snpID',by.y='cond1_snpID')
dim(origConditionalSNPs)
dim(conditionalSNPs)

write.csv(origConditionalSNPs , file='/bmi/F8/conditional/BMI_singleSNP_30Jun2020_2ndPASS_conditionalList_prefilter_annotedWithOriginalP.csv')

