#                                 KyberImage
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#




# image_run_fetch_custom
# $(1) fetch options
# $(2) config path
# $(3) build path
# $(4) install path
# $(5) fetch url
# $(6) fetch ref
define image_run_fetch_custom
	$(call image_custom_fetch,$(1),$(2),$(3),$(4),$(5),$(6))
endef


# image_run_patch_custom_verbose
# $(1) patch options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_patch_custom_verbose
	$(Q)$(call xprint_value,	"Patch Files",			$(wildcard $(2)/Patches/*.patch),$(METHOD_COLOR))
endef


# image_run_patch_custom
# $(1) patch options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_patch_custom
	$(Q)$(if $(wildcard $(2)/Patches/*.patch),cd $(3) && $(foreach patch,$(wildcard $(2)/Patches/*.patch),$(call xprint_value,"Found patch files",$(patch),$(RED));),$(call xprint_info,"No patches need to be patched"))
	$(call image_custom_patch,$(1),$(2),$(3),$(4))
endef


# image_run_config_custom
# $(1) config options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_config_custom
	$(call image_custom_config,$(1),$(2),$(3),$(4))
endef


# image_run_build_custom
# $(1) build options
# $(2) build path
# $(3) install path
define image_run_build_custom
	$(call image_custom_build,$(1),$(2),$(3))
endef


# image_run_install_custom
# $(1) install options
# $(2) config path
# $(3) build path
# $(4) install path
# $(5) install list
define image_run_install_custom
	$(call image_custom_install,$(1),$(2),$(3),$(4),$(5))
endef


# image_run_package_custom
# $(1) package options
# $(2) config path
# $(3) build path
# $(4) install path
# $(5) package list
define image_run_package_custom
	$(call image_custom_package,$(1),$(2),$(3),$(4),$(5))
endef


# image_run_clean_custom
# $(1) clean options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_clean_custom
	$(call image_custom_clean,$(1),$(2),$(3),$(4))
endef


# image_run_distclean_custom
# $(1) distclean options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_distclean_custom
	$(call image_custom_distclean,$(1),$(2),$(3),$(4))
endef


# image_run_remove_custom
# $(1) remove options
# $(2) config path
# $(3) build path
# $(4) install path
# $(5) install list
# $(6) package list
# $(7) image goal
define image_run_remove_custom
	$(call image_custom_remove,$(1),$(2),$(3),$(4),$(5),$(6),$(7))
endef


# image_run_info_custom
# $(1) info options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_info_custom
	$(call image_custom_info,$(1),$(2),$(3),$(4))
endef


# image_run_status_custom
# $(1) status options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_status_custom
	$(call image_custom_status,$(1),$(2),$(3),$(4))
endef


# image_run_action_custom
# $(1) action options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_action_custom
	$(call image_custom_action,$(1),$(2),$(3),$(4))
endef


# image_run_summary_custom
# $(1) summary options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_summary_custom
	$(call image_custom_summary,$(1),$(2),$(3),$(4))
endef

