#                                 KyberImage
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#




CC							:= $(CROSS_COMPILE)gcc
CXX							:= $(CROSS_COMPILE)g++
CPP							:= $(CROSS_COMPILE)cpp
AR							:= $(CROSS_COMPILE)ar
RANLIB						:= $(CROSS_COMPILE)ranlib

AUTOMAKE_BUILD_DIR			:= build
AUTOMAKE_OUTPUT_DIR			:= output

AUTOMAKE_BUILD_ENV			:= $(if $(ARCH),ARCH=$(ARCH))
AUTOMAKE_BUILD_ENV			+= $(if $(CROSS_COMPILE),CROSS_COMPILE=$(CROSS_COMPILE))
AUTOMAKE_BUILD_ENV			+= $(if $(CC),CC=$(CC))
AUTOMAKE_BUILD_ENV			+= $(if $(CXX),CXX=$(CXX))
AUTOMAKE_BUILD_ENV			+= $(if $(CPP),CPP=$(CPP))
AUTOMAKE_BUILD_ENV			+= $(if $(AR),AR=$(AR))
AUTOMAKE_BUILD_ENV			+= $(if $(RANLIB),RANLIB=$(RANLIB))
AUTOMAKE_BUILD_ENV			+= $(if $(CFLAGS),CFLAGS=$(CFLAGS))
AUTOMAKE_BUILD_ENV			+= $(if $(CPPFLAGS),CPPFLAGS=$(CPPFLAGS))
AUTOMAKE_BUILD_ENV			+= $(if $(LDFLAGS),LDFLAGS=$(LDFLAGS))
AUTOMAKE_BUILD_ENV			+= $(if $(TV),V=1,V=$(V))
#AUTOMAKE_BUILD_ENV		+= LD_LIBRARY_PATH=
#AUTOMAKE_BUILD_ENV		+= LD_LIBRARY_PATH=$(AUTOMAKE_ROOTFS_PATH)/usr/lib


AUTOMAKE_CONFIG_OPTS	= $(AUTOMAKE_$(call string_to_upper,$(AUTOMAKE_TYPE))_CONFIG_OPTS)
#AUTOMAKE_CONFIG_OPTS	+= --extra-cflags=-I$(AUTOMAKE_ROOTFS_PATH)/usr/include
#AUTOMAKE_CONFIG_OPTS	+= --extra-cflags=-L$(AUTOMAKE_ROOTFS_PATH)/usr/lib



# image_run_config_automake
# $(1) config options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_config_automake
	$(Q)mkdir -pv $(3)/$(AUTOMAKE_BUILD_DIR)
	$(Q)cd $(3)/$(AUTOMAKE_BUILD_DIR) && $(AUTOMAKE_BUILD_ENV) ../configure --prefix=$(4)/$(IMAGE_BUILD_GOAL) $(1)
endef


# image_run_build_automake
# $(1) build options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_build_automake
	$(Q)cd $(3)/$(AUTOMAKE_BUILD_DIR) && $(AUTOMAKE_BUILD_ENV) $(MAKE) $(1)
endef


# image_run_install_automake
# $(1) install options
# $(2) config path
# $(3) build path
# $(4) install path
# $(5) install list
define image_run_install_automake
	$(Q)cd $(3)/$(AUTOMAKE_BUILD_DIR) && $(AUTOMAKE_BUILD_ENV) $(MAKE) $(if $(1),$(1),install)
endef


# image_run_clean_automake
# $(1) clean options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_clean_automake
	$(Q)cd $(3)/$(AUTOMAKE_BUILD_DIR) && $(AUTOMAKE_BUILD_ENV) $(MAKE) $(if $(1),$(1),clean)
endef


# image_run_distclean_automake
# $(1) distclean options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_distclean_automake
	-$(Q)cd $(3)/$(AUTOMAKE_BUILD_DIR) && $(AUTOMAKE_BUILD_ENV) $(MAKE) $(if $(1),$(1),distclean)
endef

