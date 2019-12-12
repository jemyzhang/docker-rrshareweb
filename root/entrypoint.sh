#!/bin/sh

# make folders
mkdir -p \
	/mnt \
	/rrshare

DEFAULT_PACKAGE_PATH=/defaults/
UPGRADE_PACKAGE_PATH=/upgrades/

# install default
if [ ! -f /rrshare/rrshareweb ]; then
  echo "Installing ..."
  cp -af ${DEFAULT_PACKAGE_PATH}/* /rrshare/
  # set permissions
  chown -R rrshare:rrshare \
      /rrshare \
      /mnt
fi

# check upgrade
if [ -f ${UPGRADE_PACKAGE_PATH}/rrshareweb ]; then
  checksum_src=$(md5sum /rrshare/rrshareweb | cut -d " " -f 1)
  checksum_dst=$(md5sum ${UPGRADE_PACKAGE_PATH}/rrshareweb | cut -d " " -f 1)
  if [ ! $checksum_src = $checksum_dst ]; then
    echo "Upgrading ..."
    cp -af ${UPGRADE_PACKAGE_PATH}/* /rrshare/
    # set permissions
    chown -R rrshare:rrshare \
        /rrshare \
        /mnt
  fi
fi

echo "Running..."
exec su-exec rrshare /rrshare/rrshareweb
