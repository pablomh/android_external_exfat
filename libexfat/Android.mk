LOCAL_PATH := $(call my-dir)

common_src_files := cluster.c \
	io.c \
	log.c \
	lookup.c \
	mount.c \
	node.c \
	time.c \
	utils.c

common_c_includes := \
	$(LOCAL_PATH)

common_cflags := \
	-D_FILE_OFFSET_BITS=64 \
	-Wno-sign-compare \
	-Wno-unused-parameter

include $(CLEAR_VARS)
LOCAL_MODULE := libexfat
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES = $(common_src_files)
LOCAL_C_INCLUDES += $(common_c_includes)
LOCAL_CFLAGS = $(common_cflags)
include $(BUILD_SHARED_LIBRARY)
