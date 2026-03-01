#                                 KyberImage
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#




# image_run_config_scons
# $(1) config options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_config_scons
	$(Q)$(if $(1),cd $(2)/bsp/$(IMAGE_BUILD_BSP) && $(SCONS) $(1))
endef


# image_run_build_scons
# $(1) build options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_build_scons
	$(Q)cd $(3)/bsp/$(IMAGE_BUILD_BSP) && $(SCONS) $(1)
endef


# image_run_clean_scons
# $(1) clean options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_clean_scons
	$(Q)cd $(3)/bsp/$(IMAGE_BUILD_BSP) && $(SCONS) $(1) -c
endef


# image_run_distclean_scons
# $(1) distclean options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_distclean_scons
	$(Q)cd $(3)/bsp/$(IMAGE_BUILD_BSP) && $(SCONS) $(1) -c
endef

