#!/bin/bash

git clone https://github.com/almandin/fuxploider.git

docker build -t web/fuxploider ./fuxploider
