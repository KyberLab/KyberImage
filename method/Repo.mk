#                                 KyberImage
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#




# image_run_fetch_repo
# $(1) fetch options
# $(2) config path
# $(3) build path
# $(4) install path
# $(5) fetch url
# $(6) fetch ref
define image_run_fetch_repo
	$(Q)mkdir -pv $(3) && cd $(3) && $(if $(call file_is_exist,$(3)/.repo),repo init -u $(5) -m $(1) -b $(6) &&) repo sync -j$$(nproc)
endef
