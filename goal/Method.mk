#                                 KyberImage
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#




###############################################################################
# 3.1. [Image Config] Include image build config rules

$(eval $(call rule_inc,$(IMAGE_CONFIG_PATH)/$(IMAGE_BUILD_GOAL).mk))



###############################################################################
# 3.2. [Method Config] Include image build method rules

METHOD_RULE_FILES			:= $(wildcard $(IMAGE_METHOD_PATH)/*.mk)

include $(METHOD_RULE_FILES)



###############################################################################
# 3.3. [Method Type] Include image build type rules

$(eval $(call rule_inc,$(IMAGE_TYPE_PATH)/$(IMAGE_BUILD_TYPE).mk))



###############################################################################
# Method list

# phase_method_list
# $(1) phase name
# return : supported image build phase method list. 
define phase_method_list
$(if $(1),$(strip $(shell cat $(METHOD_RULE_FILES) | grep -e "^define image_run_$(1)_[a-z-]*$$" | sed 's/define image_run_$(1)_//g' | sort -u | tr '\n' ' ')))
endef


METHOD_FETCH_LIST			:= $(call phase_method_list,fetch)
METHOD_PATCH_LIST			:= $(call phase_method_list,patch)
METHOD_CONFIG_LIST			:= $(call phase_method_list,config)
METHOD_BUILD_LIST			:= $(call phase_method_list,build)

METHOD_INSTALL_LIST			:= $(call phase_method_list,install)
METHOD_PACKAGE_LIST			:= $(call phase_method_list,package)

METHOD_CLEAN_LIST			:= $(call phase_method_list,clean)
METHOD_DISTCLEAN_LIST		:= $(call phase_method_list,distclean)

METHOD_REMOVE_LIST			:= $(call phase_method_list,remove)
METHOD_INFO_LIST			:= $(call phase_method_list,info)
METHOD_STATUS_LIST			:= $(call phase_method_list,status)
METHOD_ACTION_LIST			:= $(call phase_method_list,action)
METHOD_SUMMARY_LIST			:= $(call phase_method_list,summary)



###############################################################################
# Method Arguments

# METHOD_FETCH_ARGS
METHOD_FETCH_ARGS_NUM		:= 2

# Argument 1 : fetch url
METHOD_FETCH_ARGS1_NAME		:= "Fetch URL"
METHOD_FETCH_ARGS1_VAL		:= $(IMAGE_FETCH_URL)

# Argument 2 : fetch ref
METHOD_FETCH_ARGS2_NAME		:= "Fetch Ref"
METHOD_FETCH_ARGS2_VAL		:= $(IMAGE_FETCH_REF)


# METHOD_INSTALL_ARGS
METHOD_INSTALL_ARGS_NUM		:= 1

# Argument 1 : install list
METHOD_INSTALL_ARGS1_NAME	:= "Install List"
METHOD_INSTALL_ARGS1_VAL	:= $(IMAGE_INSTALL_LIST)


# METHOD_PACKAGE_ARGS
METHOD_PACKAGE_ARGS_NUM		:= 1

# Argument 1 : package list
METHOD_PACKAGE_ARGS1_NAME	:= "Package List"
METHOD_PACKAGE_ARGS1_VAL	:= $(IMAGE_PACKAGE_LIST)


# METHOD_REMOVE_ARGS
METHOD_REMOVE_ARGS_NUM		:= 3

# Argument 1 : install list
METHOD_REMOVE_ARGS1_NAME	:= "Install List"
METHOD_REMOVE_ARGS1_VAL		:= $(IMAGE_INSTALL_LIST)

# Argument 2 : package list
METHOD_REMOVE_ARGS2_NAME	:= "Package List"
METHOD_REMOVE_ARGS2_VAL		:= $(IMAGE_PACKAGE_LIST)

# Argument 3 : image goal
METHOD_REMOVE_ARGS3_NAME	:= "Image Goal"
METHOD_REMOVE_ARGS3_VAL		:= $(IMAGE_BUILD_GOAL)



###############################################################################
# Method verbose

# image_verbose_base
# $(1) title color
# $(2) body color
# $(3) run phase
# $(4) run method
# $(5) run options
# $(6) config path
# $(7) build path
# $(8) install path
define image_verbose_base
	$(Q)$(call xprint_title,	"Image $(IMAGE_BUILD_GOAL) $(call string_to_camel,$(3))",$(1))
	$(Q)$(call xprint_filled,$(2))
	$(Q)$(call xprint_value,	"$(call string_to_camel,$(3)) Method",		$(4),$(2))
	$(Q)$(call xprint_value,	"$(call string_to_camel,$(3)) Options",		$(5),$(2))
	$(Q)$(call xprint_value,	"Config Path",		$(6),$(2))
	$(Q)$(call xprint_value,	"Build Path",		$(7),$(2))
	$(Q)$(call xprint_value,	"Install Path",		$(8),$(2))
	$(Q)$(call xprint_filled,$(2))
endef


# image_verbose_arguments
# $(1) run phase
# $(2) title color
# $(3) body color
# $(4) num of arguments
# $(5)...$(10) arg1...arg6
define image_verbose_arguments
	$(Q)[ 1 -le $(4) ] && $(call xprint_value,	"$(METHOD_$(call string_to_upper,$(1))_ARGS1_NAME)",		$(5),$(3)) || :
	$(Q)[ 2 -le $(4) ] && $(call xprint_value,	"$(METHOD_$(call string_to_upper,$(1))_ARGS2_NAME)",		$(6),$(3)) || :
	$(Q)[ 3 -le $(4) ] && $(call xprint_value,	"$(METHOD_$(call string_to_upper,$(1))_ARGS3_NAME)",		$(7),$(3)) || :
	$(Q)[ 4 -le $(4) ] && $(call xprint_value,	"$(METHOD_$(call string_to_upper,$(1))_ARGS4_NAME)",		$(8),$(3)) || :
	$(Q)[ 5 -le $(4) ] && $(call xprint_value,	"$(METHOD_$(call string_to_upper,$(1))_ARGS5_NAME)",		$(9),$(3)) || :
	$(Q)[ 6 -le $(4) ] && $(call xprint_value,	"$(METHOD_$(call string_to_upper,$(1))_ARGS6_NAME)",		$(10),$(3)) || :
	$(Q)$(call xprint_filled,$(3))
endef


# image_verbose_default
# $(1) run phase
# $(2) run method
# $(3) run options
# $(4) config path
# $(5) build path
# $(6) install path
# $(7)...$(12) arg1...arg6
define image_verbose_default
	$(Q)$(call image_verbose_base,$(IMAGE_TITLE_COLOR),$(IMAGE_COLOR),$(1),$(2),$(3),$(4),$(5),$(6))
	$(Q)$(if $(METHOD_$(call string_to_upper,$(1))_ARGS_NUM),$(call image_verbose_arguments,$(1),$(IMAGE_TITLE_COLOR),$(IMAGE_COLOR),$(METHOD_$(call string_to_upper,$(1))_ARGS_NUM),$(7),$(8),$(9),$(10),$(11),$(12)))
endef


# method_verbose_special
# $(1) run phase
# $(2) run method
# $(3) run options
# $(4) config path
# $(5) build path
# $(6) install path
# $(7)...$(12) arg1...arg6
define method_verbose_special
	$(Q)$(if $(filter $(2),dump skip),,$(call image_verbose_base,$(METHOD_TITLE_COLOR),$(METHOD_COLOR),$(1),$(2),$(3),$(4),$(5),$(6)))
	$(call image_run_$(1)_$(call string_to_lower,$(2))_verbose,$(3),$(4),$(5),$(6),$(7),$(8),$(9),$(10),$(11),$(12))
	$(Q)$(if $(filter $(2),dump skip),,$(if $(image_run_$(1)_$(call string_to_lower,$(2))_verbose),$(call xprint_filled,$(METHOD_COLOR))))
endef


# method_verbose
# $(1) run phase
# $(2) run method
# $(3) run options
# $(4) config path
# $(5) build path
# $(6) install path
# $(7)...$(12) arg1...arg6
ifeq ($(IMAGE_VERBOSE),)
ifeq ($(METHOD_VERBOSE),)
define method_verbose
	$(if $(image_run_$(1)_$(call string_to_lower,$(2))_verbose),$(call method_verbose_special,$(1),$(2),$(3),$(4),$(5),$(6),$(7),$(8),$(9),$(10),$(11),$(12)),$(if $(filter $(2),dump skip),,$(call image_verbose_default,$(1),$(2),$(3),$(4),$(5),$(6),$(7),$(8),$(9),$(10),$(11),$(12))))
endef
else # ($(METHOD_VERBOSE))
define method_verbose
	$(call method_verbose_special,$(1),$(2),$(3),$(4),$(5),$(6),$(7),$(8),$(9),$(10),$(11),$(12))
endef
endif # ($(METHOD_VERBOSE))

else # ($(IMAGE_VERBOSE))

ifeq ($(METHOD_VERBOSE))
define method_verbose
	$(if $(filter $(2),dump skip),,$(call image_verbose_default,$(1),$(2),$(3),$(4),$(5),$(6),$(7),$(8),$(9),$(10),$(11),$(12)))
endef
else # ($(METHOD_VERBOSE))
define method_verbose
	$(if $(filter $(2),dump skip),,$(call image_verbose_default,$(1),$(2),$(3),$(4),$(5),$(6),$(7),$(8),$(9),$(10),$(11),$(12)))
	$(call method_verbose_special,$(1),$(2),$(3),$(4),$(5),$(6),$(7),$(8),$(9),$(10),$(11),$(12))
endef
endif # ($(METHOD_VERBOSE))
endif # ($(IMAGE_VERBOSE))



###############################################################################
# Method run

# method_run_helper
# $(1) run phase
# $(2) run method
# $(3) run options
# $(4) config path
# $(5) build path
# $(6) install path
# $(7)...$(12) arg1...arg6
define method_run_helper
	$(if $(image_prerun_$(1)),$(call image_prerun_$(1),$(3),$(4),$(5),$(6),$(7),$(8),$(9),$(10),$(11),$(12)))
	$(call method_verbose,$(1),$(2),$(3),$(4),$(5),$(6),$(7),$(8),$(9),$(10),$(11),$(12))
	$(call image_run_$(1)_$(call string_to_lower,$(2)),$(3),$(4),$(5),$(6),$(7),$(8),$(9),$(10),$(11),$(12))
	$(if $(image_postrun_$(1)),$(call image_postrun_$(1),$(3),$(4),$(5),$(6),$(7),$(8),$(9),$(10),$(11),$(12)))
endef


# method_run_checked
# $(1) run phase
# $(2) allowed method
# $(3) run method
# $(4) run options
# $(5) config path
# $(6) build path
# $(7) install path
# $(8)...$(13) arg1...arg6
define method_run_checked
	$(if $(findstring $(3),$(2)),$(call method_run_helper,$(1),$(3),$(4),$(5),$(6),$(7),$(8),$(9),$(10),$(11),$(12),$(13)),echo "Unsupported $(call string_to_camel,$(1)) method :" \"$(3)\"; exit 1)
endef


# method_run_with_args
# $(1) run phase
# $(2)...$(7) arg1...arg6
define method_run_with_args
	$(call method_run_checked,$(1),$(METHOD_$(call string_to_upper,$(1))_LIST),$(IMAGE_$(call string_to_upper,$(1))_METHOD),$(IMAGE_$(call string_to_upper,$(1))_OPTS),$(IMAGE_CONFIG_PATH),$(BUILD_IMAGE_PATH),$(OUTPUT_ROOT_PATH),$(2),$(3),$(4),$(5),$(6),$(7))
endef


# method_args
# $(1) phase name
# $(2) arg name
# return arg value
define method_args
$(METHOD_$(call string_to_upper,$(1))_ARGS$(2)_VAL)
endef

# method_run
# $(1) run phase
define method_run
	$(call method_run_with_args,$(1),$(call method_args,$(1),1),$(call method_args,$(1),2),$(call method_args,$(1),3),$(call method_args,$(1),4),$(call method_args,$(1),5),$(call method_args,$(1),6))
endef

