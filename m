Return-Path: <linux-pwm+bounces-4541-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B81AA02779
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Jan 2025 15:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 519EC3A29DF
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Jan 2025 14:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA8E1DE3D8;
	Mon,  6 Jan 2025 14:07:49 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2128.outbound.protection.partner.outlook.cn [139.219.146.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DADA762D0;
	Mon,  6 Jan 2025 14:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736172469; cv=fail; b=XRTjonSiE4Z+1Kc/x7zWNiD2VRUAfXXyUibb+/b+dMBhfupdbbChUumaophkolsyhQHVOsFSKSwp/9RObrQmmvoejY+GSYA+UI0wfI8m8KbkZBVCz7xwFKfQRMw0itb1RoXDXGmzIG5Lvx6oWApyTQD0Za2GLbgKmNQnalU8/x0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736172469; c=relaxed/simple;
	bh=o5rBOgdoCPZfhx6f0vQoPLW13Hoj1EmuXxKeJ80e5Zo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=sY8epM87hp0gfeBR6z7ebxtMwveyT0KqXI2A6X0WGuxy/MZ4HGptPA/KFUWbX/kn1GHlPN1PEgZQy6Uh3bIlshkh1mBSO3VPWiuUxpU6LnRzofy08Zb3kKJFI3fO4aPQSSupefgG69nHcqQq25DMF9BEJ369MqpOOFpcf2rKUK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VRuZM+06pRe5BMsu2YFI50ga/ds71MuCYizkIia6Y5ddKVwIJTLf3BAXfbwH9Xc32/1zBiDffxCxgdgMriqldvOXM/TmA825dTtki8ynN0Hl2kcrKb7JIoC8SX2uBFOQAnWcY41MwzbeM9N8UPQOHJXjJIHde8p1FVYA/62y4JEK9ozVNWa0uvQ3+XJcNAn2GGQNeS3IembVJdtzxbl8wTKj503ggdp8oHQgzHy0m2utApzaBW/ZfUNPoXvmKH0hZfTyGmvGOHz9jBL1xN1qJu0f/aCXZsZucXOgspZH5j09WFDTItGUNEvpligGGAa4+2uq0xUOMo99fK5zTdmNNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LTRmwKCbQKzbU/xQrbJXdSI6ERNI7+ZkUthUC4oC/K0=;
 b=H6ZGiG/02CRNUwhUj4UmqYpTOI3XMB2nwnvo5GEYhKjwgwIIfVPC/b63iSNguspHXpV1rcoxoc9rpu4JMQ1qvZCTtmDjEomCpmLKN140zuEWrnpUOKY2Um5xR2ld+FEOwd3DN+MVK93KtudkiER20u9vgM0m5GxQlFdB/kuv30TIp37Ih3EHQrFPheI8zndSXU20urK25hfdBdWMeEsL6yRCl2BpsSejWC5SfcmM+6RrKyE5JQ+983s9sIFR8LySizGGVxeML02AgZmWUITtraZQA/RSQAsf2ME8wfEPNHuujODeZFaaMjPIwIr+UzW9z/6leG3cM53dT738omnNOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::8) by ZQ0PR01MB1254.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1c::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 10:36:29 +0000
Received: from ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
 ([fe80::6e83:b5ba:ad4b:3ad2]) by
 ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn ([fe80::6e83:b5ba:ad4b:3ad2%5])
 with mapi id 15.20.8314.015; Mon, 6 Jan 2025 10:36:29 +0000
