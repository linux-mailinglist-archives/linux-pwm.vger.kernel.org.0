Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA5282F02BD
	for <lists+linux-pwm@lfdr.de>; Sat,  9 Jan 2021 19:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbhAISHX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 9 Jan 2021 13:07:23 -0500
Received: from mout.gmx.net ([212.227.15.18]:53667 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbhAISHX (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 9 Jan 2021 13:07:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1610215502;
        bh=Tuw+ZgZ4Kq1PeWeeWse0O4WWhQIH6noWqKgzE61zkGs=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=bOCP+GslRwX4m8cumG51YSJtXjf7QCBOeRUi72FQueIspwYsZmNU9uCrHk9v/CBa2
         FaDAnADGylGYpgESRp1zR4rgZEgMHWzzjYhQTgAYIzT24pLr7APcbJ2+KZwFL/OqaC
         Iigpbmy9i9v+rLF7jYW3GS69hOfN1YNOb348n81c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.57]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MEFvj-1kqIOp20LV-00ACNe; Sat, 09
 Jan 2021 19:05:02 +0100
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
Subject: [PATCH v7 3/7] mfd: Add base driver for Netronix embedded controller
Date:   Sat,  9 Jan 2021 19:02:16 +0100
Message-Id: <20210109180220.121511-4-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210109180220.121511-1-j.neuschaefer@gmx.net>
References: <20210109180220.121511-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:foAsmsgdOWTVSw/YGXc2EruSMnsyjwSVlFx6zJqHEmmTVsft2cm
 yfQgPRN/LxWFvUEvPLkF6DnhMf7PBYWP+y9vCYJi0do+69/7BYePPvw2iCSCTItLsv35qjS
 hFd16QTidEyNTsVPJmja/a0/q3dcFGZRc0AWcYJs6LI+ABSyFxZmrACsCUH33OHAzs/1yK/
 +lH1OO1Kkoi+vZ77NxJjQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:SQ9O/0aZvnQ=:xbrVD/GkkcvZtLsCs/nDs5
 l7oXyzhJhgYh6c8D9dgJko6MfJ+p7JiL6Md6nscLi+YsY+alj+AXHU6lMdrUVD7KUPUmsj9Dn
 U9b3t8w8CZQZ/V8yldEl4IQWyfqSEghZ2Oay4VVOvnss+qn/vJyCKa5Mu5AokGKWXbTiQQhkc
 dwo+vJkLcyP2PQ1OKFVEfEUkCNOdOT872ougp8f6Dqa7MO1f+4bkwkGblHAnNpIrguPPsv8O2
 2gGiGhBjL2Ihx9JHmTjNhhTBAOrKJmXL99vWWxjjvIR57XSzneom+WxYMOKD/tuzbvAwkb+fu
 nrTMgSLxlhyWjNOuoLU0w2XHqjZM/bvRkR5/AO4EWZ2CsOOpkWEkqSBU0CckWgkpnPgNxHHdn
 2n62OZrubD5MPvUFeqFTEdF3H1YEOKyN5oyUF+nUGWFfPmGQfKzjywE/LOLWL28pKmPPy3xqQ
 ekBAUFnnXvqgvM2hjSy71GMBCmi/zWGWo+abM+hGtX3XAiFbsIVroR+ggDRfSmKRDsdvJlAEG
 HuI1Oxvf4W8gOclG9dTrCZHhHuDwuYFwsWYhjmp+A80XRLyAxwk8ghioqjRC2JlmPvvGkV5ea
 7k4wfSiZoswrDvgW1GTsQlUJBPO1PS4hChDqClA7QB5m/ZcsEkn6Yk84kRAC5qapj92r0kjoy
 JEfFGgMLJaRWHnNOnFpZV9yWxTovgQ/QePvMeDieemWrT0txhrGz2uHwSV9I1pqk6ycgb0+IH
 ZmuV2+xO/b8y7h0qcQGCBrRoNQdHWX1gY0dEkirXr7SNYNHUUopoR2yinT7NvHr7tzGMLdYTa
 yBHVsSrYZxgDcRPqB7/RzOPLkTULzx/5YffvuTarbm+u7chDzr4et8svoX5a4VuQ1Yr4jZ5mj
 /epoxKWwvZRw9w7pJXOw==
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The Netronix embedded controller is a microcontroller found in some
e-book readers designed by the original design manufacturer Netronix,
Inc. It contains RTC, battery monitoring, system power management, and
PWM functionality.

This driver implements register access and version detection.

Third-party hardware documentation is available at:

  https://github.com/neuschaefer/linux/wiki/Netronix-MSP430-embedded-contr=
oller

The EC supports interrupts, but the driver doesn't make use of them so
far.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
=2D--
v7:
- Add #define for version number (suggested by Lee Jones).

v6:
- https://lore.kernel.org/lkml/20201208011000.3060239-4-j.neuschaefer@gmx.=
net/
- Add Lee Jones' ACK

v5:
- no changes

v4:
- https://lore.kernel.org/lkml/20201122222739.1455132-4-j.neuschaefer@gmx.=
net/
- include asm/unaligned.h after linux/*
- Use put_unaligned_be16 instead of open-coded big-endian packing
- Clarify that 0x90=3D0xff00 causes an error in downstream kernel too
- Add commas after non-sentinel positions
- ntxec.h: declare structs device and regmap
- Replace WARN_ON usage and add comments to explain errors
- Replace dev_alert with dev_warn when the result isn't handled
- Change subdevice registration error message to dev_err
- Declare ntxec_reg8 as returning __be16
- Restructure version detection code
- Spell out ODM

v3:
- https://lore.kernel.org/lkml/20200924192455.2484005-4-j.neuschaefer@gmx.=
net/
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
 drivers/mfd/Kconfig       |  11 ++
 drivers/mfd/Makefile      |   1 +
 drivers/mfd/ntxec.c       | 216 ++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/ntxec.h |  37 +++++++
 4 files changed, 265 insertions(+)
 create mode 100644 drivers/mfd/ntxec.c
 create mode 100644 include/linux/mfd/ntxec.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index bdfce7b156216..4280bcd47ec7d 100644
=2D-- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -976,6 +976,17 @@ config MFD_VIPERBOARD
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
+	  certain e-book readers designed by the original design manufacturer
+	  Netronix.
+
 config MFD_RETU
 	tristate "Nokia Retu and Tahvo multi-function device"
 	select MFD_CORE
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 14fdb188af022..948a3bf8e3e57 100644
=2D-- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -219,6 +219,7 @@ obj-$(CONFIG_MFD_INTEL_PMC_BXT)	+=3D intel_pmc_bxt.o
 obj-$(CONFIG_MFD_INTEL_PMT)	+=3D intel_pmt.o
 obj-$(CONFIG_MFD_PALMAS)	+=3D palmas.o
 obj-$(CONFIG_MFD_VIPERBOARD)    +=3D viperboard.o
+obj-$(CONFIG_MFD_NTXEC)		+=3D ntxec.o
 obj-$(CONFIG_MFD_RC5T583)	+=3D rc5t583.o rc5t583-irq.o
 obj-$(CONFIG_MFD_RK808)		+=3D rk808.o
 obj-$(CONFIG_MFD_RN5T618)	+=3D rn5t618.o
diff --git a/drivers/mfd/ntxec.c b/drivers/mfd/ntxec.c
new file mode 100644
index 0000000000000..22ed2ef0669cb
=2D-- /dev/null
+++ b/drivers/mfd/ntxec.c
@@ -0,0 +1,216 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * The Netronix embedded controller is a microcontroller found in some
+ * e-book readers designed by the original design manufacturer Netronix, =
Inc.
+ * It contains RTC, battery monitoring, system power management, and PWM
+ * functionality.
+ *
+ * This driver implements register access, version detection, and system
+ * power-off/reset.
+ *
+ * Copyright 2020 Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
+ */
+
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
+#include <asm/unaligned.h>
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
+	u8 buf[3] =3D { NTXEC_REG_POWEROFF };
+	struct i2c_msg msgs[] =3D {
+		{
+			.addr =3D poweroff_restart_client->addr,
+			.flags =3D 0,
+			.len =3D sizeof(buf),
+			.buf =3D buf,
+		},
+	};
+
+	put_unaligned_be16(NTXEC_POWEROFF_VALUE, buf + 1);
+
+	res =3D i2c_transfer(poweroff_restart_client->adapter, msgs, ARRAY_SIZE(=
msgs));
+	if (res < 0)
+		dev_warn(&poweroff_restart_client->dev,
+			 "Failed to power off (err =3D %d)\n", res);
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
+	u8 buf[3] =3D { NTXEC_REG_RESET };
+	/*
+	 * NOTE: The lower half of the reset value is not sent, because sending
+	 * it causes an I2C error. (The reset handler in the downstream driver
+	 * does send the full two-byte value, but doesn't check the result).
+	 */
+	struct i2c_msg msgs[] =3D {
+		{
+			.addr =3D poweroff_restart_client->addr,
+			.flags =3D 0,
+			.len =3D sizeof(buf) - 1,
+			.buf =3D buf,
+		},
+	};
+
+	put_unaligned_be16(NTXEC_RESET_VALUE, buf + 1);
+
+	res =3D i2c_transfer(poweroff_restart_client->adapter, msgs, ARRAY_SIZE(=
msgs));
+	if (res < 0)
+		dev_warn(&poweroff_restart_client->dev,
+			 "Failed to restart (err =3D %d)\n", res);
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block ntxec_restart_handler =3D {
+	.notifier_call =3D ntxec_restart,
+	.priority =3D 128,
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
+
+	/* Bail out if we encounter an unknown firmware version */
+	switch (version) {
+	case NTXEC_VERSION_KOBO_AURA:
+		break;
+	default:
+		dev_err(ec->dev,
+			"Netronix embedded controller version %04x is not supported.\n",
+			version);
+		return -ENODEV;
+	}
+
+	dev_info(ec->dev,
+		 "Netronix embedded controller version %04x detected.\n", version);
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
+		if (poweroff_restart_client)
+			/*
+			 * Another instance of the driver already took
+			 * poweroff/restart duties.
+			 */
+			dev_err(ec->dev, "poweroff_restart_client already assigned\n");
+		else
+			poweroff_restart_client =3D client;
+
+		if (pm_power_off)
+			/* Another driver already registered a poweroff handler. */
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
+		dev_err(ec->dev, "Failed to add subdevices: %d\n", res);
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
index 0000000000000..361204d125f1a
=2D-- /dev/null
+++ b/include/linux/mfd/ntxec.h
@@ -0,0 +1,37 @@
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
+struct device;
+struct regmap;
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
+static inline __be16 ntxec_reg8(u8 value)
+{
+	return value << 8;
+}
+
+/* Known firmware versions */
+#define NTXEC_VERSION_KOBO_AURA	0xd726	/* found in Kobo Aura */
+
+#endif
=2D-
2.29.2

