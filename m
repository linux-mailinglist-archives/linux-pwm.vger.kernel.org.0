Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A02B6140205
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Jan 2020 03:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729606AbgAQCgL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 16 Jan 2020 21:36:11 -0500
Received: from mail-mw2nam10on2057.outbound.protection.outlook.com ([40.107.94.57]:40032
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729108AbgAQCgK (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 16 Jan 2020 21:36:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RrRKOvGZdnIJ7O/BPHBdoIHsCW2SIonBxupUya+UToG2qqihyGTBgUl9OK2qq/B5M2fWkhJJ1V1/jGweoq+AjnUd0qaQoYQnB8oxsPeRBJpDlPjZugqs/4+SW+d+RFRSjFeHPj3ouftlJfVxhlILm0bwEyfmXTDB04d5xJuHae72D4xFx1bV2EZlSRggQe5Pjt2H1KmiJrQ7gdpk6EprCYkznHlS18yDQ6knoVU/c1iNs0hWJ7aD+SWOtn5NP0ntSXdZdjf9wBgmczLeRelX/kLp7ARN/at/BgOVPJp62eS1uqNCHYUGZhxMwqWlw7shebTeSrhnJwStiBX9pGyMhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QqNysKbeMYhYyLnwsLIDW9pIlaynVPDLppgjNVXDiG0=;
 b=BnHlNYRthXm26sCvylsWylNjsAa4RMme/rDAvAawb5ABdyjvnTFf+GQIta6yAZ03JvEtyIof8fqldAPVcYpam7rQ40WUk66PdyXoxDJ3ZkEa7zxpSwKyqW3V6JUly2LrVvxZuEm5OR346t5q/EfWnCBC7LGbN5Cq/E7pUkaUlryWTmTxXjwB+m/oD6mEq0D4D2VlIMDOvLas2RM+YZwjawMhV9p02ThN2S6LnHhXLV28E7MDAAUnuZKJxNNKo9Au/NEplszJtDibmN0HZeqPe5t1LnOaxL2x9ZIqThTY79mOpCfjpj3+N+oLy1vdgDxd8Q6mwfr7UM5VgLl0KOiqxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QqNysKbeMYhYyLnwsLIDW9pIlaynVPDLppgjNVXDiG0=;
 b=uCGD0iVdp6QRr/61sp3h9xYwsbXuPeba7bIWQNOcMFbhc0mOkI/Yvk0sRJT199TwlsNZ8aAMA6xH75U8In0OfQhWHbniZInh/0/nSsATsHM6d+j89/+nrCAhxGWEOXhqkPlN6LWRzdW6p9KZEScmp+JOygQCqL9MigLq+c+aztU=
Received: from SN6PR08MB5053.namprd08.prod.outlook.com (52.135.107.153) by
 SN6PR08MB4671.namprd08.prod.outlook.com (52.135.117.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Fri, 17 Jan 2020 02:36:08 +0000
Received: from SN6PR08MB5053.namprd08.prod.outlook.com
 ([fe80::7c80:2b62:5d9a:2139]) by SN6PR08MB5053.namprd08.prod.outlook.com
 ([fe80::7c80:2b62:5d9a:2139%4]) with mapi id 15.20.2644.023; Fri, 17 Jan 2020
 02:36:08 +0000
Received: from localhost.localdomain (136.49.227.119) by SN6PR05CA0010.namprd05.prod.outlook.com (2603:10b6:805:de::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2644.6 via Frontend Transport; Fri, 17 Jan 2020 02:35:58 +0000
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
Subject: [PATCH v4 5/7] iio: temperature: Add support for Azoteq IQS620AT
 temperature sensor
Thread-Topic: [PATCH v4 5/7] iio: temperature: Add support for Azoteq IQS620AT
 temperature sensor
Thread-Index: AQHVzN7fAr6PI6irWkKW3LyZYxsVRQ==
Date:   Fri, 17 Jan 2020 02:36:08 +0000
Message-ID: <1579228475-6681-6-git-send-email-jeff@labundy.com>
References: <1579228475-6681-1-git-send-email-jeff@labundy.com>
In-Reply-To: <1579228475-6681-1-git-send-email-jeff@labundy.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:805:de::23) To SN6PR08MB5053.namprd08.prod.outlook.com
 (2603:10b6:805:78::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jeff@labundy.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [136.49.227.119]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ec03b94-369d-494a-3319-08d79af601a5
x-ms-traffictypediagnostic: SN6PR08MB4671:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR08MB4671CB9E5074A9ABB9F4A879D3310@SN6PR08MB4671.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0285201563
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(34096005)(396003)(136003)(376002)(346002)(366004)(39830400003)(189003)(199004)(64756008)(66946007)(66556008)(66476007)(107886003)(4326008)(69590400006)(2616005)(186003)(956004)(52116002)(66446008)(6506007)(71200400001)(5660300002)(6666004)(16526019)(36756003)(6512007)(7416002)(54906003)(316002)(26005)(508600001)(81166006)(8676002)(6486002)(110136005)(86362001)(2906002)(8936002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR08MB4671;H:SN6PR08MB5053.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: labundy.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nsXDxqrLzWp9ryEyAlnwun8/eoKutn3XseqNidrJAE73wzvDGUGsCAFODxbABCLDaAB2OZ4dkQjI2nlqw+fNgfFl8ubo1Rzsk739gLycIBShc9DNdiDmrXPKzsaSNwB3QKHoNA84uMTKUXMhWwSCQsOCNKYO8ny/JdLwiCnZiHZUZCEqzk3h+7vr7K01sS6qPC4uWdoF9eowu0o6IypuTLlcX9scRZjrNnpfiFB9BX6ED7zYlUVSbrDlskkpTCagUyjQQR0N4esFodVuUvrUZv66C5/LrSHurJamuMBfsI7DXKv/T4kJvOj4rUlhroEVFVtYGRtAxv1dgKtUbdhC6eBNae+pVMZLJbCq1UFmZf8rL9lkR4RDlzLfM4i6q9mhwvSQYRzbEW2s2qmi9Czy8cNIq9yCjfAewoCddlcqgc1EHxdVtyIcmt6O8RkVi/sqUWkJwPK2RCqMNXCsXOLS0qSoFWGdpXHqVo+r3fFfCGmD7qUt3kK244rzg6R2Soud
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ec03b94-369d-494a-3319-08d79af601a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2020 02:36:08.2007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yQb8zZA1IJlvxH6WmchqaGraUjjF8lxQ8gZgi1aBrKwrK7f7MP+P92/MdFBIc4bAWbfXOX9tRJK3MqSV+LiR8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4671
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This patch adds support for the Azoteq IQS620AT temperature sensor,
capable of reporting its absolute die temperature.

Signed-off-by: Jeff LaBundy <jeff@labundy.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
Changes in v4:
  - None

Changes in v3:
  - Added Reviewed-by trailer

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

