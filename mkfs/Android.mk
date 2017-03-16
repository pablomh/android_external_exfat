LOCAL_PATH := $(call my-dir)

common_src_files := \
	cbm.c \
	fat.c \
	main.c \
	mkexfat.c \
	rootdir.c \
	uct.c \
	uctc.c \
	vbr.c

common_c_includes := \
	$(LOCAL_PATH) \
	external/exfat/libexfat \
	externel/libfuse/include

common_cflags := \
	-D_FILE_OFFSET_BITS=64 \
	-Wno-sign-compare \
	-Wno-unused-parameter

common_shared_libraries := \
	libexfat \
	libfuse

include $(CLEAR_VARS)
LOCAL_MODULE := mkfs.exfat
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES = $(common_src_files)
LOCAL_C_INCLUDES += $(common_c_includes)
LOCAL_SHARED_LIBRARIES := $(common_shared_libraries)
LOCAL_CFLAGS = $(common_cflags)
include $(BUILD_EXECUTABLE)
