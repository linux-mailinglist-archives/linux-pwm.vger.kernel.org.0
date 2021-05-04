Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2437372F56
	for <lists+linux-pwm@lfdr.de>; Tue,  4 May 2021 20:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbhEDSCg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 4 May 2021 14:02:36 -0400
Received: from mail-vi1eur05on2041.outbound.protection.outlook.com ([40.107.21.41]:30433
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230285AbhEDSCf (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 4 May 2021 14:02:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IPvr1ECRkyWPDMrVBpUxFWNBUoYJZqOxGJtSBv8xqgJvrQ34BCaOEqy6pY717/m7FN/NDrg0uG+MT/FuRXc4TY78pg5msJpbaRPjZJyn54jCVoGHL/976X6I9Su8kdyCx5qAYK3rvmW1RYZ4aYf7ylxU3UuLH3Gyg13/At9rmUonE7TLFM+BjDe848AeagNmXfcFoZCEeddNrqt4XVUnoMAzpUCNw7OCoWuLk+5xOzzJ784FH/zCHpZNUyHAAyCmokCWX6Vpjnvw13naWiH8WYN3pbXSg7g1Sl49li0y3YGtw4P0ySgZv5KyHCOD7Sx8xi2JYD5DaXeoF6KBEXXYPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2UHCcTVAI6DnZoYknTy85QJWnwwR0uwh9WzlaaQ4R4E=;
 b=hXJP+1VuuDRMDjbMCLTJn4p/6fuVKZiiP/rVXVVjdwoYWtHjQrhQIivJV0rAlxtPVoAZDc7yG6Qp7RYg9P1dspvgnYnw2TxA0NgR+XoVeQBy2C51iStiacTT/07JX2GIQfFhKpKQOoa90onZSc5N0NHGiQlE9ARP/Ej56rEzCTmyWvmfQ4g59sZpCO0y5VSSzktkjsYc/73ujHSu9goex8YhHJ7Uk1TDr14DfR/6O1Yo7DDUXTl7Dn5SEm8LjVFVZUN2hhpmL8vcZV7MxkwG0Ywti4nDetesWF/G32gcuN97VN4c/2KL2H7ewL6yYpc3m9x+nETzEFoBQpgB1Ttu5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2UHCcTVAI6DnZoYknTy85QJWnwwR0uwh9WzlaaQ4R4E=;
 b=5I4N25LLW3GRIeDfP+mi+H7K+jVll6L7nnZz1dmc3wh0NorImgh4N0zhhC0Kt9d0DT8QfoOgBTTBPeWQTRLA6VM60YToQIFVrlvFBBJB8XQxHRPPlRQ/PfZa4PfbqlQUXrintb4P4yP5VQEIV3OdITS/LMGM8W9iygND5OnsWbk=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB3PR0302MB3193.eurprd03.prod.outlook.com (2603:10a6:8:8::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.40; Tue, 4 May
 2021 18:01:35 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b%5]) with mapi id 15.20.4087.044; Tue, 4 May 2021
 18:01:35 +0000
Subject: Re: [PATCH 2/2] pwm: Add support for Xilinx AXI Timer
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        michal.simek@xilinx.com, Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
References: <20210503214413.3145015-1-sean.anderson@seco.com>
 <20210503214413.3145015-2-sean.anderson@seco.com>
 <20210504085112.edyy6loprfzejrjl@pengutronix.de>
 <2ef7de6f-4d17-e81a-11bc-27eb382577a7@seco.com>
 <20210504171552.uccctqzbcffiqhu7@pengutronix.de>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <11d73039-030a-b6a3-fc9b-95ab00303d94@seco.com>
Date:   Tue, 4 May 2021 14:01:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210504171552.uccctqzbcffiqhu7@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [50.195.82.171]
X-ClientProxiedBy: MN2PR14CA0002.namprd14.prod.outlook.com
 (2603:10b6:208:23e::7) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.1.65] (50.195.82.171) by MN2PR14CA0002.namprd14.prod.outlook.com (2603:10b6:208:23e::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.39 via Frontend Transport; Tue, 4 May 2021 18:01:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7eaa1129-43f5-47dc-b3fe-08d90f26a84c
X-MS-TrafficTypeDiagnostic: DB3PR0302MB3193:
X-Microsoft-Antispam-PRVS: <DB3PR0302MB319373D2856C64BFF163F4FF965A9@DB3PR0302MB3193.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nJVhpmkAPzP1gaNTyGU+8Wo5z9OiApC++WQdb0LjIjDuBCYcWkPTvOghy+TH7F4afRB4a9ZoLkOdTDMLLWZwNyaC26DQR2ANzzRkmoqtSh4irMpddOdAjpg4Cm+ZpxXlvN7S3Ngf2kLp3tUNBXkz1uM15I7pfvGTBZJq7tAGrFmDaNeTq4gC54N8+7EvyLNTAus+MHi08+oYdpEcFDDajh/8RS2O+tuLl3fGAiP4PQLgCyMAViWXCWVvq9IfucoESyx3bun/G+iq+PXFOfAP+przdGY4Ma5ZLIBc8DAf3E8IT+jLmzAji2rVJ0uYbvm4co4O6cgSM6JSQXIXYMEAuvpuIZKqPIY8fPvhQmhF+ri0UqePohCvoWpzLrlFOO3FvtKcJaxSuBZHEobMDytFWXbW9GbpMu9ztYnWJOBqly5WJK5TwRgbaBZi+2iR8MZf5+NBvTjA52DLYFE5mH+81IZRAJ3Eb7ijWrRNVna+bkVFL528Xuir/XNIY+AZ2N4hh97lz6HU3SCmopHv1o4oi8f9PnkfcKOd5apohPbBR37n1wMP1JZyf0P+KjuLf8qD4ihLS66Q7cw+rfk2/OzvRBK+HM/1OQmduLi/Hp3Qw0kQBuBunlLf4pls2P4Nnjd3FQ62rLhIopNnXUBcPGC1bsuRzrbB1MIoQfjKOIJPSheeXyZW9oLDR77hAYuL4w6FmMGwBzuN0KI+R2tUAxNFYetaHt02JSZ4sfotSWC9AxK5niI8kjfeyMZubgT3Sb1xUztqnCJkjHFOYVoW5BVvr3CEFLyqplkGguQzIK3K+GU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39830400003)(376002)(346002)(136003)(396003)(86362001)(316002)(31696002)(2906002)(16576012)(52116002)(53546011)(54906003)(66574015)(38350700002)(66946007)(66476007)(478600001)(38100700002)(6486002)(83380400001)(31686004)(186003)(966005)(26005)(2616005)(16526019)(6916009)(30864003)(4326008)(8936002)(5660300002)(6666004)(36756003)(8676002)(956004)(44832011)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?Windows-1252?Q?HlSEzFBzdlWCSakOk9JxhZMgemrzGodCGgvrqNGuwA9KlSXXzjytL19A?=
 =?Windows-1252?Q?jKxEFuHydCvHeSgVKdHHlgJMJjWoX+2/v2U3BSHLueHIJ+L3Az9V1T2X?=
 =?Windows-1252?Q?r6Eg6O5bbGi1/8vA3S280AvucbP2oXLAFhjtsIbv+Q3lPoZZ2bt1KBDy?=
 =?Windows-1252?Q?CaNwutDpxB2bJTUrXeFk1rT5MhMdFMN3O6CkpN7LLI8Vzfh7Ek2K/GjO?=
 =?Windows-1252?Q?ftWUZm3U9m5n/mgNn9i2x//rqtWeCn0G/qGWQ+uHqjxodxJfFNYtU+51?=
 =?Windows-1252?Q?r5zDHwmsfBTg6RIxit+R8RUMk1fsNJutTO6sLidlh1+SnAOUGEHMHgU8?=
 =?Windows-1252?Q?ooWj/NFnh+ZH8DRhrJwvXfObVHRdPi4tCL3mqvytclwozwAp+vMQJcAE?=
 =?Windows-1252?Q?GEcGspuKdkfXB+Z3zl2j3tYhXmzc8E83HBHE9hUwQ9+51Xb6kyGGk4+U?=
 =?Windows-1252?Q?Lz7jopbZk173bta8k9/1QXH2vrCCe48fQdPhenxqO5mBvkG2+SC4g5la?=
 =?Windows-1252?Q?rftjUOMXmAxPAUx8niVh8SNTex5YuqT/zl28GU3s0O3Gn8tPWTMo6UXz?=
 =?Windows-1252?Q?CswiWFwaXriFYEnnwrNJwAsaT8P5P9o8jsm0ixQ0rfEl4zVn+G4Uf+Jz?=
 =?Windows-1252?Q?Mlao9qtiTTdSMwILF6rhjhgPrDoBhGtVy4+BwaQH6seNMDH0kdu856xA?=
 =?Windows-1252?Q?nLx8LqZsoJzhhUzJD1asYOFdKDXi8V3BthWwsV2nCrKnkvqaRn6yh5DT?=
 =?Windows-1252?Q?Hlt2aGM/UkTsPeX368hsQrVLBoaD8ZOYlQDRaL69hQVk5VtOknEo63Sl?=
 =?Windows-1252?Q?HX/OWa9E6iGaSBzrnGPCD8igducctXAY1OEMr9+p25m9CBf1sv9pB5AI?=
 =?Windows-1252?Q?L2FibaAy0apR1wfXC1AjMOg/xCPjTkB1yKuKHVd/0pLpD1/5h8WOdZHj?=
 =?Windows-1252?Q?uzFm1CDeH3sQpab9Zb34dKaSno3KACTmKLohhWuD7isDHybv66De7bOM?=
 =?Windows-1252?Q?H6bUo9SljPbjY37xOtEPCV1pPniMU/YtLhgrqq2vNPwFCN4ebv9GnKHz?=
 =?Windows-1252?Q?VxCVtLQR4cfWSu/FfKz+PkYH6omkO4C8QKbeu0k4TsMSIRU6w5kmHs8t?=
 =?Windows-1252?Q?OqeflOZF6C592GRg02t7k8HqU4s3GDSwBzo6vj6yGrnGOJSxB2v1g/UK?=
 =?Windows-1252?Q?zgQUR7sKTdhWmMzYKxR8Ap/pngomhyTtTGcLTWF/+t8ph+nOfYQNwBb8?=
 =?Windows-1252?Q?p88iU5Z21HlHSCI7vU992rnNfuPkvAaCqkVsyK3FEfK4l4Uw1QZRV7QB?=
 =?Windows-1252?Q?HNm2PDFGzphk5Nz/aHL/mzmB/9PRJDLWz5VzV2spjYiWKGDALgfksVdr?=
 =?Windows-1252?Q?BVmg5eZZyfj7xaHjQVwzuIBvHygzAyLglEp3UDO1zfESya0LwW5qgppZ?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eaa1129-43f5-47dc-b3fe-08d90f26a84c
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2021 18:01:35.8317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: be4vPPOWHBnUFa4XnyJ1eSflBDZXOAzdzNmOr04+32fwmV3iRGxzE0zSNdxionaqbXmUgiR5+oclZ0mVvOfPTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0302MB3193
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 5/4/21 1:15 PM, Uwe Kleine-König wrote:
 > Hello Sean,
 >
 > On Tue, May 04, 2021 at 10:46:39AM -0400, Sean Anderson wrote:
 >> On 5/4/21 4:51 AM, Uwe Kleine-König wrote:
 >>> On Mon, May 03, 2021 at 05:44:13PM -0400, Sean Anderson wrote:
 >>>> This adds PWM support for Xilinx LogiCORE IP AXI soft timers commonly
 >>>> found on Xilinx FPGAs. There is another driver for this device located
 >>>> at arch/microblaze/kernel/timer.c, but it is only used for timekeeping.
 >>>> This driver was written with reference to Xilinx DS764 for v1.03.a [1].
 >>>>
 >>>> [1] https://www.xilinx.com/support/documentation/ip_documentation/axi_timer/v1_03_a/axi_timer_ds764.pdf
 >>>>
 >>>> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
 >>>> ---
 >>>>
 >>>>    arch/arm64/configs/defconfig |   1 +
 >>>>    drivers/pwm/Kconfig          |  11 ++
 >>>>    drivers/pwm/Makefile         |   1 +
 >>>>    drivers/pwm/pwm-xilinx.c     | 322 +++++++++++++++++++++++++++++++++++
 >>>>    4 files changed, 335 insertions(+)
 >>>>    create mode 100644 drivers/pwm/pwm-xilinx.c
 >>>>
 >>>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
 >>>> index 08c6f769df9a..81794209f287 100644
 >>>> --- a/arch/arm64/configs/defconfig
 >>>> +++ b/arch/arm64/configs/defconfig
 >>>> @@ -1083,6 +1083,7 @@ CONFIG_PWM_SAMSUNG=y
 >>>>    CONFIG_PWM_SL28CPLD=m
 >>>>    CONFIG_PWM_SUN4I=m
 >>>>    CONFIG_PWM_TEGRA=m
 >>>> +CONFIG_PWM_XILINX=m
 >>>>    CONFIG_SL28CPLD_INTC=y
 >>>>    CONFIG_QCOM_PDC=y
 >>>>    CONFIG_RESET_IMX7=y
 >>>
 >>> I think this should go into a separate patch once this driver is
 >>> accepted. This can then go via the ARM people.
 >>
 >> Sure.
 >>
 >>>
 >>>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
 >>>> index d3371ac7b871..01e62928f4bf 100644
 >>>> --- a/drivers/pwm/Kconfig
 >>>> +++ b/drivers/pwm/Kconfig
 >>>> @@ -628,4 +628,15 @@ config PWM_VT8500
 >>>>    	  To compile this driver as a module, choose M here: the module
 >>>>    	  will be called pwm-vt8500.
 >>>>
 >>>> +config PWM_XILINX
 >>>> +	tristate "Xilinx AXI Timer PWM support"
 >>>> +	depends on !MICROBLAZE
 >>>
 >>> I don't understand this dependency.
 >>
 >> As noted in the commit message, there is already a driver for this
 >> device for microblaze systems. To prevent conflicts, this driver is
 >> disabled on microblaze.
 >
 > OK, already understood that after reading the other replies to this
 > thread. As noted there, please add a comment describing the problem.

