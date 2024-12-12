#!/usr/bin/env python
# coding: utf-8

# In[1]:

import pandas as pd
import numpy as np
import os


# In[10]:


cond = pd.read_csv('/bmi/F8/conditional/BMI_singleSNP_30Jun2020_1stPASS_conditionalList.csv')


# In[4]:


res = pd.read_csv('/bmi/F8/summary_results/BMI_singleSNP_MAC20_30Jun2020.csv.gz',dtype={'chr':str},usecols = ["chr", "pos", "ref","alt","freq"])


# In[5]:


res = res[(res.freq > 0.005) & (res.freq < 0.995)]


# In[11]:


cond.head()


# In[15]:


BUFFER = 500000
for index, row in cond.iterrows():
    pos = row['pos']
    chr = row['chr']
    snp = row['snpID']
    snp = ('_').join(snp.split(":"))
    curres = res[(res.chr == chr) & (res.pos > (pos-BUFFER)) & (res.pos < (pos+BUFFER))]
    print(curres.shape)
    curres['group_id'] = snp
    print(snp)
    curres = curres[['group_id','chr','pos','ref','alt']]
    curres.to_csv('var_list_files/var_group_interalConditional_PASS1_%s.csv' % snp,index=False)
    


# In[ ]:


dx upload var_list_files/var_group_interalConditional_PASS1_*  --destination=cdbg_bmi:/conditional/conditionalVarGroupFiles/


# In[17]:


for index, row in cond.iterrows():
    pos = row['pos']
    chr = row['chr']
    snp = row['snpID']
    snp = ('_').join(snp.split(":"))
    print(snp)
    gtfile="cdbg:/Genotypes/freeze.8/DP0/GDS/freeze.8.chr%s.pass_and_fail.gtonly.minDP0.gds" % chr
    varaggfile="cdbg_bmi:/conditionalVarGroupFiles/var_group_interalConditional_PASS1_%s.csv" % snp
    
    cmd = """
dx run Commons_Tools:/genesis_tests_v1.4.3 \
-igenotypefile=%s \
-inull_model=cdbg_bmi:/nullmodel/bmi_internalConditional_PASS1_30Jun2020_nullmodel.Rda \
-ivaraggfile=%s \
-itest_type=Single \
-imin_mac=10 \
-iuser_cores=12 \
-ioutputfilename="bmi_30Jun2020_internalConditional_PASS1_30Jun2020_%s" \
--destination=cdbg_bmi:/conditional/internalConditional_PASS1 --yes
""" % (gtfile,varaggfile,snp)
     
    print(cmd)
    stream = os.popen(cmd)
    output = stream.read()
    print(output)


# In[ ]:



