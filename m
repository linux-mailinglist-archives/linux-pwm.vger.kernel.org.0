Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3FC2202727
	for <lists+linux-pwm@lfdr.de>; Sun, 21 Jun 2020 00:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbgFTWna (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 20 Jun 2020 18:43:30 -0400
Received: from mout.gmx.net ([212.227.17.22]:40633 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728401AbgFTWn3 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 20 Jun 2020 18:43:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592692962;
        bh=SJkG9V9Ioa9d4mEs8B+Ts1mrBz/DoBrNbjbG0YqcoW8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=L0TS6ZsL9wzNE0nZD/qm5ZJjxYPd9mb0bHz+Wc89GxEVngTEO1oEtUnBDPVvqWDSW
         utlwhk8cyNqJfnConKj8VnRLNbAfPwQZqnawGcKdQqeFVaDWjUrjK7rrApjllI0D3p
         O3UGHr8naeDiHytOMobzDZmzy8GMBiHrY6pwXuwk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.186]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1wll-1ilEJH1IF7-012Gjq; Sun, 21
 Jun 2020 00:42:42 +0200
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
Subject: [RFC PATCH 08/10] rtc: New driver for RTC in Netronix embedded controller
Date:   Sun, 21 Jun 2020 00:42:19 +0200
Message-Id: <20200620224222.1312520-7-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200620224222.1312520-1-j.neuschaefer@gmx.net>
References: <20200620224222.1312520-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZySx5t2KwCOIhxVvsNRQk0BHTuvPhh9i+aJrLHsgVrp4vASHns/
 K/Sng6XDPFxIADTuQhRqPpAiIQTxA/wGOa2PSbQbB4sTuJ0aojUJGE8Ag92fPQLXO9nJD6G
 QLoS+fsnoA5cMrwfz9npyau2UOADYu9551W2HpisS3/JZwVYAkM5yt+jitcvhvxSNHOoB3r
 YTQOJ2gOZPtscWai0xOvQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qUgUBIrzrMw=:9fm4eUEqTt5MBiuFfEhduT
 mWFDkntqpgEtUv2Z+wMPuN4r6bAeq4tndR38mrmzCTTwLZB0Bno3n8/u/bYcNzbzPW7js1XHK
 IH0+7IJFAo8/zNkJueuIs2Vm5K4HlDYNbSYdeuZWeiyeHGQJrnlTjqxQpaeQpKgGUsFi+uD6m
 9Bo5bpxpM+l8enZ8zhHQak2cDovMNvBpPButuelU02VA9txy2JesT0BiCHjVezk6zEYs06tPp
 64+TFHcukjJBVKgBGAbDcY9pmRVV2nebwkJPRsOym1se7tp8pE2rcl0h8b5m3lyvx4Au3ymqI
 aywGleTVEctLo2I17590XnBgKJ9AMqT0hex7+F4ksL0KL0KBecxuNZfTOMgjqWMcBXhsi7ZLd
 WM7y8jYuqrIlRp6Lnx0xvzh06TpAhJ4RjsESjmxksmj0uIKsMMwKy4UAPmY+AfBG59ABCTSgF
 W0Ibt/Rj7q6q1EqWOCZQRpPo7NZYmmNFT9W/5LUqPjCZaSe9gtWVlbE0uaJsikLno8UESeCIj
 YpMuokn3nRJl3P96FPGYYAIIDesCD+zukBOBbMCIpz67yrL00VEvdVCAO9Xb0H4dzjFkbUltM
 q3NUyH0qYR7hKkuZdzXvNm2BWzGd5NY7wvH1U0VvjTieArI5kK2wzKvdNCuMUzPizgkrBzuBr
 lfQpEoOHXG+S1di3VAODVLI1OfETY6qkhihTLJxFAxwQXcToKgWd8fG5WgvBH/zYKDNenF6uz
 N6SL36afGnNQyz2ZWH4V3XgYysSE3xrxVpJqEHhLGb10h7iA5cXsqc4w7OIJDw1pb/Wl/2r/Z
 8Q+eGujEiDuRBivpi2Cz1mpICTIOQs30isN5H6gO73nZOV2Bp8oTCCBrRVv4RJ7HqFf3VmR5g
 QEJ8aA8sej17imekBzYUVZecSxj8fHMUAqp5Oppdjlt3Hm5ciaR211/cKwzJx2Nt28jA4rnPP
 GK5hbGIXWMeKvBD0o8p+szrDJtPl+u+cH80iRBr8jJ+PA/3Q5QGZ660fK6hjyEb16NG22QKVP
 L/ECG3hvFjnJdNMaNEpqNriFUDIsWnGaW1J5qp3ugwvB5F4zU5R1NTJGAWdbN2r5o1BjNABnH
 cwybOOoZixgQqd50QSyGd2l4h3JcHriVwhM+qV3h9yKHVwkp74WsYomw9NMRgSDY3RMzOMMJP
 S6uvfUe03QAQM/EL+X7vKcQ1HWp91d21pH3T7c2goOl7w0GVtcclM4l3ke8BskRkHXeih4Yqh
 PA7OqZbtxvORAmFOC
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
 drivers/rtc/Kconfig     |   4 ++
 drivers/rtc/Makefile    |   1 +
 drivers/rtc/rtc-ntxec.c | 115 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 120 insertions(+)
 create mode 100644 drivers/rtc/rtc-ntxec.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index b54d87d45c89b..2310d08933f9c 100644
=2D-- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1300,6 +1300,10 @@ config RTC_DRV_CROS_EC
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-cros-ec.

+config RTC_DRV_NTXEC
+	tristate "Netronix embedded controller RTC driver"
+	depends on MFD_NTXEC
+
 comment "on-CPU RTC drivers"

 config RTC_DRV_ASM9260
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 0721752c6ed4c..8653d04aefa99 100644
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
index 0000000000000..44d5a5eedb597
=2D-- /dev/null
+++ b/drivers/rtc/rtc-ntxec.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright 2020 Jonathan Neusch=C3=A4fer
+
+#include <linux/rtc.h>
+#include <linux/mfd/ntxec.h>
+#include <linux/platform_device.h>
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+
+struct ntxec_rtc {
+	struct device *dev;
+	struct ntxec *ec;
+};
+
+#define NTXEC_WRITE_YEAR	0x10
+#define NTXEC_WRITE_MONTH	0x11
+#define NTXEC_WRITE_DAY		0x12
+#define NTXEC_WRITE_HOUR	0x13
+#define NTXEC_WRITE_MINUTE	0x14
+#define NTXEC_WRITE_SECOND	0x15
+
+#define NTXEC_READ_YM		0x20
+#define NTXEC_READ_DH		0x21
+#define NTXEC_READ_MS		0x22
+
+
+static int ntxec_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct ntxec_rtc *rtc =3D dev_get_drvdata(dev);
+	int res;
+
+	res =3D ntxec_read16(rtc->ec, NTXEC_READ_YM);
+	if (res < 0)
+		return res;
+
+	tm->tm_year =3D (res >> 8) + 100;
+	tm->tm_mon =3D (res & 0xff) - 1;
+
+	res =3D ntxec_read16(rtc->ec, NTXEC_READ_DH);
+	if (res < 0)
+		return res;
+
+	tm->tm_mday =3D res >> 8;
+	tm->tm_hour =3D res & 0xff;
+
+	res =3D ntxec_read16(rtc->ec, NTXEC_READ_MS);
+	if (res < 0)
+		return res;
+
+	tm->tm_min =3D res >> 8;
+	tm->tm_sec =3D res & 0xff;
+
+	return 0;
+}
+
+static int ntxec_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct ntxec_rtc *rtc =3D dev_get_drvdata(dev);
+	int res =3D 0;
+
+	res |=3D ntxec_write8(rtc->ec, NTXEC_WRITE_YEAR, tm->tm_year - 100);
+	res |=3D ntxec_write8(rtc->ec, NTXEC_WRITE_MONTH, tm->tm_mon + 1);
+	res |=3D ntxec_write8(rtc->ec, NTXEC_WRITE_DAY, tm->tm_mday);
+	res |=3D ntxec_write8(rtc->ec, NTXEC_WRITE_HOUR, tm->tm_hour);
+	res |=3D ntxec_write8(rtc->ec, NTXEC_WRITE_MINUTE, tm->tm_min);
+	res |=3D ntxec_write8(rtc->ec, NTXEC_WRITE_SECOND, tm->tm_sec);
+
+	return (res < 0)? -EIO : 0;
+}
+
+static const struct rtc_class_ops ntxec_rtc_ops =3D {
+	.read_time		=3D ntxec_read_time,
+	.set_time		=3D ntxec_set_time,
+};
+
+static int ntxec_rtc_probe(struct platform_device *pdev)
+{
+	struct rtc_device *rtcdev;
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
+	rtcdev =3D devm_rtc_device_register(&pdev->dev, "ntxec-rtc",
+					  &ntxec_rtc_ops, THIS_MODULE);
+	if (IS_ERR(rtcdev))
+		return PTR_ERR(rtc);
+
+	return 0;
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
2.27.0

