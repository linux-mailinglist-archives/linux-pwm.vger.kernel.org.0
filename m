Return-Path: <linux-pwm+bounces-3271-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB7C978FD3
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Sep 2024 12:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3B4B1C21AD1
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Sep 2024 10:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C51157468;
	Sat, 14 Sep 2024 10:05:55 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2138.outbound.protection.partner.outlook.cn [139.219.17.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253B71CDFCB;
	Sat, 14 Sep 2024 10:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726308355; cv=fail; b=UZO/4FCcARIPmqXIe7Od1IiMawmx24YbCGWHxbLYYvbBwA+mVcTikuO1tIluErMjK+fUxTGopf3kSotqBTZjtHwPdT4611cIFiX/4bc2mje8hY4RjSqtHkTW+e7KAYZGa4EBrDIXbBz+Cgy38YX20Eo2X5nUWjEcStu83tj29HQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726308355; c=relaxed/simple;
	bh=3vu0QU479w4nKhG18f0QnCZ6YYZXxlHy6J2VNNkTQMI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=KSQDVAEqvmr36Ht04R2qJRx/3+lj6fhlsLOlKoRwuYbY2nmtEXhGolyIg9WDFY5LYUt2LwWuZUFXoGeAG0tanfJOpyqcfVX2Lx0Kldg890NZ2uxj1HjpzR2BSJJJESvEvkWe2gEWLn7pYYI7HyZDITchOE3r899SDkUPVc1x9P8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NWJgqIBYsdmDYK+ysqSMQZglO+4T4rCIn1O19cuoF32aXu5GJj0fEubah/XRfLJfzlQBI/O/fuLiSaQJavZ5f+8j0EMFvtJ+Ok55D8jrqxooN9QFVkk/3jJOBeABg6K8R4YoU7YYM3AUBWiRfPjQJ+n2Ht1iRJ6iii9iYZHv5vDbNg42l1FG83T06FLqn4/hAtOXjSjSg1nRsw8Pgs1Q2KoHItVptDgMpR+rm4/XSmFa0rFO9mWY9mq/pf2pdxF/ALL88LfQKbwBt+hgQOa1k4EieqSgj3rZoNsA+Lq9CPU0r1nWtg7Wog8MjjN63GTkfoAFpig6mhEEBGW6EEew8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7CsfgKTU0hfLSyjMWgqVYsRXJOeMjKPheiMxJNcWUw=;
 b=aJ6xJNCD2TI4lrOrXk6ykTp9XDHW8WxRIclRFMSxMpVt5LgDe/4yDVRPJJ+QS7XWmBliDauzbSeB2AaPuenCUol94I7+M6UvIkKdfnAg+dDpghDSS9vNpI3sw4Ddc7clERNILQNYGeGmbAWJisRlicniBFca76SeVeWb9as4HiLP204CwDCfPtDDFGXTXksZVZXRbdeuIcnJBzrb83RlZl3YwYKYxSM9UoFf/FWqrJqV05xTPeeIfEr6NuglhRgUevC5nysXgCDdRczqMsJWxE8P10CWLEa9pjti/DHk2ZK7N5oH2oVFH0+tvnFHBc/kR9zgBj9I4mwAzlLbFP2e+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::8) by ZQ0PR01MB1142.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.33; Sat, 14 Sep
 2024 09:51:21 +0000
Received: from ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
 ([fe80::6e83:b5ba:ad4b:3ad2]) by
 ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn ([fe80::6e83:b5ba:ad4b:3ad2%4])
 with mapi id 15.20.7962.021; Sat, 14 Sep 2024 09:51:21 +0000
