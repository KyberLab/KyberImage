#                                 KyberImage
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#




CRATE_BUILD_ENV				:= $(IMAGE_EXPORT_ENV)
CRATE_BUILD_ENV				+= $(CRATE_ENV_EXPORT)


# crate_build_cmd
# $(1) build path
define crate_build_cmd
$(MAKE) -f $(1)/crate/CrateMain.mk $(CRATE_BUILD_ENV)
endef


# image_run_config_crate
# $(1) config options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_config_crate
	$(Q)$(if $(CRATE_BUILD_GOAL),$(call crate_build_cmd,$(3)) goods_config CRATE_CONFIG_OPTS=$(1) CRATE_BUILD_PATH=$(3) CRATE_INSTALL_PATH=$(4),$(call xprint_info,"Skip - Crate not need global config !"))
endef


# image_run_build_crate
# $(1) build options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_build_crate
	$(Q)$(if $(CRATE_BUILD_GOAL),$(call crate_build_cmd,$(3)) goods_build CRATE_BUILD_OPTS=$(1) CRATE_BUILD_PATH=$(3) CRATE_INSTALL_PATH=$(4),$(call xprint_info,"Skip - Crate not need global build !"))
endef



# image_run_install_crate
# $(1) install options
# $(2) config path
# $(3) build path
# $(4) install path
# $(5) install list
define image_run_install_crate
	$(Q)$(call crate_build_cmd,$(3)) goods_install CRATE_INSTALL_OPTS=$(1) CRATE_BUILD_PATH=$(3) CRATE_INSTALL_PATH=$(4) CRATE_INSTALL_LIST=$(5)
endef


# image_run_package_crate
# $(1) package options
# $(2) config path
# $(3) build path
# $(4) install path
# $(5) package list
define image_run_package_crate
	$(Q)$(call crate_build_cmd,$(3)) goods_package CRATE_PACKAGE_OPTS=$(1) CRATE_BUILD_PATH=$(3) CRATE_INSTALL_PATH=$(4) CRATE_PACKAGE_LIST=$(5)
endef


# image_run_clean_crate
# $(1) clean options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_clean_crate
	$(Q)$(call crate_build_cmd,$(3)) goods_clean CRATE_CLEAN_OPTS=$(1) CRATE_BUILD_PATH=$(3) CRATE_INSTALL_PATH=$(4)
endef


# image_run_distclean_crate
# $(1) distclean options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_distclean_crate
	$(Q)$(call crate_build_cmd,$(3)) goods_distclean CRATE_DISTCLEAN_OPTS=$(1) CRATE_BUILD_PATH=$(3) CRATE_INSTALL_PATH=$(4)
endef


# image_run_info_crate
# $(1) info options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_info_crate
	$(Q)$(call crate_build_cmd,$(3)) goods_info CRATE_INFO_OPTS=$(1) CRATE_BUILD_PATH=$(3) CRATE_INSTALL_PATH=$(4)
endef

