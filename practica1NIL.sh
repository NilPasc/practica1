#!/bin/bash
echo "Sortir (q)"   
echo "Llistar països (lp)"
echo "Seleccionar país (sc)"
echo "Seleccionar estat (se)"
echo "LListar els estats del país seleccionat (le)"
echo "Llistar les poblacions del país seleccionat (lcp)"
echo "Extreure les poblecions del país seleccionat (ecp)"
echo "Llistar les poblacions de l’estat seleccionat (lce)"
echo "Extreure les poblacions de l’estat seleccionat (ce)"
echo "Obtenir dades d’una ciutat de la WikiData (gwd)"
echo "Obtenir estadístiques (est)"
echo Introduce una opción ; read opcion 
codi_pais='aws'
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
				codi_ciudad="$(cut -d',' -f4,5 cities.csv | grep -w $ciudad | cut -d',' -f1 | uniq)"
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
                if [[ "$codi_pais" != "xx" ]]
                then
                    cut -d ',' -f2,7,11 cities.csv | grep -w $codi_pais | cut -d',' -f1,3 > "archpractica1.csv/$codi_pais.csv"
                    echo "Se ha generado el archivo codi_pais.csv correctamente."
                else
                    echo "Error: Para generar el archivo debes seleccionar un pais con la opción "sc"."
                fi
        ;;
        "lce")
                cut -d ',' -f2,4,7,11 cities.csv | grep -w $codi_pais | grep -w $codi_estat | cut -d ',' -f1,4
        ;;
        "ce")
                cut -d ',' -f2,4,7,11 cities.csv | grep -w $codi_pais | grep -w $codi_estat | cut -d ',' -f1,4 > "archpractica1.csv/${codi_pais}_${codi_estat}.csv"
        ;;
        "gwd")
                echo "Nombre de la población" ; read poblacio
                wdid="$(cut -d ',' -f2,4,7,11 cities.csv | grep -w $codi_pais | grep -w $codi_estat | grep -w $poblacio |  cut -d ',' -f4)"
        if [[ -z "$wdid" ]] 
                then
                        echo "Esta poblacion no obstenta WikiDataId o no pertecene al pais o estado seleccionados"
                else
                        curl https://www.wikidata.org/wiki/Special:Entity Data//$wdid.json > "archivosjasonp1.csv/$wdid.json"
        fi   
	"est")
                nord="$(awk -F',' '{ if ($9 > 0) nord +=1 } END { print nord }' cities.csv)"
                sur="$(awk -F',' '{ if ($9 < 0) sur +=1 } END { print sur} ' cities.csv)"
                est="$(awk -F',' '{ if ($10 > 0) oriental +=1 } END { print oriental }' cities.csv)"
                oest="$(awk -F',' '{ if ($10 < 0) occidental +=1 } END { print occidental }'
cities.csv)"
                NoUbic="$(awk -F',' '{ if ($10 == 0 && $9 == 0) NoUbic +=1 } END { print NoUbic }'
cities.csv)"
                NoWiki="$(awk -F',' '{ if ($11 == '') NoWiki +=1 } END { print NoWiki }' cities.csv)"
        echo Nord $nord Sur $sur Est $est Oest $oest NoUbic $NoUbic No WDId $NoWiki            
        ;;
		
	esac
	echo $codi_pais
	echo $codi_ciudad

        echo Introduce una opción ; read opcion       
done