From: William Qiu <william.qiu@starfivetech.com>
To: linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Hal Feng <hal.feng@starfivetech.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	William Qiu <william.qiu@starfivetech.com>
Subject: [PATCH v15] pwm: opencores: Add PWM driver support
Date: Sat, 14 Sep 2024 17:51:14 +0800
Message-Id: <20240914095114.31100-1-william.qiu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0002.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::14) To ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::8)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1253:EE_|ZQ0PR01MB1142:EE_
X-MS-Office365-Filtering-Correlation-Id: 604908e4-adc9-4242-8fb6-08dcd4a2c9c9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|41320700013|38350700014;
X-Microsoft-Antispam-Message-Info:
	2R1MyYk9Dj/rgTqrVPzeFXJzudXv7iHkW/a2wKdGAvZNd1o4erJ56a642QYi58Fo9U3L2hIvCDaO8MdciSEGyYuPM5YlBrKaVWoF/wCtkwxF5uhBs4zGaBHKI3fAoPcL2SsS8HNF9Fw1hkQs4Jm5y9mQhYDiBaJrxZ8ZOS2x5g2x55J2xfSwLdYGutuqcJXJUwONmkfghn0dLCz8LgU11U/jBUYSbds2DZjodmvD4PL1xNgX96bejMa7YtVMaeyXcoD5VEiEhBCoSQqNqbMrVnfsqDY73m2ywq8cJ/q6i5iL+fnQi8B/rB3gT49HxoariLnm3fLl4UvOALdNBpDFI/wHt8Q+otNGbyrMOAZyODjLDnOiPSqOqlIa1VySZ+Ok30BddnLO9tkXSX/cg/MbxjmD+S2ggTrBnYl8OH8cmM9fyFVtde6QdG5FB3cprPGNr5Tzl+53gA9+s+KK+O83ssVQ0eAz1KtZZq5A/plk3ds6g17tPm6hp2AYWZvUvsMN6j3dAXJ62oUaHHSJiy7zP9IwIRvsWFgM4FZwgviLa1D2183gNZ1d1IvCMDkMYft3LC9AOBDTi8bRQG9p0uqzJ2xmdf+pefbHTYmqLpcS5/IaXcuI3KbN8ro2h74WkEbv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(41320700013)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bOJKLhDHM8kU5AXHjbQ9CzuhZGeBqquI1u8yyzDAv7fphj07rp26rUtzfjVX?=
 =?us-ascii?Q?RPFGfa5+W0u+GraNOgSZ0lVw9QLQ08/Z2hUWZk3HI0hUrtk3c+RppGhUPzkd?=
 =?us-ascii?Q?30oKpIHO+aaxXCU6MG0rdX6U25/jt9U9rhF2+e3iYKxFVOhS0o1lHOfL7rZF?=
 =?us-ascii?Q?drjZxA07RNlPETfgPdMMSE/ee8jD2RrY4T83i7NmDII2zr7qJp6wfbBiYNU8?=
 =?us-ascii?Q?LDsUIGDcJrIE2FlYkjM6JRP0rVV1WLDJ4zxfkfBVGA7v8P79+I2wIO5X/CDi?=
 =?us-ascii?Q?l/GBW/+J9kzbmmLmtZAmHXyd0Z/FjcJZATitblChnSDWQCfy1y953e5a3ohu?=
 =?us-ascii?Q?/mfRI78qgzsM7KTytBkudppP71/ljdBrYNArbBQYME4hBjarJKIZI7g5s7j2?=
 =?us-ascii?Q?Jv1JxFnqIParLcTqInqUc3zM/opLKSGfi2Gi1ChCEA95bVefq36E8x7t0D0j?=
 =?us-ascii?Q?CiRLWrGD6lLWAOWZy7TtEMf7Mv05Mv4BQmshlLY1UvAMxqgwSfWE2iK6d/k+?=
 =?us-ascii?Q?OvbLWldGJ6V3MtRPq5WVAAOYDQOrJs+f6zDhaPxSo1sKDErkoW9UofLUO0yJ?=
 =?us-ascii?Q?pk1nvbhDRYKLf5kum18EZtE0UG6+WwE2Ih1If2TfeSGSs/2ABVUh66gR7oIW?=
 =?us-ascii?Q?YzzgHZAImhyDfJFt4gUvlYmdQEuIlTw9yo3yUyM8FgnDU4HeqU37Q5I/J8lY?=
 =?us-ascii?Q?1mPATu3hVVmwwFuPfWQwjj4nugdNSMm73/GTmEOvSnU6ZgYQTJ74Q51dRctc?=
 =?us-ascii?Q?23ueC1V/CwxMw9WU0wadAxKPeOruED1qJwAHNv0oPA/HTOnIJex36MQHeRv5?=
 =?us-ascii?Q?Tk4fpE3bY6fxjfVOStsFQXuQIra7eolzq7u6Ep2iW6D+8MyhuNoEuPEKBK+6?=
 =?us-ascii?Q?lckwNf8UTzED/9cr8QsmeDE292Ft0Pmook7pSRbFHNXnLkzPzRmMaOExJFFb?=
 =?us-ascii?Q?1IPSlEoizYGXc9ZvDFfE1jv1WOZ6Ay1MWEH8R0w7LBtwZZupwPZsZO2B+rv9?=
 =?us-ascii?Q?fscyWY83HMWld+iHPIjfqmkwuE3hgzRogqdmXdchnsoduV6hJLwfUcfs5Qoj?=
 =?us-ascii?Q?WQ8yWDhVg5RfmqpsjarPsd+Pu51MGKA4g3my/bdZixGW+FAbt7UkXlevfF+B?=
 =?us-ascii?Q?wtseRAUu2IjCkvCvVygSWEScYFUsCewZI87JhLYC8x7AyC0WjxGU4u1vPiMM?=
 =?us-ascii?Q?5xQqLKmpCVVTzO4Nj6SI3FN2c8CgjK3lN1eeugQuXCM5vgjQLg7F5BJmO7Er?=
 =?us-ascii?Q?uiNLygZ2sHW8V306+xERplWRPT/rDZahwup+l0UeBautnOSXSmqCbjnlmQEU?=
 =?us-ascii?Q?AXBCXFRBkvv1Pjjt78W7jQlPCTyrFiBdX9Zm+PywDt7/o3O4qR7hENV5MXyC?=
 =?us-ascii?Q?HyLICkIQsI67ox4pro53MVdrjdaIWM1qlmSaZNIfxEi4VteooSOxShpmgctD?=
 =?us-ascii?Q?Dpj95RtEw5eyuuojgXLT5uRsC/ifF2Zu5fFpPhS/SnvJuTfpY/5pqvoYolLr?=
 =?us-ascii?Q?Uca53B+zNHMuwybhJExlK9swQKyWMvgvX/CQ8t4NS8fkSVDN0mpI8vZwGYUo?=
 =?us-ascii?Q?JeYy9jaRBJlxtWGqT+N0yiISDNCfqlPKmJn8GlcSauKENsyxCT8on7MkNR4O?=
 =?us-ascii?Q?yQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 604908e4-adc9-4242-8fb6-08dcd4a2c9c9
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2024 09:51:21.6807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jeTkvrCh5RPOGO3lUQBARS0jCOcR6gS8z2MkFoQRNjz7xxX/4WxVtxbpD/rln5ZGV+fyjbjonauZcJVtuJ6TRSuV2D3GgCm+MD7et5jEOsQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1142

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
index 10430778c998..f0475a3b8683 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17148,6 +17148,13 @@ F:	Documentation/i2c/busses/i2c-ocores.rst
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
index 000000000000..d0161b9379d1
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
+	if (!duty_data)
+		return -EINVAL;
+
+	if (duty_data > U32_MAX)
+		duty_data = U32_MAX;
+
+	ocores_pwm_writel(ddata, pwm->hwpwm, REG_OCPWM_HRC, (u32)duty_data);
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
2.34.1


