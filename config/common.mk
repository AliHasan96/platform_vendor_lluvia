PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

# Bootanimation
PRODUCT_COPY_FILES += \
    vendor/lluvia/prebuilt/common/media/bootanimation.zip:system/media/bootanimation.zip

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_GENERIC_PROPERTIES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_GENERIC_PROPERTIES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/lluvia/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/lluvia/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/lluvia/prebuilt/common/bin/50-base.sh:system/addon.d/50-base.sh \

ifeq ($(filter lluvia_marlin lluvia_sailfish,$(TARGET_PRODUCT)),)
PRODUCT_GENERIC_PROPERTIES += \
    keyguard.no_require_sim=true \
    dalvik.vm.debug.alloc=0 \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.error.receiver.system.apps=com.google.android.gms \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dataroaming=false \
    ro.atrace.core.services=com.google.android.gms,com.google.android.gms.ui,com.google.android.gms.persistent \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.build.selinux=1 \
    ro.carrier=unknown
endif

PRODUCT_COPY_FILES += \
    vendor/lluvia/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/lluvia/prebuilt/common/bin/sysinit:system/bin/sysinit

# Charger
PRODUCT_PACKAGES += \
    charger_res_images

# Init file
PRODUCT_COPY_FILES += \
    vendor/lluvia/prebuilt/common/etc/init.local.rc:root/init.lluvia.rc

# LatinIME gesture typing
ifeq ($(TARGET_ARCH),arm64)
PRODUCT_COPY_FILES += \
    vendor/lluvia/prebuilt/common/lib64/libjni_latinime.so:system/lib64/libjni_latinime.so \
    vendor/lluvia/prebuilt/common/lib64/libjni_latinimegoogle.so:system/lib64/libjni_latinimegoogle.so
else
PRODUCT_COPY_FILES += \
    vendor/lluvia/prebuilt/common/lib/libjni_latinime.so:system/lib/libjni_latinime.so \
    vendor/lluvia/prebuilt/common/lib/libjni_latinimegoogle.so:system/lib/libjni_latinimegoogle.so
endif

# Don't export PS1 in /system/etc/mkshrc.
PRODUCT_COPY_FILES += \
    vendor/lluvia/prebuilt/common/etc/mkshrc:system/etc/mkshrc

# Fix Dialer
PRODUCT_COPY_FILES +=  \
    vendor/lluvia/prebuilt/common/sysconfig/dialer_experience.xml:system/etc/sysconfig/dialer_experience.xml 

# Clean up packages cache to avoid wrong strings and resources
PRODUCT_COPY_FILES += \
    vendor/lluvia/prebuilt/common/bin/clean_cache.sh:system/bin/clean_cache.sh

# Media
PRODUCT_GENERIC_PROPERTIES += \
    media.recorder.show_manufacturer_and_model=true

# Don't compile SystemUITests
EXCLUDE_SYSTEMUI_TESTS := true

# Common overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/lluvia/overlay/common

# Packages
include vendor/lluvia/config/packages.mk

# Versionin
include vendor/lluvia/config/version.mk

# Set custom volume steps
PRODUCT_GENERIC_PROPERTIES += \
    ro.config.media_vol_steps=30 \
    ro.config.bt_sco_vol_steps=30

# Include SDCLANG definitions if it is requested and available
ifeq ($(HOST_OS),linux)
    ifneq ($(wildcard vendor/qcom/sdclang-4.0/),)
        include vendor/lluvia/sdclang/sdclang.mk
    endif
endif
