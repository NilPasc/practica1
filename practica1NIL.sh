#!/bin/bash
echo Introduce una opción ; read opcion
codi_pais='xx'
codi_estat='xx'


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
                                codi_pais="$(cut -d',' -f7,8 cities.csv | grep -w $pais | cut -d',' -f1 | uni$
                        else
                                codi_pais='aws'
                        fi
                fi

        ;;
        "se")
                echo "Nombre del estado" ; read estat
                if [[ -z "$estat" ]]
		then
                        codi_estat=$codi_estat
                else
                        if [[ -n "grep $estat cities.csv" ]]
                        then
                                codi_estat="$(cut -d',' -f4,5,7 cities.csv | grep -w $codi_pais | grep -w $es$
                        else
                                codi_estat='xx'
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
        ;;
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
        echo $codi_estat
        echo $wdid  
                        
        echo Introduce una opción ; read opcion
done
        
echo Saliendo de la aplicación

			

