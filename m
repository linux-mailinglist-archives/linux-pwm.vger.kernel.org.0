Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7836E3825E7
	for <lists+linux-pwm@lfdr.de>; Mon, 17 May 2021 09:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235221AbhEQHzp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 17 May 2021 03:55:45 -0400
Received: from mail-dm6nam08on2053.outbound.protection.outlook.com ([40.107.102.53]:18528
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231482AbhEQHzk (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 17 May 2021 03:55:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JyYl4N/C9kD/tJTDZJSuAtnE+LO2J0KgtfItsertWGb5RRhqbtBUXCPi0xqcBiUiCK1ITZfn6jMlbjVZauG8IkaEPxaYpp+joikkQKsLK7ydt4qedcHgidVti7k5rqMGEWUF4G9Op2ePFCqL3pWnYo/aG5L4T2HMI8E+01g4xxn6wo6qz4EdqCDmgOPjb61pTaOBokCam4/vyEcXwu4ULC9nCk9Wup/j5PROSO1LlmjZ3k3cVjhtJp2n58JVHIi9z026TJxOounqk+eV8+dBhqP1k2vOD4dYszAQxkiaex8oYEl5+cy0GDxe4I7ZnE2vN+tusF74DIaQgqa1ZvZCRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JWbqnjhQiNunk1/r8yb2W2yUWZt6tdzG4lXocU95T1Q=;
 b=NKaQ3E9v6IXBGFQUplYtvzZO21pFlGZCjwd3zsZ5QrQpDsCyOUh23iu/ktSsJCEMoqC+C55H7StllMVq2eCqD4pLByjmAZvha9fEIzy++5vVGAswSVUabbqfm0tT+4LI7t0/2J523tSxbD4St8NJNAVfwRU5z4Jdn7Y3essk19ldkq/qjZjh7n2XO+KvwMUpKgA1ODfzODPqonU6xJGOHaNoEPAP4Hpq8OsOoG9140nG7VqwUj8h+xtZiLOAg5+7EMlgY/Ue/mZl/6R86k4RAeVA9o9TYfsYcjiHyxJZOvmTFBLp4opwoYTKb0TvnuXDP6CblUEw8YrmJUdqHiL/Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JWbqnjhQiNunk1/r8yb2W2yUWZt6tdzG4lXocU95T1Q=;
 b=U4OZZlFci511TrDJ7JiJIl8w0qHE9VV3yBrWOSMFGaCawJ6ACr3Q1O11c35wSqQU0E0by3SXnLax3coGoH85zVHjDN107HrP9JqMUccxiCx+oqEWyhYIteOX/mfwY5bVpTvfidtyQLMcp4fZLhVCvmtuAxX9d6aJALlYK8XedhA=
Received: from BN8PR15CA0041.namprd15.prod.outlook.com (2603:10b6:408:80::18)
 by DM5PR02MB2667.namprd02.prod.outlook.com (2603:10b6:3:10d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Mon, 17 May
 2021 07:54:22 +0000
Received: from BN1NAM02FT014.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::94) by BN8PR15CA0041.outlook.office365.com
 (2603:10b6:408:80::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25 via Frontend
 Transport; Mon, 17 May 2021 07:54:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT014.mail.protection.outlook.com (10.13.2.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.27 via Frontend Transport; Mon, 17 May 2021 07:54:22 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 17 May 2021 00:54:22 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 17 May 2021 00:54:22 -0700
Envelope-to: u.kleine-koenig@pengutronix.de,
 tglx@linutronix.de,
 thierry.reding@gmail.com,
 lee.jones@linaro.org,
 daniel.lezcano@linaro.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 alvaro.gamez@hazent.com,
 devicetree@vger.kernel.org,
 linux-pwm@vger.kernel.org,
 sean.anderson@seco.com
Received: from [172.30.17.109] (port=49080)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1liY4z-0008CY-NC; Mon, 17 May 2021 00:54:22 -0700
To:     Sean Anderson <sean.anderson@seco.com>,
        Michal Simek <michal.simek@xilinx.com>,
        <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>
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
From:   Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH v3 2/2] clocksource: Add support for Xilinx AXI Timer
Message-ID: <9f227f96-a310-0fbd-fd34-91eb386306b9@xilinx.com>
Date:   Mon, 17 May 2021 09:54:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <5f960034-174d-0ed8-9f52-3d5fde90e16a@seco.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f17c3f0f-fc29-4ec2-1d77-08d91908fbfd
X-MS-TrafficTypeDiagnostic: DM5PR02MB2667:
X-Microsoft-Antispam-PRVS: <DM5PR02MB266707BBCD524E18659A5F95C62D9@DM5PR02MB2667.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yW3+amuZf/sq/uYsJIJZXWj1FKiGVnOsEKn3Tp9Ja4TfVOnl+c19ro+19T7/awQtN0AEv2Pu8hKBt22w/zpFMw+j98zlYHugQ8x1q/kFXAh5OSd1EO4SrCz0WtbAGQAniMhwsRbIoIMsPQR0+K8TYQE90RzmIAjoigdCSMmzbgz4k3S80KITaTp736k1H2oklxiT8bakDz8E/FcUCpH+B2TSfPmXmmYKTLZh2bVJAsZKOgGyVUH1BBauhNqyYw7aCmN7T4JwHRh37uGgEFlHlcKQMa+0BrQU46hbK20PxYqkCvY3DUimneEn6LgE65UWStWZD+RrLgu0m5mxhWsDK9tghnc4UKqX/IdBlM/LtbJsJRCl4cUAnn9+5WdUpQbSgLjEazjZMNET/49ciNoCirD07PWJA7QHzz9DRfVolTDaGR6jXh64XuMO7x5F4xXX9ibOpU2clnKkVMpGwyv1wLDJPs87ssQzb58lxRED4Uyditrge6xtLXsOv0e1RAaQqYJ8dg7RfNTKhkQmffalcxAnvKROXgLIMqUFg+Jt4EOjxrPhjFwvuqpovyRVZTseDq+fFZ/9QpkbyTHYMZrkPTsZFUBeyJJqRufR3LCja7Ux1dK7lhA50eTbSLpfW1eg+OekbwLuFs7H7zknFd/6+flE8K8y7E6JOdtgK+3sV97M4CYyDa/yeJAbZZ/rmIJsrq9AoMCSeY7KPr5d/vm8zT600igsKQHRrtMTtF/6ybrYv1ojA6eyvYEhM9CGAnu+BaQQrrJto0D/yxqRUmTVbZfO5S9fgfePjzRrY2Esnhtpy7X2EELXwNfOFkIrP55vtv/u5JXTop+vT+sIBGtaFw==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(396003)(39850400004)(136003)(376002)(46966006)(36840700001)(356005)(336012)(5660300002)(31686004)(7636003)(36860700001)(47076005)(6666004)(82740400003)(426003)(478600001)(82310400003)(2906002)(186003)(4326008)(31696002)(110136005)(316002)(7416002)(36906005)(2616005)(83380400001)(44832011)(53546011)(9786002)(36756003)(54906003)(70586007)(70206006)(8936002)(8676002)(966005)(26005)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 07:54:22.6188
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f17c3f0f-fc29-4ec2-1d77-08d91908fbfd
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT014.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2667
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 5/14/21 4:40 PM, Sean Anderson wrote:
> 
> 
> On 5/14/21 4:59 AM, Michal Simek wrote:
>>
>>
>> On 5/11/21 9:12 PM, Sean Anderson wrote:
>>> This adds generic clocksource and clockevent support for Xilinx
> LogiCORE IP
>>> AXI soft timers commonly found on Xilinx FPGAs. This timer is also the
>>> primary timer for Microblaze processors. This commit also adds
> support for
>>> configuring this timer as a PWM (though this could be split off if
>>> necessary). This whole driver lives in clocksource because it is
> primarily
>>> clocksource stuff now (even though it started out as a PWM driver). I
> think
>>> teasing apart the driver would not be worth it since they share so many
>>> functions.
>>>
>>> This driver configures timer 0 (which is always present) as a
> clocksource,
>>> and timer 1 (which might be missing) as a clockevent. I don't know if
> this
>>> is the correct priority for these timers, or whether we should be
> using a
>>> more dynamic allocation scheme.
>>>
>>> At the moment clock control is very basic: we just enable the clock
> during
>>> probe and pin the frequency. In the future, someone could add support
> for
>>> disabling the clock when not in use. Cascade mode is also unsupported.
>>>
>>> This driver was written with reference to Xilinx DS764 for v1.03.a [1].
>>>
>>> [1]
> https://www.xilinx.com/support/documentation/ip_documentation/axi_timer/v1_03_a/axi_timer_ds764.pdf
> 
>>>
>>> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
>>> ---
>>> Please let me know if I should organize this differently or if it should
>>> be broken up.
>>>
>>> Changes in v3:
>>> - Add clockevent and clocksource support
>>> - Rewrite probe to only use a device_node, since timers may need to be
>>>    initialized before we have proper devices. This does bloat the
> code a bit
>>>    since we can no longer rely on helpers such as dev_err_probe. We also
>>>    cannot rely on device resources being free'd on failure, so we
> must free
>>>    them manually.
>>> - We now access registers through xilinx_timer_(read|write). This
> allows us
>>>    to deal with endianness issues, as originally seen in the microblaze
>>>    driver. CAVEAT EMPTOR: I have not tested this on big-endian!
>>> - Remove old microblaze driver
>>>
>>> Changes in v2:
>>> - Don't compile this module by default for arm64
>>> - Add dependencies on COMMON_CLK and HAS_IOMEM
>>> - Add comment explaining why we depend on !MICROBLAZE
>>> - Add comment describing device
>>> - Rename TCSR_(SET|CLEAR) to TCSR_RUN_(SET|CLEAR)
>>> - Use NSEC_TO_SEC instead of defining our own
>>> - Use TCSR_RUN_MASK to check if the PWM is enabled, as suggested by Uwe
>>> - Cast dividends to u64 to avoid overflow
>>> - Check for over- and underflow when calculating TLR
>>> - Set xilinx_pwm_ops.owner
>>> - Don't set pwmchip.base to -1
>>> - Check range of xlnx,count-width
>>> - Ensure the clock is always running when the pwm is registered
>>> - Remove debugfs file :l
>>> - Report errors with dev_error_probe
>>>
>>>   arch/microblaze/kernel/Makefile    |   2 +-
>>>   arch/microblaze/kernel/timer.c     | 326 ---------------
>>>   drivers/clocksource/Kconfig        |  15 +
>>>   drivers/clocksource/Makefile       |   1 +
>>>   drivers/clocksource/timer-xilinx.c | 650 +++++++++++++++++++++++++++++
>>>   5 files changed, 667 insertions(+), 327 deletions(-)
>>>   delete mode 100644 arch/microblaze/kernel/timer.c
>>>   create mode 100644 drivers/clocksource/timer-xilinx.c
>>
>> I don't think this is the right way to go.
>> The first patch should be move current timer driver from microblaze to
>> generic location and then apply patches on the top based on what you are
>> adding/fixing to be able to review every change separately.
>> When any issue happens it can be bisected and exact patch is identified.
>> With this way we will end up in this patch and it will take a lot of
>> time to find where that problem is.
> 
> What parts would you like to see split? Fundamentally, this current
> patch is a reimplementation of the driver. I think the only reasonable
> split would be to add PWM support in a separate patch.
> 
> I do not think that genericizing the microblaze timer driver is an
> integral part of adding PWM support. This is especially since you seem
> opposed to using existing devicetree properties to inform the driver. I
> am inclined to just add a patch adding a check for '#-pwm-cells' to the
> existing driver and otherwise leave it untouched.

As I said I think the patches should be like this.
1. Cover existing DT binding based on current code.
2. Move time out of arch/microblaze to drivers/clocksource/ and even
enable it via Kconfig just for Microblaze.
3. Remove dependency on Microblaze and enable build for others. I have
seen at least one cpuinfo.cpu_clock_freq assignment. This code can be
likely completely removed or deprecate.
4. Make driver as module
5. Do whatever changes you want before adding pwm support
6. Extend DT binding doc for PWM support
7. Add PWM support

I expect you know that some time ago we have also added support for
Microblaze SMP and this code has never been sent upstream. You should
just be aware about it.
https://github.com/Xilinx/linux-xlnx/blob/master/arch/microblaze/kernel/timer.c

Thanks,
Michal
