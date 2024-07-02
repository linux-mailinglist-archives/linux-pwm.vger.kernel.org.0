Return-Path: <linux-pwm+bounces-2661-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7522092435A
	for <lists+linux-pwm@lfdr.de>; Tue,  2 Jul 2024 18:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B5062820AF
	for <lists+linux-pwm@lfdr.de>; Tue,  2 Jul 2024 16:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F11C1BD01E;
	Tue,  2 Jul 2024 16:12:16 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2124.outbound.protection.partner.outlook.cn [139.219.17.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D551BD005;
	Tue,  2 Jul 2024 16:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719936736; cv=fail; b=XQ1ytYhdNK6B3lS7f4ZpZXuC2Fr8GDI3bx4Q8DzWx96cfvWdqs2/i+Y60yOk8zm28h/EGbEWn+JmzLp1EUt4bkSBuUsDFRr12i+2vqsSHy4jwwORDCGvYuUkRa8MWbHu/1W3/PB0sVcBorGLRKDuR9FZyxK1lpzpEoibAf4HNfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719936736; c=relaxed/simple;
	bh=H+MkEpSJDEA6jLZWK7X/rF6aojMSyuOq8x3XTbiSqTw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=CzF0u88FufdPsMYXKJeEAyXRJZ4dYC7QBXew4rWDIffcZhNwtE54g/j2Hpi/QzsHzM6o6B2gEGoftFKLCNYPM3uwZ+s9o35w+QXfpB9SaWBeU3gn1CaycNflGWKuAqF6UTCHPDrV18vKnCCZYmilzR12yykQvAeAVrwgB9Y5k/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fgo++4CDpFtQzq5NJF1COoXdaDuHT4PH0U1YRks2lv1dBZf4bBNkBesewUpeJZu5TZZyHiTVWHMXQJGiTqxynImlNZDEAWet6pvPu4XKPP+os9n9686EliVRM4BLikihML+y0/drQ85sVAG9f5fTT8WGpeddl7vYmw/94x5MlkqZUVxmcvO/8nfZ+ReWHPklylkvu4XGeVzftVL0s+gK+wQU0pskrfMiFud0id/8p5R/OZWdFEWOnzS1ZpiW6aqFL6yHRCfkR5pXa2/fzMJ47DtMnXSQDy9q9sfb2AVA6faUmccStSYMHD0+rmHl0XZyDbhkUKwV95Z5oVia3t24WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/wc3JHW7ZyfdZkH3xq9SghEtwdsdyQT4U+9UVo0hzA=;
 b=FMP+OuhfN9uFKGMcHzdRshdoNvO4R58UdgEo0FFaeheOTfYFUt57a/t5d8TPmpFd+j9Hg+8NunWks9Pff6zZfflf8S0hPdOUxix0rPJZwLwvESleVWOloBWHPM+gCw+iO9NSZjRvlFdQTvt9FbxnhIWdWvT3v4Y/sSYQOdc2G4g0xb5dqL6A5NNRrE1BSHXqpABurxWkiEu6dzNX8o697ZC4aUil3IBp2AJ9k+jNsk67raSF0RnM1YNhPOX/sjloCpQqBBaZ+l+NiN5bQz2gdqSZefn5P2kRTkZbq+pHh1isKlrIZKaZqVJ0PE+FEiaB41HyJ2AL+Z3R4xdE8QzjfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::8) by ZQ0PR01MB1096.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Tue, 2 Jul
 2024 08:38:54 +0000
Received: from ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
 ([fe80::6e83:b5ba:ad4b:3ad2]) by
 ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn ([fe80::6e83:b5ba:ad4b:3ad2%4])
 with mapi id 15.20.7719.029; Tue, 2 Jul 2024 08:38:54 +0000
