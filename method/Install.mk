#                                 KyberImage
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#




# image_install_files
# $(1) install src base path
# $(2) install dst base path
# $(3) install file list
# $(4) log file
define image_install_files
	$(Q)$(if $(4),if [ -f $(4) ] ; then truncate -s 0 $(4); fi)
	$(Q)$(foreach file,$(3),$(call file_installx,$(1):$(2),$(file),$(4)) && )$(ECHO) -n
endef



# image_run_install_install
# $(1) install options
# $(2) config path
# $(3) build path
# $(4) install path
# $(5) install list
define image_run_install_install
	$(Q)$(call image_install_files,$(3),$(4),$(5),$(3)/.image_install.log)
endef
#	$(Q)$(foreach file,$(4),cp $(1) $(2)/$(call file_src,$(file)) $(3)/$(call file_dst,$(file));)