Added.

 > You probably also need some more dependencies, at least COMMON_CLK for
 > clk_rate_exclusive_get() and probably also HAS_IOMEM for readl/writel.

I will add a dependency on HAS_IOMEM. COMMON_CLK should not be
necessary, because clk_exclusive_(get|put) should be defined by the
platform if they define CONFIG_HAVE_CLK (otherwise we get a stub as
define in the linux clock header). But of course, this is not the case
on SH4... I wish this sort of thing were documented somewhere. I can add
this if necessary.

 >
 >>>> +#include <asm/io.h>
 >>>> +#include <linux/clk.h>
 >>>> +#include <linux/device.h>
 >>>> +#include <linux/debugfs.h>
 >>>> +#include <linux/module.h>
 >>>> +#include <linux/platform_device.h>
 >>>> +#include <linux/pwm.h>
 >>>> +
 >>>> +#define TCSR0	0x00
 >>>> +#define TLR0	0x04
 >>>> +#define TCR0	0x08
 >>>> +#define TCSR1	0x10
 >>>> +#define TLR1	0x14
 >>>> +#define TCR1	0x18
 >>>> +
 >>>> +#define TCSR_MDT	BIT(0)
 >>>> +#define TCSR_UDT	BIT(1)
 >>>> +#define TCSR_GENT	BIT(2)
 >>>> +#define TCSR_CAPT	BIT(3)
 >>>> +#define TCSR_ARHT	BIT(4)
 >>>> +#define TCSR_LOAD	BIT(5)
 >>>> +#define TCSR_ENIT	BIT(6)
 >>>> +#define TCSR_ENT	BIT(7)
 >>>> +#define TCSR_TINT	BIT(8)
 >>>> +#define TCSR_PWMA	BIT(9)
 >>>> +#define TCSR_ENALL	BIT(10)
 >>>> +#define TCSR_CASC	BIT(11)
 >>>
 >>> I'd like to see a prefix for these defines, something like XILINX_PWM_
 >>> maybe?
 >>
 >> I don't think that's necessary, since these defines are used only for
 >> this file. In particular, adding a prefix like that would significantly
 >> lengthen lines which add several flags.
 >
 > This is something where Thierry and I don't agree, so you can at least
 > expect support for your point. Still I see a value that is usually worth
 > the additional horizontal space.
 >
 > The prefix would make it obvious that this is a local symbol. It also
 > helps to jump to the right definition if you use ctags or something
 > similar.
 >
 > The most affected code lines are probably:
 >
 > +	return !(~tcsr0 & TCSR_SET || tcsr0 & (TCSR_CLEAR | TCSR_CASC) ||
 > +		 ~tcsr1 & TCSR_SET || tcsr1 & TCSR_CLEAR);
 >
 > which IMHO is already hard to read and adding a newline after each ||
 > doesn't hurt.

