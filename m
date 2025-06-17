Return-Path: <linux-pwm+bounces-6404-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D5CADCEA9
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Jun 2025 16:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3217C1898FA4
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Jun 2025 14:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5441916DEB3;
	Tue, 17 Jun 2025 14:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LK6FAhu5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F188482FF;
	Tue, 17 Jun 2025 14:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750168946; cv=none; b=bAcSA7cHo7BtVkOD1GcG8yDlZiM9JSu5xXTqno9TjxAV9WIublYJIM3AKdALGlL+ldT1WugCp0bq8B3uX0jmi2Ths7N4lAP1gc4a7K4JNrJ7G1+xIZ1MbKrJ0fFGcZ5Zx5a77KB9X4Q3VpHXD1cu4TRtEszScMG1HSxCZ8X9WYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750168946; c=relaxed/simple;
	bh=IDX1O24AQ0fDZmg1ZPj5AQ8cxPkyCVGdTnsRhraCqI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s2V03Ex23TEmmlkVjOdZlZ0O/huu8beZI94c7Llx8un5YAl5OqdtJuBk860kqMtK/a6VJj0x4l0M0+sBZK5MHnNgkMCP6z8HyAE1li33GhPEarVdWewz02q3bJV7RMwuKjCOb05I/YHb9qVoZQLQxekAJ0SsjEV1WdYhOwQwXAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LK6FAhu5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AD75C4CEF0;
	Tue, 17 Jun 2025 14:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750168945;
	bh=IDX1O24AQ0fDZmg1ZPj5AQ8cxPkyCVGdTnsRhraCqI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LK6FAhu5ZIAiinLdF1hK6FzwBJNcznjlQDAhJ6n/e0Oakxc2TRRZSvg74pmqZKlvi
	 ZojcdOtJTnLg4sEvm0oraVwDgq3UQ4LujOoA0Yp0ps/V7uc9dYpQ4og4olKK6XoVK2
	 4mtkf0zz6Z/XjB5v8x+Kg1QB6D25bu/o1+vpa+ZLqmabh5Q/INhJOv0hNs/Oqu+LCe
	 q7cAWd2Lz+T4Uk62NFEM2/QPp7B0DG0TLoVWhkf+Z8qUsmPTko0Xt2KXljYtjOx6wb
	 rQY1+oakjC2wlGcY5JExwVgTP9TISF+I5wiBUR1X/+o4zvkcz/wVt6hxIrOea4q50V
	 w34f7FluotYXQ==
Date: Tue, 17 Jun 2025 16:02:22 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pwm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3 3/3] pwm: argon-fan-hat: Add Argon40 Fan HAT support
Message-ID: <fhns5fnckokwsb572kge6tmqaaoholzvgncdctj7vskigytvmu@3uirsrszul36>
References: <20250617092037.37229-1-marek.vasut+renesas@mailbox.org>
 <20250617092037.37229-3-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t62wktukis6g36v3"
Content-Disposition: inline
In-Reply-To: <20250617092037.37229-3-marek.vasut+renesas@mailbox.org>


--t62wktukis6g36v3
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v3 3/3] pwm: argon-fan-hat: Add Argon40 Fan HAT support
MIME-Version: 1.0

Hello Marek,

