#                                 KyberImage
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#




# sudo apt-get install -y cloud-image-utils guestfs-tools
# sudo virt-customize -a bionic-server-cloudimg-amd64.img --root-password password:coolpass


# image_run_config_ubuntu_metadata
# $(1) build path
# $(2) image name
define image_run_config_ubuntu_metadata
[ ! -f ~/.ssh/id_rsa ] && ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -N ""; \
key=`cat ~/.ssh/id_rsa.pub`; \
sed -i "s#SSH_KEY#$${key}#g" $(1)/$(QEMU_UBUNTU_USERDATA_TEXT); \
cloud-localds $(1)/$(2) $(1)/$(QEMU_UBUNTU_USERDATA_TEXT) $(1)/$(QEMU_UBUNTU_METADATA_TEXT)
endef


# image_run_config_ubuntu
# $(1) config options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_config_ubuntu
	$(Q)$(call image_run_config_ubuntu_metadata,$(3),$(QEMU_UBUNTU_METADATA_IMAGE))
endef



# image_run_build_ubuntu
# $(1) build options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_build_ubuntu
	$(Q)-rm -fv $(3)/$(QEMU_UEFI_BOOT_CODE_IMAGE) $(3)/$(QEMU_UEFI_BOOT_DATA_IMAGE)
	$(Q)dd if=/dev/zero bs=1M count=64 of=$(3)/$(QEMU_UEFI_BOOT_CODE_IMAGE)
	$(Q)dd if=/dev/zero bs=1M count=64 of=$(3)/$(QEMU_UEFI_BOOT_DATA_IMAGE)
	$(Q)dd if=$(3)/$(QEMU_UEFI_BOOT_FW_IMAGE) bs=1M of=$(3)/$(QEMU_UEFI_BOOT_CODE_IMAGE) conv=notrunc
	$(Q)cd $(3) && [ ! -f $(QEMU_UBUNTU_SYSTEM_IMAGE) ] && \
		qemu-img create -f qcow2 -b $(QEMU_UBUNTU_BASE_IMAGE) -o backing_fmt=qcow2 $(QEMU_UBUNTU_SYSTEM_IMAGE) 20G || :;
endef



# image_run_install_ubuntu
# $(1) install options
# $(2) config path
# $(3) build path
# $(4) install path
# $(5) install list
define image_run_install_ubuntu
	$(Q)$(call xprint_notice,"Skip Ubuntu Install")
endef



# image_run_package_ubuntu
# $(1) package options
# $(2) config path
# $(3) build path
# $(4) install path
# $(5) package list
define image_run_package_ubuntu
	$(Q)$(call xprint_notice,"Skip Ubuntu Package")
endef


# image_run_clean_ubuntu
# $(1) clean options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_clean_ubuntu
	$(Q)$(call xprint_notice,"Skip Ubuntu Clean")
endef


# image_run_distclean_ubuntu
# $(1) distclean options
# $(2) config path
# $(3) build path
# $(4) install path
define image_run_distclean_ubuntu
	$(Q)$(call xprint_notice,"Skip Ubuntu Distclean")
endef

