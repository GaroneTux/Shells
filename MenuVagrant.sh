#!/bin/bash
#########################################################################
# Menu para ajudar no uso de VMs com Vagrant-V7			                  	#
# Homologado para uso com Vagrant V2.2.7			                          #
# Autor: Etore Garone (garone.tux@gmail.com)                            #
# Data Criação: 27/02/2017                                              #
# >>> Script com menu em <case in esac> para ações em uma VM            #
# gerenciada pelo Vagrant.	                                            #
# OBS.: Rodar este .sh no mesmo dir do Vagrantfile		                  #
# 29/01/2020 - Add opção 5 e 6. > egarone                               #
# 29/01/2020 - Add opção while: encerra somente com "q" > egarone       #
# 25/04/2020 - Add opções: DD, s, l, d, v no Menu > egarone		          #
# 12/05/2020 - Add Criação de Snapshot -Fast Mode > egarone             #
#                                                                       #
#                                                                       #
#########################################################################

clear
echo
echo "******** - ATENÇÃO - Rodar este script no mesmo diretório que esta o Vagrantfile - ******** "
sleep 1 
echo
while :
  do
echo
echo "==========- Escolha o que deseja fazer: - =========="
echo 
# Menu:
echo ">>>>>>>>>> - Ações na VM - <<<<<<<<<<"
echo "1 - Apenas iniciar."
echo "2 - Iniciar VM e acessar SSH."
echo "3 - Apenas acessar SSH."
echo "4 - Desligar."
echo "5 - Reload na VM. > Faz reset de cfgs."
echo "6 - Restart."
echo
echo ">>>>>>>>>> - Gerenciar VM - <<<<<<<<<<"
echo "v - Ver status da VM."
echo "D - Destruir VM. >>> Be careful <<<"
echo "s - Salvar Snapshot. >> FAST Mode."
echo "S - Salvar Snapshot. >> Escolha o nome."
echo "l - Listar Snapshots."
echo "d - Delete Snapshot."
echo "r - Restore Snapshot."
echo "q - Sair."
echo
echo "===================================================="
read -p "Digite a Opção desejada: " opcao

#Rotinas:
# >>>>>>>>>> - Ações na VM - <<<<<<<<<<
case "$opcao" in
  1)
    echo "Iniciando VM - aguarde..."
    vagrant up
    echo
    ;;
  2)
    echo "Iniciando VM - aguarde..."
    vagrant up
    vagrant ssh
    echo 
    echo
    ;;

  3)
    echo "Acessando VM via SSH - aguarde..."
    vagrant ssh
    echo
    ;;
  4)
    echo "Desligando VM - aguarde..."
    vagrant halt
    echo
    ;;
  5)
    echo "Reload em andamento - aguarde..."
    vagrant 'reload'
    vagrant ssh
    echo
    ;;
  6)
    echo "Restart em andamento - aguarde..."
    echo "desligando..."
    vagrant halt
    echo "reninicando..."
    vagrant up
    echo "acessando SSH"
    vagrant ssh
    echo
    clear
    ;;
 q)
    echo "Saindo . . ."
    sleep 1
    exit 0
    clear
    ;;

#>>>>>>>>>> - Gerenciar VM - <<<<<<<<<<
 
 D)
    echo " Removendo VM. . ."
    vagrant halt
    echo
    vagrant destroy
    echo
    ;;
 s)
    echo " Criar Snapshot da VM >> FAST MODE. . ."
    vagrant snapshot save VM-$(date +%d/%m/%y_%H:%M)
    vagrant snapshot list
    echo
    ;;    
 S)
    echo " Para criar Snapshot,rescolha o nome. . ."
    echo
    echo " >>>>>>>>>>>>>> | ATENÇÃO | <<<<<<<<<<<<<< "
    echo
    echo "1- Será adicionado data(dd) e hora(hh:mm) no nome."
    echo
    echo "2- Escolha nomes curtos mas que você lembre do que se trata."
    echo
    read -p "digite o nome desejado ou <Crtl C> para sair:  " nomesnap
    vagrant snapshot save "$nomesnap"-$(date +%d_%H:%M)
    vagrant snapshot list
    echo
#    clear
    ;;    


l)
    echo " Listar Snapshots existentes. . ."
    vagrant snapshot list
    echo
    ;;    
 v)
    echo " Verificando status da VM. . ."
    echo
    echo
    vagrant status
    echo
    ;;    
 d)
    echo " Remover Snapshots - ATENÇÃO - Verifique e digite o nome... "
    vagrant snapshot list
    read -p "digite o nome desejado ou <Ctrl C> para sair: " nomedel
    vagrant snapshot delete "$nomedel"
    echo
    vagrant snapshot list
    echo
    ;;      
r)
    echo " Restaura Snapshot >>LEMBRE-SE<< para aplicar a snapshot desejada a VM será reiniciada!!!"
    vagrant snapshot list
    read -p "digite o nome desejado ou <Crtl C> para sair: " nomerestore
    vagrant snapshot restore "$nomerestore"
    echo
    ;;      
 *)
    echo "Opção Inválida - Saindo..." 
    sleep 1
    exit 2
    clear
    ;;
esac
done
#EOF

