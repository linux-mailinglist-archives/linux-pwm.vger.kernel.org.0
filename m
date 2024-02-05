Return-Path: <linux-pwm+bounces-1211-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDA8849765
	for <lists+linux-pwm@lfdr.de>; Mon,  5 Feb 2024 11:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBDCFB2BC49
	for <lists+linux-pwm@lfdr.de>; Mon,  5 Feb 2024 10:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7505D168D7;
	Mon,  5 Feb 2024 10:09:14 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD569134A9
	for <linux-pwm@vger.kernel.org>; Mon,  5 Feb 2024 10:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707127754; cv=none; b=NVF62ockSfYkW2nB2enC9xOT5xPpKnYAVgqBTqKY7OGQXTsuI2D/QZKBR0LRcEPm8NgOZwzmjxfbRt3bzbha8sz9u32zjCEMUG9VI/qdDsI6w8hYWfegwEbSi8Zb9hXG8XUCHKZ1LymyxVtfQh47AAR6QikIhUe2n1ctJvamON4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707127754; c=relaxed/simple;
	bh=F99UGl7ngh1/kkSUhb2J1OjOelX2kbZxbOegzofmhzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=soS+wZ8SIFv5qnmJTWK3Gwatt/oYdqNT0eYlFgmpAWm08EahD0CapXbB/P1dMSkXo8SXhFz8BWQ64Pw34Z/tDXLs9/j7v3OJSnq7clGpcN2jsVsmBdbFRJObbPbcIl6BE+dknif2nbi005WV8KwAPd/Sk1bMmvgJl9CgmoKEWYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rWvuQ-00048b-NM; Mon, 05 Feb 2024 11:09:02 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rWvuP-004bvy-SF; Mon, 05 Feb 2024 11:09:01 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rWvuP-00FNpw-2S;
	Mon, 05 Feb 2024 11:09:01 +0100
Date: Mon, 5 Feb 2024 11:09:01 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, andy.shevchenko@gmail.com, 
	Angelo Compagnucci <angelo.compagnucci@gmail.com>, Philip Howard <phil@gadgetoid.com>, Sean Young <sean@mess.org>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: Re: [PATCH V4 2/2] pwm: Add GPIO PWM driver
Message-ID: <b3bh4srxjc5s5yrceugn2bry4j7srvuyyc2zc7uorynn3esbbq@xtpfu3xnsi3q>
References: <20240204220851.4783-1-wahrenst@gmx.net>
 <20240204220851.4783-3-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qooobwxuyeu4bcau"
