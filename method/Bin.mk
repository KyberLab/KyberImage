#                                 KyberImage
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#




# image_run_package_bin
# $(1) package options
# $(2) config path
# $(3) build path
# $(4) install path
# $(5) package list
define image_run_package_bin
	$(Q)$(call image_run_package_tar,$(1),$(2),$(3),$(4),$(5))
	$(Q)cat $(IMAGE_SCRIPTS_PATH)/install.sh | sed 's/^pkg_name=.*/pkg_name=$(IMAGE_PACKAGE_NAME)/g'> $(4)/$(IMAGE_PACKAGE_NAME).bin
	$(Q)python3 $(IMAGE_SCRIPTS_PATH)/license.py -l $(BUILD_LICENSE_LANG) $(IMAGE_SCRIPTS_PATH)/LICENSE $(4)/$(IMAGE_PACKAGE_NAME).bin
	$(Q)cat $(4)/$(IMAGE_PACKAGE_NAME).tar.xz >> $(4)/$(IMAGE_PACKAGE_NAME).bin
	$(Q)chmod a+x $(4)/$(IMAGE_PACKAGE_NAME).bin
	$(Q)rm -rfv $(4)/$(IMAGE_PACKAGE_NAME).tar.xz
endef

