#                                 KyberImage
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#




# image_run_config_make
# $(1) config options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_config_make
	$(Q)cd $(3) && $(MAKE) $(IMAGE_BUILDROOT_ENV) $(if $(1),$(1),config)
endef


# image_run_build_make
# $(1) build options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_build_make
	$(Q)cd $(3) && $(MAKE) $(IMAGE_BUILDROOT_ENV) $(if $(1),$(1),build)
endef


# image_run_install_make
# $(1) install options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_install_make
	$(Q)cd $(3) && $(MAKE) $(IMAGE_BUILDROOT_ENV) $(if $(1),$(1),install)
endef



# image_run_package_make
# $(1) package options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_package_make
	$(Q)cd $(3) && $(MAKE) $(IMAGE_BUILDROOT_ENV) $(if $(1),$(1),package)
endef


# image_run_clean_make
# $(1) clean options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_clean_make
	$(Q)cd $(3) && $(MAKE) $(IMAGE_BUILDROOT_ENV) $(if $(1),$(1),clean)
endef


# image_run_distclean_make
# $(1) distclean options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_distclean_make
	$(Q)cd $(3) && $(MAKE) $(IMAGE_BUILDROOT_ENV) $(if $(1),$(1),distclean)
endef

