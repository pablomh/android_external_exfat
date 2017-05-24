#
# Free exFAT implementation.
# Copyright (C) 2017  liminghao
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
#

LOCAL_PATH:= $(call my-dir)

exfat_common_cflags := \
    -D_FILE_OFFSET_BITS=64 \
    -D_LARGEFILE_SOURCE
    -DHAVE_CONFIG_H \
    -std=gnu99

exfat_common_shared_libraries := \
    libexfat

########################################
# shared library: libexfat.so

libexfat_src_files := \
    libexfat/cluster.c \
    libexfat/io.c \
    libexfat/log.c \
    libexfat/lookup.c \
    libexfat/mount.c \
    libexfat/node.c \
    libexfat/time.c \
    libexfat/utf.c \
    libexfat/utils.c

libexfat_headers := \
    $(LOCAL_PATH)/android \
    $(LOCAL_PATH)/libexfat

libexfat_shared_libraries := \
    liblog

## SHARED ##
include $(CLEAR_VARS)

LOCAL_MODULE := libexfat
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := $(libexfat_src_files)
LOCAL_CFLAGS := $(exfat_common_cflags)
LOCAL_C_INCLUDES := $(libexfat_headers)
LOCAL_SHARED_LIBRARIES := $(libexfat_shared_libraries)

include $(BUILD_SHARED_LIBRARY)


########################################
# executable: mkfs.exfat

mkexfatfs_src_files := \
    mkfs/cbm.c \
    mkfs/fat.c \
    mkfs/main.c \
    mkfs/mkexfat.c \
    mkfs/rootdir.c \
    mkfs/uct.c \
    mkfs/uctc.c \
    mkfs/vbr.c

mkexfatfs_headers := \
    $(libexfat_headers) \
    $(LOCAL_PATH)/mkfs

## TARGET ##
include $(CLEAR_VARS)

LOCAL_MODULE := mkfs.exfat
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := $(mkexfatfs_src_files)
LOCAL_CFLAGS := $(exfat_common_cflags)
LOCAL_C_INCLUDES := $(mkexfatfs_headers)
LOCAL_SHARED_LIBRARIES := $(exfat_common_shared_libraries)

include $(BUILD_EXECUTABLE)

########################################
# executable: fsck.exfat

exfatfsck_src_files := fsck/main.c

exfatfsck_headers := \
    $(libexfat_headers) \
    $(LOCAL_PATH)/fsck

## TARGET ##
include $(CLEAR_VARS)

LOCAL_MODULE := fsck.exfat
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := $(exfatfsck_src_files)
LOCAL_CFLAGS := $(exfat_common_cflags)
LOCAL_C_INCLUDES := $(exfatfsck_headers)
LOCAL_SHARED_LIBRARIES := $(exfat_common_shared_libraries)

include $(BUILD_EXECUTABLE)

########################################
# executable: mount.exfat

exfatmount_src_files := fuse/main.c

exfatmount_headers := \
    $(libexfat_headers) \
    external/libfuse/include

exfatmount_common_cflags := \
    $(exfat_common_cflags) \
    -DFUSE_USE_VERSION=30

exfatmount_common_shared_libraries := \
    $(exfat_common_shared_libraries) \
    libfuse

## TARGET ##
include $(CLEAR_VARS)

LOCAL_MODULE := mount.exfat
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := $(exfatmount_src_files)
LOCAL_CFLAGS := $(exfatmount_common_cflags)
LOCAL_C_INCLUDES := $(exfatmount_headers)
LOCAL_SHARED_LIBRARIES := $(exfatmount_common_shared_libraries)

include $(BUILD_EXECUTABLE)
