Return-Path: <linux-pwm+bounces-6471-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AC3AE38C5
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Jun 2025 10:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08E62189469F
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Jun 2025 08:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A0122F755;
	Mon, 23 Jun 2025 08:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qSeSVtBe"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6D81DF75A;
	Mon, 23 Jun 2025 08:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750668300; cv=none; b=MVCCnedo9TtnporUXKZAA/DjPtQ1l7Y1I4bWIt8SnNNgjGtiiipW/qcyF0IJTmtqDql51hP1xPQwGzN6ISSlGLQ2C6T2L7HkiEpi4HZhe4ta8UJLZ2D8FawzdoScsFTHeJ+CABaJXE9g6heum+YOkZ4TFkWzVZmz4wVay8Bs4Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750668300; c=relaxed/simple;
	bh=T+ZvFATpMVmo9JrjrJ0psl5XSDccDVqxEVtTuUwWGYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=diTywZBxvYm+2XYN7UJeOZfq7d3dv1KuJfcwqX1QTT3OZ7MeAsC5z1lhRVQRx5behlR8JHz/B6OLS4Z0FvZ/LpLy/5AScTJdw4dberrgusUkBmgwgTQ6C+OIOsOlV3JNt2XfK9H4+ds1nsH0cqAEmVLHOMwMwxj28q3NpeNyHew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qSeSVtBe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA2CC4CEED;
	Mon, 23 Jun 2025 08:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750668299;
	bh=T+ZvFATpMVmo9JrjrJ0psl5XSDccDVqxEVtTuUwWGYI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qSeSVtBe24oPA3fxyQOIEjU6APWTd0ILLyIKNoUPlgMC/+0TiNHEq3l3qE3rN+kw6
	 hXGrKsSt8/wXQNmnNBULq5BmlBb7gqK8KaaJRkfaIG8DlApgOhMO8NIEeYVehCdwM/
	 eDvCQwA5LefVr1p1ZlFqdla9/blsb+eQQPZwTeuINQmlw2Gkc9FdYvfjvuEra0JcLO
	 d2ycrAcDI8W0CQSz7WIui8aaKVg02RFR9uxGiYnOEqqjJn3+AQWk80ekdlX/xRUNT+
	 VvAWhbkaExKX1N5xk2b2sQjKBu5BJNvNKn+dyo1lOdsAhRD5ogrCThLnEQNmWaGQIC
	 QZ41rtsNkZIPw==
Date: Mon, 23 Jun 2025 10:44:57 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	William Breathitt Gray <wbg@kernel.org>, Sebastian Reichel <sebastian.reichel@collabora.com>, 
	Kever Yang <kever.yang@rock-chips.com>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Lee Jones <lee@kernel.org>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-iio@vger.kernel.org, kernel@collabora.com, Jonas Karlman <jonas@kwiboo.se>, 
	Detlev Casanova <detlev.casanova@collabora.com>
Subject: Re: [PATCH v2 5/7] pwm: Add rockchip PWMv4 driver
Message-ID: <o5xaoorrqb6a3jwwpdcsowrqbo7owrjzwj4r3laytusms6txdi@ku4bvbynkwh7>
References: <20250602-rk3576-pwm-v2-0-a6434b0ce60c@collabora.com>
 <20250602-rk3576-pwm-v2-5-a6434b0ce60c@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4g26suiz7oblktsa"
Content-Disposition: inline
In-Reply-To: <20250602-rk3576-pwm-v2-5-a6434b0ce60c@collabora.com>


--4g26suiz7oblktsa
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v2 5/7] pwm: Add rockchip PWMv4 driver
MIME-Version: 1.0

Hello Nicolas,

