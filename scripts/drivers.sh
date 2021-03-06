#!/usr/bin/bash
# Author: kNIGHT
# Co-Author: ABHackerOfficial
# thanks to mochi for the original idea 

ver8188eus=v5.3.9
ver8812=v5.6.4.2
ver8814=v5.8.5.1
which curl 2>/dev/null || echo -e "\033[1;31m Install curl !\033[0m"
which jq 2>/dev/null || echo -e "\033[1;31m Install jq !\033[0m"
which git 2>/dev/null || echo -e "\033[1;31m Install git !\033[0m"
check1=$(curl -sL https://api.github.com/repos/aircrack-ng/rtl8188eus | jq -r .default_branch)
check2=$(curl -sL https://api.github.com/repos/aircrack-ng/rtl8812au | jq -r .default_branch)
check3=$(curl -sL https://api.github.com/repos/aircrack-ng/rtl8814au | jq -r .default_branch)
gsa() {
    if [[ ${ver8188eus} == ${check1} ]];then
       :
    else
	ver8188eus=$check1
    fi
    if [[ ${ver8812} == ${check2} ]];then
	:
    else
	ver8812=$check2
    fi
    if [[ ${ver8814} == ${check3} ]];then
	:
    else
	ver8814=$check3
    fi
    git subtree add --prefix=drivers/staging/rtl8188eus --squash https://github.com/aircrack-ng/rtl8188eus $ver8188eus
    git subtree add --prefix=drivers/staging/rtl8812au  --squash https://github.com/aircrack-ng/rtl8812au $ver8812
    git subtree add --prefix=drivers/staging/rtl8814au  --squash https://github.com/aircrack-ng/rtl8814au $ver8814 
}
gsp() {
    if [[ ${ver8188eus} == ${check1} ]];then
	:
    else
	ver8188eus=$check1
    fi
    if [[ ${ver8812} == ${check2} ]];then
	:
    else
	ver8812=$check2
    fi
    if [[ ${ver8814} == ${check3} ]];then
	:
    else
	ver8814=$check3
    fi
    git subtree pull --prefix=drivers/staging/rtl8188eus --squash https://github.com/aircrack-ng/rtl8188eus $ver8188eus
    git subtree pull --prefix=drivers/staging/rtl8812au  --squash https://github.com/aircrack-ng/rtl8812au $ver8812
    git subtree pull --prefix=drivers/staging/rtl8814au  --squash https://github.com/aircrack-ng/rtl8814au $ver8814 
}
if [[ $1 != "" && $1 == "add" ]]; then
    gsa
elif [[ $1 != "" && $1 == "pull" ]]; then
    gsp
elif [[ $1 == "" ]]; then
    echo -e "\033[1m
usage: ./drivers.sh [arg]

example: ./drivers.sh add
example: ./drivers.sh pull

     add   Newly add drivers
     pull  Update added drivers
\033[1m"
    exit 1
fi
