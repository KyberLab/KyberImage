#                                 KyberImage
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#




# image_run_fetch_dump
# $(1) fetch options
# $(2) config path
# $(3) build path
# $(4) install path
# $(5) fetch url
# $(6) fetch ref
define image_run_fetch_dump
	$(Q)$(call xprint_title,	"Dump $(IMAGE_BUILD_GOAL) Fetch",$(METHOD_TITLE_COLOR))
	$(Q)$(call xprint_value,	"Fetch Options",		$(1),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Config Path",			$(2),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Build Path",			$(3),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Install Path",			$(4),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Fetch URL",			$(5),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Fetch REF",			$(6),$(METHOD_COLOR))
	$(Q)$(call xprint_filled,$(METHOD_COLOR))
endef



# image_run_patch_dump
# $(1) patch options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_patch_dump
	$(Q)$(call xprint_title,	"Dump $(IMAGE_BUILD_GOAL) Patch",$(METHOD_TITLE_COLOR))
	$(Q)$(call xprint_value,	"Patch Options",		$(1),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Config Path",			$(2),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Build Path",			$(3),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Install Path",			$(4),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Patch Files",			$(wildcard $(2)/Patches/*.patch),$(METHOD_COLOR))
	$(Q)$(call xprint_filled,$(METHOD_COLOR))
endef


# image_run_config_dump
# $(1) config options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_config_dump
	$(Q)$(call xprint_title,	"Dump $(IMAGE_BUILD_GOAL) Config",$(METHOD_TITLE_COLOR))
	$(Q)$(call xprint_value,	"Config Options",		$(1),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Config Path",			$(2),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Build Path",			$(3),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Install Path",			$(4),$(METHOD_COLOR))
	$(Q)$(call xprint_filled,$(METHOD_COLOR))
endef


# image_run_build_dump
# $(1) build options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_build_dump
	$(Q)$(call xprint_title,	"Dump $(IMAGE_BUILD_GOAL) Build",$(METHOD_TITLE_COLOR))
	$(Q)$(call xprint_value,	"Build Options",		$(1),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Config Path",			$(2),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Build Path",			$(3),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Install Path",			$(4),$(METHOD_COLOR))
	$(Q)$(call xprint_filled,$(METHOD_COLOR))
endef


# image_run_install_dump
# $(1) install options
# $(2) config path
# $(3) build path
# $(4) install path
# $(5) install list
define image_run_install_dump
	$(Q)$(call xprint_title,	"Dump $(IMAGE_BUILD_GOAL) Install",$(METHOD_TITLE_COLOR))
	$(Q)$(call xprint_value,	"Install Options",		$(1),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Config Path",			$(2),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Build Path",			$(3),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Install Path",			$(4),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Install List",			$(5),$(METHOD_COLOR))
	$(Q)$(call xprint_filled,$(METHOD_COLOR))
endef


# image_run_package_dump
# $(1) package options
# $(2) config path
# $(3) build path
# $(4) install path
# $(5) package list
define image_run_package_dump
	$(Q)$(call xprint_title,	"Dump $(IMAGE_BUILD_GOAL) Package",$(METHOD_TITLE_COLOR))
	$(Q)$(call xprint_value,	"Package Options",		$(1),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Config Path",			$(2),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Build Path",			$(3),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Install Path",			$(4),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Package List",			$(5),$(METHOD_COLOR))
	$(Q)$(call xprint_filled,$(METHOD_COLOR))
endef


# image_run_clean_dump
# $(1) clean options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_clean_dump
	$(Q)$(call xprint_title,	"Dump $(IMAGE_BUILD_GOAL) Clean",$(METHOD_TITLE_COLOR))
	$(Q)$(call xprint_value,	"Clean Options",		$(1),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Config Path",			$(2),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Build Path",			$(3),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Install Path",			$(4),$(METHOD_COLOR))
	$(Q)$(call xprint_filled,$(METHOD_COLOR))
endef


# image_run_distclean_dump
# $(1) distclean options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_distclean_dump
	$(Q)$(call xprint_title,	"Dump $(IMAGE_BUILD_GOAL) Distclean",$(METHOD_TITLE_COLOR))
	$(Q)$(call xprint_value,	"Distclean Options",	$(1),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Config Path",			$(2),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Build Path",			$(3),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Install Path",			$(4),$(METHOD_COLOR))
	$(Q)$(call xprint_filled,$(METHOD_COLOR))
endef


# image_run_remove_dump
# $(1) remove options
# $(2) config path
# $(3) build path
# $(4) install path
# $(5) install list
# $(6) package list
# $(7) image goal
define image_run_remove_dump
	$(Q)$(call xprint_title,	"Dump $(IMAGE_BUILD_GOAL) Remove",$(METHOD_TITLE_COLOR))
	$(Q)$(call xprint_value,	"Remove Options",		$(1),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Config Path",			$(2),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Build Path",			$(3),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Install Path",			$(4),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Install List",			$(5),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Package List",			$(6),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Image Goal",			$(7),$(METHOD_COLOR))
	$(Q)$(call xprint_filled,$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Remove List",			$(sort $(foreach file,$(5),$(call file_dst,$(file)) )$(6)*),$(METHOD_COLOR))
	$(Q)$(call xprint_filled,$(METHOD_COLOR))
endef


# image_run_info_dump
# $(1) info options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_info_dump
	$(Q)$(call xprint_title,	"Dump $(IMAGE_BUILD_GOAL) Info",$(METHOD_TITLE_COLOR))
	$(Q)$(call xprint_value,	"Build Type",			$(IMAGE_BUILD_TYPE),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Build Phase",			$(call string_to_camel,$(IMAGE_BUILD_PHASE)),$(METHOD_COLOR))
	$(Q)$(call xprint_filled,$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Build Platform",		$(call string_to_camel,$(BUILD_PLATFORM)),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Build Board",			$(call string_to_camel,$(BUILD_BOARD)),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Build Flavor",			$(call string_to_camel,$(BUILD_FLAVOR)),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Build Type Number",	$(BUILD_TYPE_NUM),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Build Type String",	$(call string_to_camel,$(BUILD_TYPE_STR)),$(METHOD_COLOR))
	$(Q)$(call xprint_filled,$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Fetch Method",			$(IMAGE_FETCH_METHOD),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Fetch URL",			$(IMAGE_FETCH_URL),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Fetch Reference",		$(IMAGE_FETCH_REF),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Current Reference",	\
		$(shell if [ $(IMAGE_FETCH_METHOD) = git ]; then cd $(BUILD_IMAGE_PATH); git rev-parse HEAD 2>/dev/null; fi),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Current Status",		\
		$(shell if [ $(IMAGE_FETCH_METHOD) = git ]; then cd $(BUILD_IMAGE_PATH); git status --short --null 2>/dev/null; fi),$(METHOD_COLOR))
	$(Q)$(call xprint_filled,$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Config Method",		$(IMAGE_CONFIG_METHOD),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Config Options",		$(IMAGE_CONFIG_OPTS),$(METHOD_COLOR))
	$(Q)$(call xprint_filled,$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Build Method",			$(IMAGE_BUILD_METHOD),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Build Options",		$(IMAGE_BUILD_OPTS),$(METHOD_COLOR))
	$(Q)$(call xprint_filled,$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Install Method",		$(IMAGE_INSTALL_METHOD),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Install List",			$(IMAGE_INSTALL_LIST),$(METHOD_COLOR))
	$(Q)$(call xprint_filled,$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Package Method",		$(IMAGE_PACKAGE_METHOD),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Package List",			$(IMAGE_PACKAGE_LIST),$(METHOD_COLOR))
	$(Q)$(call xprint_filled,$(METHOD_COLOR))
endef


# image_run_status_dump
# $(1) status options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_status_dump
	$(Q)$(call xprint_title,	"Dump $(IMAGE_BUILD_GOAL) Status",$(METHOD_TITLE_COLOR))
	$(Q)$(call xprint_value,	"Fetch Phase",			$(call phase_status_str,$(3),image_fetch),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Patch Phase",			$(call phase_status_str,$(3),image_patch),$(METHOD_COLOR))
	$(Q)$(call xprint_filled,$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Config Phase",			$(call phase_status_str,$(3),image_config),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Build Phase",			$(call phase_status_str,$(3),image_build),$(METHOD_COLOR))
	$(Q)$(call xprint_filled,$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Install Phase",		$(call phase_status_str,$(3),image_install),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Package Phase",		$(call phase_status_str,$(3),image_package),$(METHOD_COLOR))
	$(Q)$(call xprint_filled,$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Clean Phase",			$(call phase_status_str,$(3),image_clean),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Distclean Phase",		$(call phase_status_str,$(3),image_distclean),$(METHOD_COLOR))
	$(Q)$(call xprint_filled,$(METHOD_COLOR))
endef


# image_run_action_dump
# $(1) action options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_action_dump
	$(Q)$(call xprint_title,	"Dump $(IMAGE_BUILD_GOAL) Action",$(METHOD_TITLE_COLOR))
	$(Q)$(call xprint_value,	"Action Options",		$(1),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Config Path",			$(2),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Build Path",			$(3),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Install Path",			$(4),$(METHOD_COLOR))
	$(Q)$(call xprint_filled,$(METHOD_COLOR))
endef


# image_run_summary_dump
# $(1) summary options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_summary_dump
	$(Q)$(call xprint_title,	"Dump $(IMAGE_BUILD_GOAL) Summary",$(METHOD_TITLE_COLOR))
	$(Q)$(call xprint_value,	"Image Fetch Method",		$(METHOD_FETCH_LIST),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Image Patch Method",		$(METHOD_PATCH_LIST),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Image Config Method",		$(METHOD_CONFIG_LIST),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Image Build Method",		$(METHOD_BUILD_LIST),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Image Install Method",		$(METHOD_INSTALL_LIST),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Image Package Method",		$(METHOD_PACKAGE_LIST),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Image Clean Method",		$(METHOD_CLEAN_LIST),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Image Distclean Method",	$(METHOD_DISTCLEAN_LIST),$(METHOD_COLOR))
	$(Q)$(call xprint_filled,$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Image Remove Method",		$(METHOD_REMOVE_LIST),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Image Info Method",		$(METHOD_INFO_LIST),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Image Status Method",		$(METHOD_STATUS_LIST),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Image Action Method",		$(METHOD_ACTION_LIST),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Image Summary Method",		$(METHOD_SUMMARY_LIST),$(METHOD_COLOR))
	$(Q)$(call xprint_filled,$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Image List",				$(IMAGE_BUILD_LIST),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Image Goal",				$(IMAGE_BUILD_GOAL),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Image Type",				$(IMAGE_BUILD_TYPE),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Image Phase",				$(call string_to_camel,$(IMAGE_BUILD_PHASE)),$(METHOD_COLOR))
	$(Q)$(call xprint_filled,$(METHOD_COLOR))
endef

