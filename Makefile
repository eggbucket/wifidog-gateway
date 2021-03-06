include $(TOPDIR)/rules.mk


PKG_NAME:=mywifidog
PKG_VERSION:=$(shell date +%Y%m%d )
PKG_RELEASE=$(PKG_SOURCE_VERSION)

PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)


PKG_FIXUP:=autoreconf
PKG_INSTALL:=1
 
include $(INCLUDE_DIR)/package.mk

define Package/mywifidog
  SUBMENU:=Captive Portals
  SECTION:=net
  CATEGORY:=Network
  DEPENDS:=+kmod-ipt-extra +iptables-mod-extra +kmod-ipt-ipopt +iptables-mod-ipopt +kmod-ipt-nat +iptables-mod-nat +libpthread
  TITLE:=A wireless captive portal solution
  URL:=http://www.wifidog.org
endef

define Package/mywifidog/description
	The Wifidog project is a complete and embeddable captive
	portal solution for wireless community groups or individuals
	who wish to open a free Hotspot while still preventing abuse
	of their Internet connection.
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	$(CP) ./* $(PKG_BUILD_DIR)/
endef

define Package/mywifidog/conffiles
/etc/wifidog.conf
endef

define Package/mywifidog/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/scripts/init.d/wifidog $(1)/usr/bin/wifidog-init
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/wifidog $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/wdctl $(1)/usr/bin/
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libhttpd.so* $(1)/usr/lib/
	$(INSTALL_DIR) $(1)/etc
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/wifidog.conf $(1)/etc/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/wifidog-msg.html $(1)/etc/
	$(INSTALL_DIR) $(1)/etc/init.d
	#$(INSTALL_BIN) ./files/wifidog.init $(1)/etc/init.d/wifidog
endef

$(eval $(call BuildPackage,mywifidog))
