#!/usr/bin/env bash
args="$@"
cmd="start.sh ${args}"
#<<<----------internet check function----------->>>
internet() {
python assets/load.py -H checking-internet -P none
echo
ping -c 1 google.com > /dev/null 2>&1
if [[ "$?" != 0 ]]; then
printf "\033[32m[\033[31m!\033[32m]\033[34mStatus:- \033[31mYou are offline!!\033[0m\n"
printf "\n\033[32mEXITING.....\033[0m\n"
echo
exit 1
else
printf "\033[31m[\033[1;32m✓\033[0;31m]\033[34mStatus:- \033[32mYou are online :)\033[0;00m\n"
echo
fi
}

#<<<-------------Update--------------->>>
if [[ ${cmd} == 'start.sh -u' || ${cmd} == 'start.sh --update' ]]; then
  internet
  git pull
elif [[ ${cmd} == 'start.sh ~u' || ${cmd} == 'start.sh ~~update' ]]; then
  internet
  cd .. && rm -rf dictionary
  git clone https://github.com/BHUTUU/dictionary
elif [[ ${cmd} == 'start.sh -i' || ${cmd} == 'start.sh --install' ]]; then
cd $PREFIX/share
if [[ -e "dictionary" ]]; then
rm -rf dictionary
fi
git clone https://github.com/BHUTUU/dictionary
cd dictionary
cat <<- CONF > $PREFIX/bin/dictionary
#!/bin/bash
arg="\$@"
cd $PREFIX/share/dictionary
./start.sh \${arg}
CONF
chmod +x $PREFIX/bin/dictionary
else


#<<<----Requirements------->>>
os=$(uname -o)
if [[ $os != *'Android'* ]]; then
#printf "\033[32m[\033[31m!\033[32m]\033[31mSorry but you system is not compatible with this program\033[0m\n"
#exit 1
  if ! hash python 2>/dev/null; then
  printf "\033[37m(\033[31m•\033[37m)\033[31mPython not found! \033[32m Installing.....\033[0m\n"
   internet
   sudo apt-get install python -y
   clear
  fi
  if ! hash jq 2>/dev/null; then
  printf "\033[37m(\033[31m•\033[37m)\033[31mjq not found! \033[32m Installing.....\033[0m\n"
  internet
  sudo apt-get install jq -y
  fi
  if ! hash lolcat 2>/dev/null; then
  printf "\033[37m(\033[31m•\033[37m)\033[31mLolcat not found! \033[32m Installing.....\033[0m\n"
  internet
  pip install lolcat
  clear
  fi
else
  if ! hash python 2>/dev/null; then
  printf "\033[37m(\033[31m•\033[37m)\033[31mPython not found! \033[32m Installing.....\033[0m\n"
  internet
  pkg install python -y
  clear
  fi
  if ! hash jq 2>/dev/null; then
  printf "\033[37m(\033[31m•\033[37m)\033[31mjq not found! \033[32m Installing.....\033[0m\n"
  internet
  pkg install jq -y
  fi
  if ! hash lolcat 2>/dev/null; then
  printf "\033[37m(\033[31m•\033[37m)\033[31mLolcat not found! \033[32m Installing.....\033[0m\n"
  internet
  pip install lolcat
  clear
  fi
fi

#<<<-------Program-------->>>
internet
printf "\033[1;32mEnter your word=> \033[0m"
read word
python assets/mean.py -H $word -P $word > $HOME/dict.json | python assets/load.py -H fetching-data -P BHUTUU
tail $HOME/dict.json | jq > /dev/null 2>&1
if [[ $? != 0 ]]
then
cat $HOME/dict.json | lolcat
else
tail $HOME/dict.json | jq
fi
rm -rf $HOME/dict.json 2>/dev/null
#<<<----end------->>>

fi