Content-Disposition: inline
In-Reply-To: <20240204220851.4783-3-wahrenst@gmx.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--qooobwxuyeu4bcau
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sun, Feb 04, 2024 at 11:08:51PM +0100, Stefan Wahren wrote:
> +static enum hrtimer_restart pwm_gpio_timer(struct hrtimer *gpio_timer)
> +{
> +	struct pwm_gpio *gpwm =3D container_of(gpio_timer, struct pwm_gpio,
> +					     gpio_timer);
> +	unsigned long next_toggle;
> +	unsigned long flags;
> +	bool new_level;
> +
> +	spin_lock_irqsave(&gpwm->lock, flags);
> +
> +	/* Apply new state at end of current period */
> +	if (!gpwm->level && gpwm->changing) {
> +		gpwm->changing =3D false;
> +		gpwm->state =3D gpwm->next_state;
> +		new_level =3D !!gpwm->state.duty_cycle;
> +	} else {
> +		new_level =3D !gpwm->level;
> +	}
> +
> +	next_toggle =3D pwm_gpio_toggle(gpwm, new_level);
> +	if (next_toggle) {
> +		hrtimer_forward(gpio_timer, hrtimer_get_expires(gpio_timer),
> +				ns_to_ktime(next_toggle));

How does this work in relation to hrtimer_resolution? If the resolution
is (say) 300 and next_toggle is 2000. Does the trigger trigger at
hrtimer_get_expires(...) + 1800, or at ... + 2100?

If you assume we have period =3D 6000 and duty_cycle =3D 2000, the delta to
forward the driver alternates between 1800 and 3900 (if rounding down)
or between 2100 and 4200 if rounding up. Both is not optimal.

Ideally you'd round down the active phase (i.e. pick 1800) and for the
inactive phase you'd use rounddown(period) - rounddown(duty_cycle) which
gives 4200 here. Does this make sense?

> +	}
> +
> +	spin_unlock_irqrestore(&gpwm->lock, flags);
> +
> +	return next_toggle ? HRTIMER_RESTART : HRTIMER_NORESTART;
> +}
> +
> +static int pwm_gpio_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			  const struct pwm_state *state)
> +{
> +	struct pwm_gpio *gpwm =3D container_of(chip, struct pwm_gpio, chip);
> +	bool invert =3D state->polarity =3D=3D PWM_POLARITY_INVERSED;
> +	unsigned long flags;
> +
> +	if (state->duty_cycle && state->duty_cycle < hrtimer_resolution)
> +		return -EINVAL;
> +
> +	if (state->duty_cycle !=3D state->period &&
> +	    (state->period - state->duty_cycle < hrtimer_resolution))
> +		return -EINVAL;

If you assume that hrtimer_resolution =3D 300 again, you don't want to
refuse

	.duty_cycle =3D 200
	.period =3D 200

do you? I think you want:

	mininterval =3D min(state->duty_cycle, state->period - state->duty_cycle);
	if (mininterval && mininterval < hrtimer_resolution)
		return -EINVAL;

to catch both cases in a single check.

> +	if (!state->enabled) {
> +		hrtimer_cancel(&gpwm->gpio_timer);
> +	} else if (!gpwm->running) {
> +		/*
> +		 * This just enables the output, but pwm_gpio_toggle()
> +		 * really starts the duty cycle.
> +		 */
> +		int ret =3D gpiod_direction_output(gpwm->gpio, invert);
> +
> +		if (ret)
> +			return ret;
> +	}
> +
> +	spin_lock_irqsave(&gpwm->lock, flags);
> +
> +	if (!state->enabled) {
> +		gpwm->state =3D *state;
> +		gpwm->running =3D false;
> +		gpwm->changing =3D false;
> +
> +		gpiod_set_value(gpwm->gpio, invert);
> +	} else if (gpwm->running) {
> +		gpwm->next_state =3D *state;
> +		gpwm->changing =3D true;
> +	} else {
> +		unsigned long next_toggle;
> +
> +		gpwm->state =3D *state;
> +		gpwm->changing =3D false;
> +
> +		next_toggle =3D pwm_gpio_toggle(gpwm, !!state->duty_cycle);
> +		if (next_toggle) {
> +			hrtimer_start(&gpwm->gpio_timer, next_toggle,
> +				      HRTIMER_MODE_REL);
> +		}

The curly braces can be dropped here and in a few more locations.

> +	}
> +
> +	spin_unlock_irqrestore(&gpwm->lock, flags);
> +
> +	return 0;
> +}
> +
> +static int pwm_gpio_get_state(struct pwm_chip *chip, struct pwm_device *=
pwm,
> +			       struct pwm_state *state)
> +{
> +	struct pwm_gpio *gpwm =3D container_of(chip, struct pwm_gpio, chip);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&gpwm->lock, flags);
> +
> +	if (gpwm->changing)
> +		*state =3D gpwm->next_state;
> +	else
> +		*state =3D gpwm->state;
> +
> +	spin_unlock_irqrestore(&gpwm->lock, flags);
> +
> +	return 0;
> +}
> +
> +static const struct pwm_ops pwm_gpio_ops =3D {
> +	.apply =3D pwm_gpio_apply,
> +	.get_state =3D pwm_gpio_get_state,
> +};
> +
> +static int pwm_gpio_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct pwm_gpio *gpwm;
> +	int ret;
> +
> +	gpwm =3D devm_kzalloc(dev, sizeof(*gpwm), GFP_KERNEL);
> +	if (!gpwm)
> +		return -ENOMEM;
> +
> +	spin_lock_init(&gpwm->lock);
> +
> +	gpwm->gpio =3D devm_gpiod_get(dev, NULL, GPIOD_ASIS);
> +	if (IS_ERR(gpwm->gpio)) {
> +		return dev_err_probe(dev, PTR_ERR(gpwm->gpio),
> +				     "could not get gpio\n");
> +	}
> +
> +	if (gpiod_cansleep(gpwm->gpio)) {
> +		return dev_err_probe(dev, -EINVAL,
> +				     "sleeping GPIO %d not supported\n",
> +				     desc_to_gpio(gpwm->gpio));
> +	}

Is it still state of the art to add gpio numbers to error messages?

> +	gpwm->chip.dev =3D dev;
> +	gpwm->chip.ops =3D &pwm_gpio_ops;
> +	gpwm->chip.npwm =3D 1;
> +	gpwm->chip.atomic =3D true;
> +
> +	hrtimer_init(&gpwm->gpio_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +	gpwm->gpio_timer.function =3D pwm_gpio_timer;
> +
> +	ret =3D pwmchip_add(&gpwm->chip);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "could not add pwmchip\n");
> +
> +	platform_set_drvdata(pdev, gpwm);
> +
> +	return 0;
> +}

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--qooobwxuyeu4bcau
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXAs7wACgkQj4D7WH0S
/k6Eewf/fbsfLpDgN48u2SB5wYgDBrzE1wtKr7rJngfjIaVD+Oczp1o09UdS39z7
q3RnhAYJG5vMFNMkovAyi6nViQ0GERkX7ALcFAfTwC0B5w2uAnwL9P1u+5ONu3kW
FhKGnpXghg3bVLGNVgTdCOhog0Vajj/XeozbPUBLP05POs+7FVzg21/VYoVqzmCj
2ppNmbq8pyOVKez4HY1xzLNXb7NormhiCT02FcpxhR+f+rViAYSe4+7ueAzzwkft
O3vBrLnI16Pt4FbX7xtoaKBk71P+RkGjxcUzpd8ARz0OmF8TadO6dFkI3iK7xlZy
58kfCBe7AAI/Q7nrIMLiK+YqZ3wTIw==
=SeeU
-----END PGP SIGNATURE-----

--qooobwxuyeu4bcau--

