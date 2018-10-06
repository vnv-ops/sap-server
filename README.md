# SAP ABAP Server

Automatische installatie van een SAP ABAP development server.

## Requirements

* Vagrant
    * Vagrant-disksize: `vagrant plugin install vagrant-disksize`.
    * Vagrant-reload: `vagrant plugin install vagrant-reload`.
* Virtualbox
* [ABAP AS versie: v751 SP02](https://www.sap.com/developer/trials-downloads/additional-downloads/sap-netweaver-as-abap-developer-edition-sp02-7-51-14493.html)
    * [Sybase license key](https://sap.sharepoint.com/sites/101566/Shared%20Documents/Forms/AllItems.aspx?id=%2Fsites%2F101566%2FShared%20Documents%2FASE%20Licenses%5F2019%2Ezip&parent=%2Fsites%2F101566%2FShared%20Documents&p=true&slrid=e5c3959e-f06b-7000-b610-6b7f88234665)
    * [SAP license key](https://sap.sharepoint.com/sites/101566/Shared%20Documents/Forms/AllItems.aspx?id=%2Fsites%2F101566%2FShared%20Documents%2FASE%20Licenses%5F2019%2Ezip&parent=%2Fsites%2F101566%2FShared%20Documents&p=true&slrid=e5c3959e-f06b-7000-b610-6b7f88234665)

## Installatie

Voor deze installatie uit te voeren heeft u de uitgepakte bestanden van SAP AS ABAP nodig. Kopieer alle uitgepakte installatiebestanden naar de shared folder `./sap_install`.

Plaats in deze map ook de license key onder de naam: `SYBASE_ASE_TestDrive.lic`. Je moet steeds de meest recente license key downloaden van de SAP website, zie requirements.

Na de installatie log in via SAP GUI (zie hieronder), en ga naar de `SLICENSE` transactie. Hier vind je de hardware key die je nodig hebt om de SAP licentie aan te vragen (zie requirements). Als je de license key hebt ontvangen klik je op install en selecteer je het gedownloade .txt bestand.

## Configuratie

Zie `config.yml`

```
name: 'SAP Omgeving'            # Naam van de virtuele machine
cpus: 2                         # CPU cores
memory: 6144                    # RAM in MB
disksize: 100GB                 # Grootte van de virtuele schijf, min. 100GB
ip-address: 172.16.16.17        # IP-adres van de virtuele machine
sap_password: projecten2018     # Wachtwoord voor de SAP server. Indien leeg wordt `ABAP2018` gebruikt.
```

## Connecteren via SAP GUI

Een uitgebreid stappenplan kan je vinden onder `docs/gebruikershandleiding.md`.

1. Open de SAP GUI for Java.
1. Klik op `New Connection` onder het menu `File`.
1. Vul bij description een naam naar keuze in.
1. Klik op `Advanced` en zet `Expert mode` aan.
1. Vul aan: `conn=/H/192.168.56.10/S/3200`.
1. Klik op `Save` en log in met onderstaande credentials:
    * Username: `Developer`
    * Password: `Appl1ance`

