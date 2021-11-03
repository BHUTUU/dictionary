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
printf "\033[32m Just run 'dictionary' to use it\033[0m\n" 
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
  fi
  if ! hash pv 2>/dev/null; then
  printf "\033[37m(\033[31m•\033[37m)\033[31mpv not found! \033[32m Installing.....\033[0m\n"
   internet
   sudo apt-get install pv -y
  fi
  if ! hash sox 2>/dev/null; then
  printf "\033[37m(\033[31m•\033[37m)\033[31msox not found! \033[32m Installing.....\033[0m\n"
   internet
   sudo apt-get install sox -y
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
  fi
  find $PREFIX/lib/python3.9/site-packages/PyDictionary* > /dev/null 2>&1
  if [[ $? != 0 ]]; then
  pip install PyDictionary
  fi
else
  if ! hash python 2>/dev/null; then
  printf "\033[37m(\033[31m•\033[37m)\033[31mPython not found! \033[32m Installing.....\033[0m\n"
  internet
  pkg install python -y
  fi
  if ! hash pv 2>/dev/null; then
  printf "\033[37m(\033[31m•\033[37m)\033[31mpv not found! \033[32m Installing.....\033[0m\n"
   internet
   apt install pv -y
  fi
  if ! hash sox 2>/dev/null; then
  printf "\033[37m(\033[31m•\033[37m)\033[31msox not found! \033[32m Installing.....\033[0m\n"
   internet
   apt install sox -y
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
  fi
  find $PREFIX/lib/python3.*/site-packages/PyDictionary* > /dev/null 2>&1
  if [[ $? != 0 ]]; then
  pip install PyDictionary
  fi
fi

#<<<-------Program-------->>>
internet
printf "\033[1;32mEnter your word=> \033[0m"
read word
if [[ ${word,,} == *'suman'* || ${word^^} == *'BHUTUU'* ]]; then
printf "\033[1;31mHello...\033[0m\n"
play assets/.bhutuu/hello.mp3 > /dev/null 2>&1
printf "\n\033[1;34m Its developer here! if you waana know more about him, visit: https://bhutuu.github.io/\033[0m\n" | pv -qL 15
elif [[ ${word,,} == *'tanya'* ]]; then
printf "\n\033[34mIf I am samosa then its my aalu 👻❣️👻\033[0m\n\n" | pv -qL 15
else
python assets/mean.py -H $word -P $word > $HOME/dict.json | python assets/load.py -H fetching-data -P BHUTUU
tail $HOME/dict.json | jq > /dev/null 2>&1
if [[ $? != 0 ]]
then
cat $HOME/dict.json | lolcat
else
tail $HOME/dict.json | jq
fi
rm -rf $HOME/dict.json 2>/dev/null
fi
#<<<----end------->>>

fi
