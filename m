Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05A803CB215
	for <lists+linux-pwm@lfdr.de>; Fri, 16 Jul 2021 07:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbhGPFyV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Fri, 16 Jul 2021 01:54:21 -0400
Received: from guitar.tcltek.co.il ([192.115.133.116]:54848 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234484AbhGPFyT (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 16 Jul 2021 01:54:19 -0400
Received: from tarshish (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id AF55144011A;
        Fri, 16 Jul 2021 08:51:15 +0300 (IDT)
References: <f79128fa287e37ee59cb03ae04b319ecb3d68c29.1626176145.git.baruch@tkos.co.il>
 <1173e7b0b58730fd187871d9e14a02cab85158cc.1626176145.git.baruch@tkos.co.il>
 <20210714201839.kfyqcyvowekc4ejs@pengutronix.de>
User-agent: mu4e 1.4.15; emacs 27.1
From:   Baruch Siach <baruch@tkos.co.il>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robert.marko@sartura.hr>,
        Kathiravan T <kathirav@codeaurora.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH v5 2/4] pwm: driver for qualcomm ipq6018 pwm block
In-reply-to: <20210714201839.kfyqcyvowekc4ejs@pengutronix.de>
Date:   Fri, 16 Jul 2021 08:51:20 +0300
Message-ID: <87eebyst5z.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

Thanks again for your detailed review.

I have a few comments and questions below.

On Wed, Jul 14 2021, Uwe Kleine-König wrote:
> On Tue, Jul 13, 2021 at 02:35:43PM +0300, Baruch Siach wrote:
>> --- /dev/null
>> +++ b/drivers/pwm/pwm-ipq.c
>> @@ -0,0 +1,278 @@
>> +// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
>> +/*
>> + * Copyright (c) 2016-2017, 2020 The Linux Foundation. All rights reserved.
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pwm.h>
>> +#include <linux/clk.h>
>> +#include <linux/io.h>
>> +#include <linux/math64.h>
>> +#include <linux/of_device.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/regmap.h>
>> +
>> +#define IPQ_PWM_MAX_DEVICES	4
>
> This is only used once. Just doing
>
> 	pwm->chip.npwm = 4;
>
> is better in my book. Does "MAX" suggest that there are variants with
> less PWMs?

I have no idea. I guess not. I'll drop this macro in v6.

>
>> +/* The frequency range supported is 1Hz to 100MHz */
>
> A space between number and unit is usual and makes this better readable.

Quick 'git grep' indicates that '[[:digit:]]\+MHz' is a little more
popular than '[[:digit:]]\+ MHz' in kernel code. But OK, not a big deal.

>> +#define IPQ_PWM_CLK_SRC_FREQ	(100*1000*1000)
>> +#define IPQ_PWM_MIN_PERIOD_NS	(NSEC_PER_SEC / IPQ_PWM_CLK_SRC_FREQ)
>
> You're assuming here that the parent clock runs at exactly the set rate.
> Is this a sensible assumption? If this division didn't have an integer
> result there would be rounding issues.

The code only uses this for period validity check. It saves us some code
for run-time division.

>> +#define IPQ_PWM_MAX_PERIOD_NS	((u64)NSEC_PER_SEC)
>> +
>> +/*
>> + * The max value specified for each field is based on the number of bits
>> + * in the pwm control register for that field
>> + */
>> +#define IPQ_PWM_MAX_DIV		0xFFFF
>> +
>> +#define IPQ_PWM_CFG_REG0 0 /*PWM_DIV PWM_HI*/
>> +#define IPQ_PWM_REG0_PWM_DIV		GENMASK(15, 0)
>> +#define IPQ_PWM_REG0_HI_DURATION	GENMASK(31, 16)
>> +
>> +#define IPQ_PWM_CFG_REG1 1 /*ENABLE UPDATE PWM_PRE_DIV*/
>> +#define IPQ_PWM_REG1_PRE_DIV		GENMASK(15, 0)
>> +/*
>> + * Enable bit is set to enable output toggling in pwm device.
>> + * Update bit is set to reflect the changed divider and high duration
>> + * values in register.
>> + */
>> +#define IPQ_PWM_REG1_UPDATE		BIT(30)
>> +#define IPQ_PWM_REG1_ENABLE		BIT(31)
>> +
>> +
>> +struct ipq_pwm_chip {
>> +	struct pwm_chip chip;
>> +	struct clk *clk;
>> +	struct regmap *regmap;
>> +	u32 regmap_off;
>> +};
>> +
>> +static struct ipq_pwm_chip *to_ipq_pwm_chip(struct pwm_chip *chip)
>> +{
>> +	return container_of(chip, struct ipq_pwm_chip, chip);
>> +}
>> +
>> +static unsigned ipq_pwm_reg_offset(struct pwm_device *pwm, unsigned reg)
>> +{
>> +	return ((pwm->hwpwm * 2) + reg) * 4;
>> +}
>> +
>> +static unsigned int ipq_pwm_reg_read(struct pwm_device *pwm, unsigned reg)
>> +{
>> +	struct ipq_pwm_chip *ipq_chip = to_ipq_pwm_chip(pwm->chip);
>> +	unsigned int off = ipq_chip->regmap_off + ipq_pwm_reg_offset(pwm, reg);
>
> I already stumbled about this in v4 but thought I'd let you do it. As
> I stumbled again I'll say something now:
>
> I would do the register stuff as follows:
>
> 	/* Each PWM has two registers, the offset for PWM #i is at 8 * #i */
> 	#define IPQ_PWM_CFG_REG0	0
> 	#define IPQ_PWM_CFG_REG1	4
>
> and then do:
>
> 	static unsigned int ipq_pwm_reg_read(struct pwm_device *pwm, unsigned reg)
> 	{
> 		struct ipq_pwm_chip *ipq_chip = to_ipq_pwm_chip(pwm->chip);
> 		unsigned int off = ipq_chip->regmap_off + 8 * pwm->hwpwm + reg;
>
> 		...
>
> this is a bit easier to understand IMHO, but might be subjective. I let
> you decide if you want to change that or stay with your approach.
>
>> +	unsigned int val;
>> +
>> +	regmap_read(ipq_chip->regmap, off, &val);
>> +
>> +	return val;
>> +}
>> +
>> +static void ipq_pwm_reg_write(struct pwm_device *pwm, unsigned reg,
>> +		unsigned val)
>> +{
>> +	struct ipq_pwm_chip *ipq_chip = to_ipq_pwm_chip(pwm->chip);
>> +	unsigned int off = ipq_chip->regmap_off + ipq_pwm_reg_offset(pwm, reg);
>> +
>> +	regmap_write(ipq_chip->regmap, off, val);
>> +}
>> +
>> +static void config_div_and_duty(struct pwm_device *pwm, unsigned int pre_div,
>> +			unsigned int pwm_div, u64 period_ns, u64 duty_ns,
>> +			bool enable)
>> +{
>> +	unsigned long hi_dur;
>> +	unsigned long long quotient;
>> +	unsigned long val = 0;
>> +
>> +	/*
>> +	 * high duration = pwm duty * (pwm div + 1)
>> +	 * pwm duty = duty_ns / period_ns
>> +	 */
>> +	quotient = (pwm_div + 1) * duty_ns;
>> +	hi_dur = div64_u64(quotient, period_ns);
>
> this division should use the actual period, not the target period.
> Otherwise the result might be to small.
>
>> +	val = FIELD_PREP(IPQ_PWM_REG0_HI_DURATION, hi_dur) |
>> +		FIELD_PREP(IPQ_PWM_REG0_PWM_DIV, pwm_div);
>> +	ipq_pwm_reg_write(pwm, IPQ_PWM_CFG_REG0, val);
>> +
>> +	val = FIELD_PREP(IPQ_PWM_REG1_PRE_DIV, pre_div);
>> +	ipq_pwm_reg_write(pwm, IPQ_PWM_CFG_REG1, val);
>> +
>> +	/* Enable needs a separate write to REG1 */
>> +	val |= IPQ_PWM_REG1_UPDATE;
>
> Setting this bit results in the two writes above being configured
> atomically so that no mixed settings happen to the output, right?

I guess so. I have no access to hardware documentation, mind you. I
first tried to do only one write to REG1, but it had no effect. The
existence of the UPDATE bit also indicates that hardware works as you
suggest.

> Does the hardware complete the currently running cycle on
> reconfiguration?

No idea.

>> +	if (enable)
>> +		val |= IPQ_PWM_REG1_ENABLE;
>> +	else
>> +		val &= ~IPQ_PWM_REG1_ENABLE;
>
> The else branch has no effect as val is initialized as zero above, so
> please drop it.
>
>> +	ipq_pwm_reg_write(pwm, IPQ_PWM_CFG_REG1, val);
>
> How does the hardware behave with the ENABLE bit unset? Does it drive
> the pin to zero?

Yes. That's what experimentation here shows. The pin is pulled up, but
the PWM keeps it low.

>> +}
>> +
>> +static int ipq_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>> +			 const struct pwm_state *state)
>> +{
>> +	struct ipq_pwm_chip *ipq_chip = to_ipq_pwm_chip(chip);
>> +	unsigned long freq;
>> +	unsigned int pre_div, pwm_div, close_pre_div, close_pwm_div;
>> +	long long diff;
>> +	unsigned long rate = clk_get_rate(ipq_chip->clk);
>> +	unsigned long min_diff = rate;
>> +	uint64_t fin_ps;
>> +	u64 period_ns, duty_ns;
>
> You have to refuse the request if state->polarity !=
> PWM_POLARITY_NORMAL.
>
>> +
>> +	if (state->period < IPQ_PWM_MIN_PERIOD_NS)
>
> It's strange that you assume here the hardcoded 100 MHz but below you
> use clk_get_rate(ipq_chip->clk).

As I said above, this is meant to save code for the less critical
case. Should I use clk_get_rate() here as well? If we go with
assigned-clock-rates, as you suggest below, we'll have to do that
anyway.

>
>> +		return -ERANGE;
>> +
>> +	period_ns = min(state->period, IPQ_PWM_MAX_PERIOD_NS);
>> +	duty_ns = min(state->duty_cycle, period_ns);
>> +
>> +	/* freq in Hz for period in nano second */
>> +	freq = div64_u64(NSEC_PER_SEC, period_ns);
>> +	fin_ps = div64_u64(NSEC_PER_SEC * 1000ULL, rate);
>
> I don't understand that factor 1000. This just cancels with the 1000 in
> the calculation of pwm_div below?! Maybe this is to soften the precision
> loss?

That is my understanding of the code intent.

>> +	close_pre_div = IPQ_PWM_MAX_DIV;
>> +	close_pwm_div = IPQ_PWM_MAX_DIV;
>> +
>> +	for (pre_div = 0; pre_div <= IPQ_PWM_MAX_DIV; pre_div++) {
>> +		pwm_div = DIV64_U64_ROUND_CLOSEST(period_ns * 1000,
>> +						  fin_ps * (pre_div + 1));
>
> Having fin_ps in the divisor results in loss of precision. When ever the
> closest rounding division rounds down diff becomes negative below. So
> you should round up here.
>
> Also if you do:
>
> 	pwm_div = round_up((period_ns * rate) / (NSEC_PER_SEC * (pre_div + 1)))
>
> there is no relevant loss of precision. (You might have to care for
> period_ns * rate overflowing though or argue why it doesn't overflow.)

Looks better.

>
>> +		pwm_div--;
>> +		if (pwm_div > IPQ_PWM_MAX_DIV)
>> +			continue;
>
> This check can be dropped if the loop (depending on the other parameters)
> does not start with pre_div = 0 but some bigger number.

That is, calculate the minimum pre_div value for which the division
above always produces pwm_div in range, right?

>
>> +		diff = ((uint64_t)freq * (pre_div + 1) * (pwm_div + 1))
>> +			- (uint64_t)rate;
>> +
>> +		if (diff < 0) /* period larger than requested */
>> +			continue;
>> +		if (diff == 0) { /* bingo */
>> +			close_pre_div = pre_div;
>> +			close_pwm_div = pwm_div;
>> +			break;
>> +		}
>> +		if (diff < min_diff) {
>> +			min_diff = diff;
>> +			close_pre_div = pre_div;
>> +			close_pwm_div = pwm_div;
>
> I would call these best_..._div, not close_..._div which makes the
> purpose clearer.
>
> A big pre_div results in a coarse resolution for duty_cycle. This makes
> other similar drivers chose to hardcode pwm_div to its max value. At
> least you should ensure that pre_div <= pwm_div.
>
>> +		}
>> +	}
>> +
>> +	/* config divider values for the closest possible frequency */
>> +	config_div_and_duty(pwm, close_pre_div, close_pwm_div,
>> +			    period_ns, duty_ns, state->enabled);
>> +
>> +	return 0;
>> +}
>> +
>> +static void ipq_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>> +			      struct pwm_state *state)
>> +{
>> +	struct ipq_pwm_chip *ipq_chip = to_ipq_pwm_chip(chip);
>> +	unsigned long rate = clk_get_rate(ipq_chip->clk);
>> +	unsigned int pre_div, pwm_div, hi_dur;
>> +	u64 effective_div, hi_div;
>> +	u32 reg0, reg1;
>> +
>> +	reg0 = ipq_pwm_reg_read(pwm, IPQ_PWM_CFG_REG0);
>> +	reg1 = ipq_pwm_reg_read(pwm, IPQ_PWM_CFG_REG1);
>> +
>> +	state->polarity = PWM_POLARITY_NORMAL;
>> +	state->enabled = reg1 & IPQ_PWM_REG1_ENABLE;
>> +
>> +	pwm_div = FIELD_GET(IPQ_PWM_REG0_PWM_DIV, reg0);
>> +	hi_dur = FIELD_GET(IPQ_PWM_REG0_HI_DURATION, reg0);
>> +	pre_div = FIELD_GET(IPQ_PWM_REG1_PRE_DIV, reg1);
>> +	effective_div = (pre_div + 1) * (pwm_div + 1);
>
> Please add a comment here that with pre_div and pwm_div <= 0xffff the
> multiplication below doesn't overflow
>
>> +	state->period = div64_u64(effective_div * NSEC_PER_SEC, rate);
>> +
>> +	hi_div = hi_dur * (pre_div + 1);
>
> This suggests that the hardware cannot do 100% relative duty cycle if
> pwm_div == 0xffff? I suggest to clamp pwm_div to 0xfffe then.

What is "100% relative duty"? How does pwm_div clamping helps?

>> +	state->duty_cycle = div64_u64(hi_div * NSEC_PER_SEC, rate);
>> +}
>> +
>> +static struct pwm_ops ipq_pwm_ops = {
>
> const please
>
>> +	.apply = ipq_pwm_apply,
>> +	.get_state = ipq_pwm_get_state,
>> +	.owner = THIS_MODULE,
>> +};
>> +
>> +static int ipq_pwm_probe(struct platform_device *pdev)
>> +{
>> +	struct ipq_pwm_chip *pwm;
>> +	struct device *dev = &pdev->dev;
>> +	struct of_phandle_args args;
>> +	int ret;
>> +
>> +	pwm = devm_kzalloc(dev, sizeof(*pwm), GFP_KERNEL);
>> +	if (!pwm)
>> +		return -ENOMEM;
>> +
>> +	platform_set_drvdata(pdev, pwm);
>> +
>> +	ret = of_parse_phandle_with_fixed_args(dev->of_node, "qcom,pwm-regs",
>> +			1, 0, &args);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "regs parse failed");
>> +
>> +	pwm->regmap = syscon_node_to_regmap(args.np);
>> +	of_node_put(args.np);
>> +	if (IS_ERR(pwm->regmap))
>> +		return dev_err_probe(dev, PTR_ERR(pwm->regmap),
>> +				"regs map failed");
>> +	pwm->regmap_off = args.args[0];
>
> Does this have to be so complicated? Why doesn't the normal approach
> with the pwm being a child of the syscon device and reg = <...> work
> here?

I'll do that in v6. That's what Bjorn originally suggested in response
to v2.

>
>> +	pwm->clk = devm_clk_get(dev, "core");
>> +	if (IS_ERR(pwm->clk))
>> +		return dev_err_probe(dev, PTR_ERR(pwm->clk),
>> +				"failed to get core clock");
>> +
>> +	ret = clk_set_rate(pwm->clk, IPQ_PWM_CLK_SRC_FREQ);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "clock rate set failed");
>
> Would it make more sense to set this in the device tree using
> assigned-clock-rate?

That's 'assigned-clock-rates' I believe. I'll try that.

>
>> +	ret = clk_prepare_enable(pwm->clk);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "clock enable failed");
>> +
>> +	pwm->chip.dev = dev;
>> +	pwm->chip.ops = &ipq_pwm_ops;
>> +	pwm->chip.npwm = IPQ_PWM_MAX_DEVICES;
>> +
>> +	ret = pwmchip_add(&pwm->chip);
>> +	if (ret < 0) {
>> +		dev_err_probe(dev, ret, "pwmchip_add() failed\n");
>> +		clk_disable_unprepare(pwm->clk);
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int ipq_pwm_remove(struct platform_device *pdev)
>> +{
>> +	struct ipq_pwm_chip *pwm = platform_get_drvdata(pdev);
>> +
>> +	clk_disable_unprepare(pwm->clk);
>> +	pwmchip_remove(&pwm->chip);
>
> This is the wrong order. Until pwmchip_remove() returns the PWM must stay
> functional, so disable the clock only after pwmchip_remove().
>
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id pwm_ipq_dt_match[] = {
>> +	{ .compatible = "qcom,ipq6018-pwm", },
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(of, pwm_ipq_dt_match);
>> +
>> +static struct platform_driver ipq_pwm_driver = {
>> +	.driver = {
>> +		.name = "ipq-pwm",
>> +		.of_match_table = pwm_ipq_dt_match,
>> +	},
>> +	.probe = ipq_pwm_probe,
>> +	.remove = ipq_pwm_remove,
>> +};
>> +
>> +module_platform_driver(ipq_pwm_driver);
>> +
>> +MODULE_LICENSE("Dual BSD/GPL");
>
> Best regards
> Uwe


-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
