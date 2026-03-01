#                                 KyberImage
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#




# image_run_patch_file_verbose
# $(1) patch options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_patch_file_verbose
	$(Q)$(call xprint_value,	"Patch Files",			$(wildcard $(2)/Files/*),$(METHOD_COLOR))
endef


# image_run_patch_file
# $(1) patch options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_patch_file
	$(Q)$(foreach file,$(wildcard $(2)/Files/*),src=$(file); dst=$(3)/$(notdir $(file)); cp $(if $(1),$(1),-fv) $${src} $${dst} || :;)
endef



# image_run_install_file
# $(1) install options
# $(2) config path
# $(3) build path
# $(4) install path
# $(5) install list
define image_run_install_file
	$(Q)$(foreach file,$(5),src=$(3)/$(call file_src,$(file)); dst=$(4)/$(call file_dst,$(file)); [ $${src} -nt $${dst} ] && cp $(if $(1),$(1),-fv) $${src} $${dst} || :;)
endef

