#!/bin/bash -x

### get the settings
source /host/settings.sh

if [[ ! -f /opt/tvb_library/.tvb.configuration]]; then
    rm -rf /opt/tvb_library
    cp -a /usr/local/src/tvb_library /opt/
fi

cd /opt/tvb_library
python setup.py develop
