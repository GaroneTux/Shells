#!/bin/bash

#########################################################################
# Script para verificar User, UID e Bash.                               #
# Nome: listaUsuer.sh                                                   #
# Autor: Etore Garone - garone.tux@gmail.com                            #
# Data: 15/03/2019                                                      #
# Descrição: Listar todos os usuários e mostrar Nome, UID e bash e vai  #
# mostrar status <Encontrado> em resultados de UID >1000.               #
# No final mostra tbm o total de usuários encontrado.                   #
# TIPS: >Este script altera o IFS, mas faz backup antes;                #
#       >Use |grep para ajudar no resultado :)                          #
#                                                                       #
#                                                                       #
#########################################################################

clear
OLDIFS=$IFS # >>backup do IFS defualt do SO.
IFS=$'\n' # >>Novo IFS para quebrar linhas do valor de in.

for i in $(cat /etc/passwd)
 do  USERID=$(echo $i |cut -d ":" -f3)
   if [ $USERID -ge 1000 ]; then

      USER=$(echo $i |cut -d: -f1,3,7 )
       echo " USER ID: $USER"
#   echo
   echo -e   "\t               >>>> fim <<<<\t"

   else [ $USERID -lt 999 ]

      OTHERS=$( echo $i |cut -d: -f1,3,7)
       echo " SYSTEM ID: $OTHERS"
#   echo
     echo -e   "\t             >>>> fim <<<<\t"
     echo

     fi
done
#clear
echo
for n in $(cat /etc/passwd |wc -l)
       do
  echo -e "\t     >>> - TOTAL de USUÁRIOS:"$n" - <<<\t"
echo
done

IFS=$OLDIFS # >>restore do IFS

#EOF
