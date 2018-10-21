#!/bin/bash -e

echo "PREV_ROOTFS_DIR is ${PREV_ROOTFS_DIR}"
echo "ROOTFS_DIR is ${ROOTFS_DIR}"

if [ ! -d "${ROOTFS_DIR}" ]; then
	copy_previous
fi
