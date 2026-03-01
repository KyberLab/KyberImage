#                                 KyberVirt
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#




###############################################################################
# Default Macros

# file_is_exist
# $(1) file path
# return empty if exist.
ifeq ($(origin file_is_exist),undefined)
define file_is_exist
$(shell ls $(1) > /dev/null 2>&1;echo $$? | grep -v 0)
endef
endif

# rule_inc
# $(1) rule file path
ifeq ($(origin rule_inc),undefined)
define rule_inc
$(if $(call file_is_exist,$(1)),$(error Rule File "$(1)" Not Exist !!!),include $(1))
endef
endif

# is_in_docker
# return : empty if in docker
ifeq ($(origin is_in_docker),undefined)
define is_in_docker
$(shell echo `[ ! -f /.dockerenv ]` $$? | grep -v 1)
endef
endif

# cur_dir
# return : current directory path
ifeq ($(origin cur_dir),undefined)
define cur_dir
$(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
endef
endif



###############################################################################
# Path Check

ifeq ($(origin WORKSPACE_ROOT_PATH),undefined)
$(error "WORKSPACE_ROOT_PATH has not been defined.")
endif


ifeq ($(origin IMAGE_ROOT_PATH),undefined)
#$(warning "IMAGE_ROOT_PATH has not been defined.")
IMAGE_ROOT_PATH			:= $(call cur_dir)
#$(warning Define IMAGE_ROOT_PATH = $(IMAGE_ROOT_PATH))
endif



###############################################################################
# Default targets

BUILD_EXPORT_ENV		= \
	BUILD_TYPE_NUM=$(BUILD_TYPE_NUM) \
	BUILD_TYPE_STR=$(BUILD_TYPE_STR) \
	BUILD_FLAVOR=$(BUILD_FLAVOR) \
	WORKSPACE_ROOT_PATH=$(WORKSPACE_ROOT_PATH) \
	BUILD_ROOT_PATH=$(BUILD_ROOT_PATH) \
	CONFIG_ROOT_PATH=$(CONFIG_ROOT_PATH) \
	CONFIG_IMAGE_PATH=$(CONFIG_IMAGE_PATH) \
	BENCH_CMD_ARGS=$(BENCH_CMD_ARGS) \
	V=$(V) \
	IV=$(IV)

.PHONY : all image $(IMAGE_BUILD_PHASES)

all image : 
ifeq ($(shell echo $${BENCH_WORK_PATH}),)
	$(Q)$(MAKE) run_$(BUILD_BOARD) USER_RUN_CMD="$(MAKE) $(MAKECMDGOALS)"
else # ($(shell echo $${BENCH_WORK_PATH}),)
	$(Q)cd $(WORKSPACE_ROOT_PATH)/image && $(BUILD_EXPORT_ENV) $(MAKE) $@
endif # ($(shell echo $${BENCH_WORK_PATH}),)



###############################################################################
# Build Configs

BENCH_ROOT_PATH				?= $(WORKSPACE_ROOT_PATH)/bench

# Bench Rules
$(eval $(call rule_inc,$(BENCH_ROOT_PATH)/Main.mk))

# 1. [Workspace Config] (in Config.mk)
# 2. [Build Config] Top Level Build Config
$(eval $(call rule_inc,$(IMAGE_ROOT_PATH)/Config.mk))



###############################################################################
# Targets

.PHONY : $(IMAGE_BUILD_PHASES)


$(IMAGE_BUILD_PHASES) : 
ifeq ($(shell echo $${BENCH_WORK_PATH}),)
	$(Q)$(MAKE) run_$(BUILD_BOARD) USER_RUN_CMD="$(MAKE) $(MAKECMDGOALS) $(call make_cmd_vars)"
else # ($(shell echo $${BENCH_WORK_PATH}),)
	$(Q)cd $(WORKSPACE_ROOT_PATH)/image && $(BUILD_EXPORT_ENV) $(MAKE) image_$@
endif # ($(shell echo $${BENCH_WORK_PATH}),)


% : 
ifeq ($(shell echo $${BENCH_WORK_PATH}),)
	$(Q)$(MAKE) run_$(BUILD_BOARD) USER_RUN_CMD="$(MAKE) $(MAKECMDGOALS) $(call make_cmd_vars)"
else # ($(shell echo $${BENCH_WORK_PATH}),)
	$(Q)cd $(WORKSPACE_ROOT_PATH)/image && $(BUILD_EXPORT_ENV) $(MAKE) $@
endif # ($(shell echo $${BENCH_WORK_PATH}),)

