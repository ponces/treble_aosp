$(call inherit-product, device/phh/treble/fonts/fonts.mk)

BUILD_BROKEN_DUP_RULES := true
BOARD_EXT4_SHARE_DUP_BLOCKS := true

PRODUCT_PACKAGES += \
    FaceUnlockService

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.face_unlock_service.enabled=true

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.biometrics.face.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.biometrics.face.xml
