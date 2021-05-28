Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4C32394876
	for <lists+linux-pwm@lfdr.de>; Fri, 28 May 2021 23:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbhE1VrR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 28 May 2021 17:47:17 -0400
Received: from mail-am6eur05on2052.outbound.protection.outlook.com ([40.107.22.52]:53252
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229607AbhE1VrQ (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 28 May 2021 17:47:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dEOKSOfXFEeAyQ/IDW4Vhp6FmTyw6PhJ4I1xJm+Vj63aT7yQwcs4JAE5nwhMdZdFOVYi8zZrZNk5ukgFiFInNfWsQL/qPpaBtLxxdm3Tjg4T4obRD16QgovmA2MeYviObcpwVqbdNpCXr4bkHgpj67sVst7p7MWm+Vgs3t3jyFqaZy44iuu01r/UjG+A4HQSdEy8eiyPL2f0TbesmrHfh/0q1mrFJTrzDZevQVnufnIgBE4AGLv8PF528VCZ7ijKdJW9dQT+JQJ4hx+WZqzBXaatHlznCs8RFxM2kmxaRVhvg8qBpQ/lv5/fguC9dNKiob7Mn8Z8YTH7vWC67Nw7Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2WDylAvFmejZI2yQF9kJ8+ZXVFAOLCwi2jsLuu+VVV0=;
 b=i2H2bG4dXd1ZCnyiCkDylJaO835g93Rthw4iVcVTIZVj+gCRf8XvAXaSj948hSfVKj9FjSlp1TJ0zVLBiM9f0nP5RMr7XT9xezXICzbgqpzH9l4AUt+O5KXKgi9GH0JsWZYuZ/2EQZd1jhb0SEUcUT7DgtXYTdzdFVRtTuWIzOIblTQq36HUUHe4pojmu8W3MBQjs72J3T3CH+w/EWnU3g/4X5NsQ2j9T5PM9D4LzZbXQ0qQHBluQVhlHdFpEPTG7sKUriqV+RZIVz49vIOJNDBP/chKMeiweY9mJxX/42HhYXDLvkWefi2eRsnCWFp8zC9hzhL1v4xJBYoBFzixWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2WDylAvFmejZI2yQF9kJ8+ZXVFAOLCwi2jsLuu+VVV0=;
 b=afJS5eefI1ebLvWWpqfomw/FYq/H8CddNwdFKF8FmpqefZ4kBo6VYuR6T9XY2U65QZHaAMMR6JGbN5SIWtfk7QzlQyMpCLp8wiH3qVwOdAr+J4GVy/ifc31kCl7CFm2dwdiOb0eH3fgmxMUjmmUMnTO6jgMLWnhVgu0OP6rqipI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DBBPR03MB6700.eurprd03.prod.outlook.com (2603:10a6:10:20c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Fri, 28 May
 2021 21:45:38 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b%5]) with mapi id 15.20.4173.024; Fri, 28 May 2021
 21:45:38 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     michal.simek@xilinx.com, linux-kernel@vger.kernel.org,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        linux-arm-kernel@lists.infradead.org,
        Sean Anderson <sean.anderson@seco.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v4 3/3] pwm: Add support for Xilinx AXI Timer
