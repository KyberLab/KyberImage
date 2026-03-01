#                                 KyberImage
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#




# image_run_patch_patch_verbose
# $(1) patch options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_patch_patch_verbose
	$(Q)$(call xprint_value,	"Patch Files",			$(wildcard $(2)/Patches/*.patch),$(METHOD_COLOR))
endef


# image_run_patch_patch
# $(1) patch options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_patch_patch
	$(Q)$(if $(wildcard $(2)/Patches/*.patch),cd $(3) && $(foreach patch,$(wildcard $(2)/Patches/*.patch),$(call xprint_value,"Apply Patch File",$(patch),$(RED)); patch -p1 < $(patch);),$(call xprint_info,"No patches need to be patched"))
endef