On Mon, Jun 02, 2025 at 06:19:16PM +0200, Nicolas Frattaroli wrote:
> +/**
> + * rockchip_pwm_v4_round_params - convert PWM parameters to hardware
> + * @rate: PWM clock rate to do the calculations at
> + * @duty: PWM duty cycle in nanoseconds
> + * @period: PWM period in nanoseconds
> + * @offset: PWM offset in nanoseconds
> + * @out_duty: pointer to where the rounded duty value should be stored
> + * @out_period: pointer to where the rounded period value should be stored
> + * @out_offset: pointer to where the rounded offset value should be stored
> + *
> + * Convert nanosecond-based duty/period/offset parameters to the PWM hardware's
> + * native rounded representation in number of cycles at clock rate @rate. Should
> + * any of the input parameters be out of range for the hardware, the
> + * corresponding output parameter is the maximum permissible value for said
> + * parameter with considerations to the others.
> + */
> +static void rockchip_pwm_v4_round_params(unsigned long rate, u64 duty,
> +					u64 period, u64 offset, u32 *out_duty,
> +					u32 *out_period, u32 *out_offset)
> +{
> +	int ret;
> +
> +	ret = rockchip_pwm_v4_round_single(rate, period, out_period);
> +	if (ret)
> +		*out_period = U32_MAX;

It's strange to let rockchip_pwm_v4_round_single return failure just to
reset it to U32_MAX here then. I'd make rockchip_pwm_v4_round_single do:

	tmp = mul_u64_u64_div_u64(rate, in_val, NSEC_PER_SEC);
	if (tmp > U32_MAX)
		return U32_MAX
	return tmp;

and then just do

	*out_period = rockchip_pwm_v4_round_single(rate, period);
	*out_duty = rockchip_pwm_v4_round_single(rate, duty)
	...

> +
> +	ret = rockchip_pwm_v4_round_single(rate, duty, out_duty);
> +	if (ret || *out_duty > *out_period)
> +		*out_duty = *out_period;

You can assume that .round_wf_tohw() is called only with duty <= period.

> +	ret = rockchip_pwm_v4_round_single(rate, offset, out_offset);
> +	if (ret || *out_offset > (*out_period - *out_duty))
> +		*out_offset = *out_period - *out_duty;

Is this a hardware limitation? In general

	.period_length_ns = 1000
	.duty_length_ns = 600
	.duty_offset_ns = 600

is a valid waveform.

> +}
> +
> +static int rockchip_pwm_v4_round_wf_tohw(struct pwm_chip *chip,
> +					 struct pwm_device *pwm,
> +					 const struct pwm_waveform *wf,
> +					 void *_wfhw)
> +{
> +	struct rockchip_pwm_v4 *pc = to_rockchip_pwm_v4(chip);
> +	struct rockchip_pwm_v4_wf *wfhw = _wfhw;
> +	unsigned long rate;
> +	int ret;
> +
> +	/* We do not want chosen_clk to change out from under us here */
> +	ret = mfpwm_acquire(pc->pwmf);
> +	if (ret)
> +		return ret;
> +
> +	rate = clk_get_rate(pc->pwmf->core);
> +
> +	rockchip_pwm_v4_round_params(rate, wf->duty_length_ns,
> +				     wf->period_length_ns, wf->duty_offset_ns,
> +				     &wfhw->duty, &wfhw->period, &wfhw->offset);
> +
> +	if (wf->period_length_ns > 0)
> +		wfhw->enable = PWMV4_EN_BOTH_MASK;
> +	else
> +		wfhw->enable = 0;
> +
> +	dev_dbg(&chip->dev, "tohw: duty = %u, period = %u, offset = %u, rate %lu\n",
> +		wfhw->duty, wfhw->period, wfhw->offset, rate);

This is more helpful if the input parameters (i.e. wf) is also emitted.

> +	mfpwm_release(pc->pwmf);
> +	return 0;
> +}
> +
> +static int rockchip_pwm_v4_round_wf_fromhw(struct pwm_chip *chip,
> +					   struct pwm_device *pwm,
> +					   const void *_wfhw,
> +					   struct pwm_waveform *wf)
> +{
> +	struct rockchip_pwm_v4 *pc = to_rockchip_pwm_v4(chip);
> +	const struct rockchip_pwm_v4_wf *wfhw = _wfhw;
> +	unsigned long rate;
> +	int ret = 0;
> +
> +	/* We do not want chosen_clk to change out from under us here */
> +	ret = mfpwm_acquire(pc->pwmf);
> +	if (ret)
> +		return ret;

Hmm, there is little gain here. Correct me if I'm wrong, but you prevent
a rate change only until mfpwm_release() is called, so the assertion
ends before the caller can use the calculated parameters anyhow. So
maybe drop the acquire/release pair?

> +	rate = clk_get_rate(pc->pwmf->core);
> +
> +	if (rockchip_pwm_v4_is_enabled(wfhw->enable)) {
> +		if (!rate) {
> +			ret = -EINVAL;
> +			goto out_mfpwm_release;
> +		}
> +		wf->period_length_ns = mul_u64_u64_div_u64(wfhw->period, NSEC_PER_SEC, rate);

(u64)wfhw->period * NSEC_PER_SEC cannot overflow, so a plain
multiplication and then a division is cheaper here.

> +		wf->duty_length_ns = mul_u64_u64_div_u64(wfhw->duty, NSEC_PER_SEC, rate);
> +		wf->duty_offset_ns = mul_u64_u64_div_u64(wfhw->offset, NSEC_PER_SEC, rate);
> +	} else {
> +		wf->period_length_ns = 0;
> +		wf->duty_length_ns = 0;
> +		wf->duty_offset_ns = 0;
> +	}
> +
> +	dev_dbg(&chip->dev, "fromhw: duty = %llu, period = %llu, offset = %llu, rate = %lu\n",
> +		wf->duty_length_ns, wf->period_length_ns, wf->duty_offset_ns, rate);

As above, please include wfhw in the output.

> +out_mfpwm_release:
> +	mfpwm_release(pc->pwmf);
> +	return ret;
> +}
> +
> [...]
> +static int rockchip_pwm_v4_probe(struct platform_device *pdev)
> +{
> +	struct rockchip_mfpwm_func *pwmf = dev_get_platdata(&pdev->dev);
> +	struct rockchip_pwm_v4 *pc;
> +	struct pwm_chip *chip;
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	chip = devm_pwmchip_alloc(dev, 1, sizeof(*pc));
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +
> +	pc = to_rockchip_pwm_v4(chip);
> +	pc->pwmf = pwmf;
> +
> +	ret = mfpwm_acquire(pwmf);
> +	if (ret == -EBUSY)
> +		dev_warn(dev, "pwm hardware already in use, can't check initial state\n");
> +	else if (ret < 0)
> +		return dev_err_probe(dev, ret, "couldn't acquire mfpwm in probe\n");
> +
> +	if (!rockchip_pwm_v4_on_and_continuous(pc))
> +		mfpwm_release(pwmf);
> +	else {
> +		dev_dbg(dev, "pwm was already on at probe time\n");
> +		ret = clk_enable(pwmf->core);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "enabling pwm clock failed\n");
> +		ret = clk_rate_exclusive_get(pc->pwmf->core);
> +		if (ret) {
> +			clk_disable(pwmf->core);
> +			return dev_err_probe(dev, ret, "protecting pwm clock failed\n");
> +		}
> +	}
> +
> +	platform_set_drvdata(pdev, chip);
> +
> +	chip->ops = &rockchip_pwm_v4_ops;
> +
> +	ret = pwmchip_add(chip);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to add PWM chip\n");

I like error messages starting with a capital letter.

> +
> +	return 0;
> +}
> +
> +static void rockchip_pwm_v4_remove(struct platform_device *pdev)
> +{
> +	struct pwm_chip *chip = platform_get_drvdata(pdev);
> +	struct rockchip_pwm_v4 *pc = to_rockchip_pwm_v4(chip);
> +
> +	mfpwm_remove_func(pc->pwmf);

What does this function do? It is not used in .probe()'s error path?!

> +	pwmchip_remove(chip);

Wrong order (I think). If mfpwm_remove_func() affects operation,
pwmchip_remove() must be called first.

> +}
> +
> +static const struct platform_device_id rockchip_pwm_v4_ids[] = {
> +	{ .name = "pwm-rockchip-v4", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(platform, rockchip_pwm_v4_ids);
> +
> +static struct platform_driver rockchip_pwm_v4_driver = {
> +	.probe = rockchip_pwm_v4_probe,
> +	.remove = rockchip_pwm_v4_remove,
> +	.driver = {
> +		.name = "pwm-rockchip-v4",
> +	},
> +	.id_table = rockchip_pwm_v4_ids,
> +};
> +module_platform_driver(rockchip_pwm_v4_driver);
> +
> +MODULE_AUTHOR("Nicolas Frattaroli <nicolas.frattaroli@collabora.com>");
> +MODULE_DESCRIPTION("Rockchip PWMv4 Driver");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS("ROCKCHIP_MFPWM");

Best regards
Uwe

--4g26suiz7oblktsa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhZFAYACgkQj4D7WH0S
/k5t6ggAjmDJYKJYUEg5lEGucA+QTWdT0UbHkO7qf1jcahM1hd34ZOp7tYXkD9wC
m28YV1gus2tgEIqldCRmqO0y5hJhniDfOJ92BRihB50Bkg1m6hox9P4iqMRPSJnd
uDnmATiNVdY7Et8MPEe9Y9YDACD2CKfv/DSvUxkp3la1rhIglcTMHfPDFRMnSynw
WUgyHKQ1hLEokOyBXvXY3wlDZCTpUZQpW5eSVW6p+h+Qj/liLp7CWNbW5myK/H49
GYN3F/oEPrF+TMASFJkOfQb4Cs+MgPWOhTZfjj693TbWuFxc1p6seTByPZN8h3gg
8B0jF2BSQvP4BiSbf9asZfRRNTd3DQ==
=4kAc
-----END PGP SIGNATURE-----

--4g26suiz7oblktsa--

