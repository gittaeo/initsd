#!/usr/bin/env bash

cat << HERE1
Installs Anaconda2 2.4.1

    -b           run install in batch mode (without manual intervention),
                 it is expected the license terms are agreed upon
    -f           no error if install prefix already exists
    -h           print this help message and exit
    -p PREFIX    install prefix, defaults to $PREFIX
HERE1

SDCARD_PATH=/media/user/bootfs
CONFIGTXT=config.txt
CMDLINETXT=cmdline.txt

# sd 을 인식한다
function detectSD(){
	while true; do
		if [ -d "${SDCARD_PATH}" ];then
			echo "SD 카드가 발견됨!"
			return
		fi
		sleep 1
	done
}
#1
echo before detectSD 
detectSD
echo after detectSD


# find config.txt cmdline.txt
function detectCMDLINE(){
	sleep 1
	if [ -f "${SDCARD_PATH}/${CMDLINETXT}" ];then
		echo "cmdline.txt 가 발견됨!"
		echo 0 #find
	else
		echo 1 #no found
	fi
}

#2 cmdline.txt
isCMDLINE='detectCMDLINE'
IPADDR=192.168.111.1
if [ $isCMDLINE -eq 0 ]; then
	# find 192.168.111.1 & modify
	sed "s/111.111.111.111/${IPADDR}/""${SDCARD_PATH}/${CMDLINETXT}"
	if [ $? -eq 0 ]; then
		echo "${CMDLINETXT} 문서가 수정되었습니다. 성공"
	else
		echo "${CMDLINETXT} 문서가 수정하지 못하였습니다. 실패"
	fi
fi



#umount /media/user/bootfs
umount /media/user/bootfs
echo "SD 카드를 분리하셔도 됩니다."