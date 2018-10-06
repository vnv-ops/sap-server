# Gebruikershandleiding

Vereisten:

* git
* Vagrant versie: v2.2 of later
* Virtualbox versie: v5.2.8 of later

## Installatie

1. Clone het project vanop github. `git clone https://github.com/HoGentTIN/p2ops-g10.git`
2. Navigeer naar de bestanden omtrent SAP. `p2ops-g10/opdracht02/sap`
3. [Download](https://store.sap.com/sap/cpa/ui/resources/store/html/SolutionDetails.html?pid=0000014493&catID=&pcntry=DE&sap-language=EN&_cp_id=id-1477346420741-0) de installatie files van SAP ABAP AS V7.51 SP02 en pak deze uit naar een nieuwe map in bovenstaande directory met de naam `sap_install` (i.e. `p2ops-g10/opdracht02/sap`).
4. Plaats de license key in de sap_install folder onder volgende bestandsnaam: `SYBASE_ASE_TestDrive.lic`
5. Open in deze map een terminal naar keuze en installeer de nodige plugins van vagrant.
    * `vagrant plugin install vagrant-disksize`
    * `vagrant plugin install vagrant-reload`
6. Ten slotte typt u `vagrant up` en dan wacht u tot de installatie is afgelopen.
7. Indien u wenst om de virtual machine te verwijderen kan dit met het commando `vagrant destroy`

## Configuratie

* In het configuratiebestand hebben we een aantal variabelen die u kan aanpassen, deze variabelen worden dan meegegeven aan de vagrant file en aan de verschillende scripts.
    * `name` De naam van de virtuele machine.
    * `cpus` Het aantal cores dat de virtuele machine gebruikt.
    * `memory` Het aantal RAM geheugen dat wordt toegekent aan de virtuele machine. (minimum 6144MB)
    * `disksize` De disksize die wordt toegekent aan de virtuele machine. (minimum 100GB)
    * `ip-address` Het ip-adres van de ABAP AS.
    * `sap_password` Het passwoord van de ABAP AS.

## Connecteren via SAP GUI for Java

1. Open de SAP GUI for Java.
2. Klik op "New Connection" onder het menu "File".
3. Vul bij description een naam naar keuze in. Wij gebruiken de naam "SAP server".
4. Klik op Advanced en zet "Expert mode" aan.
5. Vul aan: `conn=/H/172.16.16.17/S/3200`.
6. Click op Save en log in met je account.