This is done intentionally to highlight that we are doing the same
checks for TCSR0 and TCSR1.

 >
 > Or write it as:
 >
 > 	#define XILINX_PWM_TCSR_RUN_SET			\
 > 			(XILINX_PWM_TCSR_GENT |		\
 > 			 XILINX_PWM_TCSR_ARHT |		\
 > 			 XILINX_PWM_TCSR_ENT |		\
 > 			 XILINX_PWM_TCSR_PWMA)
 >
 > 	#define XILINX_PWM_TCSR_RUN_CLEAR		\
 > 			 (XILINX_PWM_TCSR_MDT | \
 > 			 XILINX_PWM_TCSR_LOAD)
 >
 > 	#define XILINX_PWM_TCSR_RUN_MASK		\
 > 			(XILINX_PWM_TCSR_RUN_SET | XILINX_PWM_TCSR_RUN_CLEAR)
 >
 >
 > 	...
 >
 > 	/*
 > 	 * Both TCSR registers must be setup according to the running
 > 	 * value, TCSR0 must also have the CASC bit set.
 > 	 */
 > 	if ((tcsr0 & XILINX_PWM_TCSR_RUN_MASK) != XILINX_PWM_TCSR_RUN_SET ||
 > 	    !(tcsr0 & TCSR_CASC) ||
 > 	    (tcsr1 & XILINX_PWM_TCSR_RUN_MASK) != XILINX_PWM_TCSR_RUN_SET)
 >
 > which IMHO is better understandable and still fits the line length.
 > (Or simplify the check to only test for a single bit?)
 >
 > +			tcsr0 = (TCSR_SET & ~TCSR_ENT) | (tcsr0 & TCSR_UDT);
 > +			tcsr1 = TCSR_SET | TCSR_ENALL | (tcsr1 & TCSR_UDT);
 >
 > is similar. I wonder if it makes sense to drop ENT from the default bit
 > mask and if after that xilinx_pwm_is_enabled() yields true.

