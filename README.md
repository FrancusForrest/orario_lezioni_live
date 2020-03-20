# Orario lezioni LIVE
Script per filtrare le lezioni LIVE, rivolto agli studenti di Ingegneria - UniBg.


### Tool necessari da installare
Utilizzato per la conversione .txt a .pdf .
```shell
sudo apt-get install cups-filters
```
### Utilizzo 
**1)** Aggiungere **SOLO un codice per riga** per ogni corso, nel file config.conf .<br>
Esempio:<br>
Se il corso di Analisi 1 corrisponde al codice : 21090 <br>
Se il corso di Fisica corrsiponde al codice : 21011
<br>
Apro il file config.conf, e incollerò **SOLO** : <br>
```text
21090
21011
```
Salvo il file e lo chiudo. 
<br><br>
**2)** Apri la shell e vai alla directory dove si trova il file, e digita :
```text
./orario.sh
```
