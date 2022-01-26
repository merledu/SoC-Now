    #!/bin/bash
    # Ask the user for their name
    echo Which Test you want to run?
    read test_name
    echo Running $test_name ...
    SocNow_path=$PWD
    export NUCLEUSRV=$SocNow_path/SoCNow/nucleusrv
    cd $SocNow_path/riscv-arch-test
    make clean TARGETDIR=$NUCLEUSRV/riscv-target RISCV_TARGET=nucleusrv RISCV_DEVICE=rv32i RISCV_ISA=rv32i RISCV_TEST=$test_name TARGET_SIM=$NUCLEUSRV/test_run_dir/Top_Test/VTop
    make TARGETDIR=$NUCLEUSRV/riscv-target RISCV_TARGET=nucleusrv RISCV_DEVICE=rv32i RISCV_ISA=rv32i RISCV_TEST=$test_name TARGET_SIM=$NUCLEUSRV/test_run_dir/Top_Test/VTop | tee Test_result.txt
    cd ..
    exec bash

