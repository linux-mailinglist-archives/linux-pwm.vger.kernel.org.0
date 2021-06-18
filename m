Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1051F3AD461
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Jun 2021 23:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbhFRV02 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 18 Jun 2021 17:26:28 -0400
Received: from mail-eopbgr130085.outbound.protection.outlook.com ([40.107.13.85]:28830
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230338AbhFRV02 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 18 Jun 2021 17:26:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ROnpRKAyUt90vwk613f4aj8w6RGd1mjDW0lhS03yR/KPIDrEtqojLh9v9vvdvSHwKiyoB+09bftMPdXN3Xt5Z/geCZyMgm8TrcDKG/83QwKYr5iVswa+IlTDkL5XGPfDOqe9Izad3PN/2bSGMV6ABWuOyNxic5kKXzpG1/XX2vqJ/Iy2pQR7NeGmRkCeHtJbP2UGLYtegw+S5z0QIKwV0BAw5QS6PMUJxlPMzZ/0kwQ/KtPLCe/RxlyvfS5Bkz+aCwi6Q7RrfofH3MN/kHugM/8x3iDMM8Lu+xS7TWwQC9QhhY2tdU85vtoUMScHroGDHESw8tdgPLHLctCClE1VKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+81+EczAuz2ua6yz3+QW2QnRNp7D4wFS2O5R+uhml4=;
 b=i5Yh7WmTlCxhDN74D8optAd4KJydaAufP0/jlwfrtEi27auiWpsSnJAtZhMuLCI+2PTIfRvNjpYvYxWQZ0D/gdJz2kIgj84wmQIliELqQbdaeyXPdOGtoPXHu2Ao23WZkPN8SaiDOSwIuNbvEASS0TSoWX6F/FxOBoN9r/sAinwzqaszKZ2psr+n+sJYaGRWp6A0DB+c5sMmBJ8woooxT+AEegF5T0iv7CQdibTz+3+hTsKonnEIHS76/21Jdee7TfVCvN1esKURhlWNbuHJ/xwZxZXMTv8LYyWOIJ84REScyz1k+c/GjH+LMhw9K9/nxRQkN1CSdI1KwAObx8+f0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+81+EczAuz2ua6yz3+QW2QnRNp7D4wFS2O5R+uhml4=;
 b=gZ78spp5r/pQFCIOz+BedzVo/nqvVMSu9HbANFdQeMFYxPs/kPmZREwAYdlSVIWMo38HuYcO9WxNidz0w/U2JBSqK5iwR7GFeg09QCvTW/AUqKfHfp4ujgEBOA6eh5y4/s2IRunVoC6sTMPVzxO5ieCv/T/VljxM4nVFeOcYWpk=
Authentication-Results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB6PR0301MB2183.eurprd03.prod.outlook.com (2603:10a6:4:47::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Fri, 18 Jun
 2021 21:24:14 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b%5]) with mapi id 15.20.4242.019; Fri, 18 Jun 2021
 21:24:14 +0000
Subject: Re: [PATCH v3 2/2] clocksource: Add support for Xilinx AXI Timer
To:     Michal Simek <michal.simek@xilinx.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel@pengutronix.de
References: <20210511191239.774570-1-sean.anderson@seco.com>
 <20210511191239.774570-2-sean.anderson@seco.com>
 <d4bb7b5d-9f38-cf60-fb0b-18f8e0ca2b1e@xilinx.com>
 <5f960034-174d-0ed8-9f52-3d5fde90e16a@seco.com>
 <9f227f96-a310-0fbd-fd34-91eb386306b9@xilinx.com>
 <7a06cf46-0f85-1edb-ca08-abd7b2543ad9@seco.com>
 <41542760-3967-4f9a-0f0c-1206e03ff494@xilinx.com>
 <d206a399-454e-d9c5-e2d3-337d098ed7aa@seco.com>
 <2296d4e5-717a-0470-d487-e0924cf6c076@xilinx.com>
 <20210525061131.omrbcdewf4z75ib7@pengutronix.de>
 <64318c16-780c-336a-8580-e70c91b71cbf@xilinx.com>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <48f972d5-8690-7850-317b-59bb9680d8f9@seco.com>
