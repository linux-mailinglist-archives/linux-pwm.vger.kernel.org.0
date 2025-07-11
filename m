Return-Path: <linux-pwm+bounces-6840-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F66B01F7C
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Jul 2025 16:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF8665857D1
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Jul 2025 14:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CC82E9EB0;
	Fri, 11 Jul 2025 14:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkdkEKbz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F2A28725E;
	Fri, 11 Jul 2025 14:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752245444; cv=none; b=hfE7AsvkzEzfzDt/Vt3yls8fvwLCzpFNjZRWb33SGJNdzEC42LOQmUBcFUk3ZzLrjvgj2j/1rTQMl+RtAkWfIqAs1KOwaW+rj79cHiXC2fhZAZxHYuYflFfew0etp16B8UwM4SN8zJq3OGC0da0oHYQ+KyjU/1kLFN+UOpXrAo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752245444; c=relaxed/simple;
	bh=f7cDjsfYPdriIgbQb8YGdKasotUmE5cLXTOLFytF0io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fGQiIoWSFu+ZDHjEcfIrTuGnr1SmJ9KiAvgeZ0tQIFMbumY/iRQC+foDDdV+61BkFzko5ni7v6PcAWdc7wCSmKk1q0GsSEaIxgfO8gctQp7JAPAw0silgSMxEFN0gXIALcqjO7ykp7KbcmJRmSR43e9e0R2QVYtjDJsXQ1vEW6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkdkEKbz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92E27C4CEED;
	Fri, 11 Jul 2025 14:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752245444;
	bh=f7cDjsfYPdriIgbQb8YGdKasotUmE5cLXTOLFytF0io=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gkdkEKbzsDiMv4RtOFiBMMGIOCuL14UGF4GvAp0pra/zVrI9un62BvfuR+HbOvvkP
	 CyubUoCgzdntLhzTrM+QVUTVUg9tUhaTaq8yR5VV9mndHZroNCbA0xruIvY/xWTCgY
	 Oi0ItRuP/wMULghV4N5z/aXUuCgUM/CGt9RBOui3JhIAvtDvMxISvooZw9A4qwlYxr
	 XfvZ8ZoS+Sz5z0JNTTID4kxdeNNekl0NTvKuzDDcHyiM8DjRtaLjynaMmGYoPpp1d1
	 zHOBJZGluzRw1VnRcMeh/b6YyZQh3CQXvbxf1GhN5v93Vz0MJwwYr1wXx+rjfN0jEs
	 Te9Ev4z08EevQ==
Date: Fri, 11 Jul 2025 16:50:41 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kamel Bouhara <kamel.bouhara@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Michael Walle <mwalle@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, linux-pwm@vger.kernel.org, 
	andriy.shevchenko@intel.com, =?utf-8?Q?Gr=C3=A9gory?= Clement <gregory.clement@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v11 04/10] pwm: max7360: Add MAX7360 PWM support
Message-ID: <j6zavgfpiq7s7cnfkghn2y6fv4h4ziqtpyp7igwmovqlyuasoq@hozlyjcpsxth>
References: <20250711-mdb-max7360-support-v11-0-cf1dee2a7d4c@bootlin.com>
 <20250711-mdb-max7360-support-v11-4-cf1dee2a7d4c@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hzchddujgha2ujw2"
Content-Disposition: inline
In-Reply-To: <20250711-mdb-max7360-support-v11-4-cf1dee2a7d4c@bootlin.com>


--hzchddujgha2ujw2
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v11 04/10] pwm: max7360: Add MAX7360 PWM support
MIME-Version: 1.0

Hello Mathieu,

On Fri, Jul 11, 2025 at 11:29:44AM +0200, Mathieu Dubois-Briand wrote:
> diff --git a/drivers/pwm/pwm-max7360.c b/drivers/pwm/pwm-max7360.c
> new file mode 100644
> index 000000000000..0eb83135f658
> --- /dev/null
> +++ b/drivers/pwm/pwm-max7360.c
> @@ -0,0 +1,193 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright 2025 Bootlin
> + *
> + * Author: Kamel BOUHARA <kamel.bouhara@bootlin.com>
> + * Author: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> + *

A link to the data sheet here would be awesome. I found it at

https://www.analog.com/media/en/technical-documentation/data-sheets/MAX7360.pdf

