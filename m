Return-Path: <linux-pwm+bounces-3927-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF9F9B220E
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Oct 2024 02:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2E96B20C5F
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Oct 2024 01:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E09171C9;
	Mon, 28 Oct 2024 01:46:33 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2093.outbound.protection.partner.outlook.cn [139.219.17.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347243D66;
	Mon, 28 Oct 2024 01:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730079993; cv=fail; b=bP1sPJiyj/HL1Y1gjH4J8g4ZOrnpQq7davrHUihS8pI0BYfTXxh9LTn5BMlUF6IxSpxQaGGWFx36idqJchV/YymU8sFgt+wxp6JWR4c1luFHFmjNunZedkqn5+CS+aFAW5nJWlznxHE2wJ6XOeS+xiVGbrKS0QVqnJ3T9OHmigI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730079993; c=relaxed/simple;
	bh=KBwmjwOuMGSafqDe6k0x0vjYi5r3qiVmnkXPOZqIr2s=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UcWgEGk281yixXQJU6BfqLboT4tFWYjELNAMw1t/6ekTHiVvXEMWsRiPCvYFJF5PWUo85ngPoJdZtLvyq8yyDWjybH+xBxLSAzRn8gIjTapLeyxR5WjgP2YNtRD5dNVKMu29qGy4JjG9Lea7SdcG+WBaYL3A43ClUdfVdV6ifTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n0T2/ME095d2iyiRdLommjEAzOctuGzMIOwBbM3d/rXALjIrT4WDHgUmUCMyk8N/ot6Du6w845fLVofGnNger8OxCI4PpYNtod/TKjouc78pblSz+QtIYg6CzRXiujKnTwCYoGFKG1UhhMHVJHD3eMLKv/oWXdx+Hpe3CGdi9HeswsEygj633+YeA9Fqy69XkbR44ZWJj9EGLETRyBb527vIsY6V0WhIoZ3424QmeFKpkSZSfvV1jccE20KnvMgilrJe5xMLgEu+E/WWJMtqjRlr6/TQRQHVOIsrmX5q+4TSUeK4I+lcWuqqHksmqMFDegSW6JxcwILmZK/cj54jbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+j7If+ZgVBCb58e+d/o2OTuyYKItpYvf50CTzfj9CIE=;
 b=NYPiYIF6mifL5R49MkyDSdYxfoOATPcmdY/PosvDQWvWy/TCYIniT0Bg26ZpFDmT5LscdfWHNJY7grL9rhXJR17OBWj8vLj1wl9EZjgyUME3BMfJqgCW8wjv6ceqQlnYV3kW9+Ika3cpqXB5VKb5wW27Tu+dR7cbL23sZVRVIg0qSvsfM5BU21IJ1m9w9lFH9EwOXAJbAqM0dGTdTDtUzdlJAX6+mtY231CGPi1K+rz5Dz+xzZOU4thDam+Pbh4GxGjmOrbZk3fo5zanw3t7TFLuZqOHkCHjBPMCDljNI9DOKx0fipqrEc3xS0FSs7+BagqM4Pm4mkzggrPKeLmIkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::8) by ZQ0PR01MB0965.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.26; Mon, 28 Oct
 2024 01:46:25 +0000
Received: from ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
 ([fe80::6e83:b5ba:ad4b:3ad2]) by
 ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn ([fe80::6e83:b5ba:ad4b:3ad2%5])
 with mapi id 15.20.8069.031; Mon, 28 Oct 2024 01:46:25 +0000
