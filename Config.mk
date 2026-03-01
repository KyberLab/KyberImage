#                                 KyberImage
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#




###############################################################################
# 1. [Workspace Config] Workspace Config

$(eval $(call rule_inc,$(WORKSPACE_ROOT_PATH)/WorkSpace.mk))



###############################################################################
# Build Configs


BUILD_PLATFORM_DEFAULT		?= qemu
BUILD_BOARD_DEFAULT			?= virt-aarch64

BUILD_PLATFORM				?= $(if $(BENCH_RUN_PLAT),$(BENCH_RUN_PLAT),$(BUILD_PLATFORM_DEFAULT))
BUILD_BOARD					?= $(if $(BENCH_RUN_BOARD),$(BENCH_RUN_BOARD),$(BUILD_BOARD_DEFAULT))

BUILD_TYPE_NUM				?= 3
BUILD_TYPE_STR				?= test
BUILD_VARIANT				?= Community
BUILD_COPYRIGHT				?= Copyright (c) 2025-$(shell date +"%Y"), Kyber Development Team, all right reserved.

BUILD_LICENSE_LANG			?= en_US.UTF-8

BUILD_FLAVOR				?= default



###############################################################################
# Path Configs

ifeq ($(origin WORKSPACE_ROOT_PATH),undefined)
$(error "WORKSPACE_ROOT_PATH has not been defined.")
endif

PREBUILTS_ROOT_PATH			?= $(WORKSPACE_ROOT_PATH)/prebuilt
DOWNLOAD_ROOT_PATH			?= $(WORKSPACE_ROOT_PATH)/download
CONFIG_ROOT_PATH			?= $(WORKSPACE_ROOT_PATH)/config
BUILD_ROOT_PATH				?= $(WORKSPACE_ROOT_PATH)/build
OUTPUT_ROOT_PATH			?= $(WORKSPACE_ROOT_PATH)/output

IMAGE_TYPE_PATH				?= $(IMAGE_ROOT_PATH)/type
IMAGE_METHOD_PATH			?= $(IMAGE_ROOT_PATH)/method
IMAGE_SCRIPTS_PATH			?= $(IMAGE_ROOT_PATH)/scripts

CONFIG_IMAGE_PATH			?= $(CONFIG_ROOT_PATH)/image



###############################################################################
# Image build config

# Image build phases
IMAGE_BUILD_PHASES			:= fetch patch config build install package clean distclean remove info status action summary

# Image build verbose
IMAGE_VERBOSE				?= 
IMAGE_DONE_VERBOSE			?= 
IMAGE_TITLE_COLOR			?= $(HB_RED)
IMAGE_COLOR					?= $(HB_CYAN)

METHOD_VERBOSE				?= 
METHOD_TITLE_COLOR			?= $(BG_RED)
METHOD_COLOR				?= $(HB_GREEN)

METHOD_NOTICE_COLOR			?= $(HB_YELLOW)



###############################################################################
# Build Version Init


BUILD_VERSION_FULL			?= $(call git_version_full,$(WORKSPACE_ROOT_PATH))
BUILD_VERSION_MAIN			?= $(call git_version_main,$(BUILD_VERSION_FULL))

BUILD_VERSION				?= $(call git_version,$(BUILD_VERSION_MAIN))
BUILD_SUBVERSION			?= $(call git_subversion,$(BUILD_VERSION_MAIN))
BUILD_REVISION				?= $(call git_revision,$(BUILD_VERSION_MAIN))

BUILD_SCMVERSION			?= $(call git_scmversion,$(BUILD_VERSION_FULL))


