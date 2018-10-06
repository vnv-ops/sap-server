# Gebruikershandleiding SAP-omgeving

Vereisten:

* SAP GUI for Java / SAP Gui for Windows
* Virtualbox versie: v5.2.8 of later
* sap-omgeving.ova bestand

## Installatie

1. Dubbelklik op de sap-omgeving.ova file. Dit opent automatisch virtualbox.
2. Klik op `Import` om de virtuele machine te importeren.

![Import](img/import.png)

3. Wacht tot de virtuele machine geïmporteerd is.
4. Start de machine met de `Headless start` optie. Wacht een tweetal minuten alvorens te connecteren, zodat de server volledig kan opstarten.

![Start](img/start.png)

## Connecteren met SAP GUI for Java

1. Open de SAP GUI for Java.
2. Klik op `New Connection` onder het menu `File`.

![File](img/file.png)

3. Vul de vereiste velden in volgens onderstaande foto.

![Connectie](img/connectie.png)

4. Druk vervolgens op `Save` en je server wordt toegevoegd aan de lijst in de SAP-client.
5. Ten slotte selecteer je de server en maak je verbinding door op `Connect` te drukken.

![SAP](img/sap.png)

## Connecteren met SAP GUI for Windows

1. Open de SAP GUI for Windows.
2. Klik op `New` voor een nieuwe connectie te maken.

![Windows](img/windows.png)

3. Op het volgende venster klik je op `Next`.
4. Vul de vereiste velden in volgens onderstaande foto.

![Server](img/server.png)

5. Druk vervolgens nog twee maal op `Next` en nog een keer op `Finish`.
7. Ten slotte maak je verbinding met de server door te dubbelklikken op `SAP`.

## Server afsluiten

1. Alvorens je pc af te sluiten, moet je eerst de server uitzetten. Hiervoor druk je op `ACPI Shutdown`.

![shutdown](img/shutdown.png)