From: William Qiu <william.qiu@starfivetech.com>
To: linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Hal Feng <hal.feng@starfivetech.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	William Qiu <william.qiu@starfivetech.com>
Subject: [PATCH v13] pwm: opencores: Add PWM driver support
Date: Tue,  2 Jul 2024 16:38:48 +0800
Message-Id: <20240702083848.1947449-1-william.qiu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0020.CHNPR01.prod.partner.outlook.cn (10.2.0.201)
 To ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn (10.2.3.232)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1253:EE_|ZQ0PR01MB1096:EE_
X-MS-Office365-Filtering-Correlation-Id: b0c41bb2-38b1-401f-3b28-08dc9a726808
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|41320700013|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	bXlXGidI/FTdASRqWac8EAzFI0vRW20+Vf3Sy7xEiNG9U7WSyGkSW0IxaVGD9tnK3cyiLH4eFrY/Gk1NCg3Zmiy7tiEujvM3ycWwT5DSc+nZtsaGDBhLo3/BP4NAijB0pvUkMab2YSiUI6ddDZBODGBWv2rTYIYDKOsHRU9CvEFATfvNJvch792P4+iEf+ebHsE8WeiIIsgmGvbA3tntNfUunoawr0/GQVUYi9uW6NCuF0r7foQYO9N0Xe9N39aF/T6FSoXJbX/mKFdityEiggbc7eyyYgkuPwzpxpa3VlKVbyUpTyUSJf/v6E8aYWwjZrLnVgTWugL67pM5gjhaN92EXDlKYn9AwEMVzAgY5/1UuQKUqSYuSnWT4ZFB56lpne7Zb3bxjuHCFfcUqqUaceHZq1khlHmRDQe9GnxejirwQBn33H4YnbpuANRwuGKMn6Xe7sik3DptxDtME0ekDiSlWnyFEpkZ8H9xAFu4+5flEBnWrV3OxNinydhHAcwgdGU4IgTXBSnhGENKBUMarxxkU6K00Dllad9K9TaLe88FdTUWuar/ZEb7nslGt8VVVXTuZmwG/kjuNzf55H13Oy9TUaX/20W3M591PZGFuCi8VFOjwb1gY6MOdi5Odxe7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(41320700013)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Irz3sUL8UBRdJ4gtnNwQbrCOMDHJJss30ElGPht+e7FeRVCfpAPnmBknMkld?=
 =?us-ascii?Q?LKwozI8I1mkqU8Kk5bCKXU72fB9JvTy6dM65Fs6AQI1JyDeJhPHi7+QnQWnH?=
 =?us-ascii?Q?lX4YJ6XwbgYUCLn4QmiPfQtetx8bx+ycynIvTpHpLyXeR9t0OYQuGPAK+U48?=
 =?us-ascii?Q?eKf/QLiZMgnqohwldMX3Kp7uNOchSSAjFVBJjxUcy5cm/+8+w3pWDVBAaMZ3?=
 =?us-ascii?Q?/kKwQvqaYqr5VuV/s6iovFQNRAOynBazL9YQJn0O2woNFpHfeyzbgX+zpu1r?=
 =?us-ascii?Q?Jyy/LtM9B7Rkskigjjy0iky8jwW1vh024V3AEF95H8/eUGGe4ZqnatDTsIZU?=
 =?us-ascii?Q?4FUjE+88aI3jm5ZlDMEWdA2dHQNbWBisP/PADW9Mi9f1vOErwFze6Pv42Vqa?=
 =?us-ascii?Q?EsCYcF1OQr8KYqe1U0d1/R1iECb8wklqXRFkQLFBJoYg7yx861pIoufYIoIj?=
 =?us-ascii?Q?CgLD5S1yuZs4oHY07bVRjFi+ZcTNn6LaCI7pLhpngyISo+4Hq6zAdmsYKUxg?=
 =?us-ascii?Q?Uzo0VbfexI+Clf3aMqsvbsvA+QhuKJB37Ihkgr80+H6ueWH6S5te7e5Kw5nk?=
 =?us-ascii?Q?9e8L8uvcvjLawI1154Y/mSxUxqOltNz1+RWvMD8H/13nigmVjdrRgzKalOBY?=
 =?us-ascii?Q?X55wtYXJodcGl6Pniw9EnIJVdTK0mnTvhCTHMlvz9Gbo/wsCUvW999CK4/8u?=
 =?us-ascii?Q?tw0ot1XR26AwY4UMr8qj+Hmi3qOCvu3O8tSC7w08EAgPATc42Rx+UMx3u9qg?=
 =?us-ascii?Q?47eXCubGDg5xxKvYY4L2t/tTXFabVcHqAAGLDOvb/NoFW0n2ng5ilIhTjbGI?=
 =?us-ascii?Q?pYX3nyz0mcJFQb/PFjgRP3Al6EWMuJSaCl6y+7Duwbo4Lc67YbOKSENbcSQk?=
 =?us-ascii?Q?g2fxFUE0masbqq+6/Nh0K6rBSAQB50CtIvMuNvW32droc5C/J0dZk+MEd91H?=
 =?us-ascii?Q?Ymjq10Y2biKZhN9v3qAOm4Nz0xAy/c1vGJFmQBpl5usZQkZljR49/JQh+/XV?=
 =?us-ascii?Q?Xdg56C7DqE7H1YzdG/nc2Hh7rqNEmoMqey0OUUWznwzD6GhOOPVgXp7T7PeM?=
 =?us-ascii?Q?n0K9OCwhkpglAhC4CxTyylS5bfSiSTT6J03t8QGWQlRYG8vGL2Lq8Qo1c95F?=
 =?us-ascii?Q?mHpd26FMcQ4hONOjvM2BiwBpnNHQXLmiDr3JS5i9OfhA+z015/J7oegtWH9D?=
 =?us-ascii?Q?WG0gyLxEPItvkq+fp5sfL1E8aRErjE/Rjjss02QJwBkjrg/SA2htDHM6OYsE?=
 =?us-ascii?Q?MqI60FJXGGpN8QDmGQT2/3SlU6YV570crnpSJydv0u4lMI7Jay44ZpYE3mIT?=
 =?us-ascii?Q?f3828hkBYUtcx5ayw/z331l0d7yI8zcj8t/kvjhFjiw8ID4cALW2KuK03Lwe?=
 =?us-ascii?Q?aTsHAIShG/fg6RqLmKGZE4pFEpU28KXXzeE63u1/zcUXCpOMAQUI4Gt9Cg8Y?=
 =?us-ascii?Q?v1E+WUEy8pD4INdGcedRLdaX4IdBfKghKfUSqAdtV8SCqhv0O3ToTJwQSQZG?=
 =?us-ascii?Q?O/Uij34Qk/zk7RcUc/NtDzSMpPmUG/s+V32MsxX5Rc816UpKHlqxmuHbjzPq?=
 =?us-ascii?Q?B2zzMEPBRUTsiW4+SJe+o3Eg91Zhiz/Wehkor0I01woDhjby0lH3f3d4T4rA?=
 =?us-ascii?Q?QQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0c41bb2-38b1-401f-3b28-08dc9a726808
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 08:38:54.3313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s+aCqdE9mvVzP8pirVtg1XXJ1UaBUUA0SXS+YNf/nn6ViEcqShw8QRHtqOxeIusepdZ01E6gpN7DL6VrRe0Th8AOA0be0jSAzjkh9jQfpQk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1096

