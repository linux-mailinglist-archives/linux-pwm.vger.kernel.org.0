Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBA825E7EB
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Sep 2020 15:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbgIENfF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 5 Sep 2020 09:35:05 -0400
Received: from mout.gmx.net ([212.227.17.21]:38405 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728407AbgIENet (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 5 Sep 2020 09:34:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599312843;
        bh=lFP4+48b1q9wMps2dhvfqju3YXkQySHJhiYh5hsMw8s=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Wge91bLkSC8JeDMRv2xoC7qIr/ccP9aTthWA9Z/RA1ByqkvieReeA2RRMVrpoIBNN
         Jq3/x+3iCZlvr+tTN3FRE3T91dapHwktkOg9Cx/O0v7Cq7iiXPa6EX320kyNnx2Czm
         gteuOJDiciQz4Sz9iIICaUMdRlJXEvDzca/F3AOI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.151]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MnakX-1kxH5C1QLl-00jVm9; Sat, 05
 Sep 2020 15:34:03 +0200
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
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH v2 03/10] mfd: Add base driver for Netronix embedded controller
Date:   Sat,  5 Sep 2020 15:32:23 +0200
Message-Id: <20200905133230.1014581-4-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200905133230.1014581-1-j.neuschaefer@gmx.net>
References: <20200905133230.1014581-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9nyrMwTGKpf8aFfMoAAzhrvimxGgK1Ibt7IlLGUdrACY1CUOER5
 2GSjH+eh6PDU9Iec7TWg/lwHJDr9kUkRIxU4QIXbZ5Ij/ubOVjhFySYN9zcRMiG5svJgC9O
 2bb38VILsliYSS1xPc7zOFZhMKcMvAm6tnY2Cwlbc1kiYnozFVo8vB/qMBf/Wcngcon1aPP
 sudH74a8PDxuVW8o3iMVg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:tcXlN4wr7mI=:NkyhodHlWwhy65wMxx1icg
 MjIRdgKrVnGotYB8jNs+x0SEFFE3EB5RAA9Ya9TLtr8vK2gSQBxt6guFmrtUUmqJWUh5eAvpT
 WBMCWmI09MxjbT1ZbAcNfmumZaoDX215M4fJAWirCVj5+yEEOZspZnV2U8cPLdyJR2zyPJ/Gk
 FgV3DSYkpQiXwZ2d2qdPeLNHgYRyJbNomuP1QOg3NiV2GlpOH+ku4sPPqTUv/U4U2QnBfOVyi
 p2/3DKKZE3c+IQTus5IGA8gC26iTGFlA8w7Hz1Id7oPT7I80v2663Z1HgS/BLDsQGXhoLubJv
 cgKq9NWKxQyXh4ecypi6mN+UQQtlESx+LQvEgegqHj0mig02fgfKbaloWNPLG9DELDB4owNfw
 kK4H2q2erIWVbNTjfZVVqUlNa5m3qT6LVgoo2/dolNopaBmgOrIjO2KTmN0Y/om1U+Dz5wT/o
 i9YRNHjLxLcUTvtQowO8F/+G0MxVDOw0NoX4jStv/MelPWezFJqnbiFeLdnMNn3npPzlXQLzr
 0FimdbaYLmjnJg3Y8b+XTUzRg+6bfURKiSMLjrGHhNTg+XF25Ns6sN1kOaoX+1RseVp5gY8pO
 v6DVKQ7BHePTYbS7L5gumW/KcIYAv5gIcAi6XQFBaDKcQKkW0nHxt0ERDxs3nxATmpBqE0oa+
 wXdoR2ZMZEWgDPh1NzWi9+AXkFvItoCdhvQoeFGwp++J2oC5ZGztzxdlNKwtv3su7Nxv20dG3
 cwRk/53AHHT712hOsZLCpkZDX2wVag3S9GnNh35F9apF/QIz6UbvJkTjDq7IE6iTeseP+h48E
 RBW0x1PPy0Xf0D1SX2eb5N1Y4/FSjBsciA//S3BSGS1jddIfA5Rwvanjq4EE39f4uKRV+jZoJ
 nGcnNLeSgsJLWnSN58HDebwfmHajzyvYc+kniw+OBwksvGU6F2DBOdgI330pjJPXyvadBBJEF
 ry7ZhPCOT3h0fcClSrMVhpDJA2PCGDQj8fUMcAj+t04ANO2/M83Drq9yJ6f9cu/yBCKDCUJJT
 dzkhKwKibheArntmVF8YzRZ9BWWjtcUwS/S6fK4gPITG1ZNGpfLWgnsa6Q6uIVu2PzdLxLIq/
 nLP9PEHD8cjDCkkayNlOMHQfsh0P18s26aYm4RmioytR1896ILph/637feoQzlFdEU/SVFI+F
 0WlF1+Cpu+goFEjskAIm3pq9BIAKgBgCJJJj6jfuQxDt871CY7S+/VjDh9KKfC8e50N5l0YsB
 FNGZlc0ZflJ5RokLud3oaTihbER+DAFOgR4RveA==
