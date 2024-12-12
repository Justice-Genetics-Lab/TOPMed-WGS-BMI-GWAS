#!/usr/bin/env python
# coding: utf-8

# In[1]:


import pandas as pd
import subprocess
import os


# In[2]:


cond = pd.read_csv('BMI_singleSNP_30Jun2020_1stPASS_conditionalList.csv')
cond


# In[3]:


cond.shape


# In[4]:


for index, row in cond.iterrows():
    pos = row['pos']
    chr = row['chr']
    snpID = row['snpID']
    
    region= "chr%s:%s-%s" % (chr,pos,pos)

    sak_cmd = """
dx run swiss-army-knife \
-iin=cdbg:/Genotypes/freeze.8/DP0/BCF/freeze.8.chr%s.pass_and_fail.gtonly.minDP0.bcf \
-iin=cdbg:/Genotypes/freeze.8/DP0/BCF/freeze.8.chr%s.pass_and_fail.gtonly.minDP0.bcf.csi \
-icmd="bcftools view freeze.8.chr%s.pass_and_fail.gtonly.minDP0.bcf –r %s -o freeze.8.chr%s_ExtractVar_%s.vcf" \
--destination=cdbg_bmi:/conditionalSNPs --yes --instance-type=mem1_ssd2_v2_x4
""" % (chr,chr,chr,region,chr,snpID)
    print(sak_cmd)
    #os.system(sak_cmd)
    stream = os.popen(sak_cmd)
    output = stream.read()
    print(output)

