#                                 KyberImage
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#




###############################################################################
# BuildRoot environment



###############################################################################
# BuildRoot export environment variables

IMAGE_BUILDROOT_ENV			:= $(IMAGE_EXPORT_ENV)
IMAGE_BUILDROOT_ENV			+= $(if $(IV),V=1,V=$(V))

# Disable linux kernel auto version
IMAGE_BUILDROOT_ENV			+= LOCALVERSION=
# CONFIG_LOCALVERSION="\"\""
# CONFIG_LOCALVERSION_AUTO is not set

IMAGE_BUILDROOT_ENV			+= LANG=en_US.UTF-8
IMAGE_BUILDROOT_ENV			+= LD_LIBRARY_PATH=


ifneq ($(IMAGE_BUILDROOT_EXTERNAL),)

ifneq ($(call file_is_exist,$(IMAGE_BUILDROOT_EXTERNAL)),)
$(error IMAGE_BUILDROOT_EXTERNAL "$(IMAGE_BUILDROOT_EXTERNAL)" is not exist !)
endif

IMAGE_BUILDROOT_ENV			+= BR2_EXTERNAL=$(IMAGE_BUILDROOT_EXTERNAL)

else
#$(warning IMAGE_BUILDROOT_EXTERNAL is not set)
endif


ifneq ($(IMAGE_BUILDROOT_DOWNLOAD),)

ifneq ($(call file_is_exist,$(IMAGE_BUILDROOT_DOWNLOAD)),)
$(error IMAGE_BUILDROOT_DOWNLOAD "$(IMAGE_BUILDROOT_DOWNLOAD)" is not exist !)
endif

IMAGE_BUILDROOT_ENV			+= BR2_DL_DIR=$(IMAGE_BUILDROOT_DOWNLOAD)

else
#ifeq ($(filter %action,$(MAKECMDGOALS)),)
#$(error IMAGE_BUILDROOT_DOWNLOAD is not set ! MAKECMDGOALS="$(MAKECMDGOALS)")
#endif
endif



###############################################################################
# BuildRoot build phases


# image_run_config_buildroot
# $(1) config options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_config_buildroot
	$(Q)cd $(3) && make $(IMAGE_BUILDROOT_ENV) $(1)
endef
#	$(Q)$(if $(IMAGE_BUILDROOT_DOWNLOAD),sed -i 's!^BR2_DL_DIR=.*!BR2_DL_DIR="$(IMAGE_BUILDROOT_DOWNLOAD)"!g' $(2)/.config)


# image_run_build_buildroot
# $(1) build options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_build_buildroot
	$(Q)cd $(3) && make $(IMAGE_BUILDROOT_ENV) $(1)
endef


# image_run_clean_buildroot
# $(1) clean options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_clean_buildroot
	$(Q)cd $(3) && make $(IMAGE_BUILDROOT_ENV) clean $(1)
endef


# image_run_distclean_buildroot
# $(1) distclean options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_distclean_buildroot
	$(Q)cd $(3) && make $(IMAGE_BUILDROOT_ENV) distclean $(1)
endef

