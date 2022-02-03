    #!/bin/bash
    
    cp -r $PWD/custom_test $PWD/../SoCNow/nucleusrv/tools/tests
    
    cwd=$PWD
    echo $cwd
    
    cd ../SoCNow/nucleusrv/tools
    make
    cd out
    ls
    
