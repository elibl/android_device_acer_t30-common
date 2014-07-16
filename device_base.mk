$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# The gps config appropriate for this device
$(call inherit-product, device/common/gps/gps_us_supl.mk)

PRODUCT_AAPT_CONFIG := normal large xlarge mdpi hdpi

DEVICE_PACKAGE_OVERLAYS += device/acer/t30-common/overlay

PRODUCT_PROPERTY_OVERRIDES := \
    ro.opengles.version=131072 \
    persist.tegra.nvmmlite=1 \
    nvidia.hwc.mirror_mode=crop \
    tf.enable=y \
    wifi.interface=wlan0 \
    ro.carrier=wifi-only \
    ro.zygote.disable_gl_preload=true \

# Set default USB interface
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
	persist.sys.usb.config=mtp

# Don't store dalvik on /cache, it gets annoying when /cache is wiped
# by the bootloader everytime we boot into recovery
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.dexopt-data-only=1 \
    dalvik.vm.heapstartsize=8m \
    dalvik.vm.heapgrowthlimit=96m \
    dalvik.vm.heapsize=384m \
    dalvik.vm.heaptargetutilization=0.75 \
    dalvik.vm.heapminfree=2m \
    dalvik.vm.heapmaxfree=8m

# we have enough storage space to hold precise GC data
PRODUCT_TAGS += dalvik.gc.type-precise

# We copy fstab twice, fstab.acer for init, fstab.$(PRODUCT_BOOTLOADER) for vold
PRODUCT_COPY_FILES += \
    device/acer/t30-common/prebuilt/ramdisk/init.target.rc:root/init.$(PRODUCT_BOOTLOADER).rc \
    device/acer/t30-common/prebuilt/ramdisk/fstab.acer:root/fstab.acer \
    device/acer/t30-common/prebuilt/ramdisk/fstab.acer:root/fstab.$(PRODUCT_BOOTLOADER) \
    device/acer/t30-common/prebuilt/ramdisk/ueventd.target.rc:root/ueventd.$(PRODUCT_BOOTLOADER).rc \
    device/acer/t30-common/prebuilt/ramdisk/twrp.fstab:recovery/root/etc/twrp.fstab

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/tablet_core_hardware.xml:system/etc/permissions/tablet_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.camera.autofocus.xml:system/etc/permissions/android.hardware.camera.autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml

PRODUCT_COPY_FILES += \
    device/acer/t30-common/prebuilt/etc/gps/gpsconfig.xml:system/etc/gps/gpsconfig.xml \
    device/acer/t30-common/prebuilt/etc/ppp/ip-up:system/etc/ppp/ip-up \
    device/acer/t30-common/prebuilt/etc/ppp/ip-down:system/etc/ppp/ip-down \
    device/acer/t30-common/prebuilt/usr/idc/acer-touch.idc:system/usr/idc/acer-touch.idc \
    device/acer/t30-common/prebuilt/usr/keylayout/Acer-AK00LB.kl:system/usr/keylayout/Acer-AK00LB.kl \
    device/acer/t30-common/prebuilt/usr/keylayout/Acer-ICONIA-TAB-KB01.kl:system/usr/keylayout/Acer-ICONIA-TAB-KB01.kl \
    device/acer/t30-common/prebuilt/usr/keylayout/acer-dock.kl:system/usr/keylayout/acer-dock.kl \
    device/acer/t30-common/prebuilt/usr/keylayout/gpio-keys.kl:system/usr/keylayout/gpio-keys.kl

PRODUCT_PACKAGES := \
    audio.primary.tegra \
    libaudioutils \
    audio.a2dp.default \
    audio.usb.default \
    a1026_init \
    librs_jni \
    make_ext4fs \
    setup_fs \
    l2ping \
    hcitool \
    bttest \
    com.android.future.usb.accessory

PRODUCT_CHARACTERISTICS := tablet

# Audio config
PRODUCT_COPY_FILES += \
    device/acer/t30-common/tiny_hw.xml:system/etc/sound/$(PRODUCT_BOOTLOADER) \
    device/acer/t30-common/prebuilt/etc/audio_policy.conf:system/etc/audio_policy.conf

# media config xml file
PRODUCT_COPY_FILES += \
    device/acer/t30-common/prebuilt/etc/media_profiles.xml:system/etc/media_profiles.xml \
    device/acer/t30-common/prebuilt/etc/media_codecs.xml:system/etc/media_codecs.xml

WIFI_BAND := 802_11_BG
$(call inherit-product-if-exists, hardware/broadcom/wlan/bcmdhd/firmware/bcm4330/device-bcm.mk)
