Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72921160744
	for <lists+linux-pwm@lfdr.de>; Mon, 17 Feb 2020 00:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbgBPXcy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 16 Feb 2020 18:32:54 -0500
Received: from mail-dm6nam12on2070.outbound.protection.outlook.com ([40.107.243.70]:49361
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728115AbgBPXcy (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 16 Feb 2020 18:32:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ABCrvJmL1iLvdKvbvP7OvebcCGucTuj0l8GschMP+m9CL8jHXmZ1NsvBMlMW8lT/rmk8qC4klTkIQNAfQBiDJuG6qK46i5De7QSlSsO5pInVDTQiHnjUWHatsVXvl+KO0WJ9FApgKJYtJqRtqGQAuJ4AgUhoTp/TC2S5lSdk34KDjG7zbcG5c5LVZSpPZVH+QArVjA5mh6yDiBA0KVG0fbWsx8StyIcIJVBg3FaCZYfcG/QWyDCUuqZNfMXx1gj5IykSEvCUtglY2CULDQpUz3xy8tQzJdpVMFrcxRlXe5GkEOIHb3fXxBhKjxIQpOB8E/taV5+zocgilEHTh+StFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v6ZyZllvlwKGYN0NcRahORFD9ZL53jdVvLOrWIJIKo8=;
 b=D3r9hS7QCsm5KxMW0TZ3W9nknUymIncGJNAU1FDECfMrKY9qUNwpUBf1fIoVfKDk1acRvI0WG4Gi34prGDF+ZmMGCjaynRIFDqXSG7LhncpCivo7GUTar2DG/qyrfpLJilL5YI7gs+TNP5D3go57o/utL8Sz3v+J4v6u8Z14DFS1DsmqxEIrEnuzgIuc7IZAiWsN1QWroofVHIMOyLqxNy44wryLdz1Z+pgqMLMVmkq/VYfdnZRMBdKicjmR9gqfuY7rz/ZkpBbqrVNEwtNmFfDDdp7wUFKHqK06z+GxLoCdYwEHhfMu9X0waiuhJ70yYMD8MvKP9mQVUVXJ2qONoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v6ZyZllvlwKGYN0NcRahORFD9ZL53jdVvLOrWIJIKo8=;
 b=o8Ig9FhexVeNb8ofyHtH54ibzKTYSaFSObQodEkS1EWwrOHlW5Njgj0vSr7i0xc7yCzhGADDmZxWc1vF3z0jxFn9+SQ/UFNz9L0kDxrzyJSQOgumPMHJXDOZkoxYrMeUmrcPNzNkB0avrqCFKQM9uhTMPQvLgWhC+eczLJz4Hos=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jeff@labundy.com; 
Received: from SN6PR08MB5053.namprd08.prod.outlook.com (52.135.107.153) by
 SN6PR08MB5406.namprd08.prod.outlook.com (52.135.117.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Sun, 16 Feb 2020 23:32:45 +0000
Received: from SN6PR08MB5053.namprd08.prod.outlook.com
 ([fe80::2cd0:e164:fe88:3945]) by SN6PR08MB5053.namprd08.prod.outlook.com
 ([fe80::2cd0:e164:fe88:3945%4]) with mapi id 15.20.2729.025; Sun, 16 Feb 2020
 23:32:45 +0000
From:   Jeff LaBundy <jeff@labundy.com>
To:     lee.jones@linaro.org, dmitry.torokhov@gmail.com,
        thierry.reding@gmail.com, jic23@kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-input@vger.kernel.org, u.kleine-koenig@pengutronix.de,
        linux-pwm@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, Jeff LaBundy <jeff@labundy.com>
Subject: [PATCH v5 3/7] input: keyboard: Add support for Azoteq IQS620A/621/622/624/625
Date:   Sun, 16 Feb 2020 17:32:07 -0600
Message-Id: <1581895931-6056-4-git-send-email-jeff@labundy.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581895931-6056-1-git-send-email-jeff@labundy.com>
References: <1581895931-6056-1-git-send-email-jeff@labundy.com>
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0501CA0142.namprd05.prod.outlook.com
 (2603:10b6:803:2c::20) To SN6PR08MB5053.namprd08.prod.outlook.com
 (2603:10b6:805:78::25)
MIME-Version: 1.0
Received: from localhost.localdomain (136.49.227.119) by SN4PR0501CA0142.namprd05.prod.outlook.com (2603:10b6:803:2c::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2750.9 via Frontend Transport; Sun, 16 Feb 2020 23:32:44 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [136.49.227.119]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 733c0ff4-5b0c-4548-fbe6-08d7b3388673
X-MS-TrafficTypeDiagnostic: SN6PR08MB5406:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR08MB540602111DD3812B3DFF7E65D3170@SN6PR08MB5406.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 03152A99FF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(136003)(366004)(39830400003)(396003)(376002)(199004)(189003)(8676002)(107886003)(8936002)(4326008)(7416002)(69590400006)(956004)(66556008)(2616005)(81156014)(81166006)(16526019)(26005)(5660300002)(6506007)(186003)(66946007)(6666004)(66476007)(316002)(6486002)(36756003)(52116002)(508600001)(6512007)(2906002)(86362001)(30864003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR08MB5406;H:SN6PR08MB5053.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: labundy.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E7gVlkFnPDHRFPicQyB66Rn1VT/Rew9MlvfcgXkAY6pKm8CqikO4IzYHM5l85nr13KYozNyhFHj8kBMwxD7vtdfBSNdyKJmuoRTS+AjXzjbfHNwkqSOdKVBSQ9Ht5IZWBJeEINx6THWAgj1DsfmOvLSpt1741ItcQQUyEsxpvRBJHYjFKYnVNQn+Rzh94My8UFhoemU4iJVRrNe7TXtk/t8wgKg7n83IbovVCX2zofnUEB9LEng9p9BY27vZ8H97TGXiw84Sp/bzvmfz9EJCV/CAbs71xWI/qC4zd7Os+xoQ/eTmxr+Ug9OkQUaH8dGmSXkduoSEqH9wVoJkL7t5pn4p+AfOVKxHyfVU3bAhPbQrwbOiDjDjpdp9RbjtqoNEYsAuSPaDzxAHcthZcYVIAmjVGByRaNBXDwv7CfFaMqGhn8JqqeP23INO0hktfcXk/qVPBW2Mlv7oduGBIIV3uXEAw6OIWmjxw8bS0TtpkV5A3ogPO72fyZezftFNiB1FBBea4srlXT1o/Mm+p2Q6ivVepGphNHJwxM5FbsST01Q=
X-MS-Exchange-AntiSpam-MessageData: 1Cx17KK0sQROWiiuePOz/CeVk20pfU++QVLfoWMtSeBvk6X2mIbBbMmIG9hkP9luuLxh505IGkc9snIRLka4bN/7wsLeMzM0WB4lhhETrjzvhQzGZcCPrzooTgu5iI9XbnlWhUXeIxwQ/N6XtW6lYQ==
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 733c0ff4-5b0c-4548-fbe6-08d7b3388673
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2020 23:32:45.3132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FfiKRuLSQ7WD6EdLZO2PWs79LQex4YED5hxT8YIotHOoMx+F89FDKANu7Q32Mvi/OEc2M6+lGO9UOABwaNO+mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB5406
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This patch adds key and switch support for the Azoteq IQS620A,
IQS621, IQS622, IQS624 and IQS625 multi-function sensors.

Signed-off-by: Jeff LaBundy <jeff@labundy.com>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
Changes in v5:
  - Replaced iqs62x->map with iqs62x->regmap throughout
  - Updated iqs62x_keys_parse_prop to use device_property_count_u32 instead of
    device_property_read_u32_array to count available keycodes
  - Used input_set_capability to signal available keys and switches instead of
    __set_bit and __clear_bit within iqs62x_keys_probe
  - Dropped #defines for platform_driver name and alias in favor of the actual
    string names
  - Added Acked-by trailer

Changes in v4:
  - None

Changes in v3:
  - None

Changes in v2:
  - Merged 'Copyright' and 'Author' lines into one in introductory comments
  - Replaced 'error' with 'ret' throughout
  - Updated iqs62x_keys_parse_prop to use unified device property interface
  - Clarified the comment in iqs62x_keys_notifier to state that wheel up or
    down events elicit an emulated release cycle
  - Eliminated tabbed alignment of platform_driver struct members

 drivers/input/keyboard/Kconfig       |  10 ++
 drivers/input/keyboard/Makefile      |   1 +
 drivers/input/keyboard/iqs62x-keys.c | 335 +++++++++++++++++++++++++++++++++++
 3 files changed, 346 insertions(+)
 create mode 100644 drivers/input/keyboard/iqs62x-keys.c

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index 4706ff0..28de965 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -663,6 +663,16 @@ config KEYBOARD_IPAQ_MICRO
 	  To compile this driver as a module, choose M here: the
 	  module will be called ipaq-micro-keys.

+config KEYBOARD_IQS62X
+	tristate "Azoteq IQS620A/621/622/624/625 keys and switches"
+	depends on MFD_IQS62X
+	help
+	  Say Y here to enable key and switch support for the Azoteq IQS620A,
+	  IQS621, IQS622, IQS624 and IQS625 multi-function sensors.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called iqs62x-keys.
+
 config KEYBOARD_OMAP
 	tristate "TI OMAP keypad support"
 	depends on ARCH_OMAP1
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
index f5b1752..1d689fd 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_KEYBOARD_TCA8418)		+= tca8418_keypad.o
 obj-$(CONFIG_KEYBOARD_HIL)		+= hil_kbd.o
 obj-$(CONFIG_KEYBOARD_HIL_OLD)		+= hilkbd.o
 obj-$(CONFIG_KEYBOARD_IPAQ_MICRO)	+= ipaq-micro-keys.o
+obj-$(CONFIG_KEYBOARD_IQS62X)		+= iqs62x-keys.o
 obj-$(CONFIG_KEYBOARD_IMX)		+= imx_keypad.o
 obj-$(CONFIG_KEYBOARD_IMX_SC_KEY)	+= imx_sc_key.o
 obj-$(CONFIG_KEYBOARD_HP6XX)		+= jornada680_kbd.o
diff --git a/drivers/input/keyboard/iqs62x-keys.c b/drivers/input/keyboard/iqs62x-keys.c
new file mode 100644
index 0000000..93446b2
--- /dev/null
+++ b/drivers/input/keyboard/iqs62x-keys.c
@@ -0,0 +1,335 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Azoteq IQS620A/621/622/624/625 Keys and Switches
+ *
+ * Copyright (C) 2019 Jeff LaBundy <jeff@labundy.com>
+ */
+
+#include <linux/device.h>
+#include <linux/input.h>
+#include <linux/kernel.h>
+#include <linux/mfd/iqs62x.h>
+#include <linux/module.h>
+#include <linux/notifier.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+enum {
+	IQS62X_SW_HALL_N,
+	IQS62X_SW_HALL_S,
+};
+
+static const char * const iqs62x_switch_names[] = {
+	[IQS62X_SW_HALL_N] = "hall-switch-north",
+	[IQS62X_SW_HALL_S] = "hall-switch-south",
+};
+
+struct iqs62x_switch_desc {
+	enum iqs62x_event_flag flag;
+	unsigned int code;
+	bool enabled;
+};
+
+struct iqs62x_keys_private {
+	struct iqs62x_core *iqs62x;
+	struct input_dev *input;
+	struct notifier_block notifier;
+	struct iqs62x_switch_desc switches[ARRAY_SIZE(iqs62x_switch_names)];
+	unsigned int keycode[IQS62X_NUM_KEYS];
+	unsigned int keycodemax;
+	u8 interval;
+};
+
+static int iqs62x_keys_parse_prop(struct platform_device *pdev,
+				  struct iqs62x_keys_private *iqs62x_keys)
+{
+	struct fwnode_handle *child;
+	unsigned int val;
+	int ret, i;
+
+	ret = device_property_count_u32(&pdev->dev, "linux,keycodes");
+	if (ret > IQS62X_NUM_KEYS) {
+		dev_err(&pdev->dev, "Too many keycodes present\n");
+		return -EINVAL;
+	} else if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to count keycodes: %d\n", ret);
+		return ret;
+	}
+	iqs62x_keys->keycodemax = ret;
+
+	ret = device_property_read_u32_array(&pdev->dev, "linux,keycodes",
+					     iqs62x_keys->keycode,
+					     iqs62x_keys->keycodemax);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to read keycodes: %d\n", ret);
+		return ret;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(iqs62x_keys->switches); i++) {
+		child = device_get_named_child_node(&pdev->dev,
+						    iqs62x_switch_names[i]);
+		if (!child)
+			continue;
+
+		ret = fwnode_property_read_u32(child, "linux,code", &val);
+		if (ret) {
+			dev_err(&pdev->dev, "Failed to read switch code: %d\n",
+				ret);
+			return ret;
+		}
+		iqs62x_keys->switches[i].code = val;
+		iqs62x_keys->switches[i].enabled = true;
+
+		if (fwnode_property_present(child, "azoteq,use-prox"))
+			iqs62x_keys->switches[i].flag = (i == IQS62X_SW_HALL_N ?
+							 IQS62X_EVENT_HALL_N_P :
+							 IQS62X_EVENT_HALL_S_P);
+		else
+			iqs62x_keys->switches[i].flag = (i == IQS62X_SW_HALL_N ?
+							 IQS62X_EVENT_HALL_N_T :
+							 IQS62X_EVENT_HALL_S_T);
+	}
+
+	return 0;
+}
+
+static int iqs62x_keys_init(struct iqs62x_keys_private *iqs62x_keys)
+{
+	struct iqs62x_core *iqs62x = iqs62x_keys->iqs62x;
+	enum iqs62x_event_flag flag;
+	unsigned int event_reg, val;
+	unsigned int event_mask = 0;
+	int ret, i;
+
+	switch (iqs62x->dev_desc->prod_num) {
+	case IQS620_PROD_NUM:
+	case IQS621_PROD_NUM:
+	case IQS622_PROD_NUM:
+		event_reg = IQS620_GLBL_EVENT_MASK;
+
+		/*
+		 * Discreet button, hysteresis and SAR UI flags represent keys
+		 * and are unmasked if mapped to a valid keycode.
+		 */
+		for (i = 0; i < iqs62x_keys->keycodemax; i++) {
+			if (iqs62x_keys->keycode[i] == KEY_RESERVED)
+				continue;
+
+			if (iqs62x_events[i].reg == IQS62X_EVENT_PROX)
+				event_mask |= iqs62x->dev_desc->prox_mask;
+			else if (iqs62x_events[i].reg == IQS62X_EVENT_HYST)
+				event_mask |= (iqs62x->dev_desc->hyst_mask |
+					       iqs62x->dev_desc->sar_mask);
+		}
+
+		ret = regmap_read(iqs62x->regmap, iqs62x->dev_desc->hall_flags,
+				  &val);
+		if (ret)
+			return ret;
+
+		/*
+		 * Hall UI flags represent switches and are unmasked if their
+		 * corresponding child nodes are present.
+		 */
+		for (i = 0; i < ARRAY_SIZE(iqs62x_keys->switches); i++) {
+			if (!(iqs62x_keys->switches[i].enabled))
+				continue;
+
+			flag = iqs62x_keys->switches[i].flag;
+
+			if (iqs62x_events[flag].reg != IQS62X_EVENT_HALL)
+				continue;
+
+			event_mask |= iqs62x->dev_desc->hall_mask;
+
+			input_report_switch(iqs62x_keys->input,
+					    iqs62x_keys->switches[i].code,
+					    (val & iqs62x_events[flag].mask) ==
+					    iqs62x_events[flag].val);
+		}
+
+		input_sync(iqs62x_keys->input);
+		break;
+
+	case IQS624_PROD_NUM:
+		event_reg = IQS624_HALL_UI;
+
+		/*
+		 * Interval change events represent keys and are unmasked if
+		 * either wheel movement flag is mapped to a valid keycode.
+		 */
+		if (iqs62x_keys->keycode[IQS62X_EVENT_WHEEL_UP] != KEY_RESERVED)
+			event_mask |= IQS624_HALL_UI_INT_EVENT;
+
+		if (iqs62x_keys->keycode[IQS62X_EVENT_WHEEL_DN] != KEY_RESERVED)
+			event_mask |= IQS624_HALL_UI_INT_EVENT;
+
+		ret = regmap_read(iqs62x->regmap, iqs62x->dev_desc->interval,
+				  &val);
+		if (ret)
+			return ret;
+
+		iqs62x_keys->interval = val;
+		break;
+
+	default:
+		return 0;
+	}
+
+	return regmap_update_bits(iqs62x->regmap, event_reg, event_mask, 0);
+}
+
+static int iqs62x_keys_notifier(struct notifier_block *notifier,
+				unsigned long event_flags, void *context)
+{
+	struct iqs62x_event_data *event_data = context;
+	struct iqs62x_keys_private *iqs62x_keys;
+	int ret, i;
+
+	iqs62x_keys = container_of(notifier, struct iqs62x_keys_private,
+				   notifier);
+
+	if (event_flags & BIT(IQS62X_EVENT_SYS_RESET)) {
+		ret = iqs62x_keys_init(iqs62x_keys);
+		if (ret) {
+			dev_err(iqs62x_keys->input->dev.parent,
+				"Failed to re-initialize device: %d\n", ret);
+			return NOTIFY_BAD;
+		}
+
+		return NOTIFY_OK;
+	}
+
+	for (i = 0; i < iqs62x_keys->keycodemax; i++) {
+		if (iqs62x_events[i].reg == IQS62X_EVENT_WHEEL &&
+		    event_data->interval == iqs62x_keys->interval)
+			continue;
+
+		input_report_key(iqs62x_keys->input, iqs62x_keys->keycode[i],
+				 event_flags & BIT(i));
+	}
+
+	for (i = 0; i < ARRAY_SIZE(iqs62x_keys->switches); i++)
+		if (iqs62x_keys->switches[i].enabled)
+			input_report_switch(iqs62x_keys->input,
+					    iqs62x_keys->switches[i].code,
+					    event_flags &
+					    BIT(iqs62x_keys->switches[i].flag));
+
+	input_sync(iqs62x_keys->input);
+
+	if (event_data->interval == iqs62x_keys->interval)
+		return NOTIFY_OK;
+
+	/*
+	 * Each frame contains at most one wheel event (up or down), in which
+	 * case a complementary release cycle is emulated.
+	 */
+	if (event_flags & BIT(IQS62X_EVENT_WHEEL_UP)) {
+		input_report_key(iqs62x_keys->input,
+				 iqs62x_keys->keycode[IQS62X_EVENT_WHEEL_UP],
+				 0);
+		input_sync(iqs62x_keys->input);
+	} else if (event_flags & BIT(IQS62X_EVENT_WHEEL_DN)) {
+		input_report_key(iqs62x_keys->input,
+				 iqs62x_keys->keycode[IQS62X_EVENT_WHEEL_DN],
+				 0);
+		input_sync(iqs62x_keys->input);
+	}
+
+	iqs62x_keys->interval = event_data->interval;
+
+	return NOTIFY_OK;
+}
+
+static int iqs62x_keys_probe(struct platform_device *pdev)
+{
+	struct iqs62x_core *iqs62x = dev_get_drvdata(pdev->dev.parent);
+	struct iqs62x_keys_private *iqs62x_keys;
+	struct input_dev *input;
+	int ret, i;
+
+	iqs62x_keys = devm_kzalloc(&pdev->dev, sizeof(*iqs62x_keys),
+				   GFP_KERNEL);
+	if (!iqs62x_keys)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, iqs62x_keys);
+
+	ret = iqs62x_keys_parse_prop(pdev, iqs62x_keys);
+	if (ret)
+		return ret;
+
+	input = devm_input_allocate_device(&pdev->dev);
+	if (!input)
+		return -ENOMEM;
+
+	input->keycodemax = iqs62x_keys->keycodemax;
+	input->keycode = iqs62x_keys->keycode;
+	input->keycodesize = sizeof(*iqs62x_keys->keycode);
+
+	input->name = iqs62x->dev_desc->dev_name;
+	input->id.bustype = BUS_I2C;
+
+	for (i = 0; i < iqs62x_keys->keycodemax; i++)
+		if (iqs62x_keys->keycode[i] != KEY_RESERVED)
+			input_set_capability(input, EV_KEY,
+					     iqs62x_keys->keycode[i]);
+
+	for (i = 0; i < ARRAY_SIZE(iqs62x_keys->switches); i++)
+		if (iqs62x_keys->switches[i].enabled)
+			input_set_capability(input, EV_SW,
+					     iqs62x_keys->switches[i].code);
+
+	iqs62x_keys->iqs62x = iqs62x;
+	iqs62x_keys->input = input;
+
+	ret = iqs62x_keys_init(iqs62x_keys);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to initialize device: %d\n", ret);
+		return ret;
+	}
+
+	ret = input_register_device(iqs62x_keys->input);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to register device: %d\n", ret);
+		return ret;
+	}
+
+	iqs62x_keys->notifier.notifier_call = iqs62x_keys_notifier;
+	ret = blocking_notifier_chain_register(&iqs62x_keys->iqs62x->nh,
+					       &iqs62x_keys->notifier);
+	if (ret)
+		dev_err(&pdev->dev, "Failed to register notifier: %d\n", ret);
+
+	return ret;
+}
+
+static int iqs62x_keys_remove(struct platform_device *pdev)
+{
+	struct iqs62x_keys_private *iqs62x_keys = platform_get_drvdata(pdev);
+	int ret;
+
+	ret = blocking_notifier_chain_unregister(&iqs62x_keys->iqs62x->nh,
+						 &iqs62x_keys->notifier);
+	if (ret)
+		dev_err(&pdev->dev, "Failed to unregister notifier: %d\n", ret);
+
+	return ret;
+}
+
+static struct platform_driver iqs62x_keys_platform_driver = {
+	.driver = {
+		.name = "iqs62x-keys",
+	},
+	.probe = iqs62x_keys_probe,
+	.remove = iqs62x_keys_remove,
+};
+module_platform_driver(iqs62x_keys_platform_driver);
+
+MODULE_AUTHOR("Jeff LaBundy <jeff@labundy.com>");
+MODULE_DESCRIPTION("Azoteq IQS620A/621/622/624/625 Keys and Switches");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:iqs62x-keys");
--
2.7.4

