#!/usr/bin/env bash
#<<<----Requirements------->>>
os=$(uname -o)
if [[ $os != *'Android'* ]]; then
#printf "\033[32m[\033[31m!\033[32m]\033[31mSorry but you system is not compatible with this program\033[0m\n"
#exit 1
  if ! hash python 2>/dev/null; then
  printf "\033[37m(\033[31m•\033[37m)\033[31mPython not found! \033[32m Installing.....\033[0m\n"
   sudo apt-get install python -y
   clear
  fi
  if ! hash jq 2>/dev/null; then
  printf "\033[37m(\033[31m•\033[37m)\033[31mjq not found! \033[32m Installing.....\033[0m\n"
  sudo apt-get install jq -y
  fi
  if ! hash lolcat 2>/dev/null; then
  printf "\033[37m(\033[31m•\033[37m)\033[31mLolcat not found! \033[32m Installing.....\033[0m\n"
  pip install lolcat
  clear
  fi
else
  if ! hash python 2>/dev/null; then
  printf "\033[37m(\033[31m•\033[37m)\033[31mPython not found! \033[32m Installing.....\033[0m\n"
  pkg install python -y
  clear
  fi
  if ! hash jq 2>/dev/null; then
  printf "\033[37m(\033[31m•\033[37m)\033[31mjq not found! \033[32m Installing.....\033[0m\n"
  pkg install jq -y
  fi
  if ! hash lolcat 2>/dev/null; then
  printf "\033[37m(\033[31m•\033[37m)\033[31mLolcat not found! \033[32m Installing.....\033[0m\n"
  pip install lolcat
  clear
  fi
fi




printf "\033[1;32mEnter your word=> \033[0m"
read word
python assets/mean.py -H $word -P $word > $HOME/dict.json
tail $HOME/dict.json | jq > /dev/null 2>&1
if [[ $? != 0 ]]
then
cat $HOME/dict.json | lolcat
else
tail $HOME/dict.json | jq
fi