Date:   Fri, 18 Jun 2021 17:24:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <64318c16-780c-336a-8580-e70c91b71cbf@xilinx.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [50.195.82.171]
X-ClientProxiedBy: BL0PR02CA0024.namprd02.prod.outlook.com
 (2603:10b6:207:3c::37) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.1.65] (50.195.82.171) by BL0PR02CA0024.namprd02.prod.outlook.com (2603:10b6:207:3c::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend Transport; Fri, 18 Jun 2021 21:24:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ff6151c-3f7e-470c-cbe9-08d9329f6c1f
X-MS-TrafficTypeDiagnostic: DB6PR0301MB2183:
X-Microsoft-Antispam-PRVS: <DB6PR0301MB218315E81679A8CF8DD3CC5A960D9@DB6PR0301MB2183.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qc6WjKp+O3RZP7wumKiRvxAmISxL6ZLDjxiKQ4OHP2qF9vu07QgNwm4icxXmXYP+cgIQvdv+Grtjx+43jqz7DnYjXg36DdqgLHUrANrf5k2kWV2YVqEsVQQcFyVX20vDa+SIA+3ObnKXdO/LWUPRnll97ZXyYeG+RsGepw2Ud6mKaNRtTQcD3H985pYS/aOYUU4oZcNLxgazElhNHm+qpIToilc4RDY6QxA842WVcfASRP9cWmYJNqpJyeCWNAsNRu1RXEbE2En1XkemoCOsSj6hz9X7UOupHF8BmgkyLEn1s6AcmuAZAz7mwXo5VbCLaf4ABtuQ+/RRoEJaSqKn6BEHObw9cVQKUsO5MAvFISmX5/yrTH9hVCJIjl4uUipPNvX6yDVL/rT+k9sRMoCfjmHC8dK4bxTrU2W4AB8Dn6EUgY0rt8QxrmJzmLP1+yAPti3bfvcVUiiX7A09kVq7l9a7b/40S5kRe6tejRvXxpf4F3vyk5YTYIaVblqYh1rSSsgwGBEfKHXiocyznHf+vjKRWl8UznQlNLkJxQIC0RNx3U0MQY4//DQKUFa9TweRZCgRWhrAJ5aFn/OCgW82KJ4iuZKscdl71hQLtJFZZ1VEteI5l5xGZEL8/VX0COCqPiDAhjmXUbbyTiHDUiIgWMrsAm6YUNSToWXi9GJWaZ2+RjSyN0InSxPIk/0MMm4PUlvykLPaAr/gJHY88tjvguqZk4tt2VhpNoK+4aOUHUY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(376002)(396003)(136003)(346002)(366004)(66476007)(66946007)(66556008)(6486002)(31686004)(6666004)(2906002)(5660300002)(83380400001)(86362001)(16526019)(8676002)(16576012)(38350700002)(53546011)(26005)(2616005)(956004)(110136005)(36756003)(38100700002)(478600001)(52116002)(316002)(44832011)(8936002)(66574015)(4326008)(7416002)(54906003)(186003)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?Windows-1252?Q?21cqUhWaXhT4RqyujR5VYRtJPOScmKpVtB1oJj2utcES7t3nvWgc9gXm?=
 =?Windows-1252?Q?HKf8Z5j6zE/r9ng+40WM0DQPUKOpdsAkrNd7TTRKJ7UmEpMkgyj8aUEL?=
 =?Windows-1252?Q?KEs5X2Mmf0+1dCG9UJVAVN4KCNVaVj21MZxiO3qBCrNWDvOEqcDSAF06?=
 =?Windows-1252?Q?JSBYvaHTZZZKtkCKUwTrIfO+RpZ8s9ljdDofBp13TfZJwliitBHMX5P6?=
 =?Windows-1252?Q?FCNvsmTMRt/bKZ5aJWyUxaeDYrXkjYJucGgA70AyY+NM8340AmQsUSLm?=
 =?Windows-1252?Q?Yj5pRTed9Sb33IlLtXpRiSujjSubigYsEsCWVnWuiNNUn54MjdFiJHAD?=
 =?Windows-1252?Q?AAXCKWTbfG5MPWEdXAZ809XeiSJypxpNIlJMbpM9R1qm9OYXchZJGFoX?=
 =?Windows-1252?Q?gMizTgvbMK2hEoNV8C0jqo4cuhYn6cwOUTQu5a//EppUHSch7J4cnJNC?=
 =?Windows-1252?Q?tHFELumyho80qR0EcqJEvbWnqr8Iv8JIKt+CQn3L0J0mAGLXGmMu/Sbf?=
 =?Windows-1252?Q?Ux2o0LgfVCqPGX7MjE2H4/bFwFZEvgXYpHc3cBbtxB8ypEnrF+XT+qYm?=
 =?Windows-1252?Q?sh4njO88H9cgqS9NW3sUJJngkXyWrg9ZzNAImWss36gPIIkSV4cTwwFF?=
 =?Windows-1252?Q?sKDGBAb6wgkyltZCclzDOfdA+ctS1Iuo8/I3zrSlYgGU/Z8RkR/rVuJf?=
 =?Windows-1252?Q?IbRdCqXT7vOmPg/d4gSTRm75Ln0tB49Z1Vp2A2Z0yXNA2LumLsc6lWeC?=
 =?Windows-1252?Q?PpFSKIIu4Coo/m8FmXWrAHEc3n/Ez44hZWhnG2JkwKT5wBbQ/6jdqSlC?=
 =?Windows-1252?Q?EyXgq+ZZd+BiRKaTGDghyHv654FuOakf8rIMVE2xq7qipOLyf+cG7hiK?=
 =?Windows-1252?Q?4xACAfYM2b4Y6X1tT1t8K3AYo5PU5KL4Igis7YvdQpSDiM9biy2Qhr93?=
 =?Windows-1252?Q?vgGOgO0DXe/XqIaMmmHU4qFHD3z6MQi/FkX96A2Gbq3k9ABKfPKQBkNu?=
 =?Windows-1252?Q?UUf+8YaKQUsfmdX1rWO6e/wzhKrkXKxV5N+dvUQW0qtrXFFo1PzDTvyN?=
 =?Windows-1252?Q?UrZGgWFKqmcy9Nu4/IDRvBKfb7cpr1NkV+hHaATunyvp/OAJ81e1Ufwu?=
 =?Windows-1252?Q?feLT0vAmYM6clZRfyHzuhINVzxFDyHoSrRQnk7TblN0xA4Kkwg/H5Noe?=
 =?Windows-1252?Q?ki3eFHyRpN4yfSCx0lxRI/pf4KWU/oz7qGfV2G8sZpgXE8VjR/K/KN45?=
 =?Windows-1252?Q?TKVfXTS+wkmUWJrLPMH7h4+q53h9jgrKNlZD1tKIkxb6LgrXab5y31Hy?=
 =?Windows-1252?Q?pIYtcu+riFg2GqGI7wuVoMtFriUHRdx+CUxQM44MqF/sjJ51ns9pNIsW?=
 =?Windows-1252?Q?+k1BNkz2WYJ4BRy+6AHEYgHDMcG/ZsKL5sRGzOoWvxVn3oPf9JKL1fVH?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ff6151c-3f7e-470c-cbe9-08d9329f6c1f
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2021 21:24:14.5557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dsQ1YxMZ9ILlwUouw7dxKIpZjkFqozuHM2YDVgogvYkLrxLngaNBAmRcKBdRyZ8lrI/dA5U63nZ5TwiL5AlblQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0301MB2183
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 6/16/21 8:12 AM, Michal Simek wrote:
 > Hi Uwe,
 >
 > On 5/25/21 8:11 AM, Uwe Kleine-König wrote:
 >> Hello Sean, hello Michal,
 >>
 >> On Mon, May 24, 2021 at 09:00:51AM +0200, Michal Simek wrote:
 >>> On 5/20/21 10:13 PM, Sean Anderson wrote:
 >>>> On 5/19/21 3:24 AM, Michal Simek wrote:
 >>>>> On 5/18/21 12:15 AM, Sean Anderson wrote:
 >>>>>> This could be deprecated, but cannot be removed since existing device
 >>>>>> trees (e.g. qemu) have neither clocks nor clock-frequency properties.
 >>>>>
 >>>>> Rob: Do we have any obligation to keep properties for other projects?
 >>
 >> If a binding is in the wild and used to be documented, it has to stay.
 >>
 >>>>>>> 4. Make driver as module
 >>>>>>> 5. Do whatever changes you want before adding pwm support
 >>>>>>> 6. Extend DT binding doc for PWM support
 >>>>>>> 7. Add PWM support
 >>>>>>
 >>>>>> Frankly, I am inclined to just leave the microblaze timer as-is. The PWM
 >>>>>> driver is completely independent. I have already put too much effort into
 >>>>>> this driver, and I don't have the energy to continue working on the
 >>>>>> microblaze timer.
 >>>>>
 >>>>> I understand. I am actually using axi timer as pwm driver in one of my
 >>>>> project but never had time to upstream it because of couple of steps above.
 >>>>> We need to do it right based on steps listed above. If this is too much
 >>>>> work it will have to wait. I will NACK all attempts to add separate
 >>>>> driver for IP which we already support in the tree.
 >>>>
 >>>> 1. Many timers have separate clocksource and PWM drivers. E.g. samsung,
 >>>>     renesas TPU, etc. It is completely reasonable to keep separate
 >>>>     drivers for these purposes. There is no Linux requirement that each
 >>>>     device have only one driver, especially if it has multiple functions
 >>>>     or ways to be configured.
 >>>
 >>> It doesn't mean that it was done properly and correctly. Code
 >>> duplication is bad all the time.
 >>
 >> IMHO it's not so much about code duplication. Yes, code duplication is
 >> bad and should be prevented if possible. But it's more important to not
 >> introduce surprises. So I think it should be obvious from reading the
 >> device tree source which timer is used to provide the PWM. I don't care
 >> much if this is from an extra property (like xilinx,provide-pwm),
 >> overriding the compatible or some other explicit mechanism. IIUC in this
 >> suggested patch the selection is implicit and so this isn't so nice.
 >>
 >>>> 2. If you want to do work on a driver, I'm all for it. However, if you
 >>>>     have not yet submitted that work to the list, you should not gate
 >>>>     other work behind it. Saying that X feature must be gated behind Y
 >>>>     *even if X works completely independently of Y* is just stifling
 >>>>     development.
 >>>
 >>> I gave you guidance how I think this should be done. I am not gating you
 >>> from this work. Your patch is not working on Microblaze arch which is
 >>> what I maintain. And I don't want to go the route that we will have two
 >>> drivers for the same IP without integration. We were there in past and
 >>> it is just pain.
 >>> I am expecting that PWM guys will guide how this should be done
 >>> properly. I haven't heard any guidance on this yet.
 >>> Thierry/Uwe: Any comment?
 >>
 >> Not sure I can and want to provide guidance here. This is not Perl, but
 >> still TIMTOWTDI. If it was me who cared here, I'd look into the
 >> auxiliary bus (Documentation/driver-api/auxiliary_bus.rst) to check if
 >> it can help to solve this problem.
 >
 > I recently got patches for cadence TTC driver
 > (drivers/clocksource/timer-cadence-ttc.c) for PWM support too. It is the
 > second and very similar case. This driver is used on Zynq as clock
 > source and can be also use as PWM. I can't believe that there are no
 > other examples how to deal with these timers which are used for PWM
 > generation.
 >

The approach I took in v4 is that probe functions and driver callbacks
live in drivers/timer and drivers/pwm, and common functions live in
drivers/mfd (although I may move them to drivers/timer since Lee Jones
doesn't like them there).

I would greatly appreciate if you could review v4. It has been on the
list for three weeks now with no comments from either you or Uwe.

--Sean
