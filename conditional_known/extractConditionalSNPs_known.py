#!/usr/bin/env python
# coding: utf-8

# In[68]:


import pandas as pd
import subprocess
import os
import numpy as np


# In[3]:


cond = pd.read_csv('/bmi/F8/conditional_known/conditionalVariantKnownAndIndex.csv',index_col=0)

cond = cond[cond.type == 'Index']
cond


# In[42]:


ld = pd.read_csv("/bmi/F8/conditional_known/snpVCFs/conditionalSNPs_pass1_ALL_concat_March2020knownList_LD_R2_0.1.ld", delim_whitespace=True)

ld = pd.concat([ld,ld['SNP_A'].str.split(':',expand=True,n=2)],axis=1)
ld = ld.rename(columns = {0:"SNP_A_chr",1:'SNP_A_pos',2:'SNP_A_ra'})

ld['SNP_A_chr'] = ld['SNP_A_chr'].str.slice(start=3)
ld['SNP_A_cp'] = ld['SNP_A_chr']+":"+ld['SNP_A_pos']


ld = pd.concat([ld,ld['SNP_B'].str.split(':',expand=True,n=2)],axis=1)
ld = ld.rename(columns = {0:"SNP_B_chr",1:'SNP_B_pos',2:'SNP_B_ra'})

ld['SNP_B_chr'] = ld['SNP_B_chr'].str.slice(start=3)
ld['SNP_B_cp'] = ld['SNP_B_chr']+":"+ld['SNP_B_pos']
ld.head()


# In[58]:


## Only need those that are in LD with our index SNPs
ld = ld[(ld['SNP_A_cp'].isin(cond['Variant_build38'])) | (ld['SNP_B_cp'].isin(cond['Variant_build38']))]
ld


# In[88]:


## ld_snps are index SNPs plus those with LD  > 0.1 with index SNPs
ld_snps = ld['SNP_A_cp'].tolist()+ld['SNP_B_cp'].tolist()
ld_snps = np.unique(xx).tolist()
ld_snps


# In[86]:


## ld_snps are index SNPs plus those with LD  > 0.1 WITHOUT index SNPs
index_snps = cond['Variant_build38'].tolist()
ld_snps_no_index = []
for i in ld_snps:
     if not i in index_snps:
            ld_snps_no_index.append(i)
ld_snps_no_index


# In[1]:


for snp in ld_snps:
    print(snp)
    (chr,pos) = snp.split(':')
    region= "chr%s:%s-%s" % (chr,pos,pos)

    sak_cmd = """
dx run swiss-army-knife \
-iin=cdbg:/Genotypes/freeze.8/DP0/BCF/freeze.8.chr%s.pass_and_fail.gtonly.minDP0.bcf \
-iin=cdbg:/Genotypes/freeze.8/DP0/BCF/freeze.8.chr%s.pass_and_fail.gtonly.minDP0.bcf.csi \
-icmd="bcftools view freeze.8.chr%s.pass_and_fail.gtonly.minDP0.bcf –r %s -o freeze.8.chr%s_ExtractVar_%s.vcf" \
--destination=cdbg_bmi:/conditionalSNPs_knownMarch2020 --yes --instance-type=mem1_ssd2_v2_x4
""" % (chr,chr,chr,region,chr,snp)
    print(sak_cmd)
    stream = os.popen(sak_cmd)
    output = stream.read()
    print(output)


# In[ ]:




