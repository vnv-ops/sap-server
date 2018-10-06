#!/bin/bash

SAP_INSTALL_PATH="/sap_install/"
CONFIG_PATH="/vagrant/provision/config/"
SYSTEMD_PATH="/etc/systemd/system/"
SERVICE_FILE="sap.service"
USER="npladm"
LIC_PATH="/sybase/NPL/SYSAM-2_0/licenses/"
LIC_FILE="SYBASE_ASE_TestDrive.lic"

# Maak env file
su -c "printenv > /home/$USER/service-env.sh" $USER /bin/bash

# Copy service file
cp ${CONFIG_PATH}/${SERVICE_FILE} ${SYSTEMD_PATH}/${SERVICE_FILE}

# Herstart systemd
systemctl daemon-reload

# Enable SAP on reboot
systemctl enable sap

# Activeer license
cp ${SAP_INSTALL_PATH}/${LIC_FILE} ${LIC_PATH}/${LIC_FILE}
chmod 0750 ${LIC_PATH}/${LIC_FILE}
chown sybnpl:sapsys ${LIC_PATH}/${LIC_FILE}

exit 0
