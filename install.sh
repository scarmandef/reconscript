#!/bin/bash




echo
echo -e "\033[01;33m[+] \033[01;31m ══════════ \033[01;32mComeçando instalação \033[01;31m ══════════ \033[01;33m[+]\033[01;37m"
echo

cd /opt/ && sudo mkdir tools_recon && cd tools_recon
sudo chmod 777 /opt/tools_recon


echo
echo -e "\033[01;33m[+] \033[01;31m ══════════ \033[01;32mComeçando instalação \033[01;31m ══════════ \033[01;33m[+]\033[01;37m"
echo

sudo apt update -y

read -p 'Deseja configurar BOT do telegram ? S/N: ' bot

if [ "$bot" == "S" ] || [ "$bot" == "s" ]; then
    
    echo -e "\033[01;32m[+] ══════════ Instalando Notify ══════════ [+]\033[01;37m"
	echo
	GO111MODULE=on go get -v github.com/projectdiscovery/notify/cmd/notify    
    read -p 'telegram_apikey: ' telegram_apikey
    read -p 'telegram_chat_id: ' telegram_chat_id
    echo "telegram: true"  >> ~/.config/notify/notify.conf
    echo "telegram_apikey: $telegram_apikey" >> ~/.config/notify/notify.conf
	echo "telegram_chat_id: $telegram_chat_id" >> ~/.config/notify/notify.conf
                        
else
    echo
        
fi


echo
echo -e "\033[01;32m[+] ══════════ Baixando e instalando Python3 ══════════ [+]\033[01;37m"
echo

sudo apt install python3 python3-pip

echo
echo -e "\033[01;32m[+] ══════════ Instalando Subfinder ══════════ [+]\033[01;37m"
echo

go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest

echo
echo -e "\033[01;32m[+] ══════════ Instalando Anew ══════════ [+]\033[01;37m"
echo

go install -v github.com/tomnomnom/anew@latest


echo
echo -e "\033[01;32m[+] ══════════ Instalando Httpx ══════════ [+]\033[01;37m"
echo


go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest


echo
echo -e "\033[01;32m[+] ══════════ Instalando Gau & GauPlus & Waybackurls ══════════ [+]\033[01;37m"
echo

go install -v github.com/lc/gau@latest
go install -v github.com/bp0lr/gauplus@latest
go install -v  github.com/tomnomnom/waybackurls@latest

echo
echo -e "\033[01;32m[+] ══════════ Instalando Metabigor ══════════ [+]\033[01;37m"
echo

go install -v github.com/j3ssie/metabigor@latest

echo
echo -e "\033[01;32m[+] ══════════ Instalando Dirsearch ══════════ [+]\033[01;37m"
echo

sudo git clone https://github.com/maurosoria/dirsearch.git
sudo chmod 707 dirsearch
cd dirsearch 
sudo chmod 707 * 
pip3 install -r requirements.txt
cd ..


echo
echo -e "\033[01;32m[+] ══════════ Instalando LinkFinder ══════════ [+]\033[01;37m"
echo

sudo git clone github.com/GerbenJavado/LinkFinder.git
sudo chmod 707 LinkFinder
cd LinkFinder
pip3 install -r requirements.txt
cd ..

echo
echo -e "\033[01;32m[+] ══════════ Instalando Prips ══════════ [+]\033[01;37m"
echo

sudo apt-get install prips

echo
echo -e "\033[01;32m[+] ══════════ Instalando GF ══════════ [+]\033[01;37m"
echo

go install -v github.com/tomnomnom/gf@latest

echo 'source $GOPATH/src/github.com/tomnomnom/gf/gf-completion.bash' >> ~/.bashrc
echo 'source $GOPATH/src/github.com/tomnomnom/gf/gf-completion.bash' >> ~/.zshrc

cp -r $GOPATH/src/github.com/tomnomnom/gf/examples ~/.gf

echo
echo -e "\033[01;32m[+] ══════════ Instalando Findomain-linux ══════════ [+]\033[01;37m"
echo

sudo wget https://github.com/findomain/findomain/releases/latest/download/findomain-linux
chmod +x findomain-linux
sudo mv findomain /usr/bin/findomain


echo
echo
echo -e "\033[01;32m[+] ══════════ Instalando ParamSpider ══════════ [+]\033[01;37m"
echo

sudo git clone github.com/devanshbatham/ParamSpider.git

cd ParamSpider
pip3 install -r requirements.txt
cd ..

echo
echo -e "\033[01;32m[+] ══════════ Instalando Unfurl ══════════ [+]\033[01;37m"
echo

go install -v  github.com/tomnomnom/unfurl@latest

echo
echo -e "\033[01;32m[+] ══════════ Instalando Arjun ══════════ [+]\033[01;37m"
echo

pip3 install arjun

echo
echo -e "\033[01;32m[+] ══════════ Instalando hakrevdns ══════════ [+]\033[01;37m"
echo

go install -v github.com/hakluke/hakrevdns@latest

echo
echo -e "\033[01;32m[+] ══════════ Instalando Dalfox ══════════ [+]\033[01;37m"
echo

go install -v github.com/hahwul/dalfox/v2@latest


echo
read -p "Tem Seclists Y/N ?/" seclists

if [ "$seclists" == "S" ] || [ "$seclists" == "s" ]; then

echo -e "\033[01;32m[+] ══════════ Baixando SecLists ══════════ [+]\033[01;37m"
sudo git clone https://github.com/danielmiessler/SecLists.git

else
	echo "Ok"
fi


echo
echo -e "\033[01;32m[+] ══════════ Instalação finalizada ══════════ [+]\033[01;37m"
