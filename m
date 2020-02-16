Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A06316074D
	for <lists+linux-pwm@lfdr.de>; Mon, 17 Feb 2020 00:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbgBPXdC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 16 Feb 2020 18:33:02 -0500
Received: from mail-dm6nam12on2066.outbound.protection.outlook.com ([40.107.243.66]:6039
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727772AbgBPXdB (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 16 Feb 2020 18:33:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CKo/M6bGh++zYusqa/yjG2B7x9rlgA0qFSk4msslBg7TE/3cVYhb7ZAd/HlIRTi5EVmoTGHJk8E+qS9JJ+Iw++bv5X5+i9GuAHmnJRvRuLy6CcnmHJJWxDR6HGfJ9hQIuW4n8Ips1aorOwF+9jr+tDO8Bev353hCeMaRMC1fPrclT0gbmu7o4oZG+c8fqGsCUA1Xm+YXeabF0HiUHYx/l0ZOY2mnfzE3sMNVL65D2NUQb25gEEp57Crw7Kl7EFrnOuPEqYJBNumzrer6n5Zq7Dj7fQhXO4w94buvtZfH1NOSW5dtoaAv55DriIFmutgKNurp1eI6tXj/obPrklyHEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3/FsqTrxs6qAiBaff9VLduu9rfmSydYk/omu7VTH6g=;
 b=O5S2IrrTAIloRKHtxGxbklQgh7VhlU+4ljCRiSSoPhedjuVZFEmNqdsXCbHqmL1XCjhtHGf+oGqiMzg9Prqb+Dn4ASTV1g4+WeLbK8s6KzZwXrmmApjey1RnTqj+oBHucFT1ofkf/vxmfZ0B75oVinYrHtVjq6YsTS5KyT1tML91kjZHZ7j/Ky9Pab/yxyII/e5upWSh0rRSYiAdoMYSsLse6BvByYiaijmwnMDQE4k9bVJpmLYhkjYNco7eA1AMZcVmn7xOtKvA8zu1ZVWT0cl/2lzvMdi0Sumo/MUOoQdk0JW52vEHaBcYmbnNZMRst6QjXufvVFyhOfIgDB4bZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3/FsqTrxs6qAiBaff9VLduu9rfmSydYk/omu7VTH6g=;
 b=xKx6GIBZnraGImtnyFkolzRh7GGO8cmTj7169GL/eKeyLKoZ3bOK2szFxj/Qd9UXi68559bEQMhzJlrDVat0IaqzXvTy6RV4DD35vAe7ABnFPuR2wX2zdjv2VgJpt3qQRhe77phzB72WciApk8ICyGyEcbi/xNdZQKTNJI6Sbgs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jeff@labundy.com; 
Received: from SN6PR08MB5053.namprd08.prod.outlook.com (52.135.107.153) by
 SN6PR08MB5406.namprd08.prod.outlook.com (52.135.117.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Sun, 16 Feb 2020 23:32:57 +0000
Received: from SN6PR08MB5053.namprd08.prod.outlook.com
 ([fe80::2cd0:e164:fe88:3945]) by SN6PR08MB5053.namprd08.prod.outlook.com
 ([fe80::2cd0:e164:fe88:3945%4]) with mapi id 15.20.2729.025; Sun, 16 Feb 2020
 23:32:57 +0000
From:   Jeff LaBundy <jeff@labundy.com>
To:     lee.jones@linaro.org, dmitry.torokhov@gmail.com,
        thierry.reding@gmail.com, jic23@kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-input@vger.kernel.org, u.kleine-koenig@pengutronix.de,
        linux-pwm@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, Jeff LaBundy <jeff@labundy.com>
Subject: [PATCH v5 5/7] iio: temperature: Add support for Azoteq IQS620AT temperature sensor
Date:   Sun, 16 Feb 2020 17:32:09 -0600
Message-Id: <1581895931-6056-6-git-send-email-jeff@labundy.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581895931-6056-1-git-send-email-jeff@labundy.com>
References: <1581895931-6056-1-git-send-email-jeff@labundy.com>
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0501CA0142.namprd05.prod.outlook.com
 (2603:10b6:803:2c::20) To SN6PR08MB5053.namprd08.prod.outlook.com
 (2603:10b6:805:78::25)
MIME-Version: 1.0
Received: from localhost.localdomain (136.49.227.119) by SN4PR0501CA0142.namprd05.prod.outlook.com (2603:10b6:803:2c::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2750.9 via Frontend Transport; Sun, 16 Feb 2020 23:32:56 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [136.49.227.119]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ec44e43-6566-407c-7a8e-08d7b3388dcb
X-MS-TrafficTypeDiagnostic: SN6PR08MB5406:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR08MB5406EBA3A0AAA88DE4ACF0ECD3170@SN6PR08MB5406.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 03152A99FF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(136003)(366004)(39830400003)(396003)(376002)(199004)(189003)(8676002)(107886003)(8936002)(4326008)(7416002)(69590400006)(956004)(66556008)(2616005)(81156014)(81166006)(16526019)(26005)(5660300002)(6506007)(186003)(66946007)(6666004)(66476007)(316002)(6486002)(36756003)(52116002)(508600001)(6512007)(2906002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR08MB5406;H:SN6PR08MB5053.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: labundy.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yXIeI8JxsZZ5XxBo9xRvlt/yC9YcsCs607w0KaJFRCu2hxgBIF+COmBN5dp8TR/YwYee1SC8Wzri45h6r+5oiTjeSZkl1Txi6Jl1ks4g8eyzosjyu1Exu9FcqAByD8ng1V1jsxKRoel04SiK50GbZhPtaCMZdHtLtj71cS0KoaXeJ4HdRf8jPKfm595KejM6O7MA4RccwfSyTv7oDyUdH1VGZcT8UA+89xONwjzkfhC2QL8HX5j9zURH1Tm8CkFYdPZ/Dg8bBpwmbqT/5XzZ008N39tac7rgJMWw9L/AKnMRKt2vEtr6JtS196TRdKTeCQn5aiFPUVON0nlTFLTQoHU41KnFYG9aBodaAi7Nvs99/4yNDLi9NlJR8oE4LINqC4a9I0fez7PGcdX4VozLz7/nnAVygvRC90xRLuJA87gmo25r2v0shFrvsD9AY88J9ZRyZiYPAlLbd6Z775K4LT/EwbKtanovdGN6fdQalb0fBNfe0IxQmJ06gFxTic7ugFDpvD7vfLeLSco4UdQhLmG0H5NUCGtv4DihP2fNQFs=
X-MS-Exchange-AntiSpam-MessageData: o0SKgtCZJ26FHCVCjryYMPFxcrp8CvIJQgrW0YtI4axtXnWZ8H6gXPy99zQm674fil3IfOGkpkfBEIvmfwoIs9DLsHeTR1gJuHsnxJ1mhVY0D8zChV7tHqNrXyKTUrbrfzkA3VNKhnIkNMpDUbt9WA==
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ec44e43-6566-407c-7a8e-08d7b3388dcb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2020 23:32:57.6236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hneN2LxOg+rY5yIRVb53KIHRTYVv49laBBZQNc581sY5LnTzngf01dKVMsXZR6VRt99QoD1mEJI9JWfPOiKkfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB5406
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This patch adds support for the Azoteq IQS620AT temperature sensor,
capable of reporting its absolute die temperature.

Signed-off-by: Jeff LaBundy <jeff@labundy.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
Changes in v5:
  - Replaced iqs62x->map with iqs62x->regmap throughout
  - Dropped #defines for platform_driver name and alias in favor of the actual
    string names

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
 drivers/iio/temperature/iqs620at-temp.c | 97 +++++++++++++++++++++++++++++++++
 3 files changed, 108 insertions(+)
 create mode 100644 drivers/iio/temperature/iqs620at-temp.c

diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
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
 	tristate "Analog Devices Multi-Sensor Digital Temperature Measurement System"
 	depends on SPI
diff --git a/drivers/iio/temperature/Makefile b/drivers/iio/temperature/Makefile
index d6b850b..90c1131 100644
--- a/drivers/iio/temperature/Makefile
+++ b/drivers/iio/temperature/Makefile
@@ -3,6 +3,7 @@
 # Makefile for industrial I/O temperature drivers
 #

+obj-$(CONFIG_IQS620AT_TEMP) += iqs620at-temp.o
 obj-$(CONFIG_LTC2983) += ltc2983.o
 obj-$(CONFIG_HID_SENSOR_TEMP) += hid-sensor-temperature.o
 obj-$(CONFIG_MAXIM_THERMOCOUPLE) += maxim_thermocouple.o
diff --git a/drivers/iio/temperature/iqs620at-temp.c b/drivers/iio/temperature/iqs620at-temp.c
new file mode 100644
index 0000000..3fd52b3
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
+	struct iqs62x_core *iqs62x = iio_device_get_drvdata(indio_dev);
+	int ret;
+	__le16 val_buf;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = regmap_raw_read(iqs62x->regmap, IQS620_TEMP_UI_OUT,
+				      &val_buf, sizeof(val_buf));
+		if (ret)
+			return ret;
+
+		*val = le16_to_cpu(val_buf);
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		*val = IQS620_TEMP_SCALE;
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_OFFSET:
+		*val = IQS620_TEMP_OFFSET;
+		return IIO_VAL_INT;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info iqs620_temp_info = {
+	.read_raw = &iqs620_temp_read_raw,
+};
+
+static const struct iio_chan_spec iqs620_temp_channels[] = {
+	{
+		.type = IIO_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
+				      BIT(IIO_CHAN_INFO_OFFSET),
+	},
+};
+
+static int iqs620_temp_probe(struct platform_device *pdev)
+{
+	struct iqs62x_core *iqs62x = dev_get_drvdata(pdev->dev.parent);
+	struct iio_dev *indio_dev;
+
+	indio_dev = devm_iio_device_alloc(&pdev->dev, 0);
+	if (!indio_dev)
+		return -ENOMEM;
+
+	iio_device_set_drvdata(indio_dev, iqs62x);
+
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->dev.parent = &pdev->dev;
+	indio_dev->channels = iqs620_temp_channels;
+	indio_dev->num_channels = ARRAY_SIZE(iqs620_temp_channels);
+	indio_dev->name = iqs62x->dev_desc->dev_name;
+	indio_dev->info = &iqs620_temp_info;
+
+	return devm_iio_device_register(&pdev->dev, indio_dev);
+}
+
+static struct platform_driver iqs620_temp_platform_driver = {
+	.driver = {
+		.name = "iqs620at-temp",
+	},
+	.probe = iqs620_temp_probe,
+};
+module_platform_driver(iqs620_temp_platform_driver);
+
+MODULE_AUTHOR("Jeff LaBundy <jeff@labundy.com>");
+MODULE_DESCRIPTION("Azoteq IQS620AT Temperature Sensor");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:iqs620at-temp");
--
2.7.4

