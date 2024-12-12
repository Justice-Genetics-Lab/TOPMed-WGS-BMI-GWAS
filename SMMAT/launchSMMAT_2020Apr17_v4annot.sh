for chr in {1..23}; do
inchr=$chr
if [ $chr == 23 ]
then
inchr="X"
fi
gtfile="cdbg:/Genotypes/freeze.8/DP0/GDS/freeze.8.chr${inchr}.pass_and_fail.gtonly.minDP0.gds"

dx run Commons_Development:/genesis_tests_v1.4.3 \
-igenotypefile=${gtfile} \
-inull_model=cdbg_bmi:/nullmodel/bmi_30Jun2020_nullmodel.Rda \
-itest_type=SMMAT \
-ivaraggfile=Commons_Tools:/Annotation/TOPMed_WGS_F8/msau/msau_runs/bmi/BMI_aggregateAnnot_v4/msau_bmi_v4_chr${chr}.txt \
-imin_mac=1 \
-itop_maf=0.01 \
-iuser_cores=2 \
-iweights="'c(1,25)'" \
-ioutputfilename="bmi_30Jun2020_chr${chr}_SMMAT_1pct_aggV4_WuWeights" \
--destination=cdbg_bmi:/F8_rerun/SMMAT --yes
done
