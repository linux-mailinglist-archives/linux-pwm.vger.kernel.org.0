Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C98F42D208C
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Dec 2020 03:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgLHCNK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Dec 2020 21:13:10 -0500
Received: from mout.gmx.net ([212.227.15.18]:34417 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726830AbgLHCNK (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 7 Dec 2020 21:13:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607393457;
        bh=F3QtjZZG93hHA6vRPJKE8IwnWeenHV4ItwEp0aN02oM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=A8pr6+cN7UcqKm8MIbbVL/YVBiqwVGeSWa6NFTB80MWN0i6kwDsAKCnrTL+zb/qhL
         hjiy6KXg2jhbxk38iyIC7Ugnn+0+LWFSEsHcR5SS/tJoiYFUR3Ftz7SkRa/SJGLO/f
         z/DtsZpb4AF5398cMlsLHInROT21twXqofLbxoh8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.214.162]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MjjCL-1kJQMs0Psp-00lDBu; Tue, 08
 Dec 2020 03:10:57 +0100
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
Subject: [PATCH v6 5/7] rtc: New driver for RTC in Netronix embedded controller
Date:   Tue,  8 Dec 2020 02:09:58 +0100
Message-Id: <20201208011000.3060239-6-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201208011000.3060239-1-j.neuschaefer@gmx.net>
References: <20201208011000.3060239-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sht59cd5i0srtO/cpZxBHhJuGkEEFFbVQJvUZwFZz3n/KIHtPvt
 yvetNFklqpjWwZS5aN7V0p+EFevvEjq2r3+buaaHnB0PRmm4PWj3eFRPSTB0FiIqe7fYq8r
 yagYGoU+542qE9GqAjNbpvU6bjTPW/VaK+eH2rnzUnEVlf38WqZ//Zp18Av1xmNUOodVoYQ
 XOnhfDcZiZVjZGRsWxQig==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:bjPLcYvEBSU=:llMiPVdh3HdX1gZn2OzTPV
 LUJlYJKYnyJTRk8UyUNsaan4DanqNXX2vvDCtlf5yGLuyirGzCpiuQXAQanasMpF+dsw1m3J/
 N5xyX4bZoUNuovqn0Bxt/rQrtPMAp9U6QBqdSPOayIj20mjeEK1pCfcEfk14hnm/5seqdiHfs
 nyPwrJWYkp2clq8VL9yk2nG3Kez46lBZdLiPQuUXE93d9le/HZ5rRpViX4U+fUhQEQwGToGIU
 FUetirHt3G6Ln9rs6YMEu6Obw9Tnhso7yOkF1MGrvVJm6TaezI2ikM7YlBRxzbhOy5DDVAW2G
 RtgWDBo87Na9YdtJBGlvIHvsaHKUtHhc4EXQxm/u8674iAolT3p4m5e+eGxuM1VcWiqrDDZKo
 +Y+BJnFdKaSVtKV4+cFd72zkEOYJ7LzrFFXAzDIxvjcVFqHnsoEvNus0Zo4owXhHQwPAsYQ8y
 XOEHIF2QiPWrjnT4l687nhGI/wIKtXkPiu0bjej63LF72GD4bgAFDB5nFf84EDvGuI+dfjrPK
 olRTZEq8eXvOK0ODSFpQeUrWkxBZSjdmoQCKlgleg8bjgUaEsY84Iv0GbcHiI/xTGK45VCq9M
 ueaWovJa3ZmusAiZMO2PgfZrzkPjDzGVkP6lREn2lmhjdjjYu+I9ZGa+qAjTx6ajJVreDOBH9
 UREqEZHRxoWkbnviUD0x4gO68+AiWgkZ60gCRsdvfaC8ODgyzTSdEaMHXTZLwsiGtrjC/67WE
 tkWORYu8Ldb+qHqbRQif9NJ37RKhGu2aOfQO1q3TywGkkygeyQ56OPa1d/c7YCTOIJp5v/oTa
 iXmFzCOCkoNHFX39xMf8XWN/r0FsGiuTNw7LuRWllOdnlC2d7Dbgji08REs11IVb5Qjjs5Q3B
 xa1WZ8toatv1qnHigEfg==
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

With this driver, mainline Linux can keep its time and date in sync with
the vendor kernel.

Advanced functionality like alarm and automatic power-on is not yet
supported.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
=2D--
v6:
- no changes

v5:
- Add Alexandre Belloni's A-b
- Use regmap_multi_reg_write

v4:
- https://lore.kernel.org/lkml/20201122222739.1455132-6-j.neuschaefer@gmx.=
net/
- Remove "driver" from Kconfig entry for consistency with most other entri=
es
- Add missing MODULE_ALIAS line
- Give NTXEC_REG_READ_ macros longer names
- Solve the read tearing issue using Alexandre Belloni's algorithm
- Solve the write tearing issue using Uwe Kleine-K=C3=B6nig's algorithm
- Spell out ODM

v3:
- https://lore.kernel.org/lkml/20200924192455.2484005-6-j.neuschaefer@gmx.=
net/
- Add email address to copyright line
- Remove OF compatible string and don't include linux/of_device.h
- Don't use a comma after sentinels
- Avoid ret |=3D ... pattern
- Move 8-bit register conversion to ntxec.h
- Relicense as GPLv2 or later

v2:
- https://lore.kernel.org/lkml/20200905133230.1014581-7-j.neuschaefer@gmx.=
net/
- Rework top-of-file comment [Lee Jones]
- Sort the #include lines [Alexandre Belloni]
- don't align =3D signs in struct initializers [Uwe Kleine-K=C3=B6nig]
- Switch to regmap
- Fix register number used to read minutes and seconds
- Prefix registers with NTXEC_REG_
- Add help text to the Kconfig option
- Use devm_rtc_allocate_device and rtc_register_device, set ->range_min an=
d ->range_max
=2D--
 drivers/rtc/Kconfig     |   8 +++
 drivers/rtc/Makefile    |   1 +
 drivers/rtc/rtc-ntxec.c | 143 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 152 insertions(+)
 create mode 100644 drivers/rtc/rtc-ntxec.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 65ad9d0b47ab1..fe009949728b3 100644
=2D-- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1311,6 +1311,14 @@ config RTC_DRV_CROS_EC
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-cros-ec.

+config RTC_DRV_NTXEC
+	tristate "Netronix embedded controller RTC"
+	depends on MFD_NTXEC
+	help
+	  Say yes here if you want to support the RTC functionality of the
+	  embedded controller found in certain e-book readers designed by the
+	  original design manufacturer Netronix.
+
 comment "on-CPU RTC drivers"

 config RTC_DRV_ASM9260
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index bfb57464118d0..5f2a7582b2780 100644
=2D-- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -111,6 +111,7 @@ obj-$(CONFIG_RTC_DRV_MT7622)	+=3D rtc-mt7622.o
 obj-$(CONFIG_RTC_DRV_MV)	+=3D rtc-mv.o
 obj-$(CONFIG_RTC_DRV_MXC)	+=3D rtc-mxc.o
 obj-$(CONFIG_RTC_DRV_MXC_V2)	+=3D rtc-mxc_v2.o
+obj-$(CONFIG_RTC_DRV_NTXEC)	+=3D rtc-ntxec.o
 obj-$(CONFIG_RTC_DRV_OMAP)	+=3D rtc-omap.o
 obj-$(CONFIG_RTC_DRV_OPAL)	+=3D rtc-opal.o
 obj-$(CONFIG_RTC_DRV_PALMAS)	+=3D rtc-palmas.o
diff --git a/drivers/rtc/rtc-ntxec.c b/drivers/rtc/rtc-ntxec.c
new file mode 100644
index 0000000000000..c7cff7802895b
=2D-- /dev/null
+++ b/drivers/rtc/rtc-ntxec.c
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * The Netronix embedded controller is a microcontroller found in some
+ * e-book readers designed by the original design manufacturer Netronix, =
Inc.
+ * It contains RTC, battery monitoring, system power management, and PWM
+ * functionality.
+ *
+ * This driver implements access to the RTC time and date.
+ *
+ * Copyright 2020 Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
+ */
+
+#include <linux/mfd/ntxec.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/rtc.h>
+#include <linux/types.h>
+
+struct ntxec_rtc {
+	struct device *dev;
+	struct ntxec *ec;
+};
+
+#define NTXEC_REG_WRITE_YEAR	0x10
+#define NTXEC_REG_WRITE_MONTH	0x11
+#define NTXEC_REG_WRITE_DAY	0x12
+#define NTXEC_REG_WRITE_HOUR	0x13
+#define NTXEC_REG_WRITE_MINUTE	0x14
+#define NTXEC_REG_WRITE_SECOND	0x15
+
+#define NTXEC_REG_READ_YEAR_MONTH	0x20
+#define NTXEC_REG_READ_MDAY_HOUR	0x21
+#define NTXEC_REG_READ_MINUTE_SECOND	0x23
+
+static int ntxec_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct ntxec_rtc *rtc =3D dev_get_drvdata(dev);
+	unsigned int value;
+	int res;
+
+retry:
+	res =3D regmap_read(rtc->ec->regmap, NTXEC_REG_READ_MINUTE_SECOND, &valu=
e);
+	if (res < 0)
+		return res;
+
+	tm->tm_min =3D value >> 8;
+	tm->tm_sec =3D value & 0xff;
+
+	res =3D regmap_read(rtc->ec->regmap, NTXEC_REG_READ_MDAY_HOUR, &value);
+	if (res < 0)
+		return res;
+
+	tm->tm_mday =3D value >> 8;
+	tm->tm_hour =3D value & 0xff;
+
+	res =3D regmap_read(rtc->ec->regmap, NTXEC_REG_READ_YEAR_MONTH, &value);
+	if (res < 0)
+		return res;
+
+	tm->tm_year =3D (value >> 8) + 100;
+	tm->tm_mon =3D (value & 0xff) - 1;
+
+	/*
+	 * Read the minutes/seconds field again. If it changed since the first
+	 * read, we can't assume that the values read so far are consistent,
+	 * and should start from the beginning.
+	 */
+	res =3D regmap_read(rtc->ec->regmap, NTXEC_REG_READ_MINUTE_SECOND, &valu=
e);
+	if (res < 0)
+		return res;
+
+	if (tm->tm_min !=3D value >> 8 || tm->tm_sec !=3D (value & 0xff))
+		goto retry;
+
+	return 0;
+}
+
+static int ntxec_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct ntxec_rtc *rtc =3D dev_get_drvdata(dev);
+
+	/*
+	 * To avoid time overflows while we're writing the full date/time,
+	 * set the seconds field to zero before doing anything else. For the
+	 * next 59 seconds (plus however long it takes until the RTC's next
+	 * update of the second field), the seconds field will not overflow
+	 * into the other fields.
+	 */
+	struct reg_sequence regs[] =3D {
+		{ NTXEC_REG_WRITE_SECOND, ntxec_reg8(0) },
+		{ NTXEC_REG_WRITE_YEAR, ntxec_reg8(tm->tm_year - 100) },
+		{ NTXEC_REG_WRITE_MONTH, ntxec_reg8(tm->tm_mon + 1) },
+		{ NTXEC_REG_WRITE_DAY, ntxec_reg8(tm->tm_mday) },
+		{ NTXEC_REG_WRITE_HOUR, ntxec_reg8(tm->tm_hour) },
+		{ NTXEC_REG_WRITE_MINUTE, ntxec_reg8(tm->tm_min) },
+		{ NTXEC_REG_WRITE_SECOND, ntxec_reg8(tm->tm_sec) },
+	};
+
+	return regmap_multi_reg_write(rtc->ec->regmap, regs, ARRAY_SIZE(regs));
+}
+
+static const struct rtc_class_ops ntxec_rtc_ops =3D {
+	.read_time =3D ntxec_read_time,
+	.set_time =3D ntxec_set_time,
+};
+
+static int ntxec_rtc_probe(struct platform_device *pdev)
+{
+	struct rtc_device *dev;
+	struct ntxec_rtc *rtc;
+
+	rtc =3D devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
+	if (!rtc)
+		return -ENOMEM;
+
+	rtc->dev =3D &pdev->dev;
+	rtc->ec =3D dev_get_drvdata(pdev->dev.parent);
+	platform_set_drvdata(pdev, rtc);
+
+	dev =3D devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(dev))
+		return PTR_ERR(dev);
+
+	dev->ops =3D &ntxec_rtc_ops;
+	dev->range_min =3D RTC_TIMESTAMP_BEGIN_2000;
+	dev->range_max =3D 9025257599LL; /* 2255-12-31 23:59:59 */
+
+	return rtc_register_device(dev);
+}
+
+static struct platform_driver ntxec_rtc_driver =3D {
+	.driver =3D {
+		.name =3D "ntxec-rtc",
+	},
+	.probe =3D ntxec_rtc_probe,
+};
+module_platform_driver(ntxec_rtc_driver);
+
+MODULE_AUTHOR("Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>");
+MODULE_DESCRIPTION("RTC driver for Netronix EC");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:ntxec-rtc");
=2D-
2.29.2

