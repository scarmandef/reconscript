#!/bin/bash


#Caso não queira está mensagem toda vez que executar o script...

echo "Hosts já testados: " 
echo
ls ~/Desktop/Recon
echo 
read -p "Deseja testar algum novamente ? Insira o nome para procurar o link: " Link
echo

if [ "$Link" == "" ]; then
            
    echo 
                  
else
    echo "Hosts encontrados:"
    echo
    ls ~/Desktop/Recon | grep $Link 
    
fi

#...Remova o código até aqui.

echo
echo -e "\033[01;34m[+] ══════════ Recon Script by ScarmanDef ══════════ [+]\033[01;37m"
echo
echo -e "\033[01;32m[+] ══════════ Por favor, informe o Host  ══════════ [+]\033[01;37m"
echo -e "\033[01;32m[+] ══════════ Exemplo: www.google.com ══════════ [+]\033[01;37m"
echo

while [ "$HOST" == "" ]

do            
    read -p 'Informe o Host: ' HOST
    
    if [ "$HOST" != "" ];then
    
    echo 
    
    else
        echo "Host vázio !"
    
    fi

done   

DIR=$HOST
cd ~/Desktop

#Notifica bot no telegram

read -p 'Deseja enviar alerta para o telegram ? S/N: ' Notifica


if [ "$Notifica" == "S" ] || [ "$Notifica" == "S" ]; then
            
    Notifica="notify -silent"
                  
else
    Notifica=""
    
fi

#Cria pasta "Bounty" no Desktop

if [ -d "Recon" ]; then

    cd ~/Desktop/Recon

else
    echo -e "\033[01;32m[+] ══════════ Diretório Recon Criado ══════════ [+]\033[01;37m"
    mkdir Recon
    cd Recon
    
fi

#Cria diretório do alvo

if [ -d "$DIR" ]; then

    
    cd $HOST

else
    echo -e "\033[01;32m[+] ══════════ Diretório $HOST Criado ══════════ [+]\033[01;37m"
    echo
    mkdir $HOST
    cd ~/Desktop/Recon/$HOST

fi

PS3='Escolha o Scan: '
options=( "Subfinder" "Dirsearch Diretorios" "Dirsearch Arquivos" "Findomain" "Nuclei" "DalfoxWayback" "DalfoxGauPlus" "crt.sh" "Chaos" "Gau" "GauPlus" "Wayback" "Metabigor" "GF Gauplus" "GF Wayback" "Arjun" "ParamSpider" "All" "Quit")