From: William Qiu <william.qiu@starfivetech.com>
To: linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Hal Feng <hal.feng@starfivetech.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	William Qiu <william.qiu@starfivetech.com>
Subject: [PATCH v17] pwm: opencores: Add PWM driver support
Date: Mon,  6 Jan 2025 18:35:40 +0800
Message-ID: <20250106103540.10079-1-william.qiu@starfivetech.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0015.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::9) To ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::8)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1253:EE_|ZQ0PR01MB1254:EE_
X-MS-Office365-Filtering-Correlation-Id: 42040965-53ff-4932-9317-08dd2e3dfb13
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|41320700013|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	/jYclX6AJWJImQKC/iuJzlbnkujtVJdVmQV1Yq+Edyl4LTJgoSjOZGjSJaipnqRqL/BHkbvLv4AkvTMqFeI2LZ6auf5yw0bZ1y0SEuTiEi+lo9PJHpURVavWBj834wkZRqEbyxbW2X0p9L5Twj2G27fawXUeBLWpp0OLKSUn1sNCmlp3sdN96W0Ysk/Uw2GF+AdeGf+JR9JXfzHqQ/3n1C/x5fk9H5sBuosBXJfGQv3czXUdgXWmpJ8K0q119Y4FUiQogS0mvyKMsRJctF6ICwoGo4UDcQoCJtm/4okALp2AEclxXEl4/Oq/PEQ/4HPW6iOMZZaZiaRkiYyf6MQeYhXCo3IkG6UW0v+ZPYgWrKHU1appNoz04OjKVyA8Gy9W55Tj6zdq4yoEnFPROT5ZjooK5mr+cgq0eM+brkVW4PO2synGb8q6wQ//iPv/3TfrtajJ/dsh6vhumxab8JJGH+G4I3n2h9ZWx7ulYtLYZ0cxZ1ceos99vrgeovt5Z+SC0QEeqRSl818pK/IQcWPrOhQqz1/IbV7fwbwesidZiThizhNZUc/6ak9eFp9G+hHOm91W1D4Vzy5NUKj4GD0m2Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(41320700013)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p+9B8U7faEXonl3PpKo3Dkkwp/seu8Bj6NLsm1u3S0/3gIR3eULO8Wbzyfb6?=
 =?us-ascii?Q?GCx/Qn1QNy0/RsypzM7I+vAabWsuzJfcKOr5mLsuXmAnCHEzC0FbeKBOhVRR?=
 =?us-ascii?Q?wdhcm6F1bs/9/g5dL4HUXnTzZRFPJZ6Q0YB0YuDNYsrPfoPylrJZ79ZXPBuA?=
 =?us-ascii?Q?fgXaAJ8Rg2XDPU9zSHjCc4fwL3wFSuCfBe4H9kMVwPmZFJQQ04xy70kpKMyZ?=
 =?us-ascii?Q?ihM7HiSmDexTcuxX0T79nWM1G37IKmuSFejO+lIFn+ut7HyUTEKdlsiBGSwT?=
 =?us-ascii?Q?F78AhLNr0QIqSNV+2oOROzivQqgyQLqBltgDZBdsNFLbI+SF1VRtqlbnialh?=
 =?us-ascii?Q?7uh5cp98Zz+l6Tg8KcU53AbRHu/lghpjxPLv/BWIWCBmNv/SHrqt7GkUpbHh?=
 =?us-ascii?Q?5vRRTW4HAKdCOYXpBtrKpM0PSVXbbwd/Yw/DA5hpPs7XXL2BvQ/z6VNsVvev?=
 =?us-ascii?Q?ZNcVD4+X9wiSBATZU/NESyewNGDd9waVHFrrFHWzcF5O9wh5mdSG3El/byMT?=
 =?us-ascii?Q?WyBLWfVjwq2Kb/IyKILJbXDUZClka/BiAxVd9WTzZyq2Pem8oSBhveiQoxs0?=
 =?us-ascii?Q?FIWN1OHwrjuqe8wobfW6u/X6fqiRLluepulp8rH215SZi/mt5jaTT/iFMWLd?=
 =?us-ascii?Q?TxYEf6HvZ4LPE41lDXiDRE2CiFyEM25dXXDUHi5vhCP1P7r1y0FKhMalMWLV?=
 =?us-ascii?Q?bVi99RooVnWVu5ZtaNIibHnw9NDzoRaaVDK6QulpasvQ0+SAmDWOPONtStq2?=
 =?us-ascii?Q?S/r6YBCVL5rR7nDJrOlM27TktU3TKfBCvuAQRRJwxX315oHECVoxcPqCcKkP?=
 =?us-ascii?Q?qtrQNwV3Brff0yfcU/PoFh62F3aTtDYl/tnf0BCmojtiPWhTBNRSnHLqr634?=
 =?us-ascii?Q?7e9XBRzmAWdiFJO1FM4X8LqVqC4uyhLISJReT7ZbbLFZG22HAhrmbC92UljP?=
 =?us-ascii?Q?3/7DsKD6b55GZwWV86GehgWc6eqxFP6LjzSJadKUCnS0vuN3jEdAyBYzCxc4?=
 =?us-ascii?Q?+HxULS2nhf6zcNzzkPHFmvWtGhp8D5MBpI378PpDYRQT6YHmCmZMVduUnsQg?=
 =?us-ascii?Q?8RD6DfcUz5rJqbMJ9oK29zxFpJUXB4i1vyZyUo9lS1y5SGAnlW4xicahLYDp?=
 =?us-ascii?Q?ojA0Rpr91J2DLLrDbrdw7eJUG3WXxzYuCJ4VzcXTwxWvMjQeuWH5eGkkhCHe?=
 =?us-ascii?Q?Phc0kbm6tg+jJLYjLtisNkvA80NkmywEpvy5EASMDM00aJgkAQPG9K5+3Prt?=
 =?us-ascii?Q?SSZ4ZPO/WCaWthi3SpsslfH8t0SmsG2e+6bJ1LGAKBr0uNAOue7EZltkT0BY?=
 =?us-ascii?Q?aewNiPx7nkB3F4qXfc8rQTCiRbUPn4+8GFu2+Rg/DF1YQMIli9FJv+e0R14B?=
 =?us-ascii?Q?VmDDcrWUfQ7iUbr3ISKG7ae1dq0+MKzux8oR5BRQj6NeOpVD41zEj0Of85CF?=
 =?us-ascii?Q?m/v6NxsYc4lWO4y6BMWYvtCOOnJ03PYCAT89DA0OyJ1FDhrH62bojMmyRtmZ?=
 =?us-ascii?Q?1dl8QKN2/+Cbh1JVCpfbYEf5XJCK2S8FKbje9VzIzqsCv0/oW9/k4V4d6uXS?=
 =?us-ascii?Q?5xuLj02j/iVYenjfJMpcyabIojWWiI1dZhgeUKWhpID9HMK35ZJ5JT03mPgx?=
 =?us-ascii?Q?/Q=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42040965-53ff-4932-9317-08dd2e3dfb13
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 10:36:29.8113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ncq/Joc8VxEkyzi9ra7LD3Zt2AMeVzwEH5jenvZDALjaMNrztc+CHQmNDkfRxN3+vx1YKOS+rQpJqns9aDwN4fX/pg8OiyrjqFjqFonZ+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1254

