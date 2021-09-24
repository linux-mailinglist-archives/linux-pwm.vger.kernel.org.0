Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D29B3416C67
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Sep 2021 08:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244256AbhIXG4u (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 24 Sep 2021 02:56:50 -0400
Received: from mail-bn7nam10on2080.outbound.protection.outlook.com ([40.107.92.80]:31811
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244182AbhIXG4t (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 24 Sep 2021 02:56:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LSSJPDULuP6uYSMiPxQpaVIZ5dty04Gc90Va1ZON2eNRb7R4+Pppjri49nrgHZwOSiDgq0NTDS572//jGmleVAGmQeYbSxuxWJGAzp5+QzaJthGxEJx20mVxzXAIS65H8Ogt+ktUBNqjEUQ5hxPFwygOKuQcldgxLkEUpOZy1SGLK3gd2d2s2ojr9YdSHEOvFsd05LPDcS4+urUg/GPu2392dP5UH9gBmS6+PVgoZatvLHepidU/T4hW6SNyPhyq3/zoqXTjVYpU3Odd4XjXkOWE0ZuwlTCXGUzyhRCuxFtjDGZyVesHZDFzVZVNNNdEMF/D4V0VGH8rG/MtoRiPTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=hY0i6bi2uvvmZog9ilTyDwxncwV6RqWe/5YU5JNFb/Q=;
 b=gsxrbRazfNb+xCz9l+Q0Ka2wKl/hpAb52d/a3i5CyJlE5KPlkFLpGttdoIhD/XzkxiiAImfA18gOzVmrOG3jEXdK9VO/0iyFHuDv1fbvsqHzfhnwi0bWdge1oUYJQ2G1dj+bwCvGQbSdxKVnVyn5VaH9ZF+aqVDkBd5EWkC7x5eIEJJhJZQgg5Tr0qFGBu+LYMwj5H2ow/JAtqsgi+48cRokhEc3HVGH4FpTUnVwbCv1cmS8+1w6mqfj8lmytZ19qa3dmPGxjWdhU46K8tb6BkoUxKlWWf5F95hxSJwJ+o8TrcunNkuPnxL+b91ltrMZr/69vVXje6WqYEU3pURNqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linutronix.de smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hY0i6bi2uvvmZog9ilTyDwxncwV6RqWe/5YU5JNFb/Q=;
 b=qNfgwJpY/xoQcKGStq2mesUhTGu0sTW8pWo3x+NaPiNWo/pkCY2reRwcipw9nMf1RyCZlST88/BAHuuQF+bRrni7e+6dBTVVQ3Dw78sudZuGhXCqt6BONXxTBiNpD8CRU54mCW66JxCaPC7bhf/0GmRlIDogLBehjSwhZaq6J0g=
Received: from SN7PR04CA0214.namprd04.prod.outlook.com (2603:10b6:806:127::9)
 by MN2PR02MB5757.namprd02.prod.outlook.com (2603:10b6:208:11a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Fri, 24 Sep
 2021 06:55:11 +0000
Received: from SN1NAM02FT0023.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:127:cafe::e4) by SN7PR04CA0214.outlook.office365.com
 (2603:10b6:806:127::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Fri, 24 Sep 2021 06:55:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0023.mail.protection.outlook.com (10.97.4.236) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Fri, 24 Sep 2021 06:55:11 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 23 Sep 2021 23:55:10 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 23 Sep 2021 23:55:10 -0700
Envelope-to: tglx@linutronix.de,
 daniel.lezcano@linaro.org,
 alvaro.gamez@hazent.com,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 lee.jones@linaro.org,
 u.kleine-koenig@pengutronix.de,
 thierry.reding@gmail.com,
 devicetree@vger.kernel.org,
 linux-pwm@vger.kernel.org,
 sean.anderson@seco.com
Received: from [10.254.241.49] (port=58062)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1mTf4C-0005Md-Ir; Thu, 23 Sep 2021 23:52:16 -0700
Subject: Re: [PATCH v7 2/3] clocksource: Rewrite Xilinx AXI timer driver
To:     Sean Anderson <sean.anderson@seco.com>,
        <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        <michal.simek@xilinx.com>, Lee Jones <lee.jones@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20210916180544.2873770-1-sean.anderson@seco.com>
 <20210916180544.2873770-2-sean.anderson@seco.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <696e2f8b-1737-0686-40cb-575a8fa2fa61@xilinx.com>
Date:   Fri, 24 Sep 2021 08:52:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210916180544.2873770-2-sean.anderson@seco.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7cde6f69-fb8d-48e2-7be6-08d97f2840fb
X-MS-TrafficTypeDiagnostic: MN2PR02MB5757:
X-Microsoft-Antispam-PRVS: <MN2PR02MB57572AA751FC4BC3C330316CC6A49@MN2PR02MB5757.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rhhk1j0KaG4jwQw6Q7U21MRABsWX6KSkCe2Z0v2UNLJVrqovwI+y6btliKjOIOCrYFO8VX/bTlJk9xyXYcmq6a4la+MwhSt6R3zD2uoiNZ6ZlF9bpAVxm5/MIlb5UqjBuN51WgAQYe/JQuwoyKm9gtYS44V1j9twHlEb/gvenp5LqdUnLDWdAR4iOEFntZcZUgb0qXaiNG+NVA+S+kg+udUDoGxmyY2s/c0MmME06/iN/kSntxNJ6Fooxo3b9+8XNtKkExkA7QkIL7t9RpeDvtM6VP4gGwrtFoxE0YKmuAPFI8e4UlaCDMgYPIhWTgpRELOyMGL7TGBsJldKJ/BLuedqWskyAsVDE989VXjxhf7qxvRaCY09CC4Nj3WV4CFqEtaCm4GS/MTLlzUXwRDAdzSCYnJ8hHGdqR/bSPJQWlnLPi5T+hdcS6yr8pdEroTDF/pbmNOILle2rz5mbjTGlyyEIt/jRMC3BC+UjLudPgVJuEEj4bhvCBN8wiLTc871x0SiLcl2+5nKqV0ALmV9ECxszyk/2slkHEk1oEdW/+B0K/d6qFQDCl18pPDnrpsleXXMdXvqRV4vzNtUBNJhUNSei6EUMBj6x5PFOVNjqm9nyOHoW4kM4p/lqpKnjY6kl341U8i/Nbo/2cq4GtMC9oITIY3P6W11XOSPPx5457l0dihtWaPZJkdZ5AHt+gAqorvFHNn5+LIg/SlNf+qx+2sUUVNY84tlNN6kovspy6RYczr2AFvnyn1yDtznk6uotVmT9UMwVUKWw4jFiG6Jrw==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(110136005)(47076005)(44832011)(508600001)(36906005)(36756003)(336012)(36860700001)(7416002)(83380400001)(82310400003)(2906002)(316002)(54906003)(5660300002)(356005)(4326008)(31686004)(2616005)(7636003)(426003)(6666004)(186003)(8936002)(9786002)(8676002)(70586007)(70206006)(53546011)(31696002)(26005)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2021 06:55:11.3938
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cde6f69-fb8d-48e2-7be6-08d97f2840fb
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0023.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB5757
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Dear Sean,

On 9/16/21 8:05 PM, Sean Anderson wrote:
> This rewrites the Xilinx AXI timer driver to be more platform agnostic.
> Some common code has been split off so it can be reused. These routines
> currently live in drivers/mfd. The largest changes are summarized below:
> 
> - We now support any number of timer devices, possibly with only one
>   counter each. The first counter will be used as a clocksource. Every
>   other counter will be used as a clockevent. This allocation scheme was
>   chosen arbitrarily.
> - We do not use timer_of_init because we need to perform some tasks in
>   between different stages. For example, we must ensure that ->read and
>   ->write are initialized before registering the irq. This can only happen
>   after we have gotten the register base (to detect endianness). We also
>   have a rather unusual clock initialization sequence in order to remain
>   backwards compatible. Due to this, it's ok for the initial clock request
>   to fail, and we do not want other initialization to be undone. Lastly, it
>   is more convenient to do one allocation for xilinx_clockevent_device than
>   to do one for timer_of and one for xilinx_timer_priv.
> - We now pay attention to xlnx,count-width and handle smaller width timers.
>   The default remains 32.
> - We access registers using regmap. This automatically deals with
>   endianness issues, so we no longer have to use our own wrappers. It
>   also provides locking for clockevents which have to worry about being
>   interrupted in the middle of a read/modify/write.
> 
> Note that while the existing timer driver always sets the cpumask to cpu
> 0, this version sets it to all possible CPUs. I believe this is correct
> for multiprocessor systems where the timer is not physically wired to a
> particular CPU's interrupt line. For uniprocessor systems (like most
> microblaze systems) this makes no difference.
> 
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> ---
> This has been tested on microblaze qemu.
> 
> Changes in v7:
> - Add dependency on OF_ADDRESS
> 
> Changes in v6:
> - Add __init* attributes
> - Export common symbols
> - Fix goto'ing incorrect label for cleanup
> - Remove duplicate regmap_config
> - Round to closest period in xilinx_timer_get_period to ensure proper
>   semantics for xilinx_pwm_get_state
> 
> Changes in v5:
> - Fix some overflows when setting the max value for clockevent and
>   sched_clock
> - Just use clk_register_fixed_rate instead of the "private" version
> - Remove duplicate register definitions
> - Remove xilinx_timer_tlr_period
> - Remove xlnx,axi-timer-2.0 compatible string
> - Require that callers check arguments to xilinx_timer_tlr_cycles
> - Use regmap to deal with endianness issues as suggested by Lee
> 
> Changes in v4:
> - Break out clock* drivers into their own file
> 
>  MAINTAINERS                               |   6 +
>  arch/microblaze/kernel/Makefile           |   3 +-
>  arch/microblaze/kernel/timer.c            | 326 ----------------------
>  drivers/clocksource/Kconfig               |  13 +
>  drivers/clocksource/Makefile              |   1 +
>  drivers/clocksource/timer-xilinx-common.c |  71 +++++
>  drivers/clocksource/timer-xilinx.c        | 323 +++++++++++++++++++++
>  include/clocksource/timer-xilinx.h        |  91 ++++++
>  8 files changed, 506 insertions(+), 328 deletions(-)
>  delete mode 100644 arch/microblaze/kernel/timer.c
>  create mode 100644 drivers/clocksource/timer-xilinx-common.c
>  create mode 100644 drivers/clocksource/timer-xilinx.c
>  create mode 100644 include/clocksource/timer-xilinx.h


I have said it couple of times. I won't accept this in this form.
I have no problem to move this driver out of microblaze. But I want to
see transition from current state to new state and check it with baby
steps which are bisectable if any problem happens.
Because in this style we end in this patch and it will take some time to
find out what it is failing.

That's why my NACK.

Thanks,
Michal

