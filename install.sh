#!/bin/bash

echo
echo -e "\033[01;33m[+] \033[01;31m ══════════ \033[01;32mComeçando instalação \033[01;31m ══════════ \033[01;33m[+]\033[01;37m"
echo

cd /opt/ && mkdir reconbb && cd reconbb
sudo chmod 707 /opt/reconbb


echo
echo -e "\033[01;33m[+] \033[01;31m ══════════ \033[01;32mComeçando instalação \033[01;31m ══════════ \033[01;33m[+]\033[01;37m"
echo

sudo apt update -y

echo
echo -e "\033[01;32m[+] ══════════ Baixando e instalando GOLANG ══════════ [+]\033[01;37m"
echo
sudo apt install golang-go -y


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

GO111MODULE=on go get -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder

echo
echo -e "\033[01;32m[+] ══════════ Instalando Anew ══════════ [+]\033[01;37m"
echo

go get -u github.com/tomnomnom/anew


echo
echo -e "\033[01;32m[+] ══════════ Instalando Httpx ══════════ [+]\033[01;37m"
echo

GO111MODULE=on go get -v github.com/projectdiscovery/httpx/cmd/httpx


echo
echo -e "\033[01;32m[+] ══════════ Instalando Gau & GauPlus & Waybackurls ══════════ [+]\033[01;37m"
echo

GO111MODULE=on go get -u -v github.com/lc/gau
GO111MODULE=on go get -u -v github.com/bp0lr/gauplus
go get github.com/tomnomnom/waybackurls

echo
echo -e "\033[01;32m[+] ══════════ Instalando Metabigor ══════════ [+]\033[01;37m"
echo

GO111MODULE=on go get github.com/j3ssie/metabigor

echo
echo -e "\033[01;32m[+] ══════════ Instalando Dirsearch ══════════ [+]\033[01;37m"
echo

sudo git clone https://github.com/maurosoria/dirsearch.git
sudo chmod 777 cd dirsearch
cd dirsearch 
sudo chmod 777 * 
pip3 install -r requirements.txt
cd ..

echo
echo -e "\033[01;32m[+] ══════════ Instalando Prips ══════════ [+]\033[01;37m"
echo

sudo apt-get install prips

echo
echo -e "\033[01;32m[+] ══════════ Instalando GF ══════════ [+]\033[01;37m"
echo

go get -u github.com/tomnomnom/gf

echo 'source $GOPATH/src/github.com/tomnomnom/gf/gf-completion.bash' >> ~/.bashrc
echo 'source $GOPATH/src/github.com/tomnomnom/gf/gf-completion.bash' >> ~/.zshrc

cp -r $GOPATH/src/github.com/tomnomnom/gf/examples ~/.gf

echo
echo -e "\033[01;32m[+] ══════════ Instalando Findomain-linux ══════════ [+]\033[01;37m"
echo

sudo wget https://github.com/findomain/findomain/releases/latest/download/findomain-linux
chmod +x findomain-linux
mv findomain /usr/bin/


echo
echo -e "\033[01;32m[+] ══════════ Instalando Chaos ══════════ [+]\033[01;37m"
echo

GO111MODULE=on go get -v github.com/projectdiscovery/chaos-client/cmd/chaos
echo "export CHAOS_KEY=5af78640cccc657746c68414b52cd7ba9ca9950248d290ea36de50249bd74899" >> ~/.zshrc 
echo "export CHAOS_KEY=5af78640cccc657746c68414b52cd7ba9ca9950248d290ea36de50249bd74899" >> ~/.bashrc 


echo
echo -e "\033[01;32m[+] ══════════ Instalando ParamSpider ══════════ [+]\033[01;37m"
echo

sudo git clone https://github.com/devanshbatham/ParamSpider.git

cd ParamSpider
pip3 install -r requirements.txt
cd ..

echo
echo -e "\033[01;32m[+] ══════════ Instalando Unfurl ══════════ [+]\033[01;37m"
echo

go get -u github.com/tomnomnom/unfurl

echo
echo -e "\033[01;32m[+] ══════════ Instalando Arjun ══════════ [+]\033[01;37m"
echo

go get github.com/hakluke/hakrevdns

echo
echo -e "\033[01;32m[+] ══════════ Instalando Dalfox ══════════ [+]\033[01;37m"
echo

GO111MODULE=on go get -v github.com/hahwul/dalfox/v2


echo
echo -e "\033[01;32m[+] ══════════ Baixando SecLists ══════════ [+]\033[01;37m"
echo
sudo git clone https://github.com/danielmiessler/SecLists.git


echo
echo -e "\033[01;32m[+] ══════════ Instalação finalizada ══════════ [+]\033[01;37m"
