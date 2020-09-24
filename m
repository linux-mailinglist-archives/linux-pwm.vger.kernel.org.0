Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16FD227794B
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Sep 2020 21:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbgIXT17 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 24 Sep 2020 15:27:59 -0400
Received: from mout.gmx.net ([212.227.15.18]:33833 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728758AbgIXT17 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 24 Sep 2020 15:27:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600975618;
        bh=zSDHJBM6de05hZPfx230oe82AjsNdZNJxFzhYwgfDFE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=YCZuTDlO6lrqRKblbacCMKYxMjIts9jb1hdPbo7ll72ct3UszOjFfxuhsx0MVDYzc
         PCnWHUFLBDkJ9i4+9TNGhtKuU3TIfAKv9/UsH4L74e1HSTjq3ZcJFzObxh7LSEI69o
         1zSfWfSLAkAah0TiIqKbYXoPw3xyfDYypD1ktDd8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.151]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M5QJD-1kKhwl2ASb-001UUX; Thu, 24
 Sep 2020 21:26:58 +0200
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
Subject: [PATCH v3 5/7] rtc: New driver for RTC in Netronix embedded controller
Date:   Thu, 24 Sep 2020 21:24:53 +0200
Message-Id: <20200924192455.2484005-6-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200924192455.2484005-1-j.neuschaefer@gmx.net>
References: <20200924192455.2484005-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+L1FJx1oQ6x7VaPQrKFafs4nq4JlwRFRv3sXkEEUwJWc0oPbt6L
 sSRCF1xO+U7ERbK4pZtzhg8y0/pV9YuUf1GfIKaUrFSt7xB6hSc5TTn5zO64GdDfSKgfHPn
 IV6Tb28pfgTVdctL+InU5U3ktU8xEW2j/bBb4OWv0dLpxXhDooD70jkp7g0LkNAzqwVeXzB
 3iZa0jhjuoz5LvJ9oIDEA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:iW/DyQ1umCw=:OXkRLwVhupzITPyaadNByY
 DNzWrDCUOgfWuRGBNdXuC7L/Pu9Fgj4AcowCxscdAQHQlXO4Ylhf39QyifLje/XLyTeHRYv6K
 kL/WOkr/3COkS7B40qgzZWPeef0xVBVeUZQdqGGvnDP7U0wsmGJUcDEiuWPRKgY61cPzmL72h
 klVt5x6mNy13eVmXTPqWXXWxPHak5ZvJ1uHCF8qYOTCieJ5S0VlVauLfUO9DsyueDG/52iAlg
 sta2KoEBXFcgrPiOsSe5Wj2E4ObiGHVwau+42eRKhSded+/3RMKrb2PmYp+i+3VvQq4borxJK
 OzzpCW6uPU7AYUJ+f2xxOHaI16w9hT/VuBDlMiLsDfU5MDvPcaa7VsPog/lBnwTxHlnInl6bV
 9cJk0Oef6Y5m1RQO5dHjMLY33g+qbK4eGf/zJ/+dJ0njVctgs1W3Jjemo7x27d+lN3fkuEZrK
 b7qoeL2XsMK0BIqid6qgld2y5ft6LfGgALDli8ef5S1q+nq5JSvgZbnWHWzde7f0UBPicBvxa
 MBHX6ZrthQGrH+2R0lmHPwOgD96CzWusaWUKQUTzj4tFrXULvgjEk8EOgd1HzlUEV81/soqiP
 L3bLwUIfC6hjgN5XKnmNWqraMQjeu3ugMcpwRkvHYMfILqIiyTJSzQj/bLV7rVSNLjdGftlT1
 31DKj8Z9i5Y0dLv244NTZqcxTOZXD0bTOfOjk9ct86iBIbIN6i2Uy9zMwG1dRhT6QPS7GKrqd
 EfVPnJIYUZW46UJZYFKaS4FIA41T4E2X1s+q9J8DTfZkykuLXKugo9YxqBUCGZZg1U7DYVHu9
 ioGJ7AR4bni0Sl0FpoX01jf8fZiifA4lJJ7iCaWvPHTTHNMOk7+E4T3aC7RzmAwA6iAxqCziY
 GzVY+5BT2T2JUXdpow33XFgsiwXxYzMyUE6uQbVQaKToiI4qWl9vNGqF7IYqoMsHBPRYLyNBP
 I3cJaM8GiDkR4JQbbwjQQ/7+NZHONOpl+s5dDEme/kOVKbuOhj6Sq3OKZ35M+Lb3va7RQIOoH
 Q/rT1NruFoORXrTjZZr3hTiw5ZZd25YvwgeJshot2kqy7e7kNg+99GFywmPMUy/G8BWqEMDM2
 D9k5fhuiTO685aIKlbUymllYcz5UD2tn1++o1+uFJ/oVyZAZvIMI0sptUfq7riPIQCbYF0zk0
 63fpC1EAHiz4UfF6kC/rDjMMCTyAqUudmg+0xCFY1og0YL+kdyPJIu5iS2HDMyNRF/LzVz1wW
 KSngbCpA0/IdPFdAtYS/sNvrb3k8TVDz8hpMsFw==
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

