Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A34386CD0
	for <lists+linux-pwm@lfdr.de>; Tue, 18 May 2021 00:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343617AbhEQWR0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 17 May 2021 18:17:26 -0400
Received: from mail-eopbgr00089.outbound.protection.outlook.com ([40.107.0.89]:37390
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235143AbhEQWRZ (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 17 May 2021 18:17:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fb9WdfLG/HOmEzWcpVDT69MnZ2rsIJAu334fKcQYKd21XDQ1dQKpWffxKkU/vcxC0DRbKnRnKb89KSYDhsjmlFFtYAd0aqAY9X2sm8kzw6jQyalImEHXSKJT0W/RAS2Zboei3JhsWDs0lFCIaPnWWjFmgwKdyV+ODt/iuwW9bBTskb9Ln/VmisQOu0SdhIBLy6EWMSIdF828k3OO/4vRyRiIxT2Oh2het76bA01DSHdTTC/FEOahm7wY5VZgaZHxG5T0e98cqUfGoyFQ7AeBlwFWcKOBYX85wVDswbSv9N9xaUcx6bUt0qYanqQZPmHJH4Tsk692n+hVvRfmh279MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vfW1Y3oDVKbGT7aXz0aXshxRO/NGw6IbSYhkuZibyf8=;
 b=ZzcsSVRPxP+6MBmuZxHoh6AWdeUI6zhkM2gzK5K/xgZvxn6/iyl2N8UcKsUQZ5Ani3G1f2t3MXThnwHxw/b+j0D/jbx6UKtegEbte8TwIA/HfL0Cdms2pUEBYkD5vgDfdjcsKUXzEX2kOAUyy0eWUQks3VrZ2KArn8cxOvhKWpO3IvX3EpiIffUuW+RZpk31OAF6RMIwwpBwN7Egsoi/JQuLAbrIxP1mrFY7HSpSGmgHywqtPvzJzfWYpAFXvsseUuMxylixeAyIfVZI8qwjfS0tWa+uGVBWe4LSXRgN6YM2063fBNZU9JBPdFyLgyIWMtkl9uzE3Hcu0PNAiLmtlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vfW1Y3oDVKbGT7aXz0aXshxRO/NGw6IbSYhkuZibyf8=;
 b=C2ztbJ5JjpqdqFebjKuLlxNb9HQb5VXlLqdYsMcAVGrXRR4DZPZK3GbdkhKwv0dnTZkFPGNjjJRbUM8qShrFeVg+tSnRjnLbYa6h400tXl5QT+XlBKf3ksTl31xYO0PB1HTsdHbVnIwJyH/163+2PY1SXJWlrdb/VpHOdYMJ/i4=
Authentication-Results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB6PR0301MB2182.eurprd03.prod.outlook.com (2603:10a6:4:49::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Mon, 17 May
 2021 22:16:05 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b%5]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 22:16:05 +0000
Subject: Re: [PATCH v3 2/2] clocksource: Add support for Xilinx AXI Timer
To:     Michal Simek <michal.simek@xilinx.com>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org
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
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <7a06cf46-0f85-1edb-ca08-abd7b2543ad9@seco.com>
Date:   Mon, 17 May 2021 18:15:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <9f227f96-a310-0fbd-fd34-91eb386306b9@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.195.82.171]
X-ClientProxiedBy: BL0PR02CA0075.namprd02.prod.outlook.com
 (2603:10b6:208:51::16) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.1.65] (50.195.82.171) by BL0PR02CA0075.namprd02.prod.outlook.com (2603:10b6:208:51::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24 via Frontend Transport; Mon, 17 May 2021 22:16:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b96ea0d-8af7-4b87-9f09-08d919815d32
X-MS-TrafficTypeDiagnostic: DB6PR0301MB2182:
X-Microsoft-Antispam-PRVS: <DB6PR0301MB21826580E34198390946E7FE962D9@DB6PR0301MB2182.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VdAp9xuhAEV8ROBL83WA217QbNAuuKCTU+5IM4eLG9wtqUlP5XsA64o/ZwucP5twwS62CHlzaxTHuAaGSwTE+so/19C1WpvKHWm5TTSZSJG37NIXyWKlZ/fDELoU+apUYbzJwG6b3sxyI+0eaWhxs2tlUL/aWbpyU4xa1Or7cS550QWosUVqVU9V6ZwYGhDD9c7JKz9rtx3AzBghJ1Cwjdc/4FRngFQ6N95A6bAOMH2l67pq7UcbSF7dk5zw0wgk548OdrpbIZe/DE6IZVQ3E2bne63fveLNjaZse4zCMSonFNxFAV30P7Z8G5UfKzlDBS5j6ONOVhzV+y3l+mngLQG0fz7g5T6chDtAstasNH4dXceaP9x3dzf9qSJ0aQ7WrV75Nm3B0PfxLA9k18mctgaCrFgObD+Br7PD3/iKD8GQoiQCA5Wg5Lboz9E5T+5e8ba9p89/DV7/RuWP7ZFIF6bFB1GPuJ+tl+1jtP1VS506sHnwuB4Eg0gmDdKB0wIo9XQ2BYIkPcoRa3YjfEFyJvLLhr5HgkSvD8suOvkPxoPRfYdQGXIWJiM3VT607BXr3bKQ2J+ml77KomMA7rS8tcURiMlNpSpymGEYH/RXV6mFfo+teVeNq0m7DUGVS7rk8WkdEnV9xCxDwGI1QHGZgKNE1/ogiHVf/yRDYHbwwCAS3i334/CElsTVgZthivL5siJ1SVqOqiEtiNYJKjadmueavqILNKnR1H2gqBFFRrowD9x9Y9b5mwXivf7pR3Hdmz0Rqwgbw8S9u6MApj6lYew4Hh0+GMiO2PoOUKPI/Pw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(7416002)(8676002)(16576012)(5660300002)(83380400001)(66556008)(54906003)(86362001)(26005)(44832011)(36756003)(956004)(4326008)(966005)(31696002)(498600001)(8936002)(186003)(16526019)(53546011)(6486002)(66476007)(2616005)(31686004)(38100700002)(38350700002)(2906002)(52116002)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SG5najZJYlZYRS9EMitYUnMyYnNYSktkRWFYdlM3T2JKYkxsbUVTQTRyT3lV?=
 =?utf-8?B?Y0ViN0p4V1VRcThGNUdmVFBJVWdvMGlFcHhXQjB4ZkJvV3JVSSsyOFMxdjZB?=
 =?utf-8?B?REpZcVV5Q1VHRmxyU2srdytHYmdXejd3SC90S2xDbnE3SUdMZXhneG1TeDF2?=
 =?utf-8?B?cEtIZzd0N1ZHd3JDdzloQ29kT2ppWFdpVVBtMWxXdnRmdEo1YzJxVE5KRTAr?=
 =?utf-8?B?OGJ1S0xkMnltWGhOaUhiQjFFNE5TZzBNT1h6L0s4T2x6TU03RXM0MmJGZXd3?=
 =?utf-8?B?ODJjZHJiTU1Ddk10ZTFyRDZURUU0cURwS3RDOVdZaEt4S2pQdk4zb0I2bFFx?=
 =?utf-8?B?QTJhWTVzUTRsYSszelBLSGNmL3QzL3lsbXBPRFVRUmxLcDlweTBlMEF4WElW?=
 =?utf-8?B?TzJxTWp5YUFXNFp1djk5Y0x1bU5DTVFwN056MWF0a0N1Z2JIR2l4eFpna3k0?=
 =?utf-8?B?eXhpVmVJQnpVV3BJcnlJTmc4bGIvbG41cE05d0dGbkVRVW83aWkxK3diUGJP?=
 =?utf-8?B?cDRNRzhBdzh0L29uUGtkckJxWkorY1dQdWtXQ1hRVlVENGpOUlhndkhYQzFB?=
 =?utf-8?B?SVlWazRlOTRCenNHUnpJNm4yNC9waEVZZXVFQ0lQeUdYb204NGkwb1IxZi9L?=
 =?utf-8?B?QXNFRWs0S0poZE5oTFVSTDdkZEJoTitjdS9XSW50YnJLSld1T0ppdkhvTEZl?=
 =?utf-8?B?UisrZnVpeksxY2JZanh4ODRnWUtNVFNhWkcrRFhyZU9NMjBzYkdSaWtsOEZY?=
 =?utf-8?B?bkExV2RXNjBocmZhblZreWkwOUJMN0lvdXpTNmsvdlNxTjRwYUxzY1VMK1gr?=
 =?utf-8?B?WEhKNGhBT3RmMFpJZng5bUVVcmxPdW5lRjRjNmx3Z3JlOVNSU0JmMUlCZTM3?=
 =?utf-8?B?Nno0ZXdvUDd2VW01YTlkWkVLelF1eXdYcHhodXFpd2RLQ0pacGZBZFgzZlRE?=
 =?utf-8?B?eGJseUlnbTJkOGt1d0RwVTdGOU82ajNkazg5aDdVUkd1OGdURDhoWHBONWhw?=
 =?utf-8?B?N2F2ZTR1dHBSVDFWWEJxL3I3b3NOZ3I1ZWdpTVpwOW1oYWNET0ZWb0lCRDdR?=
 =?utf-8?B?Yjc1Mk4zVUYyZW0zNkdiRGJZUUJBL2pCVDhLb2JtK2ttRUdaOHc1STJ4ZUho?=
 =?utf-8?B?Mnc4SmlCeWl1dWVHOVZxWm1IdmVHMlFFZ05wWklRZHRKSENwSnR6SlM3by81?=
 =?utf-8?B?WEFNR1BHQUlGOXVBcW5hUHJaVE93cHUrODA4MWJXSHVzMUJYeHZFZEZGaU1p?=
 =?utf-8?B?cVpxcDVxc01XNndBZXJEM1gvWEMyTlIza0tOSzZLZkQxeWxTMkJvb2dBSXFq?=
 =?utf-8?B?Z1dRRHpORmJaUjRqNzNFWlpEREthRXhrWU5YWTJ1eEFRTFM4UVJVSFMvL29B?=
 =?utf-8?B?RTFnWEcrVG9aV0ZtS2VSRmRKTVRjU05uMUVsYVFlVEhjdFpoNEprOGJ6SnIw?=
 =?utf-8?B?K0J5czZUTG1GZGI2ZS9ZV1V2bEo4SjlJNncyOVFEeWRzKytLVmR3WTRpRGhG?=
 =?utf-8?B?WmQ1dWI0MHR3L2RnRTlNQVlpTUZiUFZrT1d0ZU0ybjBXbmIwQVlDdGlGT3Nr?=
 =?utf-8?B?V09xb21hazd4SnphWFN5ZmRkUHlhNmlvMzQ0OUVnZjFmMVFYODd5ZWJacSsw?=
 =?utf-8?B?Y1ZOd0llczd3a0NSOXFlQjFhTWdrL0tLRi93Slc0QnN3dVFMbHRnSzIzWUp1?=
 =?utf-8?B?OHUybzVGMDN0SkN0Qmhqd1dvclNQRGhxcGZscHgzTXVOUWdWRDJPQ0FqWDFX?=
 =?utf-8?Q?MyqM36g2Jc42YZ4Q0CMSxB6kpD8epczr3vd7wbQ?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b96ea0d-8af7-4b87-9f09-08d919815d32
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 22:16:05.5649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wK82/TaG/804B7NwMeaDTE78mY9XNxJwrBJHRXWvQTvrnQ0V+y+hi7eNzJRjkPbOczOEZmLkPJHQy2+eaTLFwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0301MB2182
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 5/17/21 3:54 AM, Michal Simek wrote:
 >
 >
 > On 5/14/21 4:40 PM, Sean Anderson wrote:
 >>
 >>
 >> On 5/14/21 4:59 AM, Michal Simek wrote:
 >>>
 >>>
 >>> On 5/11/21 9:12 PM, Sean Anderson wrote:
 >>>> This adds generic clocksource and clockevent support for Xilinx
 >> LogiCORE IP
 >>>> AXI soft timers commonly found on Xilinx FPGAs. This timer is also the
 >>>> primary timer for Microblaze processors. This commit also adds
 >> support for
 >>>> configuring this timer as a PWM (though this could be split off if
 >>>> necessary). This whole driver lives in clocksource because it is
 >> primarily
 >>>> clocksource stuff now (even though it started out as a PWM driver). I
 >> think
 >>>> teasing apart the driver would not be worth it since they share so many
 >>>> functions.
 >>>>
 >>>> This driver configures timer 0 (which is always present) as a
 >> clocksource,
 >>>> and timer 1 (which might be missing) as a clockevent. I don't know if
 >> this
 >>>> is the correct priority for these timers, or whether we should be
 >> using a
 >>>> more dynamic allocation scheme.
 >>>>
 >>>> At the moment clock control is very basic: we just enable the clock
 >> during
 >>>> probe and pin the frequency. In the future, someone could add support
 >> for
 >>>> disabling the clock when not in use. Cascade mode is also unsupported.
 >>>>
 >>>> This driver was written with reference to Xilinx DS764 for v1.03.a [1].
 >>>>
 >>>> [1]
 >> https://www.xilinx.com/support/documentation/ip_documentation/axi_timer/v1_03_a/axi_timer_ds764.pdf
 >>
 >>>>
 >>>> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
 >>>> ---
 >>>> Please let me know if I should organize this differently or if it should
 >>>> be broken up.
 >>>>
 >>>> Changes in v3:
 >>>> - Add clockevent and clocksource support
 >>>> - Rewrite probe to only use a device_node, since timers may need to be
 >>>>      initialized before we have proper devices. This does bloat the
 >> code a bit
 >>>>      since we can no longer rely on helpers such as dev_err_probe. We also
 >>>>      cannot rely on device resources being free'd on failure, so we
 >> must free
 >>>>      them manually.
 >>>> - We now access registers through xilinx_timer_(read|write). This
 >> allows us
 >>>>      to deal with endianness issues, as originally seen in the microblaze
 >>>>      driver. CAVEAT EMPTOR: I have not tested this on big-endian!
 >>>> - Remove old microblaze driver
 >>>>
 >>>> Changes in v2:
 >>>> - Don't compile this module by default for arm64
 >>>> - Add dependencies on COMMON_CLK and HAS_IOMEM
 >>>> - Add comment explaining why we depend on !MICROBLAZE
 >>>> - Add comment describing device
 >>>> - Rename TCSR_(SET|CLEAR) to TCSR_RUN_(SET|CLEAR)
 >>>> - Use NSEC_TO_SEC instead of defining our own
 >>>> - Use TCSR_RUN_MASK to check if the PWM is enabled, as suggested by Uwe
 >>>> - Cast dividends to u64 to avoid overflow
 >>>> - Check for over- and underflow when calculating TLR
 >>>> - Set xilinx_pwm_ops.owner
 >>>> - Don't set pwmchip.base to -1
 >>>> - Check range of xlnx,count-width
 >>>> - Ensure the clock is always running when the pwm is registered
 >>>> - Remove debugfs file :l
 >>>> - Report errors with dev_error_probe
 >>>>
 >>>>     arch/microblaze/kernel/Makefile    |   2 +-
 >>>>     arch/microblaze/kernel/timer.c     | 326 ---------------
 >>>>     drivers/clocksource/Kconfig        |  15 +
 >>>>     drivers/clocksource/Makefile       |   1 +
 >>>>     drivers/clocksource/timer-xilinx.c | 650 +++++++++++++++++++++++++++++
 >>>>     5 files changed, 667 insertions(+), 327 deletions(-)
 >>>>     delete mode 100644 arch/microblaze/kernel/timer.c
 >>>>     create mode 100644 drivers/clocksource/timer-xilinx.c
 >>>
 >>> I don't think this is the right way to go.
 >>> The first patch should be move current timer driver from microblaze to
 >>> generic location and then apply patches on the top based on what you are
 >>> adding/fixing to be able to review every change separately.
 >>> When any issue happens it can be bisected and exact patch is identified.
 >>> With this way we will end up in this patch and it will take a lot of
 >>> time to find where that problem is.
 >>
 >> What parts would you like to see split? Fundamentally, this current
 >> patch is a reimplementation of the driver. I think the only reasonable
 >> split would be to add PWM support in a separate patch.
 >>
 >> I do not think that genericizing the microblaze timer driver is an
 >> integral part of adding PWM support. This is especially since you seem
 >> opposed to using existing devicetree properties to inform the driver. I
 >> am inclined to just add a patch adding a check for '#-pwm-cells' to the
 >> existing driver and otherwise leave it untouched.
 >
 > As I said I think the patches should be like this.
 > 1. Cover existing DT binding based on current code.
 > 2. Move time out of arch/microblaze to drivers/clocksource/ and even
 > enable it via Kconfig just for Microblaze.
 > 3. Remove dependency on Microblaze and enable build for others. I have
 > seen at least one cpuinfo.cpu_clock_freq assignment. This code can be
 > likely completely removed or deprecate.

This could be deprecated, but cannot be removed since existing device
trees (e.g. qemu) have neither clocks nor clock-frequency properties.

 > 4. Make driver as module
 > 5. Do whatever changes you want before adding pwm support
 > 6. Extend DT binding doc for PWM support
 > 7. Add PWM support

Frankly, I am inclined to just leave the microblaze timer as-is. The PWM
driver is completely independent. I have already put too much effort into
this driver, and I don't have the energy to continue working on the
microblaze timer.

--Sean

 > I expect you know that some time ago we have also added support for
 > Microblaze SMP and this code has never been sent upstream. You should
 > just be aware about it.
 > https://github.com/Xilinx/linux-xlnx/blob/master/arch/microblaze/kernel/timer.c
 >
 > Thanks,
 > Michal
 >
