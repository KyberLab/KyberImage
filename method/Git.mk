#                                 KyberImage
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#




# git_ref_is_branch
# $(1) build path
# $(2) fetch ref
# return : is branch if not empty
define git_ref_is_branch
$(shell cd $(1) && git show-ref $(2) | awk -F "/" '{print $$2}' | grep -E 'heads|remotes')
endef


# image_run_fetch_git
# $(1) fetch options
# $(2) config path
# $(3) build path
# $(4) install path
# $(5) fetch url
# $(6) fetch ref
ifneq ($(BUILD_TYPE_STR),release)
define image_run_fetch_git
	$(Q)$(if $(call file_is_exist,$(3)/.git),git clone $(5) $(3))
	$(Q)if [ -n "`git --git-dir $(3)/.git show-ref $(6) | awk -F "/" '{print $$2}' | grep -E 'heads|remotes' | tr -d " \n"`" ] ; \
		then \
			cd $(3) && git checkout $(6); \
		else \
			cd $(3) && git reset --hard $(6); \
		fi
	$(Q)cd $(3) && git submodule update --init --recursive
endef
else
define image_run_fetch_git
	$(Q)git clone $(5) $(3)
	$(Q)cd $(3) && $(if $(call git_ref_is_branch,$(3),$(6)),$(call xprint,$(RED),"Cannot Use Branch As Git Fetch Reference in Release Build Type") && exit 1,git reset --hard $(6)) && git submodule update --init --recursive
endef
endif


# image_run_remove_git_verbose
# $(1) remove options
# $(2) config path
# $(3) build path
# $(4) install path
# $(5) install list
# $(6) package list
# $(7) image goal
define image_run_remove_git_verbose
	$(Q)$(call xprint_value,	"Install List",			$(5),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Package List",			$(6),$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Image Goal",			$(7),$(METHOD_COLOR))
	$(Q)$(call xprint_filled,$(METHOD_COLOR))
	$(Q)$(call xprint_value,	"Remove List",		$(sort $(foreach file,$(5),$(call file_dst,$(file)) )$(6) $(7)*),$(METHOD_COLOR))
endef


# image_run_remove_git
# $(1) remove options
# $(2) config path
# $(3) build path
# $(4) install path
# $(5) install list
# $(6) package list
# $(7) image goal
define image_run_remove_git
	$(Q)-cd $(4) > /dev/null 2>&1 && rm -rfv $(sort $(foreach file,$(5),$(call file_dst,$(file)) )$(6) $(if $(7),$(7)*))
	-if [ "$(1)" == "all" ]; \
	then \
		rm -rf $(3); \
	fi
	-if [ "$(1)" == "reset" ]; \
	then \
		cd $(3) > /dev/null 2>&1 && \
		git reset --hard && git submodule foreach --recursive git reset --hard && \
		git clean -fdx && git submodule foreach --recursive git clean -fdx && \
		git pull && git submodule update --init --recursive; \
	fi
endef

