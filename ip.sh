#!/bin/bash
clear
echo "---------------------------------------" 
echo "           GERENCIADOR DE IP"
echo "---------------------------------------"
echo
echo "[ 1 ] - Cadastrar manualmente"
echo "[ 2 ] - Gerar IP automático"
echo "[ 3 ] - Remover da lista"
echo "[ 4 ] - Exibir lista de cadastrados"
echo "[ 5 ] - Sair"
echo
read -p "Escolha uma das opções:  " escolha
case $escolha in
    1) read -p "Informe o endereço IP para cadastro: " ip_add
       if [ -e lista.txt ];then
         if [ "$(cat lista.txt | grep $ip_add)" != "$ip_add" ]; then
         read -p "Informe o nome do dispositivo  para o IP $ip_add: " hostname
           echo "$ip_add   =>  $hostname" >> lista.txt
           echo "Aguarde ...."
           sleep 3
           clear
           echo "Cadastrando ..."
           sleep 3
	   clear
           echo "Cadastro realizado com sucesso!"
	   echo
           echo "$(cat lista.txt | grep $ip_add | cut -f1)"


         else
	   echo "Aguarde ..."
           sleep 3
           echo "O IP $ip_add já está em uso, tente novamente!"
         fi
        else
           touch lista.txt
	   read -p "Informe o nome do dispositivo  para o IP $ip_add: " hostname
	   echo "$ip_add   =>  $hostname" >> lista.txt
           echo "Aguarde ...."
           sleep 3
           clear
           echo "Cadastrando ..."
           sleep 3
	   clear
	   echo "Cadastro realizado com sucesso!"
           echo
           echo "$(cat lista.txt | grep $ip_add | cut -f1)"
         fi
       ;;

    2) oct1="$(($RANDOM % 255))"
       oct2="$(($RANDOM % 255))"
       oct3="$(($RANDOM % 255))"
       oct4="$(($RANDOM % 255))"

       ip_aut="$oct1.$oct2.$oct3.$oct4"

       if [ "cat lista.txt | grep $ip_aut" != "$ip_aut" ]; then
         read -p "IP $ip_aut está disponível, deseja continuar? (s) / (n) " resp
         echo
           if [ $resp == "s" ]; then
             read -p "Informe o nome do dispositivo para o IP gerado: " dispositivo
             echo "$ip_aut   =>   $dispositivo" >> lista.txt
             clear
             echo "Aguarde ...."
             sleep 3
             clear
             echo "Cadastrando ..."
             sleep 3
	     clear
             echo "Cadastro realizado com sucesso!"
             echo
             echo "$(cat lista.txt | grep $ip_aut | cut -f1)"
           else
             echo "Tente gerar um novo IP"
           fi
       else
          echo "Este IP já está em uso."
       fi
       ;;


    3) read -p "Informe o endereço IP a ser removido: " ip_del
       if [ "$(cat lista.txt | grep $ip_del) == $ip_del" ]; then
         echo "Os dados a seguir serão deletados: "
         echo
         echo "$(cat lista.txt | grep $ip_del | cut -f1)"
         echo
         read -p "Deseja realmente continuar com a exclusão? (s) ou (n) " resp
         echo
           if [ "$resp" == "s" ]; then
             echo "$(cat lista.txt | grep -v $ip_del)" > lista.txt
             clear
             echo "Exclusão realizada com sucesso!"
           else
	     echo "Operação cancelada!"
           fi
       else
         echo "Endereço IP não consta na lista"
       fi
      ;;

    4) clear
       echo "---------------------------------------------"
       echo "           LISTA DE IP CADASTRADOS"
       echo "--------------------------------------------"
       cat lista.txt

      ;;

    5) clear
        echo "Obrigado por utilizar nosso app ;-)"
      ;;

     *) echo "Opção inválida!"
      ;;
esac
