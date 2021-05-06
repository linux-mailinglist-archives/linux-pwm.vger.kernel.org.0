Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAF1375D36
	for <lists+linux-pwm@lfdr.de>; Fri,  7 May 2021 00:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbhEFWhl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 6 May 2021 18:37:41 -0400
Received: from mail-vi1eur05on2068.outbound.protection.outlook.com ([40.107.21.68]:31393
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230231AbhEFWhk (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 6 May 2021 18:37:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JpNpehDTLdDDmW/sMqb50/96C5PDXvvW7vvPBYvE6aBX+K1ZFhMYVrDgLzaV8I1gaqOTatqCsUeKurg/6zkFYL3M9TTH4h9nwvZEaS3zILdRsc9PWfUhHzW0fopIoUPZDoIcJdXbJLFhwYJ2T48XcT8ZO4nScfqMqxAYmPixj1XHtBXnWAsOL5N7kXxaYHtf3d++MDNCxzWz0d7MemgfXJTnYRvyt0/iSU6K/3eRb4qktPAuMLIYlWuSAk3PtRrY2opWT92Gk/X7Uy9rwh11Y8vttBgX/e9QX6uuOGdOYMtRAzSuM2GZwEJWV55xXzUeKUZxNZYZyECTqfyRyv4TRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=das7oRhlNnp01f10RzWhUIuX6WpGFOKjL/sPFCNg0Hk=;
 b=NDs2PxnPbq2IjxoUQHTERriohMnMQPqBXlQ80YdEDL9zn94UNMHc87fwZ7dTbg/z9htsL5yVse4+SaR3ST40qOIuXpDZMmWism3AWfDj6Zrl+7qqGX5QubfihAqwQ1sTOddRH97TdRqxsEOI8XqLS8Q1V8v3TRiYEHlxYs8eS5xTfvtT0HwSym2yTFhOND/IEvh0irE8Yum6M64p3Um3Q+QvsrCMCtSP/tgI8kFYgy/EwaKKnDQM1fltMemmIpuM7nlbz2dpPsrTXZTGKd9naRT/evzFWVbEs2jQtRN1pv2Nj7uz2BejIkM6gk74eViNINt+pRvh9AeJx2vYvr1Z1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=das7oRhlNnp01f10RzWhUIuX6WpGFOKjL/sPFCNg0Hk=;
 b=TtzWost/oU1xqREGPwRVmayon9y1htQ3xxbH/f67s9uXVIymX/I8BCUyGdVJq8Lm8+aCOg8WzB14pT0yb798xNbeDAS4UpK0PI8i7+5lQiyZEXmli0h2ac5qgB4xzMSBwpWqfzB8j7zmRJrfxt9voRbMc7FxHL+lTfqepMJ+vSo=
Authentication-Results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB6PR0302MB2631.eurprd03.prod.outlook.com (2603:10a6:4:b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Thu, 6 May
 2021 22:36:37 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b%5]) with mapi id 15.20.4108.029; Thu, 6 May 2021
 22:36:37 +0000
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
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <448097ba-7616-ccca-7219-6532dac04dbd@seco.com>
Date:   Thu, 6 May 2021 18:36:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <ff8eb398-fd49-fdb8-447e-2f6270cb006d@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.195.82.171]
X-ClientProxiedBy: MN2PR17CA0032.namprd17.prod.outlook.com
 (2603:10b6:208:15e::45) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.1.65] (50.195.82.171) by MN2PR17CA0032.namprd17.prod.outlook.com (2603:10b6:208:15e::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24 via Frontend Transport; Thu, 6 May 2021 22:36:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91e3b859-0a01-471f-a74d-08d910df68d9
X-MS-TrafficTypeDiagnostic: DB6PR0302MB2631:
X-Microsoft-Antispam-PRVS: <DB6PR0302MB2631FB8AB76C222397D891EE96589@DB6PR0302MB2631.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uXRC4uYesBgYWiz+Bpew5nIqkYKrt8eyiiD3VWf1/jw6C+yfyLzpOMwpRhadk+RCZKFOskE0Kvokj/ixOpae5l+8ddvEryZjuAg04UuibsaWaENjwvxIX8IC4/ru/1nhrNcr6nD3MbQKlT0ebXJVayb8gJdGlL+72v2WVuHG14g39Prqa8Ziwshjb8aUFK6YHFoEWJ3HCtlm66Mmzh6Jrql1yt5gVOupkiEf0fK18KZVRwNY0Y5Tx4wSmybM08EZAs9YMzu+GL1kOAV4dDotjmOsbGXvvUPSnj/kUixNFrDfacPgQNN3KI/80DMaDhpPZcaC2poM2Ho30edVYsvK6IDzmRxmWfpnfTD4WKSv8CB3XqZLpx741wREruvZRNDA+5ncb5BaqY2x9+rNKN6GUJIKDQ7oY/aoHbbYM0rcMzkUCNwt+l1meVhrRXulIG0p0ulD6JroCXmd01HqDqsRxjOHxf7ZFH+KU2XNXI00LIwvCgqUgXlTRVlttcl/wsw9QBc2+dD8LLV/ea3agpUsYDi7RYJPXSPXblDQrWyxMR8Qj9n+G/N6uQeBIDutqT9jt2/S/dyc9vw3awkf4okV7EdZ6FMuyVORZFGgcwWU51JkjYXcydJgrNDTDGWJD1CS/WS4OXZTcXDjbW094mZHlT7yebI9iGkmk0QdMQ/gAed4vRP/DRQtFmIt7snVTaQQSdhNdIEKqzEoL+X0lWQucd4nQnheV6ZUktzMJhMK/PYROFsucwZ9GswgJhx9EhLh0tHjEf4HZl2eGdsrOJgaTWdUuHKZTIRsmsPjuGEPd14=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(366004)(39830400003)(136003)(376002)(4326008)(44832011)(54906003)(2906002)(6486002)(53546011)(8936002)(2616005)(966005)(956004)(26005)(6666004)(31686004)(38350700002)(316002)(83380400001)(5660300002)(38100700002)(16576012)(8676002)(66476007)(66556008)(66946007)(86362001)(186003)(16526019)(36756003)(31696002)(478600001)(16799955002)(52116002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aVRhZ0c4Y3FXazJXT2hGVjFrRTd1K1dqUmFVMkhvVUUrWjBxWldkd2hKL2tP?=
 =?utf-8?B?bzZxM2laYVRSZXBXekFHN3pwTkNVdGdOU2NKMFRDVUFxbHVBZE93Qks1bnA5?=
 =?utf-8?B?SEw4OVUvem0xSWphMHQ5ek9XSmFiOHA1Q3dGbEJ1SkRPR0dHUDAxUGhYcXp1?=
 =?utf-8?B?blF5SVNLakk1d25BcjN5Q0N1UVdmUko2KzIwSjljNWRqUHlwSWNqeEt1V3Q4?=
 =?utf-8?B?YTd5VnF2YVpleGR3c0FVUUZ3MzBHejV5dWM0ZEVkK2RrT01IZFVyOU8xaTZB?=
 =?utf-8?B?VE4vNU11OHhYYlM3VFg4NUxUK0htT3oyYkh0SjU0YUo4bWQ3MWd0YUo5aVV5?=
 =?utf-8?B?VkI1WHl3dU5ZMXhXTy9hMDFrQ0FiVUE0MFZqSzlxeVVtTnJ6M3pmYTdGZGhR?=
 =?utf-8?B?K1pabFk2MTJENk9qTjZhaHp3bzB4QjZkc3Z2VTM4Mm1zcnZGRVhPNDB1ZVBF?=
 =?utf-8?B?MUFjSGtwamZ1SDNGNG1wY0J6aEpKdXMwS3pEVGlNV2l6ZXJZOGQ0b2dLU3Vp?=
 =?utf-8?B?ZFduRXAyQjVKc0ZpQkorT3QwL214L3VUbGozVS9QcDdMUnNPaFlzRlR2aTdP?=
 =?utf-8?B?OXNGMWJMdHpRcmtzY3JHWDZSUks4WlVUK1NybHJKN0pSb2VRTTZwL1R2VWhx?=
 =?utf-8?B?MEkvaXJHaCtEUFpyWXJpSEdDZ2pua0M1bXVTcDJGSTJ4aE93SGMwN3VkL2J2?=
 =?utf-8?B?NDVvYkRoTmN3QzZ0eExSbk5VWjl6OFRXeEVGeXRxUmw4RE02ZEFyVU5sTXhK?=
 =?utf-8?B?dWsyOVhubUlxN2g4RkFmZXZ2dVV0Vkt2ZUV6djVZL2J3VldhWjhUM3lBeUtV?=
 =?utf-8?B?NjNVaWlxREdISk00NDh2dGJNRDMzTDVMR1Z2WnljNzExZUsyWk5yQnV6bDY3?=
 =?utf-8?B?RHUwQy9EdXJlUXBFeHpmbzA5YzBBZldMakFzbjQ2WDlZdmVkN21nRHlzem9I?=
 =?utf-8?B?ZVV2TlFKcFNzelNSeWk2Z0k1QURoTWthMUdLa041bU9PVlJDRU9EVjRmTThP?=
 =?utf-8?B?RmlGVzlOcE85RGNDYVg5Z1VEZXA3N0xDR0Q1aUVFNHlSdUxYVVQ5VkxONHJu?=
 =?utf-8?B?dGpBTUNZd04yc05CY2dsWnd5TjJ4cnhjR25RNWVlUHdCUnE5aml2UWd6WndM?=
 =?utf-8?B?MDVpb2hjTm8vVUpPUzBZSkxiVmVSRVNVUEtsUjAweVlBWGFoMEZKaGdEMjJt?=
 =?utf-8?B?anZkZlRoQWpOOUUwUzVIQlJXa2JSdzE1TDBhbnozWm81VEtDZkZaNmJRWWdC?=
 =?utf-8?B?b1RwS3hpcUJDS0dmellNazgwc2ZTTHh4VThwNU5LVkNKRm05NElTejd0S0hT?=
 =?utf-8?B?YjZUOThVdmh4L29XanBVQXEvQ2pzbWJLYXhQanFFWWxFWkpxdzBmRGNXd0Zk?=
 =?utf-8?B?YVZtc2JkVmxZbWRhd0tkQ2xYdFpEQXFuMERrc1MxSEd2NzlCK21FOXRnWmR5?=
 =?utf-8?B?R2VYT2dLY2Jua1RaREQxb3p0UlEvWHNBV2k0YVYvaitWRnluVDZIR29qZjVE?=
 =?utf-8?B?dll0dUh1ODBjSXVUWDIxb25IVnlxaWlkMkh0c1h2ZGxJaU1UcHl3a2hMcTZI?=
 =?utf-8?B?d2tMN0tyV0Z1Y2ZrZHcweVV4ck1pRDZzQ2w1UVRDN0R2eGJ4WUhVSTVCMFpR?=
 =?utf-8?B?blo3Tk5WbFpnN0Z2R0ZZY1M0Y1ZuN3Y1L3pleUFkaXFkSGhpM2V2aUlpREdP?=
 =?utf-8?B?WXY0VXhMblBXQWVrSzJhWnlTMWNQMVlGWUI3QW1ib2NkK3NiMTRMM3NxYm43?=
 =?utf-8?Q?wNlkZxXfmY1YCyYRWn6q3/G/N8zKtzNMS2KFPSZ?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91e3b859-0a01-471f-a74d-08d910df68d9
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2021 22:36:37.3711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YRrCa80uqhCkWUzD3Vy3RvyTrwMkLYC2nmy175fhL+HU7S1Musro9tE206j8JC+DZ0NGW7LdLq+tHb4OA3mOfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0302MB2631
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 5/6/21 12:54 PM, Michal Simek wrote:
 > Hi,
 >
 > On 5/6/21 4:28 PM, Sean Anderson wrote:
 >>
 >>
 >> On 5/5/21 2:37 AM, Michal Simek wrote:
 >>>
 >>>
 >>> On 5/4/21 8:49 PM, Sean Anderson wrote:
 >>>> This adds PWM support for Xilinx LogiCORE IP AXI soft timers commonly
 >>>> found on Xilinx FPGAs. There is another driver for this device located
 >>>> at arch/microblaze/kernel/timer.c, but it is only used for timekeeping.
 >>>> This driver was written with reference to Xilinx DS764 for v1.03.a [1].
 >>>>
 >>>> [1]
 >> https://www.xilinx.com/support/documentation/ip_documentation/axi_timer/v1_03_a/axi_timer_ds764.pdf
 >>
 >>>>
 >>>> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
 >>>> ---
 >>>> I tried adding a XILINX_PWM_ prefix to all the defines, but IMO it
 >>>> really hurt readability. That prefix almost doubles the size the
 >>>> defines, and is particularly excessive in something like
 >>>> XILINX_PWM_TCSR_RUN_MASK.
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
 >>>>     drivers/pwm/Kconfig      |  13 ++
 >>>>     drivers/pwm/Makefile     |   1 +
 >>>>     drivers/pwm/pwm-xilinx.c | 301 +++++++++++++++++++++++++++++++++++++++
 >>>>     3 files changed, 315 insertions(+)
 >>>>     create mode 100644 drivers/pwm/pwm-xilinx.c
 >>>
 >>> Without looking below another driver which target the same IP is just
 >>> wrong that's why NACK from me.
 >>
 >> Can you elaborate on this position a bit more? I don't think a rework of
 >> the microblaze driver should hold back this one. They cannot be enabled
 >> at the same time. I think it is OK to leave the work of making them
 >> coexist for a future series (written by someone with microblaze hardware
 >> to test on).
 >
 > I am here to test it on Microblaze. In a lot of cases you don't have
 > access to all HW you should test things on but that's why others can
 > help with this.

Ok, can you convert the microblaze driver then? I'm afraid I can't work
on a driver if I don't have a system to test it on. There are too many
small bugs which can creep in without anything to work with. If you are
insistant that there must be no driver duplication (even temporarily),
then you should help with the deduplication :)

I would also be willing to try and get a microblaze qemu setup working,
but I have found no good instructions for doing so with mainline linux.
The best I found was [1]. Do you have a working setup for this?

--Sean

[1] https://blog.waldemar-brodkorb.de/index.php?/archives/10-qemu-microblaze-system-emulation-tipps.html

 > As I said in previous thread driver duplication is not good way to go
 > and never was.
 >
 > This patch targets axi timer IP which is already in the tree just for
 > Microblaze. You want to use it on other HW which is good but it needs to
 > be done properly which is not create another copy.
 > The right way is to get axi timer out of arch/microblaze to
 > drivers/clocksource (or any other driver folder) and add PMW
 > functionality on the top of it.
 > I would expect that PWM guys will say how to add PWM support to timer
 > driver which is not unique configuration.
 >
 > Thanks,
 > Michal
 >
