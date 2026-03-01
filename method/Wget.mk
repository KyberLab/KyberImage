#                                 KyberImage
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#




# url_src
# $(1) url, format:src:dst:md5sum
# return url src
define url_src
$(shell echo "$(1)" | awk -F: '{OFS=":"; NF-=2; print}')
endef


# url_dst
# $(1) url, format:src:dst:md5sum
# return url dst
define url_dst
$(shell echo "$(1)" | awk -F: '{print $$(NF-1)}')
endef


# url_hash
# $(1) url, format:src:dst:hash
# return url hash
define url_hash
$(shell echo "$(1)" | awk -F: '{print $$NF}')
endef


# image_run_fetch_wget
# $(1) fetch options
# $(2) config path
# $(3) build path
# $(4) install path
# $(5) fetch url
# $(6) fetch ref
define image_run_fetch_wget
	$(Q)$(foreach url,$(5),src=$(call url_src,$(url)); dst=$(3)/$(call url_dst,$(url)); hash=$(call url_hash,$(url)); [ ! -f $${dst} ] && wget $${src} -O $${dst} || :; md5=`md5sum $${dst} | awk '{print $$1}'`; if [ "$${md5}" != "$${hash}" ]; then echo "File \"$${dst}\" Hash $${md5} Error !!!"; exit 1; fi;)
endef

