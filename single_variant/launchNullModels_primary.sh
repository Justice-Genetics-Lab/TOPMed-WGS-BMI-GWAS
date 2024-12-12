
kinshipfile=cdbg:/GRMs/freeze.8/pcrelate_kinshipMatrix_sparseDeg4_v2.Rda
kinshipfileX="-ikinshipmatrix=cdbg_bmi:/analysis/resources/freeze8_xchr_pcrelate_kinshipMatrix_sparse_0.354_01Jul2020.Rda"


phenofile=cdbg_bmi:/BMI_F8_phenotypes_30Jun2020_CHRX_JAB_factored.csv

covars="age_at_bmi,age_at_bmi_sq,PC1,PC2,PC3,PC4,PC5,PC6,PC7,PC8,PC9,PC10,PC11,PCX1,PCX2,PCX3,PCX4,PCX5,PCX6,PCX7,PCX8,sex,study,hare_strataAsian,hare_strataBlack,hare_strataCentralAmerican,hare_strataCuban,hare_strataMexican,hare_strataPuertoRican,hare_strataSouthAmerican,hare_strataDominican,seq_centerBAYLOR,seq_centerBROAD,seq_centerILLUMINA,seq_centerNYGC,seq_centerMACROGEN,seq_centerUW,fundingCCDG,topmed_phase1,topmed_phase1.4,topmed_phase1.5,topmed_phase2,topmed_phase2.5,topmed_phase3,topmed_phaseCCDG,topmed_phaselegacy" \

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
--destination=cdbg_bmi:analysis/nullmodel \
-ihet_vars=hare_strata_sex \
-ioutputfilename=bmi_30Jun2020_nullmodel \
--yes

