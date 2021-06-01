Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABBE397560
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jun 2021 16:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234072AbhFAO0P (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 1 Jun 2021 10:26:15 -0400
Received: from mail-eopbgr10052.outbound.protection.outlook.com ([40.107.1.52]:47134
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233797AbhFAO0N (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 1 Jun 2021 10:26:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FNe93GDWfOjeeGR1LD8e7jgU6nCkO5mWHlTcKQDpvuRYRAbEvakv4YPfneqgZI1y0N6bRisG6/dWPuxT4pc5SDMNP7yLxi041cu1bQN0VTm3oFPPJRhp3G9WbR97JUxEwAo7mo4is6idVPdS8f8VNqbZKgsfCoMvay/sA6OOme/cLOYTp9uiiOJC25p+pRmhiAoHNIWsd5GxePKQhrpyvkiuMNZp7ze7WCGjP9aS+GzQ3udG+qAKdubYON1rg2ry1iiaYxXg1Ur3MqzdHb+ejYsduggZAdBTsgzu7k7w8jSG5h4RC+x5A1wL8LTn4bRyxbf2s763+i3NxtFoOHaF3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Ceife/428YaAB9EGFII0hg/1woE0Jau24s8c4IcobE=;
 b=HzfI7PGERLnB0ZkigzwZaYXwe2SOI9cng8FFISCCTGfKnMCIX2fhr9JbiuJBenbwQhrby1NzHuWREIEuUb9LC6hTIkykzD8ShSElPRRrki9Xxi9Z5g0+ue9qk9RjBZGb9J7UinZg0ufIL5itnZEJL9MqQWO902Z6uj2Z5QT4BhnXn+stT5iPm+T/ldiFQiHR8YAlESU/VWJfhOa6laa3NEoATjvX3UtT1bHkVaDwunNNdxm808/YNj1eelKCxykv+D7lQ2UXBMClz+gna7Tvn4IFK6QGP+3kFGXkZqbKwI318jptwPJYOhN4clS3kjqyR6So9T32w2UpnaxlOwWzcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Ceife/428YaAB9EGFII0hg/1woE0Jau24s8c4IcobE=;
 b=pPOVkFzWPvEE9MTp56ENmILQ3a7rcgz0UaT9bnyPJjQFJBS7Q/gNSL5G9w9+7EgSHCGw8MkTK4wUBe89YLWxH5YwvLTSHxPxXrxoIb1j/bJjhubvzFxaEEDwEe8hnqzvEMbVt77fQkl7CDlmAr0EV8Ce5XxbzFQzxODq0ZkzsYc=
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB8PR03MB6027.eurprd03.prod.outlook.com (2603:10a6:10:ec::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Tue, 1 Jun
 2021 14:24:29 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b%5]) with mapi id 15.20.4173.030; Tue, 1 Jun 2021
 14:24:28 +0000
Subject: Re: [PATCH v4 2/3] clocksource: Rewrite Xilinx AXI timer driver
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        michal.simek@xilinx.com, linux-kernel@vger.kernel.org,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        linux-arm-kernel@lists.infradead.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20210528214522.617435-1-sean.anderson@seco.com>
 <20210528214522.617435-2-sean.anderson@seco.com>
 <20210601084734.GX543307@dell>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <fe95aba7-8362-96f2-a43f-60cd11565cea@seco.com>
Date:   Tue, 1 Jun 2021 10:24:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210601084734.GX543307@dell>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.195.82.171]
X-ClientProxiedBy: BL1P223CA0010.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::15) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.1.65] (50.195.82.171) by BL1P223CA0010.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Tue, 1 Jun 2021 14:24:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 256cf883-2c4e-4895-6ca3-08d92508f724
X-MS-TrafficTypeDiagnostic: DB8PR03MB6027:
X-Microsoft-Antispam-PRVS: <DB8PR03MB6027E1D635EFE5366AD16106963E9@DB8PR03MB6027.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y+T+5IVxSygby2rzGao9BqdZCN/0G+N4EMbm/iDGNg4iz1HsaVItfNLTCWOXGAOoNTVgHVIkWZ8XHBdqhH0Swp2zKfWA6aHjg4f9X+CsVIbh0aiW9gI+AwuCWtedidvVhCscnj9rVJ6FfpBgyUVqKoSNfx7Fb/Yl0QWUdPuXYx5zT/wp7781wox0S4DOaUZi0fnSIwdNcKu5EUHBBvqdaw4g13MiFG/fyJxfjrr/Ezu0/0GHZB6hpU3jFtYcsjNoAXB11j6fL+EgxEJYnlI/LBuQJ+gJ3PkArU8M4ljr55vKQKQ7lBhrEVbYQg2kpQin81HHGF4IEIhh4texo4MhD5EmNpxKLsqY1gy2SLykjhSodbWqQgT8R7rB4psd/DZuDhCq649cYQNO35ARZHzV63xUNASfATgwVqaqPwXXEHd5Qm8xw5kxur0HqPsJ+ZvZC31xI2N9ShTOBr8xLCpGUl5gctEhvZXQWJ0f2cmZMdRjnH4uYWDA/4YrVyc4Y18n7jWN7l5LvEB7IkOCrZ1E+XFbME6SkGRwUfMNSY00dVwLDeSHqHIz41PGsoZOr5MFH6xILRY82L70btl6Msb+Rr12DXSbkQSfUFouD/+rLP7t1JjfeHA24BhP+JxSF5SiHg+3vi5Q4hj72FiQLHvbJ8e6CamnpdUA+1aPL04oCcy4DN/r3u11Tyiabs5FF3tAGLeyPkPSoS32GG5UM71sVY1QmEUPnKXLPQZGfMOMlCDZdMSgjrSYuyqoQb1MTBL60TGDIxUKKNFBMGE2EylYdm8CSVeJ/H2++Xz97nJzFeRD1r3MdCcq8iclS2k2BtVkzo1H6CkJXUnxgIS0Of/E6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(16576012)(86362001)(66556008)(66476007)(38350700002)(26005)(6666004)(54906003)(31696002)(83380400001)(4326008)(16526019)(186003)(6916009)(38100700002)(66946007)(8676002)(44832011)(52116002)(53546011)(966005)(5660300002)(31686004)(2616005)(36756003)(956004)(498600001)(8936002)(2906002)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MXZCeUVycXJQc0htWitaM0R0RC8zbkMxcG9YcnhCaDNXNFl0R0pLcWdkbXli?=
 =?utf-8?B?TFBCbWo2UUhKWjlIZ1dUZEpNSWdOanhNRUxiY3dObTUvREkzUEMwdjkzVE56?=
 =?utf-8?B?MDRmem9scmFSekVmWUhaOHVmeXgrN1ZRTzJwSjZBbTN6YUVCb1Ruakdhdk9p?=
 =?utf-8?B?Y3YxV2FnWStYMHQrMlhrZjYvZ2lIeG5SUTY5RlNxN1FPUlVMbThEVks3aWFS?=
 =?utf-8?B?S0l6WUp0OE1hZzRxYXJ1cVdvUFpUc0VSMVMxK2U3UTBub2NvR250ejNBMWtw?=
 =?utf-8?B?aHR3ZEhaTU1rbHlvaDVYR2lxRmtrYjN5dTJoQkM3VFJsb2NBN01wYkg3RXds?=
 =?utf-8?B?RElxSENxb04xMWQxSW05UE9aY0tpdzFpNWIyQytwNXlJdkIzOWNVKzNRY0N2?=
 =?utf-8?B?VjJ5eDhOYThmNnQ5cnlZeUQ0S3FCUHNFbGFkVDQvMklkZzZnNjBVWlZieXNa?=
 =?utf-8?B?WndZMmdSWSszRWhiSXRTRy84bytNdlVmbVBFaXF6QXNnS0dHa3E1K2xlS0VT?=
 =?utf-8?B?QkNDTUx0NFZsd2tGSTZPOVZ1T2o4VVl4b1BDb3k3dy9sNGRYTW1qN0RWTFA0?=
 =?utf-8?B?cmcvbHRscGhWRHdldGdRRU9WNUFRTjRNeVBXZG1UZDBZOERQb3ZjYXVQRCtM?=
 =?utf-8?B?N2oyUTlVQVpzb0lQM0tMeENtZGplakdRbitQbEZVTmJuSStJRzJoVWhkdWtN?=
 =?utf-8?B?NmpBWjdXT0VzR0dBUEh0TGNHWFVsb2tRNmtDTGw2L3Q1K2xjU25GbVJSQzVl?=
 =?utf-8?B?TnppZXVBNW11R3FpZjQxNjIwVWs4UUtHcCtkQ2V5L0ZKblh2VlNlYkowQnJE?=
 =?utf-8?B?TUJCNHJ3ZU5XSnl3bEUrMENTZmQvSVBDVXpKVmhEN2JVU0d5ZzBVRmI5TitQ?=
 =?utf-8?B?a3d6c3d1U1pVdFkyWUF5ekI0V0padDAyNlR2OEk4MmJxb2NMRGZwZTdNOUd0?=
 =?utf-8?B?Z0FHNXF6Rm1LYTUyZUpkS2ZqN0NwTkVrUGR6aUozUWVEVElqKzFtaklVRVJ6?=
 =?utf-8?B?aDV0Rk15ZXJEVXRoN1hDbFl3aksrUHJXd3E0SWo5YWxLTDVLNVJkdFVsK24x?=
 =?utf-8?B?R0JCa2kwdmdPMjc3YUJuNlFUUjFOMUFVRjhPbFNrc25Ld0x0dGpVWXZ6RGlO?=
 =?utf-8?B?OFR1MlpYVXVTTjFCdFdhVVBFYzFCaTlzM1hzQThnNWVicVpsMlRvN3FpYUIx?=
 =?utf-8?B?My9HY1NhYVhreFRXYjdyWDNTTkk5ZW1NUXRQNXJMWGtpSlBXTmRmRkpjbi9T?=
 =?utf-8?B?VkdEVVUvb1ZBNUxWU0NOc1VUdzBFOEdGWWwxTk0rcExjQm5vN0crNnVyd2o1?=
 =?utf-8?B?Q3JHejFENDVzSCsxeWtOL0MrVHllTmFWSExWUmFhZmI5ZXNuRW1CWm5PNnVi?=
 =?utf-8?B?ZlVkbnB4dkJLRGZqNXhYd2F3WXFHVWpoTzdNY2MvaVd1SURJbUhMQWRzUmhQ?=
 =?utf-8?B?RUpKTE5RdytEZXE4bHBwRHBJU1NyTTlGUXdRMlM2VThGMldpb05KUjRvZjBk?=
 =?utf-8?B?N1hYQTlCNVdRQXhvRXFqNTkwc2VZMlpsZ281bTgxM1d0eFJHU0pKUFhRUjFW?=
 =?utf-8?B?Nnk3TnlMZ0IyMlJHQjRDWkoxQ21HMG5jVGFKTDFBZDdWb3EvOXJPN3BaUDlR?=
 =?utf-8?B?MCtRV09Ec3AvS3JRWTdVYVNjcnVraG5JNmpWbXhmdXRSZk5XSXAvdlZzK3ZK?=
 =?utf-8?B?cnBPWDRvVGFJVmRmVjNDMVg0NytPRmpwVHBSTy82cGl0Y1A4VUZ6VkhLQy9n?=
 =?utf-8?Q?1cNo5ryVd14zEPmbO+qkAUZkkvaplRerTz4ZK0y?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 256cf883-2c4e-4895-6ca3-08d92508f724
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2021 14:24:28.8010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9BLzHbWjUNjw7Erqjr20u+FvL/BhLfWjqQGOK2P+Cvi2mOoKihOtH3S2JS069z3QjXv+DlBQnlyZNs2QeZWDhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR03MB6027
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 6/1/21 4:47 AM, Lee Jones wrote:
 > On Fri, 28 May 2021, Sean Anderson wrote:
 >
 >> This rewrites the Xilinx AXI timer driver to be more platform agnostic.
 >> Some common code has been split off so it can be reused. These routines
 >> currently live in drivers/mfd. The largest changes have taken place in the
 >> initialization:
 >>
 >> - We now support any number of timer devices, possibly with only one
 >>    counter each. The first counter will be used as a clocksource. Every
 >>    other counter will be used as a clockevent.
 >> - We do not use timer_of_init because we need to perform some tasks in
 >>    between different stages. For example, we must ensure that ->read and
 >>    ->write are initialized before registering the irq. This can only happen
 >>    after we have gotten the register base (to detect endianness). We also
 >>    have a rather unusual clock initialization sequence in order to remain
 >>    backwards compatible. Due to this, it's ok for the initial clock request
 >>    to fail, and we do not want other initialization to be undone. Lastly, it
 >>    is more convenient to do one allocation for xilinx_clockevent_device than
 >>    to do one for timer_of and one for xilinx_timer_priv.
 >> - We now pay attention to xlnx,count-width and handle smaller width timers.
 >>    The default remains 32.
 >>
 >> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
 >> ---
 >> This has been tested on microblaze qemu.
 >>
 >> Changes in v4:
 >> - Break out clock* drivers into their own file
 >>
 >>   arch/microblaze/kernel/Makefile    |   3 +-
 >>   arch/microblaze/kernel/timer.c     | 326 -----------------------------
 >>   drivers/clocksource/Kconfig        |  11 +
 >>   drivers/clocksource/Makefile       |   1 +
 >>   drivers/clocksource/timer-xilinx.c | 300 ++++++++++++++++++++++++++
 >>   drivers/mfd/Makefile               |   4 +
 >>   drivers/mfd/xilinx-timer.c         | 147 +++++++++++++
 >
 > I'm confused!
 >
 >>   include/linux/mfd/xilinx-timer.h   | 134 ++++++++++++
 >>   8 files changed, 598 insertions(+), 328 deletions(-)
 >>   delete mode 100644 arch/microblaze/kernel/timer.c
 >>   create mode 100644 drivers/clocksource/timer-xilinx.c
 >>   create mode 100644 drivers/mfd/xilinx-timer.c
 >>   create mode 100644 include/linux/mfd/xilinx-timer.h
 >
 > [...]
 >
 >> +// SPDX-License-Identifier: GPL-2.0+
 >> +/*
 >> + * Copyright (C) 2021 Sean Anderson <sean.anderson@seco.com>
 >> + *
 >> + * For Xilinx LogiCORE IP AXI Timer documentation, refer to DS764:
 >> + * https://www.xilinx.com/support/documentation/ip_documentation/axi_timer/v1_03_a/axi_timer_ds764.pdf
 >> + */
 >> +
 >> +#include <linux/clk.h>
 >> +#include <linux/mfd/xilinx-timer.h>
 >> +#include <linux/of.h>
 >> +#include <asm/io.h>
 >
 > RED FLAG: You are not using the MFD API here.