Sender: linux-pwm-owner@vger.kernel.org
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

v2:
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
 drivers/mfd/Kconfig       |   7 ++
 drivers/mfd/Makefile      |   1 +
 drivers/mfd/ntxec.c       | 217 ++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/ntxec.h |  24 +++++
 4 files changed, 249 insertions(+)
 create mode 100644 drivers/mfd/ntxec.c
 create mode 100644 include/linux/mfd/ntxec.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 33df0837ab415..bab999081f32d 100644
=2D-- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -978,6 +978,13 @@ config MFD_VIPERBOARD
 	  You need to select the mfd cell drivers separately.
 	  The drivers do not support all features the board exposes.

+config MFD_NTXEC
+	tristate "Netronix embedded controller"
+	depends on I2C && OF
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
index 0000000000000..49cc4fa35b9fe
=2D-- /dev/null
+++ b/drivers/mfd/ntxec.c
@@ -0,0 +1,217 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * The Netronix embedded controller is a microcontroller found in some
+ * e-book readers designed by the ODM Netronix, Inc. It contains RTC,
+ * battery monitoring, system power management, and PWM functionality.
+ *
+ * This driver implements register access, version detection, and system
+ * power-off/reset.
+ *
+ * Copyright 2020 Jonathan Neusch=C3=A4fer
+ */
+
+#include <asm/unaligned.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/i2c.h>
+#include <linux/mfd/ntxec.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
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
+
+	u8 buf[] =3D {
+		NTXEC_REG_POWEROFF,
+		(NTXEC_POWEROFF_VALUE >> 8) & 0xff,
+		NTXEC_POWEROFF_VALUE & 0xff,
+	};
+
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
+
+	if (res < 0)
+		dev_alert(&poweroff_restart_client->dev, "Failed to power off (err =3D =
%d)\n", res);
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
+
+	/*
+	 * NOTE: The lower half of the reset value is not sent, because sending
+	 * it causes an error
+	 */
+	u8 buf[] =3D {
+		NTXEC_REG_RESET,
+		(NTXEC_RESET_VALUE >> 8) & 0xff,
+	};
+
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
+
+	if (res < 0)
+		dev_alert(&poweroff_restart_client->dev, "Failed to restart (err =3D %d=
)\n", res);
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
+static const struct ntxec_info ntxec_known_versions[] =3D {
+	{ 0xd726 }, /* found in Kobo Aura */
+};
+
+static const struct ntxec_info *ntxec_lookup_info(u16 version)
+{
+	int i;
+
+	for (i =3D 0; i < ARRAY_SIZE(ntxec_known_versions); i++) {
+		const struct ntxec_info *info =3D &ntxec_known_versions[i];
+
+		if (info->version =3D=3D version)
+			return info;
+	}
+
+	return NULL;
+}
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
+	ec->info =3D ntxec_lookup_info(version);
+	if (!ec->info)
+		return -EOPNOTSUPP;
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
+		/* Install poweroff handler */
+		WARN_ON(poweroff_restart_client);
+		poweroff_restart_client =3D client;
+		if (pm_power_off)
+			dev_err(ec->dev, "pm_power_off already assigned\n");
+		else
+			pm_power_off =3D ntxec_poweroff;
+
+		/* Install board reset handler */
+		res =3D register_restart_handler(&ntxec_restart_handler);
+		if (res)
+			dev_err(ec->dev,
+				"Failed to register restart handler: %d\n", res);
+	}
+
+	i2c_set_clientdata(client, ec);
+
+	return devm_of_platform_populate(ec->dev);
+}
+
+static int ntxec_remove(struct i2c_client *i2c)
+{
+	if (i2c =3D=3D poweroff_restart_client) {
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
index 0000000000000..65e389af79da6
=2D-- /dev/null
+++ b/include/linux/mfd/ntxec.h
@@ -0,0 +1,24 @@
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
+struct ntxec_info {
+	u16 version;
+};
+
+struct ntxec {
+	struct device *dev;
+	struct regmap *regmap;
+	const struct ntxec_info *info;
+};
+
+#endif
=2D-
2.28.0

