Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E234037AF22
	for <lists+linux-pwm@lfdr.de>; Tue, 11 May 2021 21:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbhEKTOI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 11 May 2021 15:14:08 -0400
Received: from mail-eopbgr00085.outbound.protection.outlook.com ([40.107.0.85]:54405
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231454AbhEKTOH (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 11 May 2021 15:14:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aXzRg6NqwHZs8RPnfpWWff+JB8p8MYGnmEQ1k9amNdNdAq8uKPqZHoCZm+A6bcyZFAugfdhR0XZjHudbRCiqBxVgzYFeSQ3NJxXfD2pIc3s0VZzu5Hw709RtMJhYoGoQCBDf+rpUTgZ7iP6QeUlJX6knGfq1YnT0IcaYHrU0J2m/QhMIBi0gJNtaTlCcvu0kt5jiD5ocnWIV+w4TrFkp+AVK5MkqsuM+ZEJTSkDbNtlGgpCTZiSXEyyTVqTyC0gkKbqxL0UnLnr26v0xE5lzSLON9IobG6LhfPmCU2I7wQIQg8ZHu/hNrzcAETCjWgQDpNpisZFXnqtCBiD1H6Jj/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MvDXpogFMGVNdk03ZHXkghh6qnXd7Yi4H3xxP45tEKU=;
 b=bwqfZcT1W8Tji6GMjN2U8HQdCXDx2IcDmwfHSZxSyWLjfz6iO7qR8PLMuNMD2eB5LbtEj5biS5I7SnCAYhspIgucqsx4RSrlffyHP3hsB4vcNTfKKRw/UgBP4yiuwQSHqiJEOmxMVHSqdpHB9bhwH/ykz7jpY+ZqWfuCJJXEVdkqqq+jgFStozFjrMzBnYg5Or1rASi1kEm+0IowoR6jRrvvXBNwL+9pzTJm6XsVOutfcyGwrGM5NdrVd2Yz89cTV/q95sU3JaMjTG82mF3gogntb6kRwumE31upv3XqcW7oY5aZ041WD8WvYVudjXlDO/ddmU82M5BpeXZyjKgkJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MvDXpogFMGVNdk03ZHXkghh6qnXd7Yi4H3xxP45tEKU=;
 b=xvj5o1PKbERbUFOp9kcEJCDFmWbt+ULez8Y0pVh7ONlN+9cxYWJMjJrRiyoHGeCOmbRlZiPNKZVurR8rhC2XdMj1kHlIUTzklSPcIYhoWBhqczPqMDDYmNUT074wXRm/6cKPSkRVEbH+fnPuR4czSM9Td0+HhO40heFqo+v0+J4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB7PR03MB4154.eurprd03.prod.outlook.com (2603:10a6:10:20::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24; Tue, 11 May
 2021 19:12:58 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b%5]) with mapi id 15.20.4108.032; Tue, 11 May 2021
 19:12:58 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     michal.simek@xilinx.com, Alvaro Gamez <alvaro.gamez@hazent.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sean Anderson <sean.anderson@seco.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v3 2/2] clocksource: Add support for Xilinx AXI Timer
