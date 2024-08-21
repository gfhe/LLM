!#/bin/bash

py_version='3.7'
platform='win_amd64'

pip3 download -d /packages \
-r requirements.txt \
--python-version ${py_version} \
--only-binary=:all: \
--platform ${platform} \
-i https://mirrors.aliyun.com/pypi/simple \ 
--extra-index-url https://download.pytorch.org/whl/cu113


echo "install packages:"
echo "pip3 install --no-index --find-links=/packages -r requirements.txt"