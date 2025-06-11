Return-Path: <linux-pwm+bounces-6288-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69513AD4A93
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Jun 2025 07:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E77F67A8EF9
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Jun 2025 05:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8EB226883;
	Wed, 11 Jun 2025 05:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWEg9al0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5F2225791;
	Wed, 11 Jun 2025 05:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749621319; cv=none; b=itePEDWJQMMp93EGprcxPyWhyLN/bZNGRnBiyfe7LObStpeBeWHqyUCJbvQzVlrLVvgrpn11kgooCUnBy81rAPsXXtf5TwjMBJ7ZR/gX4HTtK6AzQRH+whZl7YnBuF7bZDscxFpntQFaJccFak/iOfZQUIi0I+aVug7oeGwBI+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749621319; c=relaxed/simple;
	bh=GWjF0qwx3dUxDRAtPR0ca68BBSoBy4uLsOdkXKWrPeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ScnR7ftxmb+YPyQRZ5Z67xvzpfNrXnp7NSL50VtxybZ+iCxmKrVYifLLJmrx0oZolTt+N2UQX1VSiZiAHoS6I7VH//MJp5k+MnPnOMde7N3hki1fuW3oueJdFamidVE+ExXGXFHu5GaSA92/YjWXaP+lab23leXOvBs2I/QIuyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWEg9al0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 861B8C4CEEE;
	Wed, 11 Jun 2025 05:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749621319;
	bh=GWjF0qwx3dUxDRAtPR0ca68BBSoBy4uLsOdkXKWrPeI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DWEg9al03Y2k8DvigYipWxQSdbV+J8yrrewvAc+q4y7em82rrITE/N4IrkG1KRLN7
	 oWZ5f/UvUay4li48uw1oJNsVq7/XzkAbItF2bAw05VjWVkPfi5jmhH0/SKYqyvjOTo
	 EPye7wQZxIx63A2fxgIAFXG2IMLu8jeWbt8NCAtEifQS8BnZ5odspZX/u9Ka2RZD5Y
	 3/EtRMWci5Y8H50lUmKGHHE5jfVdcG06V4ZtA6lyU90Vipcqoq4qt5RygoP+JpWaI+
	 K4dLzbVPGejZ6bL97w96KaaW8L24s6rfwUWT+Ih7eNfFro0QAX8YEZL7ZhXmNTJ3Xi
	 +qo9Ms+8g4n3Q==
Date: Wed, 11 Jun 2025 07:55:16 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pwm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 3/3] pwm: argon-fan-hat: Add Argon40 Fan HAT support
Message-ID: <3vfic5s64fzs5e4k33dik74rrwpsivj6fiwzdy5xckald43y4c@kcalsxmse6mp>
References: <20250610220814.167318-1-marek.vasut+renesas@mailbox.org>
 <20250610220814.167318-3-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nqpz4wckjlyez23h"
Content-Disposition: inline
In-Reply-To: <20250610220814.167318-3-marek.vasut+renesas@mailbox.org>


--nqpz4wckjlyez23h
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3/3] pwm: argon-fan-hat: Add Argon40 Fan HAT support
MIME-Version: 1.0

Hello Marek,

