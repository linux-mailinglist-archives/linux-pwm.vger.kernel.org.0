Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA510372D6E
	for <lists+linux-pwm@lfdr.de>; Tue,  4 May 2021 17:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbhEDP6Y (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 4 May 2021 11:58:24 -0400
Received: from mail-eopbgr70043.outbound.protection.outlook.com ([40.107.7.43]:54866
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230512AbhEDP6Y (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 4 May 2021 11:58:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cnk6smTf+XCc/4VDGwauy4S9bzinaN4OXc/zuw2QiBD4p6MtPJNX+ch+8I39eW0KfenFBMUhi5t0h17caxJ5S0qARXpHd7TTE/dTpRGYZL6N/Wh8pSwXbBYgE2WXiDA2jBv/1Y6S1g5nauAXR70gSCx6eWXVT95enRh0HsPdwR+oRbtGCVHpPX1C8riBN9orHUzi+Z+2MaJWM/rhVbtXYzEDQmEgn8vm1S5RKSPf5chKAlJUcsXXDr2pGxIy/5YGTF0RUa8JML1iPfD7ucFuKze4huzNc1YfyHHo9n2M70/kI0ADujc4go45untGDLZYC55wEq4HwzWfH9R70pAyhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RF0af6UEDJ3hbAYP6eEO99fzC3ldtJvNlg/rDvhf1HE=;
 b=nFam0K78nqtc79WtGG0kbr7YQlr5Z8leQmxKCgsXKVOdzLgoBrPDKZ5C5Y9LG2lSiYhrgJPMjNXQCQxqHcVXzOQ7tzs889YMj/DZU6+91bgrYhng0W3pQIzPT5ahD4tBa5chWiaWujpNxxLyVy45jVvXqbsBIX+cAp8lfjGXm2GmQ0dkOVyteiFyOE8yYSqobjuI7o+/k02/02vSmeoSd9LbDKsgWSQMTOsYrSfn4zZCrqXGmqepDuTDWZtI5+NimITLNSwttx6/MvILrscxmAWCpNElM0JXJHx707Xjy8k8X7mP9Pg1aY2xrappS6KN3LfePLLBr0aZ84JE/sf4Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RF0af6UEDJ3hbAYP6eEO99fzC3ldtJvNlg/rDvhf1HE=;
 b=eaoUF5BG8pmJaeak8vOcsFmldMHAbGSCX/gxIX8TXQIbqNzGEjO8LsnQQDb1kDOVFRnfC40bnjEDp3mszdWzT0wTnFzaMBNrJ7ZLUXkxvgK78hRxO/d3aAoYQQHEXox0e8/5hrF+XliVYrZXp6W+8B89AyVtFBqoP4LYAMsx7E8=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DBBPR03MB5141.eurprd03.prod.outlook.com (2603:10a6:10:f4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.38; Tue, 4 May
 2021 15:57:25 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b%5]) with mapi id 15.20.4087.044; Tue, 4 May 2021
 15:57:25 +0000
Subject: Re: [PATCH 2/2] pwm: Add support for Xilinx AXI Timer
To:     Michal Simek <michal.simek@xilinx.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
References: <20210503214413.3145015-1-sean.anderson@seco.com>
 <20210503214413.3145015-2-sean.anderson@seco.com>
 <20210504085112.edyy6loprfzejrjl@pengutronix.de>
 <dc6d9f40-a913-90c4-9675-0f84f789ab61@xilinx.com>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <71694d6a-21d8-2b31-0e66-2dfea52a6390@seco.com>
Date:   Tue, 4 May 2021 11:57:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <dc6d9f40-a913-90c4-9675-0f84f789ab61@xilinx.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [50.195.82.171]
X-ClientProxiedBy: BL1PR13CA0256.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::21) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.1.65] (50.195.82.171) by BL1PR13CA0256.namprd13.prod.outlook.com (2603:10b6:208:2ba::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.8 via Frontend Transport; Tue, 4 May 2021 15:57:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47553343-6346-4fb9-c580-08d90f154f60
X-MS-TrafficTypeDiagnostic: DBBPR03MB5141:
X-Microsoft-Antispam-PRVS: <DBBPR03MB51412CE44FC9CB95EA088346965A9@DBBPR03MB5141.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MfhCnv5dYl6jvMU7tgbWI/6XDjc0XPGJ0GNOnbhWsAsE2VIOzGYZe1X5RhTGw5aG8jAn7Fj7dVa6jCYwDsNII3BVYHUDL5Uv5Vjsm6NuCTrgq4VCuykxcZrpxfD4P3brMVPtqkrLBmdQYCNsCHtuVCn4bvTjMSBeu7opbhnt0x+p2pmkS13cxen97rcWagmIUMM+ySqyHA0DwwsN53UrSIOKMoVQ92MWgsQ2DTc1OzXp9JUiYRpGx0or/ThZjdryZGOS8k6u1I1sNdaX8c34RwSLhQeVa7K58QwO2E0FoH2abLVcPc99WLCX4gmtMGnLsU41Pbq0vwV48/Iq7GjLbO8FEvhv/UnyS4wm7Vgej2Yej+WRCO0oed84zY5swZUlTQFRSIH2+l/ybh9mCk4DYLL5IlBACNKB5WCI4gS+LdsFNYQqR34Y4HLnMAAZe3jh1CpH5IvgmJvfLDOzv/KaA2vFaCL0l/uXK++Z2ONP/lK4jbzVoIQEyQEJGWStE490xCa1IyO/W/aBko8UEE4yTNTjgtnjNfZrOl6OyZn+OlKJr/LGEbavhqfY1sO//ZU3HHkFxGAB3PGkxh0BKvzsWPWuA1Q+CaYpsOSfS45P+DWUk7InfonM2PQKhjX+E2zP4Wu0kM5L2CB9Xej+7ZdOdZ2PQDnKfG8T1UkEN+Pro5/GlTKIbrICOupJy9sNFKEoOcA4d6l19MtHNBQTOYl1Yf6yCnemI6LpJ3M6cmIvmZpifazB8rWebEwxcMdAWTBpKqrm+DJfZujXYnpMuajT6afl6DSEo5pKFfIeSdWXBRU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(38350700002)(956004)(54906003)(16526019)(2906002)(38100700002)(2616005)(52116002)(86362001)(44832011)(16576012)(83380400001)(31696002)(66946007)(36756003)(8936002)(110136005)(66574015)(5660300002)(8676002)(31686004)(4326008)(966005)(6666004)(53546011)(26005)(498600001)(66556008)(186003)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?Windows-1252?Q?tjI80OAsOVTHByhDgpw7IVbt2NuO8Hapc81gaC8raodyc+LWlY27Cvik?=
 =?Windows-1252?Q?o8VfVrmqWJDZ1jJkfsGsOsqY7N4+tqoPXjXofu0KWpU13ty8dWvD5oCz?=
 =?Windows-1252?Q?uW99D6F6TlMmCPRs5YGsPEB+kZ7V2oZp0d2OSGjY2wBYg6ePeOml2AIg?=
 =?Windows-1252?Q?Gk0K08qGcnSaT6uDxpdioZ1XE5qjib1OpZtgWRrxzBaLUPmz0gbp/ObH?=
 =?Windows-1252?Q?A8JS0CKnIBdulA7c8SiXkq03GxBfKJdA1FVDF388kUk7DdpuP8nKMa2o?=
 =?Windows-1252?Q?odrS7pybGMsBc/ZzypsEyur+ZzOWUhAme8s/4azeLGvf1MBkxsqsyCYC?=
 =?Windows-1252?Q?8BABh6/EuNJQj8Ry310EWtdQ9VVT5XboFJthUhDuZA5/IMaNIq7Iok8U?=
 =?Windows-1252?Q?BFxJ6cYndVca6p7qOyzGdkzFM/XqQaTGL3HNnGpYx9UB5M1s5qTvzF4w?=
 =?Windows-1252?Q?mGHfWNch2BerCS1GJu+kN3IgQARD3BWJBMsqPAkHnu1NpqLFjwRjPBnk?=
 =?Windows-1252?Q?GBwTwY2h1n8ukCUdBoJ2rrFvwO3q14uQKcF0YKgiGp/3uhW91tCVxVCf?=
 =?Windows-1252?Q?yhQntotqAjRMdIxS1E3z0bkE3SY3BGyGTG3WDsTEeeSeSZXKmhnRuVLR?=
 =?Windows-1252?Q?wf8nfPnLO8OmqWyKe3jipvozDTdJ3Ozb3KE36RRu9XglfJXmneeoJM4O?=
 =?Windows-1252?Q?GmQ1EhcQ/Xy2FFi9nsE4huKBkd2tksy4IhQIZS7EcAPRv/0QyIGQwiKx?=
 =?Windows-1252?Q?yaBB+5FJQsfCSbi/PpPXPbdvc+wg9YMI2YuSBKl6caHEa532xoVoPPkB?=
 =?Windows-1252?Q?v3PIGCPMfejMdoqSpdOqmI8Vy074E2WXKrYI5dV0T8tGViFjXSf3657o?=
 =?Windows-1252?Q?x5DgT+TY0+04jn4glLIcl7GZEtCNVcc6qkldvqNfsXEeieX/+mqWttR2?=
 =?Windows-1252?Q?2pOeXF32zMpcC7xhsBdH8gCpcNU7ugaohPDZgfVr3eOeohO36CpazIon?=
 =?Windows-1252?Q?rgia2lq/YGIfU2sVd3EUMEWSbpQtb77ffz/G2wfrk888QnvBWGqaYeJV?=
 =?Windows-1252?Q?NM9zYyZUFdkOPkHTpK4jusFewcBLh/pvSf+oCgWctybnQAt8z58iujSZ?=
 =?Windows-1252?Q?70e+Xb591YemlN9iP3YCDUFVRTlomcwoX0a/C6lGyEBuDaTclGrxMv37?=
 =?Windows-1252?Q?wgJzhwMdzLseAX0nt2sYzIJhJMMZthKFrv6WTJnyGCiRHyVPK8kKMex6?=
 =?Windows-1252?Q?vzQ+jpZzIrdu3fOF48CD8Kktoma/HiE/tElaLh3R3/uRgVsSXMtA/D0h?=
 =?Windows-1252?Q?u5qAdLBAY4z6rl1LQ45pbB8B+Ps7Q0xBpddcSZmIWJeldaF7Jo6okJp7?=
 =?Windows-1252?Q?EHkbkZYrvMlFwlBNaFtMt/MrJ3PhLqwZeGctoiiK2ocTlnjChlHzkp61?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47553343-6346-4fb9-c580-08d90f154f60
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2021 15:57:25.1836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mvvTpxYj3wqHKo8fYLc5cTy4/icfO2leIZf9kGVCl37Ui8EvRdf6i3685cLptXFb0478OPuuy6mYqmKFW01Zyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB5141
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 5/4/21 8:32 AM, Michal Simek wrote:
 >
 >
 > On 5/4/21 10:51 AM, Uwe Kleine-König wrote:
 >> Hello,
 >>
 >> On Mon, May 03, 2021 at 05:44:13PM -0400, Sean Anderson wrote:
 >>> This adds PWM support for Xilinx LogiCORE IP AXI soft timers commonly
 >>> found on Xilinx FPGAs. There is another driver for this device located
 >>> at arch/microblaze/kernel/timer.c, but it is only used for timekeeping.
 >>> This driver was written with reference to Xilinx DS764 for v1.03.a [1].
 >>>
 >>> [1] https://www.xilinx.com/support/documentation/ip_documentation/axi_timer/v1_03_a/axi_timer_ds764.pdf
 >>>
 >>> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
 >>> ---
 >>>
 >>>   arch/arm64/configs/defconfig |   1 +
 >>>   drivers/pwm/Kconfig          |  11 ++
 >>>   drivers/pwm/Makefile         |   1 +
 >>>   drivers/pwm/pwm-xilinx.c     | 322 +++++++++++++++++++++++++++++++++++
 >>>   4 files changed, 335 insertions(+)
 >>>   create mode 100644 drivers/pwm/pwm-xilinx.c
 >>>
 >>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
 >>> index 08c6f769df9a..81794209f287 100644
 >>> --- a/arch/arm64/configs/defconfig
 >>> +++ b/arch/arm64/configs/defconfig
 >>> @@ -1083,6 +1083,7 @@ CONFIG_PWM_SAMSUNG=y
 >>>   CONFIG_PWM_SL28CPLD=m
 >>>   CONFIG_PWM_SUN4I=m
 >>>   CONFIG_PWM_TEGRA=m
 >>> +CONFIG_PWM_XILINX=m
 >>>   CONFIG_SL28CPLD_INTC=y
 >>>   CONFIG_QCOM_PDC=y
 >>>   CONFIG_RESET_IMX7=y
 >>
 >> I think this should go into a separate patch once this driver is
 >> accepted. This can then go via the ARM people.
 >>
 >>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
 >>> index d3371ac7b871..01e62928f4bf 100644
 >>> --- a/drivers/pwm/Kconfig
 >>> +++ b/drivers/pwm/Kconfig
 >>> @@ -628,4 +628,15 @@ config PWM_VT8500
 >>>   	  To compile this driver as a module, choose M here: the module
 >>>   	  will be called pwm-vt8500.
 >>>
 >>> +config PWM_XILINX
 >>> +	tristate "Xilinx AXI Timer PWM support"
 >>> +	depends on !MICROBLAZE
 >>
 >> I don't understand this dependency.
 >
 > The dependency is clear here because microblaze has already driver for
 > this timer here arch/microblaze/kernel/timer.c.
 >
 > And that's exactly pointing to the way how this should be done.
 > IP itself is single or dual timer and in case of dual timer you can
 > select if there is pwm output and use it for PWM generation.
 >
 > It means it is timer with PMW together.
 > I didn't have a time but Uwe likely knows this better how to design it.
 >
 > I see that gpio-mvebu driver instantiate pwm driver. Maybe that's the
 > way to go.

I think drivers/clocksource/samsung_pwm_timer.c and
drivers/pwm/pwm-samsung.c provide another example for how to go about
this.

 > Step first is move axi timer driver from microblaze to generic location.

Yes. However, I don't have a microblaze setup, so I have just added the
PWM driver.

 > Figured it out how to add PWM (with DT flag) and then write support for it.

I would really like to see a standard way of doing this. Many timers
also have PWM support (e.g. samsung, and also DW). I think it's unusual
that this problem has not already been addressed.

--Sean

 >
 > Thanks,
 > Michal
 >
