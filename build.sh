#!/usr/bin/env bash
##################################
# Author : cndaqiang             #
# Update : 2020-07-25            #
# Build  : 2020-07-25            #
# What   : 构建网页               #
#################################
#从html目录提取网页元素
htmldir=./html
header=$htmldir/header.html
footer=$htmldir/footer.html
index=./index.html
mirrirdir=./mirrors
url="https://cndaqiang.github.io/ipapush/"
workdir=$(pwd)
#============== header
echo "<!doctype html>" > $index
echo "<html>" >> $index
cat $header >> $index
#软件下载链接
echo -e "\n<body>" >> $index
#
echo -e "<h2> Mirror LSPosed web </h2>" >> $index 
echo -e "<a href=\"https://cndaqiang.github.io/ipapush/\">github</a><br>" >> $index  
#
rm -rf $mirrirdir/link/*
for input in $(ls $mirrirdir/config )
do
    inputconfig=$mirrirdir/config/$input
    link=$(grep ^link $inputconfig | awk -F= '{ print $2 }' | head -1)
    name=$(echo $input | awk -F.plist '{ print $1 }')
    if [ ${link}_ == _ ]; then link=$url/$mirrirdir/soft/${name}.ipa; fi
    cp $workdir/example.plist  $mirrirdir/link/${name}.plist
    sed -i  "s#CNDAQIANG_IPAURL#$link#g" $mirrirdir/link/${name}.plist
    sed -i  "s#BUNDLENAME#$name#g" $mirrirdir/link/${name}.plist
    sed -i  "s#TITLENAME#$name#g" $mirrirdir/link/${name}.plist
    plistlink=./$mirrirdir/link/${name}.plist
    #
    echo -e "<h2> $soft </h2>" >> $index
    #echo -e "<a href=\"$plistlink\">$name.plist</a><br>" >> $index  
    echo -e "<a href="itms-services://?action=download-manifest\&url=$plistlink" id="text">安装 $name</a>" >> $index
    echo -e "<a href=\"$link\">$name.ipa</a><br>" >> $index  
    echo "<hr>" >> $index
done









echo -e "\n</body>" >> $index
#============= footer
cat $footer >> $index
echo -e "\n</html>" >> $index
