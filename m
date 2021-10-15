Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0D142FB9A
	for <lists+linux-pwm@lfdr.de>; Fri, 15 Oct 2021 21:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242349AbhJOTDF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 15 Oct 2021 15:03:05 -0400
Received: from mail-eopbgr70089.outbound.protection.outlook.com ([40.107.7.89]:3393
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242209AbhJOTDC (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 15 Oct 2021 15:03:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QGb2aNDN7Q4ukfsVM91yEEk0hYitvoDeWsnau5EMFBUzj0BY65MZsEwKu1QuNffxhZEkkfjXziBeHvj7qHI03fjNcuHr09iqZsPM6NlL0wk8P8DeA1h4T9aFi+ntDPBLQh7/8BuD31mdJKGFr6/2cKGGDBz5jQ3++T9dJzPbOmgWjM6mgUx4G7atU0LXqpnZCxhW0WOg43yxmv3GoWtnY6bAHDqgglaUdcI1+8PmuxJyGcCxt3ms5W1A/BfYw1Ot/VC7HYJp6xtYyEQtUVcZLIby34nRJmpzmWYzOzZ+UCmhzAN/UAQXqwHlXu71iZ/qRRW7KH7tG+B66ZQa3LfP7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VwnBpqVJTSTCRi65QSeNTk7Nt3yo9KI/vhHwHTkoCJk=;
 b=JuWRKH8b3R5/tQsr+16HIlcQlM4fIR+TmBTazYYruD2WFqYaurkX/1l21QDNaGhQZO50jHE5cOrpmJtVHFaAm8dUv2FehjkXCGdmTbw9KQ9C47esqID3NODCsYkZVWlhsaVLQrbUhJYmapJddAF9uDbJwjhlV1HnoECDJPxqejZmQGDX0njdz/FBvGW6qAe78OeZ4g/I/KfpM9SdujAg8086h9vltMGZpRQF3p6DB1BvrPh9cxQjSGDrcgcsx66duD7r/wWPUMob/unss+juUp3A4NSJFiqqjWYGkbXG2oKXyJ0pflXTPa1lwG8kVFjLDLbVPeK15tk5zFxilFLSKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VwnBpqVJTSTCRi65QSeNTk7Nt3yo9KI/vhHwHTkoCJk=;
 b=WTpFEl9AhdVsk4goNdvCzFpO/Ol9cbF2YV8/QV3cLRHSoz7knYJNqv5grzYPPNP+MsoTuXouf5L5nCUqgdSInz170T3ynW9wByGVrhKiVndSXCjkVc6YTvJcCkHYlmnwYYnKghs4QvcM7IbtB2+auNm/gles5+ZdIopOMWB3Df0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DBBPR03MB6905.eurprd03.prod.outlook.com (2603:10a6:10:205::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Fri, 15 Oct
 2021 19:00:52 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::a9aa:f363:66e:fadf]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::a9aa:f363:66e:fadf%6]) with mapi id 15.20.4608.017; Fri, 15 Oct 2021
 19:00:52 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, michal.simek@xilinx.com,
        linux-arm-kernel@lists.infradead.org,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        linux-kernel@vger.kernel.org,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v8 3/3] pwm: Add support for Xilinx AXI Timer
