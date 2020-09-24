Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00910277943
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Sep 2020 21:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbgIXT0t (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 24 Sep 2020 15:26:49 -0400
Received: from mout.gmx.net ([212.227.15.15]:56357 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728733AbgIXT0r (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 24 Sep 2020 15:26:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600975568;
        bh=ryafog9o9EYAigK/QILvakc48q9JWXrf1x8ta4Cd9NE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=PauaGvg+ZaP1l1iygBOq/z2lbo9A0OPi/4BEctJPRszoVsS0vUdIYUEcMQx8ui00m
         wYtVF61MaEf568sVa3DFahuDTOazR9EuRz4W0Lie3TpfC1NkM5QoTaJTuoHm0gUoGj
         BuTPJT3tkRGFmzGutTVjCpuO3dmNxbTYk7tHioec=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.151]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWASe-1jxlbh3XT8-00XesV; Thu, 24
 Sep 2020 21:26:08 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>, allen <allen.chen@ite.com.tw>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Josua Mayer <josua.mayer@jm0.eu>,
        Andreas Kemnade <andreas@kemnade.info>,
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v3 3/7] mfd: Add base driver for Netronix embedded controller
Date:   Thu, 24 Sep 2020 21:24:51 +0200
Message-Id: <20200924192455.2484005-4-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200924192455.2484005-1-j.neuschaefer@gmx.net>
References: <20200924192455.2484005-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2/sqEliv+PQ0uN2Fo4ra2eRrVTl8o/Sf3HWGB8zZ60Z2X3NTHQt
 yeDk+anplblmj7G5BB89xLmR9C23HI+mIvNDa/OcdMixx+J3Nc/Oy4Biyy16X3CGA4cAB5H
 hOePproobbVdyIU8zIyp7QtCD2K08q9+4urGmp5tvD3jPZiEWkQu0ACNogFsYyyQRpJzp8Q
 odoOATePEkLWDVa8xZffA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:j69ta80NZrE=:Ny0rWmCQF7G6B5zUJgwpVi
 h6QNlCb29XBEpAIQl78KC0fKYDD9KlPCf8hwu8ibI4H8CUf7oyWVv90dVJ1xFuUcAkUjPxyAS
 7SyxtreYjV2fVyfS2lAt+WyDvXBm5opYVaT2L07c/ePbJfVlv4o1aBHpgKeEIj8I24UHMLo9n
 cX51XmeyFrCFNpnPk5JuqBr7QkyHX/hB6eU+UWqhwfgcMjfNnpZuAW+Bq4ACbEmkYbOwtcjJB
 2W1mlOyQGtPG1Ns2dXK6XSgqxQpVaWSauHgLh7wk9+Ik7F7/XtV7jsD2UgFnUxKuuh+IMxRVU
 hgk6fp+1nYLWQqq0MinPhsNPgkknwLs4UXoewabFyWcE/0Lg9NeDiJ4jGXuUbnl5sV8e9HYzc
 Qyu0S2Q3D/IdM23tttQFp1UqHEObzQUsCf3IUuODpR8BDtJZmrnCaTJ4vswl/MqICBeYRozZa
 ObXS6sNRmVSjQV0M4a8qKfecaIvrsJOVqxKceMJNuPTeslnudm14sULt1DfQfJ9r1esTTlfic
 o19jOL97uwdsY4SFisDE3fjA8CvTRBwXpCKO9J4cQ8pvFiDZaS1oMtqWsHlkFH1UhhtoCfCI2
 +yHoPyrOdwTEwyQ9qhx7tIFyqhZ6tx0zzwUCFOdVMhus5yaLydxCf5s94GuX9ddez2GTH2IhH
 OPjmkGjoblzXwCVmQZ7XjB85pMy5/4cNQJ9kh5NZF2LgNMPCxI5+8wV9ea5p1Y1CaOlhokqAx
 OFs/YOGZDImRsbQ0xO19I7C66Pm7wf/duyCqA623URiUEzusZWNGdgtLHiBcGQcwHh9xlLZwb
 KmeW8PkFV8ZkCExo+J05A59PBFwFTe5+V6eMs+f445yGH8cMt3tQgIKBlI4xk/vsWXZ1DTHCC
 v0XF6cdMOl8kR/E4UoK3Cck0hZY0SdaPU1pgxoPEe/p0r3t7m1bVPfEdSwCPVH5swBfMLjBac
 AelFL+tKx7C93v9oFexE5YJWclECKpjXB3cmYDHG8qIUo/wQCyNGfW0z+jk5QcN7V/BHHGaTy
 dckX5wQ6LtcwJaRxm99O+K8kWQiMeyjh4U0ukwXbpTBUYFnlDIbNpLFreY675M8iv6UTp05mv
 +JS9Hiu8ggOhMz/SlWK9FdHp/ot7Bp4TlFyWDcUBs88yBMkZ5BOGS0ShWRkXaockHIzyf8uSz
 s59Gj3wms6ICmss15zjbGiFNDvhEyLWmDf/MmTGuWGXWHhHtwDEdYUpQu49n8Jl1yRZapOI0l
 lpDhAABKu8rKfQqkr5uV7BSlozaBlTTIBKCS9Yg==
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The Netronix embedded controller is a microcontroller found in some
e-book readers designed by the ODM Netronix, Inc. It contains RTC,
battery monitoring, system power management, and PWM functionality.

This driver implements register access and version detection.

Third-party hardware documentation is available at:

  https://github.com/neuschaefer/linux/wiki/Netronix-MSP430-embedded-contr=
oller

The EC supports interrupts, but the driver doesn't make use of them so
far.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

v3:
- Add (EC) to CONFIG_MFD_NTXEC prompt
- Relicense as GPLv2 or later
- Add email address to copyright line
- remove empty lines in ntxec_poweroff and ntxec_restart functions
- Split long lines
- Remove 'Install ... handler' comments
- Make naming of struct i2c_client parameter consistent
- Remove struct ntxec_info
- Rework 'depends on' lines in Kconfig, hard-depend on I2C, select REGMAP_=
I2C and
  MFD_CORE
- Register subdevices via mfd_cells
- Move 8-bit register conversion to ntxec.h

v2:
- https://lore.kernel.org/lkml/20200905133230.1014581-4-j.neuschaefer@gmx.=
net/
- Add a description of the device to the patch text
- Unify spelling as 'Netronix embedded controller'.
  'Netronix' is the proper name of the manufacturer, but 'embedded control=
ler'
  is just a label that I have assigned to the device.
- Switch to regmap, avoid regmap use in poweroff and reboot handlers.
  Inspired by cf84dc0bb40f4 ("mfd: rn5t618: Make restart handler atomic sa=
fe")
- Use a list of known-working firmware versions instead of checking for a
  known-incompatible version
- Prefix registers with NTXEC_REG_
- Define register values as constants
- Various style cleanups as suggested by Lee Jones
- Don't align =3D signs in struct initializers [Uwe Kleine-K=C3=B6nig]
- Don't use dev_dbg for an error message
- Explain sleep in poweroff handler
- Remove (struct ntxec).client
- Switch to .probe_new in i2c driver
- Add .remove callback
- Make CONFIG_MFD_NTXEC a tristate option
=2D--
 drivers/mfd/Kconfig       |  10 ++
 drivers/mfd/Makefile      |   1 +
 drivers/mfd/ntxec.c       | 206 ++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/ntxec.h |  31 ++++++
 4 files changed, 248 insertions(+)
 create mode 100644 drivers/mfd/ntxec.c
 create mode 100644 include/linux/mfd/ntxec.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 33df0837ab415..b313103151508 100644
=2D-- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -978,6 +978,16 @@ config MFD_VIPERBOARD
 	  You need to select the mfd cell drivers separately.
 	  The drivers do not support all features the board exposes.

+config MFD_NTXEC
+	tristate "Netronix embedded controller (EC)"
+	depends on OF || COMPILE_TEST
+	depends on I2C
+	select REGMAP_I2C
+	select MFD_CORE
+	help
+	  Say yes here if you want to support the embedded controller found in
+	  certain e-book readers designed by the ODM Netronix.
+
 config MFD_RETU
 	tristate "Nokia Retu and Tahvo multi-function device"
 	select MFD_CORE
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index a60e5f835283e..236a8acd917a0 100644
=2D-- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -217,6 +217,7 @@ obj-$(CONFIG_MFD_INTEL_MSIC)	+=3D intel_msic.o
 obj-$(CONFIG_MFD_INTEL_PMC_BXT)	+=3D intel_pmc_bxt.o
 obj-$(CONFIG_MFD_PALMAS)	+=3D palmas.o
 obj-$(CONFIG_MFD_VIPERBOARD)    +=3D viperboard.o
+obj-$(CONFIG_MFD_NTXEC)		+=3D ntxec.o
 obj-$(CONFIG_MFD_RC5T583)	+=3D rc5t583.o rc5t583-irq.o
 obj-$(CONFIG_MFD_RK808)		+=3D rk808.o
 obj-$(CONFIG_MFD_RN5T618)	+=3D rn5t618.o
diff --git a/drivers/mfd/ntxec.c b/drivers/mfd/ntxec.c
new file mode 100644
index 0000000000000..93611b85a32e0
=2D-- /dev/null
+++ b/drivers/mfd/ntxec.c
@@ -0,0 +1,206 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * The Netronix embedded controller is a microcontroller found in some
+ * e-book readers designed by the ODM Netronix, Inc. It contains RTC,
+ * battery monitoring, system power management, and PWM functionality.
+ *
+ * This driver implements register access, version detection, and system
+ * power-off/reset.
+ *
+ * Copyright 2020 Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
+ */
+
+#include <asm/unaligned.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/i2c.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/ntxec.h>
+#include <linux/module.h>
+#include <linux/pm.h>
+#include <linux/reboot.h>
+#include <linux/regmap.h>
+#include <linux/types.h>
+
+#define NTXEC_REG_VERSION	0x00
+#define NTXEC_REG_POWEROFF	0x50
+#define NTXEC_REG_POWERKEEP	0x70
+#define NTXEC_REG_RESET		0x90
+
+#define NTXEC_POWEROFF_VALUE	0x0100
+#define NTXEC_POWERKEEP_VALUE	0x0800
+#define NTXEC_RESET_VALUE	0xff00
+
+static struct i2c_client *poweroff_restart_client;
+
+static void ntxec_poweroff(void)
+{
+	int res;
+	u8 buf[] =3D {
+		NTXEC_REG_POWEROFF,
+		(NTXEC_POWEROFF_VALUE >> 8) & 0xff,
+		NTXEC_POWEROFF_VALUE & 0xff,
+	};
+	struct i2c_msg msgs[] =3D {
+		{
+			.addr =3D poweroff_restart_client->addr,
+			.flags =3D 0,
+			.len =3D sizeof(buf),
+			.buf =3D buf
+		}
+	};
+
+	res =3D i2c_transfer(poweroff_restart_client->adapter, msgs, ARRAY_SIZE(=
msgs));
+	if (res < 0)
+		dev_alert(&poweroff_restart_client->dev,
+			  "Failed to power off (err =3D %d)\n", res);
+
+	/*
+	 * The time from the register write until the host CPU is powered off
+	 * has been observed to be about 2.5 to 3 seconds. Sleep long enough to
+	 * safely avoid returning from the poweroff handler.
+	 */
+	msleep(5000);
+}
+
+static int ntxec_restart(struct notifier_block *nb,
+			 unsigned long action, void *data)
+{
+	int res;
+	/*
+	 * NOTE: The lower half of the reset value is not sent, because sending
+	 * it causes an error
+	 */
+	u8 buf[] =3D {
+		NTXEC_REG_RESET,
+		(NTXEC_RESET_VALUE >> 8) & 0xff,
+	};
+	struct i2c_msg msgs[] =3D {
+		{
+			.addr =3D poweroff_restart_client->addr,
+			.flags =3D 0,
+			.len =3D sizeof(buf),
+			.buf =3D buf
+		}
+	};
+
+	res =3D i2c_transfer(poweroff_restart_client->adapter, msgs, ARRAY_SIZE(=
msgs));
+	if (res < 0)
+		dev_alert(&poweroff_restart_client->dev,
+			  "Failed to restart (err =3D %d)\n", res);
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block ntxec_restart_handler =3D {
+	.notifier_call =3D ntxec_restart,
+	.priority =3D 128
+};
+
+static const struct regmap_config regmap_config =3D {
+	.name =3D "ntxec",
+	.reg_bits =3D 8,
+	.val_bits =3D 16,
+	.cache_type =3D REGCACHE_NONE,
+	.val_format_endian =3D REGMAP_ENDIAN_BIG,
+};
+
+static const struct mfd_cell ntxec_subdevices[] =3D {
+	{ .name =3D "ntxec-rtc" },
+	{ .name =3D "ntxec-pwm" },
+};
+
+static int ntxec_probe(struct i2c_client *client)
+{
+	struct ntxec *ec;
+	unsigned int version;
+	int res;
+
+	ec =3D devm_kmalloc(&client->dev, sizeof(*ec), GFP_KERNEL);
+	if (!ec)
+		return -ENOMEM;
+
+	ec->dev =3D &client->dev;
+
+	ec->regmap =3D devm_regmap_init_i2c(client, &regmap_config);
+	if (IS_ERR(ec->regmap)) {
+		dev_err(ec->dev, "Failed to set up regmap for device\n");
+		return res;
+	}
+
+	/* Determine the firmware version */
+	res =3D regmap_read(ec->regmap, NTXEC_REG_VERSION, &version);
+	if (res < 0) {
+		dev_err(ec->dev, "Failed to read firmware version number\n");
+		return res;
+	}
+	dev_info(ec->dev,
+		 "Netronix embedded controller version %04x detected.\n",
+		 version);
+
+	/* Bail out if we encounter an unknown firmware version */
+	switch (version) {
+	case 0xd726: /* found in Kobo Aura */
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	if (of_device_is_system_power_controller(ec->dev->of_node)) {
+		/*
+		 * Set the 'powerkeep' bit. This is necessary on some boards
+		 * in order to keep the system running.
+		 */
+		res =3D regmap_write(ec->regmap, NTXEC_REG_POWERKEEP,
+				   NTXEC_POWERKEEP_VALUE);
+		if (res < 0)
+			return res;
+
+		WARN_ON(poweroff_restart_client);
+		poweroff_restart_client =3D client;
+		if (pm_power_off)
+			dev_err(ec->dev, "pm_power_off already assigned\n");
+		else
+			pm_power_off =3D ntxec_poweroff;
+
+		res =3D register_restart_handler(&ntxec_restart_handler);
+		if (res)
+			dev_err(ec->dev,
+				"Failed to register restart handler: %d\n", res);
+	}
+
+	i2c_set_clientdata(client, ec);
+
+	res =3D devm_mfd_add_devices(ec->dev, PLATFORM_DEVID_NONE, ntxec_subdevi=
ces,
+				   ARRAY_SIZE(ntxec_subdevices), NULL, 0, NULL);
+	if (res)
+		dev_warn(ec->dev, "Failed to add subdevices: %d\n", res);
+
+	return res;
+}
+
+static int ntxec_remove(struct i2c_client *client)
+{
+	if (client =3D=3D poweroff_restart_client) {
+		poweroff_restart_client =3D NULL;
+		pm_power_off =3D NULL;
+		unregister_restart_handler(&ntxec_restart_handler);
+	}
+
+	return 0;
+}
+
+static const struct of_device_id of_ntxec_match_table[] =3D {
+	{ .compatible =3D "netronix,ntxec", },
+	{}
+};
+
+static struct i2c_driver ntxec_driver =3D {
+	.driver =3D {
+		.name =3D "ntxec",
+		.of_match_table =3D of_ntxec_match_table,
+	},
+	.probe_new =3D ntxec_probe,
+	.remove =3D ntxec_remove,
+};
+module_i2c_driver(ntxec_driver);
diff --git a/include/linux/mfd/ntxec.h b/include/linux/mfd/ntxec.h
new file mode 100644
index 0000000000000..a39c85978f61b
=2D-- /dev/null
+++ b/include/linux/mfd/ntxec.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright 2020 Jonathan Neusch=C3=A4fer
+ *
+ * Register access and version information for the Netronix embedded
+ * controller.
+ */
+
+#ifndef NTXEC_H
+#define NTXEC_H
+
+#include <linux/types.h>
+
+struct ntxec {
+	struct device *dev;
+	struct regmap *regmap;
+};
+
+/*
+ * Some registers, such as the battery status register (0x41), are in
+ * big-endian, but others only have eight significant bits, which are in =
the
+ * first byte transmitted over I2C (the MSB of the big-endian value).
+ * This convenience function converts an 8-bit value to 16-bit for use in=
 the
+ * second kind of register.
+ */
+static inline u16 ntxec_reg8(u8 value)
+{
+	return value << 8;
+}
+
+#endif
=2D-
2.28.0