With this driver, mainline Linux can keep its time and date in sync with
the vendor kernel.

Advanced functionality like alarm and automatic power-on is not yet
supported.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

v3:
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
 drivers/rtc/rtc-ntxec.c | 132 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 141 insertions(+)
 create mode 100644 drivers/rtc/rtc-ntxec.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 48c536acd777f..ae8f3dc36c9a3 100644
=2D-- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1301,6 +1301,14 @@ config RTC_DRV_CROS_EC
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-cros-ec.

+config RTC_DRV_NTXEC
+	tristate "Netronix embedded controller RTC driver"
+	depends on MFD_NTXEC
+	help
+	  Say yes here if you want to support the RTC functionality of the
+	  embedded controller found in certain e-book readers designed by the
+	  ODM Netronix.
+
 comment "on-CPU RTC drivers"

 config RTC_DRV_ASM9260
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 880e08a409c3d..733479db18896 100644
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
index 0000000000000..af23c7cc76544
=2D-- /dev/null
+++ b/drivers/rtc/rtc-ntxec.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * The Netronix embedded controller is a microcontroller found in some
+ * e-book readers designed by the ODM Netronix, Inc. It contains RTC,
+ * battery monitoring, system power management, and PWM functionality.
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
+#define NTXEC_REG_READ_YM	0x20
+#define NTXEC_REG_READ_DH	0x21
+#define NTXEC_REG_READ_MS	0x23
+
+static int ntxec_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct ntxec_rtc *rtc =3D dev_get_drvdata(dev);
+	unsigned int value;
+	int res;
+
+	res =3D regmap_read(rtc->ec->regmap, NTXEC_REG_READ_YM, &value);
+	if (res < 0)
+		return res;
+
+	tm->tm_year =3D (value >> 8) + 100;
+	tm->tm_mon =3D (value & 0xff) - 1;
+
+	res =3D regmap_read(rtc->ec->regmap, NTXEC_REG_READ_DH, &value);
+	if (res < 0)
+		return res;
+
+	tm->tm_mday =3D value >> 8;
+	tm->tm_hour =3D value & 0xff;
+
+	res =3D regmap_read(rtc->ec->regmap, NTXEC_REG_READ_MS, &value);
+	if (res < 0)
+		return res;
+
+	tm->tm_min =3D value >> 8;
+	tm->tm_sec =3D value & 0xff;
+
+	return 0;
+}
+
+static int ntxec_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct ntxec_rtc *rtc =3D dev_get_drvdata(dev);
+	int res =3D 0;
+
+	res =3D regmap_write(rtc->ec->regmap, NTXEC_REG_WRITE_YEAR, ntxec_reg8(t=
m->tm_year - 100));
+	if (res)
+		return res;
+
+	res =3D regmap_write(rtc->ec->regmap, NTXEC_REG_WRITE_MONTH, ntxec_reg8(=
tm->tm_mon + 1));
+	if (res)
+		return res;
+
+	res =3D regmap_write(rtc->ec->regmap, NTXEC_REG_WRITE_DAY, ntxec_reg8(tm=
->tm_mday));
+	if (res)
+		return res;
+
+	res =3D regmap_write(rtc->ec->regmap, NTXEC_REG_WRITE_HOUR, ntxec_reg8(t=
m->tm_hour));
+	if (res)
+		return res;
+
+	res =3D regmap_write(rtc->ec->regmap, NTXEC_REG_WRITE_MINUTE, ntxec_reg8=
(tm->tm_min));
+	if (res)
+		return res;
+
+	return regmap_write(rtc->ec->regmap, NTXEC_REG_WRITE_SECOND, ntxec_reg8(=
tm->tm_sec));
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
=2D-
2.28.0