Date:   Fri, 15 Oct 2021 15:00:25 -0400
Message-Id: <20211015190025.409426-3-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211015190025.409426-1-sean.anderson@seco.com>
References: <20211015190025.409426-1-sean.anderson@seco.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0096.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::11) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
Received: from plantagenet.inhand.com (50.195.82.171) by BL1PR13CA0096.namprd13.prod.outlook.com (2603:10b6:208:2b9::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.8 via Frontend Transport; Fri, 15 Oct 2021 19:00:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ffaa7c27-6fff-42ad-61b5-08d9900e1bc8
X-MS-TrafficTypeDiagnostic: DBBPR03MB6905:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR03MB6905D59B68BC3A6E2A09DAEC96B99@DBBPR03MB6905.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VjOiqXOwdaXwZdXn7FOud5dnUhl06Hkfdf7YrtQqeIvxN5LafhJuHHaCTDAa2vmcXZdSVXFONJ3N4w1oHzrUrtjq/VuevWsP1WPDVnNfYoVASc7oSpl2ou9yWNjJG5EwKrHWgFpFkyB3MZwszCfAtZ7F58+Cfs48ALIYhS1JOn2MHL1EvSME/whFbryT4v6sh7S1OWjw5ZRJxan/3M2FevQlk7fcuhncIrnZyf0AZnHgslfIX5QG56ivBNPpGeE5QaGNUItbYUYUYhQ7NKmS8Fteoy0+58E/7eVPr5xbTDRpj/MPdYcK9fIcVO8F7TDWa0IJCdEbNlCIVpnkLAmuDTz0HaqskGThSjuS19QJNkB80bxqQD+iNIO9ds0tVWHo3fibrm8DAzZLmAnDKqyrSnz1IcGhbSNj1iIPEFIfzW1fGceN3zR6j0QXsl5pqcDQV2MvZJ0+Jim+ws7Cek0nhCtTIhu3tPb3keqqNFlH/sX/G+u38jSYFeY73RNv00poAbcqiSpHiI4e/veXTM+jY3shPnz5nOVKoDFWf8wgNybBtuf+fhaHD7m2DSC1MUS8wCvXWPTbP4BMYNh0I+sxdc0luNnNQHVquJJKue7V6fnCuZ09zLLVgjuUqgq/7D4Nj6ZXUBRA3kDsmNJ+abCRRg8v6CM9f1GCNh06Ojv6Ta+E45v0k9X6IGQscKFR6jHRqyBIcBkmyRC5CYvTuHF8YQmw/XtCCG0YtpoDhR3DJTKI7VyrZZyHGPZORdkT1yPvNPxpK5PLCWu0cPlxWomnbaerIjRxpSHlZCOfOhUcL2E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(956004)(6916009)(6506007)(54906003)(508600001)(966005)(1076003)(107886003)(6666004)(316002)(26005)(44832011)(4326008)(2616005)(66946007)(83380400001)(86362001)(8936002)(52116002)(6512007)(186003)(30864003)(8676002)(66476007)(66556008)(2906002)(38100700002)(38350700002)(6486002)(5660300002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTduY2xXdFpUdkg5c2xSdnVLN1hEeWF4VTNha1hoZUFOaTcwaE5acHlvb3lI?=
 =?utf-8?B?K2gzM2lzYnhXbzZkRjEvMHQ3RkdKU2lsbU9XcG9BWkppR1pTcDVlV281YUM5?=
 =?utf-8?B?MFlCVUFtMmRGL1RsMnlwYmo5SHZLVGloYWd5dlgzUi9sSnFjRU1WR2tWTlNC?=
 =?utf-8?B?QUJBSzI2T005dERXYUd5M2o5MjZwUW9ZRUQxTG5CTFNEcmZkYUVsWWIwZTdu?=
 =?utf-8?B?TWl6aHJjSUthQzAwams2YW9oWENEcWpFSHJpOVJrdVByOXVIdGxSSlNrUnRQ?=
 =?utf-8?B?WUlQTThMSFlhUHkreVQ3K2t6WVhiZHJnVjBtRWZLUVk3NmJ0R2dSSFBjNjRm?=
 =?utf-8?B?d2V6ZDRlZTdRL1VmV251eUdINjl0d2lSR2JqK1RwaElVVnVCSUl5eEpDd2xI?=
 =?utf-8?B?WmdyZ25IUkpNbUdjaVQyY2dUNG40QzJKZHZYcU9kdUl3eXBMYkZFakFWcjdG?=
 =?utf-8?B?SGNLSXZ1U3lPL2xDcHhUaThUUkxXdVZ2ZVRXcXd0R3BXMFd6SmxtSHhwUEt2?=
 =?utf-8?B?b3gwY21Xalg4ZUtqTUdoZUlxdlFkSUdUa3Y0TFErQk5zVWN0UDJLZFFweTdH?=
 =?utf-8?B?YkxtcSszbU5HaEJFU1NvejFSbkF0WUtGYTF0c2tYUUFJZ3lIYm1ocWkyZlY2?=
 =?utf-8?B?UnVXOGFuckdyVTl0c1hFSGJVcXdpV3M1eWdRTnpEbjU1VUtDQTBOaGhVNkdX?=
 =?utf-8?B?UFo5cjROcDZ3T1Z1NUNUeHIxV29BbmNKWDRYb2RJOXFaZ0R5aGh3VlJwdkdp?=
 =?utf-8?B?RkZXRUd5SzFkZ3Z5U0pMbjRiK1JkWlA5aWpKTWxLK3hGcUFpeGVyRG9QeG1Y?=
 =?utf-8?B?eHBwWmRlUnB6UWV0U296d2JpZXdhYkpPVFh2Y3lVeXBZdE1lSUdMdVIvcXFX?=
 =?utf-8?B?bDh4bVFBQmtmUzFEaGxsYUttN3BYNG85OVNqRkRBdElWVzVDVlF5SUxYUmF6?=
 =?utf-8?B?Y09IbHhFcXdMd0d3dFZNVzJUWFhCY0dZZk1tZjFXeGZaSEFFUDlNWm5yN3Vi?=
 =?utf-8?B?aHpYTGN1ODRjSVE2b3JmRHVEQlVsbENOQ1pwaUI1dlY2VkF5OFFLYXY5SEdL?=
 =?utf-8?B?SVNCdjMzclFuT3E3Q0MzT2xtZEhXVWNoS2k4YktFblZ1NzRxZ24raGxMWDBL?=
 =?utf-8?B?UFRTRjZ4VUZ6NUF4NVpDeGY0VUlKYXlIMEpUQUhrdU0zaXhnTmtuUEQxNUpv?=
 =?utf-8?B?TERjdXFtSWljUllQd2JRbFRVWTYyYTNTaHFUVW5CRDlwZklLSTJxOXpQQU9i?=
 =?utf-8?B?ZURoREx0L21WbC9Wczd3Y3V4RXNkbWdJaDF5ZXpQTG9pbnFYMElpUjVod2l6?=
 =?utf-8?B?dVEyYm9LTjVESHE1WUJNNkdMNUxCRThKTGw5dCtNSXZRaHZkQ202cXBVajZF?=
 =?utf-8?B?RDcwZkcvb1g5QVg2cTcvTnBXdHBFVmdHUG5SUHJGeGNjTU45YjZYU3NzNHdT?=
 =?utf-8?B?NWx0RDk4MG1UaE00ZGdzTUhVdjhiV2w3MWdTaEhXNEtDQnRMbjdNc0wxZk1R?=
 =?utf-8?B?SHZHbTFsMVVib2VJSFpRTlNDU3MxZHNlUG1PSzNFeWFPTis5Y2cycThCNzln?=
 =?utf-8?B?cnRiTkdzaE1GMjlnVTQ1SGRwbGg3bUdIZXFlOTJUOG9iZFZMUXYvL0l4ZlRW?=
 =?utf-8?B?ZGhVODhQLzc1eUozT0h6NHVVU1lJVzZFeW9raUV3M1RNSXhaZWZKT1ZoTkp3?=
 =?utf-8?B?MXJoWkFKSUZVWm41SUlnQnA5MnJkcDlta0lWQ1FDVWwxck80eHREY0h5K0p5?=
 =?utf-8?Q?cHUsAADQGJYVMsVBy4h1GcxJzV/F852a9U/LY6r?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffaa7c27-6fff-42ad-61b5-08d9900e1bc8
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 19:00:52.1343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0tDUdC3T0eXQiif1BLGPcAL6GSryLSqqIFjfahPT2LFbvxERXpXgNJGf7cwCxAneNP1ubhvmtD39R+U2eB2e4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB6905
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This adds PWM support for Xilinx LogiCORE IP AXI soft timers commonly
found on Xilinx FPGAs. At the moment clock control is very basic: we
just enable the clock during probe and pin the frequency. In the future,
someone could add support for disabling the clock when not in use.

Some common code has been specially demarcated. While currently only
used by the PWM driver, it is anticipated that it may be split off in
the future to be used by the timer driver as well.

This driver was written with reference to Xilinx DS764 for v1.03.a [1].

[1] https://www.xilinx.com/support/documentation/ip_documentation/axi_timer/v1_03_a/axi_timer_ds764.pdf

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

Changes in v8:
- Drop new timer driver; it has been deferred for future series

Changes in v7:
- Add dependency on OF_ADDRESS
- Fix period_cycles calculation
- Fix typo in limitations

Changes in v6:
- Capitalize error messages
- Don't disable regmap locking to allow inspection of registers via
  debugfs
- Prevent overflow when calculating period_cycles
- Remove enabled variable from xilinx_pwm_apply
- Swap order of period_cycle range comparisons

Changes in v5:
- Allow non-zero #pwm-cells
- Correctly set duty_cycle in get_state when TLR0=TLR1
- Elaborate on limitation section
- Perform some additional checks/rounding in apply_state
- Remove xlnx,axi-timer-2.0 compatible string
- Rework duty-cycle and period calculations with feedback from Uwe
- Switch to regmap to abstract endianness issues
- Use more verbose error messages

Changes in v4:
- Don't use volatile in read/write replacements. Some arches have it and
  some don't.
- Put common timer properties into their own struct to better reuse
  code.
- Remove references to properties which are not good enough for Linux.

Changes in v3:
- Add clockevent and clocksource support
- Remove old microblaze driver
- Rewrite probe to only use a device_node, since timers may need to be
  initialized before we have proper devices. This does bloat the code a bit
  since we can no longer rely on helpers such as dev_err_probe. We also
  cannot rely on device resources being free'd on failure, so we must free
  them manually.
- We now access registers through xilinx_timer_(read|write). This allows us
  to deal with endianness issues, as originally seen in the microblaze
  driver. CAVEAT EMPTOR: I have not tested this on big-endian!

Changes in v2:
- Add comment describing device
- Add comment explaining why we depend on !MICROBLAZE
- Add dependencies on COMMON_CLK and HAS_IOMEM
- Cast dividends to u64 to avoid overflow
- Check for over- and underflow when calculating TLR
- Check range of xlnx,count-width
- Don't compile this module by default for arm64
- Don't set pwmchip.base to -1
- Ensure the clock is always running when the pwm is registered
- Remove debugfs file :l
- Rename TCSR_(SET|CLEAR) to TCSR_RUN_(SET|CLEAR)
- Report errors with dev_error_probe
- Set xilinx_pwm_ops.owner
- Use NSEC_TO_SEC instead of defining our own
- Use TCSR_RUN_MASK to check if the PWM is enabled, as suggested by Uwe

 MAINTAINERS                        |   7 +
 arch/microblaze/kernel/timer.c     |   3 +
 drivers/pwm/Kconfig                |  14 ++
 drivers/pwm/Makefile               |   1 +
 drivers/pwm/pwm-xilinx.c           | 329 +++++++++++++++++++++++++++++
 include/clocksource/timer-xilinx.h |  91 ++++++++
 6 files changed, 445 insertions(+)
 create mode 100644 drivers/pwm/pwm-xilinx.c
 create mode 100644 include/clocksource/timer-xilinx.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 6b6f98483deb..bed034ef46ad 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20601,6 +20601,13 @@ F:	drivers/misc/Makefile
 F:	drivers/misc/xilinx_sdfec.c
 F:	include/uapi/misc/xilinx_sdfec.h
 
+XILINX PWM DRIVER
+M:	Sean Anderson <sean.anderson@seco.com>
+S:	Maintained
+F:	drivers/clocksource/timer-xilinx-common.c
+F:	drivers/pwm/pwm-xilinx.c
+F:	include/clocksource/timer-xilinx.h
+
 XILINX UARTLITE SERIAL DRIVER
 M:	Peter Korsgaard <jacmet@sunsite.dk>
 L:	linux-serial@vger.kernel.org
diff --git a/arch/microblaze/kernel/timer.c b/arch/microblaze/kernel/timer.c
index f8832cf49384..20e2669b533d 100644
--- a/arch/microblaze/kernel/timer.c
+++ b/arch/microblaze/kernel/timer.c
@@ -251,6 +251,9 @@ static int __init xilinx_timer_init(struct device_node *timer)
 	u32 timer_num = 1;
 	int ret;
 
+	if (of_property_read_bool(np, "#pwm-cells"))
+		return 0;
+
 	if (initialized)
 		return -EINVAL;
 
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index aa29841bbb79..47f25237754f 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -638,4 +638,18 @@ config PWM_VT8500
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-vt8500.
 
+config PWM_XILINX
+	tristate "Xilinx AXI Timer PWM support"
+	depends on OF_ADDRESS
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
index 000000000000..c532be6c7912
--- /dev/null
+++ b/drivers/pwm/pwm-xilinx.c
@@ -0,0 +1,329 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2021 Sean Anderson <sean.anderson@seco.com>
+ *
+ * Limitations:
+ * - When changing both duty cycle and period, we may end up with one cycle
+ *   with the old duty cycle and the new period. This is because the counters
+ *   may only be reloaded by first stopping them, or by letting them be
+ *   automatically reloaded at the end of a cycle. If this automatic reload
+ *   happens after we set TLR0 but before we set TLR1 then we will have a
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
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/regmap.h>
+
+/*
+ * The following functions are "common" to drivers for this device, and may be
+ * exported at a future date.
+ */
+u32 xilinx_timer_tlr_cycles(struct xilinx_timer_priv *priv, u32 tcsr,
+			    u64 cycles)
+{
+	WARN_ON(cycles < 2 || cycles - 2 > priv->max);
+
+	if (tcsr & TCSR_UDT)
+		return cycles - 2;
+	else
+		return priv->max - cycles + 2;
+}
+
+unsigned int xilinx_timer_get_period(struct xilinx_timer_priv *priv,
+				     u32 tlr, u32 tcsr)
+{
+	u64 cycles;
+
+	if (tcsr & TCSR_UDT)
+		cycles = tlr + 2;
+	else
+		cycles = (u64)priv->max - tlr + 2;
+
+	/* cycles has a max of 2^32 + 2 */
+	return DIV64_U64_ROUND_CLOSEST(cycles * NSEC_PER_SEC,
+				       clk_get_rate(priv->clk));
+}
+
+int xilinx_timer_common_init(struct device_node *np,
+			     struct xilinx_timer_priv *priv,
+			     u32 *one_timer)
+{
+	int ret;
+	u32 width;
+
+	ret = of_property_read_u32(np, "xlnx,one-timer-only", one_timer);
+	if (ret) {
+		pr_err("%pOF: err %d: xlnx,one-timer-only\n", np, ret);
+		return ret;
+	} else if (*one_timer && *one_timer != 1) {
+		pr_err("%pOF: xlnx,one-timer-only must be 0 or 1\n", np);
+		return -EINVAL;
+	}
+
+	ret = of_property_read_u32(np, "xlnx,count-width", &width);
+	if (ret == -EINVAL) {
+		width = 32;
+	} else if (ret) {
+		pr_err("%pOF: err %d: xlnx,count-width\n", np, ret);
+		return ret;
+	} else if (width < 8 || width > 32) {
+		pr_err("%pOF: invalid counter width\n", np);
+		return -EINVAL;
+	}
+	priv->max = BIT_ULL(width) - 1;
+
+	return 0;
+}
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
+	period_cycles = mul_u64_u32_div(period_cycles, rate, NSEC_PER_SEC);
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
diff --git a/include/clocksource/timer-xilinx.h b/include/clocksource/timer-xilinx.h
new file mode 100644
index 000000000000..1f7757b84a5e
--- /dev/null
+++ b/include/clocksource/timer-xilinx.h
@@ -0,0 +1,91 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2021 Sean Anderson <sean.anderson@seco.com>
+ */
+
+#ifndef XILINX_TIMER_H
+#define XILINX_TIMER_H
+
+#include <linux/compiler.h>
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
+struct clk;
+struct device_node;
+struct regmap;
+
+/**
+ * struct xilinx_timer_priv - Private data for Xilinx AXI timer drivers
+ * @map: Regmap of the device, possibly with an offset
+ * @clk: Parent clock
+ * @max: Maximum value of the counters
+ */
+struct xilinx_timer_priv {
+	struct regmap *map;
+	struct clk *clk;
+	u32 max;
+};
+
+/**
+ * xilinx_timer_tlr_cycles() - Calculate the TLR for a period specified
+ *                             in clock cycles
+ * @priv: The timer's private data
+ * @tcsr: The value of the TCSR register for this counter
+ * @cycles: The number of cycles in this period
+ *
+ * Callers of this function MUST ensure that @cycles is representable as
+ * a TLR.
+ *
+ * Return: The calculated value for TLR
+ */
+u32 xilinx_timer_tlr_cycles(struct xilinx_timer_priv *priv, u32 tcsr,
+			    u64 cycles);
+
+/**
+ * xilinx_timer_get_period() - Get the current period of a counter
+ * @priv: The timer's private data
+ * @tlr: The value of TLR for this counter
+ * @tcsr: The value of TCSR for this counter
+ *
+ * Return: The period, in ns
+ */
+unsigned int xilinx_timer_get_period(struct xilinx_timer_priv *priv,
+				     u32 tlr, u32 tcsr);
+
+/**
+ * xilinx_timer_common_init() - Perform common initialization for Xilinx
+ *                              AXI timer drivers.
+ * @priv: The timer's private data
+ * @np: The devicetree node for the timer
+ * @one_timer: Set to %1 if there is only one timer
+ *
+ * This performs common initialization, such as detecting endianness,
+ * and parsing devicetree properties. @priv->regs must be initialized
+ * before calling this function. This function initializes @priv->read,
+ * @priv->write, and @priv->width.
+ *
+ * Return: 0, or negative errno
+ */
+int xilinx_timer_common_init(struct device_node *np,
+			     struct xilinx_timer_priv *priv,
+			     u32 *one_timer);
+
+#endif /* XILINX_TIMER_H */
-- 
2.25.1

