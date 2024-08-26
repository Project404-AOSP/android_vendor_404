# Setup SOONG_CONFIG_* vars to export the vars listed above.
# Documentation here:
# https://github.com/LineageOS/android_build_soong/commit/8328367c44085b948c003116c0ed74a047237a69

PATH_OVERRIDE_SOONG := $(shell echo $(TOOLS_PATH_OVERRIDE))

# Add variables that we wish to make available to soong here.
EXPORT_TO_SOONG := \
    KERNEL_ARCH \
    KERNEL_BUILD_OUT_PREFIX \
    KERNEL_CROSS_COMPILE \
    KERNEL_MAKE_CMD \
    KERNEL_MAKE_FLAGS \
    PATH_OVERRIDE_SOONG \
    TARGET_KERNEL_CONFIG \
    TARGET_KERNEL_SOURCE

# Setup SOONG_CONFIG_* vars to export the vars listed above.
SOONG_CONFIG_NAMESPACES += p404VarsPlugin
SOONG_CONFIG_p404VarsPlugin :=

define addVar
  SOONG_CONFIG_p404VarsPlugin += $(1)
  SOONG_CONFIG_p404VarsPlugin_$(1) := $$(subst ",\",$$($1))
endef

$(foreach v,$(EXPORT_TO_SOONG),$(eval $(call addVar,$(v))))

SOONG_CONFIG_NAMESPACES += p404GlobalVars
SOONG_CONFIG_p404GlobalVars += \
    aapt_version_code \
    target_init_vendor_lib \
    target_surfaceflinger_udfps_lib

SOONG_CONFIG_NAMESPACES += p404QcomVars
SOONG_CONFIG_p404QcomVars += \
    gralloc_handle_has_custom_content_md_reserved_size \
    gralloc_handle_has_reserved_size \
    qti_vibrator_effect_lib \
    qti_vibrator_use_effect_stream \
    sdmcore_has_is_display_hw_available_func \
    supports_extended_compress_format \
    uses_pre_uplink_features_netmgrd

# Only create display_headers_namespace var if dealing with UM platforms to avoid breaking build for all other platforms
ifneq ($(filter $(UM_PLATFORMS),$(TARGET_BOARD_PLATFORM)),)
SOONG_CONFIG_p404QcomVars += \
    qcom_display_headers_namespace
endif

# Soong bool variables
SOONG_CONFIG_p404QcomVars_gralloc_handle_has_custom_content_md_reserved_size := $(TARGET_GRALLOC_HANDLE_HAS_CUSTOM_CONTENT_MD_RESERVED_SIZE)
SOONG_CONFIG_p404QcomVars_gralloc_handle_has_reserved_size := $(TARGET_GRALLOC_HANDLE_HAS_RESERVED_SIZE)
SOONG_CONFIG_p404QcomVars_gralloc_handle_has_ubwcp_format := $(TARGET_GRALLOC_HANDLE_HAS_UBWCP_FORMAT)
SOONG_CONFIG_p404QcomVars_qti_vibrator_use_effect_stream := $(TARGET_QTI_VIBRATOR_USE_EFFECT_STREAM)
SOONG_CONFIG_p404QcomVars_sdmcore_has_is_display_hw_available_func := $(TARGET_SDMCORE_HAS_IS_DISPLAY_HW_AVAILABLE_FUNC)
SOONG_CONFIG_p404QcomVars_supports_extended_compress_format := $(AUDIO_FEATURE_ENABLED_EXTENDED_COMPRESS_FORMAT)
SOONG_CONFIG_p404QcomVars_uses_pre_uplink_features_netmgrd := $(TARGET_USES_PRE_UPLINK_FEATURES_NETMGRD)

# Set default values
TARGET_INIT_VENDOR_LIB ?= vendor_init
TARGET_SURFACEFLINGER_UDFPS_LIB ?= surfaceflinger_udfps_lib
BOOTLOADER_MESSAGE_OFFSET ?= 0
TARGET_GRALLOC_HANDLE_HAS_CUSTOM_CONTENT_MD_RESERVED_SIZE ?= false
TARGET_GRALLOC_HANDLE_HAS_RESERVED_SIZE ?= false
TARGET_GRALLOC_HANDLE_HAS_UBWCP_FORMAT ?= false
TARGET_POWER_LIBPERFMGR_MODE_EXTENSION_LIB ?= libperfmgr-ext
TARGET_QTI_VIBRATOR_EFFECT_LIB ?= libqtivibratoreffect
TARGET_SDMCORE_HAS_IS_DISPLAY_HW_AVAILABLE_FUNC ?= true

# Soong value variables
SOONG_CONFIG_p404GlobalVars_aapt_version_code := $(shell date -u +%Y%m%d)
SOONG_CONFIG_p404GlobalVars_target_init_vendor_lib := $(TARGET_INIT_VENDOR_LIB)
SOONG_CONFIG_p404GlobalVars_target_surfaceflinger_udfps_lib := $(TARGET_SURFACEFLINGER_UDFPS_LIB)
SOONG_CONFIG_p404GlobalVars_bootloader_message_offset := $(BOOTLOADER_MESSAGE_OFFSET)
SOONG_CONFIG_p404GlobalVars_target_power_libperfmgr_mode_extension_lib := $(TARGET_POWER_LIBPERFMGR_MODE_EXTENSION_LIB)
ifneq ($(filter $(QSSI_SUPPORTED_PLATFORMS),$(TARGET_BOARD_PLATFORM)),)
SOONG_CONFIG_p404QcomVars_qcom_display_headers_namespace := vendor/qcom/opensource/commonsys-intf/display
else
SOONG_CONFIG_p404QcomVars_qcom_display_headers_namespace := $(QCOM_SOONG_NAMESPACE)/display
endif
SOONG_CONFIG_p404QcomVars_qti_vibrator_effect_lib := $(TARGET_QTI_VIBRATOR_EFFECT_LIB)
