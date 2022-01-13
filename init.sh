#!/bin/bash

python3 -m venv venv
source venv/bin/activate
PATH="/Library/PostgreSQL/13/bin:$PATH"
pip3 install -r requirements.txt
#cd db
#chmod +x dbinit.sh
#./dbinit.sh