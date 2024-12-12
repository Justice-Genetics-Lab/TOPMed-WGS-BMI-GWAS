df = read.csv('/bmi/F8/summary_results/BMI_singleSNP_30Jun2020_hits.csv',as.is=T)
df = df[order(df$Score.pval),]

BUFFER = 500000
conditional_res = list()
i = 0
while(NROW(df) > 0){
    i = i+1
    cat(i, NROW(df),'\n')
    cur = df[1,,drop=F]
    conditional_res[[i]] = cur
    cur_locus = df[df$chr == cur$chr & df$pos > (cur$pos - BUFFER) & df$pos < (cur$pos + BUFFER),]
    #df = df[!df$snpID %in% cur_locus$snpID,]
    
}

conditionalSNPs = do.call(rbind,conditional_res)

write.csv(conditionalSNPs , file='../conditional/BMI_singleSNP_30Jun2020_1stPASS_conditionalList.csv')
