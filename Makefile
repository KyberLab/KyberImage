#                                 KyberImage
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#




###############################################################################
# Default Macros


# file_is_exist
# $(1) file path
# return empty if exist.
ifeq ($(origin file_is_exist),undefined)
define file_is_exist
$(shell ls $(1) > /dev/null 2>&1;echo $$? | grep -v 0)
endef
endif


# rule_inc
# $(1) rule file path
ifeq ($(origin rule_inc),undefined)
define rule_inc
$(if $(call file_is_exist,$(1)),$(error Rule File "$(1)" Not Exist !!!),include $(1))
endef
endif


# is_in_docker
# return : empty if in docker
ifeq ($(origin is_in_docker),undefined)
define is_in_docker
$(shell echo `[ ! -f /.dockerenv ]` $$? | grep -v 1)
endef
endif


# cur_dir
# return : current directory path
ifeq ($(origin cur_dir),undefined)
define cur_dir
$(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
endef
endif



###############################################################################
# Path Check


ifeq ($(origin IMAGE_ROOT_PATH),undefined)
#$(warning "IMAGE_ROOT_PATH has not been defined.")
IMAGE_ROOT_PATH			:= $(call cur_dir)
#$(warning Define IMAGE_ROOT_PATH = $(IMAGE_ROOT_PATH))
endif



###############################################################################

.PHONY : all help image

all : help

help : 
	$(Q)$(call xprint_title,	"Version Information",		$(IMAGE_TITLE_COLOR))
	$(Q)$(call xprint_filled,$(IMAGE_COLOR))
	$(Q)$(call xprint_value,	"Build Version",			$(BUILD_VERSION),$(IMAGE_COLOR))
	$(Q)$(call xprint_value,	"Build SubVersion",			$(BUILD_SUBVERSION),$(IMAGE_COLOR))
	$(Q)$(call xprint_value,	"Build ReVersion",			$(BUILD_REVISION),$(IMAGE_COLOR))
	$(Q)$(call xprint_value,	"Build Version",			$(BUILD_SCMVERSION),$(IMAGE_COLOR))
	$(Q)$(call xprint_filled,$(IMAGE_COLOR))
	$(Q)$(call xprint_title,	"Build Information",		$(IMAGE_TITLE_COLOR))
	$(Q)$(call xprint_filled,$(IMAGE_COLOR))
	$(Q)$(call xprint_value,	"Build Platform",			$(call string_to_camel,$(BUILD_PLATFORM)),$(IMAGE_COLOR))
	$(Q)$(call xprint_value,	"Build Board",				$(call string_to_camel,$(BUILD_BOARD)),$(IMAGE_COLOR))
	$(Q)$(call xprint_value,	"Build Flavor",				$(call string_to_camel,$(BUILD_FLAVOR)),$(IMAGE_COLOR))
	$(Q)$(call xprint_value,	"Build Type Number",		$(BUILD_TYPE_NUM),$(IMAGE_COLOR))
	$(Q)$(call xprint_value,	"Build Type String",		$(call string_to_camel,$(BUILD_TYPE_STR)),$(IMAGE_COLOR))
	$(Q)$(call xprint_filled,$(IMAGE_COLOR))


image : image_install


###############################################################################
# Basic rules and config

BENCH_ROOT_PATH				?= $(WORKSPACE_ROOT_PATH)/bench

# Bench Rules
$(eval $(call rule_inc,$(BENCH_ROOT_PATH)/Main.mk))

# 1. [Workspace Config] (in Config.mk)
# 2. [Build Config] Top Level Build Config
$(eval $(call rule_inc,$(IMAGE_ROOT_PATH)/Config.mk))



###############################################################################
# Image config list

ifeq ($(origin CONFIG_IMAGE_PATH),undefined)
$(error CONFIG_IMAGE_PATH is undefined)
endif
IMAGE_BUILD_TEMP_LIST		:= $(shell ls $(CONFIG_IMAGE_PATH)/*/*.mk 2>/dev/null | awk -F "/" '{print $$(NF-1)}' | sort -u)

IMAGE_BUILD_FULL_LIST		:= $(IMAGE_BUILD_TEMP_LIST)
IMAGE_BUILD_FULL_LIST		+= $(foreach image,$(IMAGE_BUILD_TEMP_LIST),$(call string_to_lower,$(image)))
IMAGE_BUILD_FULL_LIST		+= $(foreach image,$(IMAGE_BUILD_TEMP_LIST),$(call string_to_upper,$(image)))



###############################################################################
# Build phases and targets

IMAGE_BUILD_TARGETS			:= $(foreach phase,$(IMAGE_BUILD_PHASES),image_$(phase))

.PHONY : $(IMAGE_BUILD_TARGETS) $(IMAGE_BUILD_FULL_LIST)

$(IMAGE_BUILD_TARGETS) : IMAGE_BUILD_PHASE=$(patsubst image_%,%,$@)



###############################################################################
# Image export environment variables

IMAGE_EXPORT_ENV			:= \
	BUILD_PLATFORM=$(BUILD_PLATFORM) \
	BUILD_BOARD=$(BUILD_BOARD) \
	BUILD_VARIANT=$(BUILD_VARIANT) \
	BUILD_COPYRIGHT="$(BUILD_COPYRIGHT)" \
	BUILD_TYPE_NUM=$(BUILD_TYPE_NUM) \
	BUILD_TYPE_STR=$(BUILD_TYPE_STR) \
	BUILD_FLAVOR=$(BUILD_FLAVOR)

IMAGE_EXPORT_ENV				+= \
	BUILD_VERSION=$(BUILD_VERSION) \
	BUILD_SUBVERSION=$(BUILD_SUBVERSION) \
	BUILD_REVISION=$(BUILD_REVISION) \
	BUILD_SCMVERSION=$(BUILD_SCMVERSION)

IMAGE_EXPORT_ENV				+= \
	WORKSPACE_ROOT_PATH=$(WORKSPACE_ROOT_PATH) \
	BENCH_ROOT_PATH=$(BENCH_ROOT_PATH) \
	RULES_ROOT_PATH=$(RULES_ROOT_PATH) \
	BUILD_ROOT_PATH=$(BUILD_ROOT_PATH) \
	OUTPUT_ROOT_PATH=$(OUTPUT_ROOT_PATH) \
	IMAGE_ROOT_PATH=$(IMAGE_ROOT_PATH)

IMAGE_EXPORT_ENV				+= \
	$(if $(IMAGE_FETCH_OPTS),IMAGE_FETCH_OPTS=$(IMAGE_FETCH_OPTS)) \
	$(if $(IMAGE_PATCH_OPTS),IMAGE_PATCH_OPTS=$(IMAGE_PATCH_OPTS)) \
	$(if $(IMAGE_CONFIG_OPTS),IMAGE_CONFIG_OPTS=$(IMAGE_CONFIG_OPTS)) \
	$(if $(IMAGE_BUILD_OPTS),IMAGE_BUILD_OPTS=$(IMAGE_BUILD_OPTS)) \
	$(if $(IMAGE_INSTALL_OPTS),IMAGE_INSTALL_OPTS=$(IMAGE_INSTALL_OPTS)) \
	$(if $(IMAGE_PACKAGE_OPTS),IMAGE_PACKAGE_OPTS=$(IMAGE_PACKAGE_OPTS)) \
	$(if $(IMAGE_CLEAN_OPTS),IMAGE_CLEAN_OPTS=$(IMAGE_CLEAN_OPTS)) \
	$(if $(IMAGE_DISTCLEAN_OPTS),IMAGE_DISTCLEAN_OPTS=$(IMAGE_DISTCLEAN_OPTS)) \
	$(if $(IMAGE_REMOVE_OPTS),IMAGE_REMOVE_OPTS=$(IMAGE_REMOVE_OPTS)) \
	$(if $(IMAGE_INFO_OPTS),IMAGE_INFO_OPTS=$(IMAGE_INFO_OPTS)) \
	$(if $(IMAGE_STATUS_OPTS),IMAGE_STATUS_OPTS=$(IMAGE_STATUS_OPTS)) \
	$(if $(IMAGE_ACTION_OPTS),IMAGE_ACTION_OPTS=$(IMAGE_ACTION_OPTS)) \
	$(if $(IMAGE_SUMMARY_OPTS),IMAGE_SUMMARY_OPTS=$(IMAGE_SUMMARY_OPTS))

IMAGE_EXPORT_ENV				+= \
	BENCH_CMD_ARGS=$(BENCH_CMD_ARGS) \
	V=$(V) \
	IV=$(IV)



###############################################################################

# Image Build Goal
$(eval $(call rule_inc,$(IMAGE_ROOT_PATH)/goal/Goal.mk))

# Image shortcut
$(eval $(call rule_inc,$(IMAGE_ROOT_PATH)/Shortcut.mk))

# Download packages
$(eval $(call rule_inc,$(IMAGE_ROOT_PATH)/Download.mk))

