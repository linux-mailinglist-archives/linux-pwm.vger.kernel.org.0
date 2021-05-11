Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E714C37AF3C
	for <lists+linux-pwm@lfdr.de>; Tue, 11 May 2021 21:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbhEKTUV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 11 May 2021 15:20:21 -0400
Received: from mail-eopbgr80072.outbound.protection.outlook.com ([40.107.8.72]:46852
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231917AbhEKTUU (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 11 May 2021 15:20:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mR83+pyQEqj7cd7SU62KLDmC16pMkFBtQuBBJAPiuqnr6oFD5tv5dGzLUgifRvEIh1q6VEC3K6uIcmvAo5fy8YE7fOW2eTs5OyWhJC+DXd1LuTFYLWiS/omCmGtcmi9WDiFOdi2FoAsui6NM/bKVyYaLbxhunigTQD4vgoSwFs9srljd4UbcQ4uj4igmJj4BjnFlGdwDq5VVrr6JzyWyizAh3WijXEbh7stRuSkstF4m+7ITUp7T/GfVyq34Tz3a2sqN8rvQNPudvhQrNelgB+hBXf/sqXRN9aoYFSsYIKrEu247+eZcTDXb8UL2q2GxJHMgd2z0zSJO75KFPq3PXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZwpOydGPs8aow4mYD9hG8LSlJ/2PWKfCSm5ICqZWeI=;
 b=kgiNOZdgBTU96Y/d2WBGTPuQy430DXntEKS5h66IVwe5hMK6DjjqMjK0QOUDLR2YWpGSm2tpES14wJ4PnaMv342Oryvqd7erfrFbRzgM37ZPZWOLh++WSGB3+kjIo62JTAwh8ZMN0oSkNtSadGdI94uFUFY0KzAqugRgSw8NGqT/PosPzlxfLCZNcPUy9rCObFeDpLKv8H7T8aaEz2dpEmeojGCjzrcPHzJGMYR2VTeYRcW4pQxBvTxMTkMRTu5sGbh2/tY3CuX4+B6MGiaZNjAqnS5+EX9xyBlDFXZm05QRoLtFGrJRUU/28io8dRqCEO3ZbK8jeY6GQtU/g/i2yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZwpOydGPs8aow4mYD9hG8LSlJ/2PWKfCSm5ICqZWeI=;
 b=BmrnlawxUA/XuFHozZlS1QmvSXmebmaEDEThtm2+prZ7xA+WvaPUPpFb9m3thFEu79PRzyEoihFyNuAruycc6H/2qHGT2ICRWwxCMj7GQhHF5o0g+sYxV8ZYWesJKDjiKtcgmVUbeXZzKSLYbLH4OaKRfJAIhesHfJKUJRweEc0=
Authentication-Results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB8PR03MB6332.eurprd03.prod.outlook.com (2603:10a6:10:13d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Tue, 11 May
 2021 19:19:09 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b%5]) with mapi id 15.20.4108.032; Tue, 11 May 2021
 19:19:09 +0000
Subject: Re: [PATCH v3 2/2] clocksource: Add support for Xilinx AXI Timer
To:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     michal.simek@xilinx.com, Alvaro Gamez <alvaro.gamez@hazent.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
References: <20210511191239.774570-1-sean.anderson@seco.com>
 <20210511191239.774570-2-sean.anderson@seco.com>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <44b8c4d5-01e9-53c2-f28d-9f46cee77ddb@seco.com>
Date:   Tue, 11 May 2021 15:19:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210511191239.774570-2-sean.anderson@seco.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.195.82.171]
X-ClientProxiedBy: BL1PR13CA0068.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::13) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.1.65] (50.195.82.171) by BL1PR13CA0068.namprd13.prod.outlook.com (2603:10b6:208:2b8::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.20 via Frontend Transport; Tue, 11 May 2021 19:19:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50ae4005-c97a-4617-6141-08d914b1a6d0
X-MS-TrafficTypeDiagnostic: DB8PR03MB6332:
X-Microsoft-Antispam-PRVS: <DB8PR03MB6332AF1302F93846FCC5C5A796539@DB8PR03MB6332.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tMY4m7CeN2G5MNuw1o/bU2hjmiRXd4uxFre17xfRvswdjHYuolrodWxnzUbPjcadIGQjIeRVmBa1ttLDcddD82mqOYPKAr8Bl3SOLgiIOsyeCW71u15qLbnUMJAzu9HKybsUUjRSuWV8pnyWhY3wB3Vq+T4RzrmPtobEo4n8+pOvkwolG2vy80s6EfR7RHu8ho6bFmXVvrnyL222GA3HJ3rQiAZLvZjo0of0uC8FoiLop7UUuui1J+k8Shedo8qUTiuzvPUUzIMeJLiyPZjezaGH4c0462aPMQW/uYEKTXVxar84ZhW6iAD2L5WnWGVnR46bM3RwyM3iEbV5wzh2KqMYRRllMFRamey9DrzwEQXBz9p1VGVzz9B1W3+xRaeqWa9bin1iQJBpIL/gmEIJLRiBUDYzyaeqSPh10qYnq0qYA5ubV9p/0zvHWu4acLCZVv4ewXWFazBU/kJQtJ7aI7l6vqBPMksrnq3Lpz/+AwUfmSZO5sJZJeCoS68RSgVgaAyee17CgVn/2ZKEknoqPtOijvwuKl7+SK8KDUPijorpH2TzJeZamBt3488kBJa3tmyXzGei55LgydpN7mdRwmhZL7lPhSb1Cj6LbM++HiSOCNi9PDwVN6WqFjEYnlKbEHKPl2avrAQK6RqNplTw/2JzmRkqTwbinuaWFFGcTDoCjyzFo5zaHdVpgzurW6VoSojmu8f44H2xCR8fECqh8HIKyMC2OGUDGa1uyiZ4bS/vf81k2GVwJ8P+ab8V3T/u/JpPiiMEf39b4j0uQvdy4+iRjuuHDYa7IoIo9TgsCAo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31696002)(53546011)(83380400001)(54906003)(6666004)(7416002)(36756003)(44832011)(16576012)(86362001)(31686004)(5660300002)(38350700002)(4326008)(30864003)(498600001)(2616005)(2906002)(186003)(16526019)(26005)(956004)(8936002)(8676002)(6486002)(966005)(66476007)(66556008)(66946007)(38100700002)(52116002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?K2xqOFhqVkh1NHRwS0M3YnJpQ1lmVExEOVFXWUMxSEt4MTgvYXBGL215RXZP?=
 =?utf-8?B?dWhOcmp6ZFB0YnlJOElsVVk0UFF1ZFd0SklrYWxnWjFBMkZ6TWY0UTE0azBh?=
 =?utf-8?B?RFhZODBlb0puM3A3bHFFTmZGbS9MMHdaSEJRZEVEck1hdXMrbXZuYm9qUmJG?=
 =?utf-8?B?NWxIenBHbjhzQy9DTzdKQTlOUnBhd0IreGw3S2pMUUFhNGVXRU1LMW5vdXFu?=
 =?utf-8?B?YTJsRDFPbWQ4Yjg0S3cwbzA1d01wN1pkUGpyQ05aVnZBSFE0R2xKbG1keUxB?=
 =?utf-8?B?MncxT08wSWEvREtLNTR1R1l4UXBpSW9pbWUxYlJ2c2FnK1ZpZkR5OEZTZGhs?=
 =?utf-8?B?VzFEQU8ySm9oMVp5Mi9INGo4aTBQb2Q5bVoyWk84TXRKTTlLOUNMWTRKVThC?=
 =?utf-8?B?ZE1zd20rMlBXRnA1clgvSDQyNDZsRGgvdTZwY3R0LzhYWDI4MkxpS3JDNUFp?=
 =?utf-8?B?clFnNUNNcURWUkR4ZHM5Y09oOHI0NnJ5Y0lPMDRGamJlV0xCbHhVYkF5REZ6?=
 =?utf-8?B?NndibU5HbFdEM3Y5bDFsNjdCR0l2dFhJai9YUG1FbzlYQ21QS1VIMUYwTTBr?=
 =?utf-8?B?WkRUTnpIekE2SVZ3dFpWelkxdDhFSnhuSHR6RXI4MWFKQnppRjFydXBPMjl3?=
 =?utf-8?B?VmVZbTljaUt0Sk5QNHpRcDNSbDJpdEdQT2IzMWZjNUlXUEp2NkxjNVU1YkY1?=
 =?utf-8?B?a3EzUlFyVmhJTklpRmN2VDRQaDczbVdrMzBhdlFiQnExaGQ3NGxzdUtHdzEv?=
 =?utf-8?B?emM5Q2dQblJ2dyt4dHFDZkpxcTN6LzJhZ3FwWFlPaithMnUybWE1R01MenFD?=
 =?utf-8?B?T1ZubEEzWjRrdG9ERGtWanlZUlozd0g2Z09iNnowOWtKK3JZUGdXWHRoZjZ0?=
 =?utf-8?B?MnVQMXN5K0VGVmZESGtNYit6NzN6dWpCdExaNGdQamZobUdMb1JwQUszZ040?=
 =?utf-8?B?YjdkbmQ0NENwVytOb25mMDk3WWdkNjRXbDBRb3BQdUNZbWN3WCtKZnYwNjVo?=
 =?utf-8?B?ME5aSjFuazA5czFCZU9qS3FQeHlPL3Ird3A3ckhKSWNBcXpDZ2hmNGk1Y3Zh?=
 =?utf-8?B?RHhnOHNkV0VaaG1UM0lMNktlSkRGM3JrVUxXdXFtaVFaLzhMbWV3RkNPbjI4?=
 =?utf-8?B?V0Y4S1BjZFNtN3MvM1A5Z3dGZWtac3ptRlBPL2pqSE9RRTNmVWZUYVVIU1BY?=
 =?utf-8?B?eXZDNGVWTW1XVDNWckE0ZHVwa3VpRU5tamtDV1N6bm1PbXRQN3pBOG4rcXJM?=
 =?utf-8?B?Si9yZklBVHVEMU9pdGQ3ZjhGMkdxZTBHcjRGbkQyUmF3TmRuVVFyOEZpM2xz?=
 =?utf-8?B?QUdlaFdSRGlKd1ppMml4NkxFdXI1OG8xQm96V3F1Y3JVRHlhbGxZejA3L0pn?=
 =?utf-8?B?WDZGNmxmejYrYW11cHk3YUc3enVDTXJNTXNHSEJrQnNDV1N6eG5oMFBwdkc5?=
 =?utf-8?B?UTREd1lyR0U4YVZsRGNDOXpMdkZOR1pFYnhVU1VTbU9pazR6M2pIenB0WDdZ?=
 =?utf-8?B?eVJZeHppM2F4V0YvY0x1Y3FhS080ekx4bkptQU1uVXFadHBEbjg1SGNGSnRw?=
 =?utf-8?B?TzJHUHNLaXdBM21yM2dMN0FteGNWVlAyczFtMzhyTnRpS2t1bUVOS0xRNXVG?=
 =?utf-8?B?aitNbThXdnhWUmM2MzM4Z3ZHRXhBYkN3czYzTyt2a3hXRFY3SFVab0dtMlln?=
 =?utf-8?B?K3I1aWVEcU9JSEh0dGkvR0RlVUlqN09VU0hEemMySENqV0tMZS9PWHgrRldK?=
 =?utf-8?Q?KeqCZlTuDs2vVN5uYNXjlOpC8cL8veCqLYhcW8U?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50ae4005-c97a-4617-6141-08d914b1a6d0
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2021 19:19:09.2305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dWRGaN/JgyFQiq62lA25WazUg3WWTVfGCWWw3N2rStjXnDQcmZuvk8OhA9dNIG93uN3xwf4422z+19NQhhEbTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR03MB6332
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 5/11/21 3:12 PM, Sean Anderson wrote:
> This adds generic clocksource and clockevent support for Xilinx LogiCORE IP
> AXI soft timers commonly found on Xilinx FPGAs. This timer is also the
> primary timer for Microblaze processors. This commit also adds support for
> configuring this timer as a PWM (though this could be split off if
> necessary). This whole driver lives in clocksource because it is primarily
> clocksource stuff now (even though it started out as a PWM driver). I think
> teasing apart the driver would not be worth it since they share so many
> functions.
> 
> This driver configures timer 0 (which is always present) as a clocksource,
> and timer 1 (which might be missing) as a clockevent. I don't know if this
> is the correct priority for these timers, or whether we should be using a
> more dynamic allocation scheme.
> 
> At the moment clock control is very basic: we just enable the clock during
> probe and pin the frequency. In the future, someone could add support for
> disabling the clock when not in use. Cascade mode is also unsupported.
> 
> This driver was written with reference to Xilinx DS764 for v1.03.a [1].
> 
> [1] https://www.xilinx.com/support/documentation/ip_documentation/axi_timer/v1_03_a/axi_timer_ds764.pdf
> 
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> ---
> Please let me know if I should organize this differently or if it should
> be broken up.
> 
> Changes in v3:
> - Add clockevent and clocksource support
> - Rewrite probe to only use a device_node, since timers may need to be
>    initialized before we have proper devices. This does bloat the code a bit
>    since we can no longer rely on helpers such as dev_err_probe. We also
>    cannot rely on device resources being free'd on failure, so we must free
>    them manually.
> - We now access registers through xilinx_timer_(read|write). This allows us
>    to deal with endianness issues, as originally seen in the microblaze
>    driver. CAVEAT EMPTOR: I have not tested this on big-endian!
> - Remove old microblaze driver
> 
> Changes in v2:
> - Don't compile this module by default for arm64
> - Add dependencies on COMMON_CLK and HAS_IOMEM
> - Add comment explaining why we depend on !MICROBLAZE
> - Add comment describing device
> - Rename TCSR_(SET|CLEAR) to TCSR_RUN_(SET|CLEAR)
> - Use NSEC_TO_SEC instead of defining our own
> - Use TCSR_RUN_MASK to check if the PWM is enabled, as suggested by Uwe
> - Cast dividends to u64 to avoid overflow
> - Check for over- and underflow when calculating TLR
> - Set xilinx_pwm_ops.owner
> - Don't set pwmchip.base to -1
> - Check range of xlnx,count-width
> - Ensure the clock is always running when the pwm is registered
> - Remove debugfs file :l
> - Report errors with dev_error_probe
> 
>   arch/microblaze/kernel/Makefile    |   2 +-
>   arch/microblaze/kernel/timer.c     | 326 ---------------
>   drivers/clocksource/Kconfig        |  15 +
>   drivers/clocksource/Makefile       |   1 +
>   drivers/clocksource/timer-xilinx.c | 650 +++++++++++++++++++++++++++++
>   5 files changed, 667 insertions(+), 327 deletions(-)
>   delete mode 100644 arch/microblaze/kernel/timer.c
>   create mode 100644 drivers/clocksource/timer-xilinx.c
> 
> diff --git a/arch/microblaze/kernel/Makefile b/arch/microblaze/kernel/Makefile
> index 15a20eb814ce..986b1f21d90e 100644
> --- a/arch/microblaze/kernel/Makefile
> +++ b/arch/microblaze/kernel/Makefile
> @@ -17,7 +17,7 @@ extra-y := head.o vmlinux.lds
>   obj-y += dma.o exceptions.o \
>   	hw_exception_handler.o irq.o \
>   	process.o prom.o ptrace.o \
> -	reset.o setup.o signal.o sys_microblaze.o timer.o traps.o unwind.o
> +	reset.o setup.o signal.o sys_microblaze.o traps.o unwind.o
>   
>   obj-y += cpu/
>   
> diff --git a/arch/microblaze/kernel/timer.c b/arch/microblaze/kernel/timer.c
> deleted file mode 100644
> index f8832cf49384..000000000000
> --- a/arch/microblaze/kernel/timer.c
> +++ /dev/null
> @@ -1,326 +0,0 @@
> -/*
> - * Copyright (C) 2007-2013 Michal Simek <monstr@monstr.eu>
> - * Copyright (C) 2012-2013 Xilinx, Inc.
> - * Copyright (C) 2007-2009 PetaLogix
> - * Copyright (C) 2006 Atmark Techno, Inc.
> - *
> - * This file is subject to the terms and conditions of the GNU General Public
> - * License. See the file "COPYING" in the main directory of this archive
> - * for more details.
> - */
> -
> -#include <linux/interrupt.h>
> -#include <linux/delay.h>
> -#include <linux/sched.h>
> -#include <linux/sched/clock.h>
> -#include <linux/sched_clock.h>
> -#include <linux/clk.h>
> -#include <linux/clockchips.h>
> -#include <linux/of_address.h>
> -#include <linux/of_irq.h>
> -#include <linux/timecounter.h>
> -#include <asm/cpuinfo.h>
> -
> -static void __iomem *timer_baseaddr;
> -
> -static unsigned int freq_div_hz;
> -static unsigned int timer_clock_freq;
> -
> -#define TCSR0	(0x00)
> -#define TLR0	(0x04)
> -#define TCR0	(0x08)
> -#define TCSR1	(0x10)
> -#define TLR1	(0x14)
> -#define TCR1	(0x18)
> -
> -#define TCSR_MDT	(1<<0)
> -#define TCSR_UDT	(1<<1)
> -#define TCSR_GENT	(1<<2)
> -#define TCSR_CAPT	(1<<3)
> -#define TCSR_ARHT	(1<<4)
> -#define TCSR_LOAD	(1<<5)
> -#define TCSR_ENIT	(1<<6)
> -#define TCSR_ENT	(1<<7)
> -#define TCSR_TINT	(1<<8)
> -#define TCSR_PWMA	(1<<9)
> -#define TCSR_ENALL	(1<<10)
> -
> -static unsigned int (*read_fn)(void __iomem *);
> -static void (*write_fn)(u32, void __iomem *);
> -
> -static void timer_write32(u32 val, void __iomem *addr)
> -{
> -	iowrite32(val, addr);
> -}
> -
> -static unsigned int timer_read32(void __iomem *addr)
> -{
> -	return ioread32(addr);
> -}
> -
> -static void timer_write32_be(u32 val, void __iomem *addr)
> -{
> -	iowrite32be(val, addr);
> -}
> -
> -static unsigned int timer_read32_be(void __iomem *addr)
> -{
> -	return ioread32be(addr);
> -}
> -
> -static inline void xilinx_timer0_stop(void)
> -{
> -	write_fn(read_fn(timer_baseaddr + TCSR0) & ~TCSR_ENT,
> -		 timer_baseaddr + TCSR0);
> -}
> -
> -static inline void xilinx_timer0_start_periodic(unsigned long load_val)
> -{
> -	if (!load_val)
> -		load_val = 1;
> -	/* loading value to timer reg */
> -	write_fn(load_val, timer_baseaddr + TLR0);
> -
> -	/* load the initial value */
> -	write_fn(TCSR_LOAD, timer_baseaddr + TCSR0);
> -
> -	/* see timer data sheet for detail
> -	 * !ENALL - don't enable 'em all
> -	 * !PWMA - disable pwm
> -	 * TINT - clear interrupt status
> -	 * ENT- enable timer itself
> -	 * ENIT - enable interrupt
> -	 * !LOAD - clear the bit to let go
> -	 * ARHT - auto reload
> -	 * !CAPT - no external trigger
> -	 * !GENT - no external signal
> -	 * UDT - set the timer as down counter
> -	 * !MDT0 - generate mode
> -	 */
> -	write_fn(TCSR_TINT|TCSR_ENIT|TCSR_ENT|TCSR_ARHT|TCSR_UDT,
> -		 timer_baseaddr + TCSR0);
> -}
> -
> -static inline void xilinx_timer0_start_oneshot(unsigned long load_val)
> -{
> -	if (!load_val)
> -		load_val = 1;
> -	/* loading value to timer reg */
> -	write_fn(load_val, timer_baseaddr + TLR0);
> -
> -	/* load the initial value */
> -	write_fn(TCSR_LOAD, timer_baseaddr + TCSR0);
> -
> -	write_fn(TCSR_TINT|TCSR_ENIT|TCSR_ENT|TCSR_ARHT|TCSR_UDT,
> -		 timer_baseaddr + TCSR0);
> -}
> -
> -static int xilinx_timer_set_next_event(unsigned long delta,
> -					struct clock_event_device *dev)
> -{
> -	pr_debug("%s: next event, delta %x\n", __func__, (u32)delta);
> -	xilinx_timer0_start_oneshot(delta);
> -	return 0;
> -}
> -
> -static int xilinx_timer_shutdown(struct clock_event_device *evt)
> -{
> -	pr_info("%s\n", __func__);
> -	xilinx_timer0_stop();
> -	return 0;
> -}
> -
> -static int xilinx_timer_set_periodic(struct clock_event_device *evt)
> -{
> -	pr_info("%s\n", __func__);
> -	xilinx_timer0_start_periodic(freq_div_hz);
> -	return 0;
> -}
> -
> -static struct clock_event_device clockevent_xilinx_timer = {
> -	.name			= "xilinx_clockevent",
> -	.features		= CLOCK_EVT_FEAT_ONESHOT |
> -				  CLOCK_EVT_FEAT_PERIODIC,
> -	.shift			= 8,
> -	.rating			= 300,
> -	.set_next_event		= xilinx_timer_set_next_event,
> -	.set_state_shutdown	= xilinx_timer_shutdown,
> -	.set_state_periodic	= xilinx_timer_set_periodic,
> -};
> -
> -static inline void timer_ack(void)
> -{
> -	write_fn(read_fn(timer_baseaddr + TCSR0), timer_baseaddr + TCSR0);
> -}
> -
> -static irqreturn_t timer_interrupt(int irq, void *dev_id)
> -{
> -	struct clock_event_device *evt = &clockevent_xilinx_timer;
> -	timer_ack();
> -	evt->event_handler(evt);
> -	return IRQ_HANDLED;
> -}
> -
> -static __init int xilinx_clockevent_init(void)
> -{
> -	clockevent_xilinx_timer.mult =
> -		div_sc(timer_clock_freq, NSEC_PER_SEC,
> -				clockevent_xilinx_timer.shift);
> -	clockevent_xilinx_timer.max_delta_ns =
> -		clockevent_delta2ns((u32)~0, &clockevent_xilinx_timer);
> -	clockevent_xilinx_timer.max_delta_ticks = (u32)~0;
> -	clockevent_xilinx_timer.min_delta_ns =
> -		clockevent_delta2ns(1, &clockevent_xilinx_timer);
> -	clockevent_xilinx_timer.min_delta_ticks = 1;
> -	clockevent_xilinx_timer.cpumask = cpumask_of(0);
> -	clockevents_register_device(&clockevent_xilinx_timer);
> -
> -	return 0;
> -}
> -
> -static u64 xilinx_clock_read(void)
> -{
> -	return read_fn(timer_baseaddr + TCR1);
> -}
> -
> -static u64 xilinx_read(struct clocksource *cs)
> -{
> -	/* reading actual value of timer 1 */
> -	return (u64)xilinx_clock_read();
> -}
> -
> -static struct timecounter xilinx_tc = {
> -	.cc = NULL,
> -};
> -
> -static u64 xilinx_cc_read(const struct cyclecounter *cc)
> -{
> -	return xilinx_read(NULL);
> -}
> -
> -static struct cyclecounter xilinx_cc = {
> -	.read = xilinx_cc_read,
> -	.mask = CLOCKSOURCE_MASK(32),
> -	.shift = 8,
> -};
> -
> -static int __init init_xilinx_timecounter(void)
> -{
> -	xilinx_cc.mult = div_sc(timer_clock_freq, NSEC_PER_SEC,
> -				xilinx_cc.shift);
> -
> -	timecounter_init(&xilinx_tc, &xilinx_cc, sched_clock());
> -
> -	return 0;
> -}
> -
> -static struct clocksource clocksource_microblaze = {
> -	.name		= "xilinx_clocksource",
> -	.rating		= 300,
> -	.read		= xilinx_read,
> -	.mask		= CLOCKSOURCE_MASK(32),
> -	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
> -};
> -
> -static int __init xilinx_clocksource_init(void)
> -{
> -	int ret;
> -
> -	ret = clocksource_register_hz(&clocksource_microblaze,
> -				      timer_clock_freq);
> -	if (ret) {
> -		pr_err("failed to register clocksource");
> -		return ret;
> -	}
> -
> -	/* stop timer1 */
> -	write_fn(read_fn(timer_baseaddr + TCSR1) & ~TCSR_ENT,
> -		 timer_baseaddr + TCSR1);
> -	/* start timer1 - up counting without interrupt */
> -	write_fn(TCSR_TINT|TCSR_ENT|TCSR_ARHT, timer_baseaddr + TCSR1);
> -
> -	/* register timecounter - for ftrace support */
> -	return init_xilinx_timecounter();
> -}
> -
> -static int __init xilinx_timer_init(struct device_node *timer)
> -{
> -	struct clk *clk;
> -	static int initialized;
> -	u32 irq;
> -	u32 timer_num = 1;
> -	int ret;
> -
> -	if (initialized)
> -		return -EINVAL;
> -
> -	initialized = 1;
> -
> -	timer_baseaddr = of_iomap(timer, 0);
> -	if (!timer_baseaddr) {
> -		pr_err("ERROR: invalid timer base address\n");
> -		return -ENXIO;
> -	}
> -
> -	write_fn = timer_write32;
> -	read_fn = timer_read32;
> -
> -	write_fn(TCSR_MDT, timer_baseaddr + TCSR0);
> -	if (!(read_fn(timer_baseaddr + TCSR0) & TCSR_MDT)) {
> -		write_fn = timer_write32_be;
> -		read_fn = timer_read32_be;
> -	}
> -
> -	irq = irq_of_parse_and_map(timer, 0);
> -	if (irq <= 0) {
> -		pr_err("Failed to parse and map irq");
> -		return -EINVAL;
> -	}
> -
> -	of_property_read_u32(timer, "xlnx,one-timer-only", &timer_num);
> -	if (timer_num) {
> -		pr_err("Please enable two timers in HW\n");
> -		return -EINVAL;
> -	}
> -
> -	pr_info("%pOF: irq=%d\n", timer, irq);
> -
> -	clk = of_clk_get(timer, 0);
> -	if (IS_ERR(clk)) {
> -		pr_err("ERROR: timer CCF input clock not found\n");
> -		/* If there is clock-frequency property than use it */
> -		of_property_read_u32(timer, "clock-frequency",
> -				    &timer_clock_freq);
> -	} else {
> -		timer_clock_freq = clk_get_rate(clk);
> -	}
> -
> -	if (!timer_clock_freq) {
> -		pr_err("ERROR: Using CPU clock frequency\n");
> -		timer_clock_freq = cpuinfo.cpu_clock_freq;
> -	}
> -
> -	freq_div_hz = timer_clock_freq / HZ;
> -
> -	ret = request_irq(irq, timer_interrupt, IRQF_TIMER, "timer",
> -			  &clockevent_xilinx_timer);
> -	if (ret) {
> -		pr_err("Failed to setup IRQ");
> -		return ret;
> -	}
> -
> -	ret = xilinx_clocksource_init();
> -	if (ret)
> -		return ret;
> -
> -	ret = xilinx_clockevent_init();
> -	if (ret)
> -		return ret;
> -
> -	sched_clock_register(xilinx_clock_read, 32, timer_clock_freq);
> -
> -	return 0;
> -}
> -
> -TIMER_OF_DECLARE(xilinx_timer, "xlnx,xps-timer-1.00.a",
> -		       xilinx_timer_init);
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 39aa21d01e05..35c95671d242 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -693,4 +693,19 @@ config MICROCHIP_PIT64B
>   	  modes and high resolution. It is used as a clocksource
>   	  and a clockevent.
>   
> +config XILINX_TIMER
> +	tristate "Xilinx AXI Timer support"
> +	depends on HAS_IOMEM && COMMON_CLK
> +	default y if MICROBLAZE
> +	help
> +	  Clocksource, clockevent, and PWM drivers for Xilinx LogiCORE
> +	  IP AXI Timers. This timer is typically a soft core which may
> +	  be present in Xilinx FPGAs. This device may also be present in
> +	  Microblaze soft processors. If you don't have this IP in your
> +	  design, choose N.
> +
> +	  To use this device as the primary clocksource for your system,
> +	  choose Y here. Otherwise, this driver will not be available
> +	  early enough during boot. To compile this driver as a module,
> +	  choose M here: the module will be called timer-xilinx.
>   endmenu
> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> index c17ee32a7151..717f01c0ac41 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -58,6 +58,7 @@ obj-$(CONFIG_MILBEAUT_TIMER)	+= timer-milbeaut.o
>   obj-$(CONFIG_SPRD_TIMER)	+= timer-sprd.o
>   obj-$(CONFIG_NPCM7XX_TIMER)	+= timer-npcm7xx.o
>   obj-$(CONFIG_RDA_TIMER)		+= timer-rda.o
> +obj-$(CONFIG_XILINX_TIMER)	+= timer-xilinx.o
>   
>   obj-$(CONFIG_ARC_TIMERS)		+= arc_timer.o
>   obj-$(CONFIG_ARM_ARCH_TIMER)		+= arm_arch_timer.o
> diff --git a/drivers/clocksource/timer-xilinx.c b/drivers/clocksource/timer-xilinx.c
> new file mode 100644
> index 000000000000..b410c6af9c63
> --- /dev/null
> +++ b/drivers/clocksource/timer-xilinx.c
> @@ -0,0 +1,650 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2021 Sean Anderson <sean.anderson@seco.com>
> + *
> + * For Xilinx LogiCORE IP AXI Timer documentation, refer to DS764:
> + * https://www.xilinx.com/support/documentation/ip_documentation/axi_timer/v1_03_a/axi_timer_ds764.pdf
> + *
> + * Hardware limitations:
> + * - When in cascade mode we cannot read the full 64-bit counter in one go
> + * - When changing both duty cycle and period, we may end up with one cycle
> + *   with the old duty cycle and the new period.
> + * - Cannot produce 100% duty cycle.
> + * - Only produces "normal" output.
> + */
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/clockchips.h>
> +#include <linux/clocksource.h>
> +#include <linux/device.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/sched_clock.h>
> +#include <asm/io.h>
> +#if IS_ENABLED(CONFIG_MICROBLAZE)
> +#include <asm/cpuinfo.h>
> +#endif
> +
> +/* A replacement for dev_err_probe, since we don't always have a device */
> +#define xilinx_timer_err(np, err, fmt, ...) ({ \
> +	pr_err("%pOF: error %d: " fmt, (np), (int)(err), ##__VA_ARGS__); \
> +	err; \
> +})
> +
> +#define TCSR0	0x00
> +#define TLR0	0x04
> +#define TCR0	0x08
> +#define TCSR1	0x10
> +#define TLR1	0x14
> +#define TCR1	0x18
> +
> +#define TCSR_MDT	BIT(0)
> +#define TCSR_UDT	BIT(1)
> +#define TCSR_GENT	BIT(2)
> +#define TCSR_CAPT	BIT(3)
> +#define TCSR_ARHT	BIT(4)
> +#define TCSR_LOAD	BIT(5)
> +#define TCSR_ENIT	BIT(6)
> +#define TCSR_ENT	BIT(7)
> +#define TCSR_TINT	BIT(8)
> +#define TCSR_PWMA	BIT(9)
> +#define TCSR_ENALL	BIT(10)
> +#define TCSR_CASC	BIT(11)
> +
> +/*
> + * The idea here is to capture whether the PWM is actually running (e.g.
> + * because we or the bootloader set it up) and we need to be careful to ensure
> + * we don't cause a glitch. According to the device data sheet, to enable the
> + * PWM we need to
> + *
> + * - Set both timers to generate mode (MDT=1)
> + * - Set both timers to PWM mode (PWMA=1)
> + * - Enable the generate out signals (GENT=1)
> + *
> + * In addition,
> + *
> + * - The timer must be running (ENT=1)
> + * - The timer must auto-reload TLR into TCR (ARHT=1)
> + * - We must not be in the process of loading TLR into TCR (LOAD=0)
> + * - Cascade mode must be disabled (CASC=0)
> + *
> + * If any of these differ from usual, then the PWM is either disabled, or is
> + * running in a mode that this driver does not support.
> + */
> +#define TCSR_PWM_SET (TCSR_GENT | TCSR_ARHT | TCSR_ENT | TCSR_PWMA)
> +#define TCSR_PWM_CLEAR (TCSR_MDT | TCSR_LOAD)
> +#define TCSR_PWM_MASK (TCSR_PWM_SET | TCSR_PWM_CLEAR)
> +
> +/**
> + * struct xilinx_timer_priv - Private data for Xilinx AXI timer driver
> + * @cs: Clocksource device
> + * @ce: Clockevent device
> + * @pwm: PWM controller chip
> + * @clk: Parent clock
> + * @regs: Base address of this device
> + * @width: Width of the counters, in bits
> + * @XILINX_TIMER_ONE: We have only one timer.
> + * @XILINX_TIMER_PWM: Configured as a PWM.
> + * @XILINX_TIMER_CLK: We were missing a device tree clock and created our own
> + * @flags: Flags for what type of device we are
> + */
> +struct xilinx_timer_priv {
> +	union {
> +		struct {
> +			struct clocksource cs;
> +			struct clock_event_device ce;
> +		};
> +		struct pwm_chip pwm;
> +	};
> +	struct clk *clk;
> +	void __iomem *regs;
> +	u32 (*read)(const volatile void __iomem *addr);
> +	void (*write)(u32 value, volatile void __iomem *addr);
> +	unsigned int width;
> +	enum {
> +		XILINX_TIMER_ONE = BIT(0),
> +		XILINX_TIMER_PWM = BIT(1),
> +		XILINX_TIMER_CLK = BIT(2),
> +	} flags;
> +};
> +
> +static inline struct xilinx_timer_priv
> +*xilinx_pwm_chip_to_priv(struct pwm_chip *chip)
> +{
> +	return container_of(chip, struct xilinx_timer_priv, pwm);
> +}
> +
> +static inline struct xilinx_timer_priv
> +*xilinx_clocksource_to_priv(struct clocksource *cs)
> +{
> +	return container_of(cs, struct xilinx_timer_priv, cs);
> +}
> +
> +static inline struct xilinx_timer_priv
> +*xilinx_clockevent_to_priv(struct clock_event_device *ce)
> +{
> +	return container_of(ce, struct xilinx_timer_priv, ce);
> +}
> +
> +static u32 xilinx_ioread32be(const volatile void __iomem *addr)
> +{
> +	return ioread32be(addr);
> +}
> +
> +static void xilinx_iowrite32be(u32 value, volatile void __iomem *addr)
> +{
> +	iowrite32be(value, addr);
> +}
> +
> +static inline u32 xilinx_timer_read(struct xilinx_timer_priv *priv,
> +				    int offset)
> +{
> +	return priv->read(priv->regs + offset);
> +}
> +
> +static inline void xilinx_timer_write(struct xilinx_timer_priv *priv,
> +				      u32 value, int offset)
> +{
> +	priv->write(value, priv->regs + offset);
> +}
> +
> +static inline u64 xilinx_timer_max(struct xilinx_timer_priv *priv)
> +{
> +	return BIT_ULL(priv->width) - 1;
> +}
> +
> +static int xilinx_timer_tlr_cycles(struct xilinx_timer_priv *priv, u32 *tlr,
> +				   u32 tcsr, u64 cycles)
> +{
> +	u64 max_count = xilinx_timer_max(priv);
> +
> +	if (cycles < 2 || cycles > max_count + 2)
> +		return -ERANGE;
> +
> +	if (tcsr & TCSR_UDT)
> +		*tlr = cycles - 2;
> +	else
> +		*tlr = max_count - cycles + 2;
> +
> +	return 0;
> +}
> +
> +static bool xilinx_timer_pwm_enabled(u32 tcsr0, u32 tcsr1)
> +{
> +	return ((TCSR_PWM_MASK | TCSR_CASC) & tcsr0) == TCSR_PWM_SET &&
> +		(TCSR_PWM_MASK & tcsr1) == TCSR_PWM_SET;
> +}
> +
> +static int xilinx_timer_tlr_period(struct xilinx_timer_priv *priv, u32 *tlr,
> +				   u32 tcsr, unsigned int period)
> +{
> +	u64 cycles = DIV_ROUND_DOWN_ULL((u64)period * clk_get_rate(priv->clk),
> +					NSEC_PER_SEC);
> +
> +	return xilinx_timer_tlr_cycles(priv, tlr, tcsr, cycles);
> +}
> +
> +static unsigned int xilinx_timer_get_period(struct xilinx_timer_priv *priv,
> +					    u32 tlr, u32 tcsr)
> +{
> +	u64 cycles;
> +
> +	if (tcsr & TCSR_UDT)
> +		cycles = tlr + 2;
> +	else
> +		cycles = xilinx_timer_max(priv) - tlr + 2;
> +
> +	return DIV_ROUND_UP_ULL(cycles * NSEC_PER_SEC,
> +				clk_get_rate(priv->clk));
> +}
> +
> +static int xilinx_pwm_apply(struct pwm_chip *chip, struct pwm_device *unused,
> +			    const struct pwm_state *state)
> +{
> +	int ret;
> +	struct xilinx_timer_priv *priv = xilinx_pwm_chip_to_priv(chip);
> +	u32 tlr0, tlr1;
> +	u32 tcsr0 = xilinx_timer_read(priv, TCSR0);
> +	u32 tcsr1 = xilinx_timer_read(priv, TCSR1);
> +	bool enabled = xilinx_timer_pwm_enabled(tcsr0, tcsr1);
> +
> +	if (state->polarity != PWM_POLARITY_NORMAL)
> +		return -EINVAL;
> +
> +	ret = xilinx_timer_tlr_period(priv, &tlr0, tcsr0, state->period);
> +	if (ret)
> +		return ret;
> +
> +	ret = xilinx_timer_tlr_period(priv, &tlr1, tcsr1, state->duty_cycle);
> +	if (ret)
> +		return ret;
> +
> +	xilinx_timer_write(priv, tlr0, TLR0);
> +	xilinx_timer_write(priv, tlr1, TLR1);
> +
> +	if (state->enabled) {
> +		/* Only touch the TCSRs if we aren't already running */
> +		if (!enabled) {
> +			/* Load TLR into TCR */
> +			xilinx_timer_write(priv, tcsr0 | TCSR_LOAD, TCSR0);
> +			xilinx_timer_write(priv, tcsr1 | TCSR_LOAD, TCSR1);
> +			/* Enable timers all at once with ENALL */
> +			tcsr0 = (TCSR_PWM_SET & ~TCSR_ENT) | (tcsr0 & TCSR_UDT);
> +			tcsr1 = TCSR_PWM_SET | TCSR_ENALL | (tcsr1 & TCSR_UDT);
> +			xilinx_timer_write(priv, tcsr0, TCSR0);
> +			xilinx_timer_write(priv, tcsr1, TCSR1);
> +		}
> +	} else {
> +		xilinx_timer_write(priv, 0, TCSR0);
> +		xilinx_timer_write(priv, 0, TCSR1);
> +	}
> +
> +	return 0;
> +}
> +
> +static void xilinx_pwm_get_state(struct pwm_chip *chip,
> +				 struct pwm_device *unused,
> +				 struct pwm_state *state)
> +{
> +	struct xilinx_timer_priv *priv = xilinx_pwm_chip_to_priv(chip);
> +	u32 tlr0 = xilinx_timer_read(priv, TLR0);
> +	u32 tlr1 = xilinx_timer_read(priv, TLR1);
> +	u32 tcsr0 = xilinx_timer_read(priv, TCSR0);
> +	u32 tcsr1 = xilinx_timer_read(priv, TCSR1);
> +
> +	state->period = xilinx_timer_get_period(priv, tlr0, tcsr0);
> +	state->duty_cycle = xilinx_timer_get_period(priv, tlr1, tcsr1);
> +	state->enabled = xilinx_timer_pwm_enabled(tcsr0, tcsr1);
> +	state->polarity = PWM_POLARITY_NORMAL;
> +}
> +
> +static const struct pwm_ops xilinx_pwm_ops = {
> +	.apply = xilinx_pwm_apply,
> +	.get_state = xilinx_pwm_get_state,
> +	.owner = THIS_MODULE,
> +};
> +
> +static int xilinx_pwm_init(struct device *dev,
> +			   struct xilinx_timer_priv *priv)
> +{
> +	int ret;
> +
> +	if (!dev)
> +		return -EPROBE_DEFER;
> +
> +	priv->pwm.dev = dev;
> +	priv->pwm.ops = &xilinx_pwm_ops;
> +	priv->pwm.npwm = 1;
> +	ret = pwmchip_add(&priv->pwm);
> +	if (ret)
> +		xilinx_timer_err(dev->of_node, ret,
> +				 "could not register pwm chip\n");
> +	return ret;
> +}
> +
> +static irqreturn_t xilinx_timer_handler(int irq, void *dev)
> +{
> +	struct xilinx_timer_priv *priv = dev;
> +	u32 tcsr1 = xilinx_timer_read(priv, TCSR1);
> +
> +	/* Acknowledge interrupt */
> +	xilinx_timer_write(priv, tcsr1 | TCSR_TINT, TCSR1);
> +	priv->ce.event_handler(&priv->ce);
> +	return IRQ_HANDLED;
> +}
> +
> +static int xilinx_clockevent_next_event(unsigned long evt,
> +					struct clock_event_device *ce)
> +{
> +	struct xilinx_timer_priv *priv = xilinx_clockevent_to_priv(ce);
> +
> +	xilinx_timer_write(priv, evt, TLR1);
> +	xilinx_timer_write(priv, TCSR_LOAD, TCSR1);
> +	xilinx_timer_write(priv, TCSR_ENIT | TCSR_ENT, TCSR1);
> +	return 0;
> +}
> +
> +static int xilinx_clockevent_state_periodic(struct clock_event_device *ce)
> +{
> +	int ret;
> +	u32 tlr1;
> +	struct xilinx_timer_priv *priv = xilinx_clockevent_to_priv(ce);
> +
> +	ret = xilinx_timer_tlr_cycles(priv, &tlr1, 0,
> +				      clk_get_rate(priv->clk) / HZ);
> +	if (ret)
> +		return ret;
> +
> +	xilinx_timer_write(priv, tlr1, TLR1);
> +	xilinx_timer_write(priv, TCSR_LOAD, TCSR1);
> +	xilinx_timer_write(priv, TCSR_ARHT | TCSR_ENIT | TCSR_ENT, TCSR1);
> +	return 0;
> +}
> +
> +static int xilinx_clockevent_shutdown(struct clock_event_device *ce)
> +{
> +	xilinx_timer_write(xilinx_clockevent_to_priv(ce), 0, TCSR1);
> +	return 0;
> +}
> +
> +static const struct clock_event_device xilinx_clockevent_base = {
> +	.name = "xilinx_clockevent",
> +	.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
> +	.set_next_event = xilinx_clockevent_next_event,
> +	.set_state_periodic = xilinx_clockevent_state_periodic,
> +	.set_state_shutdown = xilinx_clockevent_shutdown,
> +	.rating = 300,
> +	.cpumask = cpu_possible_mask,
> +	.owner = THIS_MODULE,
> +};
> +
> +static int xilinx_clockevent_init(struct device_node *np,
> +				  struct xilinx_timer_priv *priv)
> +{
> +	int ret = of_irq_get(np, 0);
> +
> +	if (ret < 0)
> +		return xilinx_timer_err(np, ret, "could not get irq\n");
> +
> +	ret = request_irq(ret, xilinx_timer_handler, IRQF_TIMER,
> +			  np->full_name, priv);
> +	if (ret)
> +		return xilinx_timer_err(np, ret, "could not request irq\n");
> +
> +	memcpy(&priv->ce, &xilinx_clockevent_base, sizeof(priv->ce));
> +	clockevents_config_and_register(&priv->ce,
> +					clk_get_rate(priv->clk), 2,
> +					min_t(u64,
> +					      xilinx_timer_max(priv) + 2,
> +					      ULONG_MAX));
> +	return 0;
> +}
> +
> +static u64 xilinx_clocksource_read(struct clocksource *cs)
> +{
> +	return xilinx_timer_read(xilinx_clocksource_to_priv(cs), TCR0);
> +}
> +
> +static const struct clocksource xilinx_clocksource_base = {
> +	.read = xilinx_clocksource_read,
> +	.name = "xilinx_clocksource",
> +	.rating = 300,
> +	.flags = CLOCK_SOURCE_IS_CONTINUOUS,
> +	.owner = THIS_MODULE,
> +};
> +
> +static int xilinx_clocksource_init(struct xilinx_timer_priv *priv)
> +{
> +	xilinx_timer_write(priv, 0, TLR0);
> +	/* Load TLR and clear any interrupts */
> +	xilinx_timer_write(priv, TCSR_LOAD | TCSR_TINT, TCSR0);
> +	/* Start the timer counting up with auto-reload */
> +	xilinx_timer_write(priv, TCSR_ARHT | TCSR_ENT, TCSR0);
> +
> +	memcpy(&priv->cs, &xilinx_clocksource_base, sizeof(priv->cs));
> +	priv->cs.mask = xilinx_timer_max(priv);
> +	return clocksource_register_hz(&priv->cs, clk_get_rate(priv->clk));
> +}
> +
> +static struct clk *xilinx_timer_clock_init(struct device_node *np,
> +					   struct xilinx_timer_priv *priv)
> +{
> +	int ret;
> +	u32 freq;
> +	struct clk_hw *hw;
> +	struct clk *clk = of_clk_get_by_name(np, "s_axi_aclk");
> +
> +	if (!IS_ERR(clk) || PTR_ERR(clk) == -EPROBE_DEFER)
> +		return clk;
> +
> +	pr_warn("%pOF: missing s_axi_aclk, falling back to clock-frequency\n",
> +		np);
> +	ret = of_property_read_u32(np, "clock-frequency", &freq);
> +	if (ret) {
> +#if IS_ENABLED(CONFIG_MICROBLAZE)
> +		pr_warn("%pOF: missing clock-frequency, falling back to /cpus/timebase-frequency\n",
> +			np);
> +		freq = cpuinfo.cpu_clock_freq;
> +#else
> +		return ERR_PTR(ret);
> +#endif
> +	}
> +
> +	priv->flags |= XILINX_TIMER_CLK;
> +	hw = __clk_hw_register_fixed_rate(NULL, np, "s_axi_aclk", NULL, NULL,
> +					  NULL, 0, freq, 0, 0);
> +	if (IS_ERR(hw))
> +		return ERR_CAST(hw);
> +	return hw->clk;
> +}
> +
> +static struct xilinx_timer_priv *xilinx_timer_init(struct device *dev,
> +						   struct device_node *np)
> +{
> +	bool pwm;
> +	int i, ret;
> +	struct xilinx_timer_priv *priv;
> +	u32 one_timer, tcsr0;
> +
> +	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return ERR_PTR(-ENOMEM);
> +
> +	priv->regs = of_iomap(np, 0);
> +	if (!priv->regs) {
> +		ret = -ENXIO;
> +		goto err_priv;
> +	} else if (IS_ERR(priv->regs)) {
> +		ret = PTR_ERR(priv->regs);
> +		goto err_priv;
> +	}
> +
> +	priv->read = ioread32;
> +	priv->write = iowrite32;
> +	/*
> +	 * We aren't using the interrupts yet, so use ENIT to detect endianness
> +	 */
> +	tcsr0 = xilinx_timer_read(priv, TCSR0);
> +	if (swab32(tcsr0) & TCSR_ENIT) {
> +		ret = xilinx_timer_err(np, -EOPNOTSUPP,
> +				       "cannot determine endianness\n");
> +		goto err_priv;
> +	}
> +
> +	xilinx_timer_write(priv, tcsr0 | TCSR_ENIT, TCSR0);
> +	if (!(xilinx_timer_read(priv, TCSR0) & TCSR_ENIT)) {
> +		priv->read = xilinx_ioread32be;
> +		priv->write = xilinx_iowrite32be;
> +	}
> +
> +	/*
> +	 * For backwards compatibility, allow xlnx,one-timer-only = <bool>;
> +	 * However, the preferred way is to use the xlnx,single-timer flag.
> +	 */
> +	one_timer = of_property_read_bool(np, "xlnx,single-timer");
> +	if (!one_timer) {
> +		ret = of_property_read_u32(np, "xlnx,one-timer-only", &one_timer);
> +		if (ret) {
> +			ret = xilinx_timer_err(np, ret, "xlnx,one-timer-only");
> +			goto err_priv;
> +		}
> +	}
> +
> +	pwm = of_property_read_bool(np, "xlnx,pwm");
> +	if (one_timer && pwm) {
> +		ret = xilinx_timer_err(np, -EINVAL,
> +				       "pwm mode not possible with one timer\n");
> +		goto err_priv;
> +	}
> +
> +	priv->flags = FIELD_PREP(XILINX_TIMER_ONE, one_timer) |
> +		      FIELD_PREP(XILINX_TIMER_PWM, pwm);
> +
> +	for (i = 0; pwm && i < 2; i++) {
> +		char int_fmt[] = "xlnx,gen%u-assert";
> +		char bool_fmt[] = "xlnx,gen%u-active-low";
> +		char buf[max(sizeof(int_fmt), sizeof(bool_fmt))];
> +		u32 gen;
> +
> +		/*
> +		 * Allow xlnx,gen?-assert = <bool>; for backwards
> +		 * compatibility. However, the preferred way is to use the
> +		 * xlnx,gen?-active-low flag.
> +		 */
> +		snprintf(buf, sizeof(buf), bool_fmt, i);
> +		gen = !of_property_read_bool(np, buf);
> +		if (gen) {
> +			snprintf(buf, sizeof(buf), int_fmt, i);
> +			ret = of_property_read_u32(np, buf, &gen);
> +			if (ret && ret != -EINVAL) {
> +				xilinx_timer_err(np, ret, "%s\n", buf);
> +				goto err_priv;
> +			}
> +		}
> +
> +		if (!gen) {
> +			ret = xilinx_timer_err(np, -EINVAL,
> +					       "generateout%u must be active high\n",
> +					       i);
> +			goto err_priv;
> +		}
> +	}
> +
> +	ret = of_property_read_u32(np, "xlnx,count-width", &priv->width);
> +	if (ret) {
> +		xilinx_timer_err(np, ret, "xlnx,count-width\n");
> +		goto err_priv;
> +	} else if (priv->width < 8 || priv->width > 32) {
> +		ret = xilinx_timer_err(np, -EINVAL, "invalid counter width\n");
> +		goto err_priv;
> +	}
> +
> +	priv->clk = xilinx_timer_clock_init(np, priv);
> +	if (IS_ERR(priv->clk)) {
> +		ret = xilinx_timer_err(np, PTR_ERR(priv->clk), "clock\n");
> +		goto err_priv;
> +	}
> +
> +	ret = clk_prepare_enable(priv->clk);
> +	if (ret) {
> +		xilinx_timer_err(np, ret, "clock enable failed\n");
> +		goto err_clk;
> +	}
> +	clk_rate_exclusive_get(priv->clk);
> +
> +	if (pwm) {
> +		ret = xilinx_pwm_init(dev, priv);
> +	} else {
> +		ret = xilinx_clocksource_init(priv);
> +		if (!ret && !one_timer) {
> +			ret = xilinx_clockevent_init(np, priv);
> +			if (ret)
> +				priv->flags |= XILINX_TIMER_ONE;
> +		}
> +	}
> +
> +	if (!ret)
> +		return priv;
> +
> +	clk_rate_exclusive_put(priv->clk);
> +	clk_disable_unprepare(priv->clk);
> +err_clk:
> +	if (priv->flags & XILINX_TIMER_CLK)
> +		clk_unregister_fixed_rate(priv->clk);
> +	else
> +		clk_put(priv->clk);
> +err_priv:
> +	kfree(priv);
> +	return ERR_PTR(ret);
> +}
> +
> +static int xilinx_timer_probe(struct platform_device *pdev)
> +{
> +	struct xilinx_timer_priv *priv =
> +		xilinx_timer_init(&pdev->dev, pdev->dev.of_node);
> +
> +	if (IS_ERR(priv))
> +		return PTR_ERR(priv);
> +
> +	platform_set_drvdata(pdev, priv);
> +	return 0;
> +}
> +
> +static int xilinx_timer_remove(struct platform_device *pdev)
> +{
> +	struct xilinx_timer_priv *priv = platform_get_drvdata(pdev);
> +
> +	if (IS_ENABLED(CONFIG_XILINX_PWM) && priv->flags & XILINX_TIMER_PWM) {
> +		pwmchip_remove(&priv->pwm);
> +	} else {
> +		if (!(priv->flags & XILINX_TIMER_ONE)) {
> +			int cpu;
> +
> +			for_each_cpu(cpu, priv->ce.cpumask)
> +				clockevents_unbind_device(&priv->ce, cpu);
> +		}
> +		clocksource_unregister(&priv->cs);
> +	}
> +
> +	clk_rate_exclusive_put(priv->clk);
> +	clk_disable_unprepare(priv->clk);
> +	if (priv->flags & XILINX_TIMER_CLK)
> +		clk_unregister_fixed_rate(priv->clk);
> +	else
> +		clk_put(priv->clk);
> +	return 0;
> +}
> +
> +static const struct of_device_id xilinx_timer_of_match[] = {
> +	{ .compatible = "xlnx,xps-timer-1.00.a", },
> +	{ .compatible = "xlnx,axi-timer-2.0" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, xilinx_timer_of_match);
> +
> +static struct platform_driver xilinx_timer_driver = {
> +	.probe = xilinx_timer_probe,
> +	.remove = xilinx_timer_remove,
> +	.driver = {
> +		.name = "xilinx-timer",
> +		.of_match_table = of_match_ptr(xilinx_timer_of_match),
> +	},
> +};
> +module_platform_driver(xilinx_timer_driver);
> +
> +static struct xilinx_timer_priv *xilinx_sched = (void *)-EAGAIN;
> +
> +static u64 xilinx_sched_read(void)
> +{
> +	return xilinx_timer_read(xilinx_sched, TCSR0);

This should be TCR0.

--Sean

> +}
> +
> +static int __init xilinx_timer_register(struct device_node *np)
> +{
> +	struct xilinx_timer_priv *priv;
> +
> +	if (xilinx_sched != ERR_PTR(-EAGAIN))
> +		return -EPROBE_DEFER;
> +
> +	priv = xilinx_timer_init(NULL, np);
> +	if (IS_ERR(priv))
> +		return PTR_ERR(priv);
> +	of_node_set_flag(np, OF_POPULATED);
> +
> +	xilinx_sched = priv;
> +	sched_clock_register(xilinx_sched_read, priv->width,
> +			     clk_get_rate(priv->clk));
> +	return 0;
> +}
> +
> +TIMER_OF_DECLARE(xilinx_xps_timer, "xlnx,xps-timer-1.00.a", xilinx_timer_register);
> +TIMER_OF_DECLARE(xilinx_axi_timer, "xlnx,axi-timer-2.0", xilinx_timer_register);
> +
> +MODULE_ALIAS("platform:xilinx-timer");
> +MODULE_DESCRIPTION("Xilinx LogiCORE IP AXI Timer driver");
> +MODULE_LICENSE("GPL v2");
> 
