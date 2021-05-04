Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D39C0372FF3
	for <lists+linux-pwm@lfdr.de>; Tue,  4 May 2021 20:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbhEDSuk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 4 May 2021 14:50:40 -0400
Received: from mail-vi1eur05on2065.outbound.protection.outlook.com ([40.107.21.65]:14560
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231724AbhEDSuj (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 4 May 2021 14:50:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UhpHw6dwTK4xY6LoFDjnZHwDyl+wMpFSJ8acL90PEmLkQAadvm9xHpO7cwDUNRoDiLOaWzXSCff01Kz5SYBmjPMgEqg9NtLPHY9h76eaXuihaUecRVcc0QRqhLRbHuf4FGhMyOdxJ7+hzhV3/YuaIVugjiF8Iz6UeGSES2uEd+1W4nvY+s+bvVEzQaYFlnhj50h8b8SxoFk3UGjYqsSkWouL/n7tPocYN/dxR71Lm03qREusmYNRhnfEdSLqVfDTvRqeKVVI8zDwhkUw7z7kvEqzcclt/xQjGq/+s5/XQYhrYGr0XZ60EZHqqWrIT6jvguvDglmb0M5v4ia1Jh8Qew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YzqEeHtP8TgIkjk+7URRd9LeXpi0bXmJH40p4j/CSZ4=;
 b=Odqc9A80UzNlyZV5lYkQAWXG9oBsyrIEe1Hw7jSMOUsatm+qgz01bGtFHQzmfW7V/yxLW0Zm7HTjtBF8Hj5BNDuUhOoAvaRUegB6VbPFL/XTmccKKSMkjW6OMcsXO2mBwxq/FZ0wlOXBwkJMeTqc8YlluRKjNEmNESiL5NkcVrI2+LEkW4l4hh1JQZQ9hnA6PCTHQh2Ad/SiP4ExxLvp6D0VswRtny59QlbNWXiV/E02DIl3nvYBN1lM21vl9Ioi61IwK1PZmz396Z13JNMRYV1vZ+Bm34dW8wEoEMEVHv6DeTC9npgrQKlFtlQsFrpU27pQJ2YL8GaA1kwVPa53Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YzqEeHtP8TgIkjk+7URRd9LeXpi0bXmJH40p4j/CSZ4=;
 b=u/r5ROZhZZb88kXAM1h5yCFfA46ytsKsAmOj6pjCSZWCLuUJJjGOHp85c+eGpCl9jKsqZus/wN5lHd7cMq/g0V4aEPVrl33HCL5k8e3J867Ocls+yc3UlX2d+PtK5NV+vV25LANCVv5h70yudE/0iRZk7xD/iCrJBzEfw6qHRD4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB9PR03MB7276.eurprd03.prod.outlook.com (2603:10a6:10:1fd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24; Tue, 4 May
 2021 18:49:41 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b%5]) with mapi id 15.20.4087.044; Tue, 4 May 2021
 18:49:41 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        michal.simek@xilinx.com, Alvaro Gamez <alvaro.gamez@hazent.com>,
        Sean Anderson <sean.anderson@seco.com>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v2 2/2] pwm: Add support for Xilinx AXI Timer