On Tue, Jun 17, 2025 at 11:19:36AM +0200, Marek Vasut wrote:
> diff --git a/drivers/pwm/pwm-argon-fan-hat.c b/drivers/pwm/pwm-argon-fan-hat.c
> new file mode 100644
> index 000000000000..58b94ad4d9bc
> --- /dev/null
> +++ b/drivers/pwm/pwm-argon-fan-hat.c
> @@ -0,0 +1,122 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2025 Marek Vasut
> + *
> + * Limitations:
> + * - no support for offset/polarity
> + * - fixed 30 kHz period
> + *
> + * Argon Fan HAT https://argon40.com/products/argon-fan-hat
> + */
> +
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/pwm.h>
> +
> +#define ARGON40_FAN_HAT_PERIOD_NS	33333	/* ~30 kHz */
> +
> +static int argon_fan_hat_round_waveform_tohw(struct pwm_chip *chip,
> +					     struct pwm_device *pwm,
> +					     const struct pwm_waveform *wf,
> +					     void *_wfhw)
> +{
> +	u8 *wfhw = _wfhw;
> +
> +	*wfhw = DIV_ROUND_CLOSEST_ULL(wf->duty_length_ns * 100, wf->period_length_ns);

Oh, I thought I already pointed this out to be wrong in reply to v2, but
it seems I didn't :-\ Ah, I did that for your other PWM patch
https://lore.kernel.org/all/jgafc7te2zotqwvetudo6c4o4nit6zi3yp4ecg4gka53hrypk5@7ypb5asrc2ct/.

I see you have concerns there, I'll address these in that thread.

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
> +	wf->period_length_ns = ARGON40_FAN_HAT_PERIOD_NS;
> +	wf->duty_length_ns = DIV64_U64_ROUND_UP(wf->period_length_ns * *wfhw, 100);
> +	wf->duty_offset_ns = 0;
> +
> +	return 0;
> +}
> +
> +static int argon_fan_hat_write(struct i2c_client *i2c, const u8 wfhw)
> +{
> +	u8 tx[2] = { 0x80, wfhw };

The vendor "driver" has `ADDR_ARGONONEREG_DUTYCYCLE=0x80`, maybe put that
into a define, too?

> +	struct i2c_msg msg = {
> +		.addr = i2c->addr,
> +		.len = 2,
> +		.buf = tx,
> +	};
> +
> +	return (i2c_transfer(i2c->adapter, &msg, 1) == 1) ? 0 : -EINVAL;

The vendor driver uses smbus stuff. I suggest to use
i2c_smbus_write_byte_data() here, too.

I also found that the vendor driver reads the duty-cycle register (using
i2c_smbus_read_byte_data()). Strange that this stops the fan.

> +}
> +
> +static int argon_fan_hat_write_waveform(struct pwm_chip *chip,
> +					struct pwm_device *pwm,
> +					const void *_wfhw)
> +{
> +	struct i2c_client *i2c = pwmchip_get_drvdata(chip);
> +	const u8 *wfhw = _wfhw;
> +
> +	return argon_fan_hat_write(i2c, *wfhw);
> +}
> +
> +static const struct pwm_ops argon_fan_hat_pwm_ops = {
> +	.sizeof_wfhw		= sizeof(u8),
> +	.round_waveform_fromhw	= argon_fan_hat_round_waveform_fromhw,
> +	.round_waveform_tohw	= argon_fan_hat_round_waveform_tohw,
> +	.write_waveform		= argon_fan_hat_write_waveform,

Please don't align the =, use a single space only.

> +	/*
> +	 * The controller does not provide any way to read info back,
> +	 * reading from the controller stops the fan, therefore there
> +	 * is no .read_waveform here.
> +	 */
> +};
> +
> +static int argon_fan_hat_i2c_probe(struct i2c_client *i2c)
> +{
> +	struct pwm_chip *pc = devm_pwmchip_alloc(&i2c->dev, 1, 0);

Can you please rename "pc" to "chip"? "pc" is usually used for the
driver data struct.

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
> +	argon_fan_hat_write(i2c, 100);
> +}

Isn't that something that the fan driver should cope for? PWM drivers
usually do nothing on shutdown.

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

--t62wktukis6g36v3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhRdWsACgkQj4D7WH0S
/k5sewf/W/Bkf4IPqRyNruG1KiJrgDv7v9R+ERQDdI7f9RsSCXJfEz12JrTZYUm2
atwr+J/EiXfGpeDU9saB0mzie5SUc++yLDwYWMP8Xrhd5IKr6gvD/IAuIFOLcsGl
F8mBog3Ee1FRBpadulBuXqj9S7/Z+zlfRpnBqtqgoeedRkurJp2DdP5oYPQGcrid
0cisVKrPXPVj10ab0HSBbh/Q6xDlIgVR1byv5OLX3QGrgKWuXXzhTHIhWiSTEC+w
lsD1PlM7+oe7eiVtbSGxcsyxthvXzVym53b5ygde1IHpPWvi1OwWl15EGyDG29Ml
27diFYbYMY6Nug82++4siY7k54bT5A==
=1E7U
-----END PGP SIGNATURE-----

--t62wktukis6g36v3--