From: William Qiu <william.qiu@starfivetech.com>
To: linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Hal Feng <hal.feng@starfivetech.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	William Qiu <william.qiu@starfivetech.com>
Subject: [PATCH v16] pwm: opencores: Add PWM driver support
Date: Mon, 28 Oct 2024 09:46:09 +0800
Message-ID: <20241028014609.153997-1-william.qiu@starfivetech.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0012.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::6) To ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::8)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1253:EE_|ZQ0PR01MB0965:EE_
X-MS-Office365-Filtering-Correlation-Id: 705f8d19-1766-4d1e-a1c7-08dcf6f25563
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|41320700013|38350700014;
X-Microsoft-Antispam-Message-Info:
	pQ6uIgyvPodxqEcIKcnAt8WehIJ8EP9Or9wiXJAfNPByOPLC8J7pOPmX9Pu01n4XRZZ4Bwd5DVYEvdZO3udUvHO1AKn8GYu3onJRv5g9OmSESTb4hZmiBxpHKqnnB/WCh+LcJSXFt730kpYspvCDEeF67VTwifNOfZjvwLTH9p8dRsQQDyTVoqTmCB4U+tVLwHX4/IBLYH0cwb0+F9beSLIXTPl85Bd9qv4W0nLoukf4/vfsdDqjy3JhzZW3Drv1eVuWQiobM2hGWJDfCNZ+1QrepiXRj9X982ZWXFhA6AFCTwwuyFdUh6bwMLm6aVYQBzpPdc0t9hVgsPdESPNAO8uPyTw08PvalG1+uwq9KSYSWHLVMD7AJQaclj1sYOmAxpGkoYU5Gl080Qu/LGfPDpuGLMUYwicbGC6PKL/dGEWbz3d7HtOVkHKHj4AjoxWdB5zA4SLWv26Ojcp6QFGvP83u6Tltmot4mhC7pBxWdHoI1XMGZxZA9CnkVVwIjUBYPCz4+45nqBN+uItO4C+qA/JV/stHnHcTwNZTNfvb40h0MJfg5YbZBe8CRVAamc6LU9ivhSiJ4UxJ5FS07LIUPtIAyBxi4Z/hm5cqKu292zcZu7oTVqfNaw5bvrwKtYye
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(41320700013)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xIzKD2Wpga7pkkIVXMr6aFtxukvqg6/R49Jp+RNDhvTRUDBmqw0p7TE+bpsF?=
 =?us-ascii?Q?nT805rM7FMlSDuv4eHCwcud+ibv+g0b6zrCVGNcg6nvuWlEQ+Z7j9Sh4EXFf?=
 =?us-ascii?Q?OVyOM7m1KVarP3PUPZiW3NGz7rmB+FbLLf35NLY08t8iWIRsHRxF3VHkGMqi?=
 =?us-ascii?Q?Qi5slx5tCXLUPhM9W5l0lEbf8OCnm9zaptV8kTSFvNSCpmVbp0ioL6kcC71K?=
 =?us-ascii?Q?wKR/02ZpXomO674ul/KlPKYrBhfYoMSzbLjKL406/WZAE/fAQBWkJwufR5YF?=
 =?us-ascii?Q?QISuWMxJ0KjUQnfE8/B+KZsUsZss6VX2dTy30lFzJilLLKVRut8UPkcEsny0?=
 =?us-ascii?Q?lxc1TUi+U1Abm4hyQrEW+CPNr92DZh14hrNBJxIaEBFxzcP/LOlkr3Xa2dZB?=
 =?us-ascii?Q?EtvGdnPpALVGq1LixqdY29QBgEFEGhFHbgvXgqvgHYnDKpMNoTE4NDwDnoK1?=
 =?us-ascii?Q?rx6QI7b6t5I5qjdlFr4ouMIepxRNfpiw3fNh/zb2V2eB/vY7OdrbyJAtwG2k?=
 =?us-ascii?Q?K0yYh9b4iISjSp68gS83//8vL2iBHKU8xK+nGP6v4AdP4qdkXOdgzSBhibOu?=
 =?us-ascii?Q?bTjBA7OiEy/s8kxugDK14GYhAkB8jnVplfjxitjOKynhjSM2ZrFm/yAJ43gq?=
 =?us-ascii?Q?ry8VXFAB5sJOd9pYhEZn6hyn7yVCzSfY8AowdyXM82l676JTb0YYwNRbAyC7?=
 =?us-ascii?Q?qLW1R17juAcdrVlo7Pyprv8y5FhVHpg1ssHd5ygDVwmfqTPs9C1Y1r2/yX7M?=
 =?us-ascii?Q?hqAzJehm8zFbEEg2JD5vBMNreE1lLefXfteKts9VtUCLO/8/iuUEDBQ6XhB5?=
 =?us-ascii?Q?Nlo+fEI8DO9CdDg57Xhs32+dLJwHQwS3MlWD9Z+3gZOT3b5FHtPTWXVn83qV?=
 =?us-ascii?Q?890PgtDCk1zsYX3f97rGPVJA9I0A7/04lkkDfj3FOs7EWa87VUiJAGkf3wyK?=
 =?us-ascii?Q?VC0YffpoxqkeNEcqjXfsoAh2afPAyvh/AlMKSjlz/RrZmgmkFh1jzvCwe0/c?=
 =?us-ascii?Q?BMVAq6LUGwfQLGUoLIpOWoOuH7ymwDOWtEVzjcm+GwGXMEhKCdjRhzm9nRvA?=
 =?us-ascii?Q?TIVLEsJ6edbzdoahOzWaGHVaCUmSVb0vBlnY+cuaS79xU/1tNCQFFfZStbsI?=
 =?us-ascii?Q?8k5n7/m1zI8gK27ilc2FtyBo/D7psNbY1jLXKuArRO6kGVZCfd94Hzar++dH?=
 =?us-ascii?Q?n8Msj8XESE8qS8S54t6C4A3/XpWoKPZIOV68d8P+hp3tXqZDv25Hjk83ZVoU?=
 =?us-ascii?Q?aZnf+2Af7FO/YCGSbdGEbo7xpP5IUzVPAEkIBvQY/EG38J0nIzbC0nvck6fA?=
 =?us-ascii?Q?2jUAqUKfM5BnnO4GvIQORH/JvfxEEVvHiBGFQG0DxQfxjHJZ7ewG11N0rPCN?=
 =?us-ascii?Q?HYpTFM0bIkf+6hOhrszCDNEwhlmNAjTEmqqGm76xYSuefgmACNQH2eXFbrcf?=
 =?us-ascii?Q?XhzR8/FmlPSLBlNDUmg+s7VIsiuntBXgae+dOomXtnVd4vZxi8QmX9ZB75EA?=
 =?us-ascii?Q?UiDM2qUe61JCzez2ZeiDg+NDQvwBy3n3V4SQMhWazKXlzonOYDaEd8BAUFVV?=
 =?us-ascii?Q?srTbXn7kCD54Q7yn/FJIiDqM0u4Rs2zVDBLTbwWxJQQ92nFunuyfMfTzO3NU?=
 =?us-ascii?Q?0g=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 705f8d19-1766-4d1e-a1c7-08dcf6f25563
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 01:46:25.6133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u1UhUffv+u3c3Oo2YC08wlowQ5fr1/dq17awF2ODSJ4LZihiOjglZfU1EIa9MocglMLizi6Zw4d6yhWtvGLP8G9qpRu/5PVDnkEh/N3mn2U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB0965

