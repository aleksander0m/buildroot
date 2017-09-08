################################################################################
#
# modem-manager
#
################################################################################

MODEM_MANAGER_VERSION = master
MODEM_MANAGER_SITE = git://anongit.freedesktop.org/ModemManager/ModemManager
MODEM_MANAGER_LICENSE = GPL-2.0+ (programs, plugins), LGPL-2.0+ (libmm-glib)
MODEM_MANAGER_LICENSE_FILES = COPYING COPYING.LIB
MODEM_MANAGER_DEPENDENCIES = host-pkgconf host-gettext libglib2 libgudev
MODEM_MANAGER_AUTORECONF = YES
MODEM_MANAGER_INSTALL_STAGING = YES

BR_NO_CHECK_HASH_FOR += modem-manager-$(MODEM_MANAGER_VERSION).tar.gz

ifeq ($(BR2_PACKAGE_MODEM_MANAGER_LIBQMI),y)
MODEM_MANAGER_DEPENDENCIES += libqmi
MODEM_MANAGER_CONF_OPTS += --with-qmi
else
MODEM_MANAGER_CONF_OPTS += --without-qmi
endif

ifeq ($(BR2_PACKAGE_MODEM_MANAGER_LIBMBIM),y)
MODEM_MANAGER_DEPENDENCIES += libmbim
MODEM_MANAGER_CONF_OPTS += --with-mbim
else
MODEM_MANAGER_CONF_OPTS += --without-mbim
endif

define MODEM_MANAGER_INSTALL_INIT_SYSV
	$(INSTALL) -m 0755 -D package/modem-manager/S44modem-manager \
		$(TARGET_DIR)/etc/init.d/S44modem-manager
endef

$(eval $(autotools-package))
