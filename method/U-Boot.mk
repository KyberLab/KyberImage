#                                 KyberImage
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#




IMAGE_UBOOT_BUILD_DIR		:= build
IMAGE_UBOOT_INSTALL_DIR		:= output

IMAGE_UBOOT_ENV				:= $(IMAGE_EXPORT_ENV)
IMAGE_UBOOT_ENV				+= $(if $(IV),V=1,V=$(V))



# image_run_config_u-boot
# $(1) config options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_config_u-boot
	$(Q)mkdir -pv $(3)/{$(IMAGE_UBOOT_BUILD_DIR),$(IMAGE_UBOOT_INSTALL_DIR)}
	$(Q)cd $(3) && $(IMAGE_UBOOT_ENV) make O=$(3)/$(IMAGE_UBOOT_BUILD_DIR) $(1)
endef


# image_run_build_u-boot
# $(1) build options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_build_u-boot
	$(Q)cd $(3) && $(IMAGE_UBOOT_ENV) make O=$(3)/$(IMAGE_UBOOT_BUILD_DIR) $(1) && \
		dd if=/dev/zero of=$(3)/$(IMAGE_UBOOT_BUILD_DIR)/U-Boot.img bs=1M count=64 && \
		dd if=$(3)/$(IMAGE_UBOOT_BUILD_DIR)/u-boot.bin of=$(3)/$(IMAGE_UBOOT_BUILD_DIR)/U-Boot.img bs=1K conv=notrunc
endef


# image_run_clean_u-boot
# $(1) clean options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_clean_u-boot
	$(Q)cd $(3) && $(IMAGE_UBOOT_ENV) make O=$(3)/$(IMAGE_UBOOT_BUILD_DIR) $(1) clean
endef


# image_run_distclean_u-boot
# $(1) distclean options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_distclean_u-boot
	$(Q)cd $(3) && $(IMAGE_UBOOT_ENV) make O=$(3)/$(IMAGE_UBOOT_BUILD_DIR) $(1) distclean
endef

