#!/bin/bash
#
<<<<<<< HEAD
# Copyright (C) 2019-2020 The LineageOS Project
# Copyright (C) 2019-2020 The AncientOS Project
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


ANCIENT_ROOT="$MY_DIR"/../../..



HELPER="$ANCIENT_ROOT"/vendor/ancient/build/tools/extract_utils.sh
if [ ! -f "$HELPER" ]; then
    echo "Unable to find helper script at $HELPER"

ANDROID_ROOT="${MY_DIR}/../../.."

HELPER="${ANDROID_ROOT}/tools/extract-utils/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
    echo "Unable to find helper script at ${HELPER}"
>>>>>>> ca355e734115cfe86b0b0a3ae4abdda13e091fcf
    exit 1
fi
source "${HELPER}"

# Use prebuilts from tools-ancient
TOOLS_ANCINET="$ANCIENT_ROOT"/prebuilts/tools-ancient/"$PLATFORM"/bin
PATCHELF="$TOOLS_ANCIENT"/patchelf

# Default to sanitizing the vendor folder before extraction
CLEAN_VENDOR=true

ONLY_COMMON=
ONLY_TARGET=
KANG=
SECTION=

while [ "${#}" -gt 0 ]; do
    case "${1}" in
        --only-common )
                ONLY_COMMON=true
                ;;
        --only-target )
                ONLY_TARGET=true
                ;;
        -n | --no-cleanup )
                CLEAN_VENDOR=false
                ;;
        -k | --kang )
                KANG="--kang"
                ;;
        -s | --section )
                SECTION="${2}"; shift
                CLEAN_VENDOR=false
                ;;
        * )
                SRC="${1}"
                ;;
    esac
    shift
done

if [ -z "${SRC}" ]; then
    SRC="adb"
fi

function blob_fixup() {
    case "${1}" in
        product/lib64/libdpmframework.so)
            "${PATCHELF}" --add-needed "libshim_dpmframework.so" "${2}"
            ;;
        vendor/etc/nfcee_access.xml)
            sed -i 's|xliff="urn:oasis:names:tc:xliff:document:1.2"|android="http://schemas.android.com/apk/res/android"|' "${2}"
            ;;
        vendor/lib/hw/camera.sdm660.so)
            "${PATCHELF}" --remove-needed "libMegviiFacepp.so" "${2}"
            "${PATCHELF}" --remove-needed "libmegface-new.so" "${2}"
            "${PATCHELF}" --add-needed "libshim_megvii.so" "${2}"
            ;;
    esac
}

<<<<<<< HEAD
# Initialize the helper for common device
setup_vendor "$DEVICE_COMMON" "$VENDOR" "$ANCIENT_ROOT" true $CLEAN_VENDOR
=======
if [ -z "${ONLY_TARGET}" ]; then
    # Initialize the helper for common device
    setup_vendor "${DEVICE_COMMON}" "${VENDOR}" "${ANDROID_ROOT}" true "${CLEAN_VENDOR}"
>>>>>>> ca355e734115cfe86b0b0a3ae4abdda13e091fcf

    extract "${MY_DIR}/proprietary-files.txt" "${SRC}" "${KANG}" --section "${SECTION}"
fi

<<<<<<< HEAD
# Initialize the helper for device
setup_vendor "$DEVICE" "$VENDOR" "$ANCIENT_ROOT" false $CLEAN_VENDOR
=======
if [ -z "${ONLY_COMMON}" ] && [ -s "${MY_DIR}/../${DEVICE}/proprietary-files.txt" ]; then
    # Reinitialize the helper for device
    source "${MY_DIR}/../${DEVICE}/extract-files.sh"
    setup_vendor "${DEVICE}" "${VENDOR}" "${ANDROID_ROOT}" false "${CLEAN_VENDOR}"
>>>>>>> ca355e734115cfe86b0b0a3ae4abdda13e091fcf

    extract "${MY_DIR}/../${DEVICE}/proprietary-files.txt" "${SRC}" "${KANG}" --section "${SECTION}"
fi

"${MY_DIR}/setup-makefiles.sh"