Date:   Tue, 11 May 2021 15:12:38 -0400
Message-Id: <20210511191239.774570-2-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210511191239.774570-1-sean.anderson@seco.com>
References: <20210511191239.774570-1-sean.anderson@seco.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [50.195.82.171]
X-ClientProxiedBy: BL0PR05CA0025.namprd05.prod.outlook.com
 (2603:10b6:208:91::35) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from plantagenet.inhand.com (50.195.82.171) by BL0PR05CA0025.namprd05.prod.outlook.com (2603:10b6:208:91::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.12 via Frontend Transport; Tue, 11 May 2021 19:12:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10b79de0-5a2d-4eec-8dab-08d914b0c9aa
X-MS-TrafficTypeDiagnostic: DB7PR03MB4154:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR03MB41542DF56A8C4CF1D16BAB9396539@DB7PR03MB4154.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t9P5yfeNai+ONNGcNM4HVTfDaqwfJYEEg1Wh1J5pku8MiiA+/GfwR7eg6wb87HmI3QjF764y3pTgoVrpT+uBPMdCIX7rfldE3sfX7AO8Lb3y2u6xkGfUcZ+IlMnlhfx8JzRIyc0B+/z/2o7By1oap5bFASAHA2YLNQ5d3xjHY823BGoxr6XGedaKEVz3E6b/4QFpWSHWTZrKc012XHDuirgvdDifyh31+TLF7o1ifBtLj0lKZwAFFlwFtcC+x3z1uMF+zADyqYDHJ2vKSorjq0st25rRKn9h49pgYFyBr14i2YYEBhbqNB0PCRiUXVE6nRi74c3VUd80NbDQouCLSk91TBZqqnEIlm6Fp0qdMjmaW6V5O5KhOKwg0z32DV0zgdpddXBjQZtbOHLcu+qJJxgk8MsqJrVmFKYI6bWfSC9jIUDIm4mrw1LrFKxxxVbyrzHLCR/x0vjkAILD7oTCCiZohH5VUr+wsVbOauOMaghQ8oWf1o0G7DzHbvnSnSw4UNxUUTmyVkokFkMLSH7ldWzKl2yMYBMhEbffzShVz5CSCeAws1DmAxApm0K2Q/Dy8y2xSMcKggbR/Ds6Iw2+Rc7taUSDRQBeujj13IwvP0Skms9fnZMjopUdK3MIPm9HjSG2d4CHANkeMJnphCEdr+nhtqzMgmXQnW4pWPrx0NoTsVzxQc5MIM1Gmbh9QCevHzjk1WbUBwrEs0jEdoFDG6xWajXQbLdzUe5M8uk8Z8Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(136003)(396003)(346002)(39830400003)(8676002)(54906003)(2906002)(38100700002)(36756003)(44832011)(7416002)(2616005)(316002)(1076003)(478600001)(52116002)(30864003)(16526019)(6506007)(956004)(186003)(26005)(83380400001)(8936002)(6486002)(86362001)(5660300002)(4326008)(966005)(66556008)(66476007)(66946007)(38350700002)(6512007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UlBINk4ydUZiNmRkSFJveG4vMTUxT2RMTkp1YnYxYVIrRmh6SzlOMXNRZ3FC?=
 =?utf-8?B?RW1tZ0tod0psNXE1c1plMWRkTmJ4Z09YeVQ0S2hMZmZHUnVFVFlHWEphc3BM?=
 =?utf-8?B?SnluUlFJa3JQRjV4MktvQ0JsUDc2Undva2dXUkV5RWtTY21LZDJRT0x1c3Nr?=
 =?utf-8?B?dnZBaUZyRTRjckZyS3g0b3NRUEZsamlYNW8xUktSMkdjUlJMbm03NmxLWDlQ?=
 =?utf-8?B?MVgvVmRwemFIY2F6UTNNWExtNk9OZzlYVmw4b2o1N1RjYUdwQWZaZlRWOU5X?=
 =?utf-8?B?RXhZWTNGd0V1Qk5KRTRPeS9NRTdvdFpBUGFmczZmdzJ4bUQvS3pMbk9iSFpp?=
 =?utf-8?B?TzFaV28xYVBYWGN0aHJkOWk4MDdVY3YyMFBIZ3BvOXJ5SGdDYmRBOG13akxj?=
 =?utf-8?B?cTYwZG9PYlE5WllBWWhQbUFNeTZCQ0xuMTdRS0lWUmdQbXFOdG9ReXpQNVg2?=
 =?utf-8?B?dzJSSXorUVRsQjR5WU9zVWNQdjB0VlhmNWVGS3ZlUElMQ1BMNVN1bFQ5NVVW?=
 =?utf-8?B?WFhUaFVSU0d0ZVNULzdpYVhQZ3VaTnc0aE9TaGZqS0dVL1RpNWFvcWMrNXBm?=
 =?utf-8?B?OFV3RXN5NWJmcXNCZ2RKYzNERmFYOGJrMVgzNDZmWTlKNlJjK0NGamoyUW1J?=
 =?utf-8?B?U3hFS21kemFIWmU2eldFZTcrTjFSZDA5Si9aK1RzZ3ZNbmdhdVRMMnRGdGNT?=
 =?utf-8?B?SHdZaGxVb2RZcXFERG9KM1hXVU90MEh6Rll0U2dNa1RsQ2FnK3pvVk4yUU1I?=
 =?utf-8?B?OWJCbHoxRGdZdzZNVEI0VElhNktZYzZ2eWVaVXB3ZW1odVZDYzVrbFVxS090?=
 =?utf-8?B?ZDVhRFVaTzNzUkQzZHZhQzJkd25qZG41cHR0R3g2cnViSi9VbTR0RkFTSjBq?=
 =?utf-8?B?QUhuK3E2VlZGWEt0OTExeklXZS9pZWhPdDlYbk40Nm1rUE5xdXpvWmNhSWpw?=
 =?utf-8?B?SS9QcnNtUW4zWjJzdjl4R1ZFTkdmdU43K2RtckRCWDhybnN5VjNYYVd4elVp?=
 =?utf-8?B?M0ZmaHZYaC82c3B3eVhCZFJFbEZBLzVzTU45YytlTCt6OXlVY1V1TUlOZTFB?=
 =?utf-8?B?dTk4ZnJzNjQ5WHErSFFwdy81Vm5ISzladXozN3lnbFNram1uZ3E0K2ZRODN3?=
 =?utf-8?B?MWwzZ3FjM0Y4TTUydUVIZjQvZlg5MjhRNFJCTGRyUFRSSi9IZzVQcHB1U25I?=
 =?utf-8?B?SndIN2NNOGNadWd5bXd5Ny9zN2xpaHNpemsyNEZDTStmUzBNaDlvWXQ2OWdB?=
 =?utf-8?B?bVRYMkdaQklCTkJWQmtEbTlDc1I3eW9kUGNCSURwQXhJS1JGOGtrK3hTcDcz?=
 =?utf-8?B?Z3h1QmFURlVnK1ZpYWRIYWc3dUNNTEQ0dnIrenVZUEFwYS92amszOHpOR1Y0?=
 =?utf-8?B?OFJQQndBc1pvNDBXSGhVdlVtRW5TclVOdnZUM3hvdzEwL2FIUHowL3VCdElr?=
 =?utf-8?B?Y25pMFkwUThrM2tudnc3dFZESEJpQmJQUnVBdDEzd2FsZ3RrZ2p5S1hmNG0z?=
 =?utf-8?B?cGRNQUJMeWZFMFg4Y0VvMEo1MStuRDdQWFg1OElEZlBRVmpsd2ZLRXdKeWZX?=
 =?utf-8?B?UGRFdHVOSndYNkN5MTQ4WEthRzJ6ZmNKVkRlT09uV3V0R0c3T3orZS91Z2lY?=
 =?utf-8?B?QnhkT3NIRUZ6Tm5QZGVzVHdLUEI3SUJ4RHZiRU1aM0Nsa2VrOG1uYnN5d2xG?=
 =?utf-8?B?MUpVYS9aQSt5ZkplWElGcTlNZWUvTTVzR3hrS25rN3NQWkhpQ0VMd0Vsc0wv?=
 =?utf-8?Q?GP9eMF0Ewy2BWLLjAr7v/AiAYmkfkteGheqJk9L?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10b79de0-5a2d-4eec-8dab-08d914b0c9aa
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2021 19:12:58.2111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pjpkzsDrgjRT0JKwDlvyOSo6A5/8eX34US94s1hWddQK1cYv/HxxNRbXLZSQO4KXGGG4E01oiayN92gwOnWJNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR03MB4154
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This adds generic clocksource and clockevent support for Xilinx LogiCORE IP
AXI soft timers commonly found on Xilinx FPGAs. This timer is also the
primary timer for Microblaze processors. This commit also adds support for
configuring this timer as a PWM (though this could be split off if
necessary). This whole driver lives in clocksource because it is primarily
clocksource stuff now (even though it started out as a PWM driver). I think
teasing apart the driver would not be worth it since they share so many
functions.

This driver configures timer 0 (which is always present) as a clocksource,
and timer 1 (which might be missing) as a clockevent. I don't know if this
is the correct priority for these timers, or whether we should be using a
more dynamic allocation scheme.

At the moment clock control is very basic: we just enable the clock during
probe and pin the frequency. In the future, someone could add support for
disabling the clock when not in use. Cascade mode is also unsupported.

This driver was written with reference to Xilinx DS764 for v1.03.a [1].

[1] https://www.xilinx.com/support/documentation/ip_documentation/axi_timer/v1_03_a/axi_timer_ds764.pdf

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---
Please let me know if I should organize this differently or if it should
be broken up.

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

 arch/microblaze/kernel/Makefile    |   2 +-
 arch/microblaze/kernel/timer.c     | 326 ---------------
 drivers/clocksource/Kconfig        |  15 +
 drivers/clocksource/Makefile       |   1 +
 drivers/clocksource/timer-xilinx.c | 650 +++++++++++++++++++++++++++++
 5 files changed, 667 insertions(+), 327 deletions(-)
 delete mode 100644 arch/microblaze/kernel/timer.c
 create mode 100644 drivers/clocksource/timer-xilinx.c

diff --git a/arch/microblaze/kernel/Makefile b/arch/microblaze/kernel/Makefile
index 15a20eb814ce..986b1f21d90e 100644
--- a/arch/microblaze/kernel/Makefile
+++ b/arch/microblaze/kernel/Makefile
@@ -17,7 +17,7 @@ extra-y := head.o vmlinux.lds
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
index 39aa21d01e05..35c95671d242 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -693,4 +693,19 @@ config MICROCHIP_PIT64B
 	  modes and high resolution. It is used as a clocksource
 	  and a clockevent.
 
+config XILINX_TIMER
+	tristate "Xilinx AXI Timer support"
+	depends on HAS_IOMEM && COMMON_CLK
+	default y if MICROBLAZE
+	help
+	  Clocksource, clockevent, and PWM drivers for Xilinx LogiCORE
+	  IP AXI Timers. This timer is typically a soft core which may
+	  be present in Xilinx FPGAs. This device may also be present in
+	  Microblaze soft processors. If you don't have this IP in your
+	  design, choose N.
+
+	  To use this device as the primary clocksource for your system,
+	  choose Y here. Otherwise, this driver will not be available
+	  early enough during boot. To compile this driver as a module,
+	  choose M here: the module will be called timer-xilinx.
 endmenu
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index c17ee32a7151..717f01c0ac41 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -58,6 +58,7 @@ obj-$(CONFIG_MILBEAUT_TIMER)	+= timer-milbeaut.o
 obj-$(CONFIG_SPRD_TIMER)	+= timer-sprd.o
 obj-$(CONFIG_NPCM7XX_TIMER)	+= timer-npcm7xx.o
 obj-$(CONFIG_RDA_TIMER)		+= timer-rda.o
+obj-$(CONFIG_XILINX_TIMER)	+= timer-xilinx.o
 
 obj-$(CONFIG_ARC_TIMERS)		+= arc_timer.o
 obj-$(CONFIG_ARM_ARCH_TIMER)		+= arm_arch_timer.o
diff --git a/drivers/clocksource/timer-xilinx.c b/drivers/clocksource/timer-xilinx.c
new file mode 100644
index 000000000000..b410c6af9c63
--- /dev/null
+++ b/drivers/clocksource/timer-xilinx.c
@@ -0,0 +1,650 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2021 Sean Anderson <sean.anderson@seco.com>
+ *
+ * For Xilinx LogiCORE IP AXI Timer documentation, refer to DS764:
+ * https://www.xilinx.com/support/documentation/ip_documentation/axi_timer/v1_03_a/axi_timer_ds764.pdf
+ *
+ * Hardware limitations:
+ * - When in cascade mode we cannot read the full 64-bit counter in one go
+ * - When changing both duty cycle and period, we may end up with one cycle
+ *   with the old duty cycle and the new period.
+ * - Cannot produce 100% duty cycle.
+ * - Only produces "normal" output.
+ */
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/clockchips.h>
+#include <linux/clocksource.h>
+#include <linux/device.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/of_irq.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/sched_clock.h>
+#include <asm/io.h>
+#if IS_ENABLED(CONFIG_MICROBLAZE)
+#include <asm/cpuinfo.h>
+#endif
+
+/* A replacement for dev_err_probe, since we don't always have a device */
+#define xilinx_timer_err(np, err, fmt, ...) ({ \
+	pr_err("%pOF: error %d: " fmt, (np), (int)(err), ##__VA_ARGS__); \
+	err; \
+})
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
+#define TCSR_PWM_SET (TCSR_GENT | TCSR_ARHT | TCSR_ENT | TCSR_PWMA)
+#define TCSR_PWM_CLEAR (TCSR_MDT | TCSR_LOAD)
+#define TCSR_PWM_MASK (TCSR_PWM_SET | TCSR_PWM_CLEAR)
+
+/**
+ * struct xilinx_timer_priv - Private data for Xilinx AXI timer driver
+ * @cs: Clocksource device
+ * @ce: Clockevent device
+ * @pwm: PWM controller chip
+ * @clk: Parent clock
+ * @regs: Base address of this device
+ * @width: Width of the counters, in bits
+ * @XILINX_TIMER_ONE: We have only one timer.
+ * @XILINX_TIMER_PWM: Configured as a PWM.
+ * @XILINX_TIMER_CLK: We were missing a device tree clock and created our own
+ * @flags: Flags for what type of device we are
+ */
+struct xilinx_timer_priv {
+	union {
+		struct {
+			struct clocksource cs;
+			struct clock_event_device ce;
+		};
+		struct pwm_chip pwm;
+	};
+	struct clk *clk;
+	void __iomem *regs;
+	u32 (*read)(const volatile void __iomem *addr);
+	void (*write)(u32 value, volatile void __iomem *addr);
+	unsigned int width;
+	enum {
+		XILINX_TIMER_ONE = BIT(0),
+		XILINX_TIMER_PWM = BIT(1),
+		XILINX_TIMER_CLK = BIT(2),
+	} flags;
+};
+
+static inline struct xilinx_timer_priv
+*xilinx_pwm_chip_to_priv(struct pwm_chip *chip)
+{
+	return container_of(chip, struct xilinx_timer_priv, pwm);
+}
+
+static inline struct xilinx_timer_priv
+*xilinx_clocksource_to_priv(struct clocksource *cs)
+{
+	return container_of(cs, struct xilinx_timer_priv, cs);
+}
+
+static inline struct xilinx_timer_priv
+*xilinx_clockevent_to_priv(struct clock_event_device *ce)
+{
+	return container_of(ce, struct xilinx_timer_priv, ce);
+}
+
+static u32 xilinx_ioread32be(const volatile void __iomem *addr)
+{
+	return ioread32be(addr);
+}
+
+static void xilinx_iowrite32be(u32 value, volatile void __iomem *addr)
+{
+	iowrite32be(value, addr);
+}
+
+static inline u32 xilinx_timer_read(struct xilinx_timer_priv *priv,
+				    int offset)
+{
+	return priv->read(priv->regs + offset);
+}
+
+static inline void xilinx_timer_write(struct xilinx_timer_priv *priv,
+				      u32 value, int offset)
+{
+	priv->write(value, priv->regs + offset);
+}
+
+static inline u64 xilinx_timer_max(struct xilinx_timer_priv *priv)
+{
+	return BIT_ULL(priv->width) - 1;
+}
+
+static int xilinx_timer_tlr_cycles(struct xilinx_timer_priv *priv, u32 *tlr,
+				   u32 tcsr, u64 cycles)
+{
+	u64 max_count = xilinx_timer_max(priv);
+
+	if (cycles < 2 || cycles > max_count + 2)
+		return -ERANGE;
+
+	if (tcsr & TCSR_UDT)
+		*tlr = cycles - 2;
+	else
+		*tlr = max_count - cycles + 2;
+
+	return 0;
+}
+
+static bool xilinx_timer_pwm_enabled(u32 tcsr0, u32 tcsr1)
+{
+	return ((TCSR_PWM_MASK | TCSR_CASC) & tcsr0) == TCSR_PWM_SET &&
+		(TCSR_PWM_MASK & tcsr1) == TCSR_PWM_SET;
+}
+
+static int xilinx_timer_tlr_period(struct xilinx_timer_priv *priv, u32 *tlr,
+				   u32 tcsr, unsigned int period)
+{
+	u64 cycles = DIV_ROUND_DOWN_ULL((u64)period * clk_get_rate(priv->clk),
+					NSEC_PER_SEC);
+
+	return xilinx_timer_tlr_cycles(priv, tlr, tcsr, cycles);
+}
+
+static unsigned int xilinx_timer_get_period(struct xilinx_timer_priv *priv,
+					    u32 tlr, u32 tcsr)
+{
+	u64 cycles;
+
+	if (tcsr & TCSR_UDT)
+		cycles = tlr + 2;
+	else
+		cycles = xilinx_timer_max(priv) - tlr + 2;
+
+	return DIV_ROUND_UP_ULL(cycles * NSEC_PER_SEC,
+				clk_get_rate(priv->clk));
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
+static int xilinx_pwm_init(struct device *dev,
+			   struct xilinx_timer_priv *priv)
+{
+	int ret;
+
+	if (!dev)
+		return -EPROBE_DEFER;
+
+	priv->pwm.dev = dev;
+	priv->pwm.ops = &xilinx_pwm_ops;
+	priv->pwm.npwm = 1;
+	ret = pwmchip_add(&priv->pwm);
+	if (ret)
+		xilinx_timer_err(dev->of_node, ret,
+				 "could not register pwm chip\n");
+	return ret;
+}
+
+static irqreturn_t xilinx_timer_handler(int irq, void *dev)
+{
+	struct xilinx_timer_priv *priv = dev;
+	u32 tcsr1 = xilinx_timer_read(priv, TCSR1);
+
+	/* Acknowledge interrupt */
+	xilinx_timer_write(priv, tcsr1 | TCSR_TINT, TCSR1);
+	priv->ce.event_handler(&priv->ce);
+	return IRQ_HANDLED;
+}
+
+static int xilinx_clockevent_next_event(unsigned long evt,
+					struct clock_event_device *ce)
+{
+	struct xilinx_timer_priv *priv = xilinx_clockevent_to_priv(ce);
+
+	xilinx_timer_write(priv, evt, TLR1);
+	xilinx_timer_write(priv, TCSR_LOAD, TCSR1);
+	xilinx_timer_write(priv, TCSR_ENIT | TCSR_ENT, TCSR1);
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
+	xilinx_timer_write(priv, tlr1, TLR1);
+	xilinx_timer_write(priv, TCSR_LOAD, TCSR1);
+	xilinx_timer_write(priv, TCSR_ARHT | TCSR_ENIT | TCSR_ENT, TCSR1);
+	return 0;
+}
+
+static int xilinx_clockevent_shutdown(struct clock_event_device *ce)
+{
+	xilinx_timer_write(xilinx_clockevent_to_priv(ce), 0, TCSR1);
+	return 0;
+}
+
+static const struct clock_event_device xilinx_clockevent_base = {
+	.name = "xilinx_clockevent",
+	.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
+	.set_next_event = xilinx_clockevent_next_event,
+	.set_state_periodic = xilinx_clockevent_state_periodic,
+	.set_state_shutdown = xilinx_clockevent_shutdown,
+	.rating = 300,
+	.cpumask = cpu_possible_mask,
+	.owner = THIS_MODULE,
+};
+
+static int xilinx_clockevent_init(struct device_node *np,
+				  struct xilinx_timer_priv *priv)
+{
+	int ret = of_irq_get(np, 0);
+
+	if (ret < 0)
+		return xilinx_timer_err(np, ret, "could not get irq\n");
+
+	ret = request_irq(ret, xilinx_timer_handler, IRQF_TIMER,
+			  np->full_name, priv);
+	if (ret)
+		return xilinx_timer_err(np, ret, "could not request irq\n");
+
+	memcpy(&priv->ce, &xilinx_clockevent_base, sizeof(priv->ce));
+	clockevents_config_and_register(&priv->ce,
+					clk_get_rate(priv->clk), 2,
+					min_t(u64,
+					      xilinx_timer_max(priv) + 2,
+					      ULONG_MAX));
+	return 0;
+}
+
+static u64 xilinx_clocksource_read(struct clocksource *cs)
+{
+	return xilinx_timer_read(xilinx_clocksource_to_priv(cs), TCR0);
+}
+
+static const struct clocksource xilinx_clocksource_base = {
+	.read = xilinx_clocksource_read,
+	.name = "xilinx_clocksource",
+	.rating = 300,
+	.flags = CLOCK_SOURCE_IS_CONTINUOUS,
+	.owner = THIS_MODULE,
+};
+
+static int xilinx_clocksource_init(struct xilinx_timer_priv *priv)
+{
+	xilinx_timer_write(priv, 0, TLR0);
+	/* Load TLR and clear any interrupts */
+	xilinx_timer_write(priv, TCSR_LOAD | TCSR_TINT, TCSR0);
+	/* Start the timer counting up with auto-reload */
+	xilinx_timer_write(priv, TCSR_ARHT | TCSR_ENT, TCSR0);
+
+	memcpy(&priv->cs, &xilinx_clocksource_base, sizeof(priv->cs));
+	priv->cs.mask = xilinx_timer_max(priv);
+	return clocksource_register_hz(&priv->cs, clk_get_rate(priv->clk));
+}
+
+static struct clk *xilinx_timer_clock_init(struct device_node *np,
+					   struct xilinx_timer_priv *priv)
+{
+	int ret;
+	u32 freq;
+	struct clk_hw *hw;
+	struct clk *clk = of_clk_get_by_name(np, "s_axi_aclk");
+
+	if (!IS_ERR(clk) || PTR_ERR(clk) == -EPROBE_DEFER)
+		return clk;
+
+	pr_warn("%pOF: missing s_axi_aclk, falling back to clock-frequency\n",
+		np);
+	ret = of_property_read_u32(np, "clock-frequency", &freq);
+	if (ret) {
+#if IS_ENABLED(CONFIG_MICROBLAZE)
+		pr_warn("%pOF: missing clock-frequency, falling back to /cpus/timebase-frequency\n",
+			np);
+		freq = cpuinfo.cpu_clock_freq;
+#else
+		return ERR_PTR(ret);
+#endif
+	}
+
+	priv->flags |= XILINX_TIMER_CLK;
+	hw = __clk_hw_register_fixed_rate(NULL, np, "s_axi_aclk", NULL, NULL,
+					  NULL, 0, freq, 0, 0);
+	if (IS_ERR(hw))
+		return ERR_CAST(hw);
+	return hw->clk;
+}
+
+static struct xilinx_timer_priv *xilinx_timer_init(struct device *dev,
+						   struct device_node *np)
+{
+	bool pwm;
+	int i, ret;
+	struct xilinx_timer_priv *priv;
+	u32 one_timer, tcsr0;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return ERR_PTR(-ENOMEM);
+
+	priv->regs = of_iomap(np, 0);
+	if (!priv->regs) {
+		ret = -ENXIO;
+		goto err_priv;
+	} else if (IS_ERR(priv->regs)) {
+		ret = PTR_ERR(priv->regs);
+		goto err_priv;
+	}
+
+	priv->read = ioread32;
+	priv->write = iowrite32;
+	/*
+	 * We aren't using the interrupts yet, so use ENIT to detect endianness
+	 */
+	tcsr0 = xilinx_timer_read(priv, TCSR0);
+	if (swab32(tcsr0) & TCSR_ENIT) {
+		ret = xilinx_timer_err(np, -EOPNOTSUPP,
+				       "cannot determine endianness\n");
+		goto err_priv;
+	}
+
+	xilinx_timer_write(priv, tcsr0 | TCSR_ENIT, TCSR0);
+	if (!(xilinx_timer_read(priv, TCSR0) & TCSR_ENIT)) {
+		priv->read = xilinx_ioread32be;
+		priv->write = xilinx_iowrite32be;
+	}
+
+	/*
+	 * For backwards compatibility, allow xlnx,one-timer-only = <bool>;
+	 * However, the preferred way is to use the xlnx,single-timer flag.
+	 */
+	one_timer = of_property_read_bool(np, "xlnx,single-timer");
+	if (!one_timer) {
+		ret = of_property_read_u32(np, "xlnx,one-timer-only", &one_timer);
+		if (ret) {
+			ret = xilinx_timer_err(np, ret, "xlnx,one-timer-only");
+			goto err_priv;
+		}
+	}
+
+	pwm = of_property_read_bool(np, "xlnx,pwm");
+	if (one_timer && pwm) {
+		ret = xilinx_timer_err(np, -EINVAL,
+				       "pwm mode not possible with one timer\n");
+		goto err_priv;
+	}
+
+	priv->flags = FIELD_PREP(XILINX_TIMER_ONE, one_timer) |
+		      FIELD_PREP(XILINX_TIMER_PWM, pwm);
+
+	for (i = 0; pwm && i < 2; i++) {
+		char int_fmt[] = "xlnx,gen%u-assert";
+		char bool_fmt[] = "xlnx,gen%u-active-low";
+		char buf[max(sizeof(int_fmt), sizeof(bool_fmt))];
+		u32 gen;
+
+		/*
+		 * Allow xlnx,gen?-assert = <bool>; for backwards
+		 * compatibility. However, the preferred way is to use the
+		 * xlnx,gen?-active-low flag.
+		 */
+		snprintf(buf, sizeof(buf), bool_fmt, i);
+		gen = !of_property_read_bool(np, buf);
+		if (gen) {
+			snprintf(buf, sizeof(buf), int_fmt, i);
+			ret = of_property_read_u32(np, buf, &gen);
+			if (ret && ret != -EINVAL) {
+				xilinx_timer_err(np, ret, "%s\n", buf);
+				goto err_priv;
+			}
+		}
+
+		if (!gen) {
+			ret = xilinx_timer_err(np, -EINVAL,
+					       "generateout%u must be active high\n",
+					       i);
+			goto err_priv;
+		}
+	}
+
+	ret = of_property_read_u32(np, "xlnx,count-width", &priv->width);
+	if (ret) {
+		xilinx_timer_err(np, ret, "xlnx,count-width\n");
+		goto err_priv;
+	} else if (priv->width < 8 || priv->width > 32) {
+		ret = xilinx_timer_err(np, -EINVAL, "invalid counter width\n");
+		goto err_priv;
+	}
+
+	priv->clk = xilinx_timer_clock_init(np, priv);
+	if (IS_ERR(priv->clk)) {
+		ret = xilinx_timer_err(np, PTR_ERR(priv->clk), "clock\n");
+		goto err_priv;
+	}
+
+	ret = clk_prepare_enable(priv->clk);
+	if (ret) {
+		xilinx_timer_err(np, ret, "clock enable failed\n");
+		goto err_clk;
+	}
+	clk_rate_exclusive_get(priv->clk);
+
+	if (pwm) {
+		ret = xilinx_pwm_init(dev, priv);
+	} else {
+		ret = xilinx_clocksource_init(priv);
+		if (!ret && !one_timer) {
+			ret = xilinx_clockevent_init(np, priv);
+			if (ret)
+				priv->flags |= XILINX_TIMER_ONE;
+		}
+	}
+
+	if (!ret)
+		return priv;
+
+	clk_rate_exclusive_put(priv->clk);
+	clk_disable_unprepare(priv->clk);
+err_clk:
+	if (priv->flags & XILINX_TIMER_CLK)
+		clk_unregister_fixed_rate(priv->clk);
+	else
+		clk_put(priv->clk);
+err_priv:
+	kfree(priv);
+	return ERR_PTR(ret);
+}
+
+static int xilinx_timer_probe(struct platform_device *pdev)
+{
+	struct xilinx_timer_priv *priv =
+		xilinx_timer_init(&pdev->dev, pdev->dev.of_node);
+
+	if (IS_ERR(priv))
+		return PTR_ERR(priv);
+
+	platform_set_drvdata(pdev, priv);
+	return 0;
+}
+
+static int xilinx_timer_remove(struct platform_device *pdev)
+{
+	struct xilinx_timer_priv *priv = platform_get_drvdata(pdev);
+
+	if (IS_ENABLED(CONFIG_XILINX_PWM) && priv->flags & XILINX_TIMER_PWM) {
+		pwmchip_remove(&priv->pwm);
+	} else {
+		if (!(priv->flags & XILINX_TIMER_ONE)) {
+			int cpu;
+
+			for_each_cpu(cpu, priv->ce.cpumask)
+				clockevents_unbind_device(&priv->ce, cpu);
+		}
+		clocksource_unregister(&priv->cs);
+	}
+
+	clk_rate_exclusive_put(priv->clk);
+	clk_disable_unprepare(priv->clk);
+	if (priv->flags & XILINX_TIMER_CLK)
+		clk_unregister_fixed_rate(priv->clk);
+	else
+		clk_put(priv->clk);
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
+static struct xilinx_timer_priv *xilinx_sched = (void *)-EAGAIN;
+
+static u64 xilinx_sched_read(void)
+{
+	return xilinx_timer_read(xilinx_sched, TCSR0);
+}
+
+static int __init xilinx_timer_register(struct device_node *np)
+{
+	struct xilinx_timer_priv *priv;
+
+	if (xilinx_sched != ERR_PTR(-EAGAIN))
+		return -EPROBE_DEFER;
+
+	priv = xilinx_timer_init(NULL, np);
+	if (IS_ERR(priv))
+		return PTR_ERR(priv);
+	of_node_set_flag(np, OF_POPULATED);
+
+	xilinx_sched = priv;
+	sched_clock_register(xilinx_sched_read, priv->width,
+			     clk_get_rate(priv->clk));
+	return 0;
+}
+
+TIMER_OF_DECLARE(xilinx_xps_timer, "xlnx,xps-timer-1.00.a", xilinx_timer_register);
+TIMER_OF_DECLARE(xilinx_axi_timer, "xlnx,axi-timer-2.0", xilinx_timer_register);
+
+MODULE_ALIAS("platform:xilinx-timer");
+MODULE_DESCRIPTION("Xilinx LogiCORE IP AXI Timer driver");
+MODULE_LICENSE("GPL v2");
-- 
2.25.1

