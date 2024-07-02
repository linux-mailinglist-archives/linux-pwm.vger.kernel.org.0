Return-Path: <linux-pwm+bounces-2653-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC6C9238D4
	for <lists+linux-pwm@lfdr.de>; Tue,  2 Jul 2024 10:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FA601F22AA4
	for <lists+linux-pwm@lfdr.de>; Tue,  2 Jul 2024 08:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23ACF146D65;
	Tue,  2 Jul 2024 08:50:17 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2112.outbound.protection.partner.outlook.cn [139.219.146.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E44284D39;
	Tue,  2 Jul 2024 08:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719910217; cv=fail; b=h83d8btTEZ0h5SjCcfdSBvrC0H6JH2MoQqa+8maBVfIqKQqCTgR7An7aycDjruv5c9hSwqH8bAz8X6GNwtCpwf3jUaMOeA9kdMUX60DFeOcPGoKQVMy4msC9pzjrKUewL2FVkUuj3rnUYxoVkyHEJlPsGHNc5pcXn63qWDSrD1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719910217; c=relaxed/simple;
	bh=H+MkEpSJDEA6jLZWK7X/rF6aojMSyuOq8x3XTbiSqTw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=HKzYu43dQRcSrNXTPVqpnDxBqm1Hm/pAspLVyCk5PqIIGb5U4K78wZhmNSH5Ts1lSgHJ31ciOPNSuNsqaAmRq62a3f7Le2oubz9DmiOYJPVWvpm/VT2bMV6Q39uA6lbed99cXJbYJ9SPIFc+vb7Q+8cZuCSI6SwlcvSTbGX56pQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tn610QqUiQMhB8n4A8nG4lfc5j3mcSbQxzOR5wex+m+T7uoafDHArEENQL09Nyoqw2WVVkl53lsjNKWzk4qiZjPO/b00qcI3EqwbDKTE0bEBHqBZzJR2SDgNWksyreGbsKAf+h1YCsiDmBNtYTnRllevuCZs8VbwpvbM7M23nvvzowbIsI7pO1ClHwk7d9jNBxBS81ksQRWeF11SYHxXpNC6zXz0hpIfeGnHkXuXFWYN2t+Ypclm0YF8/m5Wv6n31pBHcbw5xxy/ZvJSybVROjI9bfggjwGKbfGLWlEt+z93A2da7q37vj7ASsISDKm2icWOihhm2szvwxUJhkOSkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/wc3JHW7ZyfdZkH3xq9SghEtwdsdyQT4U+9UVo0hzA=;
 b=BFOqjXbqW2NgT6lu6x2iWJoYabn30Ga1BcZKYa0feSOIJyMpq5KUro04EYRmjLbhNhPh1no4b0cUz4+1cD+ermTJGfuqY34sHvMlemNoBhQJXScKPmw7kJpzlri+lSF7+tNQ1FMfP/WRaQ75hNtwFaKHecdAObfqylGoH5KJDH1rQmMcrN8ut7uwHWnL0VU/gL/8LOV4/qwkadto921cJ9HmcLw4AKCXX5REavaee993zL1CCZUDfngWSkqlt98LYn8t2jkqGU3Y3I/v0CJFNUgLUhNupEeJbrT351RGpjOcleJlqbQuL6rIACpPQ3G9eREJl4ympl15SdnkSsniIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::8) by ZQ0PR01MB1111.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:e::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.28; Tue, 2 Jul
 2024 08:35:34 +0000
Received: from ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
 ([fe80::6e83:b5ba:ad4b:3ad2]) by
 ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn ([fe80::6e83:b5ba:ad4b:3ad2%4])
 with mapi id 15.20.7719.029; Tue, 2 Jul 2024 08:35:34 +0000
