LOCAL_PATH := $(call my-dir)

common_src_files := \
	main.c

common_c_includes := \
	$(LOCAL_PATH) \
	external/exfat/libexfat \
	external/libfuse/include

common_cflags := \
	-D_FILE_OFFSET_BITS=64

common_shared_libraries := \
	libexfat

include $(CLEAR_VARS)
LOCAL_MODULE := fsck.exfat
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES = $(common_src_files)
LOCAL_C_INCLUDES += $(common_c_includes)
LOCAL_SHARED_LIBRARIES := $(common_shared_libraries)
LOCAL_CFLAGS = $(common_cflags)
include $(BUILD_EXECUTABLE)
