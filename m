Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B060016074F
	for <lists+linux-pwm@lfdr.de>; Mon, 17 Feb 2020 00:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbgBPXdF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 16 Feb 2020 18:33:05 -0500
Received: from mail-dm6nam12on2066.outbound.protection.outlook.com ([40.107.243.66]:6039
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728205AbgBPXdF (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 16 Feb 2020 18:33:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J7tZlP6YtPS+bF4My7v+hUckJrWbE/VZkU4DtRCUS2RcE5zMrexv+6WViM5dlLAMIRrF4KpmRcSjUco0otFcOGiEnjvvFCBOq05/Ii8SEM1m/tdRagRqymP2EJHsHUJQ492VqxmP/jvlYlrErJq00lwHL1mx+R/S5dy+tPsGAQJbpd0GXHC+ZrMWgejgAqh8dIsc8G8hHHyE0j4Gmo2a4xo322vK/YsJat97GAEVhwyVxz0Pz2cqzDQW9s5WjH3LtvIYLiVGJj5vJ228C/4hi3Z2q0IC45YDCaiN97FKHmAJ/NUMmTbHJqaBsYvDe9KLdCJ3otnWM0DW3KylVHrB3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ri2WXjlmX3IbfJZeQPe555l0EyfIijpPGjVJNKwO6Ok=;
 b=D2YKFK9fJ8TBdV6B6upw3kLYf195zaMoQAZ+FJubV6McPVXpBOOyw+QZQZO3Ps1BquFd1z2IpZFR+eeTx09eH/CJNOkAnEo8s6bQGAkAGehE6oYd63Kye7vzgnQnOTbk67H+C3ocq3ES5P8Qohi4kD74hYrhNQnbn2QqWRpCdLMmoikaU9J0AIOBb4YFPtIZb4q10X8Grd3lXUm7yImTPVmTmNLDKSsZzcIH96tHkyuZXAkWxDYlrNfZ6T0hu52uRaF2vjyjRLXH9sDP41RM51lqrTSJKiR+uSsMUqJ03kA98RwrrO7SNdTBR7zqUUqxpuzVwdlhkrTA3HyjyPzo+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ri2WXjlmX3IbfJZeQPe555l0EyfIijpPGjVJNKwO6Ok=;
 b=pfExkRFZw9Om26r6GVQmjbf2QGXox8o5xB6h1hlzi9U8xVLIUzZIkU/SAwT5d6U+PM7aLnhAF+cb+QiAG/o/Va5oaskd6MvNjm2yVaMVXu253KaVCFV0Ll7WCMyq8wTZFJSKrdanVOOFLzSumkOAdx/gzL3qye7WJDXRE4JYTM4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jeff@labundy.com; 
Received: from SN6PR08MB5053.namprd08.prod.outlook.com (52.135.107.153) by
 SN6PR08MB5406.namprd08.prod.outlook.com (52.135.117.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Sun, 16 Feb 2020 23:33:01 +0000
Received: from SN6PR08MB5053.namprd08.prod.outlook.com
 ([fe80::2cd0:e164:fe88:3945]) by SN6PR08MB5053.namprd08.prod.outlook.com
 ([fe80::2cd0:e164:fe88:3945%4]) with mapi id 15.20.2729.025; Sun, 16 Feb 2020
 23:33:00 +0000
From:   Jeff LaBundy <jeff@labundy.com>
To:     lee.jones@linaro.org, dmitry.torokhov@gmail.com,
        thierry.reding@gmail.com, jic23@kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-input@vger.kernel.org, u.kleine-koenig@pengutronix.de,
        linux-pwm@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, Jeff LaBundy <jeff@labundy.com>
Subject: [PATCH v5 6/7] iio: light: Add support for Azoteq IQS621/622 ambient light sensors
Date:   Sun, 16 Feb 2020 17:32:10 -0600
Message-Id: <1581895931-6056-7-git-send-email-jeff@labundy.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581895931-6056-1-git-send-email-jeff@labundy.com>
References: <1581895931-6056-1-git-send-email-jeff@labundy.com>
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0501CA0142.namprd05.prod.outlook.com
 (2603:10b6:803:2c::20) To SN6PR08MB5053.namprd08.prod.outlook.com
 (2603:10b6:805:78::25)
MIME-Version: 1.0
Received: from localhost.localdomain (136.49.227.119) by SN4PR0501CA0142.namprd05.prod.outlook.com (2603:10b6:803:2c::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2750.9 via Frontend Transport; Sun, 16 Feb 2020 23:33:00 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [136.49.227.119]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b0dc72e-f88f-441f-9e2f-08d7b3388fb7
X-MS-TrafficTypeDiagnostic: SN6PR08MB5406:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR08MB5406B4F6EED39E78C42BBD87D3170@SN6PR08MB5406.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03152A99FF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(136003)(366004)(39830400003)(396003)(376002)(199004)(189003)(8676002)(107886003)(8936002)(4326008)(7416002)(69590400006)(956004)(66556008)(2616005)(81156014)(81166006)(16526019)(26005)(5660300002)(6506007)(186003)(66946007)(6666004)(66476007)(316002)(6486002)(36756003)(52116002)(508600001)(6512007)(2906002)(86362001)(30864003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR08MB5406;H:SN6PR08MB5053.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: labundy.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PfLEsecIV/h2Ip2DjJAV+Ab5Gd52a4psXuG1F5Is+AcpXZll1nwr51cPxa+NppzbWkPQ13MAaUJKDCEjLLz8fF/UsNjPf/xdmuYRO5+68e9nVn3NVAeEVcElHqYBN6a2lAhRfIMK+SUVSnhRDPG4VrwW6MZ1pbIYvyLoywGEdBmjbF7ZrL77RCFxp8q/1hCaetBfJSTEmbyQ79vbtHG5bsYlsMbfqtAT8SmrCk6CiKL6r/K2CyPCY7bS5OH0xd6lH1CFFC8pkDOEWZ5HXS1gJlE3kgzCxcCiV2hljL8iZ/O2kfHbUlbPlon+fBx6XnIEYcIuFUuBvzc/o5RIo4KAV6RddJcKsVCg/4f0j5qrqkl0ZMdf1FkJwxyxeXB3J0NdQZ6x1gPfL9sMBNQj1B7vduoyhWtz3fI77WuzywiQp7vclUQsBxfImSK7pk7KwhbnidyIgbND/EYvfXjbAp7928rTOv9fcFsrmDrnpntsC/kM1HhiNMCDoRxFtAeQpLWtpoA4nZMxHknFkdvPY4qCd5/qOBS50MI7t97sMT4gMz8=
X-MS-Exchange-AntiSpam-MessageData: 0g6V7NMNxadzwdy1DzbdAZ9EXB1aH5iU1D9XrQb4Z4WiClYAI/eMOV1ToHXk/NzTaVCoTgFlNaNrWN3L8UzjuVAwxK0nzRUSOP0dDD3/uEXXYqQ6YEdf+uQWjYd1Jhy23RvI0y094mYR0uj4gNSdjA==
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b0dc72e-f88f-441f-9e2f-08d7b3388fb7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2020 23:33:00.8999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qIgEpepDPwinXNctP0nDdqNBEvZLW9z0mxsfZwTMQMVmkiMvferuS8UQpHeobpdGybPEasnILEG3DQW519pkgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB5406
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This patch adds support for the Azoteq IQS621 and IQS622 ambient light
sensors, both of which can report a four-bit representation of ambient
light intensity.

The IQS621 can additionally report illuminace directly in units of lux,
while the IQS622 can report a four-bit representation of infrared light
intensity. Furthermore, the IQS622 can report a unitless measurement of
a target's proximity to the device.

Signed-off-by: Jeff LaBundy <jeff@labundy.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
Changes in v5:
  - Replaced iqs62x->map with iqs62x->regmap throughout
  - Replaced use of bitwise-OR operators in iqs621_als_write_event_config with
    logical-OR operators as was originally intended
  - Dropped #defines for platform_driver name and alias in favor of the actual
    string names

Changes in v4:
  - None

Changes in v3:
  - Added Reviewed-by trailer

Changes in v2:
  - Merged 'Copyright' and 'Author' lines into one in introductory comments
  - Replaced 'error' with 'ret' throughout
  - Merged support for the closely related IQS622 (formerly represented by
    a separate iio/proximity driver)
  - Added support for unitless ambient light intensity (IQS621 and IQS622)
    and infrared light intensity (IQS622 only)
  - Moved the read of IQS621_ALS_FLAGS to iqs621_als_write_event_config to
    account for the fact that IQS621_ALS_FLAGS may have changed in between
    having first been read in iqs621_als_init and the time at which events
    are enabled, thereby eliminating the need to call iqs621_als_init from
    iqs621_als_probe
  - Refactored the logic in iqs621_als_notifier and added a lock to safely
    evaluate variables that may change in response to user action
  - Added locks to iqs621_als_read_event_config/value to account for cases in
    which the corresponding hardware state is in the process of being updated
  - Refactored the logic in iqs621_als_read/write_event_value and removed all
    #defines that could instead be represented by simple math
  - Based the decision whether to select the IQS622 IR touch vs. proximity
    threshold on the single proximity threshold written by user space, and
    added a comment to describe the difference between either threshold
  - Replaced IIO_CHAN_INFO_RAW with IIO_CHAN_INFO_PROCESSED for the IIO_LIGHT
    channel (IQS621 only)
  - Removed devm_add_action_or_reset failure message
  - Eliminated tabbed alignment of platform_driver struct members
  - Changed Kconfig "depends on" logic to MFD_IQS62X || COMPILE_TEST

 drivers/iio/light/Kconfig      |  10 +
 drivers/iio/light/Makefile     |   1 +
 drivers/iio/light/iqs621-als.c | 617 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 628 insertions(+)
 create mode 100644 drivers/iio/light/iqs621-als.c

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 9968f98..baf7958b 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -173,6 +173,16 @@ config GP2AP020A00F
 	  To compile this driver as a module, choose M here: the
 	  module will be called gp2ap020a00f.

+config IQS621_ALS
+	tristate "Azoteq IQS621/622 ambient light sensors"
+	depends on MFD_IQS62X || COMPILE_TEST
+	help
+	  Say Y here if you want to build support for the Azoteq IQS621
+	  and IQS622 ambient light sensors.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called iqs621-als.
+
 config SENSORS_ISL29018
 	tristate "Intersil 29018 light and proximity sensor"
 	depends on I2C
diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
index c98d1ce..988e8f4 100644
--- a/drivers/iio/light/Makefile
+++ b/drivers/iio/light/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_IIO_CROS_EC_LIGHT_PROX) += cros_ec_light_prox.o
 obj-$(CONFIG_GP2AP020A00F)	+= gp2ap020a00f.o
 obj-$(CONFIG_HID_SENSOR_ALS)	+= hid-sensor-als.o
 obj-$(CONFIG_HID_SENSOR_PROX)	+= hid-sensor-prox.o
+obj-$(CONFIG_IQS621_ALS)	+= iqs621-als.o
 obj-$(CONFIG_SENSORS_ISL29018)	+= isl29018.o
 obj-$(CONFIG_SENSORS_ISL29028)	+= isl29028.o
 obj-$(CONFIG_ISL29125)		+= isl29125.o
diff --git a/drivers/iio/light/iqs621-als.c b/drivers/iio/light/iqs621-als.c
new file mode 100644
index 0000000..b2988a7
--- /dev/null
+++ b/drivers/iio/light/iqs621-als.c
@@ -0,0 +1,617 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Azoteq IQS621/622 Ambient Light Sensors
+ *
+ * Copyright (C) 2019 Jeff LaBundy <jeff@labundy.com>
+ */
+
+#include <linux/device.h>
+#include <linux/iio/events.h>
+#include <linux/iio/iio.h>
+#include <linux/kernel.h>
+#include <linux/mfd/iqs62x.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/notifier.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#define IQS621_ALS_FLAGS_LIGHT			BIT(7)
+#define IQS621_ALS_FLAGS_RANGE			GENMASK(3, 0)
+
+#define IQS621_ALS_UI_OUT			0x17
+
+#define IQS621_ALS_THRESH_DARK			0x80
+#define IQS621_ALS_THRESH_LIGHT			0x81
+
+#define IQS622_IR_RANGE				0x15
+#define IQS622_IR_FLAGS				0x16
+#define IQS622_IR_FLAGS_TOUCH			BIT(1)
+#define IQS622_IR_FLAGS_PROX			BIT(0)
+
+#define IQS622_IR_UI_OUT			0x17
+
+#define IQS622_IR_THRESH_PROX			0x91
+#define IQS622_IR_THRESH_TOUCH			0x92
+
+struct iqs621_als_private {
+	struct iqs62x_core *iqs62x;
+	struct notifier_block notifier;
+	struct mutex lock;
+	bool light_en;
+	bool range_en;
+	bool prox_en;
+	u8 als_flags;
+	u8 ir_flags_mask;
+	u8 ir_flags;
+	u8 thresh_light;
+	u8 thresh_dark;
+	u8 thresh_prox;
+};
+
+static int iqs621_als_init(struct iqs621_als_private *iqs621_als)
+{
+	struct iqs62x_core *iqs62x = iqs621_als->iqs62x;
+	unsigned int event_mask = 0;
+	int ret;
+
+	switch (iqs621_als->ir_flags_mask) {
+	case IQS622_IR_FLAGS_TOUCH:
+		ret = regmap_write(iqs62x->regmap, IQS622_IR_THRESH_TOUCH,
+				   iqs621_als->thresh_prox);
+		break;
+
+	case IQS622_IR_FLAGS_PROX:
+		ret = regmap_write(iqs62x->regmap, IQS622_IR_THRESH_PROX,
+				   iqs621_als->thresh_prox);
+		break;
+
+	default:
+		ret = regmap_write(iqs62x->regmap, IQS621_ALS_THRESH_LIGHT,
+				   iqs621_als->thresh_light);
+		if (ret)
+			return ret;
+
+		ret = regmap_write(iqs62x->regmap, IQS621_ALS_THRESH_DARK,
+				   iqs621_als->thresh_dark);
+	}
+
+	if (ret)
+		return ret;
+
+	if (iqs621_als->light_en || iqs621_als->range_en)
+		event_mask |= iqs62x->dev_desc->als_mask;
+
+	if (iqs621_als->prox_en)
+		event_mask |= iqs62x->dev_desc->ir_mask;
+
+	return regmap_update_bits(iqs62x->regmap, IQS620_GLBL_EVENT_MASK,
+				  event_mask, 0);
+}
+
+static int iqs621_als_notifier(struct notifier_block *notifier,
+			       unsigned long event_flags, void *context)
+{
+	struct iqs62x_event_data *event_data = context;
+	struct iqs621_als_private *iqs621_als;
+	struct iio_dev *indio_dev;
+	bool light_new, light_old;
+	bool prox_new, prox_old;
+	u8 range_new, range_old;
+	s64 timestamp;
+	int ret;
+
+	iqs621_als = container_of(notifier, struct iqs621_als_private,
+				  notifier);
+	indio_dev = iio_priv_to_dev(iqs621_als);
+	timestamp = iio_get_time_ns(indio_dev);
+
+	mutex_lock(&iqs621_als->lock);
+
+	if (event_flags & BIT(IQS62X_EVENT_SYS_RESET)) {
+		ret = iqs621_als_init(iqs621_als);
+		if (ret) {
+			dev_err(indio_dev->dev.parent,
+				"Failed to re-initialize device: %d\n", ret);
+			ret = NOTIFY_BAD;
+		} else {
+			ret = NOTIFY_OK;
+		}
+
+		goto err_mutex;
+	}
+
+	if (!iqs621_als->light_en && !iqs621_als->range_en &&
+	    !iqs621_als->prox_en) {
+		ret = NOTIFY_DONE;
+		goto err_mutex;
+	}
+
+	/* IQS621 only */
+	light_new = event_data->als_flags & IQS621_ALS_FLAGS_LIGHT;
+	light_old = iqs621_als->als_flags & IQS621_ALS_FLAGS_LIGHT;
+
+	if (iqs621_als->light_en && light_new && !light_old)
+		iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(IIO_LIGHT, 0,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_RISING),
+			       timestamp);
+	else if (iqs621_als->light_en && !light_new && light_old)
+		iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(IIO_LIGHT, 0,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_FALLING),
+			       timestamp);
+
+	/* IQS621 and IQS622 */
+	range_new = event_data->als_flags & IQS621_ALS_FLAGS_RANGE;
+	range_old = iqs621_als->als_flags & IQS621_ALS_FLAGS_RANGE;
+
+	if (iqs621_als->range_en && (range_new > range_old))
+		iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(IIO_INTENSITY, 0,
+						    IIO_EV_TYPE_CHANGE,
+						    IIO_EV_DIR_RISING),
+			       timestamp);
+	else if (iqs621_als->range_en && (range_new < range_old))
+		iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(IIO_INTENSITY, 0,
+						    IIO_EV_TYPE_CHANGE,
+						    IIO_EV_DIR_FALLING),
+			       timestamp);
+
+	/* IQS622 only */
+	prox_new = event_data->ir_flags & iqs621_als->ir_flags_mask;
+	prox_old = iqs621_als->ir_flags & iqs621_als->ir_flags_mask;
+
+	if (iqs621_als->prox_en && prox_new && !prox_old)
+		iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, 0,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_RISING),
+			       timestamp);
+	else if (iqs621_als->prox_en && !prox_new && prox_old)
+		iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, 0,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_FALLING),
+			       timestamp);
+
+	iqs621_als->als_flags = event_data->als_flags;
+	iqs621_als->ir_flags = event_data->ir_flags;
+	ret = NOTIFY_OK;
+
+err_mutex:
+	mutex_unlock(&iqs621_als->lock);
+
+	return ret;
+}
+
+static void iqs621_als_notifier_unregister(void *context)
+{
+	struct iqs621_als_private *iqs621_als = context;
+	struct iio_dev *indio_dev = iio_priv_to_dev(iqs621_als);
+	int ret;
+
+	ret = blocking_notifier_chain_unregister(&iqs621_als->iqs62x->nh,
+						 &iqs621_als->notifier);
+	if (ret)
+		dev_err(indio_dev->dev.parent,
+			"Failed to unregister notifier: %d\n", ret);
+}
+
+static int iqs621_als_read_raw(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       int *val, int *val2, long mask)
+{
+	struct iqs621_als_private *iqs621_als = iio_priv(indio_dev);
+	struct iqs62x_core *iqs62x = iqs621_als->iqs62x;
+	int ret;
+	__le16 val_buf;
+
+	switch (chan->type) {
+	case IIO_INTENSITY:
+		ret = regmap_read(iqs62x->regmap, chan->address, val);
+		if (ret)
+			return ret;
+
+		*val &= IQS621_ALS_FLAGS_RANGE;
+		return IIO_VAL_INT;
+
+	case IIO_PROXIMITY:
+	case IIO_LIGHT:
+		ret = regmap_raw_read(iqs62x->regmap, chan->address, &val_buf,
+				      sizeof(val_buf));
+		if (ret)
+			return ret;
+
+		*val = le16_to_cpu(val_buf);
+		return IIO_VAL_INT;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int iqs621_als_read_event_config(struct iio_dev *indio_dev,
+					const struct iio_chan_spec *chan,
+					enum iio_event_type type,
+					enum iio_event_direction dir)
+{
+	struct iqs621_als_private *iqs621_als = iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&iqs621_als->lock);
+
+	switch (chan->type) {
+	case IIO_LIGHT:
+		ret = iqs621_als->light_en;
+		break;
+
+	case IIO_INTENSITY:
+		ret = iqs621_als->range_en;
+		break;
+
+	case IIO_PROXIMITY:
+		ret = iqs621_als->prox_en;
+		break;
+
+	default:
+		ret = -EINVAL;
+	}
+
+	mutex_unlock(&iqs621_als->lock);
+
+	return ret;
+}
+
+static int iqs621_als_write_event_config(struct iio_dev *indio_dev,
+					 const struct iio_chan_spec *chan,
+					 enum iio_event_type type,
+					 enum iio_event_direction dir,
+					 int state)
+{
+	struct iqs621_als_private *iqs621_als = iio_priv(indio_dev);
+	struct iqs62x_core *iqs62x = iqs621_als->iqs62x;
+	unsigned int val;
+	int ret;
+
+	mutex_lock(&iqs621_als->lock);
+
+	ret = regmap_read(iqs62x->regmap, iqs62x->dev_desc->als_flags, &val);
+	if (ret)
+		goto err_mutex;
+	iqs621_als->als_flags = val;
+
+	switch (chan->type) {
+	case IIO_LIGHT:
+		ret = regmap_update_bits(iqs62x->regmap, IQS620_GLBL_EVENT_MASK,
+					 iqs62x->dev_desc->als_mask,
+					 iqs621_als->range_en || state ? 0 :
+									 0xFF);
+		if (!ret)
+			iqs621_als->light_en = state;
+		break;
+
+	case IIO_INTENSITY:
+		ret = regmap_update_bits(iqs62x->regmap, IQS620_GLBL_EVENT_MASK,
+					 iqs62x->dev_desc->als_mask,
+					 iqs621_als->light_en || state ? 0 :
+									 0xFF);
+		if (!ret)
+			iqs621_als->range_en = state;
+		break;
+
+	case IIO_PROXIMITY:
+		ret = regmap_read(iqs62x->regmap, IQS622_IR_FLAGS, &val);
+		if (ret)
+			goto err_mutex;
+		iqs621_als->ir_flags = val;
+
+		ret = regmap_update_bits(iqs62x->regmap, IQS620_GLBL_EVENT_MASK,
+					 iqs62x->dev_desc->ir_mask,
+					 state ? 0 : 0xFF);
+		if (!ret)
+			iqs621_als->prox_en = state;
+		break;
+
+	default:
+		ret = -EINVAL;
+	}
+
+err_mutex:
+	mutex_unlock(&iqs621_als->lock);
+
+	return ret;
+}
+
+static int iqs621_als_read_event_value(struct iio_dev *indio_dev,
+				       const struct iio_chan_spec *chan,
+				       enum iio_event_type type,
+				       enum iio_event_direction dir,
+				       enum iio_event_info info,
+				       int *val, int *val2)
+{
+	struct iqs621_als_private *iqs621_als = iio_priv(indio_dev);
+	int ret = IIO_VAL_INT;
+
+	mutex_lock(&iqs621_als->lock);
+
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		*val = iqs621_als->thresh_light * 16;
+		break;
+
+	case IIO_EV_DIR_FALLING:
+		*val = iqs621_als->thresh_dark * 4;
+		break;
+
+	case IIO_EV_DIR_EITHER:
+		if (iqs621_als->ir_flags_mask == IQS622_IR_FLAGS_TOUCH)
+			*val = iqs621_als->thresh_prox * 4;
+		else
+			*val = iqs621_als->thresh_prox;
+		break;
+
+	default:
+		ret = -EINVAL;
+	}
+
+	mutex_unlock(&iqs621_als->lock);
+
+	return ret;
+}
+
+static int iqs621_als_write_event_value(struct iio_dev *indio_dev,
+					const struct iio_chan_spec *chan,
+					enum iio_event_type type,
+					enum iio_event_direction dir,
+					enum iio_event_info info,
+					int val, int val2)
+{
+	struct iqs621_als_private *iqs621_als = iio_priv(indio_dev);
+	struct iqs62x_core *iqs62x = iqs621_als->iqs62x;
+	unsigned int thresh_reg, thresh_val;
+	u8 ir_flags_mask, *thresh_cache;
+	int ret = -EINVAL;
+
+	mutex_lock(&iqs621_als->lock);
+
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		thresh_reg = IQS621_ALS_THRESH_LIGHT;
+		thresh_val = val / 16;
+
+		thresh_cache = &iqs621_als->thresh_light;
+		ir_flags_mask = 0;
+		break;
+
+	case IIO_EV_DIR_FALLING:
+		thresh_reg = IQS621_ALS_THRESH_DARK;
+		thresh_val = val / 4;
+
+		thresh_cache = &iqs621_als->thresh_dark;
+		ir_flags_mask = 0;
+		break;
+
+	case IIO_EV_DIR_EITHER:
+		/*
+		 * The IQS622 supports two detection thresholds, both measured
+		 * in the same arbitrary units reported by read_raw: proximity
+		 * (0 through 255 in steps of 1), and touch (0 through 1020 in
+		 * steps of 4).
+		 *
+		 * Based on the single detection threshold chosen by the user,
+		 * select the hardware threshold that gives the best trade-off
+		 * between range and resolution.
+		 *
+		 * By default, the close-range (but coarse) touch threshold is
+		 * chosen during probe.
+		 */
+		switch (val) {
+		case 0 ... 255:
+			thresh_reg = IQS622_IR_THRESH_PROX;
+			thresh_val = val;
+
+			ir_flags_mask = IQS622_IR_FLAGS_PROX;
+			break;
+
+		case 256 ... 1020:
+			thresh_reg = IQS622_IR_THRESH_TOUCH;
+			thresh_val = val / 4;
+
+			ir_flags_mask = IQS622_IR_FLAGS_TOUCH;
+			break;
+
+		default:
+			goto err_mutex;
+		}
+
+		thresh_cache = &iqs621_als->thresh_prox;
+		break;
+
+	default:
+		goto err_mutex;
+	}
+
+	if (thresh_val > 0xFF)
+		goto err_mutex;
+
+	ret = regmap_write(iqs62x->regmap, thresh_reg, thresh_val);
+	if (ret)
+		goto err_mutex;
+
+	*thresh_cache = thresh_val;
+	iqs621_als->ir_flags_mask = ir_flags_mask;
+
+err_mutex:
+	mutex_unlock(&iqs621_als->lock);
+
+	return ret;
+}
+
+static const struct iio_info iqs621_als_info = {
+	.read_raw = &iqs621_als_read_raw,
+	.read_event_config = iqs621_als_read_event_config,
+	.write_event_config = iqs621_als_write_event_config,
+	.read_event_value = iqs621_als_read_event_value,
+	.write_event_value = iqs621_als_write_event_value,
+};
+
+static const struct iio_event_spec iqs621_als_range_events[] = {
+	{
+		.type = IIO_EV_TYPE_CHANGE,
+		.dir = IIO_EV_DIR_EITHER,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+	},
+};
+
+static const struct iio_event_spec iqs621_als_light_events[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_EITHER,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+	},
+};
+
+static const struct iio_chan_spec iqs621_als_channels[] = {
+	{
+		.type = IIO_INTENSITY,
+		.address = IQS621_ALS_FLAGS,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.event_spec = iqs621_als_range_events,
+		.num_event_specs = ARRAY_SIZE(iqs621_als_range_events),
+	},
+	{
+		.type = IIO_LIGHT,
+		.address = IQS621_ALS_UI_OUT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+		.event_spec = iqs621_als_light_events,
+		.num_event_specs = ARRAY_SIZE(iqs621_als_light_events),
+	},
+};
+
+static const struct iio_event_spec iqs622_als_prox_events[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_EITHER,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE) |
+				 BIT(IIO_EV_INFO_VALUE),
+	},
+};
+
+static const struct iio_chan_spec iqs622_als_channels[] = {
+	{
+		.type = IIO_INTENSITY,
+		.channel2 = IIO_MOD_LIGHT_BOTH,
+		.address = IQS622_ALS_FLAGS,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.event_spec = iqs621_als_range_events,
+		.num_event_specs = ARRAY_SIZE(iqs621_als_range_events),
+		.modified = true,
+	},
+	{
+		.type = IIO_INTENSITY,
+		.channel2 = IIO_MOD_LIGHT_IR,
+		.address = IQS622_IR_RANGE,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.modified = true,
+	},
+	{
+		.type = IIO_PROXIMITY,
+		.address = IQS622_IR_UI_OUT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.event_spec = iqs622_als_prox_events,
+		.num_event_specs = ARRAY_SIZE(iqs622_als_prox_events),
+	},
+};
+
+static int iqs621_als_probe(struct platform_device *pdev)
+{
+	struct iqs62x_core *iqs62x = dev_get_drvdata(pdev->dev.parent);
+	struct iqs621_als_private *iqs621_als;
+	struct iio_dev *indio_dev;
+	unsigned int val;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*iqs621_als));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	iqs621_als = iio_priv(indio_dev);
+	iqs621_als->iqs62x = iqs62x;
+
+	if (iqs62x->dev_desc->prod_num == IQS622_PROD_NUM) {
+		ret = regmap_read(iqs62x->regmap, IQS622_IR_THRESH_TOUCH,
+				  &val);
+		if (ret)
+			return ret;
+		iqs621_als->thresh_prox = val;
+		iqs621_als->ir_flags_mask = IQS622_IR_FLAGS_TOUCH;
+
+		indio_dev->channels = iqs622_als_channels;
+		indio_dev->num_channels = ARRAY_SIZE(iqs622_als_channels);
+	} else {
+		ret = regmap_read(iqs62x->regmap, IQS621_ALS_THRESH_LIGHT,
+				  &val);
+		if (ret)
+			return ret;
+		iqs621_als->thresh_light = val;
+
+		ret = regmap_read(iqs62x->regmap, IQS621_ALS_THRESH_DARK,
+				  &val);
+		if (ret)
+			return ret;
+		iqs621_als->thresh_dark = val;
+
+		indio_dev->channels = iqs621_als_channels;
+		indio_dev->num_channels = ARRAY_SIZE(iqs621_als_channels);
+	}
+
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->dev.parent = &pdev->dev;
+	indio_dev->name = iqs62x->dev_desc->dev_name;
+	indio_dev->info = &iqs621_als_info;
+
+	mutex_init(&iqs621_als->lock);
+
+	iqs621_als->notifier.notifier_call = iqs621_als_notifier;
+	ret = blocking_notifier_chain_register(&iqs621_als->iqs62x->nh,
+					       &iqs621_als->notifier);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to register notifier: %d\n", ret);
+		return ret;
+	}
+
+	ret = devm_add_action_or_reset(&pdev->dev,
+				       iqs621_als_notifier_unregister,
+				       iqs621_als);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(&pdev->dev, indio_dev);
+}
+
+static struct platform_driver iqs621_als_platform_driver = {
+	.driver = {
+		.name = "iqs621-als",
+	},
+	.probe = iqs621_als_probe,
+};
+module_platform_driver(iqs621_als_platform_driver);
+
+MODULE_AUTHOR("Jeff LaBundy <jeff@labundy.com>");
+MODULE_DESCRIPTION("Azoteq IQS621/622 Ambient Light Sensors");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:iqs621-als");
--
2.7.4

