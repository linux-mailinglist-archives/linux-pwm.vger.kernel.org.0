Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E84F394872
	for <lists+linux-pwm@lfdr.de>; Fri, 28 May 2021 23:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbhE1VrP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 28 May 2021 17:47:15 -0400
Received: from mail-am6eur05on2052.outbound.protection.outlook.com ([40.107.22.52]:53252
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229500AbhE1VrO (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 28 May 2021 17:47:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cWzx8H7gr0Yc7d1T6X0D0Bn0A1h0KqMUvUr6mV7ypzknXJaTHwis2xAPJYyZR7NfzNpfThHdwbcxWr7vpaLqnDvEDY5aSQrhPbrX3p15y7DNiYcVJv0QCK7vbEEqAqSeAgdbTY++DTJwMKuo5fERLi5M6IsAItBDlHTlKnIJOVKG5QlLl2loxDrg3pxU0ZAujeTCkTrfFGpw9U7IgadFI+PQ8zZ7LxSp+kys0z6Pv/7Iu5ja5H8wG+8GWzHlgAX3K4iQhRpHuRA+uX+4HhRR8xnlC2b4PyNsivnC0RLTeM4x+IcifoXQOXkSr+QQdTJWRXflLprehq2bPi4JyhSXnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jW/A4QvojTihrRP+m1Y9A/zR8B0zMy7ed8kJVVi5Xyo=;
 b=FhdUp4ZrdLiEqEKrU12xNalqD3a5WiORZ8Ib0fWs6RnDp8bSXFeShaEMxEzviPzzPudorziSEucErNHOvMJOAwScs4b+fUhYDH6jY/sKvGFIzOJmowSSRFB3x9DODZoBFYUlAgt8VzzfNQ7uzNHWZhUcCLE1GR1Pr+YQ/q6N1KkSgqK7O3id8XmxnJqxCHgJCGHiuI6DY/KMYOipOHqZvXSPnM5tTQeS1Nae+1QmacaX89dOBcxcULlQHhRk6qH8/AEsHImJOyxSBVG7KRiR9I3U3553OoO64xW0gcIgAkyAMmV6H78PE+3XRH//hEoiPM7rNMEv/KnjPaGrhmNMaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jW/A4QvojTihrRP+m1Y9A/zR8B0zMy7ed8kJVVi5Xyo=;
 b=OEacy3vfKzbhLe+13ES770qyFLvHp8h4WDiwmlbthin4LnnP03ldNk+ax78fbTnEwc2IlqU1qmxcospX0yMdZRc/BnLs4SivMwqJPlrt4omMSmTZ1kIMqsJQPUnw8EMPpQLjNPknX22/wu1f+FkJvrY8tQECpvkwU0uWWZmUEhU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DBBPR03MB6700.eurprd03.prod.outlook.com (2603:10a6:10:20c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Fri, 28 May
 2021 21:45:36 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b%5]) with mapi id 15.20.4173.024; Fri, 28 May 2021
 21:45:36 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     michal.simek@xilinx.com, linux-kernel@vger.kernel.org,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        linux-arm-kernel@lists.infradead.org,
        Sean Anderson <sean.anderson@seco.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v4 2/3] clocksource: Rewrite Xilinx AXI timer driver
