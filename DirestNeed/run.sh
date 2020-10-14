#!/bin/sh

export DIREST_NEED_DIR="/var/lib/myfrdcsa/codebases/independent/direst-need"

cd $DIREST_NEED_DIR/DirestNeed && script/direstneed_server.pl -r -h 127.0.0.1 -p 3010 -d  
