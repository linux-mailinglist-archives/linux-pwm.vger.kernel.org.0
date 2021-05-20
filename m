Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50EC138B825
	for <lists+linux-pwm@lfdr.de>; Thu, 20 May 2021 22:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240257AbhETUOw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 20 May 2021 16:14:52 -0400
Received: from mail-eopbgr60062.outbound.protection.outlook.com ([40.107.6.62]:5352
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240253AbhETUOr (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 20 May 2021 16:14:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X4AMPMUSQKhnPF0Jynzc3z7QQw736owKkNz8qUpXROO2ZgxG4mJEaMMwostCWh6UNot83JaqWIS9OZxi/yLxki9n6+H+kd1kjTTonmupyWllPIrOfR8X6Nm5g3OmYqx14puEwdQwZtRjELmrFv6GxjZGoIBMKoFstbx75ThFnQVziEGdeBbje866CSfBOkBOitmLXrguiPGR0erf4epLYbYynEPHjZtbjHT5S+2VS58/zC4g0FnVdMVzynA+VVcFOgOm6qsOXgu+T+1Pa3whL0BWT/UZOf1VewLMw9USbqV212Q1SF0VKCwd7gFOtLfRNC1MQ7rmeyVvVitoP5T/bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcRc1lgn6BTEs4vkABOuEYp4HPuaoZ9Vp6KTolfi/Yk=;
 b=kWJHA01vUfvID3Pu0EftfrlraU1kFKOywUMZIQmhY4RX92uAIM4fwfFWQoTcJFcoNmCP9CCem3200L8HGQyeydM8pmPJW6meHkVcoYj0yxZcAWne+SmlXyMP/dwcEB4c3mJl421g1l8B/PcxDmjJ5+dOk0saxNCkI0f7DlnkQZA1kPWyK4qO+ibScWFidZMAtRakku3FjnCf/JQj0m+0ANTX3KePqQ2tHE1VBOLB71I1wmm/2nKLPi6YGc4kPD7d4g0yab5ydu1CEaaKslKwl7TMtMEEB8kElEy8U2/hRnoQNaXVm6FQeiq8/AAxl1ljj5TOkiG01C0aBKFiRsKI3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcRc1lgn6BTEs4vkABOuEYp4HPuaoZ9Vp6KTolfi/Yk=;
 b=E1enYHnV8LMBNd5CWcX98aXkUT2UMtNkcv4x6/3sdbe9NxiIjRYCEN8JaeDq4+ySEZiY2MVrOeh5SUCmn8L7ti/MFRKQ9U1GPO/GEPnyPBNJsiSPQ9lPmPJ0YABHH5GbpnywK03ZSzQTCtEI8IlPs11BEgSTsBohaWWUsKQqmx8=
Authentication-Results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB9PR03MB7403.eurprd03.prod.outlook.com (2603:10a6:10:226::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Thu, 20 May
 2021 20:13:23 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b%5]) with mapi id 15.20.4150.023; Thu, 20 May 2021
 20:13:23 +0000
Subject: Re: [PATCH v3 2/2] clocksource: Add support for Xilinx AXI Timer
To:     Michal Simek <michal.simek@xilinx.com>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Alvaro Gamez <alvaro.gamez@hazent.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
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
 <41542760-3967-4f9a-0f0c-1206e03ff494@xilinx.com>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <d206a399-454e-d9c5-e2d3-337d098ed7aa@seco.com>
Date:   Thu, 20 May 2021 16:13:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <41542760-3967-4f9a-0f0c-1206e03ff494@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.195.82.171]
X-ClientProxiedBy: MN2PR06CA0001.namprd06.prod.outlook.com
 (2603:10b6:208:23d::6) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.1.65] (50.195.82.171) by MN2PR06CA0001.namprd06.prod.outlook.com (2603:10b6:208:23d::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend Transport; Thu, 20 May 2021 20:13:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb8f6350-1734-4919-d78f-08d91bcbb7ee
X-MS-TrafficTypeDiagnostic: DB9PR03MB7403:
X-Microsoft-Antispam-PRVS: <DB9PR03MB7403389540A81F5043F1E171962A9@DB9PR03MB7403.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gHToWxJG3wcHgs5id0uDcMYQnKr7+8s51Budqh3moITnjt6nTB926tKvGzX7bX5MPSlj3YQOZOsi2/roEXB80Vp/oYOJnUELMxWV0jfKfQW1Tq1s4aZgiGeEZT18ed2q4fa6rkLITjsHt8MTuG5T5IjBbnbXauHaE5WqHv5HCL+EBPa9hEY4efHk/KgsqYjjYTbd0U/CvmRjuAJJMB/a8pS2pIc1rpUmbjwdQkX8VVQlegRyQeFZ6w7Is+kSpXYqF+oJVTCl+HBLHEVeuxB5JYs+g3VTzK77lCDWse/Ogb+33r64nSqODPQopkMZaU1Ryn09ze4jWfUu6xhM7i3VgLuKGJXQ2gNuKXzgAgN5yAtErIR5cdlmwl+sqzHcfdwkNzFKekdVrdYrKCb2A2pAsdKmO2LPZoOFPLKVEd/0QDzBnyngSENMWb1i09Tkb9F/I36u6WNpWdp9vHb8+Th+2WlfsT0Pr79onjBqDzw/+pR0hCF024lnZ54IdBTRZfKHFopSJ8sgdkbA2LxCh50EXkEZPndK0KSEFYQ3QuipsGf/HOIljwxAtgyMWRbAQBAQUNA6mSgqEZrNzpwzAvc/gWwaM0JS8q/51rwQzYP3lUz/jhN3Ir8dfpqg7u/VMqaJ/P6VztcNtvxPryRXpXMLQjqhzYJ+xljUeShMgqqvcsVkefuzH8u5HvZIreLHSLIM1mgW+93Xg0ZNXEVcq4jCsZYyIT0BLWly6W65Em+2/2Pmf4xEI70u+grLEzHaUfuzhL1VUgDeVDM0sZH6Ym+JIlnGdAwAuzKepXhuFxI88rU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38350700002)(38100700002)(2906002)(16576012)(110136005)(186003)(16526019)(6486002)(7416002)(31686004)(498600001)(44832011)(966005)(54906003)(66556008)(66476007)(66946007)(53546011)(8936002)(956004)(8676002)(52116002)(83380400001)(26005)(6666004)(4326008)(5660300002)(36756003)(31696002)(2616005)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VWZ5RzAwWHo2R0pKZTlCVG1VelFlVlpoeWpZUzI4UTNBeWdoV1VZK3o3Q3BD?=
 =?utf-8?B?UXlOdlh2QnJEa3BtQVhhRDBBQm0zV1JYbTZaQkpadlZwSWJSOWs1TnFXNkFY?=
 =?utf-8?B?Q1E0eTB1MDEwL2dzU2JLZEcxbGMxSGgwSm5sWm9lNm9HR0VqbEdEckNlV0lZ?=
 =?utf-8?B?MmZLYkFIakx3YVFsZWFjQjg0Zk1GOUowdnZsNVplZTluTWlBWjk0MGZKdUl1?=
 =?utf-8?B?OU1ibXdoYWdxU25vZEJyRXhGSDhkOFJMUHQwU3BxRjhTcnhJWmVJWUwrNzVR?=
 =?utf-8?B?T0hMd2hBdVBtOUozeG5aelo0bHVjcjBJL05lTldBVGJQdTNhZHdRdzVtVVp4?=
 =?utf-8?B?cEFaenk3eXhKLzZrY2cwYW1KL2x2a0syTExmMDN3QUJzSlpya0RUZjhKU1hE?=
 =?utf-8?B?VFZlMlRvNEZmUGJ0dUNiUnlaRFJWR2tVTDY2WXBueHV2QitVQTFLeVh6Nm82?=
 =?utf-8?B?YStiM0V5b1ZaREVlUjE4eWNwQjZySy9ZVXlZZjJodHRzUTduT2hYcVRIRUI4?=
 =?utf-8?B?MllhV3NsZzMxWXdVOFFFNXVkTDJueHhQWWdiTEdLVXNJeFVCYnNWUXAydllP?=
 =?utf-8?B?a3ZnL2FwUWhqY1hvckh5eWNMcnllWHVhV1ZNZThSSHB6Nnc5WXFsR0MzODRE?=
 =?utf-8?B?Zlc0c0dlelh1eU9MN1dJRDArM2t1RHVRT1Z4TXdjdk40NzcxUlNtTDdMMTla?=
 =?utf-8?B?bnFjQWphN0xCRGMzS1NYbFFTWldKSllLeG5ETWx1L2VGWS9HbnFVV2daWnA1?=
 =?utf-8?B?bWVPWVZlZ0NjWnpMMmhmRVIvZVBsZUk3ZUZ2Z3p5dVp2QW5jWlkxd1R2RUJ2?=
 =?utf-8?B?SkZ0cndqV25iOXVuRUtzdjFBVUxHcStFSC9QczJvNW1vUkhHVDBmQlMvQVdN?=
 =?utf-8?B?aUpabmF0dnJjRDN2cHZjak5WbXZ6QWQrTHVCRXdJcC9MZXFkZHV1ZExoNHlm?=
 =?utf-8?B?QkxrWWlZRk5UVm43SSs4NC9NNlVINHROcW9aK3BZN0xMN0NQTmFVUUJEOTB3?=
 =?utf-8?B?T1YzdDFvMmJVcVgvQzNsL1o3cUYwZHNNRTMzbVhRVlNFQUtGNEZBWUpZYVF0?=
 =?utf-8?B?YnRLRVFTMU0yVUE0S2FBUndZK2VaZzg3bDc4V3RTVTdWeC83eGNjMFFjRFls?=
 =?utf-8?B?NlBRV3RmYTVyU0NRc3JHWjB0d3hTV1p6SlZ1c0s4UnNmVTFJeHZhT200R29X?=
 =?utf-8?B?UnlrUitPYTkwZDFoWW5uZDlRSFYrNnJ1Tmwrb2dKNGZjTHgwNkxYbDFWa1J4?=
 =?utf-8?B?NDRwcGhpb3JlSFYxbmRBQWpBUEdCR1pqM1Y5dUI1WGhLNEQwVVFSaDU3Nlpq?=
 =?utf-8?B?UG80Y2kyQ1pPajdkcXdYOXZ6L2w1SlhyRlBXSjNDZ015QnNseFF1YWN6azNr?=
 =?utf-8?B?OGVjYzVQSUttQ0xMKzlpYjFMKzQxQVJEUVhFODN1ZllJNklhZkZ4SFBoL3ZP?=
 =?utf-8?B?NzNlYnZvYVRVVE54aG45N2FncHl5NlhzVWJMY0dlRjhHSnBjYWhTbGtXL3VP?=
 =?utf-8?B?NnZRNHZnOGlZMmhRQ3RPcWdRNmpZVzlGM2Zyb3FHZnFVdktsVVFKN0tBZjJM?=
 =?utf-8?B?U0VjUWpWRDRMY3p3cXFnYzExTGdDdHZGYk52TVBQQ1ZqUHBHK2dnNDVlYkYv?=
 =?utf-8?B?QVNadG1nUjNKT3IyMm9GOHhXREhDQTRKcnJkOG1paHdjYklCc2k0Kzg2Qy9H?=
 =?utf-8?B?N1VrMEZvMElJb0RtSmRGcndkSmM3MnZZdVNzR3hnNm0zVjlQNlErZnR1OGRq?=
 =?utf-8?Q?Vjbuc/p3sbTnU5nkKEDa6s+fK1cNuRN+vCKAcYx?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb8f6350-1734-4919-d78f-08d91bcbb7ee
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2021 20:13:22.9629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eCsM8aGmkWJfr/QFo/MmX+DEiDF466NpMXFJUt4ugGVW25+G7jbHt9e7BVgtv5q5tvVUp88z3aHFsCqeKN+1eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB7403
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 5/19/21 3:24 AM, Michal Simek wrote:
 >
 >
 > On 5/18/21 12:15 AM, Sean Anderson wrote:
 >>
 >>
 >> On 5/17/21 3:54 AM, Michal Simek wrote:
 >>>
 >>>
 >>> On 5/14/21 4:40 PM, Sean Anderson wrote:
 >>>>
 >>>>
 >>>> On 5/14/21 4:59 AM, Michal Simek wrote:
 >>>>>
 >>>>>
 >>>>> On 5/11/21 9:12 PM, Sean Anderson wrote:
 >>>>>> This adds generic clocksource and clockevent support for Xilinx
 >>>> LogiCORE IP
 >>>>>> AXI soft timers commonly found on Xilinx FPGAs. This timer is also the
 >>>>>> primary timer for Microblaze processors. This commit also adds
 >>>> support for
 >>>>>> configuring this timer as a PWM (though this could be split off if
 >>>>>> necessary). This whole driver lives in clocksource because it is
 >>>> primarily
 >>>>>> clocksource stuff now (even though it started out as a PWM driver). I
 >>>> think
 >>>>>> teasing apart the driver would not be worth it since they share so
 >> many
 >>>>>> functions.
 >>>>>>
 >>>>>> This driver configures timer 0 (which is always present) as a
 >>>> clocksource,
 >>>>>> and timer 1 (which might be missing) as a clockevent. I don't know if
 >>>> this
 >>>>>> is the correct priority for these timers, or whether we should be
 >>>> using a
 >>>>>> more dynamic allocation scheme.
 >>>>>>
 >>>>>> At the moment clock control is very basic: we just enable the clock
 >>>> during
 >>>>>> probe and pin the frequency. In the future, someone could add support
 >>>> for
 >>>>>> disabling the clock when not in use. Cascade mode is also unsupported.
 >>>>>>
 >>>>>> This driver was written with reference to Xilinx DS764 for v1.03.a
 >> [1].
 >>>>>>
 >>>>>> [1]
 >>>>
 >> https://www.xilinx.com/support/documentation/ip_documentation/axi_timer/v1_03_a/axi_timer_ds764.pdf
 >>
 >>>>
 >>>>>>
 >>>>>> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
 >>>>>> ---
 >>>>>> Please let me know if I should organize this differently or if it
 >> should
 >>>>>> be broken up.
 >>>>>>
 >>>>>> Changes in v3:
 >>>>>> - Add clockevent and clocksource support
 >>>>>> - Rewrite probe to only use a device_node, since timers may need to be
 >>>>>>        initialized before we have proper devices. This does bloat the
 >>>> code a bit
 >>>>>>        since we can no longer rely on helpers such as dev_err_probe.
 >> We also
 >>>>>>        cannot rely on device resources being free'd on failure, so we
 >>>> must free
 >>>>>>        them manually.
 >>>>>> - We now access registers through xilinx_timer_(read|write). This
 >>>> allows us
 >>>>>>        to deal with endianness issues, as originally seen in the
 >> microblaze
 >>>>>>        driver. CAVEAT EMPTOR: I have not tested this on big-endian!
 >>>>>> - Remove old microblaze driver
 >>>>>>
 >>>>>> Changes in v2:
 >>>>>> - Don't compile this module by default for arm64
 >>>>>> - Add dependencies on COMMON_CLK and HAS_IOMEM
 >>>>>> - Add comment explaining why we depend on !MICROBLAZE
 >>>>>> - Add comment describing device
 >>>>>> - Rename TCSR_(SET|CLEAR) to TCSR_RUN_(SET|CLEAR)
 >>>>>> - Use NSEC_TO_SEC instead of defining our own
 >>>>>> - Use TCSR_RUN_MASK to check if the PWM is enabled, as suggested by
 >> Uwe
 >>>>>> - Cast dividends to u64 to avoid overflow
 >>>>>> - Check for over- and underflow when calculating TLR
 >>>>>> - Set xilinx_pwm_ops.owner
 >>>>>> - Don't set pwmchip.base to -1
 >>>>>> - Check range of xlnx,count-width
 >>>>>> - Ensure the clock is always running when the pwm is registered
 >>>>>> - Remove debugfs file :l
 >>>>>> - Report errors with dev_error_probe
 >>>>>>
 >>>>>>       arch/microblaze/kernel/Makefile    |   2 +-
 >>>>>>       arch/microblaze/kernel/timer.c     | 326 ---------------
 >>>>>>       drivers/clocksource/Kconfig        |  15 +
 >>>>>>       drivers/clocksource/Makefile       |   1 +
 >>>>>>       drivers/clocksource/timer-xilinx.c | 650
 >> +++++++++++++++++++++++++++++
 >>>>>>       5 files changed, 667 insertions(+), 327 deletions(-)
 >>>>>>       delete mode 100644 arch/microblaze/kernel/timer.c
 >>>>>>       create mode 100644 drivers/clocksource/timer-xilinx.c
 >>>>>
 >>>>> I don't think this is the right way to go.
 >>>>> The first patch should be move current timer driver from microblaze to
 >>>>> generic location and then apply patches on the top based on what you
 >> are
 >>>>> adding/fixing to be able to review every change separately.
 >>>>> When any issue happens it can be bisected and exact patch is
 >> identified.
 >>>>> With this way we will end up in this patch and it will take a lot of
 >>>>> time to find where that problem is.
 >>>>
 >>>> What parts would you like to see split? Fundamentally, this current
 >>>> patch is a reimplementation of the driver. I think the only reasonable
 >>>> split would be to add PWM support in a separate patch.
 >>>>
 >>>> I do not think that genericizing the microblaze timer driver is an
 >>>> integral part of adding PWM support. This is especially since you seem
 >>>> opposed to using existing devicetree properties to inform the driver. I
 >>>> am inclined to just add a patch adding a check for '#-pwm-cells' to the
 >>>> existing driver and otherwise leave it untouched.
 >>>
 >>> As I said I think the patches should be like this.
 >>> 1. Cover existing DT binding based on current code.
 >>> 2. Move time out of arch/microblaze to drivers/clocksource/ and even
 >>> enable it via Kconfig just for Microblaze.
 >>> 3. Remove dependency on Microblaze and enable build for others. I have
 >>> seen at least one cpuinfo.cpu_clock_freq assignment. This code can be
 >>> likely completely removed or deprecate.
 >>
 >> This could be deprecated, but cannot be removed since existing device
 >> trees (e.g. qemu) have neither clocks nor clock-frequency properties.
 >
 > Rob: Do we have any obligation to keep properties for other projects?
 >
 >
 >>> 4. Make driver as module
 >>> 5. Do whatever changes you want before adding pwm support
 >>> 6. Extend DT binding doc for PWM support
 >>> 7. Add PWM support
 >>
 >> Frankly, I am inclined to just leave the microblaze timer as-is. The PWM
 >> driver is completely independent. I have already put too much effort into
 >> this driver, and I don't have the energy to continue working on the
 >> microblaze timer.
 >
 > I understand. I am actually using axi timer as pwm driver in one of my
 > project but never had time to upstream it because of couple of steps above.
 > We need to do it right based on steps listed above. If this is too much
 > work it will have to wait. I will NACK all attempts to add separate
 > driver for IP which we already support in the tree.

1. Many timers have separate clocksource and PWM drivers. E.g. samsung,
    renesas TPU, etc. It is completely reasonable to keep separate
    drivers for these purposes. There is no Linux requirement that each
    device have only one driver, especially if it has multiple functions
    or ways to be configured.
2. If you want to do work on a driver, I'm all for it. However, if you
    have not yet submitted that work to the list, you should not gate
    other work behind it. Saying that X feature must be gated behind Y
    *even if X works completely independently of Y* is just stifling
    development.
3. There is a clear desire for a PWM driver for this device. You, I, and
    Alvaro have all written separate drivers for this device because we
    want to use it as a PWM. By preventing merging this driver, you are
    encouraging duplicate effort by the next person who wants to use this
    device as a PWM, and sees that there is no driver in the tree.

--Sean

 >
 > Thanks,
 > Michal
 >
