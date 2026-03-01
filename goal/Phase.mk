#                                 KyberImage
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#




###############################################################################
# Phase function

# phase_status_file
# $(1) build path
# $(2) build phase
define phase_status_file
$(1)/.$(2).done
endef


# phase_done
# $(1) build path
# $(2) build phase
ifneq ($(IMAGE_DONE_VERBOSE),)
define phase_done
	$(Q)[ $$? = 0 ] && touch $(call phase_status_file,$(1),$(2))
	$(Q)$(call xprint_line,$(IMAGE_COLOR))
	$(Q)$(call xprint_info,"$(IMAGE_BUILD_GOAL) $(call string_to_camel,$(patsubst image_%,%,$(2))) Completed.",$(IMAGE_COLOR))
	$(Q)$(call xprint_line,$(IMAGE_COLOR))
endef
else
define phase_done
	$(Q)-[ $$? = 0 ] && [ "$(2)" != "image_remove" ] && [ "$(IMAGE_REMOVE_OPTS)" != "all" ] && touch $(call phase_status_file,$(1),$(2)) 1>/dev/null 2>&1 || exit 0
endef
endif


# phase_undo
# $(1) build path
# $(2) build phase
define phase_undo
	$(Q)rm -f $(call phase_status_file,$(1),$(2))
	$(call newline)
endef


# phase_check
# $(1) build path
# $(2) build phase
# $(3) check - check the phase whether has done if this value empty, else return this value.
# return : none empty when the phase need to be executed.
define phase_check
$(if $(3),$(3),$(call file_is_exist,$(call phase_status_file,$(1),$(2))))
endef


# phase_status_str
# $(1) build path
# $(2) build phase
define phase_status_str
$(shell if [ -f $(call phase_status_file,$(1),$(2)) ]; then echo -n Done; else echo -n Todo; fi)
endef


# phase_depend
# $(1) build path
# $(2) phase to depended
# return : depend phase
define phase_depend
$(if $(call phase_check,$(1),$(2)),$(2))
endef


# phase_run_helper
# $(1) build path
# $(2) phase name
# $(3) undo phase list
define phase_run_helper
$(call method_run,$(2))
$(call phase_done,$(1),image_$(2))
$(foreach phase,$(3),$(call phase_undo,$(1),image_$(phase)))
endef
#$(call xprint,$(RED),Phase \"$(2)\" Undo Phase \"$(3)\")


# phase_run
# $(1) build path
# $(2) phase name
# $(3) check - check the phase whether has done if this value empty, else return this value.
# $(4) undo phase list
define phase_run
	$(if $(call phase_check,$(1),$(2),$(3)),$(call phase_run_helper,$(1),$(patsubst image_%,%,$(2)),$(4)),$(call phase_done,$(1),$(2)))
endef



###############################################################################
# Phase targets

# image_depend_image
# $(1) image name
# $(2) depend image name
define image_depend_image
IMAGE_$(call string_to_upper,$(1))_DEPEND += $(2)
$(call newline)
endef

$(eval $(foreach depend,$(IMAGE_DEPEND_LIST),$(call image_depend_image,$(call file_src,$(depend)),$(call file_dst,$(depend)))))
#$(error IMAGE_$(call string_to_upper,$(IMAGE_BUILD_GOAL))_DEPEND=$(IMAGE_$(call string_to_upper,$(IMAGE_BUILD_GOAL))_DEPEND))


$(BUILD_IMAGE_PATH) $(OUTPUT_ROOT_PATH) : 
	$(Q)mkdir -pv $@

image_fetch : $(BUILD_IMAGE_PATH)
	$(call phase_run,$(BUILD_IMAGE_PATH),$@)

image_patch : $(call phase_depend,$(BUILD_IMAGE_PATH),image_fetch)
	$(call phase_run,$(BUILD_IMAGE_PATH),$@,$(if $<,not_check))

image_config : $(call phase_depend,$(BUILD_IMAGE_PATH),image_patch)
	$(call phase_run,$(BUILD_IMAGE_PATH),$@,not_check,build install package)

image_build : $(call phase_depend,$(BUILD_IMAGE_PATH),image_config)
	$(Q)$(foreach depend,$(IMAGE_$(call string_to_upper,$(IMAGE_BUILD_GOAL))_DEPEND),$(MAKE) $(IMAGE_EXPORT_ENV) IMAGE_BUILD_GOAL=$(depend) image_install &&) $(ECHO) -n
	$(call phase_run,$(BUILD_IMAGE_PATH),$@,not_check,install package)

image_install : $(call phase_depend,$(BUILD_IMAGE_PATH),image_build) $(OUTPUT_ROOT_PATH)
	$(call phase_run,$(BUILD_IMAGE_PATH),$@,$(if $<,not_check),package)

image_package : $(call phase_depend,$(BUILD_IMAGE_PATH),image_install)
	$(call phase_run,$(BUILD_IMAGE_PATH),$@,$(if $<,not_check),package)

image_clean : 
	$(call phase_run,$(BUILD_IMAGE_PATH),$@,not_check,build install package)

image_distclean : 
	$(call phase_run,$(BUILD_IMAGE_PATH),$@,not_check,config build install package)

image_remove : 
	$(call phase_run,$(BUILD_IMAGE_PATH),$@,not_check,config build install package)

image_info image_status image_action image_summary : 
	$(call phase_run,$(BUILD_IMAGE_PATH),$@,not_check)

$(IMAGE_BUILD_LIST) : image_install


% : 
	$(Q)$(call xprint,$(RED),"Error Image \"$@\" Goal \"$(IMAGE_BUILD_GOAL)\" Make Command Goal \"$(MAKECMDGOALS)\"")

