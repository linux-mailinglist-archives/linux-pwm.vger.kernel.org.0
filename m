Return-Path: <linux-pwm+bounces-6394-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 751C6ADC3DB
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Jun 2025 09:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51BD33B83B6
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Jun 2025 07:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB45E28ECE5;
	Tue, 17 Jun 2025 07:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oy0KoSKa"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC12E28ECCD;
	Tue, 17 Jun 2025 07:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750147160; cv=none; b=Af3WbLS/xzl4uG/MHa71G5rsFwe6B5pmRJqmgUmxubAzpadX0DuMzrOlbB9JgZQ41ayK4hpLhpyScw5XICF5pIWmq9rFzlrBkEukhJ2Bf3+36ILiHVINQlOTClyKRa+0i2w1JTWK8XNhJFNTaLWwKR/q/XsmCroLpIBg+loN+Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750147160; c=relaxed/simple;
	bh=byesW+Se6X5SuEzLgB6KkhVKbYK7slvyxQIgO6neyBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P77pWY4PqR2DhlxPOtpWzPc56dgr3UoAN19o30wNTJ6ykr3eV/KaziFLz7sUTZUWlU/zjmJoXIXQldY5H+ztcd81VX5i3uzDtpp8+3PJSBYjDcaCTL5lzt0b3qwf0URpXRPOdeGMenIIj4k55EK5oXUNz28s04JnRW0vY1NRgHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oy0KoSKa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00CFEC4CEED;
	Tue, 17 Jun 2025 07:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750147160;
	bh=byesW+Se6X5SuEzLgB6KkhVKbYK7slvyxQIgO6neyBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oy0KoSKa9joZZM9OtdixrPl0rtq0ZxhsoPHs0pF8D4wc5JfzsOWchPi04kCSzIyDx
	 Eos49bnoQNAIiT0cRCI2DPRDnjLy54kJdhGDzvkWF5wxOm458H7PywvNaZu9ANDmbo
	 cWxjxq0CzUjI4H8q3BAICfwJONc+FtXA89LwrkpT+CXB+3hm+loaOP1iVTYq/ekTWw
	 urlGpNomxAOWTGFia1+mgYPSAVNsVza6ih4rAKGFKF/sWNcvMwnp+baAiRPR697CNo
	 TWf4wMBO8aLxTd8CRKdQEvUlZT7aNfIww3excCXrLPqEIDVJY3LRI2a2JXRCSTxJSk
	 mkFiaS7gpWFzQ==
Date: Tue, 17 Jun 2025 09:59:17 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pwm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 3/3] pwm: argon-fan-hat: Add Argon40 Fan HAT support
Message-ID: <47s4qjr7iujql36opgkp3cniq46oc4p72aaewzs3i3oxp4tcgn@ikrczuyxcqwb>
References: <20250617002852.606409-1-marek.vasut+renesas@mailbox.org>
 <20250617002852.606409-3-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mtj4m4lkj7ypbbbl"
Content-Disposition: inline
In-Reply-To: <20250617002852.606409-3-marek.vasut+renesas@mailbox.org>


--mtj4m4lkj7ypbbbl
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v2 3/3] pwm: argon-fan-hat: Add Argon40 Fan HAT support
MIME-Version: 1.0

Hello Marek,

On Tue, Jun 17, 2025 at 02:28:02AM +0200, Marek Vasut wrote:
> diff --git a/drivers/pwm/pwm-argon-fan-hat.c b/drivers/pwm/pwm-argon-fan-hat.c
> new file mode 100644
> index 000000000000..a26b58ee7f29
> --- /dev/null
> +++ b/drivers/pwm/pwm-argon-fan-hat.c
> @@ -0,0 +1,115 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2025 Marek Vasut
> + *
> + * Limitations:
> + * - no support for offset/polarity
> + * - fixed duty cycle, period changes from 0Hz..120kHz

A link to the product page would be great.

