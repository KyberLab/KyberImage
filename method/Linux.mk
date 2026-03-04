#                                 KyberImage
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#




IMAGE_LINUX_BUILD_DIR		:= build
IMAGE_LINUX_INSTALL_DIR		:= output

IMAGE_LINUX_ENV				:= $(IMAGE_EXPORT_ENV)
IMAGE_LINUX_ENV				+= $(if $(IV),V=1,V=$(V))

# Disable linux kernel auto version
IMAGE_LINUX_ENV				+= LOCALVERSION=
# CONFIG_LOCALVERSION="\"\""
# CONFIG_LOCALVERSION_AUTO is not set


# image_run_config_linux
# $(1) config options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_config_linux
	$(Q)mkdir -pv $(3)/{$(IMAGE_LINUX_BUILD_DIR),$(IMAGE_LINUX_INSTALL_DIR)}
	$(Q)cd $(3) && $(IMAGE_LINUX_ENV) make O=$(3)/$(IMAGE_LINUX_BUILD_DIR) $(1)
endef


# image_run_build_linux
# $(1) build options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_build_linux
	$(Q)cd $(3) && \
			$(IMAGE_LINUX_ENV) make O=$(3)/$(IMAGE_LINUX_BUILD_DIR) && \
			$(IMAGE_LINUX_ENV) make O=$(3)/$(IMAGE_LINUX_BUILD_DIR) modules
endef


# image_run_install_linux
# $(1) install options
# $(2) config path
# $(3) build path
# $(4) install path
# $(5) install list
define image_run_install_linux
	$(Q)cd $(3) && \
			$(IMAGE_LINUX_ENV) make O=$(3)/$(IMAGE_LINUX_BUILD_DIR) \
				INSTALL_MOD_PATH=$(3)/$(IMAGE_LINUX_INSTALL_DIR) $(if $(1),$(1),modules_install)
	$(call image_run_install_install,$(1),$(2),$(3),$(4),$(5))
endef


# image_run_clean_linux
# $(1) clean options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_clean_linux
	$(Q)cd $(3) && $(IMAGE_LINUX_ENV) make O=$(3)/$(IMAGE_LINUX_BUILD_DIR) $(if $(1),$(1),clean)
endef


# image_run_distclean_linux
# $(1) distclean options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_distclean_linux
	$(Q)cd $(3) && $(IMAGE_LINUX_ENV) make O=$(3)/$(IMAGE_LINUX_BUILD_DIR) $(if $(1),$(1),distclean)
endef

