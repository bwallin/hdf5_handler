#besstandalone -d"cerr,all" -c bes-testsuite/bes.conf -i bes-testsuite/h5.he5/grid_1_2d.h5.dmr.bescmd
#valgrind --leak-check=full besstandalone -c bes-testsuite/bes.conf -i bes-testsuite/h5.nasa/3A-MO.GPM.GMI.GRID2014R1.20140601-S000000-E235959.06.V03A.h5.dds.bescmd
#besstandalone -c /etc/bes/bes.conf -i bes-testsuite/h4.nasa1.with_hdfeos2/MOD09GA.A2007268.h10v08.005.2007272184810.hdf.das.bescmd1
#besstandalone -c bes-testsuite/bes.conf -i bes-testsuite/h4.nasa1.with_hdfeos2/MOD09GA.A2007268.h10v08.005.2007272184810.hdf.data.bescmd | getdap -M -
#valgrind besstandalone -c bes-testsuite/bes.conf -i bes-testsuite/h5.he5/grid_1_2d.h5.dmr.bescmd
#besstandalone -c bes-testsuite/bes.conf -i bes-testsuite/h5.he5/grid_1_2d.h5.dap.bescmd | getdap4 -D -M -
#valgrind -v besstandalone -c bes-testsuite/bes.conf -i bes-testsuite/h5.he5/grid_1_2d.h5.dap.bescmd
#besstandalone -c bes-testsuite/bes.conf -i bes-testsuite/h5.local/eos5sin.h5.dds.bescmd
besstandalone -c bes-testsuite/bes.conf -i bes-testsuite/h5.local/eos5lamaz.h5.dds.bescmd
besstandalone -c bes-testsuite/bes.conf -i bes-testsuite/h5.local/eos5ps.h5.dds.bescmd
#besstandalone -c bes-testsuite/bes.conf -i bes-testsuite/h5.cf/grid_1_2d.h5.dds.bescmd

#besstandalone -c bes-testsuite/bes.conf -i bes-testsuite/h5.default/t_vl_string_cstr.h5.das.bescmd

