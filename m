Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18AB2372C5A
	for <lists+linux-pwm@lfdr.de>; Tue,  4 May 2021 16:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbhEDOrn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 4 May 2021 10:47:43 -0400
Received: from mail-eopbgr30064.outbound.protection.outlook.com ([40.107.3.64]:9875
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230245AbhEDOrn (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 4 May 2021 10:47:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vuwfifr4EKIGo9a0T4BXq77jN08fI2tK1FJQg6Mk01U/x6PZ8SmLZuOGVwURtRhyy6il2zaqi8ucBI6k6JVjh0ceMxHzjC1eyJUZLeutg/mknrpyihCk2nnMWFiK/zHnkuufagRVIAFMGUYRzyjfiIwVcxMKCbSScCyTGFAGJQVCJcBlY7xgjMT+QEUIPnU4js5mNdfdh9YvhkrkyGZQanJ/S/Ehl7fgfrwXJgUgVKOsMPYoSmPZyKp00dNEzOR2KSYwkRQ3mBfVyQ7IlcTSrxxaV3/KB2AJLMHEBf9MsqvszMtRw6WP+mmOHdRURHOzf2vu1NsjAfUvpjtYdZXJ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z8rvr3nawuPx/jNVTNBpFZ0cE9qoEm5oWo2T7R4JyT4=;
 b=UMIqKqYtIefslhuvqfpcAiLSJCkRwLjvq3i90uY868ySDba8Dadgus4X3W0V5xumILLAB8DYMzPIi4Z60m+tXKcnzIwDpMB/j/oqCE9ZzYJtJhGRKLpEputChEn6y/Pku7RSR6jQkBSNW4lwkhhmQIXvbNJ/AtH6slj7h7SG2A90pSgRnDiHOcSuu5JpHO5glQISemuvncUi9HqagTNI3aL3SQaemtM3BUWz379r97opwdC232Fk+0QhbOp+9L2iHN1hHGNsGlkNBIY9rZfAXZJVBVktzy2wYuXY4f1Xg8DlOhng+FTkZ+e41000dede303ONoBxnXg343D7pKU1sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z8rvr3nawuPx/jNVTNBpFZ0cE9qoEm5oWo2T7R4JyT4=;
 b=mZh7eLPet35TTkzcPkqL78KfMufMZad9ZUjmEB0Ce9UosvrfUu3XTsECx7dq7vabqAge5JNc27Rj2QQAfZhTdCC1Ip8fbvECLebZ2bC1WomaJ4guh23t2g1QSydNWvSSzm6tUGau2KDE12RnUhvBAB48FYChqHFcaEDfpvEz/6E=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DBBPR03MB6700.eurprd03.prod.outlook.com (2603:10a6:10:20c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Tue, 4 May
 2021 14:46:45 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b%5]) with mapi id 15.20.4087.044; Tue, 4 May 2021
 14:46:45 +0000
Subject: Re: [PATCH 2/2] pwm: Add support for Xilinx AXI Timer
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        michal.simek@xilinx.com, Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
References: <20210503214413.3145015-1-sean.anderson@seco.com>
 <20210503214413.3145015-2-sean.anderson@seco.com>
 <20210504085112.edyy6loprfzejrjl@pengutronix.de>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <2ef7de6f-4d17-e81a-11bc-27eb382577a7@seco.com>
Date:   Tue, 4 May 2021 10:46:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210504085112.edyy6loprfzejrjl@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [50.195.82.171]
X-ClientProxiedBy: BL1PR13CA0270.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::35) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.1.65] (50.195.82.171) by BL1PR13CA0270.namprd13.prod.outlook.com (2603:10b6:208:2ba::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.8 via Frontend Transport; Tue, 4 May 2021 14:46:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: abbdc042-ad17-43bd-37c8-08d90f0b7033
X-MS-TrafficTypeDiagnostic: DBBPR03MB6700:
X-Microsoft-Antispam-PRVS: <DBBPR03MB6700F4B5CC7D0E95F7237CDE965A9@DBBPR03MB6700.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KQHny3YDAAc7qMlhki31aRkRkN3fxLR5oGk3mHXn8T8tHSRq8FjIpFP02ipt5xOG0KLHcesW/0FoHqEioRrhax+Z7XLuRyWB5oaGmO0WaUeEsn9jzMtA4wxoxsoBLXjm6iATMvHWPCJgwmpPI4njUKSM6DkkovyPJyzpHOW1EZcVz+iOTxtrunauGAhrap7Qd88PRZG9f3cd1SLAHi7fb7ylItBksupwukM5yHASK0byYEZW/YW9wBmHNcX/D0ggRBGyIYm2PkAcYn8FhSy9BS0AC81m2dsWu0Am5EjgVjlb2tbVOyAsr+ujJTcnhJl8nNAx1f45KBSPiQPXPIkCTlITpSffP2R7g1aVkTdDosi9ZZcr0OwKcnEegaGLhleH1lCZDLCQLaOL+7Djmo0syt7xfPUUZKihdAza2lGNni09b4cf7hxsVidWc4wcL2n716VJNOr+hAYwrF2XnkbnpnXypaxRGPza1uvxm1MBpR91FQ7PWD8bHqDPxHV8blC1tJ1JWp2xYzdg1lzcoBiAmBgnZScUKZzv1mjxyRs6kzPiol9MW+gWNv7p3OAJFCTUS8aHxT0CmcYJlT4dutTKnNhmEyGPURNXetpukE4E4QByeF0/04EsDXrqiPndr3L3w0w1pb6tW8CDnQO7LVV4jGGToRdc0UDzm8bkMm2mzNKXrh0+mNlM1p3JIPyXAs1yxMTapyqrzNr1z/0f2VTRSTNr1HvPr/Pky2EhqJLzV/JoYJhTAuJM8loMFcv5Aj1rV+dHLt34RAtT0aVXC7uk7AeLTvBJ8ENGV7r0Xyf94cs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(39840400004)(136003)(346002)(366004)(396003)(376002)(66574015)(966005)(53546011)(2616005)(6916009)(31686004)(26005)(6666004)(478600001)(16526019)(66556008)(4326008)(186003)(36756003)(66946007)(66476007)(6486002)(83380400001)(44832011)(54906003)(31696002)(38350700002)(8936002)(5660300002)(30864003)(2906002)(38100700002)(956004)(8676002)(86362001)(16576012)(316002)(52116002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?Windows-1252?Q?iJ2a/6hThV8sRiVMQndL2vTYbnqHFnA31Qmtz30ZHqVBJ/KFafNVMP9y?=
 =?Windows-1252?Q?PCwwuXiLl65lDE37M8nDxTml6FfXNN/X79nKeLsH7a8/fQcDAaRDbu6r?=
 =?Windows-1252?Q?4zhXk+ncoaNi+AiDl1gcDC9bQt8y8cdqlPhbnANh0LZF9l1lcXJ+xf5o?=
 =?Windows-1252?Q?aVxMG5BZ7GcCMV4HTStTlclrjQSUtAias3ObzUpJUOPKE1p0uYcYidOd?=
 =?Windows-1252?Q?qz0smQNWJGPBx14rCH6K4/xeFtwKmAkFTt8HmInYnXso49PRfVvGhl2u?=
 =?Windows-1252?Q?7FOSZEVageAJxHh4o3FGhW6B5xWjtkncitieYCUE16a8ZptJhh+asRSq?=
 =?Windows-1252?Q?MoXI/T0xrbkDdcNydMnBMtwsE5ZI4j+jkQzpcldbZev/+zKQVxGXMYmQ?=
 =?Windows-1252?Q?Gkp27NNJLYNEJq8xY+Rt5NtnC6Ftb2RWrTnUv1prOqOK5AOGlYKX+IE/?=
 =?Windows-1252?Q?3nH5rwzHx7AK/w+x4aj6/tVqd2ZismKlfYLWmiut+pFkTG4lzZ/osaA+?=
 =?Windows-1252?Q?kVkKTK0nVR5lzMGa3HnXVTs4w61eTNEqrwzPaXPYHCYGxIxhXy8KF6kd?=
 =?Windows-1252?Q?HUjmlGF2r/XcRKJlHR/Z8oFaNJsJ1wTElsX/62kSoo1zfoo64NTmkzdi?=
 =?Windows-1252?Q?Amwip+QCXDBEAcsGcPvB2KsKCTPDBDpgrJwwelIdHqV0c4l6NPrKCe5M?=
 =?Windows-1252?Q?y0blXW6U+TMChpvxNKu6zbN43pQ7jNuRuY+RRt1WfE7P/6cSW3qGJ5QX?=
 =?Windows-1252?Q?TnBYOUVcz+fnM4yX0d3GkJyi3NpEKyjs9M+E/tt0yQlJe/gb+Y6+iUQ4?=
 =?Windows-1252?Q?dvuElkjJG8NRi62leiDTAzcsgm7nBGUZr4YrjDtdF1nAsGC07RZutQ+h?=
 =?Windows-1252?Q?4xVg3YCXTFmeSEArTe4G3P1qN/l2xRXvtnIqd3qjfbZALUa8//e5d1Ot?=
 =?Windows-1252?Q?LwAAV0kmDEI9o9QS5loVrzRi2/5TEMNMOQZV3RFPu7pR8Ty/ErIRbNuY?=
 =?Windows-1252?Q?WbbcQQByWakFyYkPfik2+i6mU0f6KoFWM9XONHOSHxSFAiRfZXRQ3Mc3?=
 =?Windows-1252?Q?YxyMddg3DdeC/0YfPFzntbGYvpYV7PwbrRgYXUirXGdp4lr1P1K0zez8?=
 =?Windows-1252?Q?8oc/sU5y/ZRRSbkI9wxYhVnqvBY3N1kzMJK4Yt/eLyIhwCrFmwN4KVhT?=
 =?Windows-1252?Q?wICJ2P79L62hiAIetwLu3m5NoyG/moHYSmbV17FhZ0V7yveClOVQfsjJ?=
 =?Windows-1252?Q?3Tzg+r/wmxdsYh5bqThwbu+JWXeHmYMOKmnebd8DtzL0x6dDSxbq3Bo0?=
 =?Windows-1252?Q?T4UezXwLqnRhwayp+J8nlBviWvFu1Zb/Q1Zm//hu/Mhtxk1PS0MXbuc5?=
 =?Windows-1252?Q?7Y21nu/4QIa184LzBZvV0AeCakMslybl1Ni2Gc3nROkptG8qiuMcUpUH?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abbdc042-ad17-43bd-37c8-08d90f0b7033
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2021 14:46:45.2216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EJGNogdSq+RjCmaYuoLYw0Jb1kKxVMOo85nA5lnnybGOZ1+BgeS8yDQrnHb735vJOkyNjYm3c1eIyxQewb0vsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB6700
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 5/4/21 4:51 AM, Uwe Kleine-König wrote:
 > Hello,
 >
 > On Mon, May 03, 2021 at 05:44:13PM -0400, Sean Anderson wrote:
 >> This adds PWM support for Xilinx LogiCORE IP AXI soft timers commonly
 >> found on Xilinx FPGAs. There is another driver for this device located
 >> at arch/microblaze/kernel/timer.c, but it is only used for timekeeping.
 >> This driver was written with reference to Xilinx DS764 for v1.03.a [1].
 >>
 >> [1] https://www.xilinx.com/support/documentation/ip_documentation/axi_timer/v1_03_a/axi_timer_ds764.pdf
 >>
 >> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
 >> ---
 >>
 >>   arch/arm64/configs/defconfig |   1 +
 >>   drivers/pwm/Kconfig          |  11 ++
 >>   drivers/pwm/Makefile         |   1 +
 >>   drivers/pwm/pwm-xilinx.c     | 322 +++++++++++++++++++++++++++++++++++
 >>   4 files changed, 335 insertions(+)
 >>   create mode 100644 drivers/pwm/pwm-xilinx.c
 >>
 >> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
 >> index 08c6f769df9a..81794209f287 100644
 >> --- a/arch/arm64/configs/defconfig
 >> +++ b/arch/arm64/configs/defconfig
 >> @@ -1083,6 +1083,7 @@ CONFIG_PWM_SAMSUNG=y
 >>   CONFIG_PWM_SL28CPLD=m
 >>   CONFIG_PWM_SUN4I=m
 >>   CONFIG_PWM_TEGRA=m
 >> +CONFIG_PWM_XILINX=m
 >>   CONFIG_SL28CPLD_INTC=y
 >>   CONFIG_QCOM_PDC=y
 >>   CONFIG_RESET_IMX7=y
 >
 > I think this should go into a separate patch once this driver is
 > accepted. This can then go via the ARM people.

Sure.

 >
 >> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
 >> index d3371ac7b871..01e62928f4bf 100644
 >> --- a/drivers/pwm/Kconfig
 >> +++ b/drivers/pwm/Kconfig
 >> @@ -628,4 +628,15 @@ config PWM_VT8500
 >>   	  To compile this driver as a module, choose M here: the module
 >>   	  will be called pwm-vt8500.
 >>
 >> +config PWM_XILINX
 >> +	tristate "Xilinx AXI Timer PWM support"
 >> +	depends on !MICROBLAZE
 >
 > I don't understand this dependency.

As noted in the commit message, there is already a driver for this
device for microblaze systems. To prevent conflicts, this driver is
disabled on microblaze.

 >
 >> +	help
 >> +	  PWM framework driver for Xilinx LogiCORE IP AXI Timers. This
 >> +	  timer is typically a soft core which may be present in Xilinx
 >> +	  FPGAs. If you don't have this IP in your design, choose N.
 >> +
 >> +	  To compile this driver as a module, choose M here: the module
 >> +	  will be called pwm-xilinx.
 >> +
 >>   endif
 >> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
 >> index d3879619bd76..fc1bd6ccc9ed 100644
 >> --- a/drivers/pwm/Makefile
 >> +++ b/drivers/pwm/Makefile
 >> @@ -59,3 +59,4 @@ obj-$(CONFIG_PWM_TIEHRPWM)	+= pwm-tiehrpwm.o
 >>   obj-$(CONFIG_PWM_TWL)		+= pwm-twl.o
 >>   obj-$(CONFIG_PWM_TWL_LED)	+= pwm-twl-led.o
 >>   obj-$(CONFIG_PWM_VT8500)	+= pwm-vt8500.o
 >> +obj-$(CONFIG_PWM_XILINX)	+= pwm-xilinx.o
 >> diff --git a/drivers/pwm/pwm-xilinx.c b/drivers/pwm/pwm-xilinx.c
 >> new file mode 100644
 >> index 000000000000..240bd2993f97
 >> --- /dev/null
 >> +++ b/drivers/pwm/pwm-xilinx.c
 >> @@ -0,0 +1,322 @@
 >> +// SPDX-License-Identifier: GPL-2.0+
 >> +/*
 >> + * Copyright (C) 2021 Sean Anderson <sean.anderson@seco.com>
 >> + */
 >
 > Please add a link to a reference manual here (if available) and add a
 > paragraph about hardware properties: Does the hardware complete cycles
 > on reconfiguration or disable? Are there limitiation like "Cannot run
 > with 100% duty cycle"? Please look into e.g. pwm-sifive how this is done
 > and stick to the same format for easy grepping.

Ok, will add.

 >
 >> +#include <asm/io.h>
 >> +#include <linux/clk.h>
 >> +#include <linux/device.h>
 >> +#include <linux/debugfs.h>
 >> +#include <linux/module.h>
 >> +#include <linux/platform_device.h>
 >> +#include <linux/pwm.h>
 >> +
 >> +#define TCSR0	0x00
 >> +#define TLR0	0x04
 >> +#define TCR0	0x08
 >> +#define TCSR1	0x10
 >> +#define TLR1	0x14
 >> +#define TCR1	0x18
 >> +
 >> +#define TCSR_MDT	BIT(0)
 >> +#define TCSR_UDT	BIT(1)
 >> +#define TCSR_GENT	BIT(2)
 >> +#define TCSR_CAPT	BIT(3)
 >> +#define TCSR_ARHT	BIT(4)
 >> +#define TCSR_LOAD	BIT(5)
 >> +#define TCSR_ENIT	BIT(6)
 >> +#define TCSR_ENT	BIT(7)
 >> +#define TCSR_TINT	BIT(8)
 >> +#define TCSR_PWMA	BIT(9)
 >> +#define TCSR_ENALL	BIT(10)
 >> +#define TCSR_CASC	BIT(11)
 >
 > I'd like to see a prefix for these defines, something like XILINX_PWM_
 > maybe?

I don't think that's necessary, since these defines are used only for
this file. In particular, adding a prefix like that would significantly
lengthen lines which add several flags.

 >
 >> +/* Bits we need to set/clear to enable PWM mode, not including CASC */
 >> +#define TCSR_SET (TCSR_GENT | TCSR_ARHT | TCSR_ENT | TCSR_PWMA)
 >> +#define TCSR_CLEAR (TCSR_MDT | TCSR_LOAD)
 >
 > Maybe call this XILINX_PWM_TCSR_DEFAULT?
 >
 >> +#define NSEC_PER_SEC_ULL 1000000000ULL
 >> +
 >> +/**
 >> + * struct xilinx_pwm_device - Driver data for Xilinx AXI timer PWM driver
 >> + * @chip: PWM controller chip
 >> + * @clk: Parent clock
 >> + * @regs: Base address of this device
 >> + * @width: Width of the counters, in bits
 >> + */
 >> +struct xilinx_pwm_device {
 >> +	struct pwm_chip chip;
 >> +	struct clk *clk;
 >> +	void __iomem *regs;
 >> +	unsigned int width;
 >> +};
 >> +
 >> +static inline struct xilinx_pwm_device *xilinx_pwm_chip_to_device(struct pwm_chip *chip)
 >> +{
 >> +	return container_of(chip, struct xilinx_pwm_device, chip);
 >> +}
 >> +
 >> +static bool xilinx_pwm_is_enabled(u32 tcsr0, u32 tcsr1)
 >> +{
 >> +	return !(~tcsr0 & TCSR_SET || tcsr0 & (TCSR_CLEAR | TCSR_CASC) ||
 >> +		 ~tcsr1 & TCSR_SET || tcsr1 & TCSR_CLEAR);
 >> +}
 >> +
 >> +static u32 xilinx_pwm_calc_tlr(struct xilinx_pwm_device *pwm, u32 tcsr,
 >> +			       unsigned int period)
 >> +{
 >> +	u64 cycles = DIV_ROUND_DOWN_ULL(period * clk_get_rate(pwm->clk),
 >> +					NSEC_PER_SEC_ULL);
 >
 > NSEC_PER_SEC should work just fine here.

Ok.

 >
 >> +
 >> +	if (tcsr & TCSR_UDT)
 >> +		return cycles - 2;
 >
 > What happens if cycles <= 1?

Then we have a problem :)

I will add a check for this.

 >
 >> +	else
 >> +		return (BIT_ULL(pwm->width) - 1) - cycles + 2;
 >
 > What happens if cycles > BIT_ULL(pwm->width)?

ditto.

 >
 >> +}
 >> +
 >> +static unsigned int xilinx_pwm_get_period(struct xilinx_pwm_device *pwm,
 >> +					  u32 tlr, u32 tcsr)
 >> +{
 >> +	u64 cycles;
 >> +
 >> +	if (tcsr & TCSR_UDT)
 >> +		cycles = tlr + 2;
 >> +	else
 >> +		cycles = (BIT_ULL(pwm->width) - 1) - tlr + 2;
 >> +
 >> +	return DIV_ROUND_DOWN_ULL(cycles * NSEC_PER_SEC_ULL,
 >> +				  clk_get_rate(pwm->clk));
 >
 > Please round up here. The idea is that applying the result from
 > .get_state() should not modify the configuration. You might want to
 > enable PWM_DEBUG to test your driver.

Ok.

 >
 >> +}
 >> +
 >> +static int xilinx_pwm_apply(struct pwm_chip *chip, struct pwm_device *unused,
 >> +			    const struct pwm_state *state)
 >> +{
 >> +	struct xilinx_pwm_device *pwm = xilinx_pwm_chip_to_device(chip);
 >> +	u32 tlr0, tlr1;
 >> +	u32 tcsr0 = readl(pwm->regs + TCSR0);
 >> +	u32 tcsr1 = readl(pwm->regs + TCSR1);
 >> +	bool enabled = xilinx_pwm_is_enabled(tcsr0, tcsr1);
 >> +
 >> +	if (state->polarity != PWM_POLARITY_NORMAL)
 >> +		return -EINVAL;
 >> +
 >> +	if (!enabled && state->enabled)
 >> +		clk_rate_exclusive_get(pwm->clk);
 >
 > Missing error checking.

This cannot fail.

 >
 >> +
 >> +	tlr0 = xilinx_pwm_calc_tlr(pwm, tcsr0, state->period);
 >
 > Please care for overflowing. If state->period >= U64_MAX /
 > clk_get_rate(pwm->clk) the multiplication in xilinx_pwm_calc_tlr is
 > susceptible. Please do something like:
 >
 > 	... calculate maximal period ...
 >
 > 	if (state->period > max_period)
 > 		period = max_period
 > 	else
 > 		period = state->period;
 >
 > 	...
 >
 > The algorithm to implement is: Configure the biggest possible period not
 > bigger than state->period. With that period configure the biggest
 > duty_cycle not bigger than state->duty_cycle.
 >
 >> +	tlr1 = xilinx_pwm_calc_tlr(pwm, tcsr1, state->duty_cycle);
 >> +	writel(tlr0, pwm->regs + TLR0);
 >> +	writel(tlr1, pwm->regs + TLR1);
 >
 > How does the hardware behave here? E.g. can it happen that after writing
 > TLR0 we can see a cycle with the new period but the old duty_cycle? Does
 > it complete the currently running period?

TLR is the value loaded into TCR when the counter resets. I believe this
happens at the rising edge for TCR0 and at the falling edge for TCR1,
but the exact behavior is not documented. Therefore, changing the value
of TLR will not affect the current cycle.

 >
 > If state->enabled == 0 you want to disable first to prevent that the
 > (maybe) new values for period and duty_cycle are emitted by the
 > hardware.
 >
 >> +	if (state->enabled) {
 >> +		/* Only touch the TCSRs if we aren't already running */
 >> +		if (!enabled) {
 >> +			/* Load TLR into TCR */
 >> +			writel(tcsr0 | TCSR_LOAD, pwm->regs + TCSR0);
 >> +			writel(tcsr1 | TCSR_LOAD, pwm->regs + TCSR1);
 >> +			/* Enable timers all at once with ENALL */
 >> +			tcsr0 = (TCSR_SET & ~TCSR_ENT) | (tcsr0 & TCSR_UDT);
 >> +			tcsr1 = TCSR_SET | TCSR_ENALL | (tcsr1 & TCSR_UDT);
 >> +			writel(tcsr0, pwm->regs + TCSR0);
 >> +			writel(tcsr1, pwm->regs + TCSR1);
 >> +		}
 >> +	} else {
 >> +		writel(tcsr0 & ~TCSR_ENT, pwm->regs + TCSR0);
 >> +		writel(tcsr1 & ~TCSR_ENT, pwm->regs + TCSR1);
 >
 > How does the hardware behave on disable? Does it always emit a low
 > level? Does it complete the currently running period?

I don't know. My suspicion is that the output stops at whatever its
current value is.

 >
 >> +	}
 >> +
 >> +	if (enabled && !state->enabled)
 >> +		clk_rate_exclusive_put(pwm->clk);
 >> +
 >> +	return 0;
 >> +}
 >> +
 >> +static void xilinx_pwm_get_state(struct pwm_chip *chip,
 >> +				 struct pwm_device *unused,
 >> +				 struct pwm_state *state)
 >> +{
 >> +	struct xilinx_pwm_device *pwm = xilinx_pwm_chip_to_device(chip);
 >> +	u32 tlr0, tlr1, tcsr0, tcsr1;
 >> +
 >> +	tlr0 = readl(pwm->regs + TLR0);
 >> +	tlr1 = readl(pwm->regs + TLR1);
 >> +	tcsr0 = readl(pwm->regs + TCSR0);
 >> +	tcsr1 = readl(pwm->regs + TCSR1);
 >> +
 >> +	state->period = xilinx_pwm_get_period(pwm, tlr0, tcsr0);
 >> +	state->duty_cycle = xilinx_pwm_get_period(pwm, tlr1, tcsr1);
 >> +	state->enabled = xilinx_pwm_is_enabled(tcsr0, tcsr1);
 >> +	state->polarity = PWM_POLARITY_NORMAL;
 >> +}
 >> +
 >> +static const struct pwm_ops xilinx_pwm_ops = {
 >> +	.apply = xilinx_pwm_apply,
 >> +	.get_state = xilinx_pwm_get_state,
 >
 > .owner is missing

OK, will add.

 >
 >> +};
 >> +
 >> +static struct dentry *debug_dir;
 >> +
 >> +#define DEBUG_REG(reg) { .name = #reg, .offset = (reg), }
 >> +static struct debugfs_reg32 xilinx_pwm_reg32[] = {
 >> +	DEBUG_REG(TCSR0),
 >> +	DEBUG_REG(TLR0),
 >> +	DEBUG_REG(TCR0),
 >> +	DEBUG_REG(TCSR1),
 >> +	DEBUG_REG(TLR1),
 >> +	DEBUG_REG(TCR1),
 >> +};
 >> +
 >> +static int xilinx_pwm_debug_create(struct xilinx_pwm_device *pwm)
 >> +{
 >> +	struct debugfs_regset32 *regset;
 >> +
 >> +	if (!IS_ENABLED(CONFIG_DEBUG_FS))
 >> +		return 0;
 >> +
 >> +	regset = devm_kzalloc(pwm->chip.dev, sizeof(*regset), GFP_KERNEL);
 >> +	if (!pwm)
 >> +		return -ENOMEM;
 >> +
 >> +	regset->regs = xilinx_pwm_reg32;
 >> +	regset->nregs = ARRAY_SIZE(xilinx_pwm_reg32);
 >> +	regset->base = pwm->regs;
 >> +
 >> +	debugfs_create_regset32(dev_name(pwm->chip.dev), 0400, debug_dir,
 >> +				regset);
 >
 > debug_dir might not yet be initialized here.

Ok, I will move the initialization of the directory before registering
this driver in module init.

 >
 >> +	return 0;
 >> +}
 >
 > This is unusual to have in a driver. Something like memtool[1] should
 > work just fine, then you don't need this debugfs file. Together with pwm
 > tracing this should be good enough.

I didn't have memtool on my test system, so I added this. I can remove
it from the next patch if you'd like.

 >
 > [1] https://github.com/pengutronix/memtool
 >
 >> +static int xilinx_pwm_probe(struct platform_device *pdev)
 >> +{
 >> +	bool enabled;
 >> +	int i, ret;
 >> +	struct device *dev = &pdev->dev;
 >> +	struct xilinx_pwm_device *pwm;
 >> +	u32 one_timer;
 >> +
 >> +	ret = of_property_read_u32(dev->of_node, "xlnx,one-timer-only",
 >> +				   &one_timer);
 >> +	if (ret || one_timer) {
 >> +		dev_err(dev, "two timers are needed for PWM mode\n");
 >> +		return -EINVAL;
 >> +	}
 >> +
 >> +	for (i = 0; i < 2; i++) {
 >> +		char fmt[] = "xlnx,gen%u-assert";
 >> +		char buf[sizeof(fmt)];
 >> +		u32 gen;
 >> +
 >> +		snprintf(buf, sizeof(buf), fmt, i);
 >> +		ret = of_property_read_u32(dev->of_node, buf, &gen);
 >> +		if (ret || !gen) {
 >> +			dev_err(dev, "generateout%u must be active high\n", i);
 >> +			return -EINVAL;
 >> +		}
 >> +	}
 >> +
 >> +	pwm = devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
 >> +	if (!pwm)
 >> +		return -ENOMEM;
 >> +	platform_set_drvdata(pdev, pwm);
 >> +
 >> +	pwm->chip.dev = &pdev->dev;
 >> +	pwm->chip.ops = &xilinx_pwm_ops;
 >> +	pwm->chip.base = -1;
 >
 > Please drop the assignment to .base. See commit
 > f9a8ee8c8bcd118e800d88772c6457381db45224 in next.

Ok.

 >> +	pwm->chip.npwm = 1;
 >> +
 >> +	pwm->regs = devm_platform_ioremap_resource(pdev, 0);
 >> +	if (IS_ERR(pwm->regs))
 >> +		return PTR_ERR(pwm->regs);
 >> +
 >> +	ret = of_property_read_u32(dev->of_node, "xlnx,count-width", &pwm->width);
 >> +	if (ret) {
 >> +		dev_err(dev, "missing counter width\n");
 >> +		return -EINVAL;
 >> +	}
 >
 > Would it make sense to error out on some values of pwm->width? Values
 > bigger than 32 don't make sense?

Yes. I will add a range check next revision.

 >
 >> +	pwm->clk = devm_clk_get(dev, NULL);
 >> +	if (IS_ERR(pwm->clk))
 >> +		return dev_err_probe(dev, PTR_ERR(pwm->clk), "missing clock\n");
 >> +
 >> +	ret = clk_prepare_enable(pwm->clk);
 >> +	if (ret) {
 >> +		dev_err(dev, "clock enable failed\n");
 >> +		return ret;
 >
 > You can use dev_err_probe here, too, for consistency.

Ok. Though in this case we will never get -EPROBE_DEFER from
clk_prepare_enable, so dev_err_probe is not as useful.

 >
 >> +	}
 >> +
 >> +	ret = xilinx_pwm_debug_create(pwm);
 >> +	if (ret) {
 >> +		clk_disable_unprepare(pwm->clk);
 >> +		return ret;
 >> +	}
 >> +
 >> +	ret = pwmchip_add(&pwm->chip);
 >> +	if (ret) {
 >> +		clk_disable_unprepare(pwm->clk);
 >
 > Error message please.

Ok.

 >
 >> +		return ret;
 >> +	}
 >> +
 >> +	enabled = xilinx_pwm_is_enabled(readl(pwm->regs + TCSR0),
 >> +					readl(pwm->regs + TCSR1));
 >> +	if (enabled)
 >> +		clk_rate_exclusive_get(pwm->clk);
 >
 > This needs to happen before calling pwmchip_add(), doesn't it?

Yes.

 >
 >> +
 >> +	return ret;
 >> +}
 >> +
 >> +static int xilinx_pwm_remove(struct platform_device *pdev)
 >> +{
 >> +	struct xilinx_pwm_device *pwm = platform_get_drvdata(pdev);
 >> +	bool enabled = xilinx_pwm_is_enabled(readl(pwm->regs + TCSR0),
 >> +					     readl(pwm->regs + TCSR1));
 >> +
 >> +	if (enabled)
 >> +		clk_rate_exclusive_put(pwm->clk);
 >
 > This looks wrong. You should rely on the consumer that they disable the
 > PWM.

What about a PWM regulator with always-on?

This is mostly to match the exclusive_get in probe, in case there are
misbehaving consumers.

 >
 >> +	clk_disable_unprepare(pwm->clk);
 >
 > I assume this stops the PWM, so this must happen after calling
 > pwmchip_remove.

Ok.

 >
 >> +	return pwmchip_remove(&pwm->chip);
 >
 > Note, pwmchip_remove always returns 0 and I plan to change it to return
 > void instead. So please don't check the return value here.

Ok.

Thanks for the detailed review.

--Sean

 >
 >> +}
 >> +
 >
 > Best regards
 > Uwe
 >
