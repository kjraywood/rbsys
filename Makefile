THIS_DIR := $(dir $(lastword $(MAKEFILE_LIST)))
PARENT_DIR := $(abspath $(THIS_DIR)/..)

MAIN = system.adoc
INSTALL_DIR = $(PARENT_DIR)/web/rbsys
BRIDGEDOC_DIR = $(PARENT_DIR)/bridgedoc

include $(BRIDGEDOC_DIR)/bridgedoc.mk