Add driver for OpenCores PWM Controller. And add compatibility code
which based on StarFive SoC.

Co-developed-by: Hal Feng <hal.feng@starfivetech.com>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
Signed-off-by: William Qiu <william.qiu@starfivetech.com>
---
 MAINTAINERS              |   7 ++
 drivers/pwm/Kconfig      |  12 ++
 drivers/pwm/Makefile     |   1 +
 drivers/pwm/pwm-ocores.c | 238 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 258 insertions(+)
 create mode 100644 drivers/pwm/pwm-ocores.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 910305c11e8a..e0b130e0dc54 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17537,6 +17537,13 @@ F:	Documentation/i2c/busses/i2c-ocores.rst
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
index 000000000000..bc957830017f
--- /dev/null
+++ b/drivers/pwm/pwm-ocores.c
@@ -0,0 +1,238 @@
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
+	struct device *dev = &pdev->dev;
+	struct ocores_pwm_device *ddata;
+	struct pwm_chip *chip;
+	struct clk *clk;
+	struct reset_control *rst;
+	int ret;
+
+	chip = devm_pwmchip_alloc(&pdev->dev, 8, sizeof(*ddata));
+	if (IS_ERR(chip))
+		return -ENOMEM;
+
+	ddata = chip_to_ocores(chip);
+	ddata->data = device_get_match_data(&pdev->dev);
+	chip->ops = &ocores_pwm_ops;
+
+	ddata->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(ddata->regs))
+		return dev_err_probe(dev, PTR_ERR(ddata->regs),
+				     "Failed to map IO resources\n");
+
+	clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk),
+				     "Failed to get pwm's clock\n");
+
+	ret = devm_clk_rate_exclusive_get(dev, clk);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to lock clock rate\n");
+
+	rst = devm_reset_control_get_optional_exclusive(dev, NULL);
+	if (IS_ERR(rst))
+		return dev_err_probe(dev, PTR_ERR(rst),
+				     "Failed to get pwm's reset\n");
+
+	ret = reset_control_deassert(rst);
+	if (ret) {
+		dev_err(dev, "Failed to deassert pwm's reset\n");
+		return ret;
+	}
+
+	ret = devm_add_action_or_reset(dev, ocores_pwm_reset_control_assert, rst);
+	if (ret) {
+		dev_err(dev, "Failed to register assert devm action\n");
+		return ret;
+	}
+
+	ddata->clk_rate = clk_get_rate(clk);
+	if (ddata->clk_rate > NSEC_PER_SEC) {
+		dev_err(dev, "Failed to get clock frequency\n");
+		return -EINVAL;
+	}
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


