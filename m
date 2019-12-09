Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E27C116470
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Dec 2019 01:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfLIAit (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 8 Dec 2019 19:38:49 -0500
Received: from mail-mw2nam12on2065.outbound.protection.outlook.com ([40.107.244.65]:11831
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726621AbfLIAis (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 8 Dec 2019 19:38:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MvUxVU6d/LuhDkixJ9m/M1XhRm+xmGcRzX9fYFwfmsKvoPN/GpTObtVjaYGNi21NGrFCobg0ByWxNi4prAERUNGQaKL2HIwbRdRcYHJ5UxlevfUIH1tzBz7lPlJtV3C/2tDD8zKsz986aCT1SPtgQWMOhEUBIbY1RKow8Y26JD29metN85trEuifiAjvZPqUIqCazxJ1JhwndU6o57lvHq0d+gnhLdhzo5HAbHx4cQZ1zsMhJ7SZx+kSDJIsWdwQ9QzH8r5aV1Tlk4AC70/DYW8OA5cwuzOJQ1pqGkuKB7FOLp22YOtgLZkMS2GD+W01KVmogY4x9qmgcZG+fonsEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=At2lW2JuUXT4nfQ4KcnVgQLXprZK7C3FlsfjqXt9Hl0=;
 b=FKf88H0AUOEObEpWUD7bKiv8jBTKclz2wrq+ec/PSHOuQpjdR0wGZ/mDbWuFHSjYjV1ASdqVSFpbzPBGvFzOsuAwMhatP5wxZRiuNHhE8E8CJZ2H1NLASDRxKuNKz98x6JIKceiLXxFtU+AkUI8Y9oZi9C3WCUJ7IcakOzbE8QHWa0PmFaYJBvr7M2PkWUgycwDCfWhDVxpQFb7HBaThlTmdGoWuwiYtZN/87qPReHA0nPmC0rNQUboXrtCptR5nK8pQebQnt4xVIMTs4F1rCuQyTesV63PQy2Kxrv1ZELSWhoQk60pEs2UrHfkt342G24PcIz1fYwg9LC5JFOZVDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=At2lW2JuUXT4nfQ4KcnVgQLXprZK7C3FlsfjqXt9Hl0=;
 b=Jj9tCTh44v/wWeTstGbNEIkzAcQUfgBrMkD1hpBn6tL4HeCDcKDqZkbQv6MdHqvrXJowwLI+XzsOA1DX5Ujcvc7JR/3PaGp0H/VgzzGgn8N9PpkGWxN7fGOfCa+a1eNj5EL5nR6GlJj3VkMsTVha8aurGHJOq4W5FX6B5H0ZlNQ=
Received: from BN7PR08MB5042.namprd08.prod.outlook.com (20.176.177.14) by
 BN7PR08MB4402.namprd08.prod.outlook.com (52.132.223.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Mon, 9 Dec 2019 00:38:38 +0000
Received: from BN7PR08MB5042.namprd08.prod.outlook.com
 ([fe80::48de:9418:73ef:d7c1]) by BN7PR08MB5042.namprd08.prod.outlook.com
 ([fe80::48de:9418:73ef:d7c1%6]) with mapi id 15.20.2516.018; Mon, 9 Dec 2019
 00:38:38 +0000
From:   Jeff LaBundy <jeff@labundy.com>
To:     "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Jeff LaBundy <jeff@labundy.com>
Subject: [PATCH v2 5/7] iio: temperature: Add support for Azoteq IQS620AT
 temperature sensor
Thread-Topic: [PATCH v2 5/7] iio: temperature: Add support for Azoteq IQS620AT
 temperature sensor
Thread-Index: AQHVrij/5ETFITLUl0qPCjPr5iG24Q==
Date:   Mon, 9 Dec 2019 00:38:38 +0000
Message-ID: <1575851866-18919-6-git-send-email-jeff@labundy.com>
References: <1575851866-18919-1-git-send-email-jeff@labundy.com>
In-Reply-To: <1575851866-18919-1-git-send-email-jeff@labundy.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN1PR12CA0082.namprd12.prod.outlook.com
 (2603:10b6:802:21::17) To BN7PR08MB5042.namprd08.prod.outlook.com
 (2603:10b6:408:2c::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jeff@labundy.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [136.49.227.119]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 70edba54-83ed-4a83-d017-08d77c4021b2
x-ms-traffictypediagnostic: BN7PR08MB4402:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR08MB4402869600442EAF6FE5FD78D3580@BN7PR08MB4402.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 02462830BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(34096005)(366004)(136003)(396003)(346002)(39830400003)(199004)(189003)(99286004)(76176011)(71200400001)(52116002)(71190400001)(54906003)(4326008)(2906002)(6512007)(38610400001)(66556008)(66476007)(6486002)(66946007)(586005)(64756008)(66446008)(110136005)(107886003)(36756003)(8936002)(102836004)(50226002)(305945005)(2616005)(7416002)(5660300002)(6506007)(81166006)(81156014)(498600001)(26005)(86362001)(186003)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR08MB4402;H:BN7PR08MB5042.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: labundy.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: df3yyYwG/iDHcM8TO22XDFww0ziy3mBUayyu+CVzs9KF/o8vm0krsyUAoMUeGqldEJ3iAyFfboc1EmI+sIwD6Tl3mI5ygOEbXAJBWpxSYeYhYNo5P1ZJRLlAIPZY2htUKxLSu8ZeJHebTXl6Juirl+Y0Ig+3eYeOQ1fFaHvUbdlDKwJLYUTUejWzUxgrzCdAZSl3QbMJm7eyAu97y+MSdiOjx/x7Pg63s63Zwd8f4ScWCFG0SM9SRvpTLlnF5PXdmHU6QRu+OV4nh+EZOYCQznm4zt/v24Tb9x9qqAX2lOWh0ptXFtPT503yaG1hF0NzKKJNYzvRLg3puqx68Ddbz+RXSLlDM+0OmU5bopAcgvHb3QGAP3e9fmdX0X5sK+C/X/Ezc18bZPRIZVDcLV3T1L1wQnSUB//pB2jcOwFcV8cZ8fh01PSsjf3emUgdSqzy
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70edba54-83ed-4a83-d017-08d77c4021b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2019 00:38:38.3802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UIkHXivHoCCUiEgyRwG5Xxsf3M1cbkCYN2xIHTs4TWGJvVfVT8RP2XRO5ipFZYKgmhH0IIhlWyGmuvGw5mTiMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB4402
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This patch adds support for the Azoteq IQS620AT temperature sensor,
capable of reporting its absolute die temperature.

Signed-off-by: Jeff LaBundy <jeff@labundy.com>
---
Changes in v2:
  - Moved the driver from hwmon to iio
  - Merged 'Copyright' and 'Author' lines into one in introductory comments
  - Replaced 'error' with 'ret' throughout
  - Eliminated tabbed alignment of platform_driver struct members
  - Changed Kconfig "depends on" logic to MFD_IQS62X || COMPILE_TEST

 drivers/iio/temperature/Kconfig         | 10 ++++
 drivers/iio/temperature/Makefile        |  1 +
 drivers/iio/temperature/iqs620at-temp.c | 97 +++++++++++++++++++++++++++++=
++++
 3 files changed, 108 insertions(+)
 create mode 100644 drivers/iio/temperature/iqs620at-temp.c

diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kcon=
fig
index e1ccb40..f1f2a14 100644
--- a/drivers/iio/temperature/Kconfig
+++ b/drivers/iio/temperature/Kconfig
@@ -4,6 +4,16 @@
 #
 menu "Temperature sensors"

+config IQS620AT_TEMP
+	tristate "Azoteq IQS620AT temperature sensor"
+	depends on MFD_IQS62X || COMPILE_TEST
+	help
+	  Say Y here if you want to build support for the Azoteq IQS620AT
+	  temperature sensor.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called iqs620at-temp.
+
 config LTC2983
 	tristate "Analog Devices Multi-Sensor Digital Temperature Measurement Sys=
tem"
 	depends on SPI
diff --git a/drivers/iio/temperature/Makefile b/drivers/iio/temperature/Mak=
efile
index d6b850b..90c1131 100644
--- a/drivers/iio/temperature/Makefile
+++ b/drivers/iio/temperature/Makefile
@@ -3,6 +3,7 @@
 # Makefile for industrial I/O temperature drivers
 #

+obj-$(CONFIG_IQS620AT_TEMP) +=3D iqs620at-temp.o
 obj-$(CONFIG_LTC2983) +=3D ltc2983.o
 obj-$(CONFIG_HID_SENSOR_TEMP) +=3D hid-sensor-temperature.o
 obj-$(CONFIG_MAXIM_THERMOCOUPLE) +=3D maxim_thermocouple.o
diff --git a/drivers/iio/temperature/iqs620at-temp.c b/drivers/iio/temperat=
ure/iqs620at-temp.c
new file mode 100644
index 0000000..d20cb6ad
--- /dev/null
+++ b/drivers/iio/temperature/iqs620at-temp.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Azoteq IQS620AT Temperature Sensor
+ *
+ * Copyright (C) 2019 Jeff LaBundy <jeff@labundy.com>
+ */
+
+#include <linux/device.h>
+#include <linux/iio/iio.h>
+#include <linux/kernel.h>
+#include <linux/mfd/iqs62x.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#define IQS620_TEMP_UI_OUT			0x1A
+
+#define IQS620_TEMP_SCALE			1000
+#define IQS620_TEMP_OFFSET			(-100)
+
+static int iqs620_temp_read_raw(struct iio_dev *indio_dev,
+				struct iio_chan_spec const *chan,
+				int *val, int *val2, long mask)
+{
+	struct iqs62x_core *iqs62x =3D iio_device_get_drvdata(indio_dev);
+	int ret;
+	__le16 val_buf;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret =3D regmap_raw_read(iqs62x->map, IQS620_TEMP_UI_OUT, &val_buf,
+				      sizeof(val_buf));
+		if (ret)
+			return ret;
+
+		*val =3D le16_to_cpu(val_buf);
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		*val =3D IQS620_TEMP_SCALE;
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_OFFSET:
+		*val =3D IQS620_TEMP_OFFSET;
+		return IIO_VAL_INT;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info iqs620_temp_info =3D {
+	.read_raw =3D &iqs620_temp_read_raw,
+};
+
+static const struct iio_chan_spec iqs620_temp_channels[] =3D {
+	{
+		.type =3D IIO_TEMP,
+		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
+				      BIT(IIO_CHAN_INFO_OFFSET),
+	},
+};
+
+static int iqs620_temp_probe(struct platform_device *pdev)
+{
+	struct iqs62x_core *iqs62x =3D dev_get_drvdata(pdev->dev.parent);
+	struct iio_dev *indio_dev;
+
+	indio_dev =3D devm_iio_device_alloc(&pdev->dev, 0);
+	if (!indio_dev)
+		return -ENOMEM;
+
+	iio_device_set_drvdata(indio_dev, iqs62x);
+
+	indio_dev->modes =3D INDIO_DIRECT_MODE;
+	indio_dev->dev.parent =3D &pdev->dev;
+	indio_dev->channels =3D iqs620_temp_channels;
+	indio_dev->num_channels =3D ARRAY_SIZE(iqs620_temp_channels);
+	indio_dev->name =3D iqs62x->dev_desc->dev_name;
+	indio_dev->info =3D &iqs620_temp_info;
+
+	return devm_iio_device_register(&pdev->dev, indio_dev);
+}
+
+static struct platform_driver iqs620_temp_platform_driver =3D {
+	.driver =3D {
+		.name =3D IQS620_DRV_NAME_TEMP,
+	},
+	.probe =3D iqs620_temp_probe,
+};
+module_platform_driver(iqs620_temp_platform_driver);
+
+MODULE_AUTHOR("Jeff LaBundy <jeff@labundy.com>");
+MODULE_DESCRIPTION("Azoteq IQS620AT Temperature Sensor");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" IQS620_DRV_NAME_TEMP);
--
2.7.4

