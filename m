Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4B163F901D
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Aug 2021 23:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243715AbhHZVTn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 26 Aug 2021 17:19:43 -0400
Received: from mail-eopbgr10086.outbound.protection.outlook.com ([40.107.1.86]:60380
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230182AbhHZVTe (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 26 Aug 2021 17:19:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ofjkljE9O6AWvZOH64IAu8UKdl31oK0UovC80nEA9lPySCrK7GTJDH9340TceJrViB45Tb1KbnctBCL9R5NY388vO8GZwCMI30nJgay6LB2HUlarZZ50TrNza1Mo89xyX+yOiyxhiLEpB4YEvNxBSE7Y2vIjAL/APAHMJcgNjfqYotwc/T1vXZOa2j7eSgEVP0pBO11fXGC2RVe7MUctR5AzNbpl7q2DiTkv7gJ0NVV786vRBZn+TNCga+WSaEc2NQM9Ad0Po8rQ741ZYVZI9vmQ69V36IkWpE0FtMGHEF5BXqU8SDhInUoRTiP26EVDFjx4vc84lYYlq2bLM56mlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZX2/rWC16xV5hSTWBXiLoucJ770SfS6XBiW/T7DCCQ=;
 b=Qo+AQAdb4UcjfwZDlv1EGHiQs6gFB87lqrD8iI0x0OvAB5DGbqvWvadPOpPCt3RjcVi7M9OX3DqIgYifgqwm3bTCzxBF0LDeZNd2i8PUbGSr5B1ZskIKeQ0SdWSebcUpvurtX/rQarroKDyMGvt+uSuRzeVko8Z8gHRhU2pxUTY+XK9CJEpwOkTgtZ+jNu1J9bQORtjF1iPjbAtoniF4fKAfk7xrLM0bst5P9uBFIX3p3AgCFJ6QlDoE/GylNsBNEH/n0QqnsECz4sOt9eU27RIKXwzKquv6V3wVIZYQhCEM0AncH4MrcqKRyTXUmfkG8N6u+Q5oAr0FWswovAuBWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZX2/rWC16xV5hSTWBXiLoucJ770SfS6XBiW/T7DCCQ=;
 b=wJDOJKvh9BiTWlcdRPkN+I87RHPUI++XSOxv8ITTvn0pL5c7iBloraTIgZBbBXpJ6a9dToBW0qQ5wQYw1ZqqdDC+Oq06isDV3/QtSPfvXgUnWUmmJNnYouAQ3UPv5qo0WjaOZo+GmzmupZ6y3swQX+GH4uBqoFjxZr0+AH8KP2c=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB6PR0301MB2182.eurprd03.prod.outlook.com (2603:10a6:4:49::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Thu, 26 Aug
 2021 21:18:43 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1%7]) with mapi id 15.20.4436.025; Thu, 26 Aug 2021
 21:18:43 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Alvaro Gamez <alvaro.gamez@hazent.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Lee Jones <lee.jones@linaro.org>, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v6 3/3] pwm: Add support for Xilinx AXI Timer
