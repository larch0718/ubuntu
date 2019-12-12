#!/bin/bash
#清华
sourceList[0]="http://mirrors.tuna.tsinghua.edu.cn/ubuntu/"
#阿里云
sourceList[1]="http://mirrors.aliyun.com/ubuntu/"
#网易
sourceList[2]="http://mirrors.163.com/ubuntu/"
#中科大
sourceList[3]="https://mirrors.ustc.edu.cn/ubuntu/"
#ubuntu官方
sourceList[4]="http://cn.archive.ubuntu.com/ubuntu/"
BASE_URL=""
case $1 in
qinghua)
	BASE_URL=${sourceList[0]}
;;
aliyun)
	BASE_URL=${sourceList[1]}
;;
163)
	BASE_URL=${sourceList[2]}
;;
ustc)
	BASE_URL=${sourceList[3]}
;;
*)
	BASE_URL=${sourceList[4]}
;;
esac

if [ ! -f /etc/apt/sources.list.back ];
then
	sudo mv /etc/apt/sources.list /etc/apt/sources.list.back
else
	sudo rm /etc/apt/sources.list
fi


RELEASE=$(lsb_release -sc)
TYPE=("deb" "deb-src")
ARRAY=("${RELEASE}" "${RELEASE}-security" "${RELEASE}-updates" "${RELEASE}-proposed" "${RELEASE}-backports")

sudo echo "# source list" > sources.list

for type in ${TYPE[@]}
do
	for str in ${ARRAY[@]} 
	do
		sudo echo "${type} ${BASE_URL} ${str} restricted universe multiverse" >> sources.list
	done
done

sudo mv sources.list /etc/apt/sources.list
sudo apt update --fix-missing
exit 0
