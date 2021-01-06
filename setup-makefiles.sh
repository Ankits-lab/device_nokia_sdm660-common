#!/bin/bash
#
<<<<<<< HEAD
# Copyright (C) 2019 The LineageOS Project
# Copyright (C) 2020 The AncientOS Project
=======
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2020 The LineageOS Project
>>>>>>> ca355e734115cfe86b0b0a3ae4abdda13e091fcf
#
# SPDX-License-Identifier: Apache-2.0
#

set -e

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

<<<<<<< HEAD
ANCIENT_ROOT="$MY_DIR"/../../..

HELPER="$ANCIENT_ROOT"/vendor/ancient/build/tools/extract_utils.sh


if [ ! -f "$HELPER" ]; then
    echo "Unable to find helper script at $HELPER"
=======
ANDROID_ROOT="${MY_DIR}/../../.."

HELPER="${ANDROID_ROOT}/tools/extract-utils/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
    echo "Unable to find helper script at ${HELPER}"
>>>>>>> ca355e734115cfe86b0b0a3ae4abdda13e091fcf
    exit 1
fi
source "${HELPER}"

<<<<<<< HEAD
# Initialize the helper for common device
setup_vendor "$DEVICE_COMMON" "$VENDOR" "$ANCIENT_ROOT" true
=======
# Initialize the helper for common
setup_vendor "${DEVICE_COMMON}" "${VENDOR}" "${ANDROID_ROOT}" true
>>>>>>> ca355e734115cfe86b0b0a3ae4abdda13e091fcf

# Warning headers and guards
write_headers "DRG PL2"

# The standard common blobs
write_makefiles "${MY_DIR}/proprietary-files.txt" true

# Finish
write_footers

<<<<<<< HEAD
# Initialize the helper for device
setup_vendor "$DEVICE" "$VENDOR" "$ANCIENT_ROOT"
=======
if [ -s "${MY_DIR}/../${DEVICE}/proprietary-files.txt" ]; then
    # Reinitialize the helper for device
    setup_vendor "${DEVICE}" "${VENDOR}" "${ANDROID_ROOT}" false
>>>>>>> ca355e734115cfe86b0b0a3ae4abdda13e091fcf

    # Warning headers and guards
    write_headers

    # The standard device blobs
    write_makefiles "${MY_DIR}/../${DEVICE}/proprietary-files.txt" true

    # Finish
    write_footers
fi
