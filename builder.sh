#!/bin/bash

cd `dirname $0`
osascript -l JavaScript 'export.js.applescript' | jsonpp > data.json
# cp data.json ~/Dropbox/data/OmniFocus.json
echo "Done"
