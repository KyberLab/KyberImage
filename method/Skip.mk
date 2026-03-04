#                                 KyberImage
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#




# image_run_fetch_skip
# $(1) fetch options
# $(2) config path
# $(3) build path
# $(4) install path
# $(5) fetch url
# $(6) fetch ref
define image_run_fetch_skip
	$(Q)$(call xprint_notice,	"Skip $(IMAGE_BUILD_GOAL) Fetch",$(METHOD_NOTICE_COLOR))
endef


# image_run_patch_skip
# $(1) patch options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_patch_skip
	$(Q)$(call xprint_notice,	"Skip $(IMAGE_BUILD_GOAL) Patch",$(METHOD_NOTICE_COLOR))
endef


# image_run_config_skip
# $(1) config options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_config_skip
	$(Q)$(call xprint_notice,	"Skip $(IMAGE_BUILD_GOAL) Config",$(METHOD_NOTICE_COLOR))
endef


# image_run_build_skip
# $(1) build options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_build_skip
	$(Q)$(call xprint_notice,	"Skip $(IMAGE_BUILD_GOAL) Build",$(METHOD_NOTICE_COLOR))
endef


# image_run_install_skip
# $(1) install options
# $(2) config path
# $(3) build path
# $(4) install path
# $(5) install list
define image_run_install_skip
	$(Q)$(call xprint_notice,	"Skip $(IMAGE_BUILD_GOAL) Install",$(METHOD_NOTICE_COLOR))
endef


# image_run_package_skip
# $(1) package options
# $(2) config path
# $(3) build path
# $(4) install path
# $(5) package list
define image_run_package_skip
	$(Q)$(call xprint_notice,	"Skip $(IMAGE_BUILD_GOAL) Package",$(METHOD_NOTICE_COLOR))
endef


# image_run_clean_skip
# $(1) clean options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_clean_skip
	$(Q)$(call xprint_notice,	"Skip $(IMAGE_BUILD_GOAL) Clean",$(METHOD_NOTICE_COLOR))
endef


# image_run_distclean_skip
# $(1) distclean options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_distclean_skip
	$(Q)$(call xprint_notice,	"Skip $(IMAGE_BUILD_GOAL) Distclean",$(METHOD_NOTICE_COLOR))
endef


# image_run_remove_skip
# $(1) remove options
# $(2) config path
# $(3) build path
# $(4) install path
# $(5) install list
# $(6) package list
# $(7) image goal
define image_run_remove_skip
	$(Q)$(call xprint_notice,	"Skip $(IMAGE_BUILD_GOAL) Remove",$(METHOD_NOTICE_COLOR))
endef


# image_run_info_skip
# $(1) info options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_info_skip
	$(Q)$(call xprint_notice,	"Skip $(IMAGE_BUILD_GOAL) Info",$(METHOD_NOTICE_COLOR))
endef


# image_run_status_skip
# $(1) status options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_status_skip
	$(Q)$(call xprint_notice,	"Skip $(IMAGE_BUILD_GOAL) Status",$(METHOD_NOTICE_COLOR))
endef

# image_run_action_skip
# $(1) action options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_action_skip
	$(Q)$(call xprint_notice,	"Skip $(IMAGE_BUILD_GOAL) Action",$(METHOD_NOTICE_COLOR))
endef


# image_run_summary_skip
# $(1) summary options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_summary_skip
	$(Q)$(call xprint_notice,	"Skip $(IMAGE_BUILD_GOAL) Summary",$(METHOD_NOTICE_COLOR))
endef