Date:   Thu, 26 Aug 2021 17:18:30 -0400
Message-Id: <20210826211830.3311140-3-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210826211830.3311140-1-sean.anderson@seco.com>
References: <20210826211830.3311140-1-sean.anderson@seco.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR06CA0016.namprd06.prod.outlook.com
 (2603:10b6:208:23d::21) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from plantagenet.inhand.com (50.195.82.171) by MN2PR06CA0016.namprd06.prod.outlook.com (2603:10b6:208:23d::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.21 via Frontend Transport; Thu, 26 Aug 2021 21:18:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85d0a93b-555c-45cd-4a49-08d968d7155b
X-MS-TrafficTypeDiagnostic: DB6PR0301MB2182:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0301MB218281816F512309E821A49396C79@DB6PR0301MB2182.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KvZc+G4lmAAALSwcqtJYbIM/wtkCDgl9P4ff73DAjFY+49wYJR7/RjWg31qfneOF47GQcW9Uq6GqFRLmSAEuk2ItvhyeoMF9YglDq0JxyL+ofpLZERQ2RzfwbKu/bk2zNNvosjdNXPkTKqFPkxqP2ttXLo0mzEe/A/Htx/XuSF3F5ZoCnKhtIXs923VI++x3xUV3KuQ1T+tfErwoUmELJwesGLiO7D3g5ZeMjNVcfEavN5kNtFkT7IF77gKU6GygbPRZWXBE63Gk38Edy0JHWcdDxAZLs4wbcwkdvQoaB9zunf4rv3+hMFEHiF9k8Flt9pnKCo93ef3L3nPGT146ODMPPyahrJvWomDIWZE4aPOE5tWV7mTVJItbydMeBQKPBHDSJz3TEmzCKXNVBTdofBEngyoVzUpXq5VvoBXkbLsI3lmFvNY8UNoGBQMtHgRhfyl37hPe5i48BWNNSR2CuzC9nl5AZf/u+dLcQY3mpxf8hx0ScrgD+lAohOQG6qBh6RF8U+F4KFhHdhXicNyNrT2EUvzBlX8jF13jRLvTxkQzyHnn0IifI1kbB9BZjew/NJydyA97owDcDAYHr1RH+WXdvJTBAlNXRatBiPbdWLUca9ULJn+kbpc0P0OlSwD8hvrNXFybhyanjWUql7ZcEEPuKrRs89VReOgzh/WSAZmtS1pp3XDJQRtjp3G0YQvHspUsdQi62Tf6Oth4Esgp30rnjfLsNPQ0N/nf7bgV2qa2squgJWLhCIi03J7k6NfgEEwsnztGPIDEM2JSzqvZf8pIt1I1zVMhoMNKkEWHvo8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(366004)(136003)(39840400004)(30864003)(36756003)(5660300002)(38100700002)(6506007)(38350700002)(966005)(44832011)(478600001)(83380400001)(6916009)(316002)(2616005)(26005)(86362001)(54906003)(6512007)(956004)(6486002)(66946007)(1076003)(8676002)(8936002)(6666004)(107886003)(4326008)(2906002)(186003)(66476007)(52116002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2x2aDRtc2VScFRJV2lCSitoaHk0SkZBV2NQa3RURmtDZjluTzd3eGpxS0xq?=
 =?utf-8?B?QThQbVYrRWsyVHlyMDY4dGI5L0c4Skk4YXpFcExFemQxaUlZWGVrbnh4akMw?=
 =?utf-8?B?d2tQelVsd2FmcEUvaEZ3aUNqZlhvM2NZdk9zSjQzbTB2VGtwTk1HdTRXcDht?=
 =?utf-8?B?UUVyOFJLbS9lUVNQWjN4TE1kZkt3dWZ5VUxGUnBJRVZaMWZueEQ2U1dpV0hy?=
 =?utf-8?B?N2laZDRsS3NlVXZwcUNUdzJFT1VBMHJoQ3NCdjUzTDBXQlVUY1I1SEFwNGNw?=
 =?utf-8?B?blpxaEJxdVpKNHBiYWZuU1pSaXNFTnZvZWhXcGJuaERscjI2WWhabUcvSkNZ?=
 =?utf-8?B?L0doOTVRQUpMN1J6MThSK1JmOTlqRk14bHBIVVNPT1Y4WWtGODJrQnM1Uzgz?=
 =?utf-8?B?WGx1RWNuNW5RZ0FyN0hxbHVoVkZaM1FpRVlQMG90bEowdjVsa0Q1S21FdjRD?=
 =?utf-8?B?UitFNzJMbXAxQ2VDTWtsSm1YK3Y3TDQyeHVYRXVKaEZDT1phWENidVVtNHdW?=
 =?utf-8?B?a2NWcWNDcHdPTW43N3ZZbTBHUzlKeldkRW4vcm5mM3RacHRvRXFqcTh5SDlM?=
 =?utf-8?B?UisrRXh1S1AyL2tVbDFtQjVsUHZFbVllaE5kMkJ4RzJFc2VJdzhLWGhKZTI5?=
 =?utf-8?B?RXlkWGloazdhdStUckplSTV5b2JxYm5GMVdNdFNhSFZTSGN0K0JhQXZSMnNq?=
 =?utf-8?B?VXVsSzVOZ3A2NjBETlJ6ckpEeTc3YWl6RmFKNEJLUnZIdjRxeTJHaWNHWkVV?=
 =?utf-8?B?SEhrZEcvOEZhWDllK3R5TTRtbXQ2a3d3MEt5dEg3ZXlBVHJzcHo0T3prc2E1?=
 =?utf-8?B?cy9HMDFrVWZsdmY4TUNEZGJFTi8zdGIxRHhiY3BvMHBDS0txK0FpNzhPYnZw?=
 =?utf-8?B?ckEzMW11VjdIbldZWkZjdklRaXJEcXh5a095K1hMV2VBWHpOVTJWdWorbGFk?=
 =?utf-8?B?YlVjNTdDV2NsWHBDYUdIclcrcE83ZGFvTGNTbm13clNiRDVIcHY2VCtaMXh2?=
 =?utf-8?B?NEJYTENTRlhKSko3b0VFaEd0ZWZIdk94bmxTRzZJbnFnTU9LeXJCNVZnT2RY?=
 =?utf-8?B?NTd1bWdHRldaYUtvRmVtY0pydTdvM29rR2wvMmhqL2ZTVEVIV0t0YmlHanZ3?=
 =?utf-8?B?OGR1Uit0bS9YU0RwbHEwdURTNnB5eWo0d28yb085ck1pZGFGb3haUFBiK0Ex?=
 =?utf-8?B?alZ5S1YxbVVJbjVsTG83U0pOanhvdHFWcW50eE5mZDZYeWV5TlllTTNZN0Y1?=
 =?utf-8?B?OHNDbFZUcEdlWkJkUGVPanp1a2dHekdIZGZFbjBBTHVvZWJyZFFERGpUSEhN?=
 =?utf-8?B?RXR0SlhrWTZFN0g2Q01Wa3RFQ3BrOW05anpnb2FLNVlibGdsSWNJWUlXYnEr?=
 =?utf-8?B?Z0RzclRDdUNZdTQwcmVpY1JoR1lTOU9aVlZydEJJeFczZzNEaytaRXJCVHJP?=
 =?utf-8?B?ZUpZN1o4UFJ6WEg5VWpoMk1IY2J1aTRQbUp1ZGdMYzZBSGFQdFBPYnE2Mm4v?=
 =?utf-8?B?djZzVnl4ZkU0UGtJVXFsVmo1Mm1vZHFNcFRSWDNMVkFiS0FEaHl0TWhqN2pv?=
 =?utf-8?B?U3c2UndrTHpNdzRFSHJkVHNxbmNYbUgxWElwNVA1ZDk5N0lEZ0N6Tkl1TlpS?=
 =?utf-8?B?SGNjM2VxbkRPZUlxam9QeUVSeDRza282emJHR1UyS1k3Qzg4YXBwdmlTaW1j?=
 =?utf-8?B?d2JmeEdNeTZiNjY3a01uOVB2T2labGlUdG9YbjdqZjBQTFNDYy85MmNvcVlr?=
 =?utf-8?Q?vuZxL76G3a5o4XRFGjI4EpiqjsBPR0LqjlfHn9f?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85d0a93b-555c-45cd-4a49-08d968d7155b
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 21:18:43.6236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RXeruj9VyaZ5Wv2gIHvWLTeATnf/QpLAsWvOkmPS3FGBMvlCFrpXrPqbJz6WtnzASWxFH4gsJrcrU3w10FMSHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0301MB2182
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This adds PWM support for Xilinx LogiCORE IP AXI soft timers commonly
found on Xilinx FPGAs. At the moment clock control is very basic: we
just enable the clock during probe and pin the frequency. In the future,
someone could add support for disabling the clock when not in use.

This driver was written with reference to Xilinx DS764 for v1.03.a [1].

[1] https://www.xilinx.com/support/documentation/ip_documentation/axi_timer/v1_03_a/axi_timer_ds764.pdf

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

Changes in v6:
- Prevent overflow when calculating period_cycles
- Swap order of period_cycle range comparisons
- Remove enabled variable from xilinx_pwm_apply
- Capitalize error messages
- Don't disable regmap locking to allow inspection of registers via
  debugfs

Changes in v5:
- Elaborate on limitation section
- Rework duty-cycle and period calculations with feedback from Uwe
- Use more verbose error messages
- Allow non-zero #pwm-cells
- Remove xlnx,axi-timer-2.0 compatible string
- Correctly set duty_cycle in get_state when TLR0=TLR1
- Perform some additional checks/rounding in apply_state
- Switch to regmap to abstract endianness issues

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

 MAINTAINERS                  |   1 +
 drivers/clocksource/Makefile |   5 +-
 drivers/pwm/Kconfig          |  13 ++
 drivers/pwm/Makefile         |   1 +
 drivers/pwm/pwm-xilinx.c     | 267 +++++++++++++++++++++++++++++++++++
 5 files changed, 286 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pwm/pwm-xilinx.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 252d71addd18..6adafd3e7a09 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20050,6 +20050,7 @@ XILINX TIMER/PWM DRIVER
 M:	Sean Anderson <sean.anderson@seco.com>
 S:	Maintained
 F:	drivers/clocksource/timer-xilinx*
+F:	drivers/pwm/pwm-xilinx.c
 F:	include/clocksource/timer-xilinx.h
 
 XILINX UARTLITE SERIAL DRIVER
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index a7cba6ef5782..36aa2e5ac1d5 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -88,4 +88,7 @@ obj-$(CONFIG_CSKY_MP_TIMER)		+= timer-mp-csky.o
 obj-$(CONFIG_GX6605S_TIMER)		+= timer-gx6605s.o
 obj-$(CONFIG_HYPERV_TIMER)		+= hyperv_timer.o
 obj-$(CONFIG_MICROCHIP_PIT64B)		+= timer-microchip-pit64b.o
-obj-$(CONFIG_XILINX_TIMER)		+= timer-xilinx.o timer-xilinx-common.o
+obj-$(CONFIG_XILINX_TIMER)		+= timer-xilinx.o
+ifneq ($(CONFIG_XILINX_TIMER)$(CONFIG_PWM_XILINX),)
+obj-y					+= timer-xilinx-common.o
+endif
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index c76adedd58c9..974774b7c987 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -637,4 +637,17 @@ config PWM_VT8500
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-vt8500.
 
+config PWM_XILINX
+	tristate "Xilinx AXI Timer PWM support"
+	depends on COMMON_CLK
+	select REGMAP_MMIO
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
index 708840b7fba8..ea785480359b 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -60,3 +60,4 @@ obj-$(CONFIG_PWM_TWL)		+= pwm-twl.o
 obj-$(CONFIG_PWM_TWL_LED)	+= pwm-twl-led.o
 obj-$(CONFIG_PWM_VISCONTI)	+= pwm-visconti.o
 obj-$(CONFIG_PWM_VT8500)	+= pwm-vt8500.o
+obj-$(CONFIG_PWM_XILINX)	+= pwm-xilinx.o
diff --git a/drivers/pwm/pwm-xilinx.c b/drivers/pwm/pwm-xilinx.c
new file mode 100644
index 000000000000..d1857f638cd7
--- /dev/null
+++ b/drivers/pwm/pwm-xilinx.c
@@ -0,0 +1,267 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2021 Sean Anderson <sean.anderson@seco.com>
+ *
+ * Limitations:
+ * - When changing both duty cycle and period, we may end up with one cycle
+ *   with the old duty cycle and the new period. This is because the counters
+ *   may only be reloaded by first stopping them, or by letting them be
+ *   automatically reloaded at the end of a cycle. If this automatic reload
+ *   happens after we set TLR0 but before we set TLR1 then we will will have a
+ *   bad cycle. This could probably be fixed by reading TCR0 just before
+ *   reprogramming, but I think it would add complexity for little gain.
+ * - Cannot produce 100% duty cycle by configuring the TLRs. This might be
+ *   possible by stopping the counters at an appropriate point in the cycle,
+ *   but this is not (yet) implemented.
+ * - Only produces "normal" output.
+ * - Always produces low output if disabled.
+ */
+
+#include <clocksource/timer-xilinx.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/regmap.h>
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
+	struct xilinx_timer_priv *priv = xilinx_pwm_chip_to_priv(chip);
+	u32 tlr0, tlr1, tcsr0, tcsr1;
+	u64 period_cycles, duty_cycles;
+	unsigned long rate;
+
+	if (state->polarity != PWM_POLARITY_NORMAL)
+		return -EINVAL;
+
+	/*
+	 * To be representable by TLR, cycles must be between 2 and
+	 * priv->max + 2. To enforce this we can reduce the duty
+	 * cycle, but we may not increase it.
+	 */
+	rate = clk_get_rate(priv->clk);
+	/* Prevent overflow by clamping to the worst case of rate */
+	period_cycles = min_t(u64, state->period, ULONG_MAX * NSEC_PER_SEC);
+	period_cycles = mul_u64_u32_div(state->period, rate, NSEC_PER_SEC);
+	if (period_cycles < 2 || period_cycles - 2 > priv->max)
+		return -ERANGE;
+	duty_cycles = mul_u64_u32_div(state->duty_cycle, rate, NSEC_PER_SEC);
+
+	/*
+	 * If we specify 100% duty cycle, we will get 0% instead, so decrease
+	 * the duty cycle count by one.
+	 */
+	if (period_cycles == duty_cycles)
+		duty_cycles--;
+
+	/* Round down to 0% duty cycle for unrepresentable duty cycles */
+	if (duty_cycles < 2)
+		duty_cycles = period_cycles;
+
+	regmap_read(priv->map, TCSR0, &tcsr0);
+	regmap_read(priv->map, TCSR1, &tcsr1);
+	tlr0 = xilinx_timer_tlr_cycles(priv, tcsr0, period_cycles);
+	tlr1 = xilinx_timer_tlr_cycles(priv, tcsr1, duty_cycles);
+	regmap_write(priv->map, TLR0, tlr0);
+	regmap_write(priv->map, TLR1, tlr1);
+
+	if (state->enabled) {
+		/*
+		 * If the PWM is already running, then the counters will be
+		 * reloaded at the end of the current cycle.
+		 */
+		if (!xilinx_timer_pwm_enabled(tcsr0, tcsr1)) {
+			/* Load TLR into TCR */
+			regmap_write(priv->map, TCSR0, tcsr0 | TCSR_LOAD);
+			regmap_write(priv->map, TCSR1, tcsr1 | TCSR_LOAD);
+			/* Enable timers all at once with ENALL */
+			tcsr0 = (TCSR_PWM_SET & ~TCSR_ENT) | (tcsr0 & TCSR_UDT);
+			tcsr1 = TCSR_PWM_SET | TCSR_ENALL | (tcsr1 & TCSR_UDT);
+			regmap_write(priv->map, TCSR0, tcsr0);
+			regmap_write(priv->map, TCSR1, tcsr1);
+		}
+	} else {
+		regmap_write(priv->map, TCSR0, 0);
+		regmap_write(priv->map, TCSR1, 0);
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
+	u32 tlr0, tlr1, tcsr0, tcsr1;
+
+	regmap_read(priv->map, TLR0, &tlr0);
+	regmap_read(priv->map, TLR1, &tlr1);
+	regmap_read(priv->map, TCSR0, &tcsr0);
+	regmap_read(priv->map, TCSR1, &tcsr1);
+	state->period = xilinx_timer_get_period(priv, tlr0, tcsr0);
+	state->duty_cycle = xilinx_timer_get_period(priv, tlr1, tcsr1);
+	state->enabled = xilinx_timer_pwm_enabled(tcsr0, tcsr1);
+	state->polarity = PWM_POLARITY_NORMAL;
+
+	/* 100% duty cycle results in constant low output */
+	if (state->period == state->duty_cycle)
+		state->duty_cycle = 0;
+}
+
+static const struct pwm_ops xilinx_pwm_ops = {
+	.apply = xilinx_pwm_apply,
+	.get_state = xilinx_pwm_get_state,
+	.owner = THIS_MODULE,
+};
+
+static const struct regmap_config xilinx_pwm_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.val_format_endian = REGMAP_ENDIAN_LITTLE,
+	.max_register = TCR1,
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
+	void __iomem *regs;
+
+	ret = of_property_read_u32(np, "#pwm-cells", &pwm_cells);
+	if (ret == -EINVAL)
+		return -ENODEV;
+	else if (ret)
+		return dev_err_probe(dev, ret, "could not read #pwm-cells\n");
+
+	pwm = devm_kzalloc(dev, sizeof(*pwm), GFP_KERNEL);
+	if (!pwm)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, pwm);
+	priv = &pwm->priv;
+
+	regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
+
+	priv->map = devm_regmap_init_mmio(dev, regs,
+					  &xilinx_pwm_regmap_config);
+	if (IS_ERR(priv->map))
+		return dev_err_probe(dev, PTR_ERR(priv->map),
+				     "Could not create regmap\n");
+
+	ret = xilinx_timer_common_init(np, priv, &one_timer);
+	if (ret)
+		return ret;
+
+	if (one_timer)
+		return dev_err_probe(dev, -EINVAL,
+				     "Two timers required for PWM mode\n");
+
+	/*
+	 * The polarity of the generate outputs must be active high for PWM
+	 * mode to work. We could determine this from the device tree, but
+	 * alas, such properties are not allowed to be used.
+	 */
+
+	priv->clk = devm_clk_get(dev, "s_axi_aclk");
+	if (IS_ERR(priv->clk))
+		return dev_err_probe(dev, PTR_ERR(priv->clk),
+				     "Could not get clock\n");
+
+	ret = clk_prepare_enable(priv->clk);
+	if (ret)
+		return dev_err_probe(dev, ret, "Clock enable failed\n");
+	clk_rate_exclusive_get(priv->clk);
+
+	pwm->chip.dev = dev;
+	pwm->chip.ops = &xilinx_pwm_ops;
+	pwm->chip.npwm = 1;
+	ret = pwmchip_add(&pwm->chip);
+	if (ret) {
+		clk_rate_exclusive_put(priv->clk);
+		clk_disable_unprepare(priv->clk);
+		return dev_err_probe(dev, ret, "Could not register PWM chip\n");
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

