$(call inherit-product, device/phh/treble/fonts/fonts.mk)

PRODUCT_PACKAGES += \
    ThemePicker

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.system.ota.json_url=https://raw.githubusercontent.com/ponces/treble_build_aosp/android-14.0/ota.json
