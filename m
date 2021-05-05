Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5E893734F8
	for <lists+linux-pwm@lfdr.de>; Wed,  5 May 2021 08:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbhEEGcH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 5 May 2021 02:32:07 -0400
Received: from mail-bn8nam08on2086.outbound.protection.outlook.com ([40.107.100.86]:46304
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229728AbhEEGcG (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 5 May 2021 02:32:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JnRb6MiwFFDF4Z5vh03AMGYerGsbbM1DEGgo5d81Ue/R5dnE5sk3yGe4kr/hVPL7T8FBTD04diiKKD6F5sicbgVbVKXa9SuwnOFZbhtn/dGTK/jsgDuaDjoRtxwe12Kyyo3bK/3EMVLl7ldIwmGozo2tTuHAYIuMQaoWVG1jV+xjv+bw8ruOl1oyy1knJ/puFJHOQEdWJBFA47tFLOurXr8dA18dlVa3aHNQ17btcnGeTjUOVHCqAZkPHKPHl2osZ0Iq9EW00ziVU18zs8hA715YE6tJD5Ca89LHeIQYfKEPXS8CLlphCbBPGzbBo3twLh9jyvt9GxIPzv/6NGzalQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QnhIXjaGHH0u/z3SB/Q3/qiSZdn3cNofgJhgwngFddw=;
 b=AMq3g4FPy5i0b+D1cFIePBRjV5++rg5XQCaV4aQJjMpLVqybd8D7rZhYuWeuizTomheWPBokLFTduSsLa+VoGtdvntp7UzBv7dGzCFqslV42fpg8eMS1NEGahjclo5Up+guSicYeJqO3ZinClKFiqjQKuRTom4sljPC/19CIBhQ0nGoXMiMJARlKOf2ILsjPm7Pt7a3EFzqo+/UAQPTgVZfefSvYut7JcCipPqKZSSRzAxn7Va/1Xh26Rg3Sm2xWRt9ObCr6GkuxsHXjHzIV2rn8FxGnlpdomWY8K7R2uWHg0CAY7YTk8pZWo1GZydbOl1RgEC12zeIU261vv+WHKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QnhIXjaGHH0u/z3SB/Q3/qiSZdn3cNofgJhgwngFddw=;
 b=sIQmwdpooOWycJibaHtLpsIL76Yo5BOXAmZCkz7ZTcaGSHkow0jt5nkBkf/la9CFab2L2xXsl40MXfynZIZsVOAWp1CVXmYg9eYPmhNvYuQcu63tPspBNtXTsVBY6uFpfbLKLhCL5XhP7R1AOwgI4/AQ+9cdXRBk8mw7CUxjKmU=
Received: from BN9PR03CA0984.namprd03.prod.outlook.com (2603:10b6:408:109::29)
 by DM5PR02MB3337.namprd02.prod.outlook.com (2603:10b6:4:65::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.44; Wed, 5 May
 2021 06:31:06 +0000
Received: from BN1NAM02FT035.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::13) by BN9PR03CA0984.outlook.office365.com
 (2603:10b6:408:109::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24 via Frontend
 Transport; Wed, 5 May 2021 06:31:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT035.mail.protection.outlook.com (10.13.2.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Wed, 5 May 2021 06:31:06 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 4 May 2021 23:31:04 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 4 May 2021 23:31:04 -0700
Envelope-to: thierry.reding@gmail.com,
 lee.jones@linaro.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-pwm@vger.kernel.org,
 robh@kernel.org,
 sean.anderson@seco.com,
 u.kleine-koenig@pengutronix.de
Received: from [172.30.17.109] (port=46014)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1leB3n-0007YU-V0; Tue, 04 May 2021 23:31:04 -0700
Subject: Re: [PATCH 2/2] pwm: Add support for Xilinx AXI Timer
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Sean Anderson <sean.anderson@seco.com>,
        Rob Herring <robh@kernel.org>
CC:     Michal Simek <michal.simek@xilinx.com>,
        <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
References: <20210503214413.3145015-1-sean.anderson@seco.com>
 <20210503214413.3145015-2-sean.anderson@seco.com>
 <20210504085112.edyy6loprfzejrjl@pengutronix.de>
 <dc6d9f40-a913-90c4-9675-0f84f789ab61@xilinx.com>
 <71694d6a-21d8-2b31-0e66-2dfea52a6390@seco.com>
 <20210504161334.tzylwyiz4k2tcztq@pengutronix.de>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <5e67c893-6261-bdfd-a51f-2c17f671294b@xilinx.com>
Date:   Wed, 5 May 2021 08:31:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210504161334.tzylwyiz4k2tcztq@pengutronix.de>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aeb15e7d-e313-4601-395f-08d90f8f5cea
X-MS-TrafficTypeDiagnostic: DM5PR02MB3337:
X-Microsoft-Antispam-PRVS: <DM5PR02MB3337C8686EF471A6B1F9A977C6599@DM5PR02MB3337.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lY9SJ9z5AKqWtVxD2HHA2EvII80zoXeb7URzDW/M2NE2gqdyD98FgLg5zj+XNWe5cLkbUO3tqCGkwa2aTYRslu5hE2qQ0NIwXLE1xEQxpFdXSuTT5j2zd1sp60KaDl2dve4G1t0QgusdBz1QaQ7x2on9aRhwKf16JS3FeoBgV8IL9aCL0UZsQ6sI9lIw0HBEpJ7usfvlUW0DcmoZI2s72Va9bu7xg8zviitTxXyosSqGwFNBemzSjmcR3xHhpAVZOiW99GIOqWGAiHzED4rNEBQCgPGYb3wykz1MZDISPflm1U5U/bV2pyJ4WPu7yqaazlu7Ge2mjW8Fdp0F6s51SgKkyxZMiCiR+8jjKZHLMy+1eWoHRX5L7Mh8OmH6XQ9Dg7OwWS0uPfd7lCeyxlDnztWU5jLPfz+/EF5wLB363LSHWZ42xrXgWtPUaAPifsGSgFO3yZLXAR32gli22jAGw0/RWsG4Zw2T2V4owBjsqp9vWoMratAaAbHWosGPUn0w/d5A3K4Xh034eUXCkbwkK/BWy5AGm92a9vjFfoxjAyj5KA7uImlnwPf4AXyy3oUNDsUDNR1l9xy+bFHyMvRuBAU2wm8fTxUDfZjuIqfLPerHWMPGp0FVZl2QjcKalzlmmojVRFYQ4uVHBEu4ObDZ4DrqW80vS/+ZhJCU4ey1FxD6wybQY3eqh3z/smBqi+KArpo3J8MIpLVn7ggLHuwSIkuT7l/bqu30460mas0B+0uCaZWA8bpCaEGuotGU/3WMqn3az0O++reUY5o+eZTo7wWZF4uhkEUe/uu7gn3R1ek=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(346002)(396003)(36840700001)(46966006)(82310400003)(36756003)(2906002)(478600001)(966005)(66574015)(36860700001)(47076005)(4326008)(5660300002)(6666004)(36906005)(70206006)(82740400003)(70586007)(9786002)(8676002)(44832011)(186003)(31696002)(26005)(54906003)(2616005)(83380400001)(7636003)(53546011)(110136005)(8936002)(316002)(336012)(31686004)(426003)(356005)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 06:31:06.1690
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aeb15e7d-e313-4601-395f-08d90f8f5cea
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT035.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3337
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On 5/4/21 6:13 PM, Uwe Kleine-König wrote:
> Hello Sean,
> 
> [Adding Rob to the list of recipents, as he for sure has a valuable
> opinion on this matter.]
> 
> On Tue, May 04, 2021 at 11:57:20AM -0400, Sean Anderson wrote:
>> On 5/4/21 8:32 AM, Michal Simek wrote:
>>> On 5/4/21 10:51 AM, Uwe Kleine-König wrote:
>>>> On Mon, May 03, 2021 at 05:44:13PM -0400, Sean Anderson wrote:
>>>>> This adds PWM support for Xilinx LogiCORE IP AXI soft timers commonly
>>>>> found on Xilinx FPGAs. There is another driver for this device located
>>>>> at arch/microblaze/kernel/timer.c, but it is only used for timekeeping.
>>>>> This driver was written with reference to Xilinx DS764 for v1.03.a [1].
>>>>>
>>>>> [1] https://www.xilinx.com/support/documentation/ip_documentation/axi_timer/v1_03_a/axi_timer_ds764.pdf
>>>>>
>>>>> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
>>>>> ---
>>>>>
>>>>>   arch/arm64/configs/defconfig |   1 +
>>>>>   drivers/pwm/Kconfig          |  11 ++
>>>>>   drivers/pwm/Makefile         |   1 +
>>>>>   drivers/pwm/pwm-xilinx.c     | 322 +++++++++++++++++++++++++++++++++++
>>>>>   4 files changed, 335 insertions(+)
>>>>>   create mode 100644 drivers/pwm/pwm-xilinx.c
>>>>>
>>>>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>>>>> index 08c6f769df9a..81794209f287 100644
>>>>> --- a/arch/arm64/configs/defconfig
>>>>> +++ b/arch/arm64/configs/defconfig
>>>>> @@ -1083,6 +1083,7 @@ CONFIG_PWM_SAMSUNG=y
>>>>>   CONFIG_PWM_SL28CPLD=m
>>>>>   CONFIG_PWM_SUN4I=m
>>>>>   CONFIG_PWM_TEGRA=m
>>>>> +CONFIG_PWM_XILINX=m
>>>>>   CONFIG_SL28CPLD_INTC=y
>>>>>   CONFIG_QCOM_PDC=y
>>>>>   CONFIG_RESET_IMX7=y
>>>>
>>>> I think this should go into a separate patch once this driver is
>>>> accepted. This can then go via the ARM people.
>>>>
>>>>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>>>>> index d3371ac7b871..01e62928f4bf 100644
>>>>> --- a/drivers/pwm/Kconfig
>>>>> +++ b/drivers/pwm/Kconfig
>>>>> @@ -628,4 +628,15 @@ config PWM_VT8500
>>>>>   	  To compile this driver as a module, choose M here: the module
>>>>>   	  will be called pwm-vt8500.
>>>>>
>>>>> +config PWM_XILINX
>>>>> +	tristate "Xilinx AXI Timer PWM support"
>>>>> +	depends on !MICROBLAZE
>>>>
>>>> I don't understand this dependency.
>>>
>>> The dependency is clear here because microblaze has already driver for
>>> this timer here arch/microblaze/kernel/timer.c.
> 
> Then at least add a comment.

I don't think that comment will really solve this. We should never
duplicate driver for the same IP to two locations.

Maybe this should be MFD driver.


> 
>>> And that's exactly pointing to the way how this should be done.
>>> IP itself is single or dual timer and in case of dual timer you can
>>> select if there is pwm output and use it for PWM generation.
>>>
>>> It means it is timer with PMW together.
>>> I didn't have a time but Uwe likely knows this better how to design it.
>>>
>>> I see that gpio-mvebu driver instantiate pwm driver. Maybe that's the
>>> way to go.
>>
>> I think drivers/clocksource/samsung_pwm_timer.c and
>> drivers/pwm/pwm-samsung.c provide another example for how to go about
>> this.
> 
> I recently had a similar problem (with code that isn't (yet) in
> mainline), where a timer can be used as a counter. I chose to change the
> compatible. Transferred to this example this would mean to use e.g.
> 
> 	static const struct of_device_id xilinx_pwm_of_match[] = {
> 		{ .compatible = "xlnx,xps-timer-pwm-1.00.a" },
> 		...
> 	};
> 
> and if you want to use the hardware as a PWM, you overwrite the
> compatible in your machine.dts.

It is HW selection inside that IP. It means you will get dt properly
when PWM output is selected. I understand that this shortcut can work
but I don't think it is proper design.


> Not sure however that this is nice enough to be accepted by the dt
> people?!

up to Rob.

Thanks,
Michal

