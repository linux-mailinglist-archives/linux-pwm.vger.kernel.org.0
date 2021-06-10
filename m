Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 374713A3052
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Jun 2021 18:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhFJQSD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 10 Jun 2021 12:18:03 -0400
Received: from mail-eopbgr70043.outbound.protection.outlook.com ([40.107.7.43]:22400
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230026AbhFJQSC (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 10 Jun 2021 12:18:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b9WOoLiAfpeKEFLnON8OKMFaschCHJQFjvD6mT+gurQBRl7arzel1BY+SxzpYz5f5M4jqhHvYmZkRfrcgVMQqHwbhVdUcAgGsEz53CPbpqypLI/ZbeyVkuYl0btwMM7uA4cdrqyZ26ASHfmLz0bIYEIOg1xGofx3rRV03obxyl1el8s18Ls73qpKd0CMZWgIydFdWoKyVLNNROXIpUtThy/UXfLLe+sOk1MkHyiJotUyfizzG9J0AdfLloxuQ5Y72EzdOCC0M//5g4wExO+XPOdpUHMpKiMt9d1sN1C9kopvh0313XfX6l/8jAOufEXoo2cLbMY5SX/VIj2vZjHKTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GkK3MaVX3sdBKm60QTGofwzWEKIS45AtW7dBHT90mXA=;
 b=AHyVUXwG/Qtkjvn6wGCDG0IqCm7WC3OIDKnOmkeC+DCTgSSw+bCVZTBmowvdcdAc4Ehx9V3hziYV5zVA4SUySKNbsx2WkLNA3vbUKP4Ynw0PCcixCjelK6Q8spfQIxfuyRvTSXJltj68Ly0IDu4bFAYi+6E7v4D+hdERodeR09oC1aQwHM3Y+bdXDNxEf5ynvOfS/2WoWi9uRhmWlA1+2TLgYl0iIyVgzvHY9a7f2dWVDQRB6bLEPfYbXMeUzh+Aq6er3SeVl6XWdnqFKqEpk9NYmBvNGPd88YqXKbLKMkpWmgPmTY8owUosZDCgvb0Xc77pQhjxea596prJTmFzYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GkK3MaVX3sdBKm60QTGofwzWEKIS45AtW7dBHT90mXA=;
 b=j8jvuoVLvQHptTKDgvmRfksLYzMQkaOaRO1g42Qz0L7NipYFJrUWh+kY8WmrqFNLok1Q92ESyS21tDbktnSDcnsDLa8XfvczuH5Y19tDANsLzjjP1CfihNhVFs/1HuUAZsB0hiTwivYCobk9WyWFUjOU0oKZ+Dbd7/SkkYWQfuM=
Authentication-Results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB3PR0302MB3385.eurprd03.prod.outlook.com (2603:10a6:8:b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Thu, 10 Jun
 2021 16:16:02 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b%5]) with mapi id 15.20.4219.022; Thu, 10 Jun 2021
 16:16:02 +0000
Subject: Re: [PATCH v4 3/3] pwm: Add support for Xilinx AXI Timer
To:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     michal.simek@xilinx.com, linux-kernel@vger.kernel.org,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        linux-arm-kernel@lists.infradead.org,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
References: <20210528214522.617435-1-sean.anderson@seco.com>
 <20210528214522.617435-3-sean.anderson@seco.com>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <12dc9337-c431-f0f5-535a-82479e11860a@seco.com>
Date:   Thu, 10 Jun 2021 12:15:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210528214522.617435-3-sean.anderson@seco.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.195.82.171]
X-ClientProxiedBy: MN2PR19CA0059.namprd19.prod.outlook.com
 (2603:10b6:208:19b::36) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.1.65] (50.195.82.171) by MN2PR19CA0059.namprd19.prod.outlook.com (2603:10b6:208:19b::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Thu, 10 Jun 2021 16:16:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60affa11-9669-4ab1-6d3e-08d92c2b0a9a
X-MS-TrafficTypeDiagnostic: DB3PR0302MB3385:
X-Microsoft-Antispam-PRVS: <DB3PR0302MB3385A44066AA81A2686574D496359@DB3PR0302MB3385.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GjrcvK0ttG2NxHFRooZ8GZhP6fexC6crZgXRQOrMs3aQAofYoq3s9unlX69agsNUSiMjkj30mqtRfyIWw+3VrydqGJxBeuFiC1fKCzFieuSJ3TfZMjH1bzgIyR/87ZkcuwShKkN2UjB8gdDzlxeHLgnaXSgrYu1wokAGimBvuM3q/eqY8HD9Nv4P4p8IoWRtfp3xchKrqpRvxYyy7Imad4uHeJp3GDErRj/TTar612kZAyoE4rz/DheHtnmE7H0mogSh80J94qRXemH7qFK6HH9aG44LwvqPkOkJvA9/k2UgR9RD3jF5qcY7b0cxr4ENQEo28C6dJJHKQKXK2L+pkvwqX3h4qHXsW6aZLQKAcYBfOahoKOtn3B7ALtI4RqYZtoIeRSWdpyCWmnKiqQx8UlqwK9njkfN/VCIGWBihROF7Dq4CCPV23MpW+dvnXgd/cXb2LirdyfX8je9r4ap2C+/jB14PFLmKXC69wFXoqCHcouO9oFQYJUuQ2QiEvs+hpITK+pyz7ug1wvUkHqFup6LXeFw8v6wrKNSQhXb11wwHHMQf5IRkKT3vMbdqj3n9efd6csI6xCiNN/nLXTSuiLS8aY9+KYf1gFB2fnY53+NEtluF1txBjjEOF6MFuLE3xAg3XMplMXy5QfHxRY88LljeIltiPIQCN3cgOVrllxhWbxv4mXprRijOCSJV3sHbDn+ibo6b6AdkneLGUkNMB1WJzlHmDOo6eisQa0RJpQFi5Krd7eVQ61JFX3FIZ4vHCEyKX0h7wt/SaCrzpNWiJ0VLTQG9onmY15wm6dubMgmhy2oll4oo4UafI0KBaTUJb+bdChT3+L58S1JySbjGPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(346002)(39850400004)(366004)(396003)(2616005)(66946007)(66556008)(186003)(2906002)(956004)(83380400001)(52116002)(6486002)(16526019)(31696002)(44832011)(478600001)(26005)(31686004)(6666004)(66476007)(16576012)(36756003)(86362001)(4326008)(53546011)(30864003)(966005)(38350700002)(316002)(38100700002)(5660300002)(54906003)(8936002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NHV4YzMrdHZLOGMrdmtrM2N1VGxRWXBEY2FIREZ3TCtSSUdqSGdnTWp4RDgy?=
 =?utf-8?B?V1luZCtXTDN1TDcrQU9tWXFyTHpqU2x3Q2RDeWE1Qlp0d0luWnZST0I5NlQ5?=
 =?utf-8?B?Mmc1WGFqc2tzWDhQb0RYWmtlSUQ3Qlozb1ZGREVjYjFMZkx0cUlwWFExZE9U?=
 =?utf-8?B?dGpsK0tWaEprSVhmTUtoaENnOS9qMDliY3JBdFlCWndlSk9ERWZFMnpNQnJG?=
 =?utf-8?B?QzBuSzhMZ0Nsc1V0V0p0Vlp4UmxtMFZQc2JjU1YyTmlSN2diL3U4RWwxcE1L?=
 =?utf-8?B?bTR2MGd1aEFibU1WT004QnZYSVM5dnJBQlJiYWlONE9ZQU1Qa0gxVGM5R1ls?=
 =?utf-8?B?Z3hWaVplWTc5bDZLTG51RFlpZUc2NzF0SkxKck5DQng4WVVxMVVzVXo3OTF4?=
 =?utf-8?B?cW9pdkkwRXliMFliemVZTEhTaDhmL1JnMEdyRVNDS3ZPYThCZ0wxVmpWRk9a?=
 =?utf-8?B?MjdJK0MvWkhMWGc2MjVsaHp5QUFVQmxjeFdIejYxQTlGSldHTzA0ZForN2Z3?=
 =?utf-8?B?a2FGNjkrYUwxV1FCV0tCdnRtQUI2cHRqektsR3l6WU9oc1dNT2dyeHJka2t1?=
 =?utf-8?B?ZVFScUVqcmZLNStGeHNnWDVZZCt0djNXK05FckoxZUtOQVplUzBvTSsrdHRr?=
 =?utf-8?B?eXkrNWZmMjlhVHRHb3E4ZkpUdS81VXFjcmVoQlYyZStjdXI2bFpOOWNoSVln?=
 =?utf-8?B?dUc2eERjd2xSUHdHZmxqVFlDeTVaeEZpbEZrd3lDZVVyMER6aUVwNHVRQlhO?=
 =?utf-8?B?MVVudmtKSXNTaWxRZzlNZHNSSHVnVzZmV1AvT0dZWVNlRjlRbm13ckdBYWl4?=
 =?utf-8?B?UFovTHEwQkxaMUxrKzVZcitrTlRJbXF2dmJSNXFtS2RxOTNsL3dOR05hNW1E?=
 =?utf-8?B?dmNISE0rMFBvVTFwcDQ3bXkya0swT3B5by80OEtUQUc1b2w1SHV6bGJhU2t6?=
 =?utf-8?B?REdNYjBIUnl2bzRTRXNSMUp3QlV5dllKWHJuay9xcmo3N3lnbnhPUzMvRkw2?=
 =?utf-8?B?MXUra3JFUDVVdFNhakRIMlk0eWlBY1oyNWtPQVJ5SmZxemI3Y3kvVFYyT0Fz?=
 =?utf-8?B?ek02cTYwemVRNldKSXltcXdYcEVTT1cxdXlwMnRaRW1kNVpBR1BvUGcvUXBr?=
 =?utf-8?B?MjZmbDJwc0pSSHBmeTNuZkRhemdHSHNQM1ltV1ZwYUlZU2pwTTBnclZXaDE2?=
 =?utf-8?B?UFU3Rjd0UTFidkgweE5qTGladkVsUzRTeVVVVVVDMjR0SEQvd09SWWg0YVkz?=
 =?utf-8?B?ZmtWSThCZHIzd1lzWmZ6L256S1FFRTBMejI4UXoxNW5WaWxhYlovM3lXNFFR?=
 =?utf-8?B?YlNEdUxORW0rOGtqeXlqT3pTallyQ2ppU1UvcUZSZjBHbGxNSXdsQUozTVBO?=
 =?utf-8?B?UVNSYW9iRnNUMGJTc2pSQzdiL0EzZTkxVk85eFNHMEs4eUwyV3N0Y3YvREI3?=
 =?utf-8?B?WEpWLzRFUEtickIybTgvQU9vNmZaSldpbWd1em1XeUxRY1djcDcwMGs5Tml5?=
 =?utf-8?B?OVo1dmszbEFGa2gzSEwrYUFHWkpZUmk1b1ZyeTZ3SkhOUyt6VUJCUWFjbU1q?=
 =?utf-8?B?N1pXQ3VJV1ZvSzJaRWpxY3plM0pZK0hBQktlM2ZuWlY0VWw0SmI5V3JvMVNw?=
 =?utf-8?B?Zk9kTzd2TGE1amliUXhqZlFvTDcrSHVqbXNOWkhNQXd4OG1OTVVLVUIvZ01h?=
 =?utf-8?B?MTVYanVUSU9TTDk0L1NENFZNWWtDWGZmNysvK2dFM20wcUZYNXdGY29xVWhK?=
 =?utf-8?Q?FPlDz2NNJoDCq2R5bxlJw0ETPbyaktmLwLfs2cn?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60affa11-9669-4ab1-6d3e-08d92c2b0a9a
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 16:16:02.5372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2rm9sMA9NVsTbz4ZQvjToGBjFBrrXd79SvBNBl+JurtmmzTQYPdhTBmqNA8QcY6K1n2gDx8/ZK5mwrDP7INmTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0302MB3385
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

ping

Michal, I know you had some objections to previous spins of this series
which I have tried to address this time around. So I would appreciate if
you could review this.

--Sean

On 5/28/21 5:45 PM, Sean Anderson wrote:
 > This adds PWM support for Xilinx LogiCORE IP AXI soft timers commonly
 > found on Xilinx FPGAs.  At the moment clock control is very basic: we
 > just enable the clock during probe and pin the frequency. In the future,
 > someone could add support for disabling the clock when not in use.
 >
 > This driver was written with reference to Xilinx DS764 for v1.03.a [1].
 >
 > [1] https://www.xilinx.com/support/documentation/ip_documentation/axi_timer/v1_03_a/axi_timer_ds764.pdf
 >
 > Signed-off-by: Sean Anderson <sean.anderson@seco.com>
 > ---
 >
 > Changes in v4:
 > - Remove references to properties which are not good enough for Linux.
 > - Don't use volatile in read/write replacements. Some arches have it and
 >    some don't.
 > - Put common timer properties into their own struct to better reuse
 >    code.
 >
 > Changes in v3:
 > - Add clockevent and clocksource support
 > - Rewrite probe to only use a device_node, since timers may need to be
 >    initialized before we have proper devices. This does bloat the code a bit
 >    since we can no longer rely on helpers such as dev_err_probe. We also
 >    cannot rely on device resources being free'd on failure, so we must free
 >    them manually.
 > - We now access registers through xilinx_timer_(read|write). This allows us
 >    to deal with endianness issues, as originally seen in the microblaze
 >    driver. CAVEAT EMPTOR: I have not tested this on big-endian!
 > - Remove old microblaze driver
 >
 > Changes in v2:
 > - Don't compile this module by default for arm64
 > - Add dependencies on COMMON_CLK and HAS_IOMEM
 > - Add comment explaining why we depend on !MICROBLAZE
 > - Add comment describing device
 > - Rename TCSR_(SET|CLEAR) to TCSR_RUN_(SET|CLEAR)
 > - Use NSEC_TO_SEC instead of defining our own
 > - Use TCSR_RUN_MASK to check if the PWM is enabled, as suggested by Uwe
 > - Cast dividends to u64 to avoid overflow
 > - Check for over- and underflow when calculating TLR
 > - Set xilinx_pwm_ops.owner
 > - Don't set pwmchip.base to -1
 > - Check range of xlnx,count-width
 > - Ensure the clock is always running when the pwm is registered
 > - Remove debugfs file :l
 > - Report errors with dev_error_probe
 >
 >   drivers/mfd/Makefile     |   2 +-
 >   drivers/pwm/Kconfig      |  12 +++
 >   drivers/pwm/Makefile     |   1 +
 >   drivers/pwm/pwm-xilinx.c | 219 +++++++++++++++++++++++++++++++++++++++
 >   4 files changed, 233 insertions(+), 1 deletion(-)
 >   create mode 100644 drivers/pwm/pwm-xilinx.c
 >
 > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
 > index f0f9fbdde7dc..89769affe251 100644
 > --- a/drivers/mfd/Makefile
 > +++ b/drivers/mfd/Makefile
 > @@ -269,6 +269,6 @@ obj-$(CONFIG_SGI_MFD_IOC3)	+= ioc3.o
 >   obj-$(CONFIG_MFD_SIMPLE_MFD_I2C)	+= simple-mfd-i2c.o
 >   obj-$(CONFIG_MFD_INTEL_M10_BMC)   += intel-m10-bmc.o
 >
 > -ifneq ($(CONFIG_XILINX_TIMER),)
 > +ifneq ($(CONFIG_PWM_XILINX)$(CONFIG_XILINX_TIMER),)
 >   obj-y				+= xilinx-timer.o
 >   endif
 > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
 > index 8ae68d6203fb..ebf8d9014758 100644
 > --- a/drivers/pwm/Kconfig
 > +++ b/drivers/pwm/Kconfig
 > @@ -620,4 +620,16 @@ config PWM_VT8500
 >   	  To compile this driver as a module, choose M here: the module
 >   	  will be called pwm-vt8500.
 >
 > +config PWM_XILINX
 > +	tristate "Xilinx AXI Timer PWM support"
 > +	depends on HAS_IOMEM && COMMON_CLK
 > +	help
 > +	  PWM driver for Xilinx LogiCORE IP AXI timers. This timer is
 > +	  typically a soft core which may be present in Xilinx FPGAs.
 > +	  This device may also be present in Microblaze soft processors.
 > +	  If you don't have this IP in your design, choose N.
 > +
 > +	  To compile this driver as a module, choose M here: the module
 > +	  will be called pwm-xilinx.
 > +
 >   endif
 > diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
 > index d43b1e17e8e1..655df169b895 100644
 > --- a/drivers/pwm/Makefile
 > +++ b/drivers/pwm/Makefile
 > @@ -58,3 +58,4 @@ obj-$(CONFIG_PWM_TWL)		+= pwm-twl.o
 >   obj-$(CONFIG_PWM_TWL_LED)	+= pwm-twl-led.o
 >   obj-$(CONFIG_PWM_VISCONTI)	+= pwm-visconti.o
 >   obj-$(CONFIG_PWM_VT8500)	+= pwm-vt8500.o
 > +obj-$(CONFIG_PWM_XILINX)	+= pwm-xilinx.o
 > diff --git a/drivers/pwm/pwm-xilinx.c b/drivers/pwm/pwm-xilinx.c
 > new file mode 100644
 > index 000000000000..f05321496717
 > --- /dev/null
 > +++ b/drivers/pwm/pwm-xilinx.c
 > @@ -0,0 +1,219 @@
 > +// SPDX-License-Identifier: GPL-2.0+
 > +/*
 > + * Copyright (C) 2021 Sean Anderson <sean.anderson@seco.com>
 > + *
 > + * Hardware limitations:
 > + * - When changing both duty cycle and period, we may end up with one cycle
 > + *   with the old duty cycle and the new period.
 > + * - Cannot produce 100% duty cycle.
 > + * - Only produces "normal" output.
 > + */
 > +
 > +#include <linux/clk.h>
 > +#include <linux/clk-provider.h>
 > +#include <linux/device.h>
 > +#include <linux/module.h>
 > +#include <linux/mfd/xilinx-timer.h>
 > +#include <linux/platform_device.h>
 > +#include <linux/pwm.h>
 > +
 > +/*
 > + * The idea here is to capture whether the PWM is actually running (e.g.
 > + * because we or the bootloader set it up) and we need to be careful to ensure
 > + * we don't cause a glitch. According to the data sheet, to enable the PWM we
 > + * need to
 > + *
 > + * - Set both timers to generate mode (MDT=1)
 > + * - Set both timers to PWM mode (PWMA=1)
 > + * - Enable the generate out signals (GENT=1)
 > + *
 > + * In addition,
 > + *
 > + * - The timer must be running (ENT=1)
 > + * - The timer must auto-reload TLR into TCR (ARHT=1)
 > + * - We must not be in the process of loading TLR into TCR (LOAD=0)
 > + * - Cascade mode must be disabled (CASC=0)
 > + *
 > + * If any of these differ from usual, then the PWM is either disabled, or is
 > + * running in a mode that this driver does not support.
 > + */
 > +#define TCSR_PWM_SET (TCSR_GENT | TCSR_ARHT | TCSR_ENT | TCSR_PWMA)
 > +#define TCSR_PWM_CLEAR (TCSR_MDT | TCSR_LOAD)
 > +#define TCSR_PWM_MASK (TCSR_PWM_SET | TCSR_PWM_CLEAR)
 > +
 > +struct xilinx_pwm_device {
 > +	struct pwm_chip chip;
 > +	struct xilinx_timer_priv priv;
 > +};
 > +
 > +static inline struct xilinx_timer_priv
 > +*xilinx_pwm_chip_to_priv(struct pwm_chip *chip)
 > +{
 > +	return &container_of(chip, struct xilinx_pwm_device, chip)->priv;
 > +}
 > +
 > +static bool xilinx_timer_pwm_enabled(u32 tcsr0, u32 tcsr1)
 > +{
 > +	return ((TCSR_PWM_MASK | TCSR_CASC) & tcsr0) == TCSR_PWM_SET &&
 > +		(TCSR_PWM_MASK & tcsr1) == TCSR_PWM_SET;
 > +}
 > +
 > +static int xilinx_pwm_apply(struct pwm_chip *chip, struct pwm_device *unused,
 > +			    const struct pwm_state *state)
 > +{
 > +	int ret;
 > +	struct xilinx_timer_priv *priv = xilinx_pwm_chip_to_priv(chip);
 > +	u32 tlr0, tlr1;
 > +	u32 tcsr0 = xilinx_timer_read(priv, TCSR0);
 > +	u32 tcsr1 = xilinx_timer_read(priv, TCSR1);
 > +	bool enabled = xilinx_timer_pwm_enabled(tcsr0, tcsr1);
 > +
 > +	if (state->polarity != PWM_POLARITY_NORMAL)
 > +		return -EINVAL;
 > +
 > +	ret = xilinx_timer_tlr_period(priv, &tlr0, tcsr0, state->period);
 > +	if (ret)
 > +		return ret;
 > +
 > +	ret = xilinx_timer_tlr_period(priv, &tlr1, tcsr1, state->duty_cycle);
 > +	if (ret)
 > +		return ret;
 > +
 > +	xilinx_timer_write(priv, tlr0, TLR0);
 > +	xilinx_timer_write(priv, tlr1, TLR1);
 > +
 > +	if (state->enabled) {
 > +		/* Only touch the TCSRs if we aren't already running */
 > +		if (!enabled) {
 > +			/* Load TLR into TCR */
 > +			xilinx_timer_write(priv, tcsr0 | TCSR_LOAD, TCSR0);
 > +			xilinx_timer_write(priv, tcsr1 | TCSR_LOAD, TCSR1);
 > +			/* Enable timers all at once with ENALL */
 > +			tcsr0 = (TCSR_PWM_SET & ~TCSR_ENT) | (tcsr0 & TCSR_UDT);
 > +			tcsr1 = TCSR_PWM_SET | TCSR_ENALL | (tcsr1 & TCSR_UDT);
 > +			xilinx_timer_write(priv, tcsr0, TCSR0);
 > +			xilinx_timer_write(priv, tcsr1, TCSR1);
 > +		}
 > +	} else {
 > +		xilinx_timer_write(priv, 0, TCSR0);
 > +		xilinx_timer_write(priv, 0, TCSR1);
 > +	}
 > +
 > +	return 0;
 > +}
 > +
 > +static void xilinx_pwm_get_state(struct pwm_chip *chip,
 > +				 struct pwm_device *unused,
 > +				 struct pwm_state *state)
 > +{
 > +	struct xilinx_timer_priv *priv = xilinx_pwm_chip_to_priv(chip);
 > +	u32 tlr0 = xilinx_timer_read(priv, TLR0);
 > +	u32 tlr1 = xilinx_timer_read(priv, TLR1);
 > +	u32 tcsr0 = xilinx_timer_read(priv, TCSR0);
 > +	u32 tcsr1 = xilinx_timer_read(priv, TCSR1);
 > +
 > +	state->period = xilinx_timer_get_period(priv, tlr0, tcsr0);
 > +	state->duty_cycle = xilinx_timer_get_period(priv, tlr1, tcsr1);
 > +	state->enabled = xilinx_timer_pwm_enabled(tcsr0, tcsr1);
 > +	state->polarity = PWM_POLARITY_NORMAL;
 > +}
 > +
 > +static const struct pwm_ops xilinx_pwm_ops = {
 > +	.apply = xilinx_pwm_apply,
 > +	.get_state = xilinx_pwm_get_state,
 > +	.owner = THIS_MODULE,
 > +};
 > +
 > +static int xilinx_timer_probe(struct platform_device *pdev)
 > +{
 > +	int ret;
 > +	struct device *dev = &pdev->dev;
 > +	struct device_node *np = dev->of_node;
 > +	struct xilinx_timer_priv *priv;
 > +	struct xilinx_pwm_device *pwm;
 > +	u32 pwm_cells, one_timer;
 > +
 > +	ret = of_property_read_u32(np, "#pwm-cells", &pwm_cells);
 > +	if (ret == -EINVAL)
 > +		return -ENODEV;
 > +	else if (ret)
 > +		return dev_err_probe(dev, ret, "#pwm-cells\n");
 > +	else if (pwm_cells)
 > +		return dev_err_probe(dev, -EINVAL, "#pwm-cells must be 0\n");
 > +
 > +	pwm = devm_kzalloc(dev, sizeof(*pwm), GFP_KERNEL);
 > +	if (!pwm)
 > +		return -ENOMEM;
 > +	platform_set_drvdata(pdev, pwm);
 > +	priv = &pwm->priv;
 > +
 > +	priv->regs = devm_platform_ioremap_resource(pdev, 0);
 > +	if (IS_ERR(priv->regs))
 > +		return PTR_ERR(priv->regs);
 > +
 > +	ret = xilinx_timer_common_init(np, priv, &one_timer);
 > +	if (ret)
 > +		return ret;
 > +
 > +	if (one_timer)
 > +		return dev_err_probe(dev, -EINVAL,
 > +				     "two timers required for PWM mode\n");
 > +
 > +	/*
 > +	 * The polarity of the generate outputs must be active high for PWM
 > +	 * mode to work. We could determine this from the device tree, but
 > +	 * alas, such properties are not allowed to be used.
 > +	 */
 > +
 > +	priv->clk = devm_clk_get(dev, "s_axi_aclk");
 > +	if (IS_ERR(priv->clk))
 > +		return dev_err_probe(dev, PTR_ERR(priv->clk), "clock\n");
 > +
 > +	ret = clk_prepare_enable(priv->clk);
 > +	if (ret)
 > +		return dev_err_probe(dev, ret, "clock enable failed\n");
 > +	clk_rate_exclusive_get(priv->clk);
 > +
 > +	pwm->chip.dev = dev;
 > +	pwm->chip.ops = &xilinx_pwm_ops;
 > +	pwm->chip.npwm = 1;
 > +	ret = pwmchip_add(&pwm->chip);
 > +	if (ret) {
 > +		clk_rate_exclusive_put(priv->clk);
 > +		clk_disable_unprepare(priv->clk);
 > +		return dev_err_probe(dev, ret, "could not register pwm chip\n");
 > +	}
 > +
 > +	return 0;
 > +}
 > +
 > +static int xilinx_timer_remove(struct platform_device *pdev)
 > +{
 > +	struct xilinx_pwm_device *pwm = platform_get_drvdata(pdev);
 > +
 > +	pwmchip_remove(&pwm->chip);
 > +	clk_rate_exclusive_put(pwm->priv.clk);
 > +	clk_disable_unprepare(pwm->priv.clk);
 > +	return 0;
 > +}
 > +
 > +static const struct of_device_id xilinx_timer_of_match[] = {
 > +	{ .compatible = "xlnx,xps-timer-1.00.a", },
 > +	{ .compatible = "xlnx,axi-timer-2.0" },
 > +	{},
 > +};
 > +MODULE_DEVICE_TABLE(of, xilinx_timer_of_match);
 > +
 > +static struct platform_driver xilinx_timer_driver = {
 > +	.probe = xilinx_timer_probe,
 > +	.remove = xilinx_timer_remove,
 > +	.driver = {
 > +		.name = "xilinx-timer",
 > +		.of_match_table = of_match_ptr(xilinx_timer_of_match),
 > +	},
 > +};
 > +module_platform_driver(xilinx_timer_driver);
 > +
 > +MODULE_ALIAS("platform:xilinx-timer");
 > +MODULE_DESCRIPTION("Xilinx LogiCORE IP AXI Timer driver");
 > +MODULE_LICENSE("GPL v2");
 >
