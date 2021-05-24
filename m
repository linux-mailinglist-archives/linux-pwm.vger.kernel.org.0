Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A92F638E143
	for <lists+linux-pwm@lfdr.de>; Mon, 24 May 2021 09:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbhEXHC3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 24 May 2021 03:02:29 -0400
Received: from mail-dm6nam12on2040.outbound.protection.outlook.com ([40.107.243.40]:7008
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232120AbhEXHC2 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 24 May 2021 03:02:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EGNwRuUh+8HGtlVrFz+cIgJkvcT90RPY7Bs4DoT9SfrwJ2O4YkS2SV1PqTgjVrUt0SJgqIUSkhj4X5EjJLUN2ib29pPik1OmdvVJurnkahDSx/NF/PmiJDdvkRaEsmk3a4dHxkeN60pHIHfBrkXy3huBkjdkXJUGRawmNE2IeefCLWkobrBjxFTeWImgK5YhC6L5qo3bzzRnjddUF4+nyQxF9UhMvDNLMCXXq1B5xEZU0Q2uXJrU0fQVLmNAd8WG6Tr6lCVyvSKIkBCstzVKq86TjGMG/DYQwwOqbGoEtuG1EXpQheGyaJGD22SUT3xUeeAlytgrCYInfs9TcyY6JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jU8HbE4NuAyN1xUGZFGzQPcMUNo+aEWm46VFc1nd8o4=;
 b=MukY0y2EIAa5SgnATUa/Z0McaGShqI09IqZkk0Phl+qg1a+eQIO9iYLDYdg4A43w4TG+EeuHGCbodJPbdf+07BiWwGT9tiu8LK7MXWCorVBZ2YPjjbz4v3796CVAJ2oSI7Bv/KQ9GinguekS8inWddMuRCmJlEOTSHNrJmdv20xssjoj7mhQZht/fk95AHuIKSpkP/m6zLk7P1zvuO7NI05qVPtmS09uaiy83sp8+Gy03quvaAmo+oFL4zMfa/09NR2R/OWshYfgpD91QkSCDH00tG104hg7+AXXI1ShjRuZOnuht9sRrm2GIlQjcVYTK+dk9tDlUcQKroHjBiflEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linutronix.de smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jU8HbE4NuAyN1xUGZFGzQPcMUNo+aEWm46VFc1nd8o4=;
 b=oOBaEbv9P/8SNXKyLIN+xnYKpAQYJtuAkuVzps+/pxnCI38DaWLc32i26w7CoNy6HG4oyCxAOO3H6VK1kc+HIYgP997Boa7oxJHS5P8dmRrDKtMxRjQlmUL+7pTJCmfxJxXktGz5enIuThGT6nz4uxVdi12Qrd72itDIDGOnLeg=
Received: from DM6PR13CA0056.namprd13.prod.outlook.com (2603:10b6:5:134::33)
 by MN2PR02MB6446.namprd02.prod.outlook.com (2603:10b6:208:118::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Mon, 24 May
 2021 07:00:58 +0000
Received: from DM3NAM02FT016.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::3e) by DM6PR13CA0056.outlook.office365.com
 (2603:10b6:5:134::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.11 via Frontend
 Transport; Mon, 24 May 2021 07:00:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT016.mail.protection.outlook.com (10.13.4.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.27 via Frontend Transport; Mon, 24 May 2021 07:00:57 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 00:00:55 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 24 May 2021 00:00:55 -0700
Envelope-to: tglx@linutronix.de,
 lee.jones@linaro.org,
 daniel.lezcano@linaro.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 alvaro.gamez@hazent.com,
 u.kleine-koenig@pengutronix.de,
 thierry.reding@gmail.com,
 robh+dt@kernel.org,
 devicetree@vger.kernel.org,
 linux-pwm@vger.kernel.org,
 sean.anderson@seco.com
Received: from [172.30.17.109] (port=46096)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1ll4a6-0007D0-Ub; Mon, 24 May 2021 00:00:55 -0700
To:     Sean Anderson <sean.anderson@seco.com>,
        Michal Simek <michal.simek@xilinx.com>,
        <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
CC:     Alvaro Gamez <alvaro.gamez@hazent.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20210511191239.774570-1-sean.anderson@seco.com>
 <20210511191239.774570-2-sean.anderson@seco.com>
 <d4bb7b5d-9f38-cf60-fb0b-18f8e0ca2b1e@xilinx.com>
 <5f960034-174d-0ed8-9f52-3d5fde90e16a@seco.com>
 <9f227f96-a310-0fbd-fd34-91eb386306b9@xilinx.com>
 <7a06cf46-0f85-1edb-ca08-abd7b2543ad9@seco.com>
 <41542760-3967-4f9a-0f0c-1206e03ff494@xilinx.com>
 <d206a399-454e-d9c5-e2d3-337d098ed7aa@seco.com>
From:   Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH v3 2/2] clocksource: Add support for Xilinx AXI Timer
Message-ID: <2296d4e5-717a-0470-d487-e0924cf6c076@xilinx.com>
Date:   Mon, 24 May 2021 09:00:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <d206a399-454e-d9c5-e2d3-337d098ed7aa@seco.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c488ce47-49bc-4852-6a3f-08d91e81aeb8
X-MS-TrafficTypeDiagnostic: MN2PR02MB6446:
X-Microsoft-Antispam-PRVS: <MN2PR02MB64461EA0A34F0C3B7DA8A3FAC6269@MN2PR02MB6446.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lpEhtf/MEKV1LSZeIh9PtFm4UmblXqhpB2rqAWQn6oT+YWVGdYXhyRWzs4a+m8hIdGoQLpbDR8+6LmC3wtnpA5BiGugVRG7JWcbat3jf1dzQVRdkOhTYT4bdYQXWzWOuijEG4gaFRJ937xHtwybJ+moyt0jBA29Y+xFIDEVfH54WZ7/LzgEOwVY8Bitn+Tzs5wv2M83Jv6VTHRHo80mpHfI0p4bTXyey0ynElWCkqPQeAc0IqKkm7h6T+8vZPPuor+D/Q6gX0dS9grSZ1DdtCYkpHH8HVT42j2jgxHQFZwrQW5m6DMJs9xhhLyhNRri4/W4nybUDVk5YFvaY5jruMCD4ZSIvqtBuwXNT+LLaF4FIezPBfT+f9f+RmldyRBDHNHWChIgEPowz0bCY0qResp8xf+CAEtqvI7RDdsbm2vj4Nstjnm27rhnuNV6jm12cGrwGIh7aIE3F+szFxuUu8TJCHk43/w+EGGrEPZt0BYIrx6uEg7Yb/E1+Hd29/cqSesJ7b+dJCEiIQgJY/0370rmCNAkg4DAYYhVQyClzWFIfqoY94v35wlXs6jCc92d/OGlEHB3EONN/gtMZ+SNgW1/OwcRfyGnWeQci6SWKYiCItHEU9OGx8j5ib6bDraFNiHOxH9CbQTXYjNC9vG3Btnw7YH5zs+4u1I3iC0cBE1OH2HyFN5x4bOls9Vw2pVEnBS1J07E1mfwMpXSv91LmO+8+ydNJEJ3LPkErYVOE0rgwyeBwKBNuHRLG1wCWTyE9ruS+NbOFwvYsV+spGfc55E3bn4mK16IXiEbs4nLL1BYNof14F8K3Ptxr2035XR/+/UYIPG6IgOaEkZ9c+Bv3kg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(376002)(39850400004)(136003)(346002)(46966006)(36840700001)(336012)(8676002)(9786002)(478600001)(6666004)(4326008)(82740400003)(8936002)(70586007)(36756003)(70206006)(2616005)(44832011)(26005)(426003)(54906003)(53546011)(7636003)(966005)(5660300002)(186003)(356005)(31696002)(47076005)(110136005)(36860700001)(83380400001)(36906005)(7416002)(316002)(82310400003)(31686004)(2906002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2021 07:00:57.9602
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c488ce47-49bc-4852-6a3f-08d91e81aeb8
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT016.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6446
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 5/20/21 10:13 PM, Sean Anderson wrote:
> 
> 
> On 5/19/21 3:24 AM, Michal Simek wrote:
>>
>>
>> On 5/18/21 12:15 AM, Sean Anderson wrote:
>>>
>>>
>>> On 5/17/21 3:54 AM, Michal Simek wrote:
>>>>
>>>>
>>>> On 5/14/21 4:40 PM, Sean Anderson wrote:
>>>>>
>>>>>
>>>>> On 5/14/21 4:59 AM, Michal Simek wrote:
>>>>>>
>>>>>>
>>>>>> On 5/11/21 9:12 PM, Sean Anderson wrote:
>>>>>>> This adds generic clocksource and clockevent support for Xilinx
>>>>> LogiCORE IP
>>>>>>> AXI soft timers commonly found on Xilinx FPGAs. This timer is
> also the
>>>>>>> primary timer for Microblaze processors. This commit also adds
>>>>> support for
>>>>>>> configuring this timer as a PWM (though this could be split off if
>>>>>>> necessary). This whole driver lives in clocksource because it is
>>>>> primarily
>>>>>>> clocksource stuff now (even though it started out as a PWM
> driver). I
>>>>> think
>>>>>>> teasing apart the driver would not be worth it since they share so
>>> many
>>>>>>> functions.
>>>>>>>
>>>>>>> This driver configures timer 0 (which is always present) as a
>>>>> clocksource,
>>>>>>> and timer 1 (which might be missing) as a clockevent. I don't
> know if
>>>>> this
>>>>>>> is the correct priority for these timers, or whether we should be
>>>>> using a
>>>>>>> more dynamic allocation scheme.
>>>>>>>
>>>>>>> At the moment clock control is very basic: we just enable the clock
>>>>> during
>>>>>>> probe and pin the frequency. In the future, someone could add
> support
>>>>> for
>>>>>>> disabling the clock when not in use. Cascade mode is also
> unsupported.
>>>>>>>
>>>>>>> This driver was written with reference to Xilinx DS764 for v1.03.a
>>> [1].
>>>>>>>
>>>>>>> [1]
>>>>>
>>>
> https://www.xilinx.com/support/documentation/ip_documentation/axi_timer/v1_03_a/axi_timer_ds764.pdf
> 
>>>
>>>>>
>>>>>>>
>>>>>>> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
>>>>>>> ---
>>>>>>> Please let me know if I should organize this differently or if it
>>> should
>>>>>>> be broken up.
>>>>>>>
>>>>>>> Changes in v3:
>>>>>>> - Add clockevent and clocksource support
>>>>>>> - Rewrite probe to only use a device_node, since timers may need
> to be
>>>>>>>        initialized before we have proper devices. This does bloat
> the
>>>>> code a bit
>>>>>>>        since we can no longer rely on helpers such as dev_err_probe.
>>> We also
>>>>>>>        cannot rely on device resources being free'd on failure,
> so we
>>>>> must free
>>>>>>>        them manually.
>>>>>>> - We now access registers through xilinx_timer_(read|write). This
>>>>> allows us
>>>>>>>        to deal with endianness issues, as originally seen in the
>>> microblaze
>>>>>>>        driver. CAVEAT EMPTOR: I have not tested this on big-endian!
>>>>>>> - Remove old microblaze driver
>>>>>>>
>>>>>>> Changes in v2:
>>>>>>> - Don't compile this module by default for arm64
>>>>>>> - Add dependencies on COMMON_CLK and HAS_IOMEM
>>>>>>> - Add comment explaining why we depend on !MICROBLAZE
>>>>>>> - Add comment describing device
>>>>>>> - Rename TCSR_(SET|CLEAR) to TCSR_RUN_(SET|CLEAR)
>>>>>>> - Use NSEC_TO_SEC instead of defining our own
>>>>>>> - Use TCSR_RUN_MASK to check if the PWM is enabled, as suggested by
>>> Uwe
>>>>>>> - Cast dividends to u64 to avoid overflow
>>>>>>> - Check for over- and underflow when calculating TLR
>>>>>>> - Set xilinx_pwm_ops.owner
>>>>>>> - Don't set pwmchip.base to -1
>>>>>>> - Check range of xlnx,count-width
>>>>>>> - Ensure the clock is always running when the pwm is registered
>>>>>>> - Remove debugfs file :l
>>>>>>> - Report errors with dev_error_probe
>>>>>>>
>>>>>>>       arch/microblaze/kernel/Makefile    |   2 +-
>>>>>>>       arch/microblaze/kernel/timer.c     | 326 ---------------
>>>>>>>       drivers/clocksource/Kconfig        |  15 +
>>>>>>>       drivers/clocksource/Makefile       |   1 +
>>>>>>>       drivers/clocksource/timer-xilinx.c | 650
>>> +++++++++++++++++++++++++++++
>>>>>>>       5 files changed, 667 insertions(+), 327 deletions(-)
>>>>>>>       delete mode 100644 arch/microblaze/kernel/timer.c
>>>>>>>       create mode 100644 drivers/clocksource/timer-xilinx.c
>>>>>>
>>>>>> I don't think this is the right way to go.
>>>>>> The first patch should be move current timer driver from
> microblaze to
>>>>>> generic location and then apply patches on the top based on what you
>>> are
>>>>>> adding/fixing to be able to review every change separately.
>>>>>> When any issue happens it can be bisected and exact patch is
>>> identified.
>>>>>> With this way we will end up in this patch and it will take a lot of
>>>>>> time to find where that problem is.
>>>>>
>>>>> What parts would you like to see split? Fundamentally, this current
>>>>> patch is a reimplementation of the driver. I think the only reasonable
>>>>> split would be to add PWM support in a separate patch.
>>>>>
>>>>> I do not think that genericizing the microblaze timer driver is an
>>>>> integral part of adding PWM support. This is especially since you seem
>>>>> opposed to using existing devicetree properties to inform the
> driver. I
>>>>> am inclined to just add a patch adding a check for '#-pwm-cells' to
> the
>>>>> existing driver and otherwise leave it untouched.
>>>>
>>>> As I said I think the patches should be like this.
>>>> 1. Cover existing DT binding based on current code.
>>>> 2. Move time out of arch/microblaze to drivers/clocksource/ and even
>>>> enable it via Kconfig just for Microblaze.
>>>> 3. Remove dependency on Microblaze and enable build for others. I have
>>>> seen at least one cpuinfo.cpu_clock_freq assignment. This code can be
>>>> likely completely removed or deprecate.
>>>
>>> This could be deprecated, but cannot be removed since existing device
>>> trees (e.g. qemu) have neither clocks nor clock-frequency properties.
>>
>> Rob: Do we have any obligation to keep properties for other projects?
>>
>>
>>>> 4. Make driver as module
>>>> 5. Do whatever changes you want before adding pwm support
>>>> 6. Extend DT binding doc for PWM support
>>>> 7. Add PWM support
>>>
>>> Frankly, I am inclined to just leave the microblaze timer as-is. The PWM
>>> driver is completely independent. I have already put too much effort
> into
>>> this driver, and I don't have the energy to continue working on the
>>> microblaze timer.
>>
>> I understand. I am actually using axi timer as pwm driver in one of my
>> project but never had time to upstream it because of couple of steps
> above.
>> We need to do it right based on steps listed above. If this is too much
>> work it will have to wait. I will NACK all attempts to add separate
>> driver for IP which we already support in the tree.
> 
> 1. Many timers have separate clocksource and PWM drivers. E.g. samsung,
>    renesas TPU, etc. It is completely reasonable to keep separate
>    drivers for these purposes. There is no Linux requirement that each
>    device have only one driver, especially if it has multiple functions
>    or ways to be configured.

It doesn't mean that it was done properly and correctly. Code
duplication is bad all the time.

> 2. If you want to do work on a driver, I'm all for it. However, if you
>    have not yet submitted that work to the list, you should not gate
>    other work behind it. Saying that X feature must be gated behind Y
>    *even if X works completely independently of Y* is just stifling
>    development.

I gave you guidance how I think this should be done. I am not gating you
from this work. Your patch is not working on Microblaze arch which is
what I maintain. And I don't want to go the route that we will have two
drivers for the same IP without integration. We were there in past and
it is just pain.
I am expecting that PWM guys will guide how this should be done
properly. I haven't heard any guidance on this yet.
Thierry/Uwe: Any comment?


> 3. There is a clear desire for a PWM driver for this device. You, I, and
>    Alvaro have all written separate drivers for this device because we
>    want to use it as a PWM. By preventing merging this driver, you are
>    encouraging duplicate effort by the next person who wants to use this
>    device as a PWM, and sees that there is no driver in the tree.

We should do it cleanly that it will be easy to maintain which is not by
creating two separate drivers or by switching to completely new driver.

Thanks,
Michal