select opt in "${options[@]}"
do
    
    case $opt in

        "Subfinder")
            echo -e "\033[01;33m[+] ══════════ Running Subfinder ══════════ [+]\033[01;37m"
            if [ -e "Subfinder.txt" ] ; then
                cat "Subfinder.txt"
            else
                echo
                subfinder -d $HOST | httpx -status-code -title | anew "Subfinder.txt"
            fi
            ;;
        "Findomain")
            echo -e "\033[01;33m[+] ══════════ Executando Findomain ══════════ [+]\033[01;37m"
            echo
            findomain -t "$HOST" | httpx -status-code -title | anew "Findomain.txt"
            ;;
        "Dirsearch Dir")
            echo -e "\033[01;33m[+] ══════════ Executando Dirsearch ══════════ [+]\033[01;37m"
            echo
            python3 /opt/reconbb/dirsearch/dirsearch.py -u "$HOST" --random-agent -w /opt/reconbb/SecLists-master/Discovery/Web-Content/directory-list-2.3-medium.txt
            ;;
        "Dirsearch Files")
            echo -e "\033[01;33m[+] ══════════ Executando Dirsearch ══════════ [+]\033[01;37m"
            echo
            python3 /opt/reconbb/dirsearch/dirsearch.py -u "$HOST" --random-agent -w /opt/reconbb/SecLists-master/Discovery/Web-Content/raft-large-files.txt
            ;;
        "Nuclei")
            echo -e "\033[01;33m[+] ══════════ Executando Nuclei ══════════ [+]\033[01;37m"
            echo
            update-templates
            subfinder -d "$HOST" | httpx -silent | nuclei -t ~/nuclei-templates/ | anew "nuclei.txt"
            ;;
        "DalfoxWayback")
            echo -e "\033[01;33m[+] ══════════ Executando DalfoxWayback ══════════ [+]\033[01;37m"
            echo
            echo "$HOST" | waybackurls | gf xss | gf idor | gf ssrf | dalfox pipe --skip-bav | $Notifica
            ;;  
        "DalfoxGauPlus")
            echo -e "\033[01;33m[+] ══════════ Executando DalfoxGauplus ══════════ [+]\033[01;37m"
            echo
            echo "$HOST" | gauplus | gf xss | gf idor | gf ssrf | dalfox pipe --skip-bav | $Notifica                 
            ;;
        "Chaos")
            echo -e "\033[01;33m[+] ══════════ Executando Chaos ══════════ [+]\033[01;37m"
            echo
            chaos -d $HOST | anew "Chaos.txt"
            ;;
        "crt.sh")
            echo -e "\033[01;33m[+] ══════════ Executando Crt.sh ══════════ [+]\033[01;37m"
            echo
            curl -s "https://crt.sh/?q=%25.$HOST&output=json" | jq -r '.[].name_value' | sed 's/\*\.//g' | anew "Crt.sh.txt"
            ;;
        "Gau")
            echo -e "\033[01;33m[+] ══════════ Executando Gau ══════════ [+]\033[01;37m"
            echo
            echo "$HOST" | gau -b png,jpg,gif | anew "Gau.txt"
            ;;
        "GauPlus")
            echo -e "\033[01;33m[+] ══════════ Executando GauPlus ══════════ [+]\033[01;37m"
            echo
            echo "$HOST" | gauplus -b png,jpg,gif | anew "GauPlus.txt"
            ;;
        "Wayback")
            echo -e "\033[01;33m[+] ══════════ Executando Waybackurls ══════════ [+]\033[01;37m"
            echo
            echo "$HOST" | waybackurls | anew "Wayback.txt"
            ;;
        "Metabigor")
            echo -e "\033[01;33m[+] ══════════ Executando Metabigor ══════════ [+]\033[01;37m"
            echo
            echo "$HOST" | metabigor net --org -v | awk '{print $3}' | sed 's/[[0-9]]\+\.//g' | xargs -I@ sh -c 'prips @ | hakrevdns | anew metabigor.txt'
            ;;
        "GF Gauplus")
            echo -e "\033[01;33m[+] ══════════ Executando GFGauXSS ══════════ [+]\033[01;37m"
            echo
            echo "$HOST"| gauplus | gf xss | anew "GFGauXSS.txt"
            ;;
        "GF Wayback")
            echo -e "\033[01;33m[+] ══════════ Executando GFWaybackXSS ══════════ [+]\033[01;37m"
            echo
            echo "$HOST"| waybackurls | gf xss | gf idor | gf ssrf | anew "GFWaybackXSS.txt" 
            ;;
        "Arjun")
            echo -e "\033[01;33m[+] ══════════ Executando Arjun ══════════ [+]\033[01;37m"
            echo
            arjun -u "https://$HOST" -oT "Arjun.txt"
            ;;
        "ParamSpider")
            echo -e "\033[01;33m[+] ══════════ Executando ParamSpider ══════════ [+]\033[01;37m"
            echo
            python3 /opt/reconbb/ParamSpider/paramspider.py -d $HOST 
            ;;
      


        "All")

            echo -e "\033[01;32m[+] ══════════ Começando Scan Completo ══════════ [+]\033[01;37m"
            echo
            

            echo -e "\033[01;33m[+] ══════════ Executando Subfinder ══════════ [+]\033[01;37m"
            subfinder -d $HOST  | httpx -status-code -title | anew "Subfinder.txt"
            echo
           
            echo -e "\033[01;33m[+] ══════════ Executando Findomain ══════════ [+]\033[01;37m"
            findomain -t "$HOST" | httpx -status-code -title | anew "Findomain.txt"
            echo

            echo -e "\033[01;34m[+] ══════════ Executando Chaos ══════════ [+]\033[01;37m"
            chaos -d $HOST | anew "Chaos.txt"
            echo

            echo -e "\033[01;33m[+] ══════════ Executando crt.sh ══════════ [+]\033[01;37m"
            curl -s "https://crt.sh/?q=%25.$HOST&output=json" | jq -r '.[].name_value' | sed 's/\*\.//g' | anew "Crt.sh.txt" 
            echo

            echo -e "\033[01;35m[+] ══════════ Executando Gau ══════════ [+]\033[01;37m"         
            echo "$HOST" | gau -b png,jpg,gif | anew "gau.txt"
            echo

            echo -e "\033[01;36m[+] ══════════ Executando Gauplus ══════════ [+]\033[01;37m"         
            echo "$HOST" | gauplus -b png,jpg,gif | anew "Gauplus.txt"
            echo

            echo -e "\033[01;32m[+] ══════════ Executando Metabigor ══════════ [+]\033[01;37m"         
            echo "$HOST" | metabigor net --org -v | awk '{print $3}' | sed 's/[[0-9]]\+\.//g' | xargs -I@ sh -c 'prips @ | hakrevdns | anew metabigor.txt'
            echo
            
            echo -e "\033[01;33m[+] ══════════ Executando Waybackurls ══════════ [+]\033[01;37m"         
            echo "$HOST" | waybackurls | anew "Wayback.txt"
            echo

            echo -e "\033[01;35m[+] ══════════ Executando GF Gauplus ══════════ [+]\033[01;37m"         
            echo "$HOST"| gauplus | gf xss | gf idor | gf ssrf | anew "GFGauXSS.txt"
            echo

            echo -e "\033[01;32m[+] ══════════ Executando GF Wayback ══════════ [+]\033[01;37m"
            echo "$HOST"| waybackurls | gf xss | gf idor | gf ssrf | anew "GFWaybackXSS.txt" 
            echo

            echo -e "\033[01;33m[+] ══════════ Executando Nuclei ══════════ [+]\033[01;37m"
            echo
            update-templates
            subfinder -d "$HOST" | httpx -silent | nuclei -t ~/nuclei-templates/ | anew "nuclei.txt"
            echo

            echo -e "\033[01;31m[+] ══════════ Executando Arjun ══════════ [+]\033[01;37m"
            arjun -u "https://$HOST" -oT "Arjun.txt"
            echo

            echo -e "\033[01;32m[+] ══════════ Executando ParamSpider ══════════ [+]\033[01;37m"
            python3 /opt/reconbb/ParamSpider/paramspider.py -d $HOST
            echo
                         
            echo -e "\033[01;33m[+] ══════════ Executando DalfoxWayback ══════════ [+]\033[01;37m"
            echo "$HOST" | waybackurls | gf xss | gf idor | gf ssrf | dalfox pipe --skip-bav | $Notifica
            echo

            
            echo -e "\033[01;33m[+] ══════════ Executando DalfoxGauPlus ══════════ [+]\033[01;37m"
            echo
            echo "$HOST" | gauplus | gf xss | gf idor | gf ssrf | dalfox pipe --skip-bav | $Notifica

            echo
            echo -e "\033[01;33m[+] ══════════ Scan Finalizado ══════════ [+]\033[01;37m"

             ;;
                        
        "Sair")
            break

            ;;
        *) echo "Opção inválida $REPLY";;
    esac
done
    
