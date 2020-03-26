#!/bin/bash 

FILE_LEZIONI_FILTRATE="./risultati/orario_filtrato.txt"
FILE_LEZIONI_OGGI="./risultati/lezioni_oggi.txt"
FILE_CONF_MATERIE="./config.conf"

# Check se directory esistono gia'
if [ -d ./risultati ]; then
    echo "La directory esiste."
else
    mkdir ./risultati
fi
if [ -d ./orario ]; then
    echo "La directory esiste."
else
    mkdir ./orario
fi

# Scarico file 
echo "========== Scarico il file aggiornato =========="
wget --no-check-certificate --output-document=./orario/orario.xlsx 'https://docs.google.com/spreadsheets/d/1OeVJ688pmtfMRGlFJIySo1CiJSwv4cymvBi71VJG9DY/export?gid=0&format=xlsx'
echo "========== Converto xlsx to csv =========="
ssconvert ./orario/orario.xlsx ./orario/orario.csv

# Check se il file orario_filtrato.txt esiste già
if [[ -f "$FILE_LEZIONI_FILTRATE" ]];then
	echo > $FILE_LEZIONI_FILTRATE #sovrascrivo il file se esistente
fi

# Check se il file orario_oggi.txt esiste gia'
if [[ -f "$FILE_LEZIONI_OGGI" ]];then
	echo > $FILE_LEZIONI_OGGI #sovrascrivo il file se esistente
fi

# Leggo file di configurazione per ottenere il numero di materie da cercare
declare -a riga_file_conf
declare -i indice=0
while IFS= read -r line
do
	riga_file_conf[indice]=$(( indice ))
	indice=$(( indice+1 ))
done < $FILE_CONF_MATERIE

# Creo le variabili per ogni codice inserito nel file config.conf
declare -a codici_materie
while IFS= read -r line
do
	codici_materie+=( $line )
done < $FILE_CONF_MATERIE
# Codici materie
echo ${codici_materie[@]}

# Per avere data di oggi
DATA_OGGI=$(date +'%Y/%m/%d')
echo "Oggi è : $DATA_OGGI"



###############################################################################################
IFS=","
while read f1 f2 f3 f4 f5 f6 f7 f8 f9 f10
do
	for r in ${riga_file_conf[@]}
	do 
		if [[ "$f5" == *${codici_materie[$r]}* || "$f6" == *${codici_materie[$r]}* ]]; then 	
		echo "======================================================================================================="  >> $FILE_LEZIONI_FILTRATE
		echo "Informazioni cronologiche : $f1" >> $FILE_LEZIONI_FILTRATE
		echo "Info non rilevanti : $f2" >> $FILE_LEZIONI_FILTRATE
		echo "Cognome e nome docente : $f3" >> $FILE_LEZIONI_FILTRATE
		echo "Titolo Insegnamento : $f4" >> $FILE_LEZIONI_FILTRATE
		echo "Codice Insegnamento : $f5" >> $FILE_LEZIONI_FILTRATE
		echo "Codice Insegnamento : $f6" >> $FILE_LEZIONI_FILTRATE
		echo "Data lezione live : $f7" >> $FILE_LEZIONI_FILTRATE
		echo "Ora inizio lezione live : $f8" >> $FILE_LEZIONI_FILTRATE
		echo "Ora fine lezione live : $f9" >> $FILE_LEZIONI_FILTRATE
		echo "Collegamento sessione live da copiare e incollare da interfaccia di gestione Microsoft Teams : $f10" >> $FILE_LEZIONI_FILTRATE
		echo ""  >> $FILE_LEZIONI_FILTRATE

		# Scrivo file per le lezioni del giorno attuale 
		if [[ $DATA_OGGI ==  $f7 || $DATA_OGGI ==  $f8  ]]; then
			echo "======================================================================================================="  >> $FILE_LEZIONI_OGGI
			echo "Informazioni cronologiche : $f1" >> $FILE_LEZIONI_OGGI
			echo "Info non rilevanti : $f2" >> $FILE_LEZIONI_OGGI
			echo "Cognome e nome docente : $f3" >> $FILE_LEZIONI_OGGI
			echo "Titolo Insegnamento : $f4" >> $FILE_LEZIONI_OGGI
			echo "Codice Insegnamento : $f5" >> $FILE_LEZIONI_OGGI
			echo "Codice Insegnamento : $f6" >> $FILE_LEZIONI_OGGI
			echo "Data lezione live : $f7" >> $FILE_LEZIONI_OGGI
			echo "Ora inizio lezione live : $f8" >> $FILE_LEZIONI_OGGI
			echo "Ora fine lezione live : $f9" >> $FILE_LEZIONI_OGGI
			echo "Collegamento sessione live da copiare e incollare da interfaccia di gestione Microsoft Teams : $f10" >> $FILE_LEZIONI_OGGI
			echo ""  >> $FILE_LEZIONI_OGGI
		fi
		fi
	done

	#echo "$f5"
	
done < ./orario/orario.csv

echo "========== Guarda $FILE =========="
echo "========== Converto file .txt -> .pdf =========="
cupsfilter ./risultati/orario_filtrato.txt > ./risultati/orario_filtrato.pdf
cupsfilter ./risultati/lezioni_oggi.txt > ./risultati/lezioni_oggi.pdf
echo "========== OPERAZIONI TERMINATE =========="

