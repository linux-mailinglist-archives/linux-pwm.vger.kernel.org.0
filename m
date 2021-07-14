Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB1063C91F2
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Jul 2021 22:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238171AbhGNUWF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 14 Jul 2021 16:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238078AbhGNUWE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 14 Jul 2021 16:22:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586B3C06175F
        for <linux-pwm@vger.kernel.org>; Wed, 14 Jul 2021 13:19:12 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m3lLQ-0004qF-Ts; Wed, 14 Jul 2021 22:19:01 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m3lLO-0007bw-CK; Wed, 14 Jul 2021 22:18:58 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m3lLO-0005Y2-Al; Wed, 14 Jul 2021 22:18:58 +0200
Date:   Wed, 14 Jul 2021 22:18:39 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Baruch Siach <baruch@tkos.co.il>
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
Message-ID: <20210714201839.kfyqcyvowekc4ejs@pengutronix.de>
References: <f79128fa287e37ee59cb03ae04b319ecb3d68c29.1626176145.git.baruch@tkos.co.il>
 <1173e7b0b58730fd187871d9e14a02cab85158cc.1626176145.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6yqo25hmihcjtfki"
Content-Disposition: inline
In-Reply-To: <1173e7b0b58730fd187871d9e14a02cab85158cc.1626176145.git.baruch@tkos.co.il>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--6yqo25hmihcjtfki
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Baruch,

On Tue, Jul 13, 2021 at 02:35:43PM +0300, Baruch Siach wrote:
> --- /dev/null
> +++ b/drivers/pwm/pwm-ipq.c
> @@ -0,0 +1,278 @@
> +// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
> +/*
> + * Copyright (c) 2016-2017, 2020 The Linux Foundation. All rights reserv=
ed.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/math64.h>
> +#include <linux/of_device.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/regmap.h>
> +
> +#define IPQ_PWM_MAX_DEVICES	4

This is only used once. Just doing

	pwm->chip.npwm =3D 4;

is better in my book. Does "MAX" suggest that there are variants with
less PWMs?

> +/* The frequency range supported is 1Hz to 100MHz */

A space between number and unit is usual and makes this better readable.

> +#define IPQ_PWM_CLK_SRC_FREQ	(100*1000*1000)
> +#define IPQ_PWM_MIN_PERIOD_NS	(NSEC_PER_SEC / IPQ_PWM_CLK_SRC_FREQ)

You're assuming here that the parent clock runs at exactly the set rate.
Is this a sensible assumption? If this division didn't have an integer
result there would be rounding issues.