> + */
> +
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/pwm.h>
> +
> +static int argon_fan_hat_round_waveform_tohw(struct pwm_chip *chip,
> +					     struct pwm_device *pwm,
> +					     const struct pwm_waveform *wf,
> +					     void *_wfhw)
> +{
> +	u8 *wfhw = _wfhw;
> +
> +	*wfhw = DIV_ROUND_CLOSEST_ULL(wf->duty_length_ns * 100, wf->period_length_ns);
> +
> +	return 0;
> +}
> +
> +static int argon_fan_hat_round_waveform_fromhw(struct pwm_chip *chip,
> +					       struct pwm_device *pwm,
> +					       const void *_wfhw,
> +					       struct pwm_waveform *wf)
> +{
> +	const u8 *wfhw = _wfhw;
> +
> +	/* 1 step of this hardware is cca. 1200 Hz increase in frequency */
> +	wf->period_length_ns = DIV64_U64_ROUND_UP(NSEC_PER_SEC, *wfhw * 1200);
> +	wf->duty_length_ns = wf->period_length_ns / 10;
> +	wf->duty_offset_ns = 0;

How extraordinary, so the relative duty cycle is always 10%? In the
binding patch you claimed duty cycle was constant?

Please enable PWM_DEBUG while testing.

> +	return 0;
> +}
> +
> +static int argon_fan_hat_write_waveform(struct pwm_chip *chip,
> +					struct pwm_device *pwm,
> +					const void *_wfhw)
> +{
> +	struct i2c_client *i2c = pwmchip_get_drvdata(chip);
> +	const u8 *wfhw = _wfhw;
> +	u8 tx[2] = { 0x80, *wfhw };
> +	struct i2c_msg msg = {
> +		.addr = i2c->addr,
> +		.len = 2,
> +		.buf = tx,
> +	};
> +
> +	return (i2c_transfer(i2c->adapter, &msg, 1) == 1) ? 0 : -EINVAL;
> +}
> +
> +static const struct pwm_ops argon_fan_hat_pwm_ops = {
> +	.sizeof_wfhw		= sizeof(u8),
> +	.round_waveform_fromhw	= argon_fan_hat_round_waveform_fromhw,
> +	.round_waveform_tohw	= argon_fan_hat_round_waveform_tohw,
> +	.write_waveform		= argon_fan_hat_write_waveform,

Please add a comment about why there is no .read_waveform().

> +};
> +
> +static int argon_fan_hat_i2c_probe(struct i2c_client *i2c)
> +{
> +	struct pwm_chip *pc = devm_pwmchip_alloc(&i2c->dev, 1, 0);
> +	int ret;
> +
> +	if (IS_ERR(pc))
> +		return PTR_ERR(pc);
> +
> +	pc->ops = &argon_fan_hat_pwm_ops;
> +	pwmchip_set_drvdata(pc, i2c);
> +
> +	ret = devm_pwmchip_add(&i2c->dev, pc);
> +	if (ret)
> +		return dev_err_probe(&i2c->dev, ret, "Could not add PWM chip\n");
> +
> +	return 0;
> +}
> +
> +static void argon_fan_hat_i2c_shutdown(struct i2c_client *i2c)
> +{
> +	u8 tx[2] = { 0x80, 0x64 };
> +	struct i2c_msg msg = {
> +		.addr = i2c->addr,
> +		.len = 2,
> +		.buf = tx,
> +	};
> +
> +	i2c_transfer(i2c->adapter, &msg, 1);
> +}

This is argon_fan_hat_write_waveform(..., _wfhw=100). Looks like an
opportunity to consolidate these functions.

> +static const struct of_device_id argon_fan_hat_dt_ids[] = {
> +	{ .compatible = "argon40,fan-hat" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, argon_fan_hat_dt_ids);
> +
> +static struct i2c_driver argon_fan_hat_driver = {
> +	.driver = {
> +		.name = "argon-fan-hat",
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
> +		.of_match_table = argon_fan_hat_dt_ids,
> +	},
> +	.probe = argon_fan_hat_i2c_probe,
> +	.shutdown = argon_fan_hat_i2c_shutdown,
> +};
> +
> +module_i2c_driver(argon_fan_hat_driver);
> +
> +MODULE_AUTHOR("Marek Vasut <marek.vasut+renesas@mailbox.org>");
> +MODULE_DESCRIPTION("Argon40 Fan HAT");
> +MODULE_LICENSE("GPL");

--mtj4m4lkj7ypbbbl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhRIFIACgkQj4D7WH0S
/k4Y/Af9G681BZSzo1iw+NSUjcQ0a4NqczEYwblboku6XSfrvKklwZeMSOYHBYZs
EyTe9VO9JROk+65IyPzOJ+jIH54+IJTmhVBRg3EbEKJ+lygOx21YH/VyoHWXE0qb
Wz+w9ik9tcqp8/e/pDn5FVc5/3O2ws3/9w7CBSCskoY5qRkyy3iZX3BhNgOLeqS8
vnAmb11jqmo7ChDuPKQDQ06icjcgVpXrztvK2/PfPvWEySJVaQWWxxrKoIPZYKgA
92l6r9ml5qClITHiIVG715HtWUGKPROKQEiHuOZHWu81NK9gVfs+eqgFraAHkQNp
cvSAIBPdENavI+ZyL4hSDp7gOxrMaQ==
=LyfD
-----END PGP SIGNATURE-----

--mtj4m4lkj7ypbbbl--