Add driver for OpenCores PWM Controller. And add compatibility code
which based on StarFive SoC.

Co-developed-by: Hal Feng <hal.feng@starfivetech.com>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
Signed-off-by: William Qiu <william.qiu@starfivetech.com>
---
 MAINTAINERS              |   7 ++
 drivers/pwm/Kconfig      |  12 ++
 drivers/pwm/Makefile     |   1 +
 drivers/pwm/pwm-ocores.c | 239 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 259 insertions(+)
 create mode 100644 drivers/pwm/pwm-ocores.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3c4fdf74a3f9..3b547ede2ce5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16824,6 +16824,13 @@ F:	Documentation/i2c/busses/i2c-ocores.rst
 F:	drivers/i2c/busses/i2c-ocores.c
 F:	include/linux/platform_data/i2c-ocores.h
 
+OPENCORES PWM DRIVER
+M:	William Qiu <william.qiu@starfivetech.com>
+M:	Hal Feng <hal.feng@starfivetech.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/pwm/opencores,pwm.yaml
+F:	drivers/pwm/pwm-ocores.c
+
 OPENRISC ARCHITECTURE
 M:	Jonas Bonn <jonas@southpole.se>
 M:	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 1dd7921194f5..42158bc1c8bc 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -440,6 +440,18 @@ config PWM_NTXEC
 	  controller found in certain e-book readers designed by the original
 	  design manufacturer Netronix.
 
