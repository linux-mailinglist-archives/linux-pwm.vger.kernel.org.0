Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD054202729
	for <lists+linux-pwm@lfdr.de>; Sun, 21 Jun 2020 00:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbgFTWnd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 20 Jun 2020 18:43:33 -0400
Received: from mout.gmx.net ([212.227.17.20]:57519 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728113AbgFTWna (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 20 Jun 2020 18:43:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592692952;
        bh=XXu+luCqljJ0m62RlCeT8CmSkmbKkHxcSLuj0ORt69w=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=iNnbYG6+HppRyny7oSDl/zcSixkIlEXLPpZpEPGi3ysfpx7QNmQPi0qppo63xY30w
         ADOgFudvJBvA5CZihzB85TvnZFodxjammv1ZB6PFWOvPOTQMZ1lSDzqMxuofpZUxDl
         U/mgB9Y+o/ZD3COw1SsOYIx4QvYxAa4BNsvY4crw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.186]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MkYbu-1j0qCE0pzS-00m7TV; Sun, 21
 Jun 2020 00:42:32 +0200
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
        Andreas Kemnade <andreas@kemnade.info>
Subject: [RFC PATCH 04/10] mfd: Add base driver for Netronix embedded controller
Date:   Sun, 21 Jun 2020 00:42:15 +0200
Message-Id: <20200620224222.1312520-3-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200620224222.1312520-1-j.neuschaefer@gmx.net>
References: <20200620224222.1312520-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1u+AFOJkIXKhSwfcftLBAxIIIFzLSLtOsHVEPr+WI+ygCv/uTZx
 bP173tXALlMVkmQtxXC3zSy60qVZn2N5fdYQS+pNrKw78Lbqq4x2vINFjsXeXWr3lLN4Arm
 HmrsGAK25Gemm3fdmo1pd6x3Za5nucsZJeUPOJwe6FlcCdYJcNknAYM0KkfuAbKRq0Wbs9l
 5GvBUsY9CW+YIzgQuUS6Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Dd6v43kPPRw=:9CCX267RpV8vvnDACISpr5
 uk8XWpwglolUEoOdfm4ML40ZZQF9MNh0RqPQCdos/fDZbKKFXB73EdN9rxPZQT8ErV1UaAzVz
 FpUEHml2lpxnsR3C5Ayohy6ialKj5tpmolzhUhBX7FUnpFndtdOF+M13RvxJCGSJKPAxynoHw
 UIyKaX5K6gL04zdSHbntQMfewUBSivQ96bWzk+RbPBh8YS5dtG+aqhIMZ2eEGYkhbyWHzBGee
 xh1RWlCs0LgBHrLfjQi8+WTxk2K3Kradtj6H3lVdeNT7TpB0VEs6B/OYg7MLFsyeeGLHO/cLT
 GZ41yJllRiwsjkA47W2M8lvItHEq/k0pO3KZpL4qPGC6Z7u69lotbGGUF04wxyNkK+ws7hkPG
 TWu6k8rubzALTIrcWOShkOd4dKWuOwJ/jjZTSJNySCpMycQyQc0B01Z8b03Re08BUqidFIQ0g
 bSlrWJ9SO5MHLxk407BZd5doNAO2hpdwtgkWjzORyYJ2vcm4ry1Ej7miWLehkA3c6nIK6raUa
 YSbiaz+yNvMs/Hghz1lldY4GrPFkkyvKw3Qhcmd9qscGKrzEPrpZxmiW/6T5rafUYH5xjdwP8
 um+uJubO5QCcoKoYYCuZDfuq10fnsonyqe1J4d10rtmgCYl35EVSjfB8unShhU6GaFfHRgWOi
 GZGbhQhUstTXV0zRoJkekg+4Vwk70aEcpE5zVvsPAvQMfA/09/g/FH3bNvuAeE6H8otGGU7xl
 93Yc2oHYEPoE0VGrKsGep00HRGkr6+wz7dBSMO7hqXrwLrqv12jIGKQv9Cha3the6o+GB/o88
 PNRkkG2Wcv893itk8J6AqGXZegYCkWdZCLksMw+InGUEymU8rb5dj4TWgwGbjli+RsXNZzvc8
 Uk5l9ijLaUJuEfXTcojgJEoGy77UQf7Juj6sdODxD+zPvwTHJUijXSrJKzRMVPGMW27FTNVGs
 bs7bmaMvzh39VNbacb7mL6xNXmBAUcG/dSQ89Pmk6Q4kjbk9k6/7t8YF/e+pzh1Mqsx0JIOgK
 yqLU8lMmSFzmbl0H0dsp4jl2Hh28EMByv8KL4rT3BLgQgTJEzS8XYTNXWdDbHFzbdLHJcPZIh
 etHzCZLWZDlV0a+Kzv9r+FxJ+5QuCAno2wLwiO7rdhbhHS4cYmMr7fJaE9vZO9WUvjLeeorpW
 lPVHChtORF6mfv96pD0PZ9zA+JWd9ZOb+2bppQOUfRJdJ9/hHY7KIGCFNXKCOxbqKJOZsaNJa
 xBH09UDGhk/IHmdu2
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Third-party hardware documentation is available at
https://github.com/neuschaefer/linux/wiki/Netronix-MSP430-embedded-control=
ler

The EC supports interrupts, but the driver doesn't make use of them so
far.

Known problems:
- The reboot handler is installed in such a way that it directly calls
  into the i2c subsystem to send the reboot command to the EC. This
  means that the reboot handler may sleep, which is not allowed.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 drivers/mfd/Kconfig       |   7 ++
 drivers/mfd/Makefile      |   1 +
 drivers/mfd/ntxec.c       | 188 ++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/ntxec.h |  30 ++++++
 4 files changed, 226 insertions(+)
 create mode 100644 drivers/mfd/ntxec.c
 create mode 100644 include/linux/mfd/ntxec.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index a37d7d1713820..78410b928648e 100644
=2D-- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -978,6 +978,13 @@ config MFD_VIPERBOARD
 	  You need to select the mfd cell drivers separately.
 	  The drivers do not support all features the board exposes.

+config MFD_NTXEC
+	bool "Netronix Embedded Controller"
+	depends on I2C && OF
+	help
+	  Say yes here if you want to support the embedded controller of
+	  certain e-book readers designed by the ODM Netronix.
+
 config MFD_RETU
 	tristate "Nokia Retu and Tahvo multi-function device"
 	select MFD_CORE
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 9367a92f795a6..19d9391ed6f32 100644
=2D-- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -218,6 +218,7 @@ obj-$(CONFIG_MFD_INTEL_MSIC)	+=3D intel_msic.o
 obj-$(CONFIG_MFD_INTEL_PMC_BXT)	+=3D intel_pmc_bxt.o
 obj-$(CONFIG_MFD_PALMAS)	+=3D palmas.o
 obj-$(CONFIG_MFD_VIPERBOARD)    +=3D viperboard.o
+obj-$(CONFIG_MFD_NTXEC)		+=3D ntxec.o
 obj-$(CONFIG_MFD_RC5T583)	+=3D rc5t583.o rc5t583-irq.o
 obj-$(CONFIG_MFD_RK808)		+=3D rk808.o
 obj-$(CONFIG_MFD_RN5T618)	+=3D rn5t618.o
diff --git a/drivers/mfd/ntxec.c b/drivers/mfd/ntxec.c
new file mode 100644
index 0000000000000..82adea34ea746
=2D-- /dev/null
+++ b/drivers/mfd/ntxec.c
@@ -0,0 +1,188 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright 2020 Jonathan Neusch=C3=A4fer
+//
+// MFD driver for the usually MSP430-based embedded controller used in ce=
rtain
+// Netronix ebook reader board designs
+
+#include <asm/unaligned.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/i2c.h>
+#include <linux/mfd/ntxec.h>
+#include <linux/of_platform.h>
+#include <linux/pm.h>
+#include <linux/reboot.h>
+#include <linux/types.h>
+
+
+#define NTXEC_VERSION		0x00
+#define NTXEC_POWEROFF		0x50
+#define NTXEC_POWERKEEP		0x70
+#define NTXEC_RESET		0x90
+
+
+/* Register access */
+
+int ntxec_read16(struct ntxec *ec, u8 addr)
+{
+	u8 request[1] =3D { addr };
+	u8 response[2];
+	int res;
+
+	struct i2c_msg msgs[] =3D {
+		{
+			.addr =3D ec->client->addr,
+			.flags =3D ec->client->flags,
+			.len =3D sizeof(request),
+			.buf =3D request
+		}, {
+			.addr =3D ec->client->addr,
+			.flags =3D ec->client->flags | I2C_M_RD,
+			.len =3D sizeof(response),
+			.buf =3D response
+		}
+	};
+
+	res =3D i2c_transfer(ec->client->adapter, msgs, ARRAY_SIZE(msgs));
+	if (res < 0)
+		return res;
+	if (res !=3D ARRAY_SIZE(msgs))
+		return -EIO;
+
+	return get_unaligned_be16(response);
+}
+EXPORT_SYMBOL(ntxec_read16);
+
+int ntxec_write16(struct ntxec *ec, u8 addr, u16 value)
+{
+	u8 request[3] =3D { addr, };
+	int res;
+
+	put_unaligned_be16(value, request + 1);
+
+	res =3D i2c_transfer_buffer_flags(ec->client, request, sizeof(request),
+					ec->client->flags);
+	if (res < 0)
+		return res;
+
+	return 0;
+}
+EXPORT_SYMBOL(ntxec_write16);
+
+int ntxec_read8(struct ntxec *ec, u8 addr)
+{
+	int res =3D ntxec_read16(ec, addr);
+
+	if (res < 0)
+		return res;
+
+	return (res >> 8) & 0xff;
+}
+EXPORT_SYMBOL(ntxec_read8);
+
+int ntxec_write8(struct ntxec *ec, u8 addr, u8 value)
+{
+	return ntxec_write16(ec, addr, value << 8);
+}
+EXPORT_SYMBOL(ntxec_write8);
+
+
+/* Reboot/poweroff handling */
+
+static struct ntxec *poweroff_restart_instance;
+
+static void ntxec_poweroff(void)
+{
+	ntxec_write8(poweroff_restart_instance, NTXEC_POWEROFF, 0x01);
+	msleep(5000);
+}
+
+static int ntxec_restart(struct notifier_block *nb,
+		unsigned long action, void *data)
+{
+	/* FIXME: The I2C driver sleeps, but restart handlers may not sleep */
+	ntxec_write8(poweroff_restart_instance, NTXEC_RESET, 0xff);
+	/* TODO: delay? */
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block ntxec_restart_handler =3D {
+	.notifier_call =3D ntxec_restart,
+	.priority =3D 128
+};
+
+
+/* Driver setup */
+
+static int ntxec_probe(struct i2c_client *client,
+			    const struct i2c_device_id *ids)
+{
+	struct ntxec *ec;
+	int res;
+
+	ec =3D devm_kmalloc(&client->dev, sizeof(*ec), GFP_KERNEL);
+	if (!ec)
+		return -ENOMEM;
+
+	ec->dev =3D &client->dev;
+	ec->client =3D client;
+
+	/* Determine the firmware version */
+	res =3D ntxec_read16(ec, NTXEC_VERSION);
+	if (res < 0) {
+		dev_dbg(ec->dev, "Failed to read firmware version number\n");
+		return res;
+	}
+	ec->version =3D res;
+
+	dev_info(ec->dev,
+		 "Netronix embedded controller version %04x detected.\n",
+		 ec->version);
+
+	/* For now, we don't support the new register layout. */
+	if (ntxec_has_new_layout(ec))
+		return -EOPNOTSUPP;
+
+	if (of_device_is_system_power_controller(ec->dev->of_node)) {
+		/*
+		 * Set the 'powerkeep' bit. This is necessary on some boards
+		 * in order to keep the system running.
+		 */
+		res =3D ntxec_write8(ec, NTXEC_POWERKEEP, 0x08);
+		if (res < 0)
+			return res;
+
+		/* Install poweroff handler */
+		WARN_ON(poweroff_restart_instance);
+		poweroff_restart_instance =3D ec;
+		if (pm_power_off !=3D NULL)
+			/* TODO: Refactor among all poweroff drivers */
+			dev_err(ec->dev, "pm_power_off already assigned\n");
+		else
+			pm_power_off =3D ntxec_poweroff;
+
+		/* Install board reset handler */
+		res =3D register_restart_handler(&ntxec_restart_handler);
+		if (res < 0)
+			dev_err(ec->dev,
+				"Failed to register restart handler: %d\n", res);
+	}
+
+	i2c_set_clientdata(client, ec);
+
+	return devm_of_platform_populate(ec->dev);
+}
+
+static const struct of_device_id of_ntxec_match_table[] =3D {
+	{ .compatible =3D "netronix,ntxec", },
+	{}
+};
+
+static struct i2c_driver ntxec_driver =3D {
+	.driver	=3D {
+		.name	=3D "ntxec",
+		.of_match_table =3D of_ntxec_match_table,
+	},
+	.probe		=3D ntxec_probe,
+};
+builtin_i2c_driver(ntxec_driver);
diff --git a/include/linux/mfd/ntxec.h b/include/linux/mfd/ntxec.h
new file mode 100644
index 0000000000000..9f9d6f2141751
=2D-- /dev/null
+++ b/include/linux/mfd/ntxec.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright 2020 Jonathan Neusch=C3=A4fer
+ *
+ * MFD access functions for the Netronix embedded controller.
+ */
+
+#ifndef NTXEC_H
+#define NTXEC_H
+
+#include <linux/types.h>
+
+struct ntxec {
+	struct device *dev;
+	struct i2c_client *client;
+	u16 version;
+	/* TODO: Add a mutex to protect actions consisting of multiple accesses?=
 */
+};
+
+static inline bool ntxec_has_new_layout(struct ntxec *ec)
+{
+	return ec->version =3D=3D 0xe916;
+}
+
+int ntxec_read16(struct ntxec *ec, u8 addr);
+int ntxec_write16(struct ntxec *ec, u8 addr, u16 value);
+int ntxec_read8(struct ntxec *ec, u8 addr);
+int ntxec_write8(struct ntxec *ec, u8 addr, u8 value);
+
+#endif
=2D-
2.27.0

