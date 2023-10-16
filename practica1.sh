#!/bin/bash
echo Introduce una opción ; read opcion 
codi_pais='xx'
codi_ciudad='xx'


while [[ $opcion != "q" ]]
do
	case $opcion in
	"q") 
		echo Saliendo de la aplicación
	;;	
	"lp") 
		cut -d',' -f7,8 cities.csv | uniq | column -s ','
	;;
	"sc") 
		echo "Nombre del país" ; read pais
		if [[ -z "$pais" ]]
		then 
			codi_pais=$codi_pais
		else 
			if  [[ -n "grep $pais cities.csv" ]]
			then 
				codi_pais="$(cut -d',' -f7,8 cities.csv | grep -w $pais | cut -d',' -f1 | uniq)"
			else
				codi_pais='aws'
			fi
		fi
	
	;;
	"se") 
		echo "Nombre de la ciudad" ; read ciudad	
		if [[ -z "$ciudad" ]]
		then 
			codi_ciudad=$codi_ciudad
		else 
			if [[ -n "grep $ciudad cities.csv" ]]
			then 
				codi_ciudad="$(cut -d',' -f4,5,7 cities.csv | grep -w $codi_pais | grep -w $ciudad | cut -d',' -f1 | uniq)"
			else 
				codi_ciudad='xx'
			fi
		fi
	;;
	"le")
		cut -d ',' -f1,2,7 cities.csv | grep -w $codi_pais | cut -d',' -f1,2 | awk -F',' '{print $1, $2}' 
	;;
	"lcp") 
		cut -d ',' -f2,7,11 cities.csv | grep -w $codi_pais | cut -d',' -f1,3 | awk -F',' '{print $1, $2}'  
	;;	
	"ecp")
		cut -d ',' -f2,7,11 cities.csv | grep -w $codi_pais | cut -d',' -f1,3 |awk -F',' '{print $1, $2}' > "archivosp.csv/$codi_pais.csv"
 	;;	
        "ce")
		cut -d',' -f2,4,7,11 cities.csv | grep -w $codi_pais | grep -w $codi_ciudad | cut -d',' -f1,4 | awk -F',' '{print $1, $2}' 
	;;
	"lce")
		cut -d',' -f2,4,7,11 cities.csv | grep -w $codi_pais | grep -w $codi_ciudad | cut -d',' -f1,4 | awk -F',' '{print $1, $2}' > "archivosc.csv/${codi_pais}_${codi_ciudad}.csv"
	;;
	"gwd") 
		echo Introduce el nombre del pueblo ; read pueblo 
		wdid="$(cut -d ',' -f2,4,7,11 cities.csv | grep -w $codi_pais | grep -w $codi_ciudad | grep -w $pueblo | cut -d ',' -f4)"
	if [[ -z "$wdid" ]]
		then 
			echo El pueblo seleccionado no tiene WikiDataID
		else 
			curl https://www.wikidata.org/wiki/Special:Entity Data//$wdid.json > "archivosj.csv/$wdid.json"
	fi
	;; 
	esac
	echo $codi_pais
	echo $codi_ciudad
	echo $wdid 
        echo Introduce una opción ; read opcion       
done

echo Saliendo de la apicación