Add driver for OpenCores PWM Controller. And add compatibility code
which based on StarFive SoC.

Co-developed-by: Hal Feng <hal.feng@starfivetech.com>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
Signed-off-by: William Qiu <william.qiu@starfivetech.com>
---
 MAINTAINERS              |   7 ++
 drivers/pwm/Kconfig      |  12 ++
 drivers/pwm/Makefile     |   1 +
 drivers/pwm/pwm-ocores.c | 241 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 261 insertions(+)
 create mode 100644 drivers/pwm/pwm-ocores.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a097afd76ded..5db90c1d9854 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17373,6 +17373,13 @@ F:	Documentation/i2c/busses/i2c-ocores.rst
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
index 0915c1e7df16..33819cb585be 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -471,6 +471,18 @@ config PWM_NTXEC
 	  controller found in certain e-book readers designed by the original
 	  design manufacturer Netronix.
 
+config PWM_OCORES
+	tristate "OpenCores PTC PWM support"
+	depends on HAS_IOMEM && OF
+	depends on COMMON_CLK
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
index 9081e0c0e9e0..e55997490dcb 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -42,6 +42,7 @@ obj-$(CONFIG_PWM_MICROCHIP_CORE)	+= pwm-microchip-core.o
 obj-$(CONFIG_PWM_MTK_DISP)	+= pwm-mtk-disp.o
 obj-$(CONFIG_PWM_MXS)		+= pwm-mxs.o
 obj-$(CONFIG_PWM_NTXEC)		+= pwm-ntxec.o
+obj-$(CONFIG_PWM_OCORES)	+= pwm-ocores.o
 obj-$(CONFIG_PWM_OMAP_DMTIMER)	+= pwm-omap-dmtimer.o
 obj-$(CONFIG_PWM_PCA9685)	+= pwm-pca9685.o
 obj-$(CONFIG_PWM_PXA)		+= pwm-pxa.o
diff --git a/drivers/pwm/pwm-ocores.c b/drivers/pwm/pwm-ocores.c
new file mode 100644
index 000000000000..1ba29f4fe0a6
--- /dev/null
+++ b/drivers/pwm/pwm-ocores.c
@@ -0,0 +1,241 @@
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
+ * - The hardware minimum period / duty_cycle is (1 / pwm_apb clock frequency).
+ * - The hardware maximum period / duty_cycle is (U32_MAX / pwm_apb clock frequency).
+ * - The output is set to a low level immediately when disabled.
+ * - When configuration changes are done, they get active immediately without resetting
+ *   the counter. This might result in one period affected by both old and new settings.
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
+struct ocores_pwm_data {
+	void __iomem *(*get_ch_base)(void __iomem *base, unsigned int channel);
+};
+
+struct ocores_pwm_device {
+	const struct ocores_pwm_data *data;
+	void __iomem *regs;
+	u32 clk_rate; /* PWM APB clock frequency */
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
+static void __iomem *ocores_pwm_get_ch_base(void __iomem *base,
+					    unsigned int channel)
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
+	ocores_pwm_writel(ddata, pwm->hwpwm, REG_OCPWM_LRC, period_data);
+
+	duty_data = mul_u64_u32_div(state->duty_cycle, ddata->clk_rate, NSEC_PER_SEC);
+	if (!duty_data)
+		return -EINVAL;
+
+	if (duty_data > U32_MAX)
+		duty_data = U32_MAX;
+
+	ocores_pwm_writel(ddata, pwm->hwpwm, REG_OCPWM_HRC, duty_data);
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
+	.get_ch_base = ocores_pwm_get_ch_base,
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
+	id = of_device_get_match_data(&pdev->dev);
+	if (!id)
+		return -ENODEV;
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
+	ret = reset_control_deassert(rst);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(dev, ocores_pwm_reset_control_assert, rst);
+	if (ret)
+		return ret;
+
+	ddata->clk_rate = clk_get_rate(clk);
+	if (ddata->clk_rate > NSEC_PER_SEC)
+		return -EINVAL;
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
2.43.0


