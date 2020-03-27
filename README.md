# Orario lezioni LIVE
Script per filtrare le lezioni LIVE, rivolto agli studenti di Ingegneria - UniBg.


### Tool necessari da installare
```shell
sudo apt install gnumeric
sudo apt install cups-filters
```
### Utilizzo
**1)** Aggiungere **SOLO un codice per riga** per ogni corso, nel file config.conf .<br>
Esempio:<br>
Se il corso di Analisi 1 corrisponde al codice : 21090 <br>
Se il corso di Fisica corrsiponde al codice : 21011
<br>
Il file config.conf risulterà : <br>
```text
21090
21011
```
<br><br>
**2)** Rendere eseguibile lo script : <br>
```shell
chmod +x orario.sh
```
<br><br>
**3)** Eseguire lo script : <br>
```shell
./orario.sh
```
