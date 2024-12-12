for chr in {1..22}; do
	gtfile="cdbg:/Genotypes/freeze.8/DP0/GDS/freeze.8.chr${chr}.pass_and_fail.gtonly.minDP0.gds"


	dx run Commons_Tools:/genesis_tests_v1.4.3 \
-igenotypefile=${gtfile} \
-inull_model=cdbg_bmi:/nullmodel/bmi_30Jun2020_EA_nullmodel.Rda \
-itest_type=Single \
-imin_mac=30 \
-iuser_cores=10 \
-ioutputfilename="bmi_30Jun2020_chr${chr}_EA_single" \
--destination=cdbg_bmi:/single --yes
done


gtfile="cdbg:/Genotypes/freeze.8/DP0/GDS/freeze.8.chrX.pass_and_fail.gtonly.minDP0.gds"
dx run Commons_Tools:/genesis_tests_v1.4.3 \
-igenotypefile=${gtfile} \
-inull_model=cdbg_bmi:/nullmodel/bmi_30Jun2020_EA_nullmodel.Rda \
-itest_type=Single \
-imin_mac=30 \
-iuser_cores=10 \
-ioutputfilename="bmi_23Jun2020_chr23_EA_single" \
--destination=cdbg_bmi:/single --yes


for chr in {1..22}; do
	gtfile="cdbg:/Genotypes/freeze.8/DP0/GDS/freeze.8.chr${chr}.pass_and_fail.gtonly.minDP0.gds"


	dx run Commons_Tools:/genesis_tests_v1.4.3 \
-igenotypefile=${gtfile} \
-inull_model=cdbg_bmi:/nullmodel/bmi_30Jun2020_AA_nullmodel.Rda \
-itest_type=Single \
-imin_mac=30 \
-iuser_cores=10 \
-ioutputfilename="bmi_30Jun2020_chr${chr}_AA_single" \
--destination=cdbg_bmi:/single --yes
done


gtfile="cdbg:/Genotypes/freeze.8/DP0/GDS/freeze.8.chrX.pass_and_fail.gtonly.minDP0.gds"
dx run Commons_Tools:/genesis_tests_v1.4.3 \
-igenotypefile=${gtfile} \
-inull_model=cdbg_bmi:/bmi_30Jun2020_AA_nullmodel.Rda \
-itest_type=Single \
-imin_mac=30 \
-iuser_cores=10 \
-ioutputfilename="bmi_23Jun2020_chr23_AA_single" \
--destination=cdbg_bmi:/single --yes
