#                                 KyberImage
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#




###############################################################################
# All the images be enabled will be build

ifeq ($(IMAGE_BUILD_GOAL),)

ifeq ($(IMAGE_BUILD_LIST),)
$(error "IMAGE_BUILD_LIST is empty, please set it to image name")
endif

$(IMAGE_BUILD_TARGETS) : $(IMAGE_BUILD_LIST)

$(IMAGE_BUILD_FULL_LIST) : 
	$(Q)$(if $(call image_config_dir_name,$@),$(MAKE) $(IMAGE_EXPORT_ENV) IMAGE_BUILD_GOAL=$(call image_config_dir_name,$@) $(if $(findstring image,$(MAKECMDGOALS)),$(MAKECMDGOALS),$(call image_config_dir_name,$(MAKECMDGOALS))),$(call xprint,$(RED),"Invalid $@ Skip !"))



###############################################################################
# Only the images be specified will be build

else # ($(IMAGE_BUILD_GOAL),)

# Package name
IMAGE_PACKAGE_NAME			:= $(IMAGE_BUILD_GOAL)
IMAGE_PACKAGE_NAME			+= _$(call string_to_camel,$(BUILD_TYPE_STR))
IMAGE_PACKAGE_NAME			+= _$(call string_to_upper,$(BUILD_SCMVERSION))
IMAGE_PACKAGE_NAME			+= _$(call string_to_upper,$(BUILD_BOARD))

ifneq ($(BUILD_VARIANT),Community)
IMAGE_PACKAGE_NAME			+= -$(call string_to_upper,$(BUILD_VARIANT))
endif

ifneq ($(IMAGE_BUILD_DEBUG_ENABLE),1)
IMAGE_PACKAGE_NAME			+= _$(shell date +"%Y-%m-%d")-$(shell date +"%H%M%S")
else
IMAGE_PACKAGE_NAME			+= _1234-56-78-123456
endif

IMAGE_PACKAGE_NAME			:= $(shell echo $(IMAGE_PACKAGE_NAME) | tr -d ' ')


# Build, and config path
BUILD_IMAGE_PATH			:= $(BUILD_ROOT_PATH)/$(IMAGE_BUILD_GOAL)

IMAGE_CONFIG_PATH			:= $(CONFIG_IMAGE_PATH)/$(IMAGE_BUILD_GOAL)



###############################################################################
# 3. [Method Rules] Include image build method rules

$(eval $(call rule_inc,$(IMAGE_ROOT_PATH)/goal/Method.mk))



###############################################################################
# 4. [Phase Rules] Include image build phase rules

$(eval $(call rule_inc,$(IMAGE_ROOT_PATH)/goal/Phase.mk))


endif # ($(IMAGE_BUILD_GOAL),)

