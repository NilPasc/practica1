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
		cut -d ',' -f1,2,7 cities.csv | grep -w $codi_pais | cut -d',' -f1,2 | column -s ', ' 
	;;
	"lcp") 
		cut -d ',' -f2,7,11 cities.csv | grep -w $codi_pais | cut -d',' -f1,3  
	;;	
	"ecp")
		cut -d ',' -f2,7,11 cities.csv | grep -w $codi_pais | cut -d',' -f1,3 > "archivosp.csv/$codi_pais.csv"
 	;;	
        "ce")
		cut -d',' -f2,4,7,11 cities.csv | grep -w $codi_pais | grep -w $codi_ciudad | cut -d',' -f1,4	
	;;
	"lce")
		cut -d',' -f2,4,7,11 cities.csv | grep -w $codi_pais | grep -w $codi_ciudad | cut -d',' -f1,4  > "archivosc.csv/${codi_pais}_${codi_ciudad}.csv"
	;;
	"gwd") 
<<<<<<< HEAD
 		cut -d',' -f2 
=======

>>>>>>> 31ba6185731ddf21841fb0fa0a4bb118c422b374
	
	esac
	echo $codi_pais
	echo $codi_ciudad

        echo Introduce una opción ; read opcion       
done
