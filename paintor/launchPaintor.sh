out_dir  = /bmi/F8/paintor/condor/
executable  = /chru/bin/PAINTOR
log         = $(out_dir)/locus$(id).condor.log
output      = $(out_dir)/locus$(id).condor.out
error       = $(out_dir)/locus$(id).condor.err
arguments   = -input inputfiles/input.files$(id) -in inputfiles -out results_paintor/ -Zhead Zscore -LDname ld  -annotations coding,promoter,genehancer -mcmc -Gname Enrichment.Estimate$(id) -Lname Log.BayesFactor$(id) --RESname results$(id)

request_memory = 2000
queue id in 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16
