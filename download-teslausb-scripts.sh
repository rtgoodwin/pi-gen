#!/bin/bash -eu
# Download setup scripts for making teslausb flash drive on Pi Zero W (at least)
RED='\033[0;31m' # Red for warning
NC='\033[0m' # No Color
GREEN='\033[0;32m'
scripts_downloaded=false
REPO=rtgoodwin
BRANCH=headless-patch
TWEAKDIR="stage7/00-teslausb-tweaks/files/teslausb_setup_scripts"

function stop_message () {
  echo -e "${RED}${1} ${NC}"
}

function good_message () {
  echo -e "${GREEN}${1} ${NC}"
}

if [ ! -d "${TWEAKDIR}" ]
then
    mkdir "${TWEAKDIR}"
    mkdir "${TWEAKDIR}/bin"
    mkdir "${TWEAKDIR}/tmp"
fi
pushd "${TWEAKDIR}/bin"

curl -s -o setup-teslausb-headless https://raw.githubusercontent.com/"$REPO"/teslausb/"$BRANCH"/headless-scripts/setup-teslausb-headless
good_message "Downloaded main setup script."

curl -s -o archiveloop https://raw.githubusercontent.com/"$REPO"/teslausb/"$BRANCH"/windows_archive/archiveloop 
# sed -i'.bak' -e "s/ARCHIVE_HOST_NAME=archiveserver/ARCHIVE_HOST_NAME=$archiveserver/" archiveloop

curl -s -o archive-teslacam-clips  https://raw.githubusercontent.com/"$REPO"/teslausb/"$BRANCH"/windows_archive/archive-teslacam-clips 
good_message "Downloaded the archive scripts."

curl -s -o remountfs_rw https://raw.githubusercontent.com/"$REPO"/teslausb/"$BRANCH"/windows_archive/remountfs_rw
good_message "Downloaded script to remount filesystems read/write if needed (/root/bin/remountfs_rw)."

curl -s -o send-pushover https://raw.githubusercontent.com/"$REPO"/teslausb/"$BRANCH"/windows_archive/send-pushover
good_message "Downloaded Pushover notification script."
popd

pushd "${TWEAKDIR}/tmp"
curl -s -o create-backingfiles-partition.sh https://raw.githubusercontent.com/"$REPO"/teslausb/"$BRANCH"/windows_archive/create-backingfiles-partition.sh
curl -s -o create-backingfiles.sh https://raw.githubusercontent.com/"$REPO"/teslausb/"$BRANCH"/windows_archive/create-backingfiles.sh
curl -s -o make-root-fs-readonly.sh https://raw.githubusercontent.com/"$REPO"/teslausb/"$BRANCH"/windows_archive/make-root-fs-readonly.sh
good_message "Downloading ancillary setup scripts."
popd