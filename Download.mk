#                                 KyberVirt
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#




ifeq ($(MAKECMDGOALS),download)

ifeq ($(origin DOWNLOAD_REPO_URL),undefined)
$(error DOWNLOAD_REPO_URL is undefined)
endif

ifeq ($(origin DOWNLOAD_ROOT_PATH),undefined)
$(error DOWNLOAD_ROOT_PATH is undefined)
endif

.PHONY : download

download : 
ifneq ($(call file_is_exist,$(DOWNLOAD_ROOT_PATH)/.git),)
	$(Q)$(call xprint_title,	"Clone Download Repository",$(IMAGE_TITLE_COLOR))
	$(Q)$(call xprint_value,	"Download URL",					$(DOWNLOAD_REPO_URL),$(IMAGE_COLOR))
	$(Q)$(call xprint_value,	"Download Root",				$(DOWNLOAD_ROOT_PATH),$(IMAGE_COLOR))
	$(Q)git clone $(DOWNLOAD_REPO_URL) $(DOWNLOAD_ROOT_PATH)
else
	$(Q)$(call xprint_title,	"Update Download Repository",$(IMAGE_TITLE_COLOR))
	$(Q)$(call xprint_value,	"Download URL",					$(DOWNLOAD_REPO_URL),$(IMAGE_COLOR))
	$(Q)$(call xprint_value,	"Download Root",				$(DOWNLOAD_ROOT_PATH),$(IMAGE_COLOR))
	$(Q)cd $(DOWNLOAD_ROOT_PATH) && git pull
endif

endif # ($(MAKECMDGOALS),download)


