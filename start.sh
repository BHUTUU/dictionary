#!/usr/bin/env bash
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

