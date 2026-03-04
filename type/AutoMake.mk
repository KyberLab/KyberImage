#                                 KyberImage
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#




# Image fetch phase
IMAGE_FETCH_METHOD			?= git
IMAGE_FETCH_OPTS			?= 

# Image patch phase
IMAGE_PATCH_METHOD			?= patch
IMAGE_PATCH_OPTS			?= 

# Image config phase
IMAGE_CONFIG_METHOD			?= automake
IMAGE_CONFIG_OPTS			?= 

# Image build phase
IMAGE_BUILD_METHOD			?= automake
IMAGE_BUILD_OPTS			?= 

# Image install phase
IMAGE_INSTALL_METHOD		?= automake
IMAGE_INSTALL_OPTS			?= 

# Image package phase
IMAGE_PACKAGE_METHOD		?= tar
IMAGE_PACKAGE_OPTS			?= 

# Image clean phase
IMAGE_CLEAN_METHOD			?= automake
IMAGE_CLEAN_OPTS			?= 

# Image distclean phase
IMAGE_DISTCLEAN_METHOD		?= automake
IMAGE_DISTCLEAN_OPTS		?= 

# Image remove phase
IMAGE_REMOVE_METHOD			?= git
IMAGE_REMOVE_OPTS			?= 

# Image info phase
IMAGE_INFO_METHOD			?= dump
IMAGE_INFO_OPTS				?= 

# Image status phase
IMAGE_STATUS_METHOD			?= dump
IMAGE_STATUS_OPTS			?= 

# Image action phase
IMAGE_ACTION_METHOD			?= dump
IMAGE_ACTION_OPTS			?= 

# Image summary phase
IMAGE_SUMMARY_METHOD		?= dump
IMAGE_SUMMARY_OPTS			?= 