Date:   Tue,  4 May 2021 14:49:25 -0400
Message-Id: <20210504184925.3399934-2-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210504184925.3399934-1-sean.anderson@seco.com>
References: <20210504184925.3399934-1-sean.anderson@seco.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [50.195.82.171]
X-ClientProxiedBy: MN2PR04CA0015.namprd04.prod.outlook.com
 (2603:10b6:208:d4::28) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from plantagenet.inhand.com (50.195.82.171) by MN2PR04CA0015.namprd04.prod.outlook.com (2603:10b6:208:d4::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend Transport; Tue, 4 May 2021 18:49:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 114618d6-6b73-414c-66cf-08d90f2d6006
X-MS-TrafficTypeDiagnostic: DB9PR03MB7276:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB9PR03MB727699E9B1559F9870783FDC965A9@DB9PR03MB7276.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /IlBy/P2abS/z6UsoU0IZ7dOXo92BP1Nq60oL7t10Dw1kRAOiNVFItzlr93Gs+18hUwEhfRzlVuYNz8iXMCfAmGpCD5AZxsy3RPD2gWkkWOplekNDq6F24h0jGBhrZuglFzlIJkNkVbDZWZHQ9w3rIhMNo8k3dmQld8GgCKg55gKsPgCH/BTpozOeJA35TQgyx2cFVRgkbYGOo9iWuF1Oa6Net2QuwPRTV7GyhvPL1mu0IlGJHKsHXcSHC8DruGEUX7OYqElv73rlEuYkZBSB9WMskUVEQdj+gKlbbf4ybCdZE41oxRZkUwEOt4rCldIeAcogtW4TzY9Hi2QdisyYsZzGRBMICyopC2/8XgBxKQVa/vTkqQiFHbID8/lFqPJFAZt1Vv/hQ5IjO+YMuBGMTnspFpjmjgqi/ptLeo21b3qvAIjpswExItapc6dnQlnwDBypoH5qhX4qcMkQZd+m/XPT5ztyeT1Al3qKdokphvXwU33EbhIHslOXYV/3249GGcWHbE4faWXGTXAZ3/ezTjeIAU9IShnvgpcwwQ83m6ITO3y7256vvvNM6Xwxh1QhAX1SIUdan3Pb4ZR2ohv6yDenYJpz00GQyTjj1qovMzYyxkcqgi5sY7ao/W34kRzIKDySYgwSqXyaVrJJ+UvwJjbKjCLNR6R24HYGJeOfEsMr72eztNR/OcUX6HhRy9/xgV7hQO8WdCR0YGIHKCf0z32sXh141Xu6SlypMRX4f8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(346002)(396003)(39830400003)(376002)(38350700002)(38100700002)(66946007)(66556008)(2906002)(5660300002)(66476007)(44832011)(26005)(52116002)(478600001)(6486002)(6506007)(8936002)(16526019)(6666004)(966005)(186003)(2616005)(83380400001)(8676002)(86362001)(4326008)(956004)(36756003)(6512007)(30864003)(1076003)(316002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NzZHWVp5clU0RHVpejRQQWVaZjNPM0kyOTFUR0sxWG50VE5LTVFtWjlGLzEw?=
 =?utf-8?B?ODMxeUJad0Q3NXp2Y1dMWU0rWjUyWTMzYkZVaVUxaGZvVEI3ejhIdk11Zkxt?=
 =?utf-8?B?cStlajVOTlZLdFA3RjZnS0tIYzhmR01YZS9PcElrRnlDRHRvMkxod256L1U1?=
 =?utf-8?B?VWxUd2RYQ1hKRXZreThEcGw2dUUzQ0dRc1hRaWQvMDU4cjhDd01Dd3I0SXoy?=
 =?utf-8?B?SWhlYi9Yamh6RklaSjgrL29sLzlMdEpwNmt5S3gweXpPQzNXL0hjaFArb21q?=
 =?utf-8?B?eXlYRUR0VDJwNklSZE5vMFZuaWt5ZzRxN3FjOHFZb090M0hiOGV0NmE3ZU05?=
 =?utf-8?B?Y2ZnM1N1R0dIOWRyMytvemk3RTJaVktxREoxd0g5QVN6SHdTV0dQRC9LMGw0?=
 =?utf-8?B?Z0QyQ3VRcGY3ekRZQ2dHcWYzbWNjemN0ZjdxSWxjVVhTNmU0d3RuVkpCNVJK?=
 =?utf-8?B?RGtlb0cycVJTRGdKMWpYV3pqcUg5Zk5NN2FCUnNVd3RjclpzT0hYVGZjUm4w?=
 =?utf-8?B?VjliNUI1Rzd1SjE5OXhlZ3NTWjA1cE9XaHdHN3ZzYTR4cmlnUFNZSHV0bTRU?=
 =?utf-8?B?L1ltNk9wUEZRbGVMaVNnVHVqK3N4Y0ZNK0c1OG1iUC8xRkEydTd2RWY1MEF1?=
 =?utf-8?B?QURpSVYzbXZsdDRrYmFOeVJaTzgzcFcyMldmWGNsVm8yS2Q1dVNzeEgzTFVJ?=
 =?utf-8?B?RXcrUk94R0phV3dHRVRDb3BETmU1UmZSNXZQR000ckZwaVp4MGJlQVdWNnkv?=
 =?utf-8?B?N3UxM2s3NVh2T1VkMHVEaFpPQnUvMW1Id3FzVzNSbTBwVGFKOHpud05VZUZo?=
 =?utf-8?B?UUl0RnRabFF1VUoxbWpQWmxPNEdXcWc4T2JOUGVMZEoybU9LdlZRWWcvay90?=
 =?utf-8?B?cCtLeVpEK00rN0ZWaFA1aEltMkwrQnZIZHp2NkpOcERTcjdYd1pwRGpmcytR?=
 =?utf-8?B?bzBHZ2xJdGR1Nzd0SUlwSTFYd2l0cUR0eXF0cDlvZXJvWFg1Ym5XVVB2aWJo?=
 =?utf-8?B?a1hMWmcrZm16STl4UzJFNFB2UWc1TjYwVHUxcUZEU3ZxSVI0Y29xbXlwSGc4?=
 =?utf-8?B?aC9kT2JRRlBtWUhBMzJRR3BaL0RXV0xLOFhFcEZEbEcvZ0hHY0Y4SEZLSVlD?=
 =?utf-8?B?UDlQemtZaHpndUFzdzl0TW5LMS9lcFJxWjFuVy9TQzM5OHBJditIS2psMm5j?=
 =?utf-8?B?aTRTd29DMDFnbGZMQXZWa3BFNk1IbXlWM1F4UStEbkpOZll4SWxEaUhxWUtO?=
 =?utf-8?B?K3FHNnJoOS9SRGl3RDVnVitETVdmZmN3eS9UVFgrdm1MRUlYRWhmaUZnRXNP?=
 =?utf-8?B?dXJEa0ZHU1ZyTDlqSmZZeVlpOUQ4OFRoRDJkUjRVWC95NEpTK1hVY1g2cTFs?=
 =?utf-8?B?Y0N6aEVBTmdBRFViamtRWXdCbzNUUC9nZTVjR2poMUxhbkFjckE0RFU3bzFt?=
 =?utf-8?B?bSsyUGhiazhuR1hrRzhXOTZxRXRucnpwNXdpTms2TGNhM1lZTEFQeE9TNzhM?=
 =?utf-8?B?UzZkY05TMysrRUdIbndESnlTQnVlemRiRzh4d1YvdmJuMXYrOS9uR3ZINDBw?=
 =?utf-8?B?amFkNlk5akFibW40Vk5CdlBqbTB6MWRzTmU3RWJ5VUJ6UENoTlpNcWhYZERL?=
 =?utf-8?B?U3hzUnNqSzEzZ2UvMTc3WjlCTFpOTWtvZDlHZnY1OVZ3eUdoZFNTM3hGT3M1?=
 =?utf-8?B?cC9MUGtPNHc0MHV2QUk2ek1ydC8rbVlieTNSNWJTNjBpVXY4YjJuSjBFS2xS?=
 =?utf-8?Q?yGFVw8hP5x+t+n6JbYU4ZJ+0zNeCSprVnpmbyTl?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 114618d6-6b73-414c-66cf-08d90f2d6006
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2021 18:49:41.0551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j77SXbp0kKzp3g2X9pd+xCv2XFPkHYpg+blCVm8hVqMqUOgADcbrTVOlFPYVFgXS3DokeLpMNiunvEUakf/t6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB7276
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This adds PWM support for Xilinx LogiCORE IP AXI soft timers commonly
found on Xilinx FPGAs. There is another driver for this device located
at arch/microblaze/kernel/timer.c, but it is only used for timekeeping.
This driver was written with reference to Xilinx DS764 for v1.03.a [1].

[1] https://www.xilinx.com/support/documentation/ip_documentation/axi_timer/v1_03_a/axi_timer_ds764.pdf

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---
I tried adding a XILINX_PWM_ prefix to all the defines, but IMO it
really hurt readability. That prefix almost doubles the size the
defines, and is particularly excessive in something like
XILINX_PWM_TCSR_RUN_MASK.

Changes in v2:
- Don't compile this module by default for arm64
- Add dependencies on COMMON_CLK and HAS_IOMEM
- Add comment explaining why we depend on !MICROBLAZE
- Add comment describing device
- Rename TCSR_(SET|CLEAR) to TCSR_RUN_(SET|CLEAR)
- Use NSEC_TO_SEC instead of defining our own
- Use TCSR_RUN_MASK to check if the PWM is enabled, as suggested by Uwe
- Cast dividends to u64 to avoid overflow
- Check for over- and underflow when calculating TLR
- Set xilinx_pwm_ops.owner
- Don't set pwmchip.base to -1
- Check range of xlnx,count-width
- Ensure the clock is always running when the pwm is registered
- Remove debugfs file :l
- Report errors with dev_error_probe

 drivers/pwm/Kconfig      |  13 ++
 drivers/pwm/Makefile     |   1 +
 drivers/pwm/pwm-xilinx.c | 301 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 315 insertions(+)
 create mode 100644 drivers/pwm/pwm-xilinx.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 8ae68d6203fb..b1ad77ec81e3 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -620,4 +620,17 @@ config PWM_VT8500
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-vt8500.
 
+config PWM_XILINX
+	tristate "Xilinx AXI Timer PWM support"
+	depends on HAS_IOMEM && COMMON_CLK
+	# This driver conflicts with arch/microblaze/kernel/timer.c
+	depends on !MICROBLAZE
+	help
+	  PWM framework driver for Xilinx LogiCORE IP AXI Timers. This
+	  timer is typically a soft core which may be present in Xilinx
+	  FPGAs. If you don't have this IP in your design, choose N.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-xilinx.
+
 endif
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index d43b1e17e8e1..655df169b895 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -58,3 +58,4 @@ obj-$(CONFIG_PWM_TWL)		+= pwm-twl.o
 obj-$(CONFIG_PWM_TWL_LED)	+= pwm-twl-led.o
 obj-$(CONFIG_PWM_VISCONTI)	+= pwm-visconti.o
 obj-$(CONFIG_PWM_VT8500)	+= pwm-vt8500.o
+obj-$(CONFIG_PWM_XILINX)	+= pwm-xilinx.o
diff --git a/drivers/pwm/pwm-xilinx.c b/drivers/pwm/pwm-xilinx.c
new file mode 100644
index 000000000000..10483da1a942
--- /dev/null
+++ b/drivers/pwm/pwm-xilinx.c
@@ -0,0 +1,301 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2021 Sean Anderson <sean.anderson@seco.com>
+ *
+ * For Xilinx LogiCORE IP AXI Timer documentation, refer to DS764:
+ * https://www.xilinx.com/support/documentation/ip_documentation/axi_timer/v1_03_a/axi_timer_ds764.pdf
+ *
+ * Hardware limitations:
+ * - When changing both duty cycle and period, we may end up with one cycle
+ *   with the old duty cycle and the new period.
+ * - Cannot produce 100% duty cycle.
+ * - Only produces "normal" output.
+ */
+#include <asm/io.h>
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+
+#define TCSR0	0x00
+#define TLR0	0x04
+#define TCR0	0x08
+#define TCSR1	0x10
+#define TLR1	0x14
+#define TCR1	0x18
+
+#define TCSR_MDT	BIT(0)
+#define TCSR_UDT	BIT(1)
+#define TCSR_GENT	BIT(2)
+#define TCSR_CAPT	BIT(3)
+#define TCSR_ARHT	BIT(4)
+#define TCSR_LOAD	BIT(5)
+#define TCSR_ENIT	BIT(6)
+#define TCSR_ENT	BIT(7)
+#define TCSR_TINT	BIT(8)
+#define TCSR_PWMA	BIT(9)
+#define TCSR_ENALL	BIT(10)
+#define TCSR_CASC	BIT(11)
+
+/*
+ * The idea here is to capture whether the PWM is actually running (e.g.
+ * because we or the bootloader set it up) and we need to be careful to ensure
+ * we don't cause a glitch. According to the device data sheet, to enable the
+ * PWM we need to
+ *
+ * - Set both timers to generate mode (MDT=1)
+ * - Set both timers to PWM mode (PWMA=1)
+ * - Enable the generate out signals (GENT=1)
+ *
+ * In addition,
+ *
+ * - The timer must be running (ENT=1)
+ * - The timer must auto-reload TLR into TCR (ARHT=1)
+ * - We must not be in the process of loading TLR into TCR (LOAD=0)
+ * - Cascade mode must be disabled (CASC=0)
+ *
+ * If any of these differ from usual, then the PWM is either disabled, or is
+ * running in a mode that this driver does not support.
+ */
+#define TCSR_RUN_SET (TCSR_GENT | TCSR_ARHT | TCSR_ENT | TCSR_PWMA)
+#define TCSR_RUN_CLEAR (TCSR_MDT | TCSR_LOAD)
+#define TCSR_RUN_MASK (TCSR_RUN_SET | TCSR_RUN_CLEAR)
+
+/**
+ * struct xilinx_pwm_device - Driver data for Xilinx AXI timer PWM driver
+ * @chip: PWM controller chip
+ * @clk: Parent clock
+ * @regs: Base address of this device
+ * @width: Width of the counters, in bits
+ */
+struct xilinx_pwm_device {
+	struct pwm_chip chip;
+	struct clk *clk;
+	void __iomem *regs;
+	unsigned int width;
+};
+
+static inline struct xilinx_pwm_device *xilinx_pwm_chip_to_device(struct pwm_chip *chip)
+{
+	return container_of(chip, struct xilinx_pwm_device, chip);
+}
+
+static bool xilinx_pwm_is_enabled(u32 tcsr0, u32 tcsr1)
+{
+	return ((TCSR_RUN_MASK | TCSR_CASC) & tcsr0) == TCSR_RUN_SET &&
+		(TCSR_RUN_MASK & tcsr1) == TCSR_RUN_SET;
+}
+
+static int xilinx_pwm_calc_tlr(struct xilinx_pwm_device *pwm, u32 *tlr, u32 tcsr,
+			       unsigned int period)
+{
+	u64 max_count = BIT_ULL(pwm->width) - 1;
+	u64 cycles = DIV_ROUND_DOWN_ULL((u64)period * clk_get_rate(pwm->clk),
+					NSEC_PER_SEC);
+
+	if (cycles < 2)
+		return -ERANGE;
+
+	if (tcsr & TCSR_UDT) {
+		if (cycles - 2 > max_count)
+			return -ERANGE;
+		*tlr = cycles - 2;
+	} else {
+		if (cycles > max_count + 2)
+			return -ERANGE;
+		*tlr = max_count - cycles + 2;
+	}
+
+	return 0;
+}
+
+static unsigned int xilinx_pwm_get_period(struct xilinx_pwm_device *pwm,
+					  u32 tlr, u32 tcsr)
+{
+	u64 cycles;
+
+	if (tcsr & TCSR_UDT)
+		cycles = tlr + 2;
+	else
+		cycles = (BIT_ULL(pwm->width) - 1) - tlr + 2;
+
+	return DIV_ROUND_UP_ULL(cycles * NSEC_PER_SEC, clk_get_rate(pwm->clk));
+}
+
+static int xilinx_pwm_apply(struct pwm_chip *chip, struct pwm_device *unused,
+			    const struct pwm_state *state)
+{
+	int ret;
+	struct xilinx_pwm_device *pwm = xilinx_pwm_chip_to_device(chip);
+	u32 tlr0, tlr1;
+	u32 tcsr0 = readl(pwm->regs + TCSR0);
+	u32 tcsr1 = readl(pwm->regs + TCSR1);
+	bool enabled = xilinx_pwm_is_enabled(tcsr0, tcsr1);
+
+	if (state->polarity != PWM_POLARITY_NORMAL)
+		return -EINVAL;
+
+	ret = xilinx_pwm_calc_tlr(pwm, &tlr0, tcsr0, state->period);
+	if (ret)
+		return ret;
+
+	ret = xilinx_pwm_calc_tlr(pwm, &tlr1, tcsr1, state->duty_cycle);
+	if (ret)
+		return ret;
+
+	if (!enabled && state->enabled)
+		clk_rate_exclusive_get(pwm->clk);
+
+	writel(tlr0, pwm->regs + TLR0);
+	writel(tlr1, pwm->regs + TLR1);
+
+	if (state->enabled) {
+		/* Only touch the TCSRs if we aren't already running */
+		if (!enabled) {
+			/* Load TLR into TCR */
+			writel(tcsr0 | TCSR_LOAD, pwm->regs + TCSR0);
+			writel(tcsr1 | TCSR_LOAD, pwm->regs + TCSR1);
+			/* Enable timers all at once with ENALL */
+			tcsr0 = (TCSR_RUN_SET & ~TCSR_ENT) | (tcsr0 & TCSR_UDT);
+			tcsr1 = TCSR_RUN_SET | TCSR_ENALL | (tcsr1 & TCSR_UDT);
+			writel(tcsr0, pwm->regs + TCSR0);
+			writel(tcsr1, pwm->regs + TCSR1);
+		}
+	} else {
+		writel(tcsr0 & ~TCSR_RUN_SET, pwm->regs + TCSR0);
+		writel(tcsr1 & ~TCSR_RUN_SET, pwm->regs + TCSR1);
+	}
+
+	if (enabled && !state->enabled)
+		clk_rate_exclusive_put(pwm->clk);
+
+	return 0;
+}
+
+static void xilinx_pwm_get_state(struct pwm_chip *chip,
+				 struct pwm_device *unused,
+				 struct pwm_state *state)
+{
+	struct xilinx_pwm_device *pwm = xilinx_pwm_chip_to_device(chip);
+	u32 tlr0, tlr1, tcsr0, tcsr1;
+
+	tlr0 = readl(pwm->regs + TLR0);
+	tlr1 = readl(pwm->regs + TLR1);
+	tcsr0 = readl(pwm->regs + TCSR0);
+	tcsr1 = readl(pwm->regs + TCSR1);
+
+	state->period = xilinx_pwm_get_period(pwm, tlr0, tcsr0);
+	state->duty_cycle = xilinx_pwm_get_period(pwm, tlr1, tcsr1);
+	state->enabled = xilinx_pwm_is_enabled(tcsr0, tcsr1);
+	state->polarity = PWM_POLARITY_NORMAL;
+}
+
+static const struct pwm_ops xilinx_pwm_ops = {
+	.apply = xilinx_pwm_apply,
+	.get_state = xilinx_pwm_get_state,
+	.owner = THIS_MODULE,
+};
+
+static int xilinx_pwm_probe(struct platform_device *pdev)
+{
+	bool enabled = false;
+	int i, ret;
+	struct device *dev = &pdev->dev;
+	struct xilinx_pwm_device *pwm;
+	u32 one_timer;
+
+	ret = of_property_read_u32(dev->of_node, "xlnx,one-timer-only",
+				   &one_timer);
+	if (ret || one_timer)
+		return dev_err_probe(dev, -EINVAL,
+				     "two timers are needed for PWM mode\n");
+
+	for (i = 0; i < 2; i++) {
+		char fmt[] = "xlnx,gen%u-assert";
+		char buf[sizeof(fmt)];
+		u32 gen;
+
+		snprintf(buf, sizeof(buf), fmt, i);
+		ret = of_property_read_u32(dev->of_node, buf, &gen);
+		if (ret || !gen)
+			return dev_err_probe(dev, -EINVAL,
+					     "generateout%u must be active high\n",
+					     i);
+	}
+
+	pwm = devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
+	if (!pwm)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, pwm);
+
+	pwm->chip.dev = &pdev->dev;
+	pwm->chip.ops = &xilinx_pwm_ops;
+	pwm->chip.npwm = 1;
+
+	pwm->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(pwm->regs))
+		return PTR_ERR(pwm->regs);
+
+	ret = of_property_read_u32(dev->of_node, "xlnx,count-width", &pwm->width);
+	if (ret || pwm->width < 8 || pwm->width > 32)
+		return dev_err_probe(dev, -EINVAL,
+				     "missing or invalid counter width\n");
+
+	pwm->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(pwm->clk))
+		return dev_err_probe(dev, PTR_ERR(pwm->clk), "missing clock\n");
+
+	ret = clk_prepare_enable(pwm->clk);
+	if (ret)
+		return dev_err_probe(dev, ret, "clock enable failed\n");
+
+	enabled = xilinx_pwm_is_enabled(readl(pwm->regs + TCSR0),
+					readl(pwm->regs + TCSR1));
+	if (enabled)
+		clk_rate_exclusive_get(pwm->clk);
+
+	ret = pwmchip_add(&pwm->chip);
+	if (ret) {
+		dev_err_probe(dev, ret, "could not register pwm chip\n");
+		if (enabled)
+			clk_rate_exclusive_put(pwm->clk);
+		clk_disable_unprepare(pwm->clk);
+	}
+	return ret;
+}
+
+static int xilinx_pwm_remove(struct platform_device *pdev)
+{
+	struct xilinx_pwm_device *pwm = platform_get_drvdata(pdev);
+	bool enabled = xilinx_pwm_is_enabled(readl(pwm->regs + TCSR0),
+					     readl(pwm->regs + TCSR1));
+
+	pwmchip_remove(&pwm->chip);
+	if (enabled)
+		clk_rate_exclusive_put(pwm->clk);
+	clk_disable_unprepare(pwm->clk);
+
+	return 0;
+}
+
+static const struct of_device_id xilinx_pwm_of_match[] = {
+	{ .compatible = "xlnx,xps-timer-1.00.a" },
+	{ .compatible = "xlnx,axi-timer-2.0" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, xilinx_pwm_of_match);
+
+static struct platform_driver xilinx_pwm_driver = {
+	.probe = xilinx_pwm_probe,
+	.remove = xilinx_pwm_remove,
+	.driver = {
+		.name = "xilinx-pwm",
+		.of_match_table = of_match_ptr(xilinx_pwm_of_match),
+	},
+};
+module_platform_driver(xilinx_pwm_driver);
+
+MODULE_ALIAS("platform:xilinx-pwm");
+MODULE_DESCRIPTION("Xilinx LogiCORE IP AXI Timer PWM driver");
+MODULE_LICENSE("GPL v2");
-- 
2.25.1