Should I be?

 >
 >> +#define TCSR0	0x00
 >> +#define TLR0	0x04
 >> +#define TCR0	0x08
 >> +#define TCSR1	0x10
 >> +#define TLR1	0x14
 >> +#define TCR1	0x18
 >> +
 >> +#define TCSR_MDT	BIT(0)
 >> +#define TCSR_UDT	BIT(1)
 >> +#define TCSR_GENT	BIT(2)
 >> +#define TCSR_CAPT	BIT(3)
 >> +#define TCSR_ARHT	BIT(4)
 >> +#define TCSR_LOAD	BIT(5)
 >> +#define TCSR_ENIT	BIT(6)
 >> +#define TCSR_ENT	BIT(7)
 >> +#define TCSR_TINT	BIT(8)
 >> +#define TCSR_PWMA	BIT(9)
 >> +#define TCSR_ENALL	BIT(10)
 >> +#define TCSR_CASC	BIT(11)
 >> +
 >> +/* readl/writel wrappers to support BE systems */
 >> +
 >> +static u32 xilinx_ioread32be(const void __iomem *addr)
 >> +{
 >> +	return ioread32be(addr);
 >> +}
 >> +
 >> +static void xilinx_iowrite32be(u32 value, void __iomem *addr)
 >> +{
 >> +	iowrite32be(value, addr);
 >> +}
 >> +
 >> +static u32 xilinx_ioread32(const void __iomem *addr)
 >> +{
 >> +	return ioread32(addr);
 >> +}
 >> +
 >> +static void xilinx_iowrite32(u32 value, void __iomem *addr)
 >> +{
 >> +	iowrite32(value, addr);
 >> +}
 >
 > Abstraction for the sake of abstraction, is not allowed.
 >
 > Just use the io*() calls directly in-place.

