Return-Path: <linux-pwm+bounces-2989-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2954594CF3E
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Aug 2024 13:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43BB01C20D06
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Aug 2024 11:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4007E192B88;
	Fri,  9 Aug 2024 11:13:42 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2102.outbound.protection.partner.outlook.cn [139.219.146.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF80516CD05;
	Fri,  9 Aug 2024 11:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723202022; cv=fail; b=GkVerjehbnLYXsBRy9FTtbh2jo/rwMOMkmV/LmjcoWajTCii8Gx+UGTRNZha+jEBuF7AZbusbVyS0q/xeW6HKI87crWownmp1cVQKvFmhn9Wr8rcK6XeHuijYhLbXJAEDNYJ+z2tvKoX6+NlkUQ5Qr+h10GbOHywJjI+jtKf9+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723202022; c=relaxed/simple;
	bh=iLuMl3kk1kt+KEtjjLkC5S1LyGhFldXqkADaHzfDCpU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ki5lib7/Vl5ULEA7n8dcws2IiGaaBzaNR9jJezXxRXvaMhfOnTRunZ6qkkZlA2GFvgoaDblmTo1KalEp6q0TtbeEPaWdm977bvXHTEi717yLauKwpTspLZzTF2TlIOz9jxLUtYbSBD0xECtwaKynFA3s24/bW89i6vvXTOnDjMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=npkdOlUADp1zQbsC9BU9WhREjcR48aFTAUXxLnbNmCw6lz5QI8rnZql8FAHmjFdoG0RS+0xMxW5lHDp2fK+bTRqvKl+x19wLHOlqzwwLaxGC5XerpuyYGbDtHHIdV2botiXmVIO5JoWsrkNuefa2ksgXxvmdeVhETW3FBPCFI/AlhJ1+rjYuciOWZKppVbJnkSNtB54jbrqcQKIfCT9Yuei8jD2uCimVDMkZPIIkndEvFX8OAbuTYuIUFkUAj7paWXKczb1jkbLst9ziu0y+2mbB0OFLnMbIcEYxXVzwyxAclnC05RvmLSnNrddn0XNhlAl8uubnKZ8vsX+hkT6BcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BO5nHeWii+7l1W8wSHMdhlSnMDKQKO9aAaitI/L5uSI=;
 b=UgNoZMOVLuteri9ljZxGgcqndyRqeFCD1+Ysl6A8Ui3XRk1G21qX7G/ljNxI4MzSCymKcIyhvkkPQHIT4rvsvjNCVzjtayUuv/yEnhSYyVdUauEgba9iUN813tgNmz2bMXA1BTbSePekf1y4kC8SinXwhqcZhmv0iNgwwl/fOPiwXWcHaSnWrsvHGy4wgNVyoYWBD7Ay+y4KfiwEp1wBHboV7gaEvuBM/DYcslc2eFw8PLHMxCVoBGapKVrH6MImhW6fiK2nw25dxmdi0sBgecj3QP5HNjyqnO8iBLIlLfSJto+HoNjzG2wuMlPBoRaOdmR+wqMcUM706xVRlJyj2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::8) by ZQ0PR01MB1206.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.31; Fri, 9 Aug
 2024 10:38:39 +0000
Received: from ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
 ([fe80::6e83:b5ba:ad4b:3ad2]) by
 ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn ([fe80::6e83:b5ba:ad4b:3ad2%4])
 with mapi id 15.20.7828.030; Fri, 9 Aug 2024 10:38:39 +0000
From: William Qiu <william.qiu@starfivetech.com>
To: linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Hal Feng <hal.feng@starfivetech.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	William Qiu <william.qiu@starfivetech.com>
Subject: [PATCH v14] pwm: opencores: Add PWM driver support
Date: Fri,  9 Aug 2024 18:38:31 +0800
Message-Id: <20240809103831.156436-1-william.qiu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0007.CHNPR01.prod.partner.outlook.cn
 (10.43.109.83) To ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn (10.2.3.232)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1253:EE_|ZQ0PR01MB1206:EE_
