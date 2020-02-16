Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2FE6160753
	for <lists+linux-pwm@lfdr.de>; Mon, 17 Feb 2020 00:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbgBPXdH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 16 Feb 2020 18:33:07 -0500
Received: from mail-dm6nam12on2066.outbound.protection.outlook.com ([40.107.243.66]:6039
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727772AbgBPXdG (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 16 Feb 2020 18:33:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hntk+cMCh5HR9/lhDdESxGx51l30HpvtfPDcbxON22SzxjuclqAv11uJ+kO8n9EqG78q4S+GjSgO9MUGBRbtBpQKOcnEkjPyzu0kztnqSF8scF7bgEPjV//tKJO/YePBuIISdwbuhMMnls4eFGlxVju09UlnU8J41BdxTnWkMuX4UBf9z1I7z9sZYJyEBKYIZUjXUT3cDbL/Oj/BV6iMBSnCbR397koimIeqc94NN5UZgLvniwGm8dsQLpwuHZzRmqOGyjICBEczjFR0/1HycsNC9A8vxSwMSPBd0HZNUSHAqoRznn5D5FNUwvkECWDfLmfcsJF/Rdd+yrKHOwaDrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1zeNsHHDRIQvCGbJwziSK2IqTbeZxXcR9M/SOAhWFPU=;
 b=bpbERfOQqkHfb91JE0n0P7TVa9W3C2NU4w9eHLb8qMz+uoafQVFEiSnrQ7H7TOPj3Hd9Dy5j59yhYABaIosh0f/EDzZ/zTj8lMlK0WdOHk2KjHh0inYS7x7Cp0ngSeBcPtzbb/Nr0woGHM1e7CmtyRAY9WqOqLqnjGAb0qBuQi4isSIF9sbEa3rWdtN7i0xJlJatwJA8/tneKZ2nydT0BY80CAMDSsCDf+IiNJgDwISeBLiNOSvcBQgY2KtZ+ydD88yMCxCrR7AXrbAEafqxwZVfAsBdlIra/zg09L//iRPAwMirIeisjXUSu/lhqq4Kk0/PQE//uKQZJMP3TVV41w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1zeNsHHDRIQvCGbJwziSK2IqTbeZxXcR9M/SOAhWFPU=;
 b=e3aIZ2Gk/KzrvSuDMtcHKzYyUSLCTzgbJCoTbcUnXaIfCGylBL57/5PITNxn/m/epDJWUFaXRxtz8mrqxEqSV9NEDwLjLQ9UjTlFaPv6Ncdtxo85APgDGP2XDEx8UANeQfdsIy3PD//PyVy0Rh0y+DrPVbCTv5R3CjXi3HNa5nQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jeff@labundy.com; 
Received: from SN6PR08MB5053.namprd08.prod.outlook.com (52.135.107.153) by
 SN6PR08MB5406.namprd08.prod.outlook.com (52.135.117.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Sun, 16 Feb 2020 23:33:03 +0000
Received: from SN6PR08MB5053.namprd08.prod.outlook.com
 ([fe80::2cd0:e164:fe88:3945]) by SN6PR08MB5053.namprd08.prod.outlook.com
 ([fe80::2cd0:e164:fe88:3945%4]) with mapi id 15.20.2729.025; Sun, 16 Feb 2020
 23:33:03 +0000
From:   Jeff LaBundy <jeff@labundy.com>
To:     lee.jones@linaro.org, dmitry.torokhov@gmail.com,
        thierry.reding@gmail.com, jic23@kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-input@vger.kernel.org, u.kleine-koenig@pengutronix.de,
        linux-pwm@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, Jeff LaBundy <jeff@labundy.com>
Subject: [PATCH v5 7/7] iio: position: Add support for Azoteq IQS624/625 angle sensors
Date:   Sun, 16 Feb 2020 17:32:11 -0600
Message-Id: <1581895931-6056-8-git-send-email-jeff@labundy.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581895931-6056-1-git-send-email-jeff@labundy.com>
References: <1581895931-6056-1-git-send-email-jeff@labundy.com>
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0501CA0142.namprd05.prod.outlook.com
 (2603:10b6:803:2c::20) To SN6PR08MB5053.namprd08.prod.outlook.com
 (2603:10b6:805:78::25)
MIME-Version: 1.0
Received: from localhost.localdomain (136.49.227.119) by SN4PR0501CA0142.namprd05.prod.outlook.com (2603:10b6:803:2c::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2750.9 via Frontend Transport; Sun, 16 Feb 2020 23:33:03 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [136.49.227.119]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ab9730e-9861-4414-1add-08d7b338917c
X-MS-TrafficTypeDiagnostic: SN6PR08MB5406:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR08MB54067F5C4B0348AE09379EF3D3170@SN6PR08MB5406.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03152A99FF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(366004)(199004)(189003)(8676002)(107886003)(8936002)(4326008)(7416002)(69590400006)(956004)(66556008)(2616005)(81156014)(81166006)(16526019)(26005)(5660300002)(6506007)(186003)(66946007)(6666004)(66476007)(6486002)(36756003)(52116002)(508600001)(6512007)(2906002)(86362001)(30864003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR08MB5406;H:SN6PR08MB5053.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: labundy.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1DMHB/IA9vejmG5cC0xUO8s3p5T5Qf4cVo9daAPRxqJkjJ+8QBchs1N4uK9fLGzTLx8T8CY2C4YD3QTsKpWZ6oITNTDFaJaGB6sExnJcLRqlx8jUXua0s3XMV/TOkVbSjG2lVyPc4116BvXHBHTxKB+VMQ8hIc+J3c3bdbMLlocfHXPb5pB69ePJZztBfBQzrIckwyssC69o4RpHwczJ5J35hkMyvBZHl5T9TRfHNHEjuvctr8uCJYd3zkY3UZtbZtUZq0ggk17HL3FLTtBpewDrTqvzPDuylmDG8d7IL34v7xdS+lBCpI/KNcL05kpyedZRaHU8StSFfqx+PT6i83ZLbtM9JAdExEjUMKpddGYkHhAsKlNSb3sKV6PWrRMZtpHn8OErLMUsDoUlq2fh4COH6vw2iQXIKdDw+2fNoQ0ZH8i/JOs9Owvwx5brMkObGOfngUOF+E1rw2/ceN45qbs62PhL0OBdBgjQ8tKyVxR/u+KHw3L9aOl+y3QbMC3LfM3+KW1HeFOrBUypU9itmxUYBE6SHImcv4Sb3yiJuF4=
X-MS-Exchange-AntiSpam-MessageData: vR+eYei9EiguIxFSMzcKAu8kApf1Vniq1k4CoMY31T2M1pkEqdMDF4dYjlLqbtBUUDxRMErSTaGuBGhYX9Kh3Fd2PRVLce3fX146WcXTKvB00VvbptM3dTFL6DpWYlncXUIPd8r7xLwroE0nQsdpbw==
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ab9730e-9861-4414-1add-08d7b338917c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2020 23:33:03.8213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PfEgCqzSbjFkUtM3MFwe0MuJBI8c1r9e0vsBKolcVWkQ1544jdGkJFkq8iABuh27+LFDueEw/zErbvFIZLB2oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB5406
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This patch adds support for the Azoteq IQS624 and IQS625 angular position
sensors, capable of reporting the angle of a rotating shaft down to 1 and
10 degrees of accuracy, respectively.

This patch also introduces a home for linear and angular position sensors.
Unlike resolvers, they are typically contactless and use the Hall effect.

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
  - Merged 'Copyright' and 'Author' lines into one in introductory comments
  - Replaced 'error' with 'ret' throughout
  - Added iqs624_pos_angle_en and iqs624_pos_angle_get to remove duplicate
    logic previously used throughout
  - Refactored the logic in iqs624_pos_notifier and added a lock to safely
    evaluate variables that may change in response to user action
  - Refactored the logic in iqs624_pos_read_raw
  - Added a lock to iqs624_pos_read_event_config to account for cases in which
    the corresponding hardware state is in the process of being updated
  - Refactored the logic in iqs624_pos_write_event_config and read the initial
    angle in case it changed since having first been read in iqs624_pos_init
  - Removed iqs624_pos_init as its logic has since been absorbed elsewhere
  - Removed devm_add_action_or_reset failure message
  - Eliminated tabbed alignment of platform_driver struct members
  - Changed Kconfig "depends on" logic to MFD_IQS62X || COMPILE_TEST

 drivers/iio/Kconfig               |   1 +
 drivers/iio/Makefile              |   1 +
 drivers/iio/position/Kconfig      |  19 +++
 drivers/iio/position/Makefile     |   7 +
 drivers/iio/position/iqs624-pos.c | 284 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 312 insertions(+)
 create mode 100644 drivers/iio/position/Kconfig
 create mode 100644 drivers/iio/position/Makefile
 create mode 100644 drivers/iio/position/iqs624-pos.c

diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
index 5bd5185..d5c073a 100644
--- a/drivers/iio/Kconfig
+++ b/drivers/iio/Kconfig
@@ -88,6 +88,7 @@ source "drivers/iio/orientation/Kconfig"
 if IIO_TRIGGER
    source "drivers/iio/trigger/Kconfig"
 endif #IIO_TRIGGER
+source "drivers/iio/position/Kconfig"
 source "drivers/iio/potentiometer/Kconfig"
 source "drivers/iio/potentiostat/Kconfig"
 source "drivers/iio/pressure/Kconfig"
diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
index bff682a..1712011 100644
--- a/drivers/iio/Makefile
+++ b/drivers/iio/Makefile
@@ -31,6 +31,7 @@ obj-y += light/
 obj-y += magnetometer/
 obj-y += multiplexer/
 obj-y += orientation/
+obj-y += position/
 obj-y += potentiometer/
 obj-y += potentiostat/
 obj-y += pressure/
diff --git a/drivers/iio/position/Kconfig b/drivers/iio/position/Kconfig
new file mode 100644
index 0000000..eda67f0
--- /dev/null
+++ b/drivers/iio/position/Kconfig
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Linear and angular position sensors
+#
+# When adding new entries keep the list in alphabetical order
+
+menu "Linear and angular position sensors"
+
+config IQS624_POS
+	tristate "Azoteq IQS624/625 angular position sensors"
+	depends on MFD_IQS62X || COMPILE_TEST
+	help
+	  Say Y here if you want to build support for the Azoteq IQS624
+	  and IQS625 angular position sensors.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called iqs624-pos.
+
+endmenu
diff --git a/drivers/iio/position/Makefile b/drivers/iio/position/Makefile
new file mode 100644
index 0000000..3cbe7a7
--- /dev/null
+++ b/drivers/iio/position/Makefile
@@ -0,0 +1,7 @@
+#
+# Makefile for IIO linear and angular position sensors
+#
+
+# When adding new entries keep the list in alphabetical order
+
+obj-$(CONFIG_IQS624_POS)	+= iqs624-pos.o
diff --git a/drivers/iio/position/iqs624-pos.c b/drivers/iio/position/iqs624-pos.c
new file mode 100644
index 0000000..77096c3
--- /dev/null
+++ b/drivers/iio/position/iqs624-pos.c
@@ -0,0 +1,284 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Azoteq IQS624/625 Angular Position Sensors
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
+#define IQS624_POS_DEG_OUT			0x16
+
+#define IQS624_POS_SCALE1			(314159 / 180)
+#define IQS624_POS_SCALE2			100000
+
+struct iqs624_pos_private {
+	struct iqs62x_core *iqs62x;
+	struct notifier_block notifier;
+	struct mutex lock;
+	bool angle_en;
+	u16 angle;
+};
+
+static int iqs624_pos_angle_en(struct iqs62x_core *iqs62x, bool angle_en)
+{
+	unsigned int event_mask = IQS624_HALL_UI_WHL_EVENT;
+
+	/*
+	 * The IQS625 reports angular position in the form of coarse intervals,
+	 * so only interval change events are unmasked. Conversely, the IQS624
+	 * reports angular position down to one degree of resolution, so wheel
+	 * movement events are unmasked instead.
+	 */
+	if (iqs62x->dev_desc->prod_num == IQS625_PROD_NUM)
+		event_mask = IQS624_HALL_UI_INT_EVENT;
+
+	return regmap_update_bits(iqs62x->regmap, IQS624_HALL_UI, event_mask,
+				  angle_en ? 0 : 0xFF);
+}
+
+static int iqs624_pos_notifier(struct notifier_block *notifier,
+			       unsigned long event_flags, void *context)
+{
+	struct iqs62x_event_data *event_data = context;
+	struct iqs624_pos_private *iqs624_pos;
+	struct iqs62x_core *iqs62x;
+	struct iio_dev *indio_dev;
+	u16 angle = event_data->ui_data;
+	s64 timestamp;
+	int ret;
+
+	iqs624_pos = container_of(notifier, struct iqs624_pos_private,
+				  notifier);
+	indio_dev = iio_priv_to_dev(iqs624_pos);
+	timestamp = iio_get_time_ns(indio_dev);
+
+	iqs62x = iqs624_pos->iqs62x;
+	if (iqs62x->dev_desc->prod_num == IQS625_PROD_NUM)
+		angle = event_data->interval;
+
+	mutex_lock(&iqs624_pos->lock);
+
+	if (event_flags & BIT(IQS62X_EVENT_SYS_RESET)) {
+		ret = iqs624_pos_angle_en(iqs62x, iqs624_pos->angle_en);
+		if (ret) {
+			dev_err(indio_dev->dev.parent,
+				"Failed to re-initialize device: %d\n", ret);
+			ret = NOTIFY_BAD;
+		} else {
+			ret = NOTIFY_OK;
+		}
+	} else if (iqs624_pos->angle_en && (angle != iqs624_pos->angle)) {
+		iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(IIO_ANGL, 0,
+						    IIO_EV_TYPE_CHANGE,
+						    IIO_EV_DIR_NONE),
+			       timestamp);
+
+		iqs624_pos->angle = angle;
+		ret = NOTIFY_OK;
+	} else {
+		ret = NOTIFY_DONE;
+	}
+
+	mutex_unlock(&iqs624_pos->lock);
+
+	return ret;
+}
+
+static void iqs624_pos_notifier_unregister(void *context)
+{
+	struct iqs624_pos_private *iqs624_pos = context;
+	struct iio_dev *indio_dev = iio_priv_to_dev(iqs624_pos);
+	int ret;
+
+	ret = blocking_notifier_chain_unregister(&iqs624_pos->iqs62x->nh,
+						 &iqs624_pos->notifier);
+	if (ret)
+		dev_err(indio_dev->dev.parent,
+			"Failed to unregister notifier: %d\n", ret);
+}
+
+static int iqs624_pos_angle_get(struct iqs62x_core *iqs62x, unsigned int *val)
+{
+	int ret;
+	__le16 val_buf;
+
+	if (iqs62x->dev_desc->prod_num == IQS625_PROD_NUM)
+		return regmap_read(iqs62x->regmap, iqs62x->dev_desc->interval,
+				   val);
+
+	ret = regmap_raw_read(iqs62x->regmap, IQS624_POS_DEG_OUT, &val_buf,
+			      sizeof(val_buf));
+	if (ret)
+		return ret;
+
+	*val = le16_to_cpu(val_buf);
+
+	return 0;
+}
+
+static int iqs624_pos_read_raw(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       int *val, int *val2, long mask)
+{
+	struct iqs624_pos_private *iqs624_pos = iio_priv(indio_dev);
+	struct iqs62x_core *iqs62x = iqs624_pos->iqs62x;
+	unsigned int scale = 1;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = iqs624_pos_angle_get(iqs62x, val);
+		if (ret)
+			return ret;
+
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		if (iqs62x->dev_desc->prod_num == IQS625_PROD_NUM) {
+			ret = regmap_read(iqs62x->regmap, IQS624_INTERVAL_DIV,
+					  &scale);
+			if (ret)
+				return ret;
+		}
+
+		*val = scale * IQS624_POS_SCALE1;
+		*val2 = IQS624_POS_SCALE2;
+		return IIO_VAL_FRACTIONAL;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int iqs624_pos_read_event_config(struct iio_dev *indio_dev,
+					const struct iio_chan_spec *chan,
+					enum iio_event_type type,
+					enum iio_event_direction dir)
+{
+	struct iqs624_pos_private *iqs624_pos = iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&iqs624_pos->lock);
+	ret = iqs624_pos->angle_en;
+	mutex_unlock(&iqs624_pos->lock);
+
+	return ret;
+}
+
+static int iqs624_pos_write_event_config(struct iio_dev *indio_dev,
+					 const struct iio_chan_spec *chan,
+					 enum iio_event_type type,
+					 enum iio_event_direction dir,
+					 int state)
+{
+	struct iqs624_pos_private *iqs624_pos = iio_priv(indio_dev);
+	struct iqs62x_core *iqs62x = iqs624_pos->iqs62x;
+	unsigned int val;
+	int ret;
+
+	mutex_lock(&iqs624_pos->lock);
+
+	ret = iqs624_pos_angle_get(iqs62x, &val);
+	if (ret)
+		goto err_mutex;
+
+	ret = iqs624_pos_angle_en(iqs62x, state);
+	if (ret)
+		goto err_mutex;
+
+	iqs624_pos->angle = val;
+	iqs624_pos->angle_en = state;
+
+err_mutex:
+	mutex_unlock(&iqs624_pos->lock);
+
+	return ret;
+}
+
+static const struct iio_info iqs624_pos_info = {
+	.read_raw = &iqs624_pos_read_raw,
+	.read_event_config = iqs624_pos_read_event_config,
+	.write_event_config = iqs624_pos_write_event_config,
+};
+
+static const struct iio_event_spec iqs624_pos_events[] = {
+	{
+		.type = IIO_EV_TYPE_CHANGE,
+		.dir = IIO_EV_DIR_NONE,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+	},
+};
+
+static const struct iio_chan_spec iqs624_pos_channels[] = {
+	{
+		.type = IIO_ANGL,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.event_spec = iqs624_pos_events,
+		.num_event_specs = ARRAY_SIZE(iqs624_pos_events),
+	},
+};
+
+static int iqs624_pos_probe(struct platform_device *pdev)
+{
+	struct iqs62x_core *iqs62x = dev_get_drvdata(pdev->dev.parent);
+	struct iqs624_pos_private *iqs624_pos;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*iqs624_pos));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	iqs624_pos = iio_priv(indio_dev);
+	iqs624_pos->iqs62x = iqs62x;
+
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->dev.parent = &pdev->dev;
+	indio_dev->channels = iqs624_pos_channels;
+	indio_dev->num_channels = ARRAY_SIZE(iqs624_pos_channels);
+	indio_dev->name = iqs62x->dev_desc->dev_name;
+	indio_dev->info = &iqs624_pos_info;
+
+	mutex_init(&iqs624_pos->lock);
+
+	iqs624_pos->notifier.notifier_call = iqs624_pos_notifier;
+	ret = blocking_notifier_chain_register(&iqs624_pos->iqs62x->nh,
+					       &iqs624_pos->notifier);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to register notifier: %d\n", ret);
+		return ret;
+	}
+
+	ret = devm_add_action_or_reset(&pdev->dev,
+				       iqs624_pos_notifier_unregister,
+				       iqs624_pos);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(&pdev->dev, indio_dev);
+}
+
+static struct platform_driver iqs624_pos_platform_driver = {
+	.driver = {
+		.name = "iqs624-pos",
+	},
+	.probe = iqs624_pos_probe,
+};
+module_platform_driver(iqs624_pos_platform_driver);
+
+MODULE_AUTHOR("Jeff LaBundy <jeff@labundy.com>");
+MODULE_DESCRIPTION("Azoteq IQS624/625 Angular Position Sensors");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:iqs624-pos");
--
2.7.4