Can't. The call signatures on some arches have volatile addr and some do
not. So without these wrappers, we will get warnings about how the
function has the wrong type.

 >
 >> +int xilinx_timer_tlr_cycles(struct xilinx_timer_priv *priv, u32 *tlr,
 >> +			    u32 tcsr, u64 cycles)
 >> +{
 >> +	if (cycles < 2 || cycles > priv->max + 2)
 >> +		return -ERANGE;
 >> +
 >> +	if (tcsr & TCSR_UDT)
 >> +		*tlr = cycles - 2;
 >> +	else
 >> +		*tlr = priv->max - cycles + 2;
 >> +
 >> +	return 0;
 >> +}
 >> +
 >> +int xilinx_timer_tlr_period(struct xilinx_timer_priv *priv, u32 *tlr,
 >> +			    u32 tcsr, unsigned int period)
 >> +{
 >> +	u64 cycles = DIV_ROUND_DOWN_ULL((u64)period * clk_get_rate(priv->clk),
 >> +					NSEC_PER_SEC);
 >> +
 >> +	return xilinx_timer_tlr_cycles(priv, tlr, tcsr, cycles);
 >> +}
 >> +
 >> +unsigned int xilinx_timer_get_period(struct xilinx_timer_priv *priv,
 >> +				     u32 tlr, u32 tcsr)
 >> +{
 >> +	u64 cycles;
 >> +
 >> +	if (tcsr & TCSR_UDT)
 >> +		cycles = tlr + 2;
 >> +	else
 >> +		cycles = priv->max - tlr + 2;
 >> +
 >> +	return DIV_ROUND_UP_ULL(cycles * NSEC_PER_SEC,
 >> +				clk_get_rate(priv->clk));
 >> +}
 >> +
 >> +int xilinx_timer_common_init(struct device_node *np,
 >> +			     struct xilinx_timer_priv *priv,
 >> +			     u32 *one_timer)
 >> +{
 >> +	int ret;
 >> +	u32 tcsr0, width;
 >> +
 >> +
 >> +	priv->read = xilinx_ioread32;
 >> +	priv->write = xilinx_iowrite32;
 >> +	/*
 >> +	 * If PWM mode is enabled, we should try not to disturb it. Use
 >> +	 * CAPT since if PWM mode is enabled then MDT will be set as
 >> +	 * well.
 >> +	 *
 >> +	 * First, clear CAPT and verify that it has been cleared
 >> +	 */
 >> +	tcsr0 = xilinx_timer_read(priv, TCSR0);
 >> +	xilinx_timer_write(priv, tcsr0 & ~(TCSR_CAPT & swab(TCSR_CAPT)), TCSR0);
 >> +	tcsr0 = xilinx_timer_read(priv, TCSR0);
 >> +	if (tcsr0 & (TCSR_CAPT | swab(TCSR_CAPT))) {
 >> +		pr_err("%pOF: cannot determine endianness\n", np);
 >> +		return -EOPNOTSUPP;
 >> +	}
 >> +
 >> +	/* Then check to make sure our write sticks */
 >> +	xilinx_timer_write(priv, tcsr0 | TCSR_CAPT, TCSR0);
 >> +	if (!(xilinx_timer_read(priv, TCSR0) & TCSR_CAPT)) {
 >> +		priv->read = xilinx_ioread32be;
 >> +		priv->write = xilinx_iowrite32be;
 >> +	}
 >> +
 >> +	ret = of_property_read_u32(np, "xlnx,one-timer-only", one_timer);
 >> +	if (ret) {
 >> +		pr_err("%pOF: err %d: xlnx,one-timer-only\n", np, ret);
 >> +		return ret;
 >> +	} else if (*one_timer && *one_timer != 1) {
 >> +		pr_err("%pOF: xlnx,one-timer-only must be 0 or 1\n", np);
 >> +		return -EINVAL;
 >> +	}
 >> +
 >> +	ret = of_property_read_u32(np, "xlnx,count-width", &width);
 >> +	if (ret == -EINVAL) {
 >> +		width = 32;
 >> +	} else if (ret) {
 >> +		pr_err("%pOF: err %d: xlnx,count-width\n", np, ret);
 >> +		return ret;
 >> +	} else if (width < 8 || width > 32) {
 >> +		pr_err("%pOF: invalid counter width\n", np);
 >> +		return -EINVAL;
 >> +	}
 >> +	priv->max = BIT_ULL(width) - 1;
 >> +
 >> +	return 0;
 >> +}
 >
 > This is *all* timer stuff.
 >
 > What is your rationale for dumping this into MFD?

It was requested that common code for the timer and PWM drivers be
reused in some way. I stuck it in mfd because I wasn't sure where else
to put it. If you have a better location suggestion, I'm all ears

--Sean
