#                                 KyberImage
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#




# image_run_package_tar
# $(1) package options
# $(2) config path
# $(3) build path
# $(4) install path
# $(5) package list
define image_run_package_tar
	$(Q)cd $(4) && ln -s . $(IMAGE_PACKAGE_NAME)
	-$(Q)cd $(4) && tar cJvf $(4)/$(IMAGE_PACKAGE_NAME).tar.xz $(foreach file,$(5),$(IMAGE_PACKAGE_NAME)/$(file))
	$(Q)cd $(4) && rm -f $(IMAGE_PACKAGE_NAME)
endef

