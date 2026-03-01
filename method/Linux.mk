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
			$(IMAGE_LINUX_ENV) make O=$(3)/$(IMAGE_LINUX_BUILD_DIR) $(1) && \
			$(IMAGE_LINUX_ENV) make O=$(3)/$(IMAGE_LINUX_BUILD_DIR) $(1) modules && \
			$(IMAGE_LINUX_ENV) make O=$(3)/$(IMAGE_LINUX_BUILD_DIR) $(1) \
				INSTALL_MOD_PATH=$(3)/$(IMAGE_LINUX_INSTALL_DIR) modules_install
endef


# image_run_install_linux
# $(1) install options
# $(2) config path
# $(3) build path
# $(4) install path
# $(5) install list
define image_run_install_linux
	$(Q)$(call xprint_title,	"Image $(IMAGE_BUILD_GOAL) Install",$(BG_YELLOW))
	$(Q)$(call xprint_value,	"Install Options",	$(1),$($(BG_PURPLE)))
	$(Q)$(call xprint_value,	"Config Path",		$(2),$($(BG_PURPLE)))
	$(Q)$(call xprint_value,	"Build Path",		$(3),$($(BG_PURPLE)))
	$(Q)$(call xprint_value,	"Install Path",		$(4),$($(BG_PURPLE)))
	$(Q)$(call xprint_value,	"Install List",		$(5),$($(BG_PURPLE)))
	$(Q)$(call xprint_line,$(BG_YELLOW))
endef


# image_run_clean_linux
# $(1) clean options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_clean_linux
	$(Q)cd $(3) && $(IMAGE_LINUX_ENV) make O=$(3)/$(IMAGE_LINUX_BUILD_DIR) $(1) clean
endef


# image_run_distclean_linux
# $(1) distclean options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_distclean_linux
	$(Q)cd $(3) && $(IMAGE_LINUX_ENV) make O=$(3)/$(IMAGE_LINUX_BUILD_DIR) $(1) distclean
endef

