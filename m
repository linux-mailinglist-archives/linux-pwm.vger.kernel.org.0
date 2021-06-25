Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDD5D3B466B
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Jun 2021 17:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbhFYPQC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 25 Jun 2021 11:16:02 -0400
Received: from mail-eopbgr50069.outbound.protection.outlook.com ([40.107.5.69]:49070
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229445AbhFYPQC (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 25 Jun 2021 11:16:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GafD51jxDshj6BBzNiFtSEvWBxRgjyjzdM/sZYmUVD/MgNYgeyMX6vu4Squxv9RN15ZnBR5D3GoDMaQLH5cX8c3Cr4KvjeI98W7feKOpAa0vducAAKYNuxtWFivH1gJUt8IV4GYYi0kPqX2Sd8gDFT1ulneSRHW3zM9cjcFsJFp0jco11Es6bM7FP6sqsjMR38QKcF48CL3YPmPlLeatGNKjeTnckt4QAx5Il8QO2lww4MFkFbhvE8Sfidckt3uzKVDCBO+TxKXxq9m0fsg2PVZo9ST3wysW/ZA+xd0WrwhBpm09eX7mH/2jl0hhuR3xq1ui4mmuBFENtBQTOsGJjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qkrqnR2lLecpG2iCeFjBPS3aNfqfHOvEkxTektoYTUA=;
 b=a/bYSWWgzDj9nPaAmK6y8ZU6EYcftsLR0Hq4/WEduAfSiewc2bZqIBYrV4IArnlQXsav1911faMRN34v1fTNJXMeyv/mcKyPGiifBhZ73kzbzw/gHxAtZQvCoPZQVnSmMIktCKHEhZg7p45LBPx8gooXi+xSXL8SsLI7MgEN/d6Il7mKkqTN8DwK4cs2q046w00T7WQvzWaizBu9s2KyTwhBi3mvkGWX8jNvwu/pykPnm8bjAFOWutbiWtE6/g//A3/ZcxJY2n/sjvVtJsK5057X0c5DTVD1oTND+C/BXU93M7yYjQOwj7BlGTzaBwI+f2qVaElLh7wtzYUWmPauvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qkrqnR2lLecpG2iCeFjBPS3aNfqfHOvEkxTektoYTUA=;
 b=xf+aIBf3V6rUoXMm/FrL7f0LET2xgD0HSgB+c5rdgP4nhz1J+4KuUYQ5ZPygZHazhhCqPyodxJttDICwlqG++TqjEWQ7LcSO7ayi5LOIF+x4IhgiJW9nrjNjsew45zE+0GFat+zPsaPtElIRtMswU0UFtJ2gEuHzjXdwG8OK6fw=
Authentication-Results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB6PR0301MB2440.eurprd03.prod.outlook.com (2603:10a6:4:58::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Fri, 25 Jun
 2021 15:13:37 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b%5]) with mapi id 15.20.4264.020; Fri, 25 Jun 2021
 15:13:37 +0000
Subject: Re: [PATCH v4 3/3] pwm: Add support for Xilinx AXI Timer
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        michal.simek@xilinx.com, linux-kernel@vger.kernel.org,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        linux-arm-kernel@lists.infradead.org,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de
References: <20210528214522.617435-1-sean.anderson@seco.com>
 <20210528214522.617435-3-sean.anderson@seco.com>
 <20210625061958.yeaxjltuq7q2t7i7@pengutronix.de>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <a748143d-f157-562e-795d-dcd9a0cf9d85@seco.com>
Date:   Fri, 25 Jun 2021 11:13:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210625061958.yeaxjltuq7q2t7i7@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [50.195.82.171]
X-ClientProxiedBy: MN2PR07CA0030.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::40) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.1.65] (50.195.82.171) by MN2PR07CA0030.namprd07.prod.outlook.com (2603:10b6:208:1a0::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend Transport; Fri, 25 Jun 2021 15:13:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95a4c5dd-7e6f-4f27-b12d-08d937ebcee2
X-MS-TrafficTypeDiagnostic: DB6PR0301MB2440:
X-Microsoft-Antispam-PRVS: <DB6PR0301MB244060BAD5938B9153B6DDCA96069@DB6PR0301MB2440.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZDZxMeyBKsVRj9uu5p10HfL6fEk06oOHxEwMN1oAGFJLJGw/CAi+4NMsNmH1Fp+Wgdx+/t/v9A20hXkJXOKHQ6K4CdmbKrVsV02EaEDCgrylyvzQ47HLW4dSSINZWzZmWtm2fX4TToB0bL3jWhmM3SLx9LCESH4PB4H7vo/dZb/T9gEhv44dz09kRS/kytCeADt97xtJ6PPBXzLN2X5mihORjsZTixyrofYOC8S9zERYLenfW/GazvEm886x33urCda/krlWoJ3k2JeibL4NiiKyJZgFdLPugXjL5k8QxeKyyxIDHZcpbd29tBExi4Xbvf2FWojbyNg31MRPaCn7jVFKdARq3RXfpc3epPM+RepFFwgn5E+At67HwALPR3APDJFCBwDTBE6Isy0zz35DHWW1nqD/YZU3r5R4CNPkvDhX1pu22xXmKtnloxy+HHtPAFBR01mCVg+zqgobXIygP1vWsO/lK6VNooZcIqSQd9BnahTShdLS8pDzajJ5LCebhCVmvYT5AkQslkBF+hvU9AJj/9RpIKrnEaE2SY3Vo04p8V4arepx9v6epUZLgXkPOiEk4QlGIaCq88UOZpwaiTZbbcF0qR9nFYJNwC7c3HNVaSWWRAXpmaLXAOkJPZvROvk2mpLh3QRp7DRIDIx0JK47DiopjjGKIUtm0VmAE+sHjKlNv2533G2j26t/6l8UwApnZKJu252phXN3PnZPPJz5qZ0Ydptt0JTZA2ZV/0tlMN27Xv/SdjWzj03hweO4zhL06nKXn7ga9fQNP9dUEGt7n90XVrOgPrHq1AdCSSgqKJwEAsZFc+ewZrNurpt1j4x4JpOB0Ab2kajrPwuGpuKmI25bVN07oc8oR8b2oGg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(376002)(366004)(396003)(39840400004)(86362001)(4326008)(316002)(52116002)(966005)(54906003)(186003)(30864003)(2616005)(16576012)(6916009)(16526019)(66946007)(26005)(36756003)(66556008)(6666004)(53546011)(478600001)(956004)(8936002)(5660300002)(38350700002)(8676002)(2906002)(31696002)(38100700002)(66476007)(31686004)(83380400001)(6486002)(66574015)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?Windows-1252?Q?67rtv9q/WdYdT55lT3U7MJIwWxHUgQRgxcqhIGqvEeuV6jv4DSMGUYv5?=
 =?Windows-1252?Q?PDdUdA6iYvyg3zLs1enPgqp+WFPEJSrXreVbDr0Uqgr3M52npLQCzvwY?=
 =?Windows-1252?Q?b4kC6ElNAK92t8w+/4qienCURoPYBTXVcFzHyQLvHnWV+7ClZxxAzHs2?=
 =?Windows-1252?Q?WkAxbmTjfz01OkuWK/33g526fUaXVxXtZe0lBYU1VeXnNqyYtP1XMuLn?=
 =?Windows-1252?Q?PJ7K0L/9ljJCsHxnCGDH2utGaCmcI7egdQuXty26kCHecNkkOGE+Pzna?=
 =?Windows-1252?Q?6KFjFF3E0yjym9O2kiwshFKanryS9p+ondOW6EtxO63dTMpEzQHLQJwJ?=
 =?Windows-1252?Q?bcJ9pUJZCKqXuCeclQYqHIYThni+81hUd7ftA9fnJiOTCH/Ci3u/kxcv?=
 =?Windows-1252?Q?CExoCUg0Zc+a5bpzdXwZV7EkNNImHWMYnJFtJ5Mav+9Ms3D3+UIUxgzk?=
 =?Windows-1252?Q?5WHjLlFq8xZqKFiYyhULfi8jXZ4jVMmBDceLfdVYtrKKUt4bXlnpROdj?=
 =?Windows-1252?Q?LcnrOcOAV+jMfvmVE0SqhQZRB0H+ylMt13RwgX1F2MGDKTIDWwJcQSrk?=
 =?Windows-1252?Q?yDjdcuY+3/agEhBoKQo9I4Vx/t7Uju4C5Yf7BIj5nczrIX9Rr85f8kLk?=
 =?Windows-1252?Q?yEDIn+tB5mxo+QgFMs7mVwwZDTXQHzEsL/gP4DiNHKaejkVsemzixKJj?=
 =?Windows-1252?Q?DAlz1iq1f55qxercPrSXl/5jE/DHb3bk0VWoF4EvIBUyuSULuAl+YUHK?=
 =?Windows-1252?Q?ffCJhNGzZBWt+fyyPSdJsUnqkkE3YUzsxXNaoY59v8JcL20a5tl0oKDe?=
 =?Windows-1252?Q?d8snWmIJPt80IG2tzQ5ocLlkzLhbtcdtofemuoCR7cvZm9Uf3dODo5g8?=
 =?Windows-1252?Q?Am4ZJTaRs61U0UgM8c5UdJXVtb0s9MnyGmKZRR47zR73vv/3XkyI0boZ?=
 =?Windows-1252?Q?7jbwnR3DkUEnpE/eu6BRxRj/e2JOWzjHCqd2FMIh0FpcTuMcoPRv98dn?=
 =?Windows-1252?Q?uPodp6WHKSK2HWl34xACpR4A3HQnK/hAKY3ob8W9N77qbmYiaCB3/tTf?=
 =?Windows-1252?Q?5G727dHcyNOJKWVdI1km/225lX40KxaFIaFkGizDFviZSrkEg1zCx2cS?=
 =?Windows-1252?Q?KFO/X+UuDJ03Z6NDlr9rgX4/PRPRc3Q2rNN867OMrC4OH1O4xJ0J1a/y?=
 =?Windows-1252?Q?HstUn8v2MDXvukJInzTEZUQ2MXlnltCWE6EaUw4t794iLifG/GSko15t?=
 =?Windows-1252?Q?ACg0+wrrBicDLAG/NtfpZuQ2xZiDFf65WpGRy+QQqxBbosTMhxqveHhc?=
 =?Windows-1252?Q?tWVy6L6SNzQPc3ALTfcnI8orOAlGziqb9iXK/LpRqVuSXl+jLEwIYNav?=
 =?Windows-1252?Q?jla1pPVVct6s9Sjjxb+X2CNVT8tc9S1ss/9ZAkENSVVE67nEHhMpTI5V?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95a4c5dd-7e6f-4f27-b12d-08d937ebcee2
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2021 15:13:37.8570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gfSMIkoTgjIa3XpHq2CqI7HrEdLeTLC56Bky+bxl+vLAiqbVMK8FaLBQQSF7oMucPJiCrvXUrKfpWpoCmPCE4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0301MB2440
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 6/25/21 2:19 AM, Uwe Kleine-König wrote:
 > On Fri, May 28, 2021 at 05:45:22PM -0400, Sean Anderson wrote:
 >> This adds PWM support for Xilinx LogiCORE IP AXI soft timers commonly
 >> found on Xilinx FPGAs.  At the moment clock control is very basic: we
 >> just enable the clock during probe and pin the frequency. In the future,
 >> someone could add support for disabling the clock when not in use.
 >>
 >> This driver was written with reference to Xilinx DS764 for v1.03.a [1].
 >>
 >> [1] https://www.xilinx.com/support/documentation/ip_documentation/axi_timer/v1_03_a/axi_timer_ds764.pdf
 >>
 >> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
 >> ---
 >>
 >> Changes in v4:
 >> - Remove references to properties which are not good enough for Linux.
 >> - Don't use volatile in read/write replacements. Some arches have it and
 >>   some don't.
 >> - Put common timer properties into their own struct to better reuse
 >>   code.
 >>
 >> Changes in v3:
 >> - Add clockevent and clocksource support
 >> - Rewrite probe to only use a device_node, since timers may need to be
 >>   initialized before we have proper devices. This does bloat the code a bit
 >>   since we can no longer rely on helpers such as dev_err_probe. We also
 >>   cannot rely on device resources being free'd on failure, so we must free
 >>   them manually.
 >> - We now access registers through xilinx_timer_(read|write). This allows us
 >>   to deal with endianness issues, as originally seen in the microblaze
 >>   driver. CAVEAT EMPTOR: I have not tested this on big-endian!
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
 >>  drivers/mfd/Makefile     |   2 +-
 >>  drivers/pwm/Kconfig      |  12 +++
 >>  drivers/pwm/Makefile     |   1 +
 >>  drivers/pwm/pwm-xilinx.c | 219 +++++++++++++++++++++++++++++++++++++++
 >>  4 files changed, 233 insertions(+), 1 deletion(-)
 >>  create mode 100644 drivers/pwm/pwm-xilinx.c
 >>
 >> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
 >> index f0f9fbdde7dc..89769affe251 100644
 >> --- a/drivers/mfd/Makefile
 >> +++ b/drivers/mfd/Makefile
 >> @@ -269,6 +269,6 @@ obj-$(CONFIG_SGI_MFD_IOC3)	+= ioc3.o
 >>  obj-$(CONFIG_MFD_SIMPLE_MFD_I2C)	+= simple-mfd-i2c.o
 >>  obj-$(CONFIG_MFD_INTEL_M10_BMC)   += intel-m10-bmc.o
 >>
 >> -ifneq ($(CONFIG_XILINX_TIMER),)
 >> +ifneq ($(CONFIG_PWM_XILINX)$(CONFIG_XILINX_TIMER),)
 >>  obj-y				+= xilinx-timer.o
 >>  endif
 >> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
 >> index 8ae68d6203fb..ebf8d9014758 100644
 >> --- a/drivers/pwm/Kconfig
 >> +++ b/drivers/pwm/Kconfig
 >> @@ -620,4 +620,16 @@ config PWM_VT8500
 >>  	  To compile this driver as a module, choose M here: the module
 >>  	  will be called pwm-vt8500.
 >>
 >> +config PWM_XILINX
 >> +	tristate "Xilinx AXI Timer PWM support"
 >> +	depends on HAS_IOMEM && COMMON_CLK
 >> +	help
 >> +	  PWM driver for Xilinx LogiCORE IP AXI timers. This timer is
 >> +	  typically a soft core which may be present in Xilinx FPGAs.
 >> +	  This device may also be present in Microblaze soft processors.
 >> +	  If you don't have this IP in your design, choose N.
 >> +
 >> +	  To compile this driver as a module, choose M here: the module
 >> +	  will be called pwm-xilinx.
 >> +
 >>  endif
 >> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
 >> index d43b1e17e8e1..655df169b895 100644
 >> --- a/drivers/pwm/Makefile
 >> +++ b/drivers/pwm/Makefile
 >> @@ -58,3 +58,4 @@ obj-$(CONFIG_PWM_TWL)		+= pwm-twl.o
 >>  obj-$(CONFIG_PWM_TWL_LED)	+= pwm-twl-led.o
 >>  obj-$(CONFIG_PWM_VISCONTI)	+= pwm-visconti.o
 >>  obj-$(CONFIG_PWM_VT8500)	+= pwm-vt8500.o
 >> +obj-$(CONFIG_PWM_XILINX)	+= pwm-xilinx.o
 >> diff --git a/drivers/pwm/pwm-xilinx.c b/drivers/pwm/pwm-xilinx.c
 >> new file mode 100644
 >> index 000000000000..f05321496717
 >> --- /dev/null
 >> +++ b/drivers/pwm/pwm-xilinx.c
 >> @@ -0,0 +1,219 @@
 >> +// SPDX-License-Identifier: GPL-2.0+
 >> +/*
 >> + * Copyright (C) 2021 Sean Anderson <sean.anderson@seco.com>
 >> + *
 >> + * Hardware limitations:
 >> + * - When changing both duty cycle and period, we may end up with one cycle
 >> + *   with the old duty cycle and the new period.
 >
 > That means it doesn't reset the counter when a new period is set, right?

Correct. The only way to write to the counter is to stop the timer and
restart it.

 >
 >> + * - Cannot produce 100% duty cycle.
 >
 > Can it produce a 0% duty cycle? Below you're calling
 > xilinx_timer_tlr_period(..., ..., ..., 0) then which returns -ERANGE.

Yes. This is what you get when you try to specify 100% duty cycle (e.g.
TLR0 == TLR1).

 >
 >> + * - Only produces "normal" output.
 >
 > Does the output emit a low level when it's disabled?

I believe so.

 >
 >> + */
 >> +
 >> [...]
 >> +static int xilinx_pwm_apply(struct pwm_chip *chip, struct pwm_device *unused,
 >> +			    const struct pwm_state *state)
 >> +{
 >> +	int ret;
 >> +	struct xilinx_timer_priv *priv = xilinx_pwm_chip_to_priv(chip);
 >> +	u32 tlr0, tlr1;
 >> +	u32 tcsr0 = xilinx_timer_read(priv, TCSR0);
 >> +	u32 tcsr1 = xilinx_timer_read(priv, TCSR1);
 >> +	bool enabled = xilinx_timer_pwm_enabled(tcsr0, tcsr1);
 >> +
 >> +	if (state->polarity != PWM_POLARITY_NORMAL)
 >> +		return -EINVAL;
 >> +
 >> +	ret = xilinx_timer_tlr_period(priv, &tlr0, tcsr0, state->period);
 >> +	if (ret)
 >> +		return ret;
 >
 > The implementation of xilinx_timer_tlr_period (in patch 2/3) returns
 > -ERANGE for big periods. The good behaviour to implement is to cap to
 > the biggest period possible in this case.

Ok. Is this documented anywhere? And wouldn't this result in the wrong
duty cycle? E.g. say the max value is 100 and I try to apply a period of
150 and a duty_cycle of 75 (for a 50% duty cycle). If we cap at 100,
then I will instead have a 75% duty cycle, and there will be no error.
So I will silently get the wrong duty cycle, even when that duty cycle
is probably more important than the period.

 >
 > Also note that state->period is an u64 but it is casted to unsigned int
 > as this is the type of the forth parameter of xilinx_timer_tlr_period.

Hm, it looks like I immediately cast period to a u64. I will change the
signature for this function next revision.

 >
 >> +	ret = xilinx_timer_tlr_period(priv, &tlr1, tcsr1, state->duty_cycle);
 >> +	if (ret)
 >> +		return ret;
 >> +
 >> +	xilinx_timer_write(priv, tlr0, TLR0);
 >> +	xilinx_timer_write(priv, tlr1, TLR1);
 >> +
 >> +	if (state->enabled) {
 >> +		/* Only touch the TCSRs if we aren't already running */
 >> +		if (!enabled) {
 >> +			/* Load TLR into TCR */
 >> +			xilinx_timer_write(priv, tcsr0 | TCSR_LOAD, TCSR0);
 >> +			xilinx_timer_write(priv, tcsr1 | TCSR_LOAD, TCSR1);
 >> +			/* Enable timers all at once with ENALL */
 >> +			tcsr0 = (TCSR_PWM_SET & ~TCSR_ENT) | (tcsr0 & TCSR_UDT);
 >> +			tcsr1 = TCSR_PWM_SET | TCSR_ENALL | (tcsr1 & TCSR_UDT);
 >> +			xilinx_timer_write(priv, tcsr0, TCSR0);
 >> +			xilinx_timer_write(priv, tcsr1, TCSR1);
 >> +		}
 >> +	} else {
 >> +		xilinx_timer_write(priv, 0, TCSR0);
 >> +		xilinx_timer_write(priv, 0, TCSR1);
 >> +	}
 >> +
 >> +	return 0;
 >> +}
 >> +
 >> +static void xilinx_pwm_get_state(struct pwm_chip *chip,
 >> +				 struct pwm_device *unused,
 >> +				 struct pwm_state *state)
 >> +{
 >> +	struct xilinx_timer_priv *priv = xilinx_pwm_chip_to_priv(chip);
 >> +	u32 tlr0 = xilinx_timer_read(priv, TLR0);
 >> +	u32 tlr1 = xilinx_timer_read(priv, TLR1);
 >> +	u32 tcsr0 = xilinx_timer_read(priv, TCSR0);
 >> +	u32 tcsr1 = xilinx_timer_read(priv, TCSR1);
 >> +
 >> +	state->period = xilinx_timer_get_period(priv, tlr0, tcsr0);
 >> +	state->duty_cycle = xilinx_timer_get_period(priv, tlr1, tcsr1);
 >> +	state->enabled = xilinx_timer_pwm_enabled(tcsr0, tcsr1);
 >> +	state->polarity = PWM_POLARITY_NORMAL;
 >
 > Are the values returned here sensible if the hardware isn't in PWM mode?

Yes. If the hardware isn't in PWM mode, then state->enabled will be
false.

 >
 >> +}
 >> +
 >> +static const struct pwm_ops xilinx_pwm_ops = {
 >> +	.apply = xilinx_pwm_apply,
 >> +	.get_state = xilinx_pwm_get_state,
 >> +	.owner = THIS_MODULE,
 >> +};
 >> +
 >> +static int xilinx_timer_probe(struct platform_device *pdev)
 >> +{
 >> +	int ret;
 >> +	struct device *dev = &pdev->dev;
 >> +	struct device_node *np = dev->of_node;
 >> +	struct xilinx_timer_priv *priv;
 >> +	struct xilinx_pwm_device *pwm;
 >> +	u32 pwm_cells, one_timer;
 >> +
 >> +	ret = of_property_read_u32(np, "#pwm-cells", &pwm_cells);
 >> +	if (ret == -EINVAL)
 >> +		return -ENODEV;
 >> +	else if (ret)
 >> +		return dev_err_probe(dev, ret, "#pwm-cells\n");
 >
 > Very sparse error message.

Ok, will elaborate.

 >
 >> +	else if (pwm_cells)
 >> +		return dev_err_probe(dev, -EINVAL, "#pwm-cells must be 0\n");
 >
 > What is the rationale here to not support #pwm-cells = <2>?

Only one PWM is supported. But otherwise there is no particular
reason.

 >> +	pwm = devm_kzalloc(dev, sizeof(*pwm), GFP_KERNEL);
 >> +	if (!pwm)
 >> +		return -ENOMEM;
 >> +	platform_set_drvdata(pdev, pwm);
 >> +	priv = &pwm->priv;
 >> +
 >> +	priv->regs = devm_platform_ioremap_resource(pdev, 0);
 >> +	if (IS_ERR(priv->regs))
 >> +		return PTR_ERR(priv->regs);
 >> +
 >> +	ret = xilinx_timer_common_init(np, priv, &one_timer);
 >> +	if (ret)
 >> +		return ret;
 >> +
 >> +	if (one_timer)
 >> +		return dev_err_probe(dev, -EINVAL,
 >> +				     "two timers required for PWM mode\n");
 >> +
 >> +	/*
 >> +	 * The polarity of the generate outputs must be active high for PWM
 >> +	 * mode to work. We could determine this from the device tree, but
 >> +	 * alas, such properties are not allowed to be used.
 >> +	 */
 >> +
 >> +	priv->clk = devm_clk_get(dev, "s_axi_aclk");
 >> +	if (IS_ERR(priv->clk))
 >> +		return dev_err_probe(dev, PTR_ERR(priv->clk), "clock\n");
 >
 > again a sparse error message.
 >
 >> +
 >> +	ret = clk_prepare_enable(priv->clk);
 >> +	if (ret)
 >> +		return dev_err_probe(dev, ret, "clock enable failed\n");
 >> +	clk_rate_exclusive_get(priv->clk);
 >> +
 >> +	pwm->chip.dev = dev;
 >> +	pwm->chip.ops = &xilinx_pwm_ops;
 >> +	pwm->chip.npwm = 1;
 >> +	ret = pwmchip_add(&pwm->chip);
 >> +	if (ret) {
 >> +		clk_rate_exclusive_put(priv->clk);
 >> +		clk_disable_unprepare(priv->clk);
 >> +		return dev_err_probe(dev, ret, "could not register pwm chip\n");
 >> +	}
 >> +
 >> +	return 0;
 >> +}

Thanks for the review.

--Sean
