# Technische documentatie SAP omgeving OpenSUSE

## Voorbereiding

* Vagrant versie: v2.2
* Virtualbox versie: v5.2.8
* ABAP AS versie:  v751 SP02

* Voor deze installatie correct uit te voeren heeft u de uitgepakte bestanden van SAP AS ABAP nodig, deze kunnen gedownload worden vanop het internet.

We maken ook gebruik van 2 Vagrant plugins:
* Vagrant-disksize: `vagrant plugin install vagrant-disksize`. Deze gebruiken we om de disksize makkelijk te kunnen aanpassen via de vagrant file.
* Vagrant-reload: `vagrant plugin install vagrant-reload`. Met deze plugin kunnen we een reload

## GitHub

Alle bestanden die worden gebruikt voor deze installatie bevinden zich op github, deze moet u clonen via `git clone git@github.com:vnv-ops/sap-server.git`.

Daarna kopieert u alle uitgepakte bestanden voor de installatie van SAP Netweaver naar de shared folder `./sap_install`

Plaats in deze map ook de license key onder de naam: `SYBASE_ASE_TestDrive.lic`

## Vagrant

Voor de automatisatie van de omgeving maken we gebruik van Vagrant en Virtualbox.

`settings = YAML.load_file File.dirname(File.expand_path(__FILE__)) + '/config.yml'` Hiermee laden we het bestand config.yml in. In deze config file kan u het volgende aanpassen

* `name: 'SAP Omgeving'` Deze variabele laat toe de naam van de box in te stellen.
* `cpus: 2` Het aantal cores dat u wenst te geven aan de virtuele machine kan hier worden gespecifieerd.
* `memory: 6144` Hier kan u het aantal RAM-geheugen dat u aan de virtuele machine geeft instellen (opgelet, minimum van 6144MB is vereist).
* `disksize: 100GB` De disksize van de virtuele machine kan hier worden aangepast.
* `ip-address: 172.16.16.17` Dit wordt het ip-adres van de ABAP AS.
* `sap_password: projecten2018` Dit wachtwoord wordt gebruikt als wachtwoord voor de ABAP AS.

* Volgend codeblock specifieert welk besturingssysteem we gebruiken en de disksize setting wordt geimporteerd vanuit de config file.
```
Vagrant.configure("2") do |config|
  config.vm.box = "bento/opensuse-leap-42.3"
  config.disksize.size = settings['disksize']
```

* Dit laat toe alle settings te importeren vanuit de config file, deze worden nadien meegegeven aan de virtuele machine.
```
config.vm.provider "virtualbox" do |vb|
    vb.name = settings['name']
    vb.cpus = settings['cpus']
    vb.memory = settings['memory']
  end
```

* `config.vm.network "private_network", ip: settings['ip-address']` Hiermee stellen we het ip-adres in vanuit de config file.

* `config.vm.synced_folder "./sap_install", "/sap_install", create: true` Dit maakt ook een shared folder aan die we kunnen gebruiken voor de installatie.

## Installatie en scripts

### Initial-setup

Het eerste script dat wordt uitgevoerd is het script initial-setup.sh, dit script configureert de virtualbox zodat hij klaar is voor de installatie van SAP


* `HOSTNAME="vhcalnplci"` Eerst geven we de hostname "vhcalnplci" mee als hostname, aangezien dit een requirement is voor SAP
* `IP_ADDRESS=$1` Deze variabele wordt geïmporteerd uit het configuratiebestand.

* Als er geen ip-adres meegegeven is, dan wordt het ip-adres van de interface ethernet 1 gekozen.
```
  if [[ -z "$1" ]]; then
      IP_ADDRESS=$(ifconfig eth1 | grep 'inet addr:' | cut -d : -f 2 | awk '{ print $1 }')
  fi
```

* `zypper -n install uuidd` Daarna installeren we uuidd, een daemon die gebruikt wordt om uuids te genereren
* `service uuidd start` Hiermee starten we de uuidd.
* `echo $IP_ADDRESS $HOSTNAME $HOSTNAME.dummy.nodomain >> /etc/hosts` Vervolgens maken we een nieuwe host aan met meegegeven ip-adres en hostname.
* `echo $HOSTNAME > /etc/hostname` Daarna passen we de hostname aan naar de meegegeven hostname, dit is een requirement voor de installatie van SAP.
* Voor de boot time van de virtuele machine te verbeteren doen we het volgende.
```
sed -i 's/GRUB_TIMEOUT=8/GRUB_TIMEOUT=0/g' /etc/default/grub
grub2-mkconfig -o /boot/grub2/grub.cfg
```
* En ten slotte disablen we de firewall van de virtual machine, dit is eveneens een requirement voor SAP.
```
systemctl disable SuSEfirewall2_setup.service
systemctl disable SuSEfirewall2_init.service
```

### Filesystem

Dit script zorgt ervoor dat we correcte partities aanmaken in onze virtualbox.

* `set +e` Dit zorgt ervoor dat als er een error is, het script blijft runnen.
* Dit zorgt ervoor dat er nieuwe partities worden aangemaakt, zodat de volledige schijfruimte benut wordt. Dit doen we via End Of File.
    * `d` Start verwijderen partities.
    * `2` Verwijder dev/sda2.
    * `n` Creëer nieuwe partitie.
    * `p` Type primary.
    * `2` Partitienummer dev/sda2.
    * `/n` Vanaf de eerste sector.
    * `/n` Tot de laatst beschikbare sector
    * `n` Dit staat voor "Gelieve niet de signature van de partitie te verwijderen".
    * `a` Maak partitie bootable.
    * `2` Doe dit voor partitienummer 2.
    * `w` Dit schrijft alle changes naar de disk.
```
fdisk /dev/sda << _EOF_
    d
    2
    n
    p
    2


    n
    a
    2
    w
_EOF_
```

### Btrfs

* `btrfs filesystem resize max /` Breidt de root uit tot de maximale beschikbare capaciteit van de partitie.

### SAP_install

Dit script verwerkt de installatie van SAP

* `SAP_PATH="/sap_install/install.sh"`Dit is een variabele waar we het pad naar het script in opslaan.
* `PASSWORD=$1` In deze variabele slaan we het wachtwoord op dat we hebben meegegeven in de config file.
* Wanneer er geen wachtwoord meegegeven wordt via de configuratie file, wordt het standaard wachtwoord "ABAP2018" gebruikt.
```
if [[ -z "$1" ]]; then
    PASSWORD="ABAP2018"
fi
```

* `chmod +x "${SAP_PATH}"` Dit maakt het installatiescript executable.

* `sleep 1 && kill "$(pgrep more)" &` Tijdens de installatie van SAP wordt er een terms of services getoont en hiermee sluiten we deze.

* Het script geeft volgende user input mee aan het SAP-installatiescript:
    * Ga akkoord met de ToS: `y`
    * Geef het wachtwoord in: `${PASSWORD}`
    * Geef alles door aan het script en sla de hostname check over: `" | bash "${SAP_PATH}" -s`

```
echo "
y
${PASSWORD}
${PASSWORD}
" | bash "${SAP_PATH}" -s
```