+config PWM_OCORES
+	tristate "OpenCores PTC PWM support"
+	depends on HAS_IOMEM && OF
+	depends on COMMON_CLK && RESET_CONTROLLER
+	depends on ARCH_STARFIVE || COMPILE_TEST
+	help
+	  If you say yes to this option, support will be included for the
+	  OpenCores PWM. For details see https://opencores.org/projects/ptc.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-ocores.
+
 config PWM_OMAP_DMTIMER
 	tristate "OMAP Dual-Mode Timer PWM support"
 	depends on OF
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 90913519f11a..7a44d8afe044 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_PWM_MICROCHIP_CORE)	+= pwm-microchip-core.o
 obj-$(CONFIG_PWM_MTK_DISP)	+= pwm-mtk-disp.o
 obj-$(CONFIG_PWM_MXS)		+= pwm-mxs.o
 obj-$(CONFIG_PWM_NTXEC)		+= pwm-ntxec.o
+obj-$(CONFIG_PWM_OCORES)	+= pwm-ocores.o
 obj-$(CONFIG_PWM_OMAP_DMTIMER)	+= pwm-omap-dmtimer.o
 obj-$(CONFIG_PWM_PCA9685)	+= pwm-pca9685.o
 obj-$(CONFIG_PWM_PXA)		+= pwm-pxa.o
