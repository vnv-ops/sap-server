# Testplan SAP

1. Clone het project vanop github. `git clone git@github.com:vnv-ops/sap-server.git`
1. [Download](https://store.sap.com/sap/cpa/ui/resources/store/html/SolutionDetails.html?pid=0000014493&catID=&pcntry=DE&sap-language=EN&_cp_id=id-1477346420741-0) de installatie files van SAP ABAP AS V7.51 SP02 en pak deze uit naar een nieuwe map in bovenstaande directory met de naam `sap_install` (i.e. `p2ops-g10/opdracht02/sap`).
1. Open in deze map een terminal naar keuze en installeer de nodige plugins van vagrant.
   * `vagrant plugin install vagrant-disksize`
   * `vagrant plugin install vagrant-reload`
1. Start de server met het commando `vagrant up`.
1. Navigeer naar `sap_install/client/JavaGUI` en installeer de Java client.
1. Als de server opgestart is, open de SAP GUI for Java.
1. Klik op "New Connection" onder het menu "File".
1. Vul bij description een naam naar keuze in. Wij gebruiken de naam "SAP server".
1. Klik op Advanced en zet "Expert mode" aan.
1. Vul aan: `conn=/H/172.16.16.17/S/3200`.
1. Click op Save en log in met je account.
