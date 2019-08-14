Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7288D6CE
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Aug 2019 17:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbfHNPDK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 14 Aug 2019 11:03:10 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:53817 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfHNPDK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 14 Aug 2019 11:03:10 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hxunp-00088e-Ak; Wed, 14 Aug 2019 17:03:05 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hxuno-0000fe-8G; Wed, 14 Aug 2019 17:03:04 +0200
Date:   Wed, 14 Aug 2019 17:03:04 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        orsonzhai@gmail.com, zhang.lyra@gmail.com,
        vincent.guittot@linaro.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] pwm: sprd: Add Spreadtrum PWM support
Message-ID: <20190814150304.x44lalde3cwp67ge@pengutronix.de>
References: <65a34dd943b0260bfe45ec76dcf414a67e5d8343.1565785291.git.baolin.wang@linaro.org>
 <446eb284a096a1fd8998765669b1c9a2f78d7d22.1565785291.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <446eb284a096a1fd8998765669b1c9a2f78d7d22.1565785291.git.baolin.wang@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Aug 14, 2019 at 08:46:11PM +0800, Baolin Wang wrote:
> This patch adds the Spreadtrum PWM support, which provides maximum 4
> channels.
> 
> Signed-off-by: Neo Hou <neo.hou@unisoc.com>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
> Changes from v2:
>  - Optimize some macors' name.
>  - Improve some comments.
>  - Optimize the calculation of prescale.
>  - Do not print error log if error numeber is EPROBE_DEFER.
>  - Return -ENODEV if no available PWM channels.
>  - Simplify the logics in sprd_pwm_clk_init().
>  - Remove disabling PWM clocks in sprd_pwm_remove().
>  - Remove pwm_get_state().
> 
> Changes from v1:
>  - Add depending on HAS_IOMEM.
>  - Rename parameters' names.
>  - Implement .apply() instead of .config(), .enable() and .disable().
>  - Use NSEC_PER_SEC instead of 1000000000ULL.
>  - Add some comments to make code more readable.
>  - Remove some redundant operation.
>  - Use standard clock properties to set clock parent.
>  - Other coding style optimization.
> ---
>  drivers/pwm/Kconfig    |   11 ++
>  drivers/pwm/Makefile   |    1 +
>  drivers/pwm/pwm-sprd.c |  309 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 321 insertions(+)
>  create mode 100644 drivers/pwm/pwm-sprd.c
> 
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index a7e5751..31dfc88 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -423,6 +423,17 @@ config PWM_SPEAR
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-spear.
>  
> +config PWM_SPRD
> +	tristate "Spreadtrum PWM support"
> +	depends on ARCH_SPRD || COMPILE_TEST
> +	depends on HAS_IOMEM
> +	help
> +	  Generic PWM framework driver for the PWM controller on
> +	  Spreadtrum SoCs.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-sprd.
> +
>  config PWM_STI
>  	tristate "STiH4xx PWM support"
>  	depends on ARCH_STI
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 76b555b..26326ad 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -41,6 +41,7 @@ obj-$(CONFIG_PWM_ROCKCHIP)	+= pwm-rockchip.o
>  obj-$(CONFIG_PWM_SAMSUNG)	+= pwm-samsung.o
>  obj-$(CONFIG_PWM_SIFIVE)	+= pwm-sifive.o
>  obj-$(CONFIG_PWM_SPEAR)		+= pwm-spear.o
> +obj-$(CONFIG_PWM_SPRD)		+= pwm-sprd.o
>  obj-$(CONFIG_PWM_STI)		+= pwm-sti.o
>  obj-$(CONFIG_PWM_STM32)		+= pwm-stm32.o
>  obj-$(CONFIG_PWM_STM32_LP)	+= pwm-stm32-lp.o
> diff --git a/drivers/pwm/pwm-sprd.c b/drivers/pwm/pwm-sprd.c
> new file mode 100644
> index 0000000..68c2d9f
> --- /dev/null
> +++ b/drivers/pwm/pwm-sprd.c
> @@ -0,0 +1,309 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019 Spreadtrum Communications Inc.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/math64.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +
> +#define SPRD_PWM_PRESCALE	0x0
> +#define SPRD_PWM_MOD		0x4
> +#define SPRD_PWM_DUTY		0x8
> +#define SPRD_PWM_ENABLE		0x18
> +
> +#define SPRD_PWM_MOD_MAX	GENMASK(7, 0)
> +#define SPRD_PWM_DUTY_MSK	GENMASK(15, 0)
> +#define SPRD_PWM_PRESCALE_MSK	GENMASK(7, 0)
> +#define SPRD_PWM_ENABLE_BIT	BIT(0)
> +
> +#define SPRD_PWM_CHN_NUM	4
> +#define SPRD_PWM_REGS_SHIFT	5
> +#define SPRD_PWM_CHN_CLKS_NUM	2
> +#define SPRD_PWM_CHN_OUTPUT_CLK	1
> +
> +struct sprd_pwm_chn {
> +	struct clk_bulk_data clks[SPRD_PWM_CHN_CLKS_NUM];
> +	u32 clk_rate;
> +};
> +
> +struct sprd_pwm_chip {
> +	void __iomem *base;
> +	struct device *dev;
> +	struct pwm_chip chip;
> +	int num_pwms;
> +	struct sprd_pwm_chn chn[SPRD_PWM_CHN_NUM];
> +};
> +
> +/*
> + * The list of clocks required by PWM channels, and each channel has 2 clocks:
> + * enable clock and pwm clock.
> + */
> +static const char * const sprd_pwm_clks[] = {
> +	"enable0", "pwm0",
> +	"enable1", "pwm1",
> +	"enable2", "pwm2",
> +	"enable3", "pwm3",
> +};
> +
> +static u32 sprd_pwm_read(struct sprd_pwm_chip *spc, u32 hwid, u32 reg)
> +{
> +	u32 offset = reg + (hwid << SPRD_PWM_REGS_SHIFT);
> +
> +	return readl_relaxed(spc->base + offset);
> +}
> +
> +static void sprd_pwm_write(struct sprd_pwm_chip *spc, u32 hwid,
> +			   u32 reg, u32 val)
> +{
> +	u32 offset = reg + (hwid << SPRD_PWM_REGS_SHIFT);
> +
> +	writel_relaxed(val, spc->base + offset);
> +}
> +
> +static void sprd_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> +			       struct pwm_state *state)
> +{
> +	struct sprd_pwm_chip *spc =
> +		container_of(chip, struct sprd_pwm_chip, chip);
> +	struct sprd_pwm_chn *chn = &spc->chn[pwm->hwpwm];
> +	u32 val, duty, prescale;
> +	u64 tmp;
> +	int ret;
> +
> +	/*
> +	 * The clocks to PWM channel has to be enabled first before
> +	 * reading to the registers.
> +	 */
> +	ret = clk_bulk_prepare_enable(SPRD_PWM_CHN_CLKS_NUM, chn->clks);
> +	if (ret) {
> +		dev_err(spc->dev, "failed to enable pwm%u clocks\n",
> +			pwm->hwpwm);
> +		return;
> +	}
> +
> +	val = sprd_pwm_read(spc, pwm->hwpwm, SPRD_PWM_ENABLE);
> +	if (val & SPRD_PWM_ENABLE_BIT)
> +		state->enabled = true;
> +	else
> +		state->enabled = false;
> +
> +	/*
> +	 * The hardware provides a counter that is feed by the source clock.
> +	 * The period length is (PRESCALE + 1) * MOD counter steps.
> +	 * The duty cycle length is (PRESCALE + 1) * DUTY counter steps.
> +	 * Thus the period_ns and duty_ns calculation formula should be:
> +	 * period_ns = NSEC_PER_SEC * (prescale + 1) * mod / clk_rate
> +	 * duty_ns = NSEC_PER_SEC * (prescale + 1) * duty / clk_rate
> +	 */
> +	val = sprd_pwm_read(spc, pwm->hwpwm, SPRD_PWM_PRESCALE);
> +	prescale = val & SPRD_PWM_PRESCALE_MSK;
> +	tmp = (prescale + 1) * NSEC_PER_SEC * SPRD_PWM_MOD_MAX;
> +	state->period = DIV_ROUND_CLOSEST_ULL(tmp, chn->clk_rate);
> +
> +	val = sprd_pwm_read(spc, pwm->hwpwm, SPRD_PWM_DUTY);
> +	duty = val & SPRD_PWM_DUTY_MSK;
> +	tmp = (prescale + 1) * NSEC_PER_SEC * duty;
> +	state->duty_cycle = DIV_ROUND_CLOSEST_ULL(tmp, chn->clk_rate);
> +
> +	/* Disable PWM clocks if the PWM channel is not in enable state. */
> +	if (!state->enabled)
> +		clk_bulk_disable_unprepare(SPRD_PWM_CHN_CLKS_NUM, chn->clks);
> +}
> +
> +static int sprd_pwm_config(struct sprd_pwm_chip *spc, struct pwm_device *pwm,
> +			   int duty_ns, int period_ns)
> +{
> +	struct sprd_pwm_chn *chn = &spc->chn[pwm->hwpwm];
> +	u32 prescale, duty;
> +	u64 tmp;
> +
> +	/*
> +	 * The hardware provides a counter that is feed by the source clock.
> +	 * The period length is (PRESCALE + 1) * MOD counter steps.
> +	 * The duty cycle length is (PRESCALE + 1) * DUTY counter steps.
> +	 *
> +	 * To keep the maths simple we're always using MOD = SPRD_PWM_MOD_MAX.

Did you spend some thoughts about how wrong your period can get because
of that "lazyness"?

Let's assume a clk rate of 100/3 MHz. Then the available period lengths
are:

	PRESCALE =  0  ->  period =   7.65 µs
	PRESCALE =  1  ->  period =  15.30 µs
	...
	PRESCALE = 17  ->  period = 137.70 µs
	PRESCALE = 18  ->  period = 145.35 µs

So the error can be up to (nearly) 7.65 µs (or in general 
255 / clk_rate) because if 145.34 µs is requested you configure
PRESCALE = 17 and so yield a period of 137.70 µs. If however you'd pick
PRESCALE = 18 and MOD = 254 you get a period of 144.78 µs and so the
error is only 0.56 µs which is a factor of 13 better.

Hmm.

> +	 * The value for PRESCALE is selected such that the resulting period
> +	 * gets the maximal length not bigger than the requested one with the
> +	 * given settings (MOD = SPRD_PWM_MOD_MAX and input clock).
> +	 */
> +	duty = duty_ns * SPRD_PWM_MOD_MAX / period_ns;

I wonder if you loose some precision here as you use period_ns but might
actually implement a shorter period.

Quick example, again consider clk_rate = 100 / 3 MHz,
period_ns = 145340, duty_ns = 72670. Then you end up with

	PRESCALE = 17
	MOD = 255
	DUTY = 127

That corresponds to period_ns = 137700, duty_ns = 68580. With DUTY = 134
you get 72360 ns which is still smaller than the requested 72670 ns.
(But then again it is not obvious which of the two is the "better"
approximation because Thierry doesn't seem to see the necessity to
discuss or define a policy here.)

(And to pick up the thoughts about not using SPRD_PWM_MOD_MAX
unconditionally, you could also use

	PRESCALE = 18
	MOD = 254
	DUTY = 127

yielding period_ns = 144780 and duty_ns = 72390. Summary:

	Request:                 72670 / 145340
	your result:             68580 / 137700
	also possible:           72390 / 144780

Judge yourself.)

> +	tmp = (u64)chn->clk_rate * period_ns;
> +	do_div(tmp, NSEC_PER_SEC);
> +	prescale = DIV_ROUND_CLOSEST_ULL(tmp, SPRD_PWM_MOD_MAX) - 1;

Now that you use DIV_ROUND_CLOSEST_ULL the comment is wrong because you
might provide a period bigger than the requested one. Also you divide
twice instead of once before. (I don't know what architecture your SoC
uses, but compared to a multiplication a division is usually expensive.)
Also the math is more complicated now as you have a round-down div and a
round-closest div.

My preference for how to fix that is to restore the behaviour of v2 that
matches the comment and adapt .get_state() instead.

For .get_state() this should then be:

	val = sprd_pwm_read(spc, pwm->hwpwm, SPRD_PWM_PRESCALE);
	prescale = FIELD_GET(SPRD_PWM_PRESCALE_MSK, val);

	tmp = (prescale + 1) * NSEC_PER_SEC * SPRD_PWM_MOD_MAX;
	state->period = DIV_ROUND_UP_ULL(tmp, chn->clk_rate);

> +	if (prescale > SPRD_PWM_PRESCALE_MSK)
> +		prescale = SPRD_PWM_PRESCALE_MSK;
> +
> +	/*
> +	 * Note: Writing DUTY triggers the hardware to actually apply the
> +	 * values written to MOD and DUTY to the output, so must keep writing
> +	 * DUTY last.
> +	 *
> +	 * The hardware can ensures that current running period is completed
> +	 * before changing a new configuration to avoid mixed settings.

I'm not a native English speaker, but I would write:

	* The hardware ensures that currently running period is
	* completed before changing to the new configuration to avoid
	* mixed settings.

Does this mechanism also apply to PRESCALE? If yes, please include it in
your description. If not there is still a possibility for a wrong
period.

> +	 */
> +	sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_PRESCALE, prescale);
> +	sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_MOD, SPRD_PWM_MOD_MAX);
> +	sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_DUTY, duty);
> +
> +	return 0;
> +}

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