The idea here is to capture whether the PWM is actually running (e.g.
because we or the bootloader set it up) and we need to be careful to
ensure we don't cause a glitch. According to the device data sheet, to
enable the PWM we need to

* Set both timers to generate mode (MDT=1)
* Set both timers to PWM mode (PWMA=1)
* Enable the generate out signals (GENT=1)

In addition,

* The timer must be running (ENT=1)
* The timer must auto-reload TLR into TCR (ARHT=1)
* We must not be in the process of loading TLR into TCR (LOAD=0)
* Cascade mode must be disabled (CASC=0)

If any of these differ from usual, then the PWM is either disabled, or
is running in a mode that this driver does not support.

 > I also don't understand the semantic of the UDT bit. You never modify
 > it. Assuming it has a relevant meaning the driver's behaviour depends
 > on the value the bootloader initialized that bit to?

UDT is whether the timer counts upward or downward. We keep whatever
the bootloader (or the power-on reset) set so we don't cause an
incorrect pulse between when we write TLR and when we write TCSR.

 >
 > So these lines might need some explanation anyhow and having to write it
 > over several lines doesn't actually hurt.
 >
 > 	bool enabled = xilinx_pwm_is_enabled(readl(pwm->regs + TCSR0),
 > 					     readl(pwm->regs + TCSR1));
 >
 > could be rewritten as
 >
 > 	u32 tcsr0 = readl(pwm->regs + XILINX_PWM_TCSR0);
 > 	u32 tcsr1 = readl(pwm->regs + XILINX_PWM_TCSR1);
 > 	bool enabled = xilinx_pwm_is_enabled(tcsr0, tcsr1);
 >
 > which IMHO reads better and the required horizontal space is even less
 > than with your lines even tough I have added a prefix.
 >
 >>>> +static int xilinx_pwm_apply(struct pwm_chip *chip, struct pwm_device *unused,
 >>>> +			    const struct pwm_state *state)
 >>>> +{
 >>>> +	struct xilinx_pwm_device *pwm = xilinx_pwm_chip_to_device(chip);
 >>>> +	u32 tlr0, tlr1;
 >>>> +	u32 tcsr0 = readl(pwm->regs + TCSR0);
 >>>> +	u32 tcsr1 = readl(pwm->regs + TCSR1);
 >>>> +	bool enabled = xilinx_pwm_is_enabled(tcsr0, tcsr1);
 >>>> +
 >>>> +	if (state->polarity != PWM_POLARITY_NORMAL)
 >>>> +		return -EINVAL;
 >>>> +
 >>>> +	if (!enabled && state->enabled)
 >>>> +		clk_rate_exclusive_get(pwm->clk);
 >>>
 >>> Missing error checking.
 >>
 >> This cannot fail.
 >
 > Oh indeed. IMHO it should be changed to return void and the comment
 > "Returns 0 on success, -EERROR otherwise" should be adapted to reality.
 >
 >>>> +	tlr1 = xilinx_pwm_calc_tlr(pwm, tcsr1, state->duty_cycle);
 >>>> +	writel(tlr0, pwm->regs + TLR0);
 >>>> +	writel(tlr1, pwm->regs + TLR1);
 >>>
 >>> How does the hardware behave here? E.g. can it happen that after writing
 >>> TLR0 we can see a cycle with the new period but the old duty_cycle? Does
 >>> it complete the currently running period?
 >>
 >> TLR is the value loaded into TCR when the counter resets. I believe this
 >> happens at the rising edge for TCR0 and at the falling edge for TCR1,
 >> but the exact behavior is not documented. Therefore, changing the value
 >> of TLR will not affect the current cycle.
 >
 > So we might still get a mixed period if the counter resets between the
 > two writel commands, right?

Yes. I have noted this in V2.

 >>> If state->enabled == 0 you want to disable first to prevent that the
 >>> (maybe) new values for period and duty_cycle are emitted by the
 >>> hardware.
 >>>
 >>>> +	if (state->enabled) {
 >>>> +		/* Only touch the TCSRs if we aren't already running */
 >>>> +		if (!enabled) {
 >>>> +			/* Load TLR into TCR */
 >>>> +			writel(tcsr0 | TCSR_LOAD, pwm->regs + TCSR0);
 >>>> +			writel(tcsr1 | TCSR_LOAD, pwm->regs + TCSR1);
 >>>> +			/* Enable timers all at once with ENALL */
 >>>> +			tcsr0 = (TCSR_SET & ~TCSR_ENT) | (tcsr0 & TCSR_UDT);
 >>>> +			tcsr1 = TCSR_SET | TCSR_ENALL | (tcsr1 & TCSR_UDT);
 >>>> +			writel(tcsr0, pwm->regs + TCSR0);
 >>>> +			writel(tcsr1, pwm->regs + TCSR1);
 >>>> +		}
 >>>> +	} else {
 >>>> +		writel(tcsr0 & ~TCSR_ENT, pwm->regs + TCSR0);
 >>>> +		writel(tcsr1 & ~TCSR_ENT, pwm->regs + TCSR1);
 >>>
 >>> How does the hardware behave on disable? Does it always emit a low
 >>> level? Does it complete the currently running period?
 >>
 >> I don't know. My suspicion is that the output stops at whatever its
 >> current value is.
 >
 > Would be great if you could find out that. Please document that in the
 > Limitations paragraph at the top of the driver.

Well, as it turns out, just clearing ENT doesn't disable the PWM output
(!). However, clearing everything in TCSR_SET does disable the PWM. The
output is low when it is disabled.

 >>> This is unusual to have in a driver. Something like memtool[1] should
 >>> work just fine, then you don't need this debugfs file. Together with pwm
 >>> tracing this should be good enough.
 >>
 >> I didn't have memtool on my test system, so I added this. I can remove
 >> it from the next patch if you'd like.
 >
 > Yes, please remove it. (And install memtool or one of its alternatives
 > :-).

I'll be sad to see it go. It is very convenient for debugging.

 >>>> +	pwm->clk = devm_clk_get(dev, NULL);
 >>>> +	if (IS_ERR(pwm->clk))
 >>>> +		return dev_err_probe(dev, PTR_ERR(pwm->clk), "missing clock\n");
 >>>> +
 >>>> +	ret = clk_prepare_enable(pwm->clk);
 >>>> +	if (ret) {
 >>>> +		dev_err(dev, "clock enable failed\n");
 >>>> +		return ret;
 >>>
 >>> You can use dev_err_probe here, too, for consistency.
 >>
 >> Ok. Though in this case we will never get -EPROBE_DEFER from
 >> clk_prepare_enable, so dev_err_probe is not as useful.
 >
 > Everything it does here is useful, and the overhead is only the check
 > against -EPROBE_DEFER. In return you get consistent error handling and
 > the messages are also all in the same format. (And compared to your
 > version the error message also gives a hint about the actual problem as
 > it emits the error code.)

Shouldn't the error return be printed by whoever called this probe?

 >>>> +static int xilinx_pwm_remove(struct platform_device *pdev)
 >>>> +{
 >>>> +	struct xilinx_pwm_device *pwm = platform_get_drvdata(pdev);
 >>>> +	bool enabled = xilinx_pwm_is_enabled(readl(pwm->regs + TCSR0),
 >>>> +					     readl(pwm->regs + TCSR1));
 >>>> +
 >>>> +	if (enabled)
 >>>> +		clk_rate_exclusive_put(pwm->clk);
 >
 > Note that I misunderstood what clk_rate_exclusive_put does. This only
 > drops the lock on the clock that prevents that others modify the clock
 > rate. So that call is fine.
 >
 >>> This looks wrong. You should rely on the consumer that they disable the
 >>> PWM.
 >>
 >> What about a PWM regulator with always-on?
 >
 > So in general: What do you think should happen? When the remove function
 > is called the PWM regulator driver is already gone, so there is no way
 > to get the information that the PWM should stay on ...

Well, we can still tell whether the PWM is on or off. If it should turn
off, then someone should have disabled it.

 >>>> +	clk_disable_unprepare(pwm->clk);
 >
 > ... and still you stop the PWM here (or does that only affect access to
 > its registers?)

This will turn off the PWM if we are the last user of this clock and no
one else has set e.g. CLK_IS_CRITICAL (which is what I would expect if
this powered a critical regulator).

--Sean

 >
 > So it's a delicate topic and there isn't the single right thing to do
 > here. So usually I request to free all resources allocated in .probe()
 > and otherwise leave the hardware alone. Now that I understood
 > clk_rate_exclusive_put() the status quo is fine for me. Just call
 > pwmchip_remove first and only then release the resources needed to
 > operate the PWM.
 >
 > Best regards
 > Uwe
 >
