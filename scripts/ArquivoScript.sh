#!/bin/bash

#Comando para executar a criação de um arquivo de texto.
DTHR=`date +'%d-%m-%Y_%T'`

exec > /pasta/Filipe/ArquivoDeSaida-$DTHR.txt

#Variável para verificar o apache
VERIFICA=$(systemctl status httpd)

if [[ "${VERIFICA}" != *"active (running)"* ]]
then
	DTHR=`date +'%d-%m-%Y_%T'`
	echo $DTHR" - O apache está offline."

else
	DTHR=`date +'%d-%m-%Y_%T'`
	echo $DTHR" - O apache está online."

fi