From: William Qiu <william.qiu@starfivetech.com>
To: linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Hal Feng <hal.feng@starfivetech.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	William Qiu <william.qiu@starfivetech.com>
Subject: [PATCH v13] pwm: opencores: Add PWM driver support
Date: Tue,  2 Jul 2024 16:35:27 +0800
Message-Id: <20240702083527.1947413-1-william.qiu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJSPR01CA0004.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:c::16) To ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::8)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1253:EE_|ZQ0PR01MB1111:EE_
X-MS-Office365-Filtering-Correlation-Id: 52abc5d7-8f28-4930-b788-08dc9a71f0d0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|41320700013|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	OvZwpfXC9hpBP6pmkkln/JuD4yaAQ9YQT1bLdCJzC58SP2Ag7rVwWbd5zU8Zw+5JQZO8JmRxHzlVR2LoHAoqfEbsFXBIK/9yxtaT15kgCjHDQlzoyBlVNE5VqMveYGxl5jgV1andcID2y4rXxB5NlRtXihjNDlu/56ylqCnmVR8zo1/qWKBh4j6xAlRjU8QYStpZbdK/2wx+ba4dsERiq0tCEQh06c5zVhPzaC1wjJQeA45nO4x/AZOYpmZkGzLEHQ7uRFuWegESLR3xlOQKtKq+Xt7QTxiwklLtfXWM8YVYqfSUN4+pE3lhZZ8QJUoJuAVZmV394DYd93UHakYK2cJHhKAbA6MKqtzGk+iKimnj49Qvi+VpnX/otEwtD/HLMcfGy/DcAsgWjpNFSUmnN+ItgAFs0TzwgPhDXEHIoTO1NemT9CmCE0dkjT7lUOxbKc2p1sqMcfcNp941GKTSjEGKN61xFT5TFTXwzxDuXx0+HL6wVEZxVERI8bMoETtN5HZg/CBfDr1yCDpnU0kL2Zqzu0ufkc6JJuFsWhmKUJXDOvciXZ+ah5GEF8I3LGQ5Fbp9A6JhinUBJNPBc5Lk7433Xda/llkkmHEDhJ15QxnZwJxBWHO5acqCKI8kgmaw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(41320700013)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oToKHDoK7xf6rgJzmqh0V+klr0p2XaF7x3eWUyn5sLT0wLocyJ43e9CoFWNX?=
 =?us-ascii?Q?biTPSrI+oGPnVKQkHLXGvOlcimlfXumUGCrG0LCQF9+p2fQr2Gly+v9+Ys1Q?=
 =?us-ascii?Q?9bP6BjrbS7AoidHFHTQbJhygo7+mLuVQ0EJN2vrkKIiY9xgGa+zReoiCNtwS?=
 =?us-ascii?Q?AfC0QYwBUquSjKOvTlZRwwfMvuJ4yHxACkcYrBUoY0NCtYD2SMuxTYGlw6v8?=
 =?us-ascii?Q?EZjwonsiyE4DvT+4TcjvVMUrlMea105uKur+zK69pO10Qs4AiBNzSUgUgrwP?=
 =?us-ascii?Q?bIrTksWYcQ/UssUe17vRS/Z2saWQeaci5v9p74F5cZ/j/OKphSwJVysKs+IB?=
 =?us-ascii?Q?pstMJug+esAu0w1yzjvSrl4V5lxEPqb7zpkjN09KBZH/pIQPipDCYvyGkHFc?=
 =?us-ascii?Q?ksurk3B19zlerjHqfuK1UvFLX3gP20SfgmzeLHTVCzKftLrGTkkoFOWFJCsU?=
 =?us-ascii?Q?pGFy0DkreHWcJOI1Y0+WHB3n9Zd4Hj/r5CKu+Uh2OZmC8QMdC5SsSAfkpgzv?=
 =?us-ascii?Q?PTH84enY6GXJ6j4Yahgc+H+GsF1zzG79Ma0q3hww3kHmGOBtEMVy49ySyGqs?=
 =?us-ascii?Q?L1PtW91m9ncmniG5qmUq59S3HLJIFDD+HkMCjnIChlYSR797w+vUZuqSn9xo?=
 =?us-ascii?Q?zcC+TZq4Vk4z9ZF4dx3p/oPg9B+zLaBot1fIoY5PQsLzbEEBXArSAxeQQH1g?=
 =?us-ascii?Q?wQ2Q+wiVNuT4JrreEslDkg7T0G59h3DFRXJzingk5I4Cqf81jIGSqRxHKxT1?=
 =?us-ascii?Q?Ya8rOen0E2Kbfi62BJNXizC+EZ0vcR0m/SthjngIoMmMrtPJKPk+Tprs9TGL?=
 =?us-ascii?Q?998Y0tK8XZ+JeH01QIVXMfhSRiJFJ84ixdQldPCl69mMuJnMJ0dg6Teschpp?=
 =?us-ascii?Q?DV45uFKx99AQ8+qQoRXNWlmTI7k2yeLTXvCBf0xf2cEtckSrBGtRAi621VAr?=
 =?us-ascii?Q?6koO6rr9bINa+8C/3Mc1lJYuZkpN8w08ziF1BrqJSCAmLSVhcjJRsQlMkrC6?=
 =?us-ascii?Q?EN7U118ZnBOufxxjo1uwKj5ENQKbvwu5Be0t69mlEIQ9dMksqLvMYp6fvlH2?=
 =?us-ascii?Q?ppk5IzZdpvf4l/7zrupPnRsO05X5O9pgvTlpmU/NnBq9UeJl55Z0m+4nNpiE?=
 =?us-ascii?Q?FxUY1h01bcFQU0saDi6Mk/1+xHn2X2remmvg/CDjy9W+2r3xggaK8vMR8kk/?=
 =?us-ascii?Q?B4E+o3sGTKlunQNlbdYAN9F0UKDqlIedzZjP6qW55biGcQbeQtc0/pMmJJwm?=
 =?us-ascii?Q?fAGcrkq+14f24Amlz1TnXMg9rbf6BzLLIndn0pQk6TDJCqoxYSnMxWrk6rYz?=
 =?us-ascii?Q?ipCeJ5DRXbbFX7FAa/P7nR86i6I7yyemSI63QJn1758+fRKBSKAN896Gm2vc?=
 =?us-ascii?Q?K3hGZC4DvhwQ4O4itYRzUAT0W4xZRYDP5iW88jjkMlBJtv4ojyDOkgS1BC7D?=
 =?us-ascii?Q?I74+Yqo5Cxhu93wl32wayb5o9UV9kVYqJhOFtWuU+iB0Oeys6tbJkmHCPuaO?=
 =?us-ascii?Q?fqPA3zgSVYKfZ8TLXh/2OOLyAbKYI6wssdIvmyoX7Ug+/WOuPqJ78d+rHTQh?=
 =?us-ascii?Q?Rr9vVmfRmWC+MPqSmnXJQZhUu6hjl9NVkP1ZWpn6SeCcJHXgFjbaMFukCUJl?=
 =?us-ascii?Q?Nw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52abc5d7-8f28-4930-b788-08dc9a71f0d0
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 08:35:34.3234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UQ9GivDBu1rvTXMGYzy3fjFb7n3qgUldofpQewehw9EORwiOkkkLS7fqd22cbKuhtfu3vzx1uyEJn9gf7BbtyBrvqwJA2JBwuYO9jPQ3RyE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1111

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


