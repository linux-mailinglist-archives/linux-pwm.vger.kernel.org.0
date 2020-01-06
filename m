Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0FF130B11
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Jan 2020 01:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbgAFAso (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 5 Jan 2020 19:48:44 -0500
Received: from mail-bn7nam10on2068.outbound.protection.outlook.com ([40.107.92.68]:6166
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726526AbgAFAso (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 5 Jan 2020 19:48:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jVTitPyFrEGM40veNZneDsB0MhxUrNLqy72Y8rBw3xV9HMhUHaL77MQZWetoyXd1yyyOVRASkJ1CHALzEItCRm1Bx9UE1qRigMNRfHHAN6RZNrsvD8kallHznW9m1POmeqPdkgjjIAtN1s+hO7nc5NzfEdbgefj4Y3+mJJ+WsSUUNNWi2Gl4bAqdCXXpRJ30pQbkGra9p51YVECOV188CjtkI7wMSW2cTKLn8X8DedKCF+8fQi87K/bsUFpcEjhGMaxI5t/Z68pNkXbAZvDh9IfYbygC+nYkV9A7yByEvVaJ92iYMI51VHhy5Z/C229Hq79WGU8rIAkLjjQUVh4aOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/fHvtpsQEIg51WOGAxxBkkGfgR7CRVroD1x+Aj1ffk=;
 b=VEtJFvG1L/x0ZbGQAulCxnbWaweg1t0DWiZlsUDHoqHIvyIdtyJAfA2I0sch7oPEwQ641zBvmQ3qv3Q2AOLqKflkJ1R+lpPcg2gMOHfUr2kNoHx+pxx5F55nNx8XWEOxltUG08zzqHhxTH7b19T0gJgfIRuZht01EGieR9Tp4kQylHxzAjbTILZEym5ZcuqhYhlwUtNWtKqIp/EsugJXanFF17RXGFWBTddMUsRA2GP1rZd7Jk5WlnvGP/RBtAiRat68q9WwVpf3TboSgVBD4tLTopVa+clzIO5uveZV4LmbR6kvZR1iX9WI9cyiiCnuypvqhL+Wm+B5QLxNH/X3Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/fHvtpsQEIg51WOGAxxBkkGfgR7CRVroD1x+Aj1ffk=;
 b=daVVQOBEnFdLfLyTq/ZcLn6icANbLDsu/5Y42vX8gUGVB9wRJiDWPYJxxRBugEODSOdEINH7sp5/v0CnzoP1BHLfLSgfbtzYDBlES/5Q10U+4TEPYJxvtPktV4nqo0u/kF1AVlUooiJMSu10KehQscLj0zs/ek4SFMr4LLwhe2I=
Received: from SN6PR08MB5053.namprd08.prod.outlook.com (52.135.107.153) by
 SN6PR08MB4175.namprd08.prod.outlook.com (52.135.69.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Mon, 6 Jan 2020 00:48:06 +0000
Received: from SN6PR08MB5053.namprd08.prod.outlook.com
 ([fe80::7c80:2b62:5d9a:2139]) by SN6PR08MB5053.namprd08.prod.outlook.com
 ([fe80::7c80:2b62:5d9a:2139%4]) with mapi id 15.20.2602.015; Mon, 6 Jan 2020
 00:48:06 +0000
Received: from localhost.localdomain (136.49.227.119) by SN4PR0701CA0020.namprd07.prod.outlook.com (2603:10b6:803:28::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2602.13 via Frontend Transport; Mon, 6 Jan 2020 00:48:03 +0000
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
Subject: [PATCH v3 5/7] iio: temperature: Add support for Azoteq IQS620AT
 temperature sensor
Thread-Topic: [PATCH v3 5/7] iio: temperature: Add support for Azoteq IQS620AT
 temperature sensor
Thread-Index: AQHVxCrzaUNk+i1RRk+ClxiQZe1edw==
Date:   Mon, 6 Jan 2020 00:48:03 +0000
Message-ID: <1578271620-2159-6-git-send-email-jeff@labundy.com>
References: <1578271620-2159-1-git-send-email-jeff@labundy.com>
In-Reply-To: <1578271620-2159-1-git-send-email-jeff@labundy.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0701CA0020.namprd07.prod.outlook.com
 (2603:10b6:803:28::30) To SN6PR08MB5053.namprd08.prod.outlook.com
 (2603:10b6:805:78::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jeff@labundy.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [136.49.227.119]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7999fc40-a38b-4ed7-d6c4-08d792421658
x-ms-traffictypediagnostic: SN6PR08MB4175:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR08MB4175E623964CDA457592EEF4D33C0@SN6PR08MB4175.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0274272F87
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39830400003)(136003)(376002)(346002)(34096005)(199004)(189003)(36756003)(107886003)(2616005)(956004)(316002)(69590400006)(5660300002)(86362001)(6486002)(508600001)(2906002)(4326008)(6506007)(81166006)(110136005)(6512007)(54906003)(16526019)(26005)(8676002)(186003)(7416002)(8936002)(66476007)(71200400001)(52116002)(66946007)(66446008)(66556008)(64756008)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR08MB4175;H:SN6PR08MB5053.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: labundy.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +ePViaqf+L2cSYnoVlx+08BQOBKvknmuJsT8ay1i5mfRPGmkq97ujuC6pE7iqYpvnFHv27OkL6U+OsCCxQIRZnOUeb+kAaMav62EJeiZ9Em4tMBeIUDm8WzK8Fiujwlvd1cfx/UsuoVw9U9rVETAlmkKggYL/1NK77+p5KWo0O9cvRWi4eip0bEgFiAZVTvuK1u6LCHfvi2XhRDhiUKgo9WotrvasRK5Z0oRVsRD/Gr3MdJu4fNJOb5FHgcIPkNHVxh6X1mUAmLo3pN5aywn2ikWfJ/L9O83lQajD9Hth0V1im92k9dBKBsjNfz73wk1F7tHtu8NLgrA3o5FeECUN6oWDDD8a3TA/sDqFJcFLuNemKvOKRNsc1xn/poOydOs9mu8dpewDk59YY5DM7PCwCaVrNlcK/8Iv29075kGSwibeLBvt8OVzw6GlVHvh09D3xTHh4U0xf2e/m4BdreNh1xg82nv5YEQKPHQehNj7xI4ZT22q2zniHN/5gMh65JD
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7999fc40-a38b-4ed7-d6c4-08d792421658
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2020 00:48:04.0310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pWz2hJt23eGz/dhu9EH7wuVYt8ieEMIbyUTsd3RGfxAbLKr04IiEMuBYeBaOg6Q5rrfoGz17JyNtFPTN0ScsdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4175
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This patch adds support for the Azoteq IQS620AT temperature sensor,
capable of reporting its absolute die temperature.

Signed-off-by: Jeff LaBundy <jeff@labundy.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
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

