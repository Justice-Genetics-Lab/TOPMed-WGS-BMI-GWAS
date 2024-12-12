library(data.table)
setwd('/chru_subs/analysis_Commons/phenotypes/bmi/F8/paintor')
## All results 
df = fread(cmd = 'zcat /chru_subs/analysis_Commons/phenotypes/bmi/F8/summary_results/BMI_singleSNP_17Dec2019.csv.gz',data.table=F)
df$MAF = pmin(df$freq,1-df$freq)
df = df[df$MAF > 0.005,]

## Our sig loci
loci = read.csv('/chru_subs/analysis_Commons/phenotypes/bmi/F8/conditional/BMI_singleSNP_30Jun2020_1stPASS_conditionalList.csv',as.is=T)
loci$locusname = paste0(loci$chr,'_',loci$pos,'_',loci$ref,'_',loci$alt)
## All results in window
BUFFER = 100000

write.table(loci[,'locusname'],file=paste0('inputfiles/input.files'),row.names=F,col.names=F,quote=F)

for( i in 1:NROW(loci)){

	write.table(loci[i,'locusname'],file=paste0('inputfiles/input.files',i),row.names=F,col.names=F,quote=F)
	#print(i)
	#}
	cur = loci[i,]
	locusname = cur$locusname
	cl = df[df$chr == cur$chr & df$pos > (cur$pos - BUFFER) & df$pos < (cur$pos + BUFFER),]	
	dim(cl)

	annot = fread(sub('@',cur$chr,'/chru_subs/analysis_Commons/phenotypes/bmi/F8/Annotation/msau_bmi_v2_chr@.txt'),data.table=F)
	annot$snpID = paste(sub('chr','',annot$chr),annot$pos,annot$ref,annot$alt,sep=':')
	annot = annot[annot$snpID %in% cl$snpID,]
	dim(annot)
	ld = fread(sub('@',locusname,'/chru_subs/analysis_Commons/phenotypes/bmi/F8/ld/bmi_LD_30Mar2020_100kb_0.005maf_@.csv'),data.table=F)
	row.names(ld) = ld$V1
	ld = ld[,2:NCOL(ld)]



	cl = cl[order(cl$pos),]
	cl$coding = ifelse(cl$snpID %in% annot[annot$label == 'coding1',]$snpID,1,0)
	cl$promoter = ifelse(cl$snpID %in% annot[annot$label == 'promoter',]$snpID,1,0)
	cl$genehancer = ifelse(cl$snpID %in% annot[annot$label == 'genehancer',]$snpID,1,0)


	## Must be ALL 
	if(!table(cl$snpID %in% row.names(ld))[TRUE] == NROW(cl)){
	
		## Added exception: 2 snps different due to MAF calculation on X, not at all sig SNPs
		if(locusname %in% c("X_31836665_G_C","X_118803350_G_T")){
			cl = cl[cl$snpID %in% row.names(ld),]
		}else{
			stop('LD does not match\n')
		}
	}
	ld = ld[cl$snpID,cl$snpID]
	write.table(ld,file=sub('@',locusname,'inputfiles/@.ld'),row.names=F,col.names=F)

	cl$Zscore = qnorm(1 - (cl$Score.pval/2))
	cl$Zscore = ifelse(cl$Est < 0,-1*cl$Zscore,cl$Zscore)

	cl$Zscore = cl$Est/cl$Est.SE
	
	write.table(cl,file=sub('@',locusname,'inputfiles/@_raw.csv'),row.names=F,col.names=T,quote=F)
	write.table(cl[,c('Zscore'),drop=F],file=sub('@',locusname,'inputfiles/@'),row.names=F,col.names=T,quote=F)
	write.table(cl[,c('coding','promoter','genehancer')],file=sub('@',locusname,'inputfiles/@.annotations'),row.names=F,col.names=T,quote=F)

	if(!(identical(row.names(ld),cl$snpID) || identical(colnames(ld),cl$snpID))){
		
		stop('LD doesnt match 2\n')
	}
}	

## Run:  PAINTOR -input inputfiles/input.files -in inputfiles -out results/ -Zhead Zscore -LDname ld  -annotations coding,promoter,genehancer -mcmc

## Example: PAINTOR -input input.files -in SampleData -out mytest -Zhead Zscore -LDname ld -annotations Coding,DHS 
