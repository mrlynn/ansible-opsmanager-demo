#!/bin/bash
bold=`tput bold`
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
blue=`tput setaf 4`
reset=`tput sgr0`
printf -v stars '%*s' 80 ''
export ANSIBLE_HOSTS=ansible-hosts
export ANSIBLE_CONFIG=ansible.cfg
dir=`basename $PWD`
hn=`hostname -s`
un=`whoami`
export PROMPT="${green}${hn}:${dir} ${un}$ ${reset}"
USEPV=1
echo "t" | pv -qL 10 > /dev/null 2>&1 || USEPV=0
SPEED=10
function typeit {
  echo "${PROMPT}$ \c"
  [ $USEPV -eq 1 ] && echo $1 | pv -qL $SPEED || echo $1
}
pause(){
     read -n1 -rsp $"${blue}Press any key to continue or Ctrl+C to exit${reset}"
     echo
}
function title {
    echo "${stars// /*}"
    echo "$1"
    echo "${stars// /*}"
}
function prompt {
	while true; do
		read -n1 -rsp "[C]ontinue, [Q]uit: " ans
		case $ans in
			[Cc]* ) return 0;;
			[Qq]* ) exit;;
			* ) echo "Please enter C to Continue or Q to Quit";;
		esac
	done
}
