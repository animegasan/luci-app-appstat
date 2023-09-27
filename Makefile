# See /LICENSE for more information.
# This is free software, licensed under the GNU General Public License v2.

include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-appstat
PKG_VERSION:=1.0.1-20230928
PKG_MAINTAINER:=<https://github.com/animegasan>

LUCI_TITLE:=LuCI for Application Status in Overview
LUCI_PKGARCH:=all
LUCI_DESCRIPTION:=LuCI support for Application Status in Overview

include $(TOPDIR)/feeds/luci/luci.mk

# call BuildPackage - OpenWrt buildroot signature
