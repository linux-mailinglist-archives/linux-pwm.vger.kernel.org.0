Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E47E038881A
	for <lists+linux-pwm@lfdr.de>; Wed, 19 May 2021 09:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237886AbhESH0H (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 19 May 2021 03:26:07 -0400
Received: from mail-bn8nam11on2045.outbound.protection.outlook.com ([40.107.236.45]:5997
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230292AbhESH0G (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 19 May 2021 03:26:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cbxgCJ9+WPWg9EFk9Gt57x1KU7Cfr8tXrQ5DQOdM1YxeTy0nDxHB9cNigLPabHDe0KOQogLETXNZtzFMJP9fbPnBVZCpHVIA+LMLP6EMNaPw/H+hh6KFILoxKPqCxyCeoHM2mxlT4Hyffx0iUMEw87OrxaQQUUvcpQXWuKMzWsmJvS5OzuANLqZ2Qj+KUgY634gjjDVQjXhlKIko+MEobYIYgIewa50v2+rn01z/FYvJ8wZ3VG8/FbyHDOFD/Gq92+NiO22P6o4ayBBnkuco8txWbd1kCYsJKNwkqus9ZVb8emryiOaJh5I4WgVOiYrCQ3fX3e7dEx/9DaHOvFmVrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=guREZVyG9B2ZyL2M1fG5DfRo18rpMxZCovgU0Y6lerU=;
 b=TNnsvzrBBgZNw3LVnkT72lb++dE5YLkrpS8sIt0+Nabqgy7Bw2BGjUQrXZpRB9JRXsj1A8NSc0RL6Vv4nW4HqQ4JwHAfdu47UEMz7yHHhmntwhEpvScZZj90xEZj9EU22i8OPd+t9b/Gc+cDiZjKXVurbmXshRwhFZykbFCHooF0Hz+sy62uTZbI5Ln3sLO9a50L3RczfvYeupOMi5WefaPEMRRcOy8nh7pe/ZZP5oeKHOxWr1qi3JztiNoOXEVfOyBUW1u+EIRwByoFeOigI2FMJoL3Funx2m/vKGHFHNz6A8Z5lVKPr/nuxv3cqfGiDOgWXsUUPHQeW9hhO4F4VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=guREZVyG9B2ZyL2M1fG5DfRo18rpMxZCovgU0Y6lerU=;
 b=De4LOTPUSzLLeK9Z32phljSX4qO6g4f/6CZSIZt8Nn3z3B4THWxqz0pjExgZVekJE/PHdmZ4f4B/g3Df6+w98t0Ig4ZbANAOZgdUR0YSSMC6UQLimAXS3qHnMepqdO0z0Ev/YJIeThWZ4fpFYFrtspnrbcXfG48QAEGis+HT1pw=
Received: from DM3PR12CA0113.namprd12.prod.outlook.com (2603:10b6:0:55::33) by
 DM6PR02MB4475.namprd02.prod.outlook.com (2603:10b6:5:2d::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.28; Wed, 19 May 2021 07:24:44 +0000
Received: from DM3NAM02FT016.eop-nam02.prod.protection.outlook.com
 (2603:10b6:0:55:cafe::7f) by DM3PR12CA0113.outlook.office365.com
 (2603:10b6:0:55::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25 via Frontend
 Transport; Wed, 19 May 2021 07:24:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT016.mail.protection.outlook.com (10.13.4.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.27 via Frontend Transport; Wed, 19 May 2021 07:24:44 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 19 May 2021 00:24:43 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 19 May 2021 00:24:43 -0700
Envelope-to: u.kleine-koenig@pengutronix.de,
 tglx@linutronix.de,
 thierry.reding@gmail.com,
 lee.jones@linaro.org,
 daniel.lezcano@linaro.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 alvaro.gamez@hazent.com,
 robh+dt@kernel.org,
 devicetree@vger.kernel.org,
 linux-pwm@vger.kernel.org,
 sean.anderson@seco.com
Received: from [172.30.17.109] (port=43588)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1ljGZP-0006Wv-Db; Wed, 19 May 2021 00:24:43 -0700
To:     Sean Anderson <sean.anderson@seco.com>,
        Michal Simek <michal.simek@xilinx.com>,
        <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Alvaro Gamez <alvaro.gamez@hazent.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
References: <20210511191239.774570-1-sean.anderson@seco.com>
 <20210511191239.774570-2-sean.anderson@seco.com>
 <d4bb7b5d-9f38-cf60-fb0b-18f8e0ca2b1e@xilinx.com>
 <5f960034-174d-0ed8-9f52-3d5fde90e16a@seco.com>
 <9f227f96-a310-0fbd-fd34-91eb386306b9@xilinx.com>
 <7a06cf46-0f85-1edb-ca08-abd7b2543ad9@seco.com>
From:   Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH v3 2/2] clocksource: Add support for Xilinx AXI Timer
Message-ID: <41542760-3967-4f9a-0f0c-1206e03ff494@xilinx.com>
Date:   Wed, 19 May 2021 09:24:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <7a06cf46-0f85-1edb-ca08-abd7b2543ad9@seco.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc28cbba-82b2-4b34-6cad-08d91a972cda
X-MS-TrafficTypeDiagnostic: DM6PR02MB4475:
X-Microsoft-Antispam-PRVS: <DM6PR02MB44753B9123BB9CBF82866652C62B9@DM6PR02MB4475.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mlKDPD99otYJPiML3jZmQCazfaavTkS4B1US/5JtLvqvKx3y8PNS9+y2hsqzLim6HkkfPmhHUVGftzALnKk461BeK8NPgm0vrnsPe/CCKnpPtrRQnbrBDdme3ffvXUAJJbSJfjPxjaz8P48m06OzShsCr1aL8ApiJI8lReySZ7Zu92f5kRP6Cm1sAZxDaskmvT/Dq38qGMqd2FaXynvXfLXXLhH78nR7fMwzDyYb9lpr2vqxJTgEQZhL47K/lmFqgwGe0yRs71xqD23riQ0e5kviIvtbtvMIsWBeDcqQl7didqWZ73tVgu7ULmd6M8FOfglqNRqkZTQuvEJsVoGAroARXxFZ284WEVzr6uVAzXeBVTeX4KdiScFJi5lVtqdaXtp1WW2INDl61frzoM8YxaLUztlr+C5pZ2pzd/Cp7F6+orOxRqzt0kn7D/F6AP+6cXsEeAbKZqRIJyv7hO61TVmMs5CqGSoq6ad8TJUz2E4TyO3KDTgHhVhWZGArJcJknivYOSzWNRW3UfCiBitISx/uOUqymO55DhBNAa8A5udMLRLrYuPbxA3jOp8LPZLsv4VW3x/csxbYe45q4BCaX8fUhF85EIBkcj8s2HfyTcT/zsWQiyYe/D5EZhuK3B/UaMCulAzMSeX3ACxi5jIQsxBtaDV5pEegGiFJhveRt7muzd/oxVBfFCIAvxPJe8qXnbkeL9WJKEFLX8Zc/lucjo7qqLJfCQAqr6ouczeCvLGLUo6GzUPdD5CjCGaRQ86GXxiBD3WhZ3ypRpUDX0RwD6RYezxPLvIgCbkexgoQLNk=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39830400003)(376002)(136003)(396003)(346002)(46966006)(36840700001)(966005)(186003)(426003)(53546011)(26005)(36860700001)(7636003)(5660300002)(8676002)(478600001)(31686004)(70206006)(70586007)(44832011)(2616005)(31696002)(36756003)(4326008)(9786002)(7416002)(47076005)(110136005)(83380400001)(54906003)(356005)(82310400003)(336012)(8936002)(2906002)(316002)(36906005)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 07:24:44.3622
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc28cbba-82b2-4b34-6cad-08d91a972cda
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT016.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4475
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 5/18/21 12:15 AM, Sean Anderson wrote:
> 
> 
> On 5/17/21 3:54 AM, Michal Simek wrote:
>>
>>
>> On 5/14/21 4:40 PM, Sean Anderson wrote:
>>>
>>>
>>> On 5/14/21 4:59 AM, Michal Simek wrote:
>>>>
>>>>
>>>> On 5/11/21 9:12 PM, Sean Anderson wrote:
>>>>> This adds generic clocksource and clockevent support for Xilinx
>>> LogiCORE IP
>>>>> AXI soft timers commonly found on Xilinx FPGAs. This timer is also the
>>>>> primary timer for Microblaze processors. This commit also adds
>>> support for
>>>>> configuring this timer as a PWM (though this could be split off if
>>>>> necessary). This whole driver lives in clocksource because it is
>>> primarily
>>>>> clocksource stuff now (even though it started out as a PWM driver). I
>>> think
>>>>> teasing apart the driver would not be worth it since they share so
> many
>>>>> functions.
>>>>>
>>>>> This driver configures timer 0 (which is always present) as a
>>> clocksource,
>>>>> and timer 1 (which might be missing) as a clockevent. I don't know if
>>> this
>>>>> is the correct priority for these timers, or whether we should be
>>> using a
>>>>> more dynamic allocation scheme.
>>>>>
>>>>> At the moment clock control is very basic: we just enable the clock
>>> during
>>>>> probe and pin the frequency. In the future, someone could add support
>>> for
>>>>> disabling the clock when not in use. Cascade mode is also unsupported.
>>>>>
>>>>> This driver was written with reference to Xilinx DS764 for v1.03.a
> [1].
>>>>>
>>>>> [1]
>>>
> https://www.xilinx.com/support/documentation/ip_documentation/axi_timer/v1_03_a/axi_timer_ds764.pdf
> 
>>>
>>>>>
>>>>> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
>>>>> ---
>>>>> Please let me know if I should organize this differently or if it
> should
>>>>> be broken up.
>>>>>
>>>>> Changes in v3:
>>>>> - Add clockevent and clocksource support
>>>>> - Rewrite probe to only use a device_node, since timers may need to be
>>>>>      initialized before we have proper devices. This does bloat the
>>> code a bit
>>>>>      since we can no longer rely on helpers such as dev_err_probe.
> We also
>>>>>      cannot rely on device resources being free'd on failure, so we
>>> must free
>>>>>      them manually.
>>>>> - We now access registers through xilinx_timer_(read|write). This
>>> allows us
>>>>>      to deal with endianness issues, as originally seen in the
> microblaze
>>>>>      driver. CAVEAT EMPTOR: I have not tested this on big-endian!
>>>>> - Remove old microblaze driver
>>>>>
>>>>> Changes in v2:
>>>>> - Don't compile this module by default for arm64
>>>>> - Add dependencies on COMMON_CLK and HAS_IOMEM
>>>>> - Add comment explaining why we depend on !MICROBLAZE
>>>>> - Add comment describing device
>>>>> - Rename TCSR_(SET|CLEAR) to TCSR_RUN_(SET|CLEAR)
>>>>> - Use NSEC_TO_SEC instead of defining our own
>>>>> - Use TCSR_RUN_MASK to check if the PWM is enabled, as suggested by
> Uwe
>>>>> - Cast dividends to u64 to avoid overflow
>>>>> - Check for over- and underflow when calculating TLR
>>>>> - Set xilinx_pwm_ops.owner
>>>>> - Don't set pwmchip.base to -1
>>>>> - Check range of xlnx,count-width
>>>>> - Ensure the clock is always running when the pwm is registered
>>>>> - Remove debugfs file :l
>>>>> - Report errors with dev_error_probe
>>>>>
>>>>>     arch/microblaze/kernel/Makefile    |   2 +-
>>>>>     arch/microblaze/kernel/timer.c     | 326 ---------------
>>>>>     drivers/clocksource/Kconfig        |  15 +
>>>>>     drivers/clocksource/Makefile       |   1 +
>>>>>     drivers/clocksource/timer-xilinx.c | 650
> +++++++++++++++++++++++++++++
>>>>>     5 files changed, 667 insertions(+), 327 deletions(-)
>>>>>     delete mode 100644 arch/microblaze/kernel/timer.c
>>>>>     create mode 100644 drivers/clocksource/timer-xilinx.c
>>>>
>>>> I don't think this is the right way to go.
>>>> The first patch should be move current timer driver from microblaze to
>>>> generic location and then apply patches on the top based on what you
> are
>>>> adding/fixing to be able to review every change separately.
>>>> When any issue happens it can be bisected and exact patch is
> identified.
>>>> With this way we will end up in this patch and it will take a lot of
>>>> time to find where that problem is.
>>>
>>> What parts would you like to see split? Fundamentally, this current
>>> patch is a reimplementation of the driver. I think the only reasonable
>>> split would be to add PWM support in a separate patch.
>>>
>>> I do not think that genericizing the microblaze timer driver is an
>>> integral part of adding PWM support. This is especially since you seem
>>> opposed to using existing devicetree properties to inform the driver. I
>>> am inclined to just add a patch adding a check for '#-pwm-cells' to the
>>> existing driver and otherwise leave it untouched.
>>
>> As I said I think the patches should be like this.
>> 1. Cover existing DT binding based on current code.
>> 2. Move time out of arch/microblaze to drivers/clocksource/ and even
>> enable it via Kconfig just for Microblaze.
>> 3. Remove dependency on Microblaze and enable build for others. I have
>> seen at least one cpuinfo.cpu_clock_freq assignment. This code can be
>> likely completely removed or deprecate.
> 
> This could be deprecated, but cannot be removed since existing device
> trees (e.g. qemu) have neither clocks nor clock-frequency properties.

Rob: Do we have any obligation to keep properties for other projects?


>> 4. Make driver as module
>> 5. Do whatever changes you want before adding pwm support
>> 6. Extend DT binding doc for PWM support
>> 7. Add PWM support
> 
> Frankly, I am inclined to just leave the microblaze timer as-is. The PWM
> driver is completely independent. I have already put too much effort into
> this driver, and I don't have the energy to continue working on the
> microblaze timer.

I understand. I am actually using axi timer as pwm driver in one of my
project but never had time to upstream it because of couple of steps above.
We need to do it right based on steps listed above. If this is too much
work it will have to wait. I will NACK all attempts to add separate
driver for IP which we already support in the tree.

Thanks,
Michal
