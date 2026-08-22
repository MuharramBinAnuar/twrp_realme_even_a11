#!/bin/bash
# Apply gerrit 8742 + 8745 fixes for TWRP 14.1 build
# Run from AOSP root directory
set -e

echo "=== Applying TWRP 14.1 build fixes ==="

# --- Fix 1: Stale ndk_platform suffix (gerrit 8742) ---
echo "Fixing stale ndk_platform AIDL suffix..."
for f in bootable/recovery/Android.mk bootable/recovery/libtar/Android.mk; do
    [ -f "$f" ] && sed -i \
        -e 's/android\.security\.apc-ndk_platform/android.security.apc-ndk/g' \
        -e 's/android\.system\.keystore2-V1-ndk_platform/android.system.keystore2-V1-ndk/g' \
        -e 's/android\.security\.authorization-ndk_platform/android.security.authorization-ndk/g' \
        -e 's/android\.security\.maintenance-ndk_platform/android.security.maintenance-ndk/g' \
        "$f"
done

# --- Fix 2: Create fscrypt_policy_compat.h ---
echo "Creating fscrypt_policy_compat.h..."
cat > bootable/recovery/libtar/fscrypt_policy_compat.h << 'COMPAT_EOF'
#ifndef _LIBTAR_FSCRYPT_POLICY_COMPAT_H_
#define _LIBTAR_FSCRYPT_POLICY_COMPAT_H_

#include <linux/fscrypt.h>
#include <stdint.h>
#include <string.h>
#include <stddef.h>
#include <stdbool.h>

#ifdef __cplusplus
extern "C" {
#endif

#ifdef USE_FSCRYPT_POLICY_V1
typedef struct fscrypt_policy_v1 libtar_fscrypt_policy_t;
#define LIBTAR_FSCRYPT_KEY_FIELD master_key_descriptor
#else
typedef struct fscrypt_policy_v2 libtar_fscrypt_policy_t;
#define LIBTAR_FSCRYPT_KEY_FIELD master_key_identifier
#endif

static inline uint8_t* get_policy(libtar_fscrypt_policy_t *fep) {
	return (uint8_t*)fep;
}

static inline uint8_t* get_policy_descriptor(libtar_fscrypt_policy_t *fep) {
	return (uint8_t*)fep->LIBTAR_FSCRYPT_KEY_FIELD;
}

static inline size_t get_policy_size(libtar_fscrypt_policy_t *fep, bool hex) {
	size_t raw_size = sizeof(*fep);
	if (hex)
		return (raw_size * 2) + 1;
	return raw_size;
}

static inline size_t fscrypt_policy_size(libtar_fscrypt_policy_t *fep) {
	return get_policy_size(fep, false);
}

static inline void get_policy_content(libtar_fscrypt_policy_t *fep, char *content) {
	static const char hex_lookup[] = "0123456789abcdef";
	uint8_t *descriptor = get_policy_descriptor(fep);
	size_t descriptor_len = sizeof(fep->LIBTAR_FSCRYPT_KEY_FIELD);
	size_t i;
	for (i = 0; i < descriptor_len; i++) {
		content[i * 2]     = hex_lookup[(descriptor[i] >> 4) & 0xF];
		content[i * 2 + 1] = hex_lookup[descriptor[i] & 0xF];
	}
	content[descriptor_len * 2] = '\0';
}

#ifdef __cplusplus
}
#endif

#endif
COMPAT_EOF

# --- Fix 3: Add compat include to libtar.h ---
echo "Fixing libtar.h..."
if ! grep -q 'fscrypt_policy_compat.h' bootable/recovery/libtar/libtar.h; then
    # Add include after fscrypt_policy.h or after USE_FSCRYPT ifdef
    if grep -q '#include "fscrypt_policy.h"' bootable/recovery/libtar/libtar.h; then
        sed -i '/#include "fscrypt_policy.h"/a #include "fscrypt_policy_compat.h"' bootable/recovery/libtar/libtar.h
    else
        sed -i '/#ifdef USE_FSCRYPT/a #include "fscrypt_policy_compat.h"' bootable/recovery/libtar/libtar.h
    fi
fi

# --- Fix 4: Replace bare fscrypt_policy type usage in libtar sources ---
# Only replace standalone "fscrypt_policy" that is NOT part of "fscrypt_policy_v1", "fscrypt_policy_v2",
# "fscrypt_policy_compat", "fscrypt_policy_get_struct", "fscrypt_policy_size", "libtar_fscrypt_policy_t"
for f in bootable/recovery/libtar/libtar.h bootable/recovery/libtar/append.c bootable/recovery/libtar/block.c bootable/recovery/libtar/extract.c; do
    [ -f "$f" ] || continue
    # Replace variable declarations and casts - be precise
    sed -i \
        -e 's/\bfscrypt_policy \*fep\b/libtar_fscrypt_policy_t *fep/g' \
        -e 's/\bfscrypt_policy \*\*fep\b/libtar_fscrypt_policy_t **fep/g' \
        -e 's/(fscrypt_policy \*)/(libtar_fscrypt_policy_t *)/g' \
        -e 's/(fscrypt_policy\*)/(libtar_fscrypt_policy_t *)/g' \
        -e 's/\bfscrypt_policy fscrypt_pol\b/libtar_fscrypt_policy_t fscrypt_pol/g' \
        "$f"
done

# --- Fix 5: Fix lookup_ref_tar call in extract.c ---
if grep -q 'lookup_ref_tar(t->th_buf.fep' bootable/recovery/libtar/extract.c 2>/dev/null; then
    sed -i 's/lookup_ref_tar(t->th_buf.fep,/lookup_ref_tar(descriptor,/g' bootable/recovery/libtar/extract.c
fi

echo "=== All fixes applied ==="