I wonder how this device works in rpios, I didn't find a matching driver
(but I also didn't try more than two minutes).

On Wed, Jun 11, 2025 at 12:07:27AM +0200, Marek Vasut wrote:
> diff --git a/drivers/pwm/pwm-argon-fan-hat.c b/drivers/pwm/pwm-argon-fan-=
hat.c
> new file mode 100644
> index 000000000000..3d04abdbd349
> --- /dev/null
> +++ b/drivers/pwm/pwm-argon-fan-hat.c
> @@ -0,0 +1,64 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2025 Marek Vasut
> + */

 * Limitations:
 * - fixed period (which?)
 * - no support for offset/polarity

If you can find out if it completes a period when reconfigured that
would also be nice to document.

This device is really trivial, but for completeness' sake: If there is a
data sheet publicly available, please add a link here.

> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/pwm.h>
> +
> +static int argon_fan_hat_pwm_apply(struct pwm_chip *chip, struct pwm_dev=
ice *pwm,
> +				   const struct pwm_state *state)

Can you please implement the new-style callbacks?

> +{
> +	struct i2c_client *i2c =3D pwmchip_get_drvdata(chip);
> +	u8 tx[2] =3D { 0x80, state->enabled ? pwm_get_relative_duty_cycle(state=
, 100) : 0 };

This is too simple. I won't go into details about the right algorithm
for .apply() as I want you to implement .round_waveform_tohw() +
=2Eround_waveform_fromhw() + .read_waveform() + .write_waveform() anyhow.

For .round_waveform_tohw() you have to know the actual period length and
then use something like:

	duty =3D wf->duty_length_ns;

	if (duty > ARGON_FAN_HAT_PERIOD)
		duty =3D ARGON_FAN_HAT_PERIOD;

	duty_percent =3D 100 * duty / ARGON_FAN_HAT_PERIOD;
=09

> +	struct i2c_msg msg =3D {
> +		.addr =3D i2c->addr,
> +		.len =3D 2,
> +		.buf =3D tx,
> +	};
> +
> +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> +		return -EINVAL;
> +
> +	return (i2c_transfer(i2c->adapter, &msg, 1) =3D=3D 1) ? 0 : -EINVAL;
> +}
> +
> +static const struct pwm_ops argon_fan_hat_pwm_ops =3D {
> +	.apply =3D argon_fan_hat_pwm_apply,

Can you read back the configuration? If yes then please implement
=2Eread_waveform().

> +};
> +
> +static int argon_fan_hat_i2c_probe(struct i2c_client *i2c)
> +{
> +	struct pwm_chip *pc =3D devm_pwmchip_alloc(&i2c->dev, 1, 0);
> +
> +	if (IS_ERR(pc))
> +		return PTR_ERR(pc);
> +
> +	pc->ops =3D &argon_fan_hat_pwm_ops;
> +	pwmchip_set_drvdata(pc, i2c);
> +
> +	return devm_pwmchip_add(&i2c->dev, pc);

Error message on failure please. (-> dev_err_probe())

> +}
> +
> +static const struct of_device_id argon_fan_hat_dt_ids[] =3D {
> +	{ .compatible =3D "argon40,fan-hat" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, argon_fan_hat_dt_ids);
> +
> +static struct i2c_driver argon_fan_hat_driver =3D {
> +	.driver =3D {
> +		.name =3D "argon-fan-hat",
> +		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> +		.of_match_table =3D argon_fan_hat_dt_ids,
> +	},
> +	.probe =3D argon_fan_hat_i2c_probe,
> +};

TIL about PROBE_PREFER_ASYNCHRONOUS.

Best regards
Uwe

--nqpz4wckjlyez23h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhJGkEACgkQj4D7WH0S
/k6w2wf/Yy5kBMGeDlXmdGvdWJLczbwyCVwY6zIHQrKX9YvMAsOWip2jV8D+tsmc
SCf03FUlPZT3Davt5kcESZvpGHwWWQdVvWmWDlx27K9NJYpIJI2Ko9wdxyYtTWOr
f8OQCAk6YpAGyY2yZknZZnLxeYdAMdWVydyIiq+Tht5cV1S32wzo961nYCtsxl9B
nas2LUxxmw5VPNo+nqqFm2gkmVzAUIWYvpOdBoGNVyV1CHxwV1wiGiTBxSfHeUNi
kPlzQymHCDkmVXjs0EZg4ROZDQjhgRDsB8J7cMLjo8an1Egwjg/vDSn1NSdvFPeu
WpLulwIl4dLnQrOBPAie2tUJHw3zxQ==
=qRjD
-----END PGP SIGNATURE-----

--nqpz4wckjlyez23h--

