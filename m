Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2B1130B09
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Jan 2020 01:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbgAFAsl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 5 Jan 2020 19:48:41 -0500
Received: from mail-bn7nam10on2068.outbound.protection.outlook.com ([40.107.92.68]:6166
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726526AbgAFAsl (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 5 Jan 2020 19:48:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nt7p5Gtev7iW0LQ7fulrIC82bj8nsFxPEu9/SV1zsX9fV6pzQzZxbebT8AZjpENdV5m2CWFNhWByN8jEfDB7teW+Zss8RthbMW5qAX5wQMF4I9KRFSbEOHQq2fYevZhUhIvOqNMPIBs7S73L7nMLxVop2eWEBCG+s5S0qTPk6AoqJ8JNinCRt9DftraCH50TdXnABvbE/WWFiVdqpLo63vMpCepc6GGaB+ruqnU5kjCvAPmlS9laPBQJvPQIowsAoUKIGhBqfiEJw4G31VZyWmjt7Ai0Bepb3plzf+dciDR9UVaj5XxWzqnjzS0GZUUDh7kJuw8LXrS+Xtc+bBz0Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Li827rvCjFoukrwEuJCYFzKDpwnBcdSnmR/hT+FlhKk=;
 b=HbhImZJh0qQiO6jVoyMrVd+AKYv75jB1P45OmPfgzMFOh9J36FcgzCAa76+9Bz4BR9+JF//UMDuBvLlBVvmhoS6p+JW5sjTqfBMV9HBhLFmdTFNgzMcILw8Nalcty3+tuJhcGIVNsYhlPwO2qaW1ZQpfvmjVXcmZ99l6pFQNeQVwprCuigjeJ0awaCX6APgxmOxnYsPZJdAb1HrGdyg5D0qywXz2RxVcbqxO47RL95P6HsPQzVLFtJcCvkOt0ydA8Pjt7GMW+ufzJXuftPkcAsAJboQVxpLlAGNhZhM6sQnOqxOnGL9FqXexszrp2Pg9KuWReTBNhqS4Wd7GVFN//Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Li827rvCjFoukrwEuJCYFzKDpwnBcdSnmR/hT+FlhKk=;
 b=Ko6xbLyAT0p4oEhw6LocgV7AwIntFxMken4SiXqP8S01djjnPREWYWT2ucYCfHiXW10lUi2uKKS4AD5VJt5M2xrUeQ52pbgqbCVgFGhKo8EhR3d8a135cMIPFY5SoTYrlxYTGUs/jf1TSGS4EFhm6s8D1YwHIZ/YwAel+J/8EHA=
Received: from SN6PR08MB5053.namprd08.prod.outlook.com (52.135.107.153) by
 SN6PR08MB4175.namprd08.prod.outlook.com (52.135.69.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Mon, 6 Jan 2020 00:48:02 +0000
Received: from SN6PR08MB5053.namprd08.prod.outlook.com
 ([fe80::7c80:2b62:5d9a:2139]) by SN6PR08MB5053.namprd08.prod.outlook.com
 ([fe80::7c80:2b62:5d9a:2139%4]) with mapi id 15.20.2602.015; Mon, 6 Jan 2020
 00:48:02 +0000
Received: from localhost.localdomain (136.49.227.119) by SN4PR0701CA0020.namprd07.prod.outlook.com (2603:10b6:803:28::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2602.13 via Frontend Transport; Mon, 6 Jan 2020 00:48:01 +0000
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
Subject: [PATCH v3 3/7] input: keyboard: Add support for Azoteq
 IQS620A/621/622/624/625
Thread-Topic: [PATCH v3 3/7] input: keyboard: Add support for Azoteq
 IQS620A/621/622/624/625
Thread-Index: AQHVxCryRi1p6AWP10yXqEUZq0D5Iw==
Date:   Mon, 6 Jan 2020 00:48:02 +0000
Message-ID: <1578271620-2159-4-git-send-email-jeff@labundy.com>
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
x-ms-office365-filtering-correlation-id: 3c5ee51d-6872-4f8a-cb47-08d792421546
x-ms-traffictypediagnostic: SN6PR08MB4175:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR08MB4175B2F5739D5561ED2119A8D33C0@SN6PR08MB4175.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 0274272F87
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39830400003)(136003)(376002)(346002)(34096005)(199004)(189003)(36756003)(107886003)(2616005)(956004)(316002)(69590400006)(5660300002)(86362001)(6486002)(508600001)(2906002)(4326008)(6506007)(81166006)(110136005)(6512007)(54906003)(16526019)(26005)(8676002)(186003)(7416002)(8936002)(66476007)(71200400001)(52116002)(66946007)(30864003)(66446008)(66556008)(64756008)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR08MB4175;H:SN6PR08MB5053.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: labundy.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X/eQ2guczIpmkIFjcXeVmCxx9/8nlGYsl409iMGwI+4SJmdHckrfCwLVDx6kvcfJHKVjXnEPVVj41zXSsssholrRWjZ+4GTcDjhRcau2vtHHfWO8slXsdZI4R6fMrxmBAmRi/RqMy2C7LvlOil1J32WHehu4zpyAoP3nUIGaWMEvRFghZDgg4cs/hISaprlXDn6gyX5P+s6Swg0mQR5MwD1IPO1b7lXPnfCN4CchHb83Rv6zLtZ0hfoOUfxTTIUxAlL4JEVfJyaKDBE+CIxZw5KgN/6A2LX9QxsrZiw9hMP0qFOM8NiiO5vKsKYXdOFHYXTKyolslOBDZbWMBEa2hc+BOCXolx96MJU5fJGq3shi1YxMsE91VU8BZYfQlQ8rsWEVO8b0mxxkre+uH1cwNGfaqy+b9qnhS14Mj8Qd3mIRhHslnUXAQIt2sugUbE6KaAY55q1K7BD8W6hYJKzdzNHt3juLiltD1wccTCo3EP0cji2DA75dl3H6o2WFru1u
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c5ee51d-6872-4f8a-cb47-08d792421546
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2020 00:48:02.0531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3ngHQ8b+nmvu3rT9XAi8AGEFwTfdupAUx5inpWQ+EjPv/Mjf1Uoji7JIT7fZcOnYbw/eh50BISvcfpMlGa59bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4175
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This patch adds key and switch support for the Azoteq IQS620A,
IQS621, IQS622, IQS624 and IQS625 multi-function sensors.

Signed-off-by: Jeff LaBundy <jeff@labundy.com>
---
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
 drivers/input/keyboard/iqs62x-keys.c | 340 +++++++++++++++++++++++++++++++=
++++
 3 files changed, 351 insertions(+)
 create mode 100644 drivers/input/keyboard/iqs62x-keys.c

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfi=
g
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
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makef=
ile
index f5b1752..1d689fd 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_KEYBOARD_TCA8418)		+=3D tca8418_keypad.o
 obj-$(CONFIG_KEYBOARD_HIL)		+=3D hil_kbd.o
 obj-$(CONFIG_KEYBOARD_HIL_OLD)		+=3D hilkbd.o
 obj-$(CONFIG_KEYBOARD_IPAQ_MICRO)	+=3D ipaq-micro-keys.o
+obj-$(CONFIG_KEYBOARD_IQS62X)		+=3D iqs62x-keys.o
 obj-$(CONFIG_KEYBOARD_IMX)		+=3D imx_keypad.o
 obj-$(CONFIG_KEYBOARD_IMX_SC_KEY)	+=3D imx_sc_key.o
 obj-$(CONFIG_KEYBOARD_HP6XX)		+=3D jornada680_kbd.o
diff --git a/drivers/input/keyboard/iqs62x-keys.c b/drivers/input/keyboard/=
iqs62x-keys.c
new file mode 100644
index 0000000..b477334
--- /dev/null
+++ b/drivers/input/keyboard/iqs62x-keys.c
@@ -0,0 +1,340 @@
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
+static const char * const iqs62x_switch_names[] =3D {
+	[IQS62X_SW_HALL_N] =3D "hall-switch-north",
+	[IQS62X_SW_HALL_S] =3D "hall-switch-south",
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
+	ret =3D device_property_read_u32_array(&pdev->dev, "linux,keycodes",
+					     NULL, 0);
+	if (ret > IQS62X_NUM_KEYS) {
+		dev_err(&pdev->dev, "Too many keycodes present\n");
+		return -EINVAL;
+	} else if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to count keycodes: %d\n", ret);
+		return ret;
+	}
+	iqs62x_keys->keycodemax =3D ret;
+
+	ret =3D device_property_read_u32_array(&pdev->dev, "linux,keycodes",
+					     iqs62x_keys->keycode,
+					     iqs62x_keys->keycodemax);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to read keycodes: %d\n", ret);
+		return ret;
+	}
+
+	for (i =3D 0; i < ARRAY_SIZE(iqs62x_keys->switches); i++) {
+		child =3D device_get_named_child_node(&pdev->dev,
+						    iqs62x_switch_names[i]);
+		if (!child)
+			continue;
+
+		ret =3D fwnode_property_read_u32(child, "linux,code", &val);
+		if (ret) {
+			dev_err(&pdev->dev, "Failed to read switch code: %d\n",
+				ret);
+			return ret;
+		}
+		iqs62x_keys->switches[i].code =3D val;
+		iqs62x_keys->switches[i].enabled =3D true;
+
+		if (fwnode_property_present(child, "azoteq,use-prox"))
+			iqs62x_keys->switches[i].flag =3D (i =3D=3D IQS62X_SW_HALL_N ?
+							 IQS62X_EVENT_HALL_N_P :
+							 IQS62X_EVENT_HALL_S_P);
+		else
+			iqs62x_keys->switches[i].flag =3D (i =3D=3D IQS62X_SW_HALL_N ?
+							 IQS62X_EVENT_HALL_N_T :
+							 IQS62X_EVENT_HALL_S_T);
+	}
+
+	return 0;
+}
+
+static int iqs62x_keys_init(struct iqs62x_keys_private *iqs62x_keys)
+{
+	struct iqs62x_core *iqs62x =3D iqs62x_keys->iqs62x;
+	enum iqs62x_event_flag flag;
+	unsigned int event_mask_reg;
+	unsigned int event_mask =3D 0;
+	unsigned int val;
+	int ret, i;
+
+	switch (iqs62x->dev_desc->prod_num) {
+	case IQS620_PROD_NUM:
+	case IQS621_PROD_NUM:
+	case IQS622_PROD_NUM:
+		event_mask_reg =3D IQS620_GLBL_EVENT_MASK;
+
+		/*
+		 * Discreet button, hysteresis and SAR UI flags represent keys
+		 * and are unmasked if mapped to a valid keycode.
+		 */
+		for (i =3D 0; i < iqs62x_keys->keycodemax; i++) {
+			if (iqs62x_keys->keycode[i] =3D=3D KEY_RESERVED)
+				continue;
+
+			if (iqs62x_events[i].reg =3D=3D IQS62X_EVENT_PROX)
+				event_mask |=3D iqs62x->dev_desc->prox_mask;
+			else if (iqs62x_events[i].reg =3D=3D IQS62X_EVENT_HYST)
+				event_mask |=3D (iqs62x->dev_desc->hyst_mask |
+					       iqs62x->dev_desc->sar_mask);
+		}
+
+		ret =3D regmap_read(iqs62x->map, iqs62x->dev_desc->hall_flags,
+				  &val);
+		if (ret)
+			return ret;
+
+		/*
+		 * Hall UI flags represent switches and are unmasked if their
+		 * corresponding child nodes are present.
+		 */
+		for (i =3D 0; i < ARRAY_SIZE(iqs62x_keys->switches); i++) {
+			if (!(iqs62x_keys->switches[i].enabled))
+				continue;
+
+			flag =3D iqs62x_keys->switches[i].flag;
+
+			if (iqs62x_events[flag].reg !=3D IQS62X_EVENT_HALL)
+				continue;
+
+			event_mask |=3D iqs62x->dev_desc->hall_mask;
+
+			input_report_switch(iqs62x_keys->input,
+					    iqs62x_keys->switches[i].code,
+					    (val & iqs62x_events[flag].mask) =3D=3D
+					    iqs62x_events[flag].val);
+		}
+
+		input_sync(iqs62x_keys->input);
+		break;
+
+	case IQS624_PROD_NUM:
+		event_mask_reg =3D IQS624_HALL_UI;
+
+		/*
+		 * Interval change events represent keys and are unmasked if
+		 * either wheel movement flag is mapped to a valid keycode.
+		 */
+		if (iqs62x_keys->keycode[IQS62X_EVENT_WHEEL_UP] !=3D KEY_RESERVED)
+			event_mask |=3D IQS624_HALL_UI_INT_EVENT;
+
+		if (iqs62x_keys->keycode[IQS62X_EVENT_WHEEL_DN] !=3D KEY_RESERVED)
+			event_mask |=3D IQS624_HALL_UI_INT_EVENT;
+
+		ret =3D regmap_read(iqs62x->map, iqs62x->dev_desc->interval,
+				  &val);
+		if (ret)
+			return ret;
+
+		iqs62x_keys->interval =3D val;
+		break;
+
+	default:
+		return 0;
+	}
+
+	return regmap_update_bits(iqs62x->map, event_mask_reg, event_mask, 0);
+}
+
+static int iqs62x_keys_notifier(struct notifier_block *notifier,
+				unsigned long event_flags, void *context)
+{
+	struct iqs62x_event_data *event_data =3D context;
+	struct iqs62x_keys_private *iqs62x_keys;
+	int ret, i;
+
+	iqs62x_keys =3D container_of(notifier, struct iqs62x_keys_private,
+				   notifier);
+
+	if (event_flags & BIT(IQS62X_EVENT_SYS_RESET)) {
+		ret =3D iqs62x_keys_init(iqs62x_keys);
+		if (ret) {
+			dev_err(iqs62x_keys->input->dev.parent,
+				"Failed to re-initialize device: %d\n", ret);
+			return NOTIFY_BAD;
+		}
+
+		return NOTIFY_OK;
+	}
+
+	for (i =3D 0; i < iqs62x_keys->keycodemax; i++) {
+		if (iqs62x_events[i].reg =3D=3D IQS62X_EVENT_WHEEL &&
+		    event_data->interval =3D=3D iqs62x_keys->interval)
+			continue;
+
+		input_report_key(iqs62x_keys->input, iqs62x_keys->keycode[i],
+				 event_flags & BIT(i));
+	}
+
+	for (i =3D 0; i < ARRAY_SIZE(iqs62x_keys->switches); i++)
+		if (iqs62x_keys->switches[i].enabled)
+			input_report_switch(iqs62x_keys->input,
+					    iqs62x_keys->switches[i].code,
+					    event_flags &
+					    BIT(iqs62x_keys->switches[i].flag));
+
+	input_sync(iqs62x_keys->input);
+
+	if (event_data->interval =3D=3D iqs62x_keys->interval)
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
+	iqs62x_keys->interval =3D event_data->interval;
+
+	return NOTIFY_OK;
+}
+
+static int iqs62x_keys_probe(struct platform_device *pdev)
+{
+	struct iqs62x_core *iqs62x =3D dev_get_drvdata(pdev->dev.parent);
+	struct iqs62x_keys_private *iqs62x_keys;
+	struct input_dev *input;
+	int ret, i;
+
+	iqs62x_keys =3D devm_kzalloc(&pdev->dev, sizeof(*iqs62x_keys),
+				   GFP_KERNEL);
+	if (!iqs62x_keys)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, iqs62x_keys);
+
+	ret =3D iqs62x_keys_parse_prop(pdev, iqs62x_keys);
+	if (ret)
+		return ret;
+
+	input =3D devm_input_allocate_device(&pdev->dev);
+	if (!input)
+		return -ENOMEM;
+
+	input->keycodemax =3D iqs62x_keys->keycodemax;
+	input->keycode =3D iqs62x_keys->keycode;
+	input->keycodesize =3D sizeof(*iqs62x_keys->keycode);
+
+	input->name =3D iqs62x->dev_desc->dev_name;
+	input->id.bustype =3D BUS_I2C;
+
+	__set_bit(EV_KEY, input->evbit);
+
+	for (i =3D 0; i < iqs62x_keys->keycodemax; i++)
+		__set_bit(iqs62x_keys->keycode[i], input->keybit);
+
+	__clear_bit(KEY_RESERVED, input->keybit);
+
+	for (i =3D 0; i < ARRAY_SIZE(iqs62x_keys->switches); i++)
+		if (iqs62x_keys->switches[i].enabled) {
+			__set_bit(EV_SW, input->evbit);
+			__set_bit(iqs62x_keys->switches[i].code, input->swbit);
+		}
+
+	iqs62x_keys->iqs62x =3D iqs62x;
+	iqs62x_keys->input =3D input;
+
+	ret =3D iqs62x_keys_init(iqs62x_keys);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to initialize device: %d\n", ret);
+		return ret;
+	}
+
+	ret =3D input_register_device(iqs62x_keys->input);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to register device: %d\n", ret);
+		return ret;
+	}
+
+	iqs62x_keys->notifier.notifier_call =3D iqs62x_keys_notifier;
+	ret =3D blocking_notifier_chain_register(&iqs62x_keys->iqs62x->nh,
+					       &iqs62x_keys->notifier);
+	if (ret)
+		dev_err(&pdev->dev, "Failed to register notifier: %d\n", ret);
+
+	return ret;
+}
+
+static int iqs62x_keys_remove(struct platform_device *pdev)
+{
+	struct iqs62x_keys_private *iqs62x_keys =3D platform_get_drvdata(pdev);
+	int ret;
+
+	ret =3D blocking_notifier_chain_unregister(&iqs62x_keys->iqs62x->nh,
+						 &iqs62x_keys->notifier);
+	if (ret)
+		dev_err(&pdev->dev, "Failed to unregister notifier: %d\n", ret);
+
+	return ret;
+}
+
+static struct platform_driver iqs62x_keys_platform_driver =3D {
+	.driver =3D {
+		.name =3D IQS62X_DRV_NAME_KEYS,
+	},
+	.probe =3D iqs62x_keys_probe,
+	.remove =3D iqs62x_keys_remove,
+};
+module_platform_driver(iqs62x_keys_platform_driver);
+
+MODULE_AUTHOR("Jeff LaBundy <jeff@labundy.com>");
+MODULE_DESCRIPTION("Azoteq IQS620A/621/622/624/625 Keys and Switches");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" IQS62X_DRV_NAME_KEYS);
--
2.7.4