> +#define IPQ_PWM_MAX_PERIOD_NS	((u64)NSEC_PER_SEC)
> +
> +/*
> + * The max value specified for each field is based on the number of bits
> + * in the pwm control register for that field
> + */
> +#define IPQ_PWM_MAX_DIV		0xFFFF
> +
> +#define IPQ_PWM_CFG_REG0 0 /*PWM_DIV PWM_HI*/
> +#define IPQ_PWM_REG0_PWM_DIV		GENMASK(15, 0)
> +#define IPQ_PWM_REG0_HI_DURATION	GENMASK(31, 16)
> +
> +#define IPQ_PWM_CFG_REG1 1 /*ENABLE UPDATE PWM_PRE_DIV*/
> +#define IPQ_PWM_REG1_PRE_DIV		GENMASK(15, 0)
> +/*
> + * Enable bit is set to enable output toggling in pwm device.
> + * Update bit is set to reflect the changed divider and high duration
> + * values in register.
> + */
> +#define IPQ_PWM_REG1_UPDATE		BIT(30)
> +#define IPQ_PWM_REG1_ENABLE		BIT(31)
> +
> +
> +struct ipq_pwm_chip {
> +	struct pwm_chip chip;
> +	struct clk *clk;
> +	struct regmap *regmap;
> +	u32 regmap_off;
> +};
> +
> +static struct ipq_pwm_chip *to_ipq_pwm_chip(struct pwm_chip *chip)
> +{
> +	return container_of(chip, struct ipq_pwm_chip, chip);
> +}
> +
> +static unsigned ipq_pwm_reg_offset(struct pwm_device *pwm, unsigned reg)
> +{
> +	return ((pwm->hwpwm * 2) + reg) * 4;
> +}
> +
> +static unsigned int ipq_pwm_reg_read(struct pwm_device *pwm, unsigned re=
g)
> +{
> +	struct ipq_pwm_chip *ipq_chip =3D to_ipq_pwm_chip(pwm->chip);
> +	unsigned int off =3D ipq_chip->regmap_off + ipq_pwm_reg_offset(pwm, reg=
);

I already stumbled about this in v4 but thought I'd let you do it. As
I stumbled again I'll say something now:

I would do the register stuff as follows:

	/* Each PWM has two registers, the offset for PWM #i is at 8 * #i */
	#define IPQ_PWM_CFG_REG0	0
	#define IPQ_PWM_CFG_REG1	4

and then do:

	static unsigned int ipq_pwm_reg_read(struct pwm_device *pwm, unsigned reg)
	{
		struct ipq_pwm_chip *ipq_chip =3D to_ipq_pwm_chip(pwm->chip);
		unsigned int off =3D ipq_chip->regmap_off + 8 * pwm->hwpwm + reg;

		...

this is a bit easier to understand IMHO, but might be subjective. I let
you decide if you want to change that or stay with your approach.

> +	unsigned int val;
> +
> +	regmap_read(ipq_chip->regmap, off, &val);
> +
> +	return val;
> +}
> +
> +static void ipq_pwm_reg_write(struct pwm_device *pwm, unsigned reg,
> +		unsigned val)
> +{
> +	struct ipq_pwm_chip *ipq_chip =3D to_ipq_pwm_chip(pwm->chip);
> +	unsigned int off =3D ipq_chip->regmap_off + ipq_pwm_reg_offset(pwm, reg=
);
> +
> +	regmap_write(ipq_chip->regmap, off, val);
> +}
> +
> +static void config_div_and_duty(struct pwm_device *pwm, unsigned int pre=
_div,
> +			unsigned int pwm_div, u64 period_ns, u64 duty_ns,
> +			bool enable)
> +{
> +	unsigned long hi_dur;
> +	unsigned long long quotient;
> +	unsigned long val =3D 0;
> +
> +	/*
> +	 * high duration =3D pwm duty * (pwm div + 1)
> +	 * pwm duty =3D duty_ns / period_ns
> +	 */
> +	quotient =3D (pwm_div + 1) * duty_ns;
> +	hi_dur =3D div64_u64(quotient, period_ns);

this division should use the actual period, not the target period.
Otherwise the result might be to small.

> +	val =3D FIELD_PREP(IPQ_PWM_REG0_HI_DURATION, hi_dur) |
> +		FIELD_PREP(IPQ_PWM_REG0_PWM_DIV, pwm_div);
> +	ipq_pwm_reg_write(pwm, IPQ_PWM_CFG_REG0, val);
> +
> +	val =3D FIELD_PREP(IPQ_PWM_REG1_PRE_DIV, pre_div);
> +	ipq_pwm_reg_write(pwm, IPQ_PWM_CFG_REG1, val);
> +
> +	/* Enable needs a separate write to REG1 */
> +	val |=3D IPQ_PWM_REG1_UPDATE;

Setting this bit results in the two writes above being configured
atomically so that no mixed settings happen to the output, right?

Does the hardware complete the currently running cycle on
reconfiguration?

> +	if (enable)
> +		val |=3D IPQ_PWM_REG1_ENABLE;
> +	else
> +		val &=3D ~IPQ_PWM_REG1_ENABLE;

The else branch has no effect as val is initialized as zero above, so
please drop it.

> +	ipq_pwm_reg_write(pwm, IPQ_PWM_CFG_REG1, val);

How does the hardware behave with the ENABLE bit unset? Does it drive
the pin to zero?

> +}
> +
> +static int ipq_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			 const struct pwm_state *state)
> +{
> +	struct ipq_pwm_chip *ipq_chip =3D to_ipq_pwm_chip(chip);
> +	unsigned long freq;
> +	unsigned int pre_div, pwm_div, close_pre_div, close_pwm_div;
> +	long long diff;
> +	unsigned long rate =3D clk_get_rate(ipq_chip->clk);
> +	unsigned long min_diff =3D rate;
> +	uint64_t fin_ps;
> +	u64 period_ns, duty_ns;

You have to refuse the request if state->polarity !=3D
PWM_POLARITY_NORMAL.

> +
> +	if (state->period < IPQ_PWM_MIN_PERIOD_NS)

It's strange that you assume here the hardcoded 100 MHz but below you
use clk_get_rate(ipq_chip->clk).

> +		return -ERANGE;
> +
> +	period_ns =3D min(state->period, IPQ_PWM_MAX_PERIOD_NS);
> +	duty_ns =3D min(state->duty_cycle, period_ns);
> +
> +	/* freq in Hz for period in nano second */
> +	freq =3D div64_u64(NSEC_PER_SEC, period_ns);
> +	fin_ps =3D div64_u64(NSEC_PER_SEC * 1000ULL, rate);

I don't understand that factor 1000. This just cancels with the 1000 in
the calculation of pwm_div below?! Maybe this is to soften the precision
loss?

> +	close_pre_div =3D IPQ_PWM_MAX_DIV;
> +	close_pwm_div =3D IPQ_PWM_MAX_DIV;
> +
> +	for (pre_div =3D 0; pre_div <=3D IPQ_PWM_MAX_DIV; pre_div++) {
> +		pwm_div =3D DIV64_U64_ROUND_CLOSEST(period_ns * 1000,
> +						  fin_ps * (pre_div + 1));

Having fin_ps in the divisor results in loss of precision. When ever the
closest rounding division rounds down diff becomes negative below. So
you should round up here.

Also if you do:

	pwm_div =3D round_up((period_ns * rate) / (NSEC_PER_SEC * (pre_div + 1)))

there is no relevant loss of precision. (You might have to care for
period_ns * rate overflowing though or argue why it doesn't overflow.)

> +		pwm_div--;
> +		if (pwm_div > IPQ_PWM_MAX_DIV)
> +			continue;

This check can be dropped if the loop (depending on the other parameters)
does not start with pre_div =3D 0 but some bigger number.

> +		diff =3D ((uint64_t)freq * (pre_div + 1) * (pwm_div + 1))
> +			- (uint64_t)rate;
> +
> +		if (diff < 0) /* period larger than requested */
> +			continue;
> +		if (diff =3D=3D 0) { /* bingo */
> +			close_pre_div =3D pre_div;
> +			close_pwm_div =3D pwm_div;
> +			break;
> +		}
> +		if (diff < min_diff) {
> +			min_diff =3D diff;
> +			close_pre_div =3D pre_div;
> +			close_pwm_div =3D pwm_div;

I would call these best_..._div, not close_..._div which makes the
purpose clearer.

A big pre_div results in a coarse resolution for duty_cycle. This makes
other similar drivers chose to hardcode pwm_div to its max value. At
least you should ensure that pre_div <=3D pwm_div.

> +		}
> +	}
> +
> +	/* config divider values for the closest possible frequency */
> +	config_div_and_duty(pwm, close_pre_div, close_pwm_div,
> +			    period_ns, duty_ns, state->enabled);
> +
> +	return 0;
> +}
> +
> +static void ipq_pwm_get_state(struct pwm_chip *chip, struct pwm_device *=
pwm,
> +			      struct pwm_state *state)
> +{
> +	struct ipq_pwm_chip *ipq_chip =3D to_ipq_pwm_chip(chip);
> +	unsigned long rate =3D clk_get_rate(ipq_chip->clk);
> +	unsigned int pre_div, pwm_div, hi_dur;
> +	u64 effective_div, hi_div;
> +	u32 reg0, reg1;
> +
> +	reg0 =3D ipq_pwm_reg_read(pwm, IPQ_PWM_CFG_REG0);
> +	reg1 =3D ipq_pwm_reg_read(pwm, IPQ_PWM_CFG_REG1);
> +
> +	state->polarity =3D PWM_POLARITY_NORMAL;
> +	state->enabled =3D reg1 & IPQ_PWM_REG1_ENABLE;
> +
> +	pwm_div =3D FIELD_GET(IPQ_PWM_REG0_PWM_DIV, reg0);
> +	hi_dur =3D FIELD_GET(IPQ_PWM_REG0_HI_DURATION, reg0);
> +	pre_div =3D FIELD_GET(IPQ_PWM_REG1_PRE_DIV, reg1);
> +	effective_div =3D (pre_div + 1) * (pwm_div + 1);

Please add a comment here that with pre_div and pwm_div <=3D 0xffff the
multiplication below doesn't overflow

> +	state->period =3D div64_u64(effective_div * NSEC_PER_SEC, rate);
> +
> +	hi_div =3D hi_dur * (pre_div + 1);

This suggests that the hardware cannot do 100% relative duty cycle if
pwm_div =3D=3D 0xffff? I suggest to clamp pwm_div to 0xfffe then.

> +	state->duty_cycle =3D div64_u64(hi_div * NSEC_PER_SEC, rate);
> +}
> +
> +static struct pwm_ops ipq_pwm_ops =3D {

const please

> +	.apply =3D ipq_pwm_apply,
> +	.get_state =3D ipq_pwm_get_state,
> +	.owner =3D THIS_MODULE,
> +};
> +
> +static int ipq_pwm_probe(struct platform_device *pdev)
> +{
> +	struct ipq_pwm_chip *pwm;
> +	struct device *dev =3D &pdev->dev;
> +	struct of_phandle_args args;
> +	int ret;
> +
> +	pwm =3D devm_kzalloc(dev, sizeof(*pwm), GFP_KERNEL);
> +	if (!pwm)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, pwm);
> +
> +	ret =3D of_parse_phandle_with_fixed_args(dev->of_node, "qcom,pwm-regs",
> +			1, 0, &args);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "regs parse failed");
> +
> +	pwm->regmap =3D syscon_node_to_regmap(args.np);
> +	of_node_put(args.np);
> +	if (IS_ERR(pwm->regmap))
> +		return dev_err_probe(dev, PTR_ERR(pwm->regmap),
> +				"regs map failed");
> +	pwm->regmap_off =3D args.args[0];