Date:   Fri, 28 May 2021 17:45:22 -0400
Message-Id: <20210528214522.617435-3-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210528214522.617435-1-sean.anderson@seco.com>
References: <20210528214522.617435-1-sean.anderson@seco.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [50.195.82.171]
X-ClientProxiedBy: BLAPR03CA0126.namprd03.prod.outlook.com
 (2603:10b6:208:32e::11) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from plantagenet.inhand.com (50.195.82.171) by BLAPR03CA0126.namprd03.prod.outlook.com (2603:10b6:208:32e::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22 via Frontend Transport; Fri, 28 May 2021 21:45:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 367d5f45-3f34-4a67-e939-08d92221ee93
X-MS-TrafficTypeDiagnostic: DBBPR03MB6700:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR03MB6700E4A01728A9B873E933CB96229@DBBPR03MB6700.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UhPrgeyM9NvJTzCblsg7oxRpBMcmhUFkgFLb1iKvMm0EWpjJC3wjMHMNO+NHWuDtvdmVWn+u+2Z7Pe78xe/Ce6YdqwzpAUzpSbPHx00zAgc5tcms7rBT1pScyWQ3RS7ZpaHcG7P+T/zuFxzpN+jXZfUNU5ucQD5dq9IL6YP0sOjJcmlIgafik11IJIOAI0BH2ADhB82P62VSkHHQk0kSLWRc9N/kfYYj8mr9Y+F3GR2px/swUhWBFvrKdoJysIpQ+sEdNYgPiGvhNws/g7LPJGcnO6ygPejiq/EFUgPpOMWDoc+laxrI7Wdzrff9PCATzVwb8abEvzqZBWVQseU/9+i+9PunebLJhIGhXM8wYKwKSpB2Omehngz50Mg1EqTgib3NE+C/XNMYQqsbS1wgwwYcZ80ur5x35O2G71voEBDT3N4MQj1vW28Ox6fJgYN4it+v1Kf7KX4LHbybq+ZLN3aWOcRW2UlX9P9Wxv5c4qdDxMWG2ejtEp+lx5rQYGPFTIHvZLyocYT3Zolk8LUUpmVO0yP+H4r/7pbr143nNeJ8+P0YqB6U3jTngvCbHpl6bdWTIOACLmJkaXW7uWTG4JlhPBBAL1a0tSaNoIyuLdWa5g6LbUD/6dZk9pi38v7ExRw08FXncMwJkFZreiJQuCfRaKJe1xfwtujLVPsw76RiXa4m4jqSk8QsZxYPscvZeDOSOenl/q0PQWnw3au9hm2mOaqDEBaZOY5lBrQ+iBb/5+yM7jvnVLYW7dWXuaaj+Jnw7cQ6xcBHXuP/cCMPIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(136003)(39840400004)(346002)(366004)(478600001)(8676002)(6666004)(956004)(83380400001)(26005)(86362001)(966005)(16526019)(2906002)(8936002)(316002)(38100700002)(6506007)(54906003)(186003)(30864003)(52116002)(36756003)(6486002)(44832011)(5660300002)(4326008)(6512007)(1076003)(66556008)(66476007)(38350700002)(66946007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eGVhaGlZNFliQ21FQWMvWE81ZzRqWHVHNDY0dm1WVmdxYW1zS1ROUEUvbTYw?=
 =?utf-8?B?a2dkWXpNbzNLczVaK2VOL3Q0MXpzdzVpMmlQKzg2Z296dTRibjRKRjIyQ1Js?=
 =?utf-8?B?MENvR0VnZC9GQXUrLzVMY1dYQm9vZ0dlNllmNy95akNHZncvUUgrY2graEdD?=
 =?utf-8?B?dVA5NDl6bjhoeHV6djhLOHFqaTlMZ3BMUG1MaXN6Z0FqS0xjYWZoZUZ6Tnc3?=
 =?utf-8?B?ek9WSUkwQXhCdmF2c2loa2tSdURVWWZyVkRibnhGb0czVUxjQ0g5UTVtUWtQ?=
 =?utf-8?B?Vm1SZG1IdXZGTVZTT2dPbkhFZHRXYWNkTFhsRVpXRHMvK2ludndjTjREeWxh?=
 =?utf-8?B?bnlLcThidXEyU1lBM2ZHb0ZvTkNUZGRDcDN0OU9NQ2Ria2dCZGs1VW1jaHI3?=
 =?utf-8?B?MFNXSEJZUnNDdTROREZYcDQvdm9pZHo2UnZ0d1N6dk50cEtEeE9pOHhTUXpJ?=
 =?utf-8?B?TG4yS054ZDZXdTZMVC90YTNnb3Jsb0NaV1NvRFpOekJvY0c3dnREQ2lDeFZz?=
 =?utf-8?B?cUdKaXdPQ256UWRacXV5MDBNMDRrajlZNkdJWWRGWmsrQjFRb1FHWFgzT21N?=
 =?utf-8?B?NmkrTEhXVmJuVnRQWGF6M3JJd2F1dzJRNEFBTk1hc2FnTG9uU0IzYWo0WlBG?=
 =?utf-8?B?eWkvTVNLc2MxZ2NsR3AwVDZlSVZ2NmZ1M3p5VGZFRDBCbmNyR2xWU1RZVmtY?=
 =?utf-8?B?QzhWTWkvMjhOZ2lYdDNNV2NVcTFhb2k0ZFoxYXJocHVTKzVpT040YTZUWHVm?=
 =?utf-8?B?RE1uYXlqSHJoaFNNTTM2bXJ6QjI5N2R2Q1RxVmU5R1lreDllVHgvQkxZVTE1?=
 =?utf-8?B?amF5SWxSR1g0cENBS096RGRFa3BkZHF2OWVFcjJ2ZHdWSTZpRS9Oc2ZaZ01x?=
 =?utf-8?B?c3dlRkcyZnBBcTlldzQ1YzNobHR2MWZGTWtHaU1QWmxqN29nZGxkeHNmQi9s?=
 =?utf-8?B?cXBISWRDeUhQYWF5VVRWbDJxeit1WWJJOStIdW1kQXpBQ0RIbHNaT045V1Q4?=
 =?utf-8?B?M2lwTDRUc0ZPd2dqR0VrTHRidkhHdE9XNHJudTliNmNZejMwR3RaTTUxM25V?=
 =?utf-8?B?MGhEU0hRbTBDYzErMng1ZFFtY1Z3MjZUVXRmWFBBcHBtUmRoVUxGMk1iUHN0?=
 =?utf-8?B?WHFJeGc0WWR2V0grSEZQZ2tCbmI4WXJ2YVRRLy9uOVM4VGUrZmNnT1lVWEdS?=
 =?utf-8?B?SFloNUZaSlBtTm9pY2xFRFRSbVJmVCtWczlmaW0yUms0UlQ4d2ZzT0xoNzNv?=
 =?utf-8?B?UGd2a2ovNnJpa2crbzF3L2w2ckN4dVpKUDI4bXJlNEl5OTFrZnBwSm9rRE5w?=
 =?utf-8?B?TnhacmFEL2QyNE03Tk1OR1R6UUpSSVlZbnA3NjE1WWp2NThBNVVvVFBTTExE?=
 =?utf-8?B?ZWJQdm5xc0VueEFUNEZCQlI5YUJYYm9WVEcxNmhMUnNuV1lraFcwekM4bE94?=
 =?utf-8?B?dWRTMVo4VHE3TUtCWHoxUy8rZEd0V0pQeXdON21pVUo4MVk5dXJzQlVLaGE3?=
 =?utf-8?B?L3ZXM0pweE4yUW9LTkFhd3hNL2Y5d3pjaG5LZjRBVXJiNC8vQ0J0ZkRmdTJs?=
 =?utf-8?B?c3VSTFhxUm9IVlVjVWJzNGNvTVc5enMvVUFJTGZTMGduRU5nbmg3YmxYVWpw?=
 =?utf-8?B?a2d1Q3dmalZRUTVKWkEzYjlYSkQzSU81cHpQL3Z5Ly9naXhBOGNDN0IwOE9D?=
 =?utf-8?B?WURLdTMzSG9KOUI3ZE51WFBTTCtGM3U1NXREMXJycE5ZSkdBYTQwSlh2RHBF?=
 =?utf-8?Q?iZL0bYi6a82S6b7M8SYeLBhcyyjsGmyXKkSGCC4?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 367d5f45-3f34-4a67-e939-08d92221ee93
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 21:45:38.3420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sMBmkq0nMxIsVwPCZ0vCKy2aTeIuikuy/kPCKkYGyqojCs4JO0okKMbdKb2zze+SZnMOEio0WBOZlgo0+esbkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB6700
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This adds PWM support for Xilinx LogiCORE IP AXI soft timers commonly
found on Xilinx FPGAs.  At the moment clock control is very basic: we
just enable the clock during probe and pin the frequency. In the future,
someone could add support for disabling the clock when not in use.

This driver was written with reference to Xilinx DS764 for v1.03.a [1].

[1] https://www.xilinx.com/support/documentation/ip_documentation/axi_timer/v1_03_a/axi_timer_ds764.pdf

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

Changes in v4:
- Remove references to properties which are not good enough for Linux.
- Don't use volatile in read/write replacements. Some arches have it and
  some don't.
- Put common timer properties into their own struct to better reuse
  code.

Changes in v3:
- Add clockevent and clocksource support
- Rewrite probe to only use a device_node, since timers may need to be
  initialized before we have proper devices. This does bloat the code a bit
  since we can no longer rely on helpers such as dev_err_probe. We also
  cannot rely on device resources being free'd on failure, so we must free
  them manually.
- We now access registers through xilinx_timer_(read|write). This allows us
  to deal with endianness issues, as originally seen in the microblaze
  driver. CAVEAT EMPTOR: I have not tested this on big-endian!
- Remove old microblaze driver

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

 drivers/mfd/Makefile     |   2 +-
 drivers/pwm/Kconfig      |  12 +++
 drivers/pwm/Makefile     |   1 +
 drivers/pwm/pwm-xilinx.c | 219 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 233 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pwm/pwm-xilinx.c

diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index f0f9fbdde7dc..89769affe251 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -269,6 +269,6 @@ obj-$(CONFIG_SGI_MFD_IOC3)	+= ioc3.o
 obj-$(CONFIG_MFD_SIMPLE_MFD_I2C)	+= simple-mfd-i2c.o
 obj-$(CONFIG_MFD_INTEL_M10_BMC)   += intel-m10-bmc.o
 
-ifneq ($(CONFIG_XILINX_TIMER),)
+ifneq ($(CONFIG_PWM_XILINX)$(CONFIG_XILINX_TIMER),)
 obj-y				+= xilinx-timer.o
 endif
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 8ae68d6203fb..ebf8d9014758 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -620,4 +620,16 @@ config PWM_VT8500
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-vt8500.
 
+config PWM_XILINX
+	tristate "Xilinx AXI Timer PWM support"
+	depends on HAS_IOMEM && COMMON_CLK
+	help
+	  PWM driver for Xilinx LogiCORE IP AXI timers. This timer is
+	  typically a soft core which may be present in Xilinx FPGAs.
+	  This device may also be present in Microblaze soft processors.
+	  If you don't have this IP in your design, choose N.
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
index 000000000000..f05321496717
--- /dev/null
+++ b/drivers/pwm/pwm-xilinx.c
@@ -0,0 +1,219 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2021 Sean Anderson <sean.anderson@seco.com>
+ *
+ * Hardware limitations:
+ * - When changing both duty cycle and period, we may end up with one cycle
+ *   with the old duty cycle and the new period.
+ * - Cannot produce 100% duty cycle.
+ * - Only produces "normal" output.
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/mfd/xilinx-timer.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+
+/*
+ * The idea here is to capture whether the PWM is actually running (e.g.
+ * because we or the bootloader set it up) and we need to be careful to ensure
+ * we don't cause a glitch. According to the data sheet, to enable the PWM we
+ * need to
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
+#define TCSR_PWM_SET (TCSR_GENT | TCSR_ARHT | TCSR_ENT | TCSR_PWMA)
+#define TCSR_PWM_CLEAR (TCSR_MDT | TCSR_LOAD)
+#define TCSR_PWM_MASK (TCSR_PWM_SET | TCSR_PWM_CLEAR)
+
+struct xilinx_pwm_device {
+	struct pwm_chip chip;
+	struct xilinx_timer_priv priv;
+};
+
+static inline struct xilinx_timer_priv
+*xilinx_pwm_chip_to_priv(struct pwm_chip *chip)
+{
+	return &container_of(chip, struct xilinx_pwm_device, chip)->priv;
+}
+
+static bool xilinx_timer_pwm_enabled(u32 tcsr0, u32 tcsr1)
+{
+	return ((TCSR_PWM_MASK | TCSR_CASC) & tcsr0) == TCSR_PWM_SET &&
+		(TCSR_PWM_MASK & tcsr1) == TCSR_PWM_SET;
+}
+
+static int xilinx_pwm_apply(struct pwm_chip *chip, struct pwm_device *unused,
+			    const struct pwm_state *state)
+{
+	int ret;
+	struct xilinx_timer_priv *priv = xilinx_pwm_chip_to_priv(chip);
+	u32 tlr0, tlr1;
+	u32 tcsr0 = xilinx_timer_read(priv, TCSR0);
+	u32 tcsr1 = xilinx_timer_read(priv, TCSR1);
+	bool enabled = xilinx_timer_pwm_enabled(tcsr0, tcsr1);
+
+	if (state->polarity != PWM_POLARITY_NORMAL)
+		return -EINVAL;
+
+	ret = xilinx_timer_tlr_period(priv, &tlr0, tcsr0, state->period);
+	if (ret)
+		return ret;
+
+	ret = xilinx_timer_tlr_period(priv, &tlr1, tcsr1, state->duty_cycle);
+	if (ret)
+		return ret;
+
+	xilinx_timer_write(priv, tlr0, TLR0);
+	xilinx_timer_write(priv, tlr1, TLR1);
+
+	if (state->enabled) {
+		/* Only touch the TCSRs if we aren't already running */
+		if (!enabled) {
+			/* Load TLR into TCR */
+			xilinx_timer_write(priv, tcsr0 | TCSR_LOAD, TCSR0);
+			xilinx_timer_write(priv, tcsr1 | TCSR_LOAD, TCSR1);
+			/* Enable timers all at once with ENALL */
+			tcsr0 = (TCSR_PWM_SET & ~TCSR_ENT) | (tcsr0 & TCSR_UDT);
+			tcsr1 = TCSR_PWM_SET | TCSR_ENALL | (tcsr1 & TCSR_UDT);
+			xilinx_timer_write(priv, tcsr0, TCSR0);
+			xilinx_timer_write(priv, tcsr1, TCSR1);
+		}
+	} else {
+		xilinx_timer_write(priv, 0, TCSR0);
+		xilinx_timer_write(priv, 0, TCSR1);
+	}
+
+	return 0;
+}
+
+static void xilinx_pwm_get_state(struct pwm_chip *chip,
+				 struct pwm_device *unused,
+				 struct pwm_state *state)
+{
+	struct xilinx_timer_priv *priv = xilinx_pwm_chip_to_priv(chip);
+	u32 tlr0 = xilinx_timer_read(priv, TLR0);
+	u32 tlr1 = xilinx_timer_read(priv, TLR1);
+	u32 tcsr0 = xilinx_timer_read(priv, TCSR0);
+	u32 tcsr1 = xilinx_timer_read(priv, TCSR1);
+
+	state->period = xilinx_timer_get_period(priv, tlr0, tcsr0);
+	state->duty_cycle = xilinx_timer_get_period(priv, tlr1, tcsr1);
+	state->enabled = xilinx_timer_pwm_enabled(tcsr0, tcsr1);
+	state->polarity = PWM_POLARITY_NORMAL;
+}
+
+static const struct pwm_ops xilinx_pwm_ops = {
+	.apply = xilinx_pwm_apply,
+	.get_state = xilinx_pwm_get_state,
+	.owner = THIS_MODULE,
+};
+
+static int xilinx_timer_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct xilinx_timer_priv *priv;
+	struct xilinx_pwm_device *pwm;
+	u32 pwm_cells, one_timer;
+
+	ret = of_property_read_u32(np, "#pwm-cells", &pwm_cells);
+	if (ret == -EINVAL)
+		return -ENODEV;
+	else if (ret)
+		return dev_err_probe(dev, ret, "#pwm-cells\n");
+	else if (pwm_cells)
+		return dev_err_probe(dev, -EINVAL, "#pwm-cells must be 0\n");
+
+	pwm = devm_kzalloc(dev, sizeof(*pwm), GFP_KERNEL);
+	if (!pwm)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, pwm);
+	priv = &pwm->priv;
+
+	priv->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->regs))
+		return PTR_ERR(priv->regs);
+
+	ret = xilinx_timer_common_init(np, priv, &one_timer);
+	if (ret)
+		return ret;
+
+	if (one_timer)
+		return dev_err_probe(dev, -EINVAL,
+				     "two timers required for PWM mode\n");
+
+	/*
+	 * The polarity of the generate outputs must be active high for PWM
+	 * mode to work. We could determine this from the device tree, but
+	 * alas, such properties are not allowed to be used.
+	 */
+
+	priv->clk = devm_clk_get(dev, "s_axi_aclk");
+	if (IS_ERR(priv->clk))
+		return dev_err_probe(dev, PTR_ERR(priv->clk), "clock\n");
+
+	ret = clk_prepare_enable(priv->clk);
+	if (ret)
+		return dev_err_probe(dev, ret, "clock enable failed\n");
+	clk_rate_exclusive_get(priv->clk);
+
+	pwm->chip.dev = dev;
+	pwm->chip.ops = &xilinx_pwm_ops;
+	pwm->chip.npwm = 1;
+	ret = pwmchip_add(&pwm->chip);
+	if (ret) {
+		clk_rate_exclusive_put(priv->clk);
+		clk_disable_unprepare(priv->clk);
+		return dev_err_probe(dev, ret, "could not register pwm chip\n");
+	}
+
+	return 0;
+}
+
+static int xilinx_timer_remove(struct platform_device *pdev)
+{
+	struct xilinx_pwm_device *pwm = platform_get_drvdata(pdev);
+
+	pwmchip_remove(&pwm->chip);
+	clk_rate_exclusive_put(pwm->priv.clk);
+	clk_disable_unprepare(pwm->priv.clk);
+	return 0;
+}
+
+static const struct of_device_id xilinx_timer_of_match[] = {
+	{ .compatible = "xlnx,xps-timer-1.00.a", },
+	{ .compatible = "xlnx,axi-timer-2.0" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, xilinx_timer_of_match);
+
+static struct platform_driver xilinx_timer_driver = {
+	.probe = xilinx_timer_probe,
+	.remove = xilinx_timer_remove,
+	.driver = {
+		.name = "xilinx-timer",
+		.of_match_table = of_match_ptr(xilinx_timer_of_match),
+	},
+};
+module_platform_driver(xilinx_timer_driver);
+
+MODULE_ALIAS("platform:xilinx-timer");
+MODULE_DESCRIPTION("Xilinx LogiCORE IP AXI Timer driver");
+MODULE_LICENSE("GPL v2");
-- 
2.25.1

