Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADA640E992
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Sep 2021 20:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344022AbhIPSKR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 16 Sep 2021 14:10:17 -0400
Received: from mail-vi1eur05on2068.outbound.protection.outlook.com ([40.107.21.68]:9952
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1343604AbhIPSIP (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 16 Sep 2021 14:08:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LTQi5MJrsi4qWagNjnpT3iT1CpGROALaGME4hUg2uU+Sdq33wuu+5o4YD6HDBPf5HrR6W5Kp/At2PHK0XNNWq20ieqN92t5l0BfVCKjBkEBTT3bUxcoAyshfyL1LR+DOR/HJzIapMVZwrKWA3lL1VbMPqHTFRbrfilRGjPBO7FXhT1PlFW7rdzIaHfGASY4VUtD7DtUnnoJj7KLOIkoqk3ImFuSU8DtewGIsHNoG6Jq32Hxw4yLtgk0QBYkmNMTfseX6ZvSLkycg8hhNRmPjyof/TUunAEV0ee36uzj2QfM47ASGc2xMSNX1SPJtQoHr4Bg0L5bGl/vp1zIbdRhywA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=SN5V3K6UUBS34CAOA4iLVJMfX/m5K2UJMPAvInozQRo=;
 b=jLowj2Yk04l5hoH/XOrv6xcVqkx/Yz0+cCZI2r3Swt4NhuGuZ+6d7sZACFKDvzcgdDY/NMmKlcNYRM05uVPp8eo64qWsAjbDj7QAOtPWYiaopQ6/yiW3WB2X7gmvz4lZGqHd7PJ/D4/giC/Y/xBBpMddV77H+fL6jI3BoZSzPj+Eyr2Ya75LBBmPz1JpE+64cZgZrakvqSS+ETaYuOUdAqfb0opi0tQyf3v34yaCCiqzvVwHW+MvSDv/e380xA3LGT3S+kbKr4cC4ZOP2ZfEWF83HPKO1wuMwL05ob/i+fDyJSQUSx10dLHF6iZa+j5q3vJm6Y3P5K5hWz6I5oT6dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SN5V3K6UUBS34CAOA4iLVJMfX/m5K2UJMPAvInozQRo=;
 b=YyE5h3ga5ViuBWfidZqr7LO7wfhbOHZBwzXlFZ2GpTfQUh3ZMEbRkYpCAhOm7d267YOit4MVfgDnXsyIpCHTSS9QjgfxJWfqn3qiEYrw1x1RwsAp2S3QKxaOjFdwHyGG1QE++v2Sw3xRV5czJV5SRlLLE8/cQzTs0ZpXRnu/W88=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DBAPR03MB6470.eurprd03.prod.outlook.com (2603:10a6:10:19f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Thu, 16 Sep
 2021 18:06:08 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::a9aa:f363:66e:fadf]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::a9aa:f363:66e:fadf%6]) with mapi id 15.20.4523.016; Thu, 16 Sep 2021
 18:06:08 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, michal.simek@xilinx.com,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v7 3/3] pwm: Add support for Xilinx AXI Timer
