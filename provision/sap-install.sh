#!/bin/bash

SAP_PATH="/sap_install/install.sh"
PASSWORD=$1

# Gebruik default password indien er geen wordt meegegeven
if [[ -z "$1" ]]; then
    PASSWORD="ABAP2018"
fi

# Maak installatiescript executable
chmod +x "${SAP_PATH}"

# Kill 'more' zodat de terms of service sluiten
sleep 1 && kill "$(pgrep more)" &

# Ga akkoord met de ToS en voer wachtwoord in
echo "
y
${PASSWORD}
${PASSWORD}
" | bash "${SAP_PATH}" -s

exit 0
