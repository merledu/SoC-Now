    #!/bin/bash
    # Ask the user for their name
    # read test_name
    echo Running $1 ...

    

    export NUCLEUSRV=$(pwd)/SoC-Now-Generator/compliance
    FILE=$NUCLEUSRV/test_run_dir/Top_Test/VTop
    if [ -f $FILE ]; then
        echo "$FILE exists."
        export NUCLEUSRV=$(pwd)/SoC-Now-Generator/compliance
        cd $NUCLEUSRV/riscv-arch-test
        make clean TARGETDIR=$NUCLEUSRV/riscv-target RISCV_TARGET=nucleusrv RISCV_DEVICE=rv32i RISCV_ISA=rv32i RISCV_TEST=$1 TARGET_SIM=$NUCLEUSRV/test_run_dir/Top_Test/VTop
        make TARGETDIR=$NUCLEUSRV/riscv-target RISCV_TARGET=nucleusrv RISCV_DEVICE=rv32i RISCV_ISA=rv32i RISCV_TEST=$1 TARGET_SIM=$NUCLEUSRV/test_run_dir/Top_Test/VTop | tee Test_result.txt
        cd ..
        python report.py
        # exec bash

    else 
        echo "$FILE does not exist."
        echo "First run sbt testOnly TopTest"
        export NUCLEUSRV=$(pwd)/SoC-Now-Generator/compliance
        cd $NUCLEUSRV
        sbt "testOnly nucleusrv.components.TopTest"
        # cd ../../
        cd $NUCLEUSRV/riscv-arch-test
        make clean TARGETDIR=$NUCLEUSRV/riscv-target RISCV_TARGET=nucleusrv RISCV_DEVICE=rv32i RISCV_ISA=rv32i RISCV_TEST=$1 TARGET_SIM=$NUCLEUSRV/test_run_dir/Top_Test/VTop
        make TARGETDIR=$NUCLEUSRV/riscv-target RISCV_TARGET=nucleusrv RISCV_DEVICE=rv32i RISCV_ISA=rv32i RISCV_TEST=$1 TARGET_SIM=$NUCLEUSRV/test_run_dir/Top_Test/VTop | tee Test_result.txt
        cd ..
        python report.py
        # exec bash
    fi

