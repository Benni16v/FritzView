$(call PKG_INIT_BIN, main)
$(PKG)_SOURCE:=fritzview-$($(PKG)_VERSION).tar.gz
$(PKG)_SITE:=https://github.com/Benni16v/FritzView/archive/refs/heads
$(PKG)_CATEGORY:=Unstable

define $(PKG)_BUILD_CMDS
	$(TARGET_CC) $(TARGET_CFLAGS) -o $($(PKG)_DIR)/native/ax206/ax206_write \
		$($(PKG)_DIR)/native/ax206/ax206_write.c -lusb-1.0
endef

define $(PKG)_INSTALL_TARGET_CMDS
	mkdir -p $($(PKG)_DEST_DIR)/usr/share/fritzview
	cp -a $($(PKG)_DIR)/* $($(PKG)_DEST_DIR)/usr/share/fritzview/
	mkdir -p $($(PKG)_DEST_DIR)/usr/mww
	ln -sf /usr/share/fritzview/webif $($(PKG)_DEST_DIR)/usr/mww/fritzview
endef