Date:   Fri, 28 May 2021 17:45:21 -0400
Message-Id: <20210528214522.617435-2-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210528214522.617435-1-sean.anderson@seco.com>
References: <20210528214522.617435-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [50.195.82.171]
X-ClientProxiedBy: BLAPR03CA0126.namprd03.prod.outlook.com
 (2603:10b6:208:32e::11) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from plantagenet.inhand.com (50.195.82.171) by BLAPR03CA0126.namprd03.prod.outlook.com (2603:10b6:208:32e::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22 via Frontend Transport; Fri, 28 May 2021 21:45:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24e6c17c-3045-4446-8d20-08d92221eda5
X-MS-TrafficTypeDiagnostic: DBBPR03MB6700:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR03MB6700A653A3046C41235DC75896229@DBBPR03MB6700.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:318;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: joXGWxFkrqsIsXoO+UlN6v6qVB3uz9d7lFihm4iy1fTg0j+qt+Km4FzzP70iwUq4r7ke2Zobx+fllXqqtvWS5mQ2njiOJOUkWWcmXFoKzjUj/dtWwffjUMn40uNgSlqObfhdOU0uOqIvmz6f2N4eB7CLeQVMtyQkEHOptGDh4cT+n7+pLWo/DC4J2U2UGXzkpmfTlSqru/9Js5OLeOo6F1iqo7yct8/609Aj0pJ3+nvdZXz7M6g3rYyNy3sJNesYSBePvOMfi+P+AiAvqkWTKz1XMnVXZm0UKYihYGWRy8wEXGps8rNKJdLTh8XbGbq/Hl9WV8EwAngWh8/2mA5MXCQg7yHabaOfiXDM2NRQXx/Mn3EiBa0smqPcoyySjab9y2gHs9MSP1JnnKpjdBkqf6Bml8ZuGMS9mZAV8Tyu42Uv2kKjUNA+X2LT0zhwRX+un6rJGyn0GvDyDxkhdIHoDq/Rq7ZoEV3eEFV/+8o40ek1EjSxyqwIJqS1gY8GlfJ9XoSieKZGAg0zlTuMfSZTGe9cJUxCTWAiku8Tay+9Ym+GWlM/UomUTAtoTNtOSPZeSwhFaDygYI1EPB0UIWH5PYkUgjCB5Qbv/N85voQ7F1+oZeiEzKw8RgwLzVVAF+kLJ93xFe0Igmczh7vAChMxcADpccf8LpJQZUmGXSIbq0KI/fItlbVLs4aZ6NvP8lAXSUdqgBi2lopHP6k35zpDYwX0EAmnCTAxk5DTWrEoiBx7RgmwNIf8kYyyxe6lbxiPxK5vqqtoNtBCvfRk5OvQ8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(136003)(39840400004)(346002)(366004)(478600001)(8676002)(6666004)(956004)(83380400001)(26005)(86362001)(966005)(16526019)(2906002)(8936002)(316002)(38100700002)(6506007)(54906003)(186003)(30864003)(52116002)(36756003)(6486002)(44832011)(5660300002)(4326008)(6512007)(1076003)(66556008)(66476007)(38350700002)(66946007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?9V3vTwTKbpJKsCSe6UV/RDBh2SXnFpcivXLlR429nS9o0QAmUdE5lRnbdeya?=
 =?us-ascii?Q?U1NgWKeS04ghKfa6Qdq1kapdIszMVuaL2jGXJE5xfcarzGqfA6Yh5wluYp9P?=
 =?us-ascii?Q?E/AdgjLNs+2D17Dxo1orsF/9WevpMIE5z89rYSB+pmoSdzHNOv5u69FvBc/B?=
 =?us-ascii?Q?1bHCnOvcxR40rmB/uZdXHUZSG5fPXQ4XsAYpEPGt9lOCocex+uJ444KIwha1?=
 =?us-ascii?Q?jfjVeGLwoJuGJdR32GNPhlbQlchLpPruIiJkI8kFxQEuPxun43wZVTTrA4ga?=
 =?us-ascii?Q?EAd2eNyuUZq3/wI3LWzw7isqpSqYh4DvlgI76yynLfmQQZ6twydwZ4Gyl7vY?=
 =?us-ascii?Q?Y5NIdmyekOyl5Ctv7A13518E5v96EMmvD0Yj/V+WN94QL22IPAsgLj4KXXsL?=
 =?us-ascii?Q?qFFpEIRloH3bfNT3RhgAOuFGw3EtmHOavYtO+RgBIygK/5Ou5forn21JfiMj?=
 =?us-ascii?Q?HOTov2oZn+mY5kKX1yXHTJ3An0dgyHz+wQrc95WL8+Yb6R3egd7YbhK4DIdY?=
 =?us-ascii?Q?qDIxjAXak/lYRNXLYqqYStryAtmvAjH7sbXxv2dSwW5e7Y8q3veoRqni7Xfy?=
 =?us-ascii?Q?T7jkuYhsL2IFr7UanqYqCqsgFjIGRoZI7Bt/pNREy3+QwM6wXUOmVRJ7tRAM?=
 =?us-ascii?Q?sRps6Nvsu/gHOvCthf+UsNC0oQ9wEOljcVSMk52ROQAfgpTvjpWkcp8JM0Sc?=
 =?us-ascii?Q?vlJ2Mt50hbBEYgSRUWHg8cRLLErIW0OBHn3u3+3fGAAwSW7Cw6R7Nkm89BFK?=
 =?us-ascii?Q?w1NkjsD22PK+lyj4Oo7asqW9wXmqjIksrSqxMd3/KQbdnWInmscYWKYY7HaG?=
 =?us-ascii?Q?bVcHbjvmGgMNawcnMIvYM+GbBEiKtQ5jO+xgBHqrs7CfdByo9gWtJ00YZ5FL?=
 =?us-ascii?Q?32hiNgtzHan6SyGsb3afm2Pmz1vSVb3+AREbk+jg3BxWkJZEqdGEBBBj9/7e?=
 =?us-ascii?Q?hTIdfa2sAo/qf4Jz4D4GHS2zJ6R4a6gCxg9geIp7euFxhdcUH0coGIBQG4Ua?=
 =?us-ascii?Q?M1S+f+qTKzYhnJren8aOCNTqNyWs5B55PUguFdoqbi/KTFdftxxCYXv6Gf8D?=
 =?us-ascii?Q?9JCLhZN9MqXbcMLmp/CV63f4yR70YLDcyFmS/4m208NNM2C0FzacQ7az2PCT?=
 =?us-ascii?Q?3R8p6RZeJGGarKKsmtczvMncr0F0UTBdcygvxZGOf7LZ2UzpeXrqOSZHI0nG?=
 =?us-ascii?Q?OOi9QcmS0VPqQeR3be1HeZWzul4PZz8oyoz7rdAiCv6ckHVQKaHEiGrsZ2FX?=
 =?us-ascii?Q?h5njouhcoaTtJY2wLDHyq0QlfhUGFfXrpmewXBgW8x3hzaoJ/aq4JsVOLCIS?=
 =?us-ascii?Q?IPZATyyCM4nGf4zpwfiexf6R?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24e6c17c-3045-4446-8d20-08d92221eda5
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 21:45:36.7909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Ow6oDNJ/mlPJsGrxVG7D/o8hUhgPWIBbrnDZTVV8FVmD/juewXaS2dl3grxltK3+AF9FjHw9AeM/rTmRnNpeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB6700
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This rewrites the Xilinx AXI timer driver to be more platform agnostic.
Some common code has been split off so it can be reused. These routines
currently live in drivers/mfd. The largest changes have taken place in the
initialization:

- We now support any number of timer devices, possibly with only one
  counter each. The first counter will be used as a clocksource. Every
  other counter will be used as a clockevent.
- We do not use timer_of_init because we need to perform some tasks in
  between different stages. For example, we must ensure that ->read and
  ->write are initialized before registering the irq. This can only happen
  after we have gotten the register base (to detect endianness). We also
  have a rather unusual clock initialization sequence in order to remain
  backwards compatible. Due to this, it's ok for the initial clock request
  to fail, and we do not want other initialization to be undone. Lastly, it
  is more convenient to do one allocation for xilinx_clockevent_device than
  to do one for timer_of and one for xilinx_timer_priv.
- We now pay attention to xlnx,count-width and handle smaller width timers.
  The default remains 32.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---
This has been tested on microblaze qemu.

Changes in v4:
- Break out clock* drivers into their own file

 arch/microblaze/kernel/Makefile    |   3 +-
 arch/microblaze/kernel/timer.c     | 326 -----------------------------
 drivers/clocksource/Kconfig        |  11 +
 drivers/clocksource/Makefile       |   1 +
 drivers/clocksource/timer-xilinx.c | 300 ++++++++++++++++++++++++++
 drivers/mfd/Makefile               |   4 +
 drivers/mfd/xilinx-timer.c         | 147 +++++++++++++
 include/linux/mfd/xilinx-timer.h   | 134 ++++++++++++
 8 files changed, 598 insertions(+), 328 deletions(-)
 delete mode 100644 arch/microblaze/kernel/timer.c
 create mode 100644 drivers/clocksource/timer-xilinx.c
 create mode 100644 drivers/mfd/xilinx-timer.c
 create mode 100644 include/linux/mfd/xilinx-timer.h

diff --git a/arch/microblaze/kernel/Makefile b/arch/microblaze/kernel/Makefile
index 15a20eb814ce..3b6d725398f8 100644
--- a/arch/microblaze/kernel/Makefile
+++ b/arch/microblaze/kernel/Makefile
@@ -5,7 +5,6 @@
 
 ifdef CONFIG_FUNCTION_TRACER
 # Do not trace early boot code and low level code
-CFLAGS_REMOVE_timer.o = -pg
 CFLAGS_REMOVE_intc.o = -pg
 CFLAGS_REMOVE_early_printk.o = -pg
 CFLAGS_REMOVE_ftrace.o = -pg
@@ -17,7 +16,7 @@ extra-y := head.o vmlinux.lds
 obj-y += dma.o exceptions.o \
 	hw_exception_handler.o irq.o \
 	process.o prom.o ptrace.o \
-	reset.o setup.o signal.o sys_microblaze.o timer.o traps.o unwind.o
+	reset.o setup.o signal.o sys_microblaze.o traps.o unwind.o
 
 obj-y += cpu/
 
diff --git a/arch/microblaze/kernel/timer.c b/arch/microblaze/kernel/timer.c
deleted file mode 100644
index f8832cf49384..000000000000
--- a/arch/microblaze/kernel/timer.c
+++ /dev/null
@@ -1,326 +0,0 @@
-/*
- * Copyright (C) 2007-2013 Michal Simek <monstr@monstr.eu>
- * Copyright (C) 2012-2013 Xilinx, Inc.
- * Copyright (C) 2007-2009 PetaLogix
- * Copyright (C) 2006 Atmark Techno, Inc.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License. See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-
-#include <linux/interrupt.h>
-#include <linux/delay.h>
-#include <linux/sched.h>
-#include <linux/sched/clock.h>
-#include <linux/sched_clock.h>
-#include <linux/clk.h>
-#include <linux/clockchips.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/timecounter.h>
-#include <asm/cpuinfo.h>
-
-static void __iomem *timer_baseaddr;
-
-static unsigned int freq_div_hz;
-static unsigned int timer_clock_freq;
-
-#define TCSR0	(0x00)
-#define TLR0	(0x04)
-#define TCR0	(0x08)
-#define TCSR1	(0x10)
-#define TLR1	(0x14)
-#define TCR1	(0x18)
-
-#define TCSR_MDT	(1<<0)
-#define TCSR_UDT	(1<<1)
-#define TCSR_GENT	(1<<2)
-#define TCSR_CAPT	(1<<3)
-#define TCSR_ARHT	(1<<4)
-#define TCSR_LOAD	(1<<5)
-#define TCSR_ENIT	(1<<6)
-#define TCSR_ENT	(1<<7)
-#define TCSR_TINT	(1<<8)
-#define TCSR_PWMA	(1<<9)
-#define TCSR_ENALL	(1<<10)
-
-static unsigned int (*read_fn)(void __iomem *);
-static void (*write_fn)(u32, void __iomem *);
-
-static void timer_write32(u32 val, void __iomem *addr)
-{
-	iowrite32(val, addr);
-}
-
-static unsigned int timer_read32(void __iomem *addr)
-{
-	return ioread32(addr);
-}
-
-static void timer_write32_be(u32 val, void __iomem *addr)
-{
-	iowrite32be(val, addr);
-}
-
-static unsigned int timer_read32_be(void __iomem *addr)
-{
-	return ioread32be(addr);
-}
-
-static inline void xilinx_timer0_stop(void)
-{
-	write_fn(read_fn(timer_baseaddr + TCSR0) & ~TCSR_ENT,
-		 timer_baseaddr + TCSR0);
-}
-
-static inline void xilinx_timer0_start_periodic(unsigned long load_val)
-{
-	if (!load_val)
-		load_val = 1;
-	/* loading value to timer reg */
-	write_fn(load_val, timer_baseaddr + TLR0);
-
-	/* load the initial value */
-	write_fn(TCSR_LOAD, timer_baseaddr + TCSR0);
-
-	/* see timer data sheet for detail
-	 * !ENALL - don't enable 'em all
-	 * !PWMA - disable pwm
-	 * TINT - clear interrupt status
-	 * ENT- enable timer itself
-	 * ENIT - enable interrupt
-	 * !LOAD - clear the bit to let go
-	 * ARHT - auto reload
-	 * !CAPT - no external trigger
-	 * !GENT - no external signal
-	 * UDT - set the timer as down counter
-	 * !MDT0 - generate mode
-	 */
-	write_fn(TCSR_TINT|TCSR_ENIT|TCSR_ENT|TCSR_ARHT|TCSR_UDT,
-		 timer_baseaddr + TCSR0);
-}
-
-static inline void xilinx_timer0_start_oneshot(unsigned long load_val)
-{
-	if (!load_val)
-		load_val = 1;
-	/* loading value to timer reg */
-	write_fn(load_val, timer_baseaddr + TLR0);
-
-	/* load the initial value */
-	write_fn(TCSR_LOAD, timer_baseaddr + TCSR0);
-
-	write_fn(TCSR_TINT|TCSR_ENIT|TCSR_ENT|TCSR_ARHT|TCSR_UDT,
-		 timer_baseaddr + TCSR0);
-}
-
-static int xilinx_timer_set_next_event(unsigned long delta,
-					struct clock_event_device *dev)
-{
-	pr_debug("%s: next event, delta %x\n", __func__, (u32)delta);
-	xilinx_timer0_start_oneshot(delta);
-	return 0;
-}
-
-static int xilinx_timer_shutdown(struct clock_event_device *evt)
-{
-	pr_info("%s\n", __func__);
-	xilinx_timer0_stop();
-	return 0;
-}
-
-static int xilinx_timer_set_periodic(struct clock_event_device *evt)
-{
-	pr_info("%s\n", __func__);
-	xilinx_timer0_start_periodic(freq_div_hz);
-	return 0;
-}
-
-static struct clock_event_device clockevent_xilinx_timer = {
-	.name			= "xilinx_clockevent",
-	.features		= CLOCK_EVT_FEAT_ONESHOT |
-				  CLOCK_EVT_FEAT_PERIODIC,
-	.shift			= 8,
-	.rating			= 300,
-	.set_next_event		= xilinx_timer_set_next_event,
-	.set_state_shutdown	= xilinx_timer_shutdown,
-	.set_state_periodic	= xilinx_timer_set_periodic,
-};
-
-static inline void timer_ack(void)
-{
-	write_fn(read_fn(timer_baseaddr + TCSR0), timer_baseaddr + TCSR0);
-}
-
-static irqreturn_t timer_interrupt(int irq, void *dev_id)
-{
-	struct clock_event_device *evt = &clockevent_xilinx_timer;
-	timer_ack();
-	evt->event_handler(evt);
-	return IRQ_HANDLED;
-}
-
-static __init int xilinx_clockevent_init(void)
-{
-	clockevent_xilinx_timer.mult =
-		div_sc(timer_clock_freq, NSEC_PER_SEC,
-				clockevent_xilinx_timer.shift);
-	clockevent_xilinx_timer.max_delta_ns =
-		clockevent_delta2ns((u32)~0, &clockevent_xilinx_timer);
-	clockevent_xilinx_timer.max_delta_ticks = (u32)~0;
-	clockevent_xilinx_timer.min_delta_ns =
-		clockevent_delta2ns(1, &clockevent_xilinx_timer);
-	clockevent_xilinx_timer.min_delta_ticks = 1;
-	clockevent_xilinx_timer.cpumask = cpumask_of(0);
-	clockevents_register_device(&clockevent_xilinx_timer);
-
-	return 0;
-}
-
-static u64 xilinx_clock_read(void)
-{
-	return read_fn(timer_baseaddr + TCR1);
-}
-
-static u64 xilinx_read(struct clocksource *cs)
-{
-	/* reading actual value of timer 1 */
-	return (u64)xilinx_clock_read();
-}
-
-static struct timecounter xilinx_tc = {
-	.cc = NULL,
-};
-
-static u64 xilinx_cc_read(const struct cyclecounter *cc)
-{
-	return xilinx_read(NULL);
-}
-
-static struct cyclecounter xilinx_cc = {
-	.read = xilinx_cc_read,
-	.mask = CLOCKSOURCE_MASK(32),
-	.shift = 8,
-};
-
-static int __init init_xilinx_timecounter(void)
-{
-	xilinx_cc.mult = div_sc(timer_clock_freq, NSEC_PER_SEC,
-				xilinx_cc.shift);
-
-	timecounter_init(&xilinx_tc, &xilinx_cc, sched_clock());
-
-	return 0;
-}
-
-static struct clocksource clocksource_microblaze = {
-	.name		= "xilinx_clocksource",
-	.rating		= 300,
-	.read		= xilinx_read,
-	.mask		= CLOCKSOURCE_MASK(32),
-	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
-};
-
-static int __init xilinx_clocksource_init(void)
-{
-	int ret;
-
-	ret = clocksource_register_hz(&clocksource_microblaze,
-				      timer_clock_freq);
-	if (ret) {
-		pr_err("failed to register clocksource");
-		return ret;
-	}
-
-	/* stop timer1 */
-	write_fn(read_fn(timer_baseaddr + TCSR1) & ~TCSR_ENT,
-		 timer_baseaddr + TCSR1);
-	/* start timer1 - up counting without interrupt */
-	write_fn(TCSR_TINT|TCSR_ENT|TCSR_ARHT, timer_baseaddr + TCSR1);
-
-	/* register timecounter - for ftrace support */
-	return init_xilinx_timecounter();
-}
-
-static int __init xilinx_timer_init(struct device_node *timer)
-{
-	struct clk *clk;
-	static int initialized;
-	u32 irq;
-	u32 timer_num = 1;
-	int ret;
-
-	if (initialized)
-		return -EINVAL;
-
-	initialized = 1;
-
-	timer_baseaddr = of_iomap(timer, 0);
-	if (!timer_baseaddr) {
-		pr_err("ERROR: invalid timer base address\n");
-		return -ENXIO;
-	}
-
-	write_fn = timer_write32;
-	read_fn = timer_read32;
-
-	write_fn(TCSR_MDT, timer_baseaddr + TCSR0);
-	if (!(read_fn(timer_baseaddr + TCSR0) & TCSR_MDT)) {
-		write_fn = timer_write32_be;
-		read_fn = timer_read32_be;
-	}
-
-	irq = irq_of_parse_and_map(timer, 0);
-	if (irq <= 0) {
-		pr_err("Failed to parse and map irq");
-		return -EINVAL;
-	}
-
-	of_property_read_u32(timer, "xlnx,one-timer-only", &timer_num);
-	if (timer_num) {
-		pr_err("Please enable two timers in HW\n");
-		return -EINVAL;
-	}
-
-	pr_info("%pOF: irq=%d\n", timer, irq);
-
-	clk = of_clk_get(timer, 0);
-	if (IS_ERR(clk)) {
-		pr_err("ERROR: timer CCF input clock not found\n");
-		/* If there is clock-frequency property than use it */
-		of_property_read_u32(timer, "clock-frequency",
-				    &timer_clock_freq);
-	} else {
-		timer_clock_freq = clk_get_rate(clk);
-	}
-
-	if (!timer_clock_freq) {
-		pr_err("ERROR: Using CPU clock frequency\n");
-		timer_clock_freq = cpuinfo.cpu_clock_freq;
-	}
-
-	freq_div_hz = timer_clock_freq / HZ;
-
-	ret = request_irq(irq, timer_interrupt, IRQF_TIMER, "timer",
-			  &clockevent_xilinx_timer);
-	if (ret) {
-		pr_err("Failed to setup IRQ");
-		return ret;
-	}
-
-	ret = xilinx_clocksource_init();
-	if (ret)
-		return ret;
-
-	ret = xilinx_clockevent_init();
-	if (ret)
-		return ret;
-
-	sched_clock_register(xilinx_clock_read, 32, timer_clock_freq);
-
-	return 0;
-}
-
-TIMER_OF_DECLARE(xilinx_timer, "xlnx,xps-timer-1.00.a",
-		       xilinx_timer_init);
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 39aa21d01e05..d2dcde65390d 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -693,4 +693,15 @@ config MICROCHIP_PIT64B
 	  modes and high resolution. It is used as a clocksource
 	  and a clockevent.
 
+config XILINX_TIMER
+	bool "Xilinx AXI Timer support"
+	depends on HAS_IOMEM && COMMON_CLK
+	default y if MICROBLAZE
+	help
+	  Clocksource/clockevent driver for Xilinx LogiCORE IP AXI
+	  timers. This timer is typically a soft core which may be
+	  present in Xilinx FPGAs. This device may also be present in
+	  Microblaze soft processors. If you don't have this IP in your
+	  design, choose N.
+
 endmenu
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index c17ee32a7151..d506eeceedf4 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -88,3 +88,4 @@ obj-$(CONFIG_CSKY_MP_TIMER)		+= timer-mp-csky.o
 obj-$(CONFIG_GX6605S_TIMER)		+= timer-gx6605s.o
 obj-$(CONFIG_HYPERV_TIMER)		+= hyperv_timer.o
 obj-$(CONFIG_MICROCHIP_PIT64B)		+= timer-microchip-pit64b.o
+obj-$(CONFIG_XILINX_TIMER)		+= timer-xilinx.o
diff --git a/drivers/clocksource/timer-xilinx.c b/drivers/clocksource/timer-xilinx.c
new file mode 100644
index 000000000000..3554a0cd4d9c
--- /dev/null
+++ b/drivers/clocksource/timer-xilinx.c
@@ -0,0 +1,300 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2021 Sean Anderson <sean.anderson@seco.com>
+ *
+ * Hardware limitations:
+ * - When in cascade mode we cannot read the full 64-bit counter in one go
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/clockchips.h>
+#include <linux/clocksource.h>
+#include <linux/log2.h>
+#include <linux/mfd/xilinx-timer.h>
+#include <linux/interrupt.h>
+#include <linux/of_irq.h>
+#include <linux/of_address.h>
+#include <linux/sched_clock.h>
+#if IS_ENABLED(CONFIG_MICROBLAZE)
+#include <asm/cpuinfo.h>
+#endif
+
+struct xilinx_clocksource_device {
+	struct clocksource cs;
+	struct xilinx_timer_priv priv;
+};
+
+static inline struct xilinx_timer_priv
+*xilinx_clocksource_to_priv(struct clocksource *cs)
+{
+	return &container_of(cs, struct xilinx_clocksource_device, cs)->priv;
+}
+
+static u64 xilinx_clocksource_read(struct clocksource *cs)
+{
+	return xilinx_timer_read(xilinx_clocksource_to_priv(cs), TCR0);
+}
+
+static struct xilinx_clocksource_device xilinx_clocksource = {
+	.cs = {
+		.name = "xilinx_clocksource",
+		.rating = 300,
+		.read = xilinx_clocksource_read,
+		.flags = CLOCK_SOURCE_IS_CONTINUOUS,
+		.owner = THIS_MODULE,
+	},
+};
+
+static u64 xilinx_sched_read(void)
+{
+	return xilinx_timer_read(&xilinx_clocksource.priv, TCSR0);
+}
+
+static int xilinx_clocksource_init(struct device_node *np)
+{
+	int ret;
+	struct xilinx_timer_priv *priv = &xilinx_clocksource.priv;
+
+	xilinx_timer_write(priv, 0, TLR0);
+	/* Load TLR and clear any interrupts */
+	xilinx_timer_write(priv, TCSR_LOAD | TCSR_TINT, TCSR0);
+	/* Start the timer counting up with auto-reload */
+	xilinx_timer_write(priv, TCSR_ARHT | TCSR_ENT, TCSR0);
+
+	xilinx_clocksource.cs.mask = priv->max;
+	ret = clocksource_register_hz(&xilinx_clocksource.cs,
+				      clk_get_rate(priv->clk));
+	if (!ret)
+		sched_clock_register(xilinx_sched_read, ilog2(priv->max),
+				     clk_get_rate(priv->clk));
+	else
+		pr_err("%pOF: err %d: could not register clocksource\n",
+		       np, ret);
+	return ret;
+}
+
+struct xilinx_clockevent_device {
+	struct clock_event_device ce;
+	struct xilinx_timer_priv priv;
+};
+
+static inline struct xilinx_timer_priv
+*xilinx_clockevent_to_priv(struct clock_event_device *ce)
+{
+	return &container_of(ce, struct xilinx_clockevent_device, ce)->priv;
+}
+
+static irqreturn_t xilinx_timer_handler(int irq, void *p)
+{
+	struct xilinx_clockevent_device *dev = p;
+	u32 tcsr1 = xilinx_timer_read(&dev->priv, TCSR0);
+
+	if (!(tcsr1 & TCSR_TINT))
+		return IRQ_NONE;
+
+	xilinx_timer_write(&dev->priv, tcsr1 | TCSR_TINT, TCSR0);
+	dev->ce.event_handler(&dev->ce);
+	return IRQ_HANDLED;
+}
+
+static int xilinx_clockevent_next_event(unsigned long evt,
+					struct clock_event_device *ce)
+{
+	struct xilinx_timer_priv *priv = xilinx_clockevent_to_priv(ce);
+
+	xilinx_timer_write(priv, evt, TLR0);
+	xilinx_timer_write(priv, TCSR_LOAD, TCSR0);
+	xilinx_timer_write(priv, TCSR_ENIT | TCSR_ENT, TCSR0);
+	return 0;
+}
+
+static int xilinx_clockevent_state_periodic(struct clock_event_device *ce)
+{
+	int ret;
+	u32 tlr1;
+	struct xilinx_timer_priv *priv = xilinx_clockevent_to_priv(ce);
+
+	ret = xilinx_timer_tlr_cycles(priv, &tlr1, 0,
+				      clk_get_rate(priv->clk) / HZ);
+	if (ret)
+		return ret;
+
+	xilinx_timer_write(priv, tlr1, TLR0);
+	xilinx_timer_write(priv, TCSR_LOAD, TCSR0);
+	xilinx_timer_write(priv, TCSR_ARHT | TCSR_ENIT | TCSR_ENT, TCSR0);
+	return 0;
+}
+
+static int xilinx_clockevent_shutdown(struct clock_event_device *ce)
+{
+	xilinx_timer_write(xilinx_clockevent_to_priv(ce), 0, TCSR0);
+	return 0;
+}
+
+static const struct clock_event_device xilinx_clockevent_base = {
+	.rating = 300,
+	.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
+	.set_next_event = xilinx_clockevent_next_event,
+	.set_state_periodic = xilinx_clockevent_state_periodic,
+	.set_state_shutdown = xilinx_clockevent_shutdown,
+	.cpumask = cpu_possible_mask,
+	.owner = THIS_MODULE,
+};
+
+static int xilinx_clockevent_init(struct device_node *np,
+				  struct xilinx_clockevent_device *dev)
+{
+	char *buf;
+	char fmt[] = "%pOFn@%p";
+	size_t n;
+	int irq, ret;
+
+	irq = ret = of_irq_get(np, 0);
+	if (ret < 0) {
+		pr_err("%pOF: err %d: could not get irq\n", np, ret);
+		return ret;
+	}
+
+	ret = request_irq(irq, xilinx_timer_handler, IRQF_TIMER,
+			  np->full_name, dev);
+	if (ret) {
+		pr_err("%pOF: err %d: could not request irq\n", np, ret);
+		return ret;
+	}
+
+	memcpy(&dev->ce, &xilinx_clockevent_base, sizeof(dev->ce));
+	n = snprintf(NULL, 0, fmt, np, dev->priv.regs) + 1;
+	buf = kzalloc(n, GFP_KERNEL);
+	if (!buf) {
+		free_irq(irq, dev);
+		return -ENOMEM;
+	}
+	snprintf(buf, n, fmt, np, dev->priv.regs);
+	dev->ce.name = buf;
+
+	clockevents_config_and_register(&dev->ce, clk_get_rate(dev->priv.clk), 2,
+					min_t(u64, dev->priv.max + 2, ULONG_MAX));
+	return 0;
+}
+
+static bool clocksource_uninitialized = true;
+
+static int __init xilinx_timer_init(struct device_node *np)
+{
+	bool artificial_clock = false;
+	int ret;
+	struct clk_hw *hw;
+	struct clk *clk;
+	struct xilinx_timer_priv *priv;
+	struct xilinx_clockevent_device *dev;
+	u32 one_timer;
+	void __iomem *regs;
+
+	if (of_property_read_bool(np, "#pwm-cells"))
+		return 0;
+
+	regs = of_iomap(np, 0);
+	if (IS_ERR(regs)) {
+		ret = PTR_ERR(regs);
+		pr_err("%pOF: err %d: failed to map regs\n", np, ret);
+		return ret;
+	}
+
+	if (clocksource_uninitialized) {
+		priv = &xilinx_clocksource.priv;
+	} else {
+		dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+		if (!dev) {
+			ret = -ENOMEM;
+			goto err_regs;
+		}
+		priv = &dev->priv;
+	}
+	priv->regs = regs;
+
+	ret = xilinx_timer_common_init(np, priv, &one_timer);
+	if (ret)
+		goto err_regs;
+
+	priv->clk = of_clk_get_by_name(np, "s_axi_aclk");
+	if (IS_ERR(priv->clk)) {
+		u32 freq;
+
+		ret = PTR_ERR(clk);
+		if (ret == -EPROBE_DEFER)
+			goto err_regs;
+
+		pr_warn("%pOF: missing s_axi_aclk, falling back to clock-frequency\n",
+			np);
+		ret = of_property_read_u32(np, "clock-frequency", &freq);
+		if (ret) {
+#if IS_ENABLED(CONFIG_MICROBLAZE)
+			pr_warn("%pOF: missing clock-frequency, falling back to /cpus/timebase-frequency\n",
+				np);
+			freq = cpuinfo.cpu_clock_freq;
+#else
+			goto err_regs;
+#endif
+		}
+
+		hw = __clk_hw_register_fixed_rate(NULL, np, np->full_name, NULL,
+						  NULL, NULL, 0, freq, 0, 0);
+		if (IS_ERR(hw)) {
+			ret = PTR_ERR(hw);
+			goto err_regs;
+		}
+		priv->clk = hw->clk;
+		artificial_clock = true;
+	}
+
+	ret = clk_prepare_enable(priv->clk);
+	if (ret) {
+		pr_err("%pOF: err %d: clock enable failed\n", np, ret);
+		goto err_clk_init;
+	}
+	clk_rate_exclusive_get(priv->clk);
+
+	if (clocksource_uninitialized) {
+		ret = xilinx_clocksource_init(np);
+		if (ret)
+			goto err_clk_enable;
+		clocksource_uninitialized = false;
+	} else {
+		ret = xilinx_clockevent_init(np, dev);
+		if (ret)
+			goto err_clk_enable;
+	}
+	of_node_set_flag(np, OF_POPULATED);
+
+	if (!one_timer) {
+		dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+		if (!dev)
+			return -ENOMEM;
+
+		/*
+		 * We don't support removal, so don't bother enabling
+		 * the clock twice.
+		 */
+		memcpy(&dev->priv, priv, sizeof(dev->priv));
+		dev->priv.regs += TCSR1;
+		return xilinx_clockevent_init(np, dev);
+	}
+
+	return 0;
+
+err_clk_enable:
+	clk_rate_exclusive_put(priv->clk);
+	clk_disable_unprepare(priv->clk);
+err_clk_init:
+	if (artificial_clock)
+		clk_unregister_fixed_rate(priv->clk);
+	else
+		clk_put(priv->clk);
+err_regs:
+	iounmap(regs);
+	return ret;
+}
+
+TIMER_OF_DECLARE(xilinx_xps_timer, "xlnx,xps-timer-1.00.a", xilinx_timer_init);
+TIMER_OF_DECLARE(xilinx_axi_timer, "xlnx,axi-timer-2.0", xilinx_timer_init);
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 834f5463af28..f0f9fbdde7dc 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -268,3 +268,7 @@ obj-$(CONFIG_MFD_ACER_A500_EC)	+= acer-ec-a500.o
 obj-$(CONFIG_SGI_MFD_IOC3)	+= ioc3.o
 obj-$(CONFIG_MFD_SIMPLE_MFD_I2C)	+= simple-mfd-i2c.o
 obj-$(CONFIG_MFD_INTEL_M10_BMC)   += intel-m10-bmc.o
+
+ifneq ($(CONFIG_XILINX_TIMER),)
+obj-y				+= xilinx-timer.o
+endif
diff --git a/drivers/mfd/xilinx-timer.c b/drivers/mfd/xilinx-timer.c
new file mode 100644
index 000000000000..3d80a3ab6626
--- /dev/null
+++ b/drivers/mfd/xilinx-timer.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2021 Sean Anderson <sean.anderson@seco.com>
+ *
+ * For Xilinx LogiCORE IP AXI Timer documentation, refer to DS764:
+ * https://www.xilinx.com/support/documentation/ip_documentation/axi_timer/v1_03_a/axi_timer_ds764.pdf
+ */
+
+#include <linux/clk.h>
+#include <linux/mfd/xilinx-timer.h>
+#include <linux/of.h>
+#include <asm/io.h>
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
+/* readl/writel wrappers to support BE systems */
+
+static u32 xilinx_ioread32be(const void __iomem *addr)
+{
+	return ioread32be(addr);
+}
+
+static void xilinx_iowrite32be(u32 value, void __iomem *addr)
+{
+	iowrite32be(value, addr);
+}
+
+static u32 xilinx_ioread32(const void __iomem *addr)
+{
+	return ioread32(addr);
+}
+
+static void xilinx_iowrite32(u32 value, void __iomem *addr)
+{
+	iowrite32(value, addr);
+}
+
+int xilinx_timer_tlr_cycles(struct xilinx_timer_priv *priv, u32 *tlr,
+			    u32 tcsr, u64 cycles)
+{
+	if (cycles < 2 || cycles > priv->max + 2)
+		return -ERANGE;
+
+	if (tcsr & TCSR_UDT)
+		*tlr = cycles - 2;
+	else
+		*tlr = priv->max - cycles + 2;
+
+	return 0;
+}
+
+int xilinx_timer_tlr_period(struct xilinx_timer_priv *priv, u32 *tlr,
+			    u32 tcsr, unsigned int period)
+{
+	u64 cycles = DIV_ROUND_DOWN_ULL((u64)period * clk_get_rate(priv->clk),
+					NSEC_PER_SEC);
+
+	return xilinx_timer_tlr_cycles(priv, tlr, tcsr, cycles);
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
+		cycles = priv->max - tlr + 2;
+
+	return DIV_ROUND_UP_ULL(cycles * NSEC_PER_SEC,
+				clk_get_rate(priv->clk));
+}
+
+int xilinx_timer_common_init(struct device_node *np,
+			     struct xilinx_timer_priv *priv,
+			     u32 *one_timer)
+{
+	int ret;
+	u32 tcsr0, width;
+
+
+	priv->read = xilinx_ioread32;
+	priv->write = xilinx_iowrite32;
+	/*
+	 * If PWM mode is enabled, we should try not to disturb it. Use
+	 * CAPT since if PWM mode is enabled then MDT will be set as
+	 * well.
+	 *
+	 * First, clear CAPT and verify that it has been cleared
+	 */
+	tcsr0 = xilinx_timer_read(priv, TCSR0);
+	xilinx_timer_write(priv, tcsr0 & ~(TCSR_CAPT & swab(TCSR_CAPT)), TCSR0);
+	tcsr0 = xilinx_timer_read(priv, TCSR0);
+	if (tcsr0 & (TCSR_CAPT | swab(TCSR_CAPT))) {
+		pr_err("%pOF: cannot determine endianness\n", np);
+		return -EOPNOTSUPP;
+	}
+
+	/* Then check to make sure our write sticks */
+	xilinx_timer_write(priv, tcsr0 | TCSR_CAPT, TCSR0);
+	if (!(xilinx_timer_read(priv, TCSR0) & TCSR_CAPT)) {
+		priv->read = xilinx_ioread32be;
+		priv->write = xilinx_iowrite32be;
+	}
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
diff --git a/include/linux/mfd/xilinx-timer.h b/include/linux/mfd/xilinx-timer.h
new file mode 100644
index 000000000000..d61af119655f
--- /dev/null
+++ b/include/linux/mfd/xilinx-timer.h
@@ -0,0 +1,134 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2021 Sean Anderson <sean.anderson@seco.com>
+ */
+
+#ifndef MFD_XILINX_TIMER_H
+#define MFD_XILINX_TIMER_H
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
+
+/**
+ * struct xilinx_timer_priv - Private data for Xilinx AXI timer drivers
+ * @regs: Base address of this device
+ * @clk: Parent clock
+ * @read: Function to read a register
+ * @write: Function to write a register
+ * @max: Maximum value of the counters
+ */
+struct xilinx_timer_priv {
+	void __iomem *regs;
+	struct clk *clk;
+	u32 (*read)(const void __iomem *addr);
+	void (*write)(u32 value, void __iomem *addr);
+	u64 max;
+};
+
+/**
+ * xilinx_timer_read() - Read a word from a Xilinx AXI timer
+ * @priv: The timer's private data
+ * @offset: The offset to read from
+ *
+ * Just like readl(), possibly with endianness correction
+ *
+ * Return: The word at @priv->regs + @offset
+ */
+static inline u32 xilinx_timer_read(struct xilinx_timer_priv *priv,
+				    int offset)
+{
+	return priv->read(priv->regs + offset);
+}
+
+/**
+ * xilinx_timer_write() - Write a word to a Xilinx AXI timer
+ * @priv: The timer's private data
+ * @value: The value to write
+ * @offset: The offset to write it at
+ *
+ * Just like writel(), possibly with endianness correction
+ */
+static inline void xilinx_timer_write(struct xilinx_timer_priv *priv,
+				      u32 value, int offset)
+{
+	priv->write(value, priv->regs + offset);
+}
+
+/**
+ * xilinx_timer_tlr_cycles() - Calculate the TLR for a period specified
+ *                             in clock cycles
+ * @priv: The timer's private data
+ * @tlr: A pointer for where to write the calculated TLR value
+ * @tcsr: The value of the TCSR register for this counter
+ * @cycles: The number of cycles in this period
+ *
+ * Return: 0, or -%ERANGE if TLR cannot specify a period of @cycles
+ */
+int xilinx_timer_tlr_cycles(struct xilinx_timer_priv *priv, u32 *tlr,
+			    u32 tcsr, u64 cycles);
+
+/**
+ * xilinx_timer_tlr_period() - Calculate the TLR for a given period
+ *                             specified in a duration
+ * @priv: The timer's private data
+ * @tlr: A pointer for where to write the calculated TLR value
+ * @tcsr: The value of the TCSR register for this counter
+ * @period: The duration of the period, in ns
+ *
+ * Return: 0, or -%ERANGE if TLR cannot specify a period of @period
+ */
+int xilinx_timer_tlr_period(struct xilinx_timer_priv *priv, u32 *tlr,
+			    u32 tcsr, unsigned int period);
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
+#endif /* MFD_XILINX_TIMER_H */
-- 
2.25.1

