Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5154318FE
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Oct 2021 14:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbhJRMZk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 18 Oct 2021 08:25:40 -0400
Received: from mail-dm6nam10on2080.outbound.protection.outlook.com ([40.107.93.80]:26081
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229833AbhJRMZj (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 18 Oct 2021 08:25:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jkYQsEjXiop5lPFmYz5fdpJYuhrA72j7OLQh3dOPBuhXsoan4376nr0LxlfGrinCnfYSUiNZ54g0hhLwGujr2Z2lg3xZXHfeUYprsFS869AEgK6RWnqfCjspSeJii/YEsoGamFyMi2hqUoIKEHUpYIJ9etDCx7+YHGTSzQhsal/21hhC7PXV5FCHgXpHIvhgM2Uc7odUfemeGbBdaj7Lf6CdJSGksaS1gMpwmjUyu/a7FpyViCOiYVUd29UIBoGXKLF7yVLXoaIJfOa/Q9b3iJirRjZUp7QWMkJH1APFnZ/F7PZ0EYQzce9giporJQ0msuNlSUf1RbuMI5MlJ3kZVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nXXfUyvKzcEAjiwTc3flYw4NEWnh72sLnzIAkT2eU7g=;
 b=H1kYA7X1eK2B8JkKmrTIno/CjFkFrJcn9Nw4dyPFKi9fy8pR5Zu+d2KI5XVAm0oF+e9u6gwmWxaYtgY1ZSmG5FZrAGCrCHL2+Unp9rnQbeODayxvh5WsKIaetxGNt4refTacfvoGay2VExMLzXtekcR9zjxa4DIZe6Ekfgdn8L1hQAVZAxGpR2SgwR0tpJwYQf6gntGL2/sfI1AxpB6oWUVBguhOG6a4SL6bQb8mDp6N0BcxHeggwbDXtjtfVEKClfqJ1JLBSpmFORpQX5IGnn8rbJg2WyfiXwrqXfd05XvtbTJeQ75TsS4mzOVS/CGVN9e/YmDkRT/TXvbY5tDH6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=seco.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXXfUyvKzcEAjiwTc3flYw4NEWnh72sLnzIAkT2eU7g=;
 b=qk5baTruQDKfZwSoOBZmfSlsRhKiGj0orMxRmiHM1hX11BachPdr5pQCBhX/aqoTHB2GvR226y0rdw1WtOpwCZBKxTXDyXtEPgmyfMgXbLQFsNurcSRmEWPiPgaMZqFtHHYVcpvj0wfEiV7qKJE9113163xxgedYyRB471jv2g8=
Received: from SN4PR0201CA0031.namprd02.prod.outlook.com
 (2603:10b6:803:2e::17) by MWHPR02MB2847.namprd02.prod.outlook.com
 (2603:10b6:300:114::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Mon, 18 Oct
 2021 12:23:26 +0000
Received: from SN1NAM02FT0023.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:2e:cafe::14) by SN4PR0201CA0031.outlook.office365.com
 (2603:10b6:803:2e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend
 Transport; Mon, 18 Oct 2021 12:23:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; seco.com; dkim=none (message not signed)
 header.d=none;seco.com; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0023.mail.protection.outlook.com (10.97.4.236) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Mon, 18 Oct 2021 12:23:25 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 18 Oct 2021 05:23:25 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 18 Oct 2021 05:23:25 -0700
Envelope-to: sean.anderson@seco.com,
 linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org,
 thierry.reding@gmail.com,
 lee.jones@linaro.org,
 u.kleine-koenig@pengutronix.de,
 linux-arm-kernel@lists.infradead.org,
 alvaro.gamez@hazent.com,
 linux-kernel@vger.kernel.org
Received: from [10.254.241.49] (port=52950)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1mcRfo-000H1f-Bi; Mon, 18 Oct 2021 05:23:24 -0700
Message-ID: <3303baa4-e3ea-2009-2122-0abff30e25c5@xilinx.com>
Date:   Mon, 18 Oct 2021 14:23:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v8 3/3] pwm: Add support for Xilinx AXI Timer
Content-Language: en-US
To:     Sean Anderson <sean.anderson@seco.com>,
        <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        <michal.simek@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        <linux-kernel@vger.kernel.org>
References: <20211015190025.409426-1-sean.anderson@seco.com>
 <20211015190025.409426-3-sean.anderson@seco.com>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <20211015190025.409426-3-sean.anderson@seco.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1fced72-7137-46c3-f16d-08d9923215b5
X-MS-TrafficTypeDiagnostic: MWHPR02MB2847:
X-Microsoft-Antispam-PRVS: <MWHPR02MB2847E12E1E1AF0CF342E7841C6BC9@MWHPR02MB2847.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EORg3qfAqpFqdGIoUrvdt3zvrpA4DW2g5SNfK4t2rEPKHoL9ZokMpo67TibQc3CCxYYL7nqxlHGlQFvqAlPTGfauDVFMqHpvVfIwPzD1yf1NtXFIHqCa6QC78YmvJWCdt0kdn0Dld4GW3MYT9ZBiDf18f8ibfayeBmYU72A5JivSN7OsgP8jgSl+6pF+FhtHb/t2V6LuTAOcxzARK9IRB3UXmAsMg8dBIxvrRR2Z64YqMM3jFkAwWI+8CLlYF+W8ae/sJSyOc5byRKyNHCUezWsLcj9QYLmMd4G5ztq6z1efGp5FdGXmdy1vUNYEgjNbtQxHgg6FM7I0dXRbj86KaAlMNL/pu0v52tuxtxzOwny/0PkXemQu3DOF6GRdK+ziKHpJUS7fDk7qlvo8Znn2BKn1oPeqxnKguogmnVe/WJvf0FD51bJf5Gp0yWP51rPmQNBSd/3IcyjwvLErqdLrZr3rBrphCSGuyM7h2d2dtP7IyDoD6TJ9UnpArXdOltU6RLH1Y4N5gwV9B7tA7vXJ66yYPcO+U4iahJNleQt7PuT/95Di9yw8g7Yp6EyIE5rJeYg/VUova841Px6zyax+8k9JYM+OxG+dCJtP8GEElTTPLuS2LxsmMFKq5Nc0JxertUIRivyRcmoHCQGJ192smAJSQksvWywGlF+w894vRJUa4rGhumNKK9o8fqlcvL+vMv933XtqrbkfFpHTXRWOFOGA0sAowHJDzO7MGUFEILNjdZcgW8GMXmwTTfeXI9V/a+JcElWX7YfrRMf13nw+X4H2P/0bAgFZsQShCrPc35bMBrlkiNLGEe+ptiWPXcyagl9NrVZCw9QLzrmFolWs7g==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(31696002)(8936002)(44832011)(356005)(8676002)(5660300002)(4326008)(110136005)(31686004)(2906002)(70206006)(54906003)(966005)(36860700001)(426003)(508600001)(53546011)(82310400003)(336012)(316002)(47076005)(26005)(2616005)(36906005)(70586007)(30864003)(9786002)(7636003)(83380400001)(6666004)(36756003)(186003)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 12:23:25.9091
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1fced72-7137-46c3-f16d-08d9923215b5
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0023.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2847
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 10/15/21 21:00, Sean Anderson wrote:
> This adds PWM support for Xilinx LogiCORE IP AXI soft timers commonly
> found on Xilinx FPGAs. At the moment clock control is very basic: we
> just enable the clock during probe and pin the frequency. In the future,
> someone could add support for disabling the clock when not in use.
> 
> Some common code has been specially demarcated. While currently only
> used by the PWM driver, it is anticipated that it may be split off in
> the future to be used by the timer driver as well.
> 
> This driver was written with reference to Xilinx DS764 for v1.03.a [1].
> 
> [1] https://www.xilinx.com/support/documentation/ip_documentation/axi_timer/v1_03_a/axi_timer_ds764.pdf
> 
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> ---
> 
> Changes in v8:
> - Drop new timer driver; it has been deferred for future series
> 
> Changes in v7:
> - Add dependency on OF_ADDRESS
> - Fix period_cycles calculation
> - Fix typo in limitations
> 
> Changes in v6:
> - Capitalize error messages
> - Don't disable regmap locking to allow inspection of registers via
>    debugfs
> - Prevent overflow when calculating period_cycles
> - Remove enabled variable from xilinx_pwm_apply
> - Swap order of period_cycle range comparisons
> 
> Changes in v5:
> - Allow non-zero #pwm-cells
> - Correctly set duty_cycle in get_state when TLR0=TLR1
> - Elaborate on limitation section
> - Perform some additional checks/rounding in apply_state
> - Remove xlnx,axi-timer-2.0 compatible string
> - Rework duty-cycle and period calculations with feedback from Uwe
> - Switch to regmap to abstract endianness issues
> - Use more verbose error messages
> 
> Changes in v4:
> - Don't use volatile in read/write replacements. Some arches have it and
>    some don't.
> - Put common timer properties into their own struct to better reuse
>    code.
> - Remove references to properties which are not good enough for Linux.
> 
> Changes in v3:
> - Add clockevent and clocksource support
> - Remove old microblaze driver
> - Rewrite probe to only use a device_node, since timers may need to be
>    initialized before we have proper devices. This does bloat the code a bit
>    since we can no longer rely on helpers such as dev_err_probe. We also
>    cannot rely on device resources being free'd on failure, so we must free
>    them manually.
> - We now access registers through xilinx_timer_(read|write). This allows us
>    to deal with endianness issues, as originally seen in the microblaze
>    driver. CAVEAT EMPTOR: I have not tested this on big-endian!
> 
> Changes in v2:
> - Add comment describing device
> - Add comment explaining why we depend on !MICROBLAZE
> - Add dependencies on COMMON_CLK and HAS_IOMEM
> - Cast dividends to u64 to avoid overflow
> - Check for over- and underflow when calculating TLR
> - Check range of xlnx,count-width
> - Don't compile this module by default for arm64
> - Don't set pwmchip.base to -1
> - Ensure the clock is always running when the pwm is registered
> - Remove debugfs file :l
> - Rename TCSR_(SET|CLEAR) to TCSR_RUN_(SET|CLEAR)
> - Report errors with dev_error_probe
> - Set xilinx_pwm_ops.owner
> - Use NSEC_TO_SEC instead of defining our own
> - Use TCSR_RUN_MASK to check if the PWM is enabled, as suggested by Uwe
> 
>   MAINTAINERS                        |   7 +
>   arch/microblaze/kernel/timer.c     |   3 +
>   drivers/pwm/Kconfig                |  14 ++
>   drivers/pwm/Makefile               |   1 +
>   drivers/pwm/pwm-xilinx.c           | 329 +++++++++++++++++++++++++++++
>   include/clocksource/timer-xilinx.h |  91 ++++++++
>   6 files changed, 445 insertions(+)
>   create mode 100644 drivers/pwm/pwm-xilinx.c
>   create mode 100644 include/clocksource/timer-xilinx.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6b6f98483deb..bed034ef46ad 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20601,6 +20601,13 @@ F:	drivers/misc/Makefile
>   F:	drivers/misc/xilinx_sdfec.c
>   F:	include/uapi/misc/xilinx_sdfec.h
>   
> +XILINX PWM DRIVER
> +M:	Sean Anderson <sean.anderson@seco.com>
> +S:	Maintained
> +F:	drivers/clocksource/timer-xilinx-common.c
> +F:	drivers/pwm/pwm-xilinx.c
> +F:	include/clocksource/timer-xilinx.h
> +
>   XILINX UARTLITE SERIAL DRIVER
>   M:	Peter Korsgaard <jacmet@sunsite.dk>
>   L:	linux-serial@vger.kernel.org
> diff --git a/arch/microblaze/kernel/timer.c b/arch/microblaze/kernel/timer.c
> index f8832cf49384..20e2669b533d 100644
> --- a/arch/microblaze/kernel/timer.c
> +++ b/arch/microblaze/kernel/timer.c
> @@ -251,6 +251,9 @@ static int __init xilinx_timer_init(struct device_node *timer)
>   	u32 timer_num = 1;
>   	int ret;
>   
> +	if (of_property_read_bool(np, "#pwm-cells"))
> +		return 0;
> +
>   	if (initialized)
>   		return -EINVAL;
>   
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index aa29841bbb79..47f25237754f 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -638,4 +638,18 @@ config PWM_VT8500
>   	  To compile this driver as a module, choose M here: the module
>   	  will be called pwm-vt8500.
>   
> +config PWM_XILINX
> +	tristate "Xilinx AXI Timer PWM support"
> +	depends on OF_ADDRESS
> +	depends on COMMON_CLK
> +	select REGMAP_MMIO
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
> index 708840b7fba8..ea785480359b 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -60,3 +60,4 @@ obj-$(CONFIG_PWM_TWL)		+= pwm-twl.o
>   obj-$(CONFIG_PWM_TWL_LED)	+= pwm-twl-led.o
>   obj-$(CONFIG_PWM_VISCONTI)	+= pwm-visconti.o
>   obj-$(CONFIG_PWM_VT8500)	+= pwm-vt8500.o
> +obj-$(CONFIG_PWM_XILINX)	+= pwm-xilinx.o
> diff --git a/drivers/pwm/pwm-xilinx.c b/drivers/pwm/pwm-xilinx.c
> new file mode 100644
> index 000000000000..c532be6c7912
> --- /dev/null
> +++ b/drivers/pwm/pwm-xilinx.c
> @@ -0,0 +1,329 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2021 Sean Anderson <sean.anderson@seco.com>
> + *
> + * Limitations:
> + * - When changing both duty cycle and period, we may end up with one cycle
> + *   with the old duty cycle and the new period. This is because the counters
> + *   may only be reloaded by first stopping them, or by letting them be
> + *   automatically reloaded at the end of a cycle. If this automatic reload
> + *   happens after we set TLR0 but before we set TLR1 then we will have a
> + *   bad cycle. This could probably be fixed by reading TCR0 just before
> + *   reprogramming, but I think it would add complexity for little gain.
> + * - Cannot produce 100% duty cycle by configuring the TLRs. This might be
> + *   possible by stopping the counters at an appropriate point in the cycle,
> + *   but this is not (yet) implemented.
> + * - Only produces "normal" output.
> + * - Always produces low output if disabled.
> + */
> +
> +#include <clocksource/timer-xilinx.h>
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/regmap.h>
> +
> +/*
> + * The following functions are "common" to drivers for this device, and may be
> + * exported at a future date.
> + */
> +u32 xilinx_timer_tlr_cycles(struct xilinx_timer_priv *priv, u32 tcsr,
> +			    u64 cycles)
> +{
> +	WARN_ON(cycles < 2 || cycles - 2 > priv->max);
> +
> +	if (tcsr & TCSR_UDT)
> +		return cycles - 2;
> +	else


you don't need else here.

> +		return priv->max - cycles + 2;
> +}
> +
> +unsigned int xilinx_timer_get_period(struct xilinx_timer_priv *priv,
> +				     u32 tlr, u32 tcsr)
> +{
> +	u64 cycles;
> +
> +	if (tcsr & TCSR_UDT)
> +		cycles = tlr + 2;
> +	else
> +		cycles = (u64)priv->max - tlr + 2;
> +
> +	/* cycles has a max of 2^32 + 2 */
> +	return DIV64_U64_ROUND_CLOSEST(cycles * NSEC_PER_SEC,
> +				       clk_get_rate(priv->clk));
> +}
> +
> +int xilinx_timer_common_init(struct device_node *np,
> +			     struct xilinx_timer_priv *priv,
> +			     u32 *one_timer)
> +{
> +	int ret;
> +	u32 width;
> +
> +	ret = of_property_read_u32(np, "xlnx,one-timer-only", one_timer);
> +	if (ret) {
> +		pr_err("%pOF: err %d: xlnx,one-timer-only\n", np, ret);
> +		return ret;
> +	} else if (*one_timer && *one_timer != 1) {

you can also remove this else.


> +		pr_err("%pOF: xlnx,one-timer-only must be 0 or 1\n", np);

Isn't it better to check direct value you need?
If you have 1 here you will fail in probe anyway that's why there is no 
reason to continue in property reading.



> +		return -EINVAL;
> +	}
> +
> +	ret = of_property_read_u32(np, "xlnx,count-width", &width);
> +	if (ret == -EINVAL) {
> +		width = 32;
> +	} else if (ret) {
> +		pr_err("%pOF: err %d: xlnx,count-width\n", np, ret);
> +		return ret;
> +	} else if (width < 8 || width > 32) {
> +		pr_err("%pOF: invalid counter width\n", np);
> +		return -EINVAL;
> +	}
> +	priv->max = BIT_ULL(width) - 1;
> +
> +	return 0;
> +}
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
> +	struct xilinx_timer_priv *priv = xilinx_pwm_chip_to_priv(chip);
> +	u32 tlr0, tlr1, tcsr0, tcsr1;
> +	u64 period_cycles, duty_cycles;
> +	unsigned long rate;
> +
> +	if (state->polarity != PWM_POLARITY_NORMAL)
> +		return -EINVAL;
> +
> +	/*
> +	 * To be representable by TLR, cycles must be between 2 and
> +	 * priv->max + 2. To enforce this we can reduce the duty
> +	 * cycle, but we may not increase it.
> +	 */
> +	rate = clk_get_rate(priv->clk);
> +	/* Prevent overflow by clamping to the worst case of rate */
> +	period_cycles = min_t(u64, state->period, ULONG_MAX * NSEC_PER_SEC);
> +	period_cycles = mul_u64_u32_div(period_cycles, rate, NSEC_PER_SEC);
> +	if (period_cycles < 2 || period_cycles - 2 > priv->max)
> +		return -ERANGE;
> +	duty_cycles = mul_u64_u32_div(state->duty_cycle, rate, NSEC_PER_SEC);
> +
> +	/*
> +	 * If we specify 100% duty cycle, we will get 0% instead, so decrease
> +	 * the duty cycle count by one.
> +	 */
> +	if (period_cycles == duty_cycles)
> +		duty_cycles--;
> +
> +	/* Round down to 0% duty cycle for unrepresentable duty cycles */
> +	if (duty_cycles < 2)
> +		duty_cycles = period_cycles;
> +
> +	regmap_read(priv->map, TCSR0, &tcsr0);
> +	regmap_read(priv->map, TCSR1, &tcsr1);
> +	tlr0 = xilinx_timer_tlr_cycles(priv, tcsr0, period_cycles);
> +	tlr1 = xilinx_timer_tlr_cycles(priv, tcsr1, duty_cycles);
> +	regmap_write(priv->map, TLR0, tlr0);
> +	regmap_write(priv->map, TLR1, tlr1);
> +
> +	if (state->enabled) {
> +		/*
> +		 * If the PWM is already running, then the counters will be
> +		 * reloaded at the end of the current cycle.
> +		 */
> +		if (!xilinx_timer_pwm_enabled(tcsr0, tcsr1)) {
> +			/* Load TLR into TCR */
> +			regmap_write(priv->map, TCSR0, tcsr0 | TCSR_LOAD);
> +			regmap_write(priv->map, TCSR1, tcsr1 | TCSR_LOAD);
> +			/* Enable timers all at once with ENALL */
> +			tcsr0 = (TCSR_PWM_SET & ~TCSR_ENT) | (tcsr0 & TCSR_UDT);
> +			tcsr1 = TCSR_PWM_SET | TCSR_ENALL | (tcsr1 & TCSR_UDT);
> +			regmap_write(priv->map, TCSR0, tcsr0);
> +			regmap_write(priv->map, TCSR1, tcsr1);
> +		}
> +	} else {
> +		regmap_write(priv->map, TCSR0, 0);
> +		regmap_write(priv->map, TCSR1, 0);
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
> +	u32 tlr0, tlr1, tcsr0, tcsr1;
> +
> +	regmap_read(priv->map, TLR0, &tlr0);
> +	regmap_read(priv->map, TLR1, &tlr1);
> +	regmap_read(priv->map, TCSR0, &tcsr0);
> +	regmap_read(priv->map, TCSR1, &tcsr1);
> +	state->period = xilinx_timer_get_period(priv, tlr0, tcsr0);
> +	state->duty_cycle = xilinx_timer_get_period(priv, tlr1, tcsr1);
> +	state->enabled = xilinx_timer_pwm_enabled(tcsr0, tcsr1);
> +	state->polarity = PWM_POLARITY_NORMAL;
> +
> +	/* 100% duty cycle results in constant low output */
> +	if (state->period == state->duty_cycle)
> +		state->duty_cycle = 0;
> +}
> +
> +static const struct pwm_ops xilinx_pwm_ops = {
> +	.apply = xilinx_pwm_apply,
> +	.get_state = xilinx_pwm_get_state,
> +	.owner = THIS_MODULE,
> +};
> +
> +static const struct regmap_config xilinx_pwm_regmap_config = {
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.val_format_endian = REGMAP_ENDIAN_LITTLE,
> +	.max_register = TCR1,
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
> +	void __iomem *regs;
> +
> +	ret = of_property_read_u32(np, "#pwm-cells", &pwm_cells);
> +	if (ret == -EINVAL)
> +		return -ENODEV;
> +	else if (ret)

I would remove this else. It is at least for me easier to read.

> +		return dev_err_probe(dev, ret, "could not read #pwm-cells\n");
> +
> +	pwm = devm_kzalloc(dev, sizeof(*pwm), GFP_KERNEL);
> +	if (!pwm)
> +		return -ENOMEM;

newline

> +	platform_set_drvdata(pdev, pwm);
> +	priv = &pwm->priv;
> +
> +	regs = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(regs))
> +		return PTR_ERR(regs);
> +
> +	priv->map = devm_regmap_init_mmio(dev, regs,
> +					  &xilinx_pwm_regmap_config);
> +	if (IS_ERR(priv->map))
> +		return dev_err_probe(dev, PTR_ERR(priv->map),
> +				     "Could not create regmap\n");
> +
> +	ret = xilinx_timer_common_init(np, priv, &one_timer);
> +	if (ret)
> +		return ret;
> +
> +	if (one_timer)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Two timers required for PWM mode\n");

I would fail from above that this code is not needed.

> +
> +	/*
> +	 * The polarity of the generate outputs must be active high for PWM
> +	 * mode to work. We could determine this from the device tree, but
> +	 * alas, such properties are not allowed to be used.
> +	 */
> +
> +	priv->clk = devm_clk_get(dev, "s_axi_aclk");
> +	if (IS_ERR(priv->clk))
> +		return dev_err_probe(dev, PTR_ERR(priv->clk),
> +				     "Could not get clock\n");
> +
> +	ret = clk_prepare_enable(priv->clk);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Clock enable failed\n");
> +	clk_rate_exclusive_get(priv->clk);
> +
> +	pwm->chip.dev = dev;
> +	pwm->chip.ops = &xilinx_pwm_ops;
> +	pwm->chip.npwm = 1;
> +	ret = pwmchip_add(&pwm->chip);
> +	if (ret) {
> +		clk_rate_exclusive_put(priv->clk);
> +		clk_disable_unprepare(priv->clk);
> +		return dev_err_probe(dev, ret, "Could not register PWM chip\n");
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
> diff --git a/include/clocksource/timer-xilinx.h b/include/clocksource/timer-xilinx.h
> new file mode 100644
> index 000000000000..1f7757b84a5e
> --- /dev/null
> +++ b/include/clocksource/timer-xilinx.h
> @@ -0,0 +1,91 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (C) 2021 Sean Anderson <sean.anderson@seco.com>
> + */
> +
> +#ifndef XILINX_TIMER_H
> +#define XILINX_TIMER_H
> +
> +#include <linux/compiler.h>
> +
> +#define TCSR0	0x00
> +#define TLR0	0x04
> +#define TCR0	0x08
> +#define TCSR1	0x10
> +#define TLR1	0x14
> +#define TCR1	0x18
> +
> +#define TCSR_MDT	BIT(0)
> +#define TCSR_UDT	BIT(1)
> +#define TCSR_GENT	BIT(2)
> +#define TCSR_CAPT	BIT(3)
> +#define TCSR_ARHT	BIT(4)
> +#define TCSR_LOAD	BIT(5)
> +#define TCSR_ENIT	BIT(6)
> +#define TCSR_ENT	BIT(7)
> +#define TCSR_TINT	BIT(8)
> +#define TCSR_PWMA	BIT(9)
> +#define TCSR_ENALL	BIT(10)
> +#define TCSR_CASC	BIT(11)
> +
> +struct clk;
> +struct device_node;
> +struct regmap;
> +
> +/**
> + * struct xilinx_timer_priv - Private data for Xilinx AXI timer drivers
> + * @map: Regmap of the device, possibly with an offset
> + * @clk: Parent clock
> + * @max: Maximum value of the counters
> + */
> +struct xilinx_timer_priv {
> +	struct regmap *map;
> +	struct clk *clk;
> +	u32 max;
> +};
> +
> +/**
> + * xilinx_timer_tlr_cycles() - Calculate the TLR for a period specified
> + *                             in clock cycles
> + * @priv: The timer's private data
> + * @tcsr: The value of the TCSR register for this counter
> + * @cycles: The number of cycles in this period
> + *
> + * Callers of this function MUST ensure that @cycles is representable as
> + * a TLR.
> + *
> + * Return: The calculated value for TLR
> + */
> +u32 xilinx_timer_tlr_cycles(struct xilinx_timer_priv *priv, u32 tcsr,
> +			    u64 cycles);
> +
> +/**
> + * xilinx_timer_get_period() - Get the current period of a counter
> + * @priv: The timer's private data
> + * @tlr: The value of TLR for this counter
> + * @tcsr: The value of TCSR for this counter
> + *
> + * Return: The period, in ns
> + */
> +unsigned int xilinx_timer_get_period(struct xilinx_timer_priv *priv,
> +				     u32 tlr, u32 tcsr);
> +
> +/**
> + * xilinx_timer_common_init() - Perform common initialization for Xilinx
> + *                              AXI timer drivers.
> + * @priv: The timer's private data
> + * @np: The devicetree node for the timer
> + * @one_timer: Set to %1 if there is only one timer
> + *
> + * This performs common initialization, such as detecting endianness,
> + * and parsing devicetree properties. @priv->regs must be initialized
> + * before calling this function. This function initializes @priv->read,
> + * @priv->write, and @priv->width.
> + *
> + * Return: 0, or negative errno
> + */
> +int xilinx_timer_common_init(struct device_node *np,
> +			     struct xilinx_timer_priv *priv,
> +			     u32 *one_timer);
> +
> +#endif /* XILINX_TIMER_H */
> 

Thanks,
Michal