> [...]
> +static int max7360_pwm_round_waveform_tohw(struct pwm_chip *chip,
> +					   struct pwm_device *pwm,
> +					   const struct pwm_waveform *wf,
> +					   void *_wfhw)
> +{
> +	struct max7360_pwm_waveform *wfhw = _wfhw;
> +	u64 duty_steps;
> +
> +	/*
> +	 * Ignore user provided values for period_length_ns and duty_offset_ns:
> +	 * we only support fixed period of MAX7360_PWM_PERIOD_NS and offset of 0.
> +	 */
> +	if (wf->duty_length_ns >= MAX7360_PWM_PERIOD_NS)
> +		duty_steps = MAX7360_PWM_MAX_RES;
> +	else
> +		duty_steps = (u32)wf->duty_length_ns * MAX7360_PWM_MAX_RES / MAX7360_PWM_PERIOD_NS;

I read through the data sheet and I think the right formula for
duty_steps is:

	if (wf->duty_length_ns >= MAX7360_PWM_PERIOD_NS) {
		duty_steps = 255;
	} else {
		duty_steps = (u32)wf->duty_length_ns * 256 / MAX7360_PWM_PERIOD_NS;
		if (duty_steps == 255)
			duty_steps = 254;
	}

(Using magic constants here, but in the end these should be cpp symbols
of course.)

> +	wfhw->duty_steps = min(MAX7360_PWM_MAX_RES, duty_steps);
> +	wfhw->enabled = !!wf->period_length_ns;
> +
> +	return 0;
> +}
> +
> +static int max7360_pwm_round_waveform_fromhw(struct pwm_chip *chip, struct pwm_device *pwm,
> +					     const void *_wfhw, struct pwm_waveform *wf)
> +{
> +	const struct max7360_pwm_waveform *wfhw = _wfhw;
> +
> +	wf->period_length_ns = wfhw->enabled ? MAX7360_PWM_PERIOD_NS : 0;
> +	wf->duty_offset_ns = 0;
> +
> +	if (wfhw->enabled)
> +		wf->duty_length_ns = DIV_ROUND_UP(wfhw->duty_steps * MAX7360_PWM_PERIOD_NS,
> +						  MAX7360_PWM_MAX_RES);
> +	else
> +		wf->duty_length_ns = 0;

The matching code here is:

	if (wfhw->duty_steps == 255)
		wf->duty_length_ns = MAX7360_PWM_PERIOD_NS;
	else
		wf->duty_length_ns = DIV_ROUND_UP(wfhw->duty_steps * MAX7360_PWM_PERIOD_NS, 256)

This is arguably a strange design, but f_OSC = 128 kHz and the fixed
period being 2 ms is a strong indication that the divider is 256 and not
255. If you don't agree to the manual (e.g. because you measured the
output and saw your formula to be true), please add a code comment about
that.

When you have measureing equipment at hand it would be great if you
could verify that the right fromhw implementation isn't:

	wf->duty_length_ns = DIV_ROUND_UP(wfhw->duty_steps * MAX7360_PWM_PERIOD_NS, 256)

even for wfhw->duty_steps == 255. (Which would mean that the PWM cannot
provide a 100% duty cycle.)

> +static int max7360_pwm_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct pwm_chip *chip;
> +	struct regmap *regmap;
> +	int ret;
> +
> +	regmap = dev_get_regmap(dev->parent, NULL);
> +	if (!regmap)
> +		return dev_err_probe(dev, -ENODEV, "could not get parent regmap\n");
> +
> +	/*
> +	 * This MFD sub-device does not have any associated device tree node:
> +	 * properties are stored in the device node of the parent (MFD) device
> +	 * and this same node is used in phandles of client devices.
> +	 * Reuse this device tree node here, as otherwise the PWM subsystem
> +	 * would be confused by this topology.
> +	 */
> +	device_set_of_node_from_dev(dev, dev->parent);
> +
> +	chip = devm_pwmchip_alloc(dev, MAX7360_NUM_PWMS, 0);
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +	chip->ops = &max7360_pwm_ops;
> +
> +	pwmchip_set_drvdata(chip, regmap);
> +
> +	ret = devm_pwmchip_add(dev, chip);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to add PWM chip\n");

Please start error messages with a capital letter.

Best regards
Uwe

--hzchddujgha2ujw2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhxJL4ACgkQj4D7WH0S
/k4S6Af+OP9Xr/XyQhfCdozOq2IuZOzTvXZVWWn6sR7p0bRMZDSX1IfwDcvdb63z
qRUXpBHJaW8grNb+hmwTbRxmHWUCGjhH4VBGUmtfP8fv+QfC35r8ie8Batp8VkOG
N7+9Z0x5mqd7FLtoJ8TDmxgDzvMzEHyzMdEUmKL/53NxYXpIszBHtB9+5vYszxel
DaIPmYHyU2JBBAEiSO3LRztZqLOpizDnjhdADLP8ZugJfCTpy5/vymIrc4u3oRxh
1Mn85JaS8LNhFoVIzBLo35o7yD2eWdrmCRlcsyzExXi7aSJW2o5ZW6ilW4IhovVx
q+Ox8XFxB7ol5KCtc69MrwYW8HrRAQ==
=oqCg
-----END PGP SIGNATURE-----

--hzchddujgha2ujw2--

