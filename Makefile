THIS_DIR := $(dir $(lastword $(MAKEFILE_LIST)))

ifeq ($(strip $(BRIDGEDOC)),)
    BRIDGEDOC = $(abspath $(THIS_DIR)../../../bridgedoc)
endif

MAIN = system.adoc

include $(BRIDGEDOC)/bridgedoc.mk