X-MS-Office365-Filtering-Correlation-Id: 330cb80d-2bfd-48e9-cfca-08dcb85f6e12
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|41320700013|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	n10hfQWbYYRRpNUWX2+SQpgvzJk+xxidiqu0Zz+VZwmROhr7XtWmydO2fSKniLxjW2mjnuUjmUOwpOJ0XfkCoCU7kRFIQP3pZs+P7ZoHD9QLmIOu3HeYzF5AWTDJCQj9qEU4HJ2W2y8ZMZB/olSFs4U4rlxpdE1ZpY4gPzcHgQdFYDUKmlWSl9c5ZfS12h7qPWLMks2yLCUe004Fq+SzJQGsq27srg9MdonwHCq9MrgvHLOqLh+siYOvHNcAJ9T61PPJ/VzX/RtHeNZg7TnSudyziU+p6sMlwvWZUNF91DrwbePCGQZcP1zScqQhUXz8LDflBrMY2biQyDnWRGoPnR/xtcSYvDUlUlbBqs53faBudPq7Jq0qoNXTYWWqfonX4030Aq00lJ8XAL+fqUyVcn9n4CRcNG4DP8qjxYIxi+8JN/RFEBw/ThXZX3e1iTQotZTjxZcWZIWFS0ng2Xa0roK3OCz9IiCVnktTbaOc7HHdJfK4by/9p0EQX1Q2IffyiNdiDWqVOBmtR74rM78uVca/l/vtQvvV1KVAQ6IbHsURrHucDKeAE2avQjJI+3wJcAT1zw1FZ9CYuqJuPlWeQ1MjDpgUC7FbB6TD0CafrQk4KXmrcuXlY9VZsyG8g00b
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(41320700013)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wKT3a1i/8wX6fy2kA4SyOCK+1tOqZaI7VrRJE7JtkEYhZGYf0Ztl/ifr1XcE?=
 =?us-ascii?Q?97b+Fo2RomwOILRZ0qmA5xa3eMuL6erXoPIPLYkeBBx3Yj/7ZmOvjW6IZg0p?=
 =?us-ascii?Q?znsT1O8H7yvTCbiVydkMti3B5NckklhAe2DOyaFDXY6Mg5pkfq6EGQpvI1gp?=
 =?us-ascii?Q?MliEr0fYcmDAvLtGFMP0+r0SECB4GU5hkFH/NnolZulbBBJPYBK2XIK33RWU?=
 =?us-ascii?Q?Ykwi4HQ+uy79BLwhcaUxPdbvzjyyLAC1eJHiO2ut/TSE6Rn6/X2yllFYtv4z?=
 =?us-ascii?Q?FvKgO2eF6B+WdTfzCQTpETT7UH46kONPddDYNd9c13yqV1SFQxi5GECw+JvW?=
 =?us-ascii?Q?YOgdFBOwGc9IhwdT3P5m8qvsXKOirRgOpG/zPKgGyrzUNhKHLQKmJ2b+h3At?=
 =?us-ascii?Q?UI2Wh/St4MVlqST4MdjLf+AyDgu+IFDjweKgaNxNqpjkyNACL17WYfLhGPR0?=
 =?us-ascii?Q?Z3x75YZnE03CORC7pjyRh/5jbkLiWhCQQ0rDlgljKAZI035euT2u1VM9fLq8?=
 =?us-ascii?Q?1QVcMPR8t1j2nUUUlfGfc2ZoBBTZwyYITIpcNwUU2s5vDdP/T9SEovfhT+QN?=
 =?us-ascii?Q?eGfpxHaqabfS9baVIqAFlZj7U+Ljju7v+j3YJc00NOeipeWzNzh8S2GQFfXQ?=
 =?us-ascii?Q?6taxdKFv7DYGPZ2BqtFKj+imCjbU47iBK+POein+LZu771e34YaRVfA70CU4?=
 =?us-ascii?Q?jyVwSr8BbBbAIeieWclGi221QDPeP5Gjb17j5JJjRcdcKrgbqhdsvBve+zzV?=
 =?us-ascii?Q?OyMYe3h21uB2HslIIM2sAbONm7mXIvQQL+No5xg1frT4plbIRYw9PLZrjXd+?=
 =?us-ascii?Q?M77au7R2swTcYeJpplt12xf1DNVoZIQbDTPFgSArn5x3U2SD5c2BZsEfQKZq?=
 =?us-ascii?Q?mjt/X/HZ/5N7kCAA98yVPgqk+uuD7N38nQrNFpsw2+Rj5TMfXKXVWCa8sx0O?=
 =?us-ascii?Q?QzZ6h2yT5FGBhq2gx1i7GXYRiL5RAX+a68i8ZxG79D7cPyNjqbf5YIzmTkft?=
 =?us-ascii?Q?KwrP+zKXG12re+5ZhEdJT27iTN8iz7gFVfQoRred8KXmi+9CySyPV68+uae/?=
 =?us-ascii?Q?4XM5KKaF0R739IbcIJd1go4ZNmJRemm8zyMhcuLsk/A868a6ubIUoiLRtnFc?=
 =?us-ascii?Q?Tc2l68hkh8RE9oQQggDBVwAJ0VXGtLalWLrSc75k9jfLZyyFAAHR/i6TjjXJ?=
 =?us-ascii?Q?YOCHHp6A3geW7jSEmK7GayMCihZiiKqZZYeji662k5iv1Qnaa70e29UpGMpP?=
 =?us-ascii?Q?TydI8AfIjjNflISe4d1yIBfdaGrWtnDp7yR6ZoSw2l41+BjWLEmjTFZca6Xj?=
 =?us-ascii?Q?xJ44j8tr07hb/wUDjBjWtul7nq2Lzpywmpqm6ayuMzkJu+QUAPtSLkYUjyPw?=
 =?us-ascii?Q?SbX/3oHiGhnnKGNAtugzjNk+IM2TA6kj4eE6/RcjZythHNCiO1DWL8n+VDxQ?=
 =?us-ascii?Q?CvqjZlA7lc5dLHKCvE7jqBPIKEdb9MaeDHr3EqpwX1CmjN43MBbl7+OHlTlJ?=
 =?us-ascii?Q?GiJEQBYPOaR0fx+pgeEqm41Olydx5ERL8Epj2lr0g4UelHPCrMSWVCDvjcpo?=
 =?us-ascii?Q?J+U5fixH81W1uoBwneMhE/vPscpf/vqzxtgq/m3IUwdPgo0BX+TNZjiNbbjI?=
 =?us-ascii?Q?tg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 330cb80d-2bfd-48e9-cfca-08dcb85f6e12
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 10:38:38.9769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NLuHJXUjcjbLmqU8rwHWVR3+XNe0+S7+nNCiYHdwJxRLW3E7Gpv61UvJXb3k0s4R5E/zk9l7XELU9eCBguxoolCaE0qXhesyuOmGU9wsD/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1206

