kinshipfile=cdbg:/GRMs/freeze.8/pcrelate_kinshipMatrix_sparseDeg4_v2.Rda
kinshipfileX="-ikinshipmatrix=cdbg_bmi:/analysis/resources/freeze8_xchr_pcrelate_kinshipMatrix_sparse_0.354_01Jul2020.Rda"

phenofile=cdbg_bmi:/phenotype/BMI_F8_phenotypes_30Jun2020_JAB_PASS2_internal_conditional.csv

covars="age_at_bmi,age_at_bmi_sq,PC1,PC2,PC3,PC4,PC5,PC6,PC7,PC8,PC9,PC10,PC11,PCX1,PCX2,PCX3,PCX4,PCX5,PCX6,PCX7,PCX8,sex,study,hare_strataAsian,hare_strataBlack,hare_strataCentralAmerican,hare_strataCuban,hare_strataMexican,hare_strataPuertoRican,hare_strataSouthAmerican,hare_strataDominican,seq_centerBAYLOR,seq_centerBROAD,seq_centerILLUMINA,seq_centerNYGC,seq_centerMACROGEN,seq_centerUW,fundingCCDG,topmed_phase1,topmed_phase1.4,topmed_phase1.5,topmed_phase2,topmed_phase2.5,topmed_phase3,topmed_phaseCCDG,topmed_phaselegacy,chr11.27657463.GT.G_0,chr12.49853685.G.A_0,chr13.53533448.G.T_0,chr16.53767042.T.C_0,chr18.60161902.T.C_0,chr19.47077985.C.T_0,chr1.177920345.A.G_0,chr22.29906934.C.T_0,chr2.24927427.A.G_0,chr2.621558.C.T_0,chr3.186108951.T.G_0,chr4.45179317.A.T_0,chr5.75707853.T.C_0,chr6.50830813.C.T_0,chr8.76068626.A.G_0,chrX.31836665.G.C_0,chr18.60361739.G.T_0,chr2.422144.T.C_0"  \




# many transform group
# HV hare_strata_sex
# no rescale
dx run Commons_Development:/genesis_nullmodel_v1.4.2 \
-iphenofile=${phenofile} \
-ioutcome_name=bmi \
-ikinshipmatrix=${kinshipfile}  ${kinshipfileX} \
-ioutcome_type='Continuous' \
-icovariate_list=${covars} \
-itransform='transform' \
-itransform_rankNorm='by.group' \
-itransform_rescale='none' \
-ipheno_id=sample.id \
--destination=cdbg_bmi:nullmodel \
-ihet_vars=hare_strata_sex \
-ioutputfilename=bmi_internalConditional_PASS2_30Jun2020_nullmodel \
--yes

