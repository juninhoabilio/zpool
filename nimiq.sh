#!/bin/bash
#=============================================
# script montado por [ Telegram: @digitandoo ]
#
# se tiver qualquer erro so me chama que
# tento resolver.
#=============================================
__DADOS=($@) # NQ30 0KDY FMQ2 96E9 H9JM 7L8J TP3E KSNC ECM4
dados=($@)
y="${dados[0]} ${dados[1]} ${dados[2]} ${dados[3]} ${dados[4]} ${dados[5]} ${dados[6]} ${dados[7]} ${dados[8]}" # nao reparem nessa nojeira kkk
[[ ${y} != "" ]] && __WALLET__="$y" || read -p "Informe a wallet" __WALLET__
[[ ${dados[9]} != "" ]] && __NAME__="${dados[9]}" || __NAME__="*" #default
[[ ${dados[@]:10} =~ [0-9] ]] && __DE__="${dados[@]:10}" || __DE__=0
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install nodejs -y
sudo apt-get install -y build-essential
sudo apt-get install git -y
sudo apt-get install python2.7 -y
sudo apt-get install make gcc -y
sudo apt-get install gcc-c++ -y
sudo apt-get install unzip -y
sudo apt-get install cpulimit -y
apt-get install npm
npm install -g yarn
yarn global add gulp
wget https://github.com/skypool-org/skypool-nimiq-miner/releases/download/v1.3.1/skypool-nimiq-v1.3.1-linux-x64-extreme.zip
unzip skypool-nimiq-v1.3.1-linux-x64-extreme.zip
echo -e "\e[1;31m\t\tATENÃ‡ÃƒO\n\e[0;33mEssa parte pode demorar, tenha paciencia !\e[0m"
cd skypool-nimiq-v1.3.1-linux-x64-extreme && yarn
echo "const config =
{
  \"address\": \"${__WALLET__}\",
  \"name\": \"${__NAME__}\",
  \"thread\": 6,
  \"percent\": ${__DE__},
  \"server\": [
    \"ws://hk0.nimiq.skypool.org:4000\",
    \"ws://hk1.nimiq.skypool.org:4000\",
    \"ws://sh0.nimiq.skypool.org:4000\",
  ]
}
module.exports = config;
" > config.txt
screen -dmS NODE ./skypool-node-client
clear
screen -dmS CPU cpulimit -e skypool-node-client -l 600 || echo -e "\e[1;31merro core dumped\e[0m" # INFORMA O ERRO CASO NAO SEJA POSSIVEL MANTER A SEGUNDA TELA...
veri=$(screen -ls | awk '/\.NODE\t/ {print strtonum($1)}')
[[ "$(echo ${veri})" = "" ]] && echo -e "\e[1;31m[-!-] SCREEN NAO ESTA RODANDO\e[0m" || echo -e "\e[1;32m[ OK ] SCREEN RODANDO\e[0m"
