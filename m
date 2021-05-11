Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F26037AF2D
	for <lists+linux-pwm@lfdr.de>; Tue, 11 May 2021 21:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbhEKTRn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 11 May 2021 15:17:43 -0400
Received: from mail-eopbgr140088.outbound.protection.outlook.com ([40.107.14.88]:45255
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231454AbhEKTRm (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 11 May 2021 15:17:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOcvQJaIrCC7mvOAX0JQa0NfZhVBGInIYNMmvOQKKfX1fGnSt198Br6j/y0An5kOu5CF+HkZn5El2F0yrWdP7HdkPacvP8b+az9JXHELiDYR3/nHRbJZtWBPjf0/GLvQn4NSRgZAhSs7Za97oxh0CoWuDwOHk92wlRv2uqqSguIM/P43OWeiH9oeKsPojt7dWLQTan9w63gjZRk2uUWsScFT/r3XL9xk/XnQH6HnrSME7i4+yvs0UOCzKJMqoChbjNbSz6Nh3phjNiWDXkDDfdgbQ5s1tdxMuVOym0BkTLvP4WQmjPXH1BYvCZP/dj6muQpQqm8c9tIUosORX1F6Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEcJxr3uI1VoO6+msSg96I9RRUScZvXkCnfZNuWDMQ0=;
 b=ItwmKqve4L1M28raSc1EPL+LdG2i5o2faJRgPjJ+dNMsWQErVSuucUcvGjdGEScAGy9Kjw5uwvuphiER0rbpLWzhOcPaImuOcUHHLHYpRavOR+fgFelkPnWJlZHh08hi7ePgBfeUrZ7CYD2XhAAYEWO1Hcpbfjob2apov+3r/z+YrUD4wewIDmn9hk4JfqoZdz+/GY0FV669L56QBfn78DwY3BTiwKDzc3uvf7w2HBFyTJJlwzx+A6uFTrqxDMdxClm2vsDqq/QHeSAwwN5zvcfHuzBfxQWYwwXoBNLXbPzSKHlk9IJxzeCckOB272gazxMIHi5siTrYegWUyKKOGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEcJxr3uI1VoO6+msSg96I9RRUScZvXkCnfZNuWDMQ0=;
 b=xxvH5elC1HjwWBK8FDfBlQpB85Ng5Bh1cJY4TfS1kKgN4G+DP43q3bDkW1kPt3jehYNCmXOMSLMt7iP57HFFQti6bssRdJx1w9IwwCp2zSw6G3XzwiKyugxkyS85cg732+fF+aNB1L9noEOOct4YNVr3Wtuhkj5ooJjpJPxIqpE=
Authentication-Results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DBBPR03MB7051.eurprd03.prod.outlook.com (2603:10a6:10:200::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Tue, 11 May
 2021 19:16:32 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b%5]) with mapi id 15.20.4108.032; Tue, 11 May 2021
 19:16:32 +0000
Subject: Re: [PATCH v2 2/2] pwm: Add support for Xilinx AXI Timer
To:     Michal Simek <michal.simek@xilinx.com>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
References: <20210504184925.3399934-1-sean.anderson@seco.com>
 <20210504184925.3399934-2-sean.anderson@seco.com>
 <e3782bc5-bcd9-5eb8-e89b-e4e52ed2e3cb@xilinx.com>
 <1bfde199-617a-343c-10ed-4c436bfd908f@seco.com>
 <ff8eb398-fd49-fdb8-447e-2f6270cb006d@xilinx.com>
 <448097ba-7616-ccca-7219-6532dac04dbd@seco.com>
 <12409453-c6f2-1731-a45a-7ef74dabe982@xilinx.com>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <678bcbc4-dddf-1d6f-5a82-c245e0ebfe8d@seco.com>
Date:   Tue, 11 May 2021 15:16:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <12409453-c6f2-1731-a45a-7ef74dabe982@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.195.82.171]
X-ClientProxiedBy: MN2PR04CA0028.namprd04.prod.outlook.com
 (2603:10b6:208:d4::41) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.1.65] (50.195.82.171) by MN2PR04CA0028.namprd04.prod.outlook.com (2603:10b6:208:d4::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Tue, 11 May 2021 19:16:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86d2b0ff-983b-41be-3886-08d914b1492e
X-MS-TrafficTypeDiagnostic: DBBPR03MB7051:
X-Microsoft-Antispam-PRVS: <DBBPR03MB7051D6EE0C5EC59A58BCA6A296539@DBBPR03MB7051.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tGRloCZ9qTntdl2DMlgYTfsJSwVCXAoJhQe65viAN52qH5LX9LIrc70l6a8uYCoHY8klvyQe8VByG3Okpfs40GTA+CK7hPL0RtmWmRCkHHqWmJugUmpIfgoBNdKXX++t2EoIu1D/+lUWicrGcoaVYIvvRRF3Zji49nx3YhNc9W28VDkotGoA2sCX0n2acee9D0cne3j2UbtHPy9F6thcaYeiG0AWtW3fvZhywq94ZGRyXnCRKozBy7GN8LFYzvW2of+EE2tqJrmFwhWUHim6YGDb8ZRiqnGzgeqV4B7kZ9vkendEcE+ePv3L4JnrogEOokGIgu/v2ydXVJSwDkFv/9SBGg8/6+/alj/mci1KG7AmNfVy4TwrWeWkIDtIFwYcYqprSYEAamt3uub68/Ey73IbhgCedueXMqwHq4UvZhE1BT6/8wkIUYTkG+E2cbesgKkUt1GolBTuWVzuuOr6KaODN2JEH5i2E8ph1k8jbI+nMXI+NxxVrFgAvFeOqlh0Emjl0SCz00TdysWDKmUovbh2HS77nURImTd2NH4wvbktBkBhulv974ri3roCnH9twgMFs/iC6oujSN9qMQPaPiLCmhU6PXcEYDXbYkRVUrppAkhuwuYoXvEjDZcSy1JjriyW5aaC/ZsESxxN5DSiP4VPDT8mU7tdDHJSUlko3ZsRn6b3EWzSVixw/ytejjcEMbdnbKGPVLH/uIFtZ2h8ZIxpLHwuBaSWuYirzO4XAPnqmRgZsvR4ARMD0TtFD7mZLz3HlGEuEedyBAkoTJbyTz4VQwbmDxEYmKEQqiGst6o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(346002)(396003)(376002)(136003)(366004)(38350700002)(38100700002)(54906003)(956004)(2906002)(6486002)(86362001)(16576012)(4326008)(66476007)(66946007)(66556008)(316002)(8676002)(2616005)(44832011)(6666004)(478600001)(83380400001)(16526019)(5660300002)(31686004)(8936002)(31696002)(52116002)(53546011)(36756003)(186003)(966005)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Ly9tbnA5eEs4UkpUYzBkSnV0N2JoYlNLRGVxeXl3dWxJenZXTjlpTnZCMjNY?=
 =?utf-8?B?WHF5NEFZOHJHcFNVVnFxQ1oyZkhTWjI1ZktWNmZiUDZKZHYxbXlSNEJ0K0k2?=
 =?utf-8?B?eTJrN2I0UEVvb2dBNjVoYzNzOFpYcE9INjZpcWIzbXhHZjNjeHRvbWpQblVV?=
 =?utf-8?B?S2FUNlFSTHNtY2ZLSjYrcTViZm9mUW9XemVWeXZsQzJyVzkyZGpTWnd0S01M?=
 =?utf-8?B?T3dhc2o5aE5EY0NWemZoQkk0QlZNZ2tGL05haFptWWNRUVNQMytPQkpyNVM5?=
 =?utf-8?B?WFFPZytPMlVrZmNMQllkb1UreStRTDZVOERURHJMUGhXR245Q1dBTk1XSitv?=
 =?utf-8?B?TTlyTENCMDh0YnhZVUZMVGZyVnRzY0FueUtHNEIwV0FRUE5zb2JUZVFKQmVz?=
 =?utf-8?B?TjdiVzEyOTJ4bnRGaXc1QVhIUm5QS1NIM1hnd2hpOGNEZnlyVGdrT3dDdXhJ?=
 =?utf-8?B?VUJxV0pUeldBQzhqb3ZJU2FGdjM0Rmw3TVo1Y2pBL3lWZmJGT3B6WWlwcU45?=
 =?utf-8?B?QUhsaExoeVM1SGZqcHljSTdYUUtsYjgwSC9NQnZIbHhuWWVyTk0vZUd6VVho?=
 =?utf-8?B?VFdFUW85dStRNkZ6QmhJSTlaUzhMUGF0QnN3N3EyWGhYUXNiQWdQVSs4ZSty?=
 =?utf-8?B?V1FRTTRzc25QZFdzQzNqSURWRGUrbEdPRmxwcElqRHRpaTF2R2cwQy82Yjlh?=
 =?utf-8?B?QmZXRDcwei83cVdZYkJ4dld6ZzN0eDlzMk5JcHBLNDdNOWtRbEpJR1VrOEJZ?=
 =?utf-8?B?UGlkbE5EZGQ2c3ZFTmR3WktmeFFBeUJ6MHQ1TXV3KzdXVzd5aE9ZcmFmclor?=
 =?utf-8?B?VFF5bjduTUtYeVloVkxTR2EwYWlod3U1VzNHU1V3c3lMM1JCTUo0OHpKdklY?=
 =?utf-8?B?RHY0SmhWaW9qaWhBRUtCZk9PWDNUaXN5Uk9FcG9ibFA4eVpMSTlnYW9NM1pC?=
 =?utf-8?B?bzNDVXlVaUE5RFNjeXk1MnJrTlhiRU1LdE9vMGRLWVNkQjRKU3pzWjNQREtP?=
 =?utf-8?B?QkdMeEY4MjlJVW9RS1JuU2Z6OVkrSHJreXdCNkJBMU56L1pEOVJXZXdhSEhu?=
 =?utf-8?B?UVpJeUw3UGZ0Mm9FeVZ0emRueWpyQmdQMTAvMnRvSVVOZzd3RDEyQ2lPbEl6?=
 =?utf-8?B?L212OW5HZnpiWENEUHVFWWJSZVpXZkdXUGRId1VnV0phQXhGVXFOY1JXSS9h?=
 =?utf-8?B?d2IzZ3J0OEJaczJDclYwSWpLWlpORTNGNlJYOWNHTzNWOTBiWlJ4U2FqTUVV?=
 =?utf-8?B?U2VGYW5TbkRpck5FM3R4T3krdUQrK044YTR6Z21MRDhQc0JwRExDWTNuTSt6?=
 =?utf-8?B?akpJOVBlNGltRUV3aUJtWmJCYlVNMWt6ZVV2bWJCTHZ5MEpWYUhVaU4vWHpB?=
 =?utf-8?B?bU1DVEJyNDRQYkxXUXZnMzhzS1p0QVNMUnlobTB4QlJocE95RUVlMVk5REJn?=
 =?utf-8?B?bnBoOTBzU2tpNThiS0ZLbEkxVzlWN3dyUWptK0hMYjVLN25heUdJQURWanpl?=
 =?utf-8?B?MVBOWEpZQkRzbjZacHBpaXV0M2QreXY0VDhPOEYxWGgvQ1YzV3ZPZHNrc1Vk?=
 =?utf-8?B?QXdJY1BycCtHbWpicmhBSkdad3BWaHJyTkVXYnorSjdBSUd5aElmSkd4QTRG?=
 =?utf-8?B?UXJjQ2laQkNPUFFjY29mclRmYzVpa0M0VFRuV0hjMTl1VEV4Z1BVdGVWYmVJ?=
 =?utf-8?B?ZUZxWmYyM1NwUVhLT1BrOThxRWYrWitCbGMxekNkWjMwVTJhYStldUFCQlpS?=
 =?utf-8?Q?ZYE21IAWtcPUAUuZYHVMfvNN4kF+LIMDlvM2g1k?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86d2b0ff-983b-41be-3886-08d914b1492e
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2021 19:16:32.0737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MPsXsEd8MlUX/FPBPt2ExsO14rRfSI68OCfxbdwS/kI/In0U4/4velAcC4nN8inbl0BJhqiUP7MwP3JZSZiESQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB7051
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 5/10/21 6:20 AM, Michal Simek wrote:
 > Hi,
 >
 > On 5/7/21 12:36 AM, Sean Anderson wrote:
 >>
 >>
 >> On 5/6/21 12:54 PM, Michal Simek wrote:
 >>> Hi,
 >>>
 >>> On 5/6/21 4:28 PM, Sean Anderson wrote:
 >>>>
 >>>>
 >>>> On 5/5/21 2:37 AM, Michal Simek wrote:
 >>>>>
 >>>>>
 >>>>> On 5/4/21 8:49 PM, Sean Anderson wrote:
 >>>>>> This adds PWM support for Xilinx LogiCORE IP AXI soft timers commonly
 >>>>>> found on Xilinx FPGAs. There is another driver for this device located
 >>>>>> at arch/microblaze/kernel/timer.c, but it is only used for
 >> timekeeping.
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
 >>>>>> I tried adding a XILINX_PWM_ prefix to all the defines, but IMO it
 >>>>>> really hurt readability. That prefix almost doubles the size the
 >>>>>> defines, and is particularly excessive in something like
 >>>>>> XILINX_PWM_TCSR_RUN_MASK.
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
 >>>>>>       drivers/pwm/Kconfig      |  13 ++
 >>>>>>       drivers/pwm/Makefile     |   1 +
 >>>>>>       drivers/pwm/pwm-xilinx.c | 301
 >> +++++++++++++++++++++++++++++++++++++++
 >>>>>>       3 files changed, 315 insertions(+)
 >>>>>>       create mode 100644 drivers/pwm/pwm-xilinx.c
 >>>>>
 >>>>> Without looking below another driver which target the same IP is just
 >>>>> wrong that's why NACK from me.
 >>>>
 >>>> Can you elaborate on this position a bit more? I don't think a rework of
 >>>> the microblaze driver should hold back this one. They cannot be enabled
 >>>> at the same time. I think it is OK to leave the work of making them
 >>>> coexist for a future series (written by someone with microblaze hardware
 >>>> to test on).
 >>>
 >>> I am here to test it on Microblaze. In a lot of cases you don't have
 >>> access to all HW you should test things on but that's why others can
 >>> help with this.
 >>
 >> Ok, can you convert the microblaze driver then? I'm afraid I can't work
 >> on a driver if I don't have a system to test it on. There are too many
 >> small bugs which can creep in without anything to work with. If you are
 >> insistant that there must be no driver duplication (even temporarily),
 >> then you should help with the deduplication :)
 >>
 >> I would also be willing to try and get a microblaze qemu setup working,
 >> but I have found no good instructions for doing so with mainline linux.
 >> The best I found was [1]. Do you have a working setup for this?
 >
 >
 > You can look at Guenter's files which he uses for testing here.
 > http://server.roeck-us.net/qemu/microblazeel/

Thanks! These really helped when developing. In particular, I was unable
to get a working system with GCC 9, but I haven't looked into it
further.

--Sean

 >
 > Or you can use Xilinx petalinux distribution or Yocto layer which should
 > have qemu integrated.
 >
 > Thanks,
 > Michal
 >