diff --git a/drivers/pwm/pwm-ocores.c b/drivers/pwm/pwm-ocores.c
new file mode 100644
index 000000000000..c8f08aa14e44
--- /dev/null
+++ b/drivers/pwm/pwm-ocores.c
@@ -0,0 +1,239 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * OpenCores PWM Driver
+ *
+ * https://opencores.org/projects/ptc
+ *
+ * Copyright (C) 2018-2023 StarFive Technology Co., Ltd.
+ *
+ * Limitations:
+ * - The hardware only supports inverted polarity.
+ * - The hardware minimum period / duty_cycle is (1 / pwm_apb clock frequency) ns.
+ * - The hardware maximum period / duty_cycle is (U32_MAX / pwm_apb clock frequency) ns.
+ * - The hardware is set to a low level immediately when disabledThe hardware is set to
+ *   a low level immediately when disabled.
+ * - The hardware will have a conversion cycle when reconfiguring.
+ */
+
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/reset.h>
+#include <linux/slab.h>
+
+/* OpenCores Register offsets */
+#define REG_OCPWM_CNTR    0x0
+#define REG_OCPWM_HRC     0x4
+#define REG_OCPWM_LRC     0x8
+#define REG_OCPWM_CTRL    0xC
+
+/* OCPWM_CTRL register bits*/
+#define REG_OCPWM_CNTR_EN      BIT(0)
+#define REG_OCPWM_CNTR_ECLK    BIT(1)
+#define REG_OCPWM_CNTR_NEC     BIT(2)
+#define REG_OCPWM_CNTR_OE      BIT(3)
+#define REG_OCPWM_CNTR_SIGNLE  BIT(4)
+#define REG_OCPWM_CNTR_INTE    BIT(5)
+#define REG_OCPWM_CNTR_INT     BIT(6)
+#define REG_OCPWM_CNTR_RST     BIT(7)
+#define REG_OCPWM_CNTR_CAPTE   BIT(8)
+
+struct ocores_pwm_device {
+	const struct ocores_pwm_data *data;
+	void __iomem *regs;
+	u32 clk_rate; /* PWM APB clock frequency */
+};
+
+struct ocores_pwm_data {
+	void __iomem *(*get_ch_base)(void __iomem *base, unsigned int channel);
+};
+
+static inline u32 ocores_pwm_readl(struct ocores_pwm_device *ddata,
+				   unsigned int channel,
+				   unsigned int offset)
+{
+	void __iomem *base = ddata->data->get_ch_base ?
+			     ddata->data->get_ch_base(ddata->regs, channel) : ddata->regs;
+
+	return readl(base + offset);
+}
+
+static inline void ocores_pwm_writel(struct ocores_pwm_device *ddata,
+				     unsigned int channel,
+				     unsigned int offset, u32 val)
+{
+	void __iomem *base = ddata->data->get_ch_base ?
+			     ddata->data->get_ch_base(ddata->regs, channel) : ddata->regs;
+
+	writel(val, base + offset);
+}
+
+static inline struct ocores_pwm_device *chip_to_ocores(struct pwm_chip *chip)
+{
+	return pwmchip_get_drvdata(chip);
+}
+
+static void __iomem *starfive_get_ch_base(void __iomem *base,
+					  unsigned int channel)
+{
+	unsigned int offset = (channel & 4) << 13 | (channel & 3) << 4;
+
+	return base + offset;
+}
+
+static int ocores_pwm_get_state(struct pwm_chip *chip,
+				struct pwm_device *pwm,
+				struct pwm_state *state)
+{
+	struct ocores_pwm_device *ddata = chip_to_ocores(chip);
+	u32 period_data, duty_data, ctrl_data;
+
+	period_data = ocores_pwm_readl(ddata, pwm->hwpwm, REG_OCPWM_LRC);
+	duty_data = ocores_pwm_readl(ddata, pwm->hwpwm, REG_OCPWM_HRC);
+	ctrl_data = ocores_pwm_readl(ddata, pwm->hwpwm, REG_OCPWM_CTRL);
+
+	state->period = DIV_ROUND_UP_ULL((u64)period_data * NSEC_PER_SEC, ddata->clk_rate);
+	state->duty_cycle = DIV_ROUND_UP_ULL((u64)duty_data * NSEC_PER_SEC, ddata->clk_rate);
+	state->polarity = PWM_POLARITY_INVERSED;
+	state->enabled = (ctrl_data & REG_OCPWM_CNTR_EN) ? true : false;
+
+	return 0;
+}
+
+static int ocores_pwm_apply(struct pwm_chip *chip,
+			    struct pwm_device *pwm,
+			    const struct pwm_state *state)
+{
+	struct ocores_pwm_device *ddata = chip_to_ocores(chip);
+	u32 ctrl_data = 0;
+	u64 period_data, duty_data;
+
+	if (state->polarity != PWM_POLARITY_INVERSED)
+		return -EINVAL;
+
+	period_data = mul_u64_u32_div(state->period, ddata->clk_rate, NSEC_PER_SEC);
+	if (!period_data)
+		return -EINVAL;
+
+	if (period_data > U32_MAX)
+		period_data = U32_MAX;
+
+	ocores_pwm_writel(ddata, pwm->hwpwm, 0x8, (u32)period_data);
+
+	duty_data = mul_u64_u32_div(state->duty_cycle, ddata->clk_rate, NSEC_PER_SEC);
+	if (duty_data <= U32_MAX)
+		ocores_pwm_writel(ddata, pwm->hwpwm, REG_OCPWM_HRC, (u32)duty_data);
+	else if (duty_data > U32_MAX)
+		duty_data = U32_MAX;
+	else
+		return -EINVAL;
+
+	ctrl_data = ocores_pwm_readl(ddata, pwm->hwpwm, REG_OCPWM_CTRL);
+	if (state->enabled)
+		ocores_pwm_writel(ddata, pwm->hwpwm, REG_OCPWM_CTRL,
+				  ctrl_data | REG_OCPWM_CNTR_EN | REG_OCPWM_CNTR_OE);
+	else
+		ocores_pwm_writel(ddata, pwm->hwpwm, REG_OCPWM_CTRL,
+				  ctrl_data & ~(REG_OCPWM_CNTR_EN | REG_OCPWM_CNTR_OE));
+
+	return 0;
+}
+
+static const struct pwm_ops ocores_pwm_ops = {
+	.get_state = ocores_pwm_get_state,
+	.apply = ocores_pwm_apply,
+};
+
+static const struct ocores_pwm_data starfive_pwm_data = {
+	.get_ch_base = starfive_get_ch_base,
+};
+
+static const struct of_device_id ocores_pwm_of_match[] = {
+	{ .compatible = "opencores,pwm-v1" },
+	{ .compatible = "starfive,jh7100-pwm", .data = &starfive_pwm_data},
+	{ .compatible = "starfive,jh7110-pwm", .data = &starfive_pwm_data},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, ocores_pwm_of_match);
+
+static void ocores_pwm_reset_control_assert(void *data)
+{
+	reset_control_assert(data);
+}
+
+static int ocores_pwm_probe(struct platform_device *pdev)
+{
+	const struct of_device_id *id;
+	struct device *dev = &pdev->dev;
+	struct ocores_pwm_device *ddata;
+	struct pwm_chip *chip;
+	struct clk *clk;
+	struct reset_control *rst;
+	int ret;
+
+	id = of_match_device(ocores_pwm_of_match, dev);
+	if (!id)
+		return -EINVAL;
+
+	chip = devm_pwmchip_alloc(&pdev->dev, 8, sizeof(*ddata));
+	if (IS_ERR(chip))
+		return -ENOMEM;
+
+	ddata = chip_to_ocores(chip);
+	ddata->data = id->data;
+	chip->ops = &ocores_pwm_ops;
+
+	ddata->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(ddata->regs))
+		return dev_err_probe(dev, PTR_ERR(ddata->regs),
+				     "Unable to map IO resources\n");
+
+	clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk),
+				     "Unable to get pwm's clock\n");
+
+	ret = devm_clk_rate_exclusive_get(dev, clk);
+	if (ret)
+		return ret;
+
+	rst = devm_reset_control_get_optional_exclusive(dev, NULL);
+	if (IS_ERR(rst))
+		return dev_err_probe(dev, PTR_ERR(rst),
+				     "Unable to get pwm's reset\n");
+
+	reset_control_deassert(rst);
+
+	ret = devm_add_action_or_reset(dev, ocores_pwm_reset_control_assert, rst);
+	if (ret)
+		return ret;
+
+	ddata->clk_rate = clk_get_rate(clk);
+	if (ddata->clk_rate > NSEC_PER_SEC)
+		return dev_err_probe(dev, ddata->clk_rate,
+				     "Unable to get clock's rate\n");
+
+	ret = devm_pwmchip_add(dev, chip);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Could not register PWM chip\n");
+
+	return 0;
+}
+
+static struct platform_driver ocores_pwm_driver = {
+	.probe = ocores_pwm_probe,
+	.driver = {
+		.name = "ocores-pwm",
+		.of_match_table = ocores_pwm_of_match,
+	},
+};
+module_platform_driver(ocores_pwm_driver);
+
+MODULE_AUTHOR("Jieqin Chen");
+MODULE_AUTHOR("Hal Feng <hal.feng@starfivetech.com>");
+MODULE_DESCRIPTION("OpenCores PTC PWM driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1


