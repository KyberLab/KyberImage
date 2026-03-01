#                                 KyberImage
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#




IMAGE_BUSYBOX_BUILD_DIR		:= build
IMAGE_BUSYBOX_ROOTFS_DIR	:= rootfs
IMAGE_BUSYBOX_INSTALL_DIR	:= output

IMAGE_BUSYBOX_ENV			:= $(IMAGE_EXPORT_ENV)
IMAGE_BUSYBOX_ENV			+= $(if $(IV),V=1,V=$(V))



# image_run_config_busybox
# $(1) config options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_config_busybox
	$(Q)mkdir -pv $(3)/{$(IMAGE_BUSYBOX_BUILD_DIR),$(IMAGE_BUSYBOX_INSTALL_DIR)}
	$(Q)cd $(3) && $(IMAGE_BUSYBOX_ENV) make O=$(3)/$(IMAGE_BUSYBOX_BUILD_DIR) $(1)
endef


# image_run_build_busybox
# $(1) build options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_build_busybox
	$(Q)cd $(3) && \
		$(IMAGE_BUSYBOX_ENV) make O=$(3)/$(IMAGE_BUSYBOX_BUILD_DIR) $(1) && \
		rm -rf $(IMAGE_BUSYBOX_ROOTFS_DIR) && \
		$(IMAGE_BUSYBOX_ENV) make O=$(3)/$(IMAGE_BUSYBOX_BUILD_DIR) CONFIG_PREFIX=$(3)/$(IMAGE_BUSYBOX_ROOTFS_DIR) install && \
		mkdir -pv $(3)/${IMAGE_BUSYBOX_ROOTFS_DIR}/{proc,sys,dev,etc{,/init.d}} && \
		cp -vf $(3)/rcS $(3)/${IMAGE_BUSYBOX_ROOTFS_DIR}/etc/init.d/rcS && \
		chmod +x $(3)/$(IMAGE_BUSYBOX_ROOTFS_DIR)/etc/init.d/rcS && \
		sudo chown root:root $(3)/$(IMAGE_BUSYBOX_ROOTFS_DIR)/bin/busybox && \
		sudo chmod u+s $(3)/$(IMAGE_BUSYBOX_ROOTFS_DIR)/bin/busybox
	$(Q)cd $(3)/$(IMAGE_BUSYBOX_ROOTFS_DIR) && \
			find . | cpio --quiet -H newc -o > $(3)/$(IMAGE_BUSYBOX_INSTALL_DIR)/initrd.cpio && \
			gzip -nc9 $(3)/$(IMAGE_BUSYBOX_INSTALL_DIR)/initrd.cpio > $(3)/$(IMAGE_BUSYBOX_INSTALL_DIR)/initrd.cpio.gz
endef


# image_run_clean_busybox
# $(1) clean options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_clean_busybox
	$(Q)cd $(3) && $(IMAGE_BUSYBOX_ENV) make O=$(3)/$(IMAGE_BUSYBOX_BUILD_DIR) $(1) clean
endef


# image_run_distclean_busybox
# $(1) distclean options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_distclean_busybox
	$(Q)cd $(3) && $(IMAGE_BUSYBOX_ENV) make O=$(3)/$(IMAGE_BUSYBOX_BUILD_DIR) $(1) distclean
endef

