Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 238343F901B
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Aug 2021 23:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243709AbhHZVTe (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 26 Aug 2021 17:19:34 -0400
Received: from mail-eopbgr10086.outbound.protection.outlook.com ([40.107.1.86]:60380
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243654AbhHZVTd (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 26 Aug 2021 17:19:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XGVtmHvuK2zTkhxyWmNKemPhZoon7MSrk77ZCBBkhCuOuqW+61JGnuYtbFUUJQKGeeXxnS/ZCkon5g4RgrcXj3udOCQY092RRDWikJFXFLeaX5udVaIWpc6BUpaH1yrHk4jJc7FAfizUVD9VXRzVZxlnJNbj0rl7j/dcRZbsF2gjNo/3Wzz8dYclW/++ECG/taE8JoGPBpj4o7GI9cOnWG2y80vgwRNimLd16gOfFay8A5AwNR07w6EKJ1ReZ8RKQ/bdZvhYzVOd3ZXqAC0ojgyFDHh44A7AmwAoBzEpSSHsjuzfZc5kkBT7p14ncRPGdLfpQ4H9gJo+HYvNhW6DXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gud0dq+bU6Z01JAmapXioGaDKlunNOZ/1ehfxvOheso=;
 b=FfLhDUgMkPWNOe86MWngUOXsnoqxyRSY/OP24i/Jgtw3FpovzWSiC4tV448WD7kEraqmVCIBssQmGbjohTceZDrG+dbhpwuNMWWT847rzlJ/buA0aiqABuAqlnAiEm6mWfnPvV8S96f6LRouk9yKNOc1TU8HpJcW0LA0x17k/2WeQZQ7ncKGhZhc5AWbQm6McAzS36DTrlmRHeTICgxDfp1SQp/J2E6ZL0+pol7AX+28NkerKQwpDtegFt2IZfLzjYY7oUSGtYwW/+QUZM9bx54E83HDgZHTp1mNVBwBO2e6pK+LMkBRt6/6g5Enzflea8rUr4ZMp24CWEcDQ/OUTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gud0dq+bU6Z01JAmapXioGaDKlunNOZ/1ehfxvOheso=;
 b=PgheuR0cWu7KKF9aQOxX8pxtTyupIq7qXKk+rRnNFRHnVJ26EukIfa7JtXIaTWl88akOpz/oOpoTPp0bWSCpdS04uvkuYG06bx9rMHTD8CJoBktPO2FQvLrJdj8WZd+xLKjUORWqk7J5F5aCaXhe9Uiw15DqQTfacQhHgm0wzG8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB6PR0301MB2182.eurprd03.prod.outlook.com (2603:10a6:4:49::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Thu, 26 Aug
 2021 21:18:42 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1%7]) with mapi id 15.20.4436.025; Thu, 26 Aug 2021
 21:18:42 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Alvaro Gamez <alvaro.gamez@hazent.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Lee Jones <lee.jones@linaro.org>, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org,
        Sean Anderson <sean.anderson@seco.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v6 2/3] clocksource: Rewrite Xilinx AXI timer driver
Date:   Thu, 26 Aug 2021 17:18:29 -0400
Message-Id: <20210826211830.3311140-2-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210826211830.3311140-1-sean.anderson@seco.com>
References: <20210826211830.3311140-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR06CA0016.namprd06.prod.outlook.com
 (2603:10b6:208:23d::21) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from plantagenet.inhand.com (50.195.82.171) by MN2PR06CA0016.namprd06.prod.outlook.com (2603:10b6:208:23d::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.21 via Frontend Transport; Thu, 26 Aug 2021 21:18:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5dea74bf-fbdb-45a0-7022-08d968d71470
X-MS-TrafficTypeDiagnostic: DB6PR0301MB2182:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0301MB2182974B53314287486B85C796C79@DB6PR0301MB2182.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:655;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NYpvd5FgJsURKWQd62Ga+PFuZ+0mfD9FhgJ7vvKJEb+rAMancBjUaNp8v1R/vkiGg2fFRojGzkADpkrhfpUmoZMlZrb4eqLTiEcPtH5GvzCJ3Eq9dAmHMC1XKP3jq5HISU9LubUaZVPpAZmVAjdn2NTAeWtRO/V371SnqurmzmPdCFIHOQPuTpztGmPkWmpzfqje40VY+wiNKg4M/t2DYryj1nUf2zRtD0VDxq3tIz5eg8HrlB70AXqwrMHYO5MdpFgb/u4tVCkr+57S0CmNvgVrcZQNWn0KT4FIrcucl2sXN/+rtbwbxDUlqUIKAjK4TiELQfBxhbnuDhyLiVW+xok/CwFGBwC/e996aUQ+/dlPvrnkUbkIVutclJO1G+rPmdOvWEYM9JeXozTNf4ijK3LpE6Cuu9kEZ6DqqPWG/7bb3o4LPfPxSQ3EjjzUrYXXbhBqE959pSedvH9vaMbEcnxJg/U7fXKy8CUDaIkREaxGrsI/JQToGGugPlBEBmxB9CasXPIWGNtKkJe6mY+p2tmRfDYjtp0jTyQKOv5edJ/bV9PAFCGvJGPa0at3IdBNk8o1Bpdylo4WxhvaKLY4JVr+B9ESjnSmltRgZK0zDL0ReLA13UaqVSPxVD/dgQEqC0SpXvuA/Rz4eOq4d/Y2FoFeZV9DUixy9IvmXKHlwCC4A1f+FHWM3UrBDkZEV7gHc7NPQHr7IL3vQyhB0A8yuhiMMLd2WBZBCGboXACyzHTbqKMbNMNR3qPlatgvsJPy+o7e0frHEQW2+RqE/SwexsbxYdQWNCxYMu9Czo94k4s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(366004)(136003)(39840400004)(30864003)(36756003)(5660300002)(38100700002)(6506007)(38350700002)(966005)(44832011)(478600001)(83380400001)(6916009)(316002)(2616005)(26005)(86362001)(54906003)(6512007)(956004)(6486002)(66946007)(1076003)(8676002)(8936002)(6666004)(7416002)(4326008)(2906002)(186003)(66476007)(52116002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OSvkQeZlDDLPVtcd0KfYpLpLu9Wc9l37ldMVLdEChASAv9Ca5VL/FpEKl7t6?=
 =?us-ascii?Q?bYGOF9SG3M1UVHpE03wKceKJ9IAVyG7VF3sz1O7ruvmTsDfdAL8mFomvSqkU?=
 =?us-ascii?Q?aeSs5huzOYDW3FI+QcgCqhqj7/JrJEZHxjVJjZppmhnscUH36/o4E/5tzrne?=
 =?us-ascii?Q?yiCrB34G9xbnRFc+UQd8wbP4Jh5euVUoWwAq5RD2/2tEULowG90t03lAIPsy?=
 =?us-ascii?Q?ejuGd9Qyqtf0sX4xJsKLyTUgUCSlPtyVDQbcs8P3ZBVRF7qneBLLuJPajNMW?=
 =?us-ascii?Q?7W29gFQp2lX7Ut999swORxx21iLAUMVfTBkeQOkDvPz0KmQRvnKlgIpIeC9s?=
 =?us-ascii?Q?SHeY2AyosKzdsvTiZotMKul6QtcahUJtpRQKeOL/eeeDGcorsYRqFZuLNpu+?=
 =?us-ascii?Q?J1ea4Bmrc65ZD33Egc1f51EM/kKFUJfFQ5Lw1JVJP/Q1drFaIJk3doEWqxkX?=
 =?us-ascii?Q?SFD5i41CzAYWl52QPWVYWqLQLAuGVZZhsTwvgLwTC/fbnsMrd2ZLcGn3L5TD?=
 =?us-ascii?Q?FsKP4AFj6ohdzrvBdXLCSFoiGBDe1uL+Ia6C75LQ3DPb1mJmcxXoHGcS5SyU?=
 =?us-ascii?Q?ekSxhoo0xuu9yi0N1gp0B/fOQum2cIP0hYsnLhPy1nY9dcFxM34YO5fBFaVo?=
 =?us-ascii?Q?qVUg2Zo1VzVaeS5LaDxu9ecgg2d2NEBaH+mC0hkhuteNsK9N3jIUnhqPM9Al?=
 =?us-ascii?Q?SLttXw1dA0qJdDD9YsdaQfZVswDMHLi9YjRER8ZMXvwHr2mMnA9KZzYP4BE2?=
 =?us-ascii?Q?jwDUinrw6RxHOzvYpq3toCVZUEP1s5o634Q9EQ2hwgFKpIc8Eom1ZcNwGqIS?=
 =?us-ascii?Q?AKOSr3VYTC5A2WTjzD2V4tsdO5EOdePSRf3JQDs9SQDdtHR4nK69Bhe5RgkL?=
 =?us-ascii?Q?skSKO1gfEC8sxr/Mj4erDX+5/F9j3M89bvapMNLO5accynjS38C1wOPQYVt5?=
 =?us-ascii?Q?FR9MCNuj1f61b5b7Je4QM0HcCn8qutWcZR8T3rCDeNTZoGql3GunKuWp8EuL?=
 =?us-ascii?Q?Xoyvv9h1fgOm0znP3jWCP/mS3fQ5Iy2IZvUjGetVVhXvuNc8jXnJkOI9A4ob?=
 =?us-ascii?Q?woV7/RIJL54f4RbzwgoGfGmmOuR4A345ESPEZoksEEhy+kfgTw0GcYTdc8h6?=
 =?us-ascii?Q?kSOQN/g5LpyMCP2Y6x8nnM09JuIxh47nP11m+71fYl2sg8VM3spcmK/aDsDS?=
 =?us-ascii?Q?heWaDME70lOIT5WQJkcQ2xVVWVikF9SeBqIgzsVlCeSRFOqLTOVvAE/s/r+q?=
 =?us-ascii?Q?GBCsVgx6fUaopFlwV49hkg9HYp4gjMCY+cv+fG0SSgWOkQYjykvtsPU+gEN0?=
 =?us-ascii?Q?+d1WNB9BiG9m4D7GTDAD0/86?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dea74bf-fbdb-45a0-7022-08d968d71470
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 21:18:42.1675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1k8y+ROvM/IZX0h+uvKFRfHxAGCR1YhWnE9iEx5jv3phz9E8ILyxYBi0CkCNNFTp5J5vAqRz7m0WAR47ycFg9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0301MB2182
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This rewrites the Xilinx AXI timer driver to be more platform agnostic.
Some common code has been split off so it can be reused. These routines
currently live in drivers/mfd. The largest changes are summarized below:

- We now support any number of timer devices, possibly with only one
  counter each. The first counter will be used as a clocksource. Every
  other counter will be used as a clockevent. This allocation scheme was
  chosen arbitrarily.
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
- We access registers using regmap. This automatically deals with
  endianness issues, so we no longer have to use our own wrappers. It
  also provides locking for clockevents which have to worry about being
  interrupted in the middle of a read/modify/write.

Note that while the existing timer driver always sets the cpumask to cpu
0, this version sets it to all possible CPUs. I believe this is correct
for multiprocessor systems where the timer is not physically wired to a
particular CPU's interrupt line. For uniprocessor systems (like most
microblaze systems) this makes no difference.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---
This has been tested on microblaze qemu.

Changes in v6:
- Add __init* attributes
- Remove duplicate regmap_config
- Export common symbols
- Fix goto'ing incorrect label for cleanup
- Round to closest period in xilinx_timer_get_period to ensure proper
  semantics for xilinx_pwm_get_state

Changes in v5:
- Remove duplicate register definitions
- Remove xilinx_timer_tlr_period
- Require that callers check arguments to xilinx_timer_tlr_cycles
- Remove xlnx,axi-timer-2.0 compatible string
- Use regmap to deal with endianness issues as suggested by Lee
- Fix some overflows when setting the max value for clockevent and
  sched_clock
- Just use clk_register_fixed_rate instead of the "private" version

Changes in v4:
- Break out clock* drivers into their own file

 MAINTAINERS                               |   6 +
 arch/microblaze/kernel/Makefile           |   3 +-
 arch/microblaze/kernel/timer.c            | 326 ----------------------
 drivers/clocksource/Kconfig               |  12 +
 drivers/clocksource/Makefile              |   1 +
 drivers/clocksource/timer-xilinx-common.c |  71 +++++
 drivers/clocksource/timer-xilinx.c        | 323 +++++++++++++++++++++
 include/clocksource/timer-xilinx.h        |  91 ++++++
 8 files changed, 505 insertions(+), 328 deletions(-)
 delete mode 100644 arch/microblaze/kernel/timer.c
 create mode 100644 drivers/clocksource/timer-xilinx-common.c
 create mode 100644 drivers/clocksource/timer-xilinx.c
 create mode 100644 include/clocksource/timer-xilinx.h

diff --git a/MAINTAINERS b/MAINTAINERS
index bd7aff0c120f..252d71addd18 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20046,6 +20046,12 @@ F:	drivers/misc/Makefile
 F:	drivers/misc/xilinx_sdfec.c
 F:	include/uapi/misc/xilinx_sdfec.h
 
+XILINX TIMER/PWM DRIVER
+M:	Sean Anderson <sean.anderson@seco.com>
+S:	Maintained
+F:	drivers/clocksource/timer-xilinx*
+F:	include/clocksource/timer-xilinx.h
+
 XILINX UARTLITE SERIAL DRIVER
 M:	Peter Korsgaard <jacmet@sunsite.dk>
 L:	linux-serial@vger.kernel.org
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
index 39aa21d01e05..daa9d55927ec 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -693,4 +693,16 @@ config MICROCHIP_PIT64B
 	  modes and high resolution. It is used as a clocksource
 	  and a clockevent.
 
+config XILINX_TIMER
+	bool "Xilinx AXI Timer support"
+	depends on COMMON_CLK
+	select REGMAP_MMIO
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
index c17ee32a7151..a7cba6ef5782 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -88,3 +88,4 @@ obj-$(CONFIG_CSKY_MP_TIMER)		+= timer-mp-csky.o
 obj-$(CONFIG_GX6605S_TIMER)		+= timer-gx6605s.o
 obj-$(CONFIG_HYPERV_TIMER)		+= hyperv_timer.o
 obj-$(CONFIG_MICROCHIP_PIT64B)		+= timer-microchip-pit64b.o
+obj-$(CONFIG_XILINX_TIMER)		+= timer-xilinx.o timer-xilinx-common.o
diff --git a/drivers/clocksource/timer-xilinx-common.c b/drivers/clocksource/timer-xilinx-common.c
new file mode 100644
index 000000000000..b07156faba4e
--- /dev/null
+++ b/drivers/clocksource/timer-xilinx-common.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2021 Sean Anderson <sean.anderson@seco.com>
+ *
+ * For Xilinx LogiCORE IP AXI Timer documentation, refer to DS764:
+ * https://www.xilinx.com/support/documentation/ip_documentation/axi_timer/v1_03_a/axi_timer_ds764.pdf
+ */
+
+#include <clocksource/timer-xilinx.h>
+#include <linux/clk.h>
+#include <linux/of.h>
+
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
+EXPORT_SYMBOL_GPL(xilinx_timer_tlr_cycles);
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
+EXPORT_SYMBOL_GPL(xilinx_timer_get_period);
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
+EXPORT_SYMBOL_GPL(xilinx_timer_common_init);
diff --git a/drivers/clocksource/timer-xilinx.c b/drivers/clocksource/timer-xilinx.c
new file mode 100644
index 000000000000..142949a69502
--- /dev/null
+++ b/drivers/clocksource/timer-xilinx.c
@@ -0,0 +1,323 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2021 Sean Anderson <sean.anderson@seco.com>
+ *
+ * Limitations:
+ * - When in cascade mode we cannot read the full 64-bit counter in one go
+ */
+
+#include <clocksource/timer-xilinx.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/clockchips.h>
+#include <linux/clocksource.h>
+#include <linux/log2.h>
+#include <linux/interrupt.h>
+#include <linux/of_irq.h>
+#include <linux/of_address.h>
+#include <linux/regmap.h>
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
+	struct xilinx_timer_priv *priv = xilinx_clocksource_to_priv(cs);
+	unsigned int ret;
+
+	regmap_read(priv->map, TCR0, &ret);
+	return ret;
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
+	return xilinx_clocksource_read(&xilinx_clocksource.cs);
+}
+
+static int __init xilinx_clocksource_init(struct device_node *np)
+{
+	int ret;
+	struct xilinx_timer_priv *priv = &xilinx_clocksource.priv;
+	static const struct reg_sequence init[] = {
+		REG_SEQ0(TLR0, 0),
+		REG_SEQ0(TCSR0, TCSR_LOAD | TCSR_TINT),
+		REG_SEQ0(TCSR0, TCSR_ARHT | TCSR_ENT),
+	};
+
+	ret = regmap_multi_reg_write(priv->map, init, ARRAY_SIZE(init));
+	if (ret)
+		return ret;
+
+	xilinx_clocksource.cs.mask = priv->max;
+	ret = clocksource_register_hz(&xilinx_clocksource.cs,
+				      clk_get_rate(priv->clk));
+	if (!ret)
+		sched_clock_register(xilinx_sched_read,
+				     ilog2((u64)priv->max + 1),
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
+
+	if (regmap_test_bits(dev->priv.map, TCSR0, TCSR_TINT) <= 0)
+		return IRQ_NONE;
+
+	regmap_clear_bits(dev->priv.map, TCSR0, TCSR_TINT);
+	dev->ce.event_handler(&dev->ce);
+	return IRQ_HANDLED;
+}
+
+static int xilinx_clockevent_next_event(unsigned long evt,
+					struct clock_event_device *ce)
+{
+	struct xilinx_timer_priv *priv = xilinx_clockevent_to_priv(ce);
+	struct reg_sequence next[] = {
+		REG_SEQ0(TLR0, evt - 2),
+		REG_SEQ0(TCSR0, TCSR_LOAD),
+		REG_SEQ0(TCSR0, TCSR_ENIT | TCSR_ENT),
+	};
+
+	return regmap_multi_reg_write(priv->map, next, ARRAY_SIZE(next));
+}
+
+static int xilinx_clockevent_state_periodic(struct clock_event_device *ce)
+{
+	struct xilinx_timer_priv *priv = xilinx_clockevent_to_priv(ce);
+	struct reg_sequence periodic[] = {
+		REG_SEQ0(TLR0, 0),
+		REG_SEQ0(TCSR0, TCSR_LOAD),
+		REG_SEQ0(TCSR0, TCSR_ARHT | TCSR_ENIT | TCSR_ENT),
+	};
+	unsigned long cycles = clk_get_rate(priv->clk) / HZ;
+
+	if (cycles < 2 || cycles - 2 > priv->max)
+		return -ERANGE;
+	periodic[0].def = xilinx_timer_tlr_cycles(priv, 0, cycles);
+
+	return regmap_multi_reg_write(priv->map, periodic, ARRAY_SIZE(periodic));
+}
+
+static int xilinx_clockevent_shutdown(struct clock_event_device *ce)
+{
+	struct xilinx_timer_priv *priv = xilinx_clockevent_to_priv(ce);
+
+	return regmap_write(priv->map, TCSR0, 0);
+}
+
+static const struct clock_event_device xilinx_clockevent_base __initconst = {
+	.rating = 300,
+	.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
+	.set_next_event = xilinx_clockevent_next_event,
+	.set_state_periodic = xilinx_clockevent_state_periodic,
+	.set_state_shutdown = xilinx_clockevent_shutdown,
+	.cpumask = cpu_possible_mask,
+	.owner = THIS_MODULE,
+};
+
+static int __init xilinx_clockevent_init(struct device_node *np,
+					 struct xilinx_clockevent_device *dev)
+{
+	int irq, ret;
+
+	irq = ret = of_irq_get(np, 0);
+	if (ret < 0) {
+		pr_err("%pOF: err %d: could not get irq\n", np, ret);
+		return ret;
+	}
+
+	ret = request_irq(irq, xilinx_timer_handler, IRQF_TIMER,
+			  of_node_full_name(np), dev);
+	if (ret) {
+		pr_err("%pOF: err %d: could not request irq\n", np, ret);
+		return ret;
+	}
+
+	memcpy(&dev->ce, &xilinx_clockevent_base, sizeof(dev->ce));
+	dev->ce.name = of_node_full_name(np);
+	clockevents_config_and_register(&dev->ce, clk_get_rate(dev->priv.clk), 2,
+					min_t(u64, (u64)dev->priv.max + 2,
+					      ULONG_MAX));
+	return 0;
+}
+
+static const struct regmap_config xilinx_timer_regmap_config __initconst = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.val_format_endian = REGMAP_ENDIAN_LITTLE,
+	.max_register = TCR0,
+};
+
+static bool clocksource_uninitialized __initdata = true;
+
+static int __init xilinx_timer_init(struct device_node *np)
+{
+	bool artificial_clock = false;
+	int ret;
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
+
+	priv->map = regmap_init_mmio(NULL, regs, &xilinx_timer_regmap_config);
+	if (IS_ERR(priv->map)) {
+		ret = PTR_ERR(priv->map);
+		goto err_priv;
+	}
+
+	ret = xilinx_timer_common_init(np, priv, &one_timer);
+	if (ret)
+		goto err_regmap;
+
+	priv->clk = of_clk_get_by_name(np, "s_axi_aclk");
+	if (IS_ERR(priv->clk)) {
+		u32 freq;
+
+		ret = PTR_ERR(priv->clk);
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
+			goto err_regmap;
+#endif
+		}
+
+		priv->clk = clk_register_fixed_rate(NULL, of_node_full_name(np),
+						    NULL, 0, freq);
+		if (IS_ERR(priv->clk)) {
+			ret = PTR_ERR(priv->clk);
+			goto err_regmap;
+		}
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
+		dev->priv.map = regmap_init_mmio(NULL, regs + TCSR1,
+						 &xilinx_timer_regmap_config);
+		if (!IS_ERR(dev->priv.map)) {
+			ret = xilinx_clockevent_init(np, dev);
+			if (!ret)
+				return 0;
+			regmap_exit(dev->priv.map);
+		} else {
+			ret = PTR_ERR(dev->priv.map);
+		}
+		kfree(dev);
+	}
+	return ret;
+
+err_clk_enable:
+	clk_rate_exclusive_put(priv->clk);
+	clk_disable_unprepare(priv->clk);
+err_clk_init:
+	if (artificial_clock)
+		clk_unregister_fixed_rate(priv->clk);
+	else
+		clk_put(priv->clk);
+err_regmap:
+	regmap_exit(priv->map);
+err_priv:
+	if (!clocksource_uninitialized)
+		kfree(dev);
+err_regs:
+	iounmap(regs);
+	return ret;
+}
+
+TIMER_OF_DECLARE(xilinx_xps_timer, "xlnx,xps-timer-1.00.a", xilinx_timer_init);
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

