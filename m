Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD01B8BCD5
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Aug 2019 17:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbfHMPQS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 13 Aug 2019 11:16:18 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:47649 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729580AbfHMPQS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 13 Aug 2019 11:16:18 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hxYWz-00036K-Pg; Tue, 13 Aug 2019 17:16:13 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hxYWy-0001bq-Jz; Tue, 13 Aug 2019 17:16:12 +0200
Date:   Tue, 13 Aug 2019 17:16:12 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        orsonzhai@gmail.com, zhang.lyra@gmail.com,
        vincent.guittot@linaro.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] pwm: sprd: Add Spreadtrum PWM support
Message-ID: <20190813151612.v6x6e6kzxflkpu7b@pengutronix.de>
References: <f9d2c7cb01cbf31bf75c4160611fa1d37d99f355.1565703607.git.baolin.wang@linaro.org>
 <4f6e3110b4d7e0a2f7ab317bba98a933de12e5da.1565703607.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4f6e3110b4d7e0a2f7ab317bba98a933de12e5da.1565703607.git.baolin.wang@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello,

On Tue, Aug 13, 2019 at 09:46:41PM +0800, Baolin Wang wrote:
> This patch adds the Spreadtrum PWM support, which provides maximum 4
> channels.
> 
> Signed-off-by: Neo Hou <neo.hou@unisoc.com>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
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
>  drivers/pwm/pwm-sprd.c |  307 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 319 insertions(+)
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
> index 0000000..067e711
> --- /dev/null
> +++ b/drivers/pwm/pwm-sprd.c
> @@ -0,0 +1,307 @@
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
> +#define SPRD_PWM_NUM		4
> +#define SPRD_PWM_REGS_SHIFT	5
> +#define SPRD_PWM_NUM_CLKS	2
> +#define SPRD_PWM_OUTPUT_CLK	1

These definitions could benefit from some explaining comments. Just from
looking at the names it is for example not obvious what is the
difference between SPRD_PWM_NUM and SPRD_PWM_NUM_CLKS is.

> +struct sprd_pwm_chn {
> +	struct clk_bulk_data clks[SPRD_PWM_NUM_CLKS];
> +	u32 clk_rate;
> +};
> +
> +struct sprd_pwm_chip {
> +	void __iomem *base;
> +	struct device *dev;
> +	struct pwm_chip chip;
> +	int num_pwms;
> +	struct sprd_pwm_chn chn[SPRD_PWM_NUM];
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
> +	ret = clk_bulk_prepare_enable(SPRD_PWM_NUM_CLKS, chn->clks);
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
> +		clk_bulk_disable_unprepare(SPRD_PWM_NUM_CLKS, chn->clks);
> +}
> +
> +static int sprd_pwm_config(struct sprd_pwm_chip *spc, struct pwm_device *pwm,
> +			   int duty_ns, int period_ns)
> +{
> +	struct sprd_pwm_chn *chn = &spc->chn[pwm->hwpwm];
> +	u64 div, tmp;
> +	u32 prescale, duty;
> +
> +	/*
> +	 * The hardware provides a counter that is feed by the source clock.
> +	 * The period length is (PRESCALE + 1) * MOD counter steps.
> +	 * The duty cycle length is (PRESCALE + 1) * DUTY counter steps.
> +	 *
> +	 * To keep the maths simple we're always using MOD = SPRD_PWM_MOD_MAX.
> +	 * The value for PRESCALE is selected such that the resulting period
> +	 * gets the maximal length not bigger than the requested one with the
> +	 * given settings (MOD = SPRD_PWM_MOD_MAX and input clock).
> +	 */
> +	duty = duty_ns * SPRD_PWM_MOD_MAX / period_ns;
> +
> +	tmp = (u64)chn->clk_rate * period_ns;
> +	div = NSEC_PER_SEC * SPRD_PWM_MOD_MAX;
> +	prescale = div64_u64(tmp, div) - 1;
> +	if (prescale > SPRD_PWM_PRESCALE_MSK)
> +		prescale = SPRD_PWM_PRESCALE_MSK;

This isn't the inverse of .get_state(). Consider:

	clk_rate = 3333333
	SPRD_PWM_PRESCALE = 15
	
then you calculate in .get_state():

	period = 1224000

If you then call apply with this value you calulate:

	prescale = 14

.

> +
> +	/*
> +	 * Note: The MOD must be configured before DUTY, and the hardware can
> +	 * ensure current running period is completed before changing a new
> +	 * configuration to avoid mixed settings.

You write "the hardware can ensure ..". Does that actually means "The
hardware ensures that ..." or is there some additional condition? Maybe
you mean:

	/*
	 * Writing DUTY triggers the hardware to actually apply the
	 * values written to MOD and DUTY to the output. So write DUTY
	 * last.
	 */

> +	sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_MOD, SPRD_PWM_MOD_MAX);
> +	sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_DUTY, duty);
> +	sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_PRESCALE, prescale);

If writing DUTY triggers the hardware to sample DUTY and MOD, what about
PRESCALE?

