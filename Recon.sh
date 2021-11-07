#!/bin/bash

#echo "Hosts já testados: " 
#echo
#ls ~/Desktop/Bounty
#echo 
#read -p "Deseja testar algum novamente ? Insira o nome para procurar o link: " Link
#echo

#if [ "$Link" == "" ]; then
            
 #   echo 
                  
#else
 #   echo "Hosts encontrados:"
  #  echo
   # ls ~/Desktop/Bounty | grep $Link 
    
#fi

echo
echo -e "\033[01;34m[+] ══════════ Recon Script ScarMan ══════════ [+]\033[01;37m"
echo
echo -e "\033[01;32m[+] ══════════ Por favor, informe o Host ══════════ [+]\033[01;37m"
echo -e "\033[01;32m[+] ══════════ Exemplo: www.google.com ══════════ [+]\033[01;37m"
echo

#while [ "$HOST" == "" ]

#do            
 #   read -p 'Informe o Host: ' HOST
    
  #  if [ "$HOST" != "" ];then

   # echo
     
   # else
    #    echo "Host vázio !"
    
   # fi

#done                  


HOST=$1

if [ "$HOST" == "" ];then
	printf "host vázio !"
	exit
else
	printf ""	
fi

DIR=$HOST
cd /opt/

#Configura bot no telegram
#
#read -p 'Deseja enviar alerta para o telegram ? S/N: ' Notifica


#if [ "$Notifica" == "S" ] || [ "$Notifica" == "S" ]; then
            
#    Notifica="notify -silent"
                  
#else
#    Notifica=""
    
#fi

#Cria pasta "Bounty" no Desktop

if [ -d "Bounty" ]; then

    echo -e "\033[01;31m[+] ══════════ Diretório Bounty existe ══════════ [+]\033[01;37m"
    cd /opt/Bounty

else
    echo -e "\033[01;32m[+] ══════════ Diretório Bounty Criado ══════════ [+]\033[01;37m"
    mkdir /opt/Bounty
    cd /opt/Bounty
    
fi

#Cria diretório do alvo

if [ -d "$DIR" ]; then

    echo -e "\033[01;31m[+] ══════════ Diretório $HOST Existe ══════════ [+]\033[01;37m"
    echo
    cd $HOST

else
    echo -e "\033[01;32m[+] ══════════ Diretório $HOST Criado ══════════ [+]\033[01;37m"
    echo
    mkdir $HOST
    cd /opt/Bounty/$HOST

fi

PS3='Escolha o Scan: '
options=( "Subfinder" "Sub + Way" "Find + Way" "Dirsearch Dir" "Dirsearch Files" "Findomain" "Nuclei Subfinder" "Nuclei Findomain" "DalfoxWayback" "DalfoxGauPlus" "crt.sh" "Chaos" "Gau" "GauPlus" "Wayback" "Metabigor" "GF Gauplus" "GF Wayback" "Unfurl" "Arjun" "ParamSpider" "Quit")

select opt in "${options[@]}"
do
    
    case $opt in

        "Subfinder")
            echo -e "\033[01;33m[+] ══════════ Running Subfinder ══════════ [+]\033[01;37m"
            
            subfinder -d $HOST | httpx | anew "Subfinder.txt" 
            ;;

        "Sub + Way")
            echo -e "\033[01;33m[+] ══════════ Running Subfinder + Waybackurls ══════════ [+]\033[01;37m"
            
           sub=`subfinder -d $HOST | httpx`

            for x in $sub;
            do

            echo "$x" | waybackurls | anew "$HOST-Subfinder-Wayback.txt"

            done
                    
            ;;

        "Find + Way")
            echo -e "\033[01;33m[+] ══════════ Running Findomain + Waybackurls ══════════ [+]\033[01;37m"
            
           sub=`findomain -t $HOST | httpx`

            for x in $sub;
            do

            echo "$x" | waybackurls | anew "$HOST-Findomain-Wayback.txt"

            done
                    
            ;;
        "Findomain")
            echo -e "\033[01;33m[+] ══════════ Executando Findomain ══════════ [+]\033[01;37m"
            echo
            findomain -t "$HOST" | httpx | anew "Findomain.txt"
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

        "Nuclei Findomain")
            echo -e "\033[01;33m[+] ══════════ Executando Nuclei ══════════ [+]\033[01;37m"
            echo
            update-templates
            findomain -t "$HOST" | httpx -silent | nuclei -t ~/nuclei-templates/ | anew "nuclei.txt"
            ;;

        "Nuclei Subfinder")
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
        "Unfurl")
            echo -e "\033[01;33m[+] ══════════ Executando Unfurl ══════════ [+]\033[01;37m"
            echo
            echo "$HOST" | waybackurl | unfurl Keys | anew "Unfurl.txt"
            ;;


                        
        "Sair")
            break

            ;;
        *) echo "Opção inválida $REPLY";;
    esac
done
    