Does this have to be so complicated? Why doesn't the normal approach
with the pwm being a child of the syscon device and reg =3D <...> work
here?

> +	pwm->clk =3D devm_clk_get(dev, "core");
> +	if (IS_ERR(pwm->clk))
> +		return dev_err_probe(dev, PTR_ERR(pwm->clk),
> +				"failed to get core clock");
> +
> +	ret =3D clk_set_rate(pwm->clk, IPQ_PWM_CLK_SRC_FREQ);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "clock rate set failed");

Would it make more sense to set this in the device tree using
assigned-clock-rate?

> +	ret =3D clk_prepare_enable(pwm->clk);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "clock enable failed");
> +
> +	pwm->chip.dev =3D dev;
> +	pwm->chip.ops =3D &ipq_pwm_ops;
> +	pwm->chip.npwm =3D IPQ_PWM_MAX_DEVICES;
> +
> +	ret =3D pwmchip_add(&pwm->chip);
> +	if (ret < 0) {
> +		dev_err_probe(dev, ret, "pwmchip_add() failed\n");
> +		clk_disable_unprepare(pwm->clk);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ipq_pwm_remove(struct platform_device *pdev)
> +{
> +	struct ipq_pwm_chip *pwm =3D platform_get_drvdata(pdev);
> +
> +	clk_disable_unprepare(pwm->clk);
> +	pwmchip_remove(&pwm->chip);

This is the wrong order. Until pwmchip_remove() returns the PWM must stay
functional, so disable the clock only after pwmchip_remove().

> +
> +	return 0;
> +}
> +
> +static const struct of_device_id pwm_ipq_dt_match[] =3D {
> +	{ .compatible =3D "qcom,ipq6018-pwm", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, pwm_ipq_dt_match);
> +
> +static struct platform_driver ipq_pwm_driver =3D {
> +	.driver =3D {
> +		.name =3D "ipq-pwm",
> +		.of_match_table =3D pwm_ipq_dt_match,
> +	},
> +	.probe =3D ipq_pwm_probe,
> +	.remove =3D ipq_pwm_remove,
> +};
> +
> +module_platform_driver(ipq_pwm_driver);
> +
> +MODULE_LICENSE("Dual BSD/GPL");

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--6yqo25hmihcjtfki
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDvRpwACgkQwfwUeK3K
7AkxNAf+IfnoWfNTldj3Iiv+JSrbgEjEtWwJ5RWO0QQbsQVL8nwDPCgdBOj6DmS3
uXR3ml6p6C1NzPfn2YOElEgkHUb5PmTPs4T0qR/MBl3WExAXG9A9o1mPYtJo8bp1
il79LpMof/I6qriXNe6so+ERJHMSEKW6s16X53ROJgvC0B/NiP3M9Cm1U9yoK8Lw
i5ISHjX2UqILLEpptHqaDIyBH0SVOGSRd60Wuq9QhettToQJ5/12PHGFJ9YFx9pD
ewv9LQAFj8BBSbGIkRZp2cjFF17euCW7DhTlbMEwlTo1sWOUzCOH3Y5J6dD+4nJL
J98EIzmZgSmhP3doiBY5QG5f0PX/Eg==
=r9IJ
-----END PGP SIGNATURE-----

--6yqo25hmihcjtfki--