> +	return 0;
> +}
> +
> +static int sprd_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			  struct pwm_state *state)
> +{
> +	struct sprd_pwm_chip *spc =
> +		container_of(chip, struct sprd_pwm_chip, chip);
> +	struct sprd_pwm_chn *chn = &spc->chn[pwm->hwpwm];
> +	struct pwm_state cstate;
> +	int ret;
> +
> +	pwm_get_state(pwm, &cstate);

I don't like it when pwm drivers call pwm_get_state(). If ever
pwm_get_state would take a lock, this would deadlock as the lock is
probably already taken when your .apply() callback is running. Moreover
the (expensive) calculations are not used appropriately. See below.

> +	if (state->enabled) {
> +		if (!cstate.enabled) {

To just know the value of cstate.enabled you only need to read the
register with the ENABLE flag. That is cheaper than calling get_state.

> +			/*
> +			 * The clocks to PWM channel has to be enabled first
> +			 * before writing to the registers.
> +			 */
> +			ret = clk_bulk_prepare_enable(SPRD_PWM_NUM_CLKS,
> +						      chn->clks);
> +			if (ret) {
> +				dev_err(spc->dev,
> +					"failed to enable pwm%u clocks\n",
> +					pwm->hwpwm);
> +				return ret;
> +			}
> +		}
> +
> +		if (state->period != cstate.period ||
> +		    state->duty_cycle != cstate.duty_cycle) {

This is a coarse check. If state->period and cstate.period only differ
by one calling sprd_pwm_config(spc, pwm, state->duty_cycle,
state->period) probably results in a noop. So you're doing an expensive
division to get an unreliable check. It would be better to calculate the
register values from the requested state and compare the register
values. The costs are more or less the same than calling .get_state and
the check is reliable. And you don't need to spend another division to
calculate the new register values.

> +			ret = sprd_pwm_config(spc, pwm, state->duty_cycle,
> +					      state->period);
> +			if (ret)
> +				return ret;
> +		}
> +
> +		sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_ENABLE, 1);
> +	} else if (cstate.enabled) {
> +		sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_ENABLE, 0);
> +
> +		clk_bulk_disable_unprepare(SPRD_PWM_NUM_CLKS, chn->clks);

Assuming writing SPRD_PWM_ENABLE = 0 to the hardware completes the
currently running period and the write doesn't block that long: Does
disabling the clocks interfere with completing the period?

> +	}
> +
> +	return 0;
> +}
> +
> +static const struct pwm_ops sprd_pwm_ops = {
> +	.apply = sprd_pwm_apply,
> +	.get_state = sprd_pwm_get_state,
> +	.owner = THIS_MODULE,
> +};
> +
> +static int sprd_pwm_clk_init(struct sprd_pwm_chip *spc)
> +{
> +	struct clk *clk_pwm;
> +	int ret, i, clk_index = 0;
> +
> +	for (i = 0; i < SPRD_PWM_NUM; i++) {
> +		struct sprd_pwm_chn *chn = &spc->chn[i];
> +		int j;
> +
> +		for (j = 0; j < SPRD_PWM_NUM_CLKS; ++j)
> +			chn->clks[j].id = sprd_pwm_clks[clk_index++];

I think this would be more understandable when written as:

	for (j = 0; j < SPRD_PWM_NUM_CLKS; ++j)
		chn->clks[j].id = sprd_pwm_clks[i * SPRD_PWM_NUM_CLKS + j];

but I'm not sure I'm objective here.

> +
> +		ret = devm_clk_bulk_get(spc->dev, SPRD_PWM_NUM_CLKS, chn->clks);
> +		if (ret) {
> +			if (ret == -ENOENT)
> +				break;
> +
> +			dev_err(spc->dev, "failed to get channel clocks\n");

if ret == -EPROBE_DEFER you shouldn't issue an error message.

> +			return ret;
> +		}
> +
> +		clk_pwm = chn->clks[SPRD_PWM_OUTPUT_CLK].clk;
> +		chn->clk_rate = clk_get_rate(clk_pwm);
> +	}
> +
> +	if (!i) {
> +		dev_err(spc->dev, "no available PWM channels\n");
> +		return -EINVAL;

ENODEV?

> +	}
> +
> +	spc->num_pwms = i;
> +
> +	return 0;
> +}
> +
> +static int sprd_pwm_probe(struct platform_device *pdev)
> +{
> +	struct sprd_pwm_chip *spc;
> +	int ret;
> +
> +	spc = devm_kzalloc(&pdev->dev, sizeof(*spc), GFP_KERNEL);
> +	if (!spc)
> +		return -ENOMEM;
> +
> +	spc->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(spc->base))
> +		return PTR_ERR(spc->base);
> +
> +	spc->dev = &pdev->dev;
> +	platform_set_drvdata(pdev, spc);
> +
> +	ret = sprd_pwm_clk_init(spc);
> +	if (ret)
> +		return ret;
> +
> +	spc->chip.dev = &pdev->dev;
> +	spc->chip.ops = &sprd_pwm_ops;
> +	spc->chip.base = -1;
> +	spc->chip.npwm = spc->num_pwms;
> +
> +	ret = pwmchip_add(&spc->chip);
> +	if (ret)
> +		dev_err(&pdev->dev, "failed to add PWM chip\n");
> +
> +	return ret;
> +}
> +
> +static int sprd_pwm_remove(struct platform_device *pdev)
> +{
> +	struct sprd_pwm_chip *spc = platform_get_drvdata(pdev);
> +	int ret, i;
> +
> +	ret = pwmchip_remove(&spc->chip);
> +
> +	for (i = 0; i < spc->num_pwms; i++) {
> +		struct sprd_pwm_chn *chn = &spc->chn[i];
> +
> +		clk_bulk_disable_unprepare(SPRD_PWM_NUM_CLKS, chn->clks);

If a PWM was still running you're effectively stopping it here, right?
Are you sure you don't disable once more than you enabled?

> +	}
> +
> +	return ret;
> +}

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