Date:   Thu, 16 Sep 2021 14:05:43 -0400
Message-Id: <20210916180544.2873770-3-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210916180544.2873770-1-sean.anderson@seco.com>
References: <20210916180544.2873770-1-sean.anderson@seco.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR19CA0051.namprd19.prod.outlook.com
 (2603:10b6:208:19b::28) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from plantagenet.inhand.com (50.195.82.171) by MN2PR19CA0051.namprd19.prod.outlook.com (2603:10b6:208:19b::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 18:06:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 572d49c3-7005-4498-eaba-08d9793ca87a
X-MS-TrafficTypeDiagnostic: DBAPR03MB6470:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBAPR03MB647008C7BE9F677076A01A2596DC9@DBAPR03MB6470.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EuC8srRplrODyUg8SThX+mVg+CGDo/YtK3mREGV3pQT112eDqTakCihPkhyXKrLK6BfzGMN3mstv7WCyjCmCfdh7/JfpEU96mbuZ9SFJYtY4oZIPA2ddmlocpU3BoQzSo20uOLfVoHc2SvuRHijOUqcgiIs1zUtzQ6cB76+AVTXYg4D03HVW+3JvhznAn55gFJl2+AfxzmdkYZWEgcio2866LD3OtXd/SmrlZ8HSGVyojsECsuv1kqQSkH7bGO/WgzH67VE/XOkdhKLeJQJkYnYqKAU9NW4m0wzgTLm7S0AXP04ad1r7IgepCwLXuBo+yypLeIfqkmVZaeb2eXyUWYo4PnDKGyWjYNAAFlb3Wpt7kl/yXPudWbdqD1W3WBw6TUHhXpZ4jMH9Bi86u9z8fyi98dzi80YBs7xxCov2sWy6V59CT6cFFVV03HshyPqr5bSkFkjAQuisOQZ3gzkb2Ex3eTMc2OOJqNIqfW61URAB3DEVunJw3sv3kVCEAOsLI+Wv5Jsqt4isrWcKm6lIMUba1ISmKXaM0x1wWB10uh/ZLdBRnJ2/hoi52jA314B4Pmb+iq6VJ8Y9PaUOHmIUbETFvy8yCwwEXjwcXo+byGz3i+C4gINov/zguHuR9tz765C79XwrX70qk30o6L322u8XuF5LGHJUnXyHA5ubhCMCLnytWCOLJn8L/OWyIl4Z6+cdoE6vrlojHZ6pPlAdRyBOOL8Y1tiOsg9Vz3kdoEwgwYjUd6EBYq4EoGtjrWu+stuuF2F3Sh0tSWo4scV7maG427nKupMs8f9zub+FJ4Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39850400004)(366004)(346002)(396003)(376002)(966005)(6506007)(36756003)(107886003)(6666004)(54906003)(6916009)(316002)(38350700002)(26005)(4326008)(66946007)(30864003)(8936002)(5660300002)(2616005)(956004)(478600001)(52116002)(83380400001)(66556008)(66476007)(44832011)(1076003)(6486002)(6512007)(86362001)(2906002)(186003)(8676002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGVBOHRFQTNMOUdqTkgwSDVYU0tDV0hYZXNYcWNHVzVqUkI3ZzVrOHZyL3Zl?=
 =?utf-8?B?dUp1MERibHVCMWpLbFFWSmlDZXhRbXBCM1IwT2VRT3huZ2QwWHpFYklBam4w?=
 =?utf-8?B?UGtjK1ZmZWlDK3lWTVJuK3JVRHhlQm1rTXBZTjIxSGo5bDFUUnpteEpHK2NE?=
 =?utf-8?B?Q3hEN1V1akpCdXYxNDdPNUU2bjRyVUtmcnNQUklkZGdHeUtkK2Q2cVRWMTV4?=
 =?utf-8?B?QVVpMk5KN1VUaUgwTzNoaGdnZndzcXgxQ3FFV0xKMHNUYUNsWjByOHFlZHFS?=
 =?utf-8?B?d2J2NWxtRVRVZVRiVlpxcUFkdmdTV090dVhDZzdZQjdYa2NLUkg2d043TndO?=
 =?utf-8?B?MGNKQlorTlZRdm53aFBvUlB1V3pPVVJNenF3MHNHcWdKNE1vNlVSRVR0Y3Va?=
 =?utf-8?B?NDFTbEhjRlJzU09yKzRISCswTitueFlTN1VsS0Q5V0s4NkpUYXVIU1FHdktU?=
 =?utf-8?B?R282NTB5VHlrZWZENmE0a0lZanQ3U0dHY0RDRlFaN045bVZLWXpEVlRKM2Vh?=
 =?utf-8?B?Vk5ieXhVd1VpTjk3d2lVdVdrNmF6bXg2TDNnVUJTQW5ETzFqUGU2Y2NQR1Z1?=
 =?utf-8?B?eFFId2NHQUlnU1ZsRlpOTWRmMTU3UThkaHB0MlMyWlJEaGNoNVNJUFdzQU8y?=
 =?utf-8?B?WTJYcDV6azVzelBLWDRidVJqMXlmZS8zM1ZEcVlKdEJ4K2xiOExYMTBPcldq?=
 =?utf-8?B?MnFGZG53WTZvcGtWUnptYTZPL290cE5HbEJ1djJqVUI4ajBTU1ZIKzdaeDJ0?=
 =?utf-8?B?KzVVZnMzd2p2dy9mYjhlcG1wTEVsMTF3MzFiVkVPclFnMlNDc1p6OHRLMjN5?=
 =?utf-8?B?UWZZUUVuUFM0bFFYVENGU0xsLytjQ1JLajhBUUN1NEF4cENwOFQxQ2tkRmdy?=
 =?utf-8?B?UXlMeDVES2FRUExSaG9KSUc4cGhBanRBTFZtZ0pWWnFkMmJxZkoyRDcrZXdX?=
 =?utf-8?B?V3JvTDJSekdSQ25ZZ1JabFR5Rk1vaWRBWjRrYkRkWE9RckhveWl5ZVV4YVZO?=
 =?utf-8?B?RDM3TDI4eDEwZ3ZadzVUeGNsbEhsQ2h2N2J4L05EQmgxWXFtL1dTZ01IRGpr?=
 =?utf-8?B?dTZSdk5ocnhEUXlZeW5Fa3ZkNFJIVklTVUpWQ205cmQvUUtUY0tJYnN4bThX?=
 =?utf-8?B?bjdBMmJTdWNPdU1pVFlKUXNoWVZnRE84Z0lNVnpVaWI4M1ZxMmV2Q1lwQXFv?=
 =?utf-8?B?aUpERWxhN1RWa2JNbVY3U0Era2kwY0Z0am9JV3hnbUphVkVRY2JpY3pHR2NT?=
 =?utf-8?B?aXdvVmd6bWRTeWRoaTJMMnUraUFQNFpBbTN2M1BZQlRFUnV0TmZ4MVZ0OGF5?=
 =?utf-8?B?Yk0wLzhsODhaMERtSUYxcy9LNllkdFVINGtnOHBtZW53VHdRTmVWRHNFT0dN?=
 =?utf-8?B?Y3B0eFk0Q2pNZGlWVjlHT0RjMVN1SC8rS3h4NDlvZkFGS3NaV0RkUWhXR2E0?=
 =?utf-8?B?YmVZN1NBSTNHVEZIZi95U1FCSHlJaWdLL0R1WWVRZHNQWE1pdnJrUWVFTG9W?=
 =?utf-8?B?Y2V2VG0wTWdnSW03c2x1NDlxekdjZVN2ZnpWaTdXdE1jNHg0Q2xqSWVPVGVq?=
 =?utf-8?B?bDQ2dXMvbjRQQ1ZSUUo5cG9WT0tBZVJoNEtzZWc1K1lOZWJaNjdRVjgrbVZw?=
 =?utf-8?B?aitOMGtpLytpcllnQUtiWlljRDNkalUrTGpsQjczQXlsTW8rb1dER3d5T1lp?=
 =?utf-8?B?SHNsWGlMQWdDZjVLcURpVkNlOWdKTkV5aXhEbFNRd21hSlBrS01sblBXZ09p?=
 =?utf-8?Q?rzTn4RRzGM1p/c1itogEYV0ZjU1fSVcKUtIfAme?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 572d49c3-7005-4498-eaba-08d9793ca87a
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 18:06:08.3101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uP6eq80IHnzoCAFvrZC6l5HErM7LXmekk3UF+d8CBgQPiAVvxEc7qOmd3T/KrxxpAsuXXY9Y9AuD93qJLxJj4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR03MB6470
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

 MAINTAINERS                  |   1 +
 drivers/clocksource/Makefile |   5 +-
 drivers/pwm/Kconfig          |  14 ++
 drivers/pwm/Makefile         |   1 +
 drivers/pwm/pwm-xilinx.c     | 267 +++++++++++++++++++++++++++++++++++
 5 files changed, 287 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pwm/pwm-xilinx.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 683cfc03b71d..328664194e62 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20606,6 +20606,7 @@ XILINX TIMER/PWM DRIVER
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
index 000000000000..972cb65c9fe9
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
-- 
2.25.1