Add driver for OpenCores PWM Controller. And add compatibility code
which based on StarFive SoC.

Co-developed-by: Hal Feng <hal.feng@starfivetech.com>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
Signed-off-by: William Qiu <william.qiu@starfivetech.com>
---
 MAINTAINERS              |   7 ++
 drivers/pwm/Kconfig      |  12 ++
 drivers/pwm/Makefile     |   1 +
 drivers/pwm/pwm-ocores.c | 242 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 262 insertions(+)
 create mode 100644 drivers/pwm/pwm-ocores.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8766f3e5e87e..e79bd16cfab8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17109,6 +17109,13 @@ F:	Documentation/i2c/busses/i2c-ocores.rst
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
index 3e53838990f5..7682936484aa 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -464,6 +464,18 @@ config PWM_NTXEC
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
index 0be4f3e6dd43..5d87811e8537 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -41,6 +41,7 @@ obj-$(CONFIG_PWM_MICROCHIP_CORE)	+= pwm-microchip-core.o
 obj-$(CONFIG_PWM_MTK_DISP)	+= pwm-mtk-disp.o
 obj-$(CONFIG_PWM_MXS)		+= pwm-mxs.o
 obj-$(CONFIG_PWM_NTXEC)		+= pwm-ntxec.o
+obj-$(CONFIG_PWM_OCORES)	+= pwm-ocores.o
 obj-$(CONFIG_PWM_OMAP_DMTIMER)	+= pwm-omap-dmtimer.o
 obj-$(CONFIG_PWM_PCA9685)	+= pwm-pca9685.o
 obj-$(CONFIG_PWM_PXA)		+= pwm-pxa.o
diff --git a/drivers/pwm/pwm-ocores.c b/drivers/pwm/pwm-ocores.c
new file mode 100644
index 000000000000..860ee414e8fa
--- /dev/null
+++ b/drivers/pwm/pwm-ocores.c
@@ -0,0 +1,242 @@
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
+	ocores_pwm_writel(ddata, pwm->hwpwm, REG_OCPWM_LRC, (u32)period_data);
+
+	duty_data = mul_u64_u32_div(state->duty_cycle, ddata->clk_rate, NSEC_PER_SEC);
+	if (duty_data <= U32_MAX)
+		ocores_pwm_writel(ddata, pwm->hwpwm, REG_OCPWM_HRC, (u32)duty_data);
+	else if (duty_data > U32_MAX)
+		duty_data = U32_MAX;
+		ocores_pwm_writel(ddata, pwm->hwpwm, REG_OCPWM_HRC, (u32)duty_data);
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


