Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 854E0380C02
	for <lists+linux-pwm@lfdr.de>; Fri, 14 May 2021 16:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234436AbhENOlr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 14 May 2021 10:41:47 -0400
Received: from mail-eopbgr70043.outbound.protection.outlook.com ([40.107.7.43]:7563
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231792AbhENOlr (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 14 May 2021 10:41:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E5avTZ9ZnOl2mzRVHnSb5yA8Y6apw18IhgryR7VSK/L8Mr0738YAoumtwbvSpgqSHqnXwsDxhDyIIapvfD160DrmwNYIISlqo2s7NxiJJFfeSp/LhR3rUR/rNZm+PNQ6dcYBhUkz7GaL+uZJhAjvt9Y5gbVJDmj8r+Hin1bMPKSMUuC2SpKY4OfS2Z7ESlTGQgMpsiG7eQObsZuIoJ0FeYb77+qV3m6B90T6+vUDBMRvlcfGiS+LhaaPAPJZwE4wfs9OfgrKdsgkDmTSJ4oIJVelgiugKZ/n8W9rpArzEO9/xghUAmk628y04+HDU7E8k1DSdeXgLFi2nR2j+1qCfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKma1LLAgHk/SDT2dk4kXwr0uUX4nlWJIPIJLJ+N6oY=;
 b=AhtnQaPXWv9ZTEX6kqfl9IU+z2AXuoqCAIBwM+UAzYe8dj7sx6IevGSNGpZIG7YMswTf4CzHVY3+eitwYjqF5w6Ou9U3/uMgpVydBTulc2pnOZG8jSep/qb5d30rPu//yH+XW3X9rOHL1LOb45N9jrvoK94VMUESE/AyaGH3+aAtxV21RtUEGd4Hczr9jcleUfblii5oopDIDIo/w+AUTv/H8ntLLtk+ypvcdg4E9yBWLhIYIv/Q0lcNlupPDD90K7CSVg1u+sjwj+YAIexYi1rYGrPY/wRJcA4ut6yQERjiI2ihiCOZqD40lvwFL5a7nOuRda1doCFLZAn5gyRpfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKma1LLAgHk/SDT2dk4kXwr0uUX4nlWJIPIJLJ+N6oY=;
 b=Yzy5Msrxb49DkkuUmiYKIIOixPq5xlSIlR4hOqdIKagUU/zXpGUCBZ/uAbzsRSqOVHp1IryA7RnUcCcoaYFXvm0vTnuyd+6krEBMgNmT2MybhlHipM6YetG6gaN+dC4BQiwVO91R0/7gCfii+Kxnx48qFZ4elb1VlPoCyXlPaZ4=
Authentication-Results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB7PR03MB3801.eurprd03.prod.outlook.com (2603:10a6:5:33::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Fri, 14 May
 2021 14:40:32 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b%5]) with mapi id 15.20.4129.026; Fri, 14 May 2021
 14:40:32 +0000
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
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <5f960034-174d-0ed8-9f52-3d5fde90e16a@seco.com>
Date:   Fri, 14 May 2021 10:40:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <d4bb7b5d-9f38-cf60-fb0b-18f8e0ca2b1e@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.195.82.171]
X-ClientProxiedBy: BL1PR13CA0069.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::14) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.1.65] (50.195.82.171) by BL1PR13CA0069.namprd13.prod.outlook.com (2603:10b6:208:2b8::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend Transport; Fri, 14 May 2021 14:40:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66de1478-c7d9-4c34-b9e3-08d916e639e3
X-MS-TrafficTypeDiagnostic: DB7PR03MB3801:
X-Microsoft-Antispam-PRVS: <DB7PR03MB3801D24D4E1BBD98E6B150F996509@DB7PR03MB3801.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sR60hE9Y6FxwA7zgNufrCIB7p0ArgKvBXjy4pwKEzKLd3N1q2G5+W1Ow8W5GAkCkPJHWMnO3Bf3CKZXTaNpFvvkQnOpkte3El8XUgP6H8W+PuYSC8X5eYFM12OMBt+OhN6/JEg1cSE94a6i2tlaHEXEzoyYJrw+exSq8GCL90V+6hGUBInu53Zv+zLrUKalf3R+/WdE2kK1DG6lY5eVqA93MAbxCjRh25IuQKFXU61io9Wh52r5uYGwroXkJ57rosSZeigrAphCzT5Ejjbty1lgnHc1sesvLyL3ys3yO0T3PpFNSm6eelYVJYt4yhkEg0Tz6auh7mUfh8pf7jurso/9l8bRFbwkvtkPf+OTQ/VaPeITXgh/cY6kIZjdX8TcVpgRumBbhuTgat6MnwBugXuZn56dPcGZN2eM8Ztys5Ykqxfk6uLroO8Pwbj6dwRUm69Q8RbzLbuF+BnJAeW/WzKcL5yW3pDHvFDp4LLBgsj7Jfzhp9WwesSTS+ptSuZgX/7M+EAgLj+Bcb/QwbgVYrlR0gYOz+BUy/QUddyn9Av7aoYz/FCxY0libiW3Cl3F5a5tLTGN4QMFzNUI4NORFXQuzspELDHGsvpQgxXNw6dw4PR5t2LHNLAb2UytNSR56fEoJHjPYT0FmeUeAaEFarm9iVM7aOO5vDMJLHeDnS181llyCj5G1pIX1m+HXExGOCNfqIa7whelyThMXovDWWd+ZgvPDc6I4ex+heOxb2YidkBQgyzzV4TBEb3fQUyNDUBAyyJIh++fzXjBhHTcvJQXLLjzGEY4GKJD1gZs12lk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(54906003)(86362001)(8676002)(16576012)(6666004)(66476007)(6486002)(66556008)(66946007)(44832011)(966005)(36756003)(4326008)(8936002)(7416002)(83380400001)(2616005)(956004)(2906002)(38100700002)(38350700002)(16526019)(186003)(31686004)(26005)(498600001)(31696002)(53546011)(52116002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QjNEL2NELy9maXh0SWVFRE5DTUt0a3VQK3FzaHExYnhhcStkTTI5amgzTWhv?=
 =?utf-8?B?TDZINmlmcytqdHFabkUxTlQwUkxMR2pHUWRYOUZoeDBQUnhFbVhSWXRMT3RP?=
 =?utf-8?B?Uml6NmhxSnpmei9oVU5sbjAyTnd0QzBHY1FFcFVwRlpscGhhRngybTZFeEJH?=
 =?utf-8?B?eEczYndxUmRzYlp3aFhYSEtIZ0U1UHUzSUpQQjNRb3E1MEpKeVNYQzRRN2s1?=
 =?utf-8?B?UGR3UE9RazRkM0tOQUhsb0ZYK1ZZTjNFWTNXMFQwLzJxS1B4WWU0QWdtMTJr?=
 =?utf-8?B?MlBja3NtRVRidlpLOEVLMnhRTmdxdEdicnF4VkpOcFBOclRPdDNXcEFGVnRV?=
 =?utf-8?B?aThlZmZ0ZzhacDROd2FPYU1hcTFXZlZMczI3T21VTEpYcWJlbU9hU05EWUE4?=
 =?utf-8?B?Sk9OeW42RzBMR0FDQXpMRll5Nk5LWWZOenRDNWZDYmxDOWRWYmFjWHJxUjdG?=
 =?utf-8?B?ZzZRcEdXemZKWTkxZ3l2RVZzZTg4YVh4SDFZcVIyU3o3TjFBa2lMZkJybWUv?=
 =?utf-8?B?TndvVEo0WUhqVUF0TWp5SXNKK2k3eFllQVZ1YmYra3JyRzN6V1cxSEVsb2M4?=
 =?utf-8?B?bkJreElCbXFNOTg3Tk5ncFRLbjNRY0ZORGJ2cHk2NjZPVXIzRVY5UzFvWEFM?=
 =?utf-8?B?MlF1TDJ4UGpEOEF4dzVYT3lSYnhwenNOUHRpcCs0QzFOWDZHekNjSytLM3Y3?=
 =?utf-8?B?SWMvTHc4azVVa1VFRlVMYXNhVnk0ODJOcDIxcUNoMjRpWlVXRnVmVFpsZWlS?=
 =?utf-8?B?QS9kY055T002azcwazFuRS9GREV6N3ZuWldNM3lHbmtpQkxhdXJFSDZTWHhh?=
 =?utf-8?B?V0txbDB2RTNhWmN2UVhQNnhsZXhwZlpFY2QxbkJvRkN2dWlUUHc5MkF1T3RZ?=
 =?utf-8?B?RjhaR2NVd3dKTDB2dU01b2NudmJjRTE0dkw1SlFXZmtQUUxYQ1RpMUdKUUcv?=
 =?utf-8?B?S0tycFpyZS9LdngyOUtsYkFaZGxZUHNOdExwaWFCbTNGaDd0MlU5THFPalc3?=
 =?utf-8?B?aVhyNnV1dk5qaHAraWtjcFdhREhqNERpZ3VmeXFqQWRkcG43eWFaRkZKeUFP?=
 =?utf-8?B?UkR0amtpbm45OFB5Q1Q0cTJXYzREWHU1OC9YZGFXRFdOVTNqdGtzRHo1VVpG?=
 =?utf-8?B?VkV1SEhqV0pUOUtzRjJQNk9RUDMrZmFDN2RkSXV3SEZXSlFFZnJadVVYT1VD?=
 =?utf-8?B?dlB4bFdRSWlrOVpndmhuMDFDazZ3U3FmY092SFdLS2Vicm1WU0R1NHd0M1VG?=
 =?utf-8?B?SVI5YXJISUdvUzhMRVdjem13SzQwWkZBcDdEQmVpdEFzQWRjb1JTWWZXbjFY?=
 =?utf-8?B?dW9FWlFTVFlKU0F6c1VNQWlkVTFRclA4TEFOc0pRbEVJTVA2VFA4MTBURXBZ?=
 =?utf-8?B?TzVFTWE5YjJWTnFBekZRbzd2Y0lhWVlhYzdDanAvYmhUSFlPbzlKNXFra2w2?=
 =?utf-8?B?R2hHWDgyWHQ3dnZoZmV1ZEdFeFE0MEd1L0FlRkFmaThqcTZLT05BalZqNm5T?=
 =?utf-8?B?V2VNU1BoTVltT0d2V3FaWVk3R1BzUjcxakNJQ1N0UStHOVNCazJyVkpCTTVK?=
 =?utf-8?B?Z0xvamowYldDWjY0MHBlU0E0aEpKL0JGUHBsQ3dBRlZwRjBCbmdsWElzZG5n?=
 =?utf-8?B?UWQ1SytzWHM0QWhUSjZJOG5lc1MxcWhRK3BxVFJOSVhHVVpVN3NwSHJ4QTFM?=
 =?utf-8?B?SnByZ1FSOFFmaW9yek1Gci9uSW9laGJlOElOYm9kc29SMnpIWHo2WkVsU1gv?=
 =?utf-8?Q?J/F6mHUKmY0QsxKBbVTDJHeYoaa5RWtcN38f0wR?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66de1478-c7d9-4c34-b9e3-08d916e639e3
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 14:40:32.0459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dkf5QZlJX42RxXy9tqBbazdfschblI387xL/hIsyhDIZ9mNBiIIUY4QNbyJlc2YT89TMd9JkG485dC4ESRBoHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR03MB3801
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 5/14/21 4:59 AM, Michal Simek wrote:
 >
 >
 > On 5/11/21 9:12 PM, Sean Anderson wrote:
 >> This adds generic clocksource and clockevent support for Xilinx LogiCORE IP
 >> AXI soft timers commonly found on Xilinx FPGAs. This timer is also the
 >> primary timer for Microblaze processors. This commit also adds support for
 >> configuring this timer as a PWM (though this could be split off if
 >> necessary). This whole driver lives in clocksource because it is primarily
 >> clocksource stuff now (even though it started out as a PWM driver). I think
 >> teasing apart the driver would not be worth it since they share so many
 >> functions.
 >>
 >> This driver configures timer 0 (which is always present) as a clocksource,
 >> and timer 1 (which might be missing) as a clockevent. I don't know if this
 >> is the correct priority for these timers, or whether we should be using a
 >> more dynamic allocation scheme.
 >>
 >> At the moment clock control is very basic: we just enable the clock during
 >> probe and pin the frequency. In the future, someone could add support for
 >> disabling the clock when not in use. Cascade mode is also unsupported.
 >>
 >> This driver was written with reference to Xilinx DS764 for v1.03.a [1].
 >>
 >> [1] https://www.xilinx.com/support/documentation/ip_documentation/axi_timer/v1_03_a/axi_timer_ds764.pdf
 >>
 >> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
 >> ---
 >> Please let me know if I should organize this differently or if it should
 >> be broken up.
 >>
 >> Changes in v3:
 >> - Add clockevent and clocksource support
 >> - Rewrite probe to only use a device_node, since timers may need to be
 >>    initialized before we have proper devices. This does bloat the code a bit
 >>    since we can no longer rely on helpers such as dev_err_probe. We also
 >>    cannot rely on device resources being free'd on failure, so we must free
 >>    them manually.
 >> - We now access registers through xilinx_timer_(read|write). This allows us
 >>    to deal with endianness issues, as originally seen in the microblaze
 >>    driver. CAVEAT EMPTOR: I have not tested this on big-endian!
 >> - Remove old microblaze driver
 >>
 >> Changes in v2:
 >> - Don't compile this module by default for arm64
 >> - Add dependencies on COMMON_CLK and HAS_IOMEM
 >> - Add comment explaining why we depend on !MICROBLAZE
 >> - Add comment describing device
 >> - Rename TCSR_(SET|CLEAR) to TCSR_RUN_(SET|CLEAR)
 >> - Use NSEC_TO_SEC instead of defining our own
 >> - Use TCSR_RUN_MASK to check if the PWM is enabled, as suggested by Uwe
 >> - Cast dividends to u64 to avoid overflow
 >> - Check for over- and underflow when calculating TLR
 >> - Set xilinx_pwm_ops.owner
 >> - Don't set pwmchip.base to -1
 >> - Check range of xlnx,count-width
 >> - Ensure the clock is always running when the pwm is registered
 >> - Remove debugfs file :l
 >> - Report errors with dev_error_probe
 >>
 >>   arch/microblaze/kernel/Makefile    |   2 +-
 >>   arch/microblaze/kernel/timer.c     | 326 ---------------
 >>   drivers/clocksource/Kconfig        |  15 +
 >>   drivers/clocksource/Makefile       |   1 +
 >>   drivers/clocksource/timer-xilinx.c | 650 +++++++++++++++++++++++++++++
 >>   5 files changed, 667 insertions(+), 327 deletions(-)
 >>   delete mode 100644 arch/microblaze/kernel/timer.c
 >>   create mode 100644 drivers/clocksource/timer-xilinx.c
 >
 > I don't think this is the right way to go.
 > The first patch should be move current timer driver from microblaze to
 > generic location and then apply patches on the top based on what you are
 > adding/fixing to be able to review every change separately.
 > When any issue happens it can be bisected and exact patch is identified.
 > With this way we will end up in this patch and it will take a lot of
 > time to find where that problem is.

What parts would you like to see split? Fundamentally, this current
patch is a reimplementation of the driver. I think the only reasonable
split would be to add PWM support in a separate patch.

I do not think that genericizing the microblaze timer driver is an
integral part of adding PWM support. This is especially since you seem
opposed to using existing devicetree properties to inform the driver. I
am inclined to just add a patch adding a check for '#-pwm-cells' to the
existing driver and otherwise leave it untouched.

 > Another part of this is that you have c&p some parts from origin driver
 > and do not keep origin authors there which can be consider as license
 > violation.

I have not copy-pasted any code from the original driver. All of this
was written by consulting with the datasheet and other timer drivers in
the Linux kernel. In some instances I have referred to the original
driver (such as when discovering the need for detecting endianness) but
none of the original code was re-used. As it happens, since these
drivers are accomplishing the same task, some code is necessarily going
to be similar. Therefore, I have not added the copyright lines from the
original driver.

--Sean

 >
 > Thanks,
 > Michal
 >
