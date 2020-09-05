Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB4F725E873
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Sep 2020 16:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbgIEOql (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 5 Sep 2020 10:46:41 -0400
Received: from mout.gmx.net ([212.227.15.18]:42295 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728608AbgIEOqh (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 5 Sep 2020 10:46:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599317136;
        bh=AmcVqt376Z16SI/dPXXTlsZxd3ygG5eId5RZWTXwmYU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Pbx0pRWtk8XingUiEX6KIelSHcvwYiaIsVxK00GRHfug1crcMICpmL2tilK+lLT+u
         UKKGGoBybLtbZUFeg2oTCOlgeqCpSipSVkRDfbiYRndJeILfHt8vjbDaImxKE8abnP
         jNrK1bnpdZOrORTHoLU18pOn6ZIBBCH/TbfDeSS8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.151]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTiPv-1k8pu63Yvl-00TzFu; Sat, 05
 Sep 2020 16:45:36 +0200
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
Subject: [PATCH v2 08/10] rtc: New driver for RTC in Netronix embedded controller
Date:   Sat,  5 Sep 2020 16:45:00 +0200
Message-Id: <20200905144503.1067124-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200905133230.1014581-1-j.neuschaefer@gmx.net>
References: <20200905133230.1014581-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:s1Iuy0DqF3nvuCeJDEoK6kI2mBJxXiedCE/mjpNaXYYDwjmv37D
 RxR6zMa9OiHI6c3hAO40fXIgiLrCbUToOLmrQxoNxuNVYu5CsOSFv5sh2yR5c8DpscEysJC
 /nYdzmBrKo0DxrcxUpjxHo8yn5AvKv2KxrZCg4floK3I5QMI8c2XBgs4igC0T5OCv0/Kof+
 mUzjOZUPeEP+5QnC6jNGA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:k5hvmOJhwyI=:+r46tjXRikSm3I6GUWoewQ
 0xhx3X2K36hhfQnPz71Z/cx53Z17X9b5AIYFDN4ai2RgLbSzimptqBd+v/ro8zGLXc8sWWWPQ
 OZJ4YfNeh84CpARM7b5CIiHGhEhKJ6QtVcUD2gKetkLx1UEH3oMAUYTyjt1vt/70LYjr2eUtk
 67I9hIO6G3H5kWqODDkiW9GvZaKzHkevT6sSiO++02ZN/5s23BQSZuW6bwoTcXgZ93X1eM00w
 ClpRercLip5iO+8UJM6D1P8bqCPLTPCNLN6Ik1nlPOLpuruUt3NjKcalUqFs81C8M5BeEZHYa
 Osi8W9cPGZ9DnFXRGF2QaN9utrWbOF00PPUToyxKlETZNmxkmn8c8Q8yHxmYkRXZ3AtxJ/Xgd
 gV+V0yxXPVTFCRmPHmLjth73+gC9IehlN5+cNyslShObYTOU7A39Qprf2QNiy6A9gFHKtrwhk
 0L/LIVg8ae5dTQU805D4Favkh+jVJIaqb764EMay/vIyD3P8CcbsNZvxitpaFGa21B/E+U8of
 4kkzJkpt8XsZA8rVIO2J5fH070NKke7hyqNBdZEjg2/xzPQyGDcPUt1sLMgV3HR3bSlCdTT2H
 UHZ1HhVJC/bPOAmDOdbRofVBCVcT2ZPLXwcXGWeqW0F42Dg+TUGiMsIoULl4ZDidt6nt4udU5
 pCY3pWbqENKj74sUK5R7HkMARTTISkDBN7qDimdtoovBh856oWYN/zZKPEtuXXsuw/1kdGe86
 nPLwb+U3IvZOxqLReCOacATYSuOvtr5+KdLK6qoEuPXiQGkVs2IFClj44RItrWSfkLmFB6nbb
 yq9fUdCqPT+6bzjLNCrJXDL0CZ6ZKx+Cq0h76zW+DGDkVR5IKHyH8RBFNltwC4zkD/b2JpDSh
 U+ups9mUU6Bk9OT4CcH4TCBoaPoGiba5wUMlY0GqIkqitYQF8YCGuewkyfsr2NSRbiY9Qf1HD
 A3rMqqSo0A94NbRZdAanCgrFmJFFkdB7FB+eXH9ksw/ZV7IpWrluOFSpM8QOQkpyIO0jcee4q
 MekOd+1QmYzQhOTxD7BRtS5oBk20lCm9PtgABToJvtOGInxw3kUHgQv0+mtZgOeXj4ZY2FiUP
 6EArs2u68+CFKxjQfOwIUAc0EdjBkXTcANodNpVjLy/RwLslcR2FCdg0r1xHbWLdP3X3BWnPU
 0w51GeZHxGcO0T3F3UUTLFbjMKTCFV85NA/E4Pgi1tAjYRlvgQX029LGUpDijsugojzUaG5tY
 QewQHgmGV5mr3Vrle4C3sXQoLicks2tBz4KtDow==
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

With this driver, mainline Linux can keep its time and date in sync with
the vendor kernel.

Advanced functionality like alarm and automatic power-on is not yet
supported.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

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
 drivers/rtc/rtc-ntxec.c | 130 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 139 insertions(+)
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
index 0000000000000..82eb6352353cd
=2D-- /dev/null
+++ b/drivers/rtc/rtc-ntxec.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * The Netronix embedded controller is a microcontroller found in some
+ * e-book readers designed by the ODM Netronix, Inc. It contains RTC,
+ * battery monitoring, system power management, and PWM functionality.
+ *
+ * This driver implements access to the RTC time and date.
+ *
+ * Copyright 2020 Jonathan Neusch=C3=A4fer
+ */
+
+#include <linux/mfd/ntxec.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
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
+/* Convert an 8-bit value into the correct format for writing into a regi=
ster */
+#define u8_to_reg(x) (((x) & 0xff) << 8)
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
+	res |=3D regmap_write(rtc->ec->regmap, NTXEC_REG_WRITE_YEAR, u8_to_reg(t=
m->tm_year - 100));
+	res |=3D regmap_write(rtc->ec->regmap, NTXEC_REG_WRITE_MONTH, u8_to_reg(=
tm->tm_mon + 1));
+	res |=3D regmap_write(rtc->ec->regmap, NTXEC_REG_WRITE_DAY, u8_to_reg(tm=
->tm_mday));
+	res |=3D regmap_write(rtc->ec->regmap, NTXEC_REG_WRITE_HOUR, u8_to_reg(t=
m->tm_hour));
+	res |=3D regmap_write(rtc->ec->regmap, NTXEC_REG_WRITE_MINUTE, u8_to_reg=
(tm->tm_min));
+	res |=3D regmap_write(rtc->ec->regmap, NTXEC_REG_WRITE_SECOND, u8_to_reg=
(tm->tm_sec));
+
+	return (res < 0) ? -EIO : 0;
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
+	dev->range_max =3D RTC_TIMESTAMP_END_2255;
+
+	return rtc_register_device(dev);
+}
+
+static const struct of_device_id ntxec_rtc_of_match[] =3D {
+	{ .compatible =3D "netronix,ntxec-rtc" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ntxec_rtc_of_match);
+
+static struct platform_driver ntxec_rtc_driver =3D {
+	.driver =3D {
+		.name =3D "ntxec-rtc",
+		.of_match_table =3D ntxec_rtc_of_match,
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

