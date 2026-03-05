#                                 KyberImage
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#




###############################################################################

# image_config_dir_name
# $(1) image name
define image_config_dir_name
$(shell find $(CONFIG_IMAGE_PATH) -maxdepth 1 -type d -iname $(1) -printf "%f")
endef



###############################################################################
# Image build shortcut

# Format <image_name>_<build_phase>
IMAGE_BUILD_SHORTCUT		:= $(foreach image,$(IMAGE_BUILD_FULL_LIST),$(addprefix $(image)_,$(IMAGE_BUILD_PHASES)))
#$(error IMAGE_BUILD_SHORTCUT=$(IMAGE_BUILD_SHORTCUT))


.PHONY : $(IMAGE_BUILD_PHASES) $(IMAGE_BUILD_SHORTCUT)

$(IMAGE_BUILD_PHASES) : 
	$(Q)$(IMAGE_EXPORT_ENV) $(MAKE) image_$@ $(call make_cmd_vars)


$(IMAGE_BUILD_SHORTCUT) : 
	$(call image_shortcut_helper,$@)


# image_shortcut_goal_name
# $(1) target name
define image_shortcut_goal_name
$(call image_config_dir_name,$(shell echo $(1) | awk -F "_" '{print $$1}'))
endef


# image_shortcut_phase_name
# $(1) target name
define image_shortcut_phase_name
image_$(shell echo $(1) | awk -F "_" '{print $$2}')
endef


# image_shortcut_helper
# $(1) image
define image_shortcut_helper
	$(Q)$(if $(call image_shortcut_goal_name,$(1)),$(IMAGE_EXPORT_ENV) $(MAKE) IMAGE_BUILD_GOAL=$(call image_shortcut_goal_name,$(1)) $(call make_cmd_vars) $(call image_shortcut_phase_name,$(1)),$(call xprint,$(RED),"Invalid Image Target $(1) - Skip !"))
endef



###############################################################################
# Crate build shortcut

# Format : <image_name>_<goods_name>_<build_phase>
CRATE_BUILD_SHORTCUT		:= $(addsuffix _%,$(IMAGE_BUILD_FULL_LIST))
# $(error CRATE_BUILD_SHORTCUT=$(CRATE_BUILD_SHORTCUT))

.PHONY : $(CRATE_BUILD_SHORTCUT)

$(CRATE_BUILD_SHORTCUT) : 
	$(call crate_shortcut_helper,$@)


# crate_shortcut_image_name
# $(1) image
define crate_shortcut_image_name
$(call image_config_dir_name,$(shell echo $(1) | awk -F "_" '{print $$1}'))
endef


# crate_shortcut_goal_name_helper
# $(1) image
# $(2) num for suffix skipped
define crate_shortcut_goal_name_helper
$(shell echo $(1) | awk -F "_" '{for(i=2;i<NF-$(2);i++) printf("%s_",$$i);printf("%s",$$(NF-$(2)))}')
endef


# crate_shortcut_goal_name
# $(1) image
define crate_shortcut_goal_name
$(if $(findstring $(call crate_shortcut_phase_name_helper,$(1)),$(IMAGE_BUILD_PHASES)),$(call crate_shortcut_goal_name_helper,$(1),1),$(call crate_shortcut_goal_name_helper,$(1),0))
endef


# crate_shortcut_phase_name_helper
# $(1) image
define crate_shortcut_phase_name_helper
$(shell echo $(1) | awk -F "_" '{print $$NF}')
endef


# crate_shortcut_phase_name
# $(1) image
define crate_shortcut_phase_name
$(if $(findstring $(call crate_shortcut_phase_name_helper,$(1)),$(IMAGE_BUILD_PHASES)),image_$(call crate_shortcut_phase_name_helper,$(1)),image_install)
endef


# crate_shortcut_helper
# $(1) image
define crate_shortcut_helper
	$(Q)$(if $(call crate_shortcut_goal_name,$(1)),$(MAKE) IMAGE_BUILD_GOAL=$(call crate_shortcut_image_name,$(1)) CRATE_BUILD_GOAL=$(call crate_shortcut_goal_name,$(1)) $(IMAGE_EXPORT_ENV) $(call crate_shortcut_phase_name,$(1)),$(call xprint,$(RED),"Invalid Crate Target $(1) - Skip !"))
endef

