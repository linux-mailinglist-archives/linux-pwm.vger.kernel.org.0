Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 388C1301F5F
	for <lists+linux-pwm@lfdr.de>; Sun, 24 Jan 2021 23:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbhAXWpp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 24 Jan 2021 17:45:45 -0500
Received: from mout.gmx.net ([212.227.17.21]:54995 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726670AbhAXWp3 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 24 Jan 2021 17:45:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611528190;
        bh=7z3e7eIs2m1EJ3EXPvYoF48skrucAmlDLTA/IAwAyDk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=U7NH4g+qYDcYJsV0aTvUaMmkM4iu+sm5rlYjLRSVE3tcIdgetozjlNhnMwyYLX3Ov
         f3oQSlIGoefso7Q6PTG185J+EXK/2NHJ6T35vDHo1Ja3V+6r2PbXapPFc7phAJ9FIH
         yDCiJqJv2uS4toyQK0wdQgy4xCxiER/Q5KQ5bzoM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.209]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MpDNf-1lmzSr15qR-00qksq; Sun, 24
 Jan 2021 23:43:10 +0100
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
Subject: [PATCH v9 5/7] rtc: New driver for RTC in Netronix embedded controller
Date:   Sun, 24 Jan 2021 22:41:25 +0100
Message-Id: <20210124214127.3631530-6-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210124214127.3631530-1-j.neuschaefer@gmx.net>
References: <20210124214127.3631530-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BZJ7Sf0Z444iOSRedPl9o8dj+dDfs3vkZzwftWwyZPFjO2lsmDu
 lRcS9gPFCWxvfmeB8T822rGSVg/fcOzML0x3UvRP0NvdobiS/7N1/d1KRH7AUr60OZcc58u
 yv0JG+dLc6zOpnchKGXbkIGvzC10Clv6sE6dESQJcVHuBvSVtRUCS1FMAQcYVHFPl5euSgl
 sZEy7w8ZZpy1pkEzcTXHQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:eig9ImzRoBg=:TqY66fqR+tfmfPhxX0kl7p
 c1/ycqAjApPItJq5bjr4CvCVuarRSMH64GrggnBFMtomL+5LHHAEQu7cZVOdFgG0CK1gfUNww
 IfNREz4wauu17o97LwsJrwzW5VrLHgx4YBROnI2E6XbLaBxs8Cak4euvlZixyReEpUPdT9TqQ
 ePBT/cDXpJcllMKsyiUhB7dtjNZmlUAW73mzohn58tldAbDYDrT+oYiMX5TvJWnjOCre0mVtg
 djDpGAVNj/DVPkN967AAD077SbjJbaliEog+ErqVQZ+aPwC8gavc/ccanf6oWPcSw8cvbFySR
 qbNiHfWt/pkF1T4D0VattsaqSlfKconl9wSlDDKYxnptMHX1K7BdH+np0Vk8TdRkxOOHoI4CD
 1RnPcGVyj6V5fWYA0v9o+4enNqycjzPwTGWlBuXKcO43ufvmFzDdfbX6DmzrtDOlTVPeky2e7
 l2ncBFI1MRWQwmRdVujE+aLSu/Ri5UWeoyOr6hcaA5EjM4g7Ko9aCAtsDNrkmJoQEU4Fz37mO
 9TG5jqfMpFR9r0jS0GU9w4yAFT7StBItIe9dGljN3wZcqvxEEPA96O+shmqyQmJGZcmRkuRVR
 LP3t0z65ha7fzSZsWur8nYi4lNOuoNzd2sz00c2Xzheq/6FHjI75ZC8dJVILVJBDgTzEsaFoe
 z+u1tZLs8kaccoh+9o+4PtatD/loTGwdFB2H8QaFu5xuxa+kQ1b/heQIdz7V0GZC/pS1jlxEb
 xQe3EX7mcW9noJ9b++nFakqknOgyHH6FtgOocZNa4atry4Pjdfbq54kxYrUuMOt6OTg0W/RXn
 SqWWPfd+/tqNUbb8Fx5SKLT8IQ5cI9gtaPAvIP71WihT8HTTA2Y5pVk4nQLp9bh4NGNpjoUXN
 +Qe0wECnkPRdXY3jp9Aw==
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
v9:
- no changes

v8:
- https://lore.kernel.org/lkml/20210116194826.3866540-6-j.neuschaefer@gmx.=
net/
- Copy dev.of_node from parent device

v7:
- Adjust to recent RTC API change (rtc_register_device -> devm_rtc_registe=
r_device)

v6:
- no changes

v5:
- Add Alexandre Belloni's A-b
- Use regmap_multi_reg_write

v4:
- Remove "driver" from Kconfig entry for consistency with most other entri=
es
- Add missing MODULE_ALIAS line
- Give NTXEC_REG_READ_ macros longer names
- Solve the read tearing issue using Alexandre Belloni's algorithm
- Solve the write tearing issue using Uwe Kleine-K=C3=B6nig's algorithm
- Spell out ODM

v3:
- Add email address to copyright line
- Remove OF compatible string and don't include linux/of_device.h
- Don't use a comma after sentinels
- Avoid ret |=3D ... pattern
- Move 8-bit register conversion to ntxec.h
- Relicense as GPLv2 or later

v2:
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
 drivers/rtc/rtc-ntxec.c | 145 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 154 insertions(+)
 create mode 100644 drivers/rtc/rtc-ntxec.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 6123f9f4fbc90..d49cf387add14 100644
=2D-- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1315,6 +1315,14 @@ config RTC_DRV_CROS_EC
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
index bb8f319b09fbf..92c26eafe70ce 100644
=2D-- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -110,6 +110,7 @@ obj-$(CONFIG_RTC_DRV_MT7622)	+=3D rtc-mt7622.o
 obj-$(CONFIG_RTC_DRV_MV)	+=3D rtc-mv.o
 obj-$(CONFIG_RTC_DRV_MXC)	+=3D rtc-mxc.o
 obj-$(CONFIG_RTC_DRV_MXC_V2)	+=3D rtc-mxc_v2.o
+obj-$(CONFIG_RTC_DRV_NTXEC)	+=3D rtc-ntxec.o
 obj-$(CONFIG_RTC_DRV_OMAP)	+=3D rtc-omap.o
 obj-$(CONFIG_RTC_DRV_OPAL)	+=3D rtc-opal.o
 obj-$(CONFIG_RTC_DRV_PALMAS)	+=3D rtc-palmas.o
diff --git a/drivers/rtc/rtc-ntxec.c b/drivers/rtc/rtc-ntxec.c
new file mode 100644
index 0000000000000..850ca49186fdc
=2D-- /dev/null
+++ b/drivers/rtc/rtc-ntxec.c
@@ -0,0 +1,145 @@
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
+	pdev->dev.of_node =3D pdev->dev.parent->of_node;
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
+	return devm_rtc_register_device(dev);
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

