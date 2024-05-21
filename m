Return-Path: <linux-pwm+bounces-2202-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 943C08CAA5F
	for <lists+linux-pwm@lfdr.de>; Tue, 21 May 2024 10:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F9251C214E6
	for <lists+linux-pwm@lfdr.de>; Tue, 21 May 2024 08:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958C357C85;
	Tue, 21 May 2024 08:51:39 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BF356771
	for <linux-pwm@vger.kernel.org>; Tue, 21 May 2024 08:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716281499; cv=none; b=iGrSMuL7E7ux3DoiQGCZY9G2rS9gwb4M+T8e0PRZPeERrGoHO0rlmenFSS67yVaKBndCxzDTlOqlbv8HK7qGaHM/xN6zwwG3IJQgAhHWuihdPeT6nQ+4gB/qBfz/qkyqBjPeic0wMFA7xoeZ8AhlidAshmRLd2DvmELlfXZVgjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716281499; c=relaxed/simple;
	bh=rS3UVYhGZuhcoa6yECMf2xlQPlWNMlzpfZZdREAOwiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6NO2CiZXD6vUKYANqrb84m5fx5iU0oJwpmqIfYHLBkg16YLIBzdaLY0sC6039cfCuN9Xl3eBNNX+LNgQrzGpK1F5LCV6l3AUr5057BZGE7v/VWUr3yRTmtJHtV5tRCzEbzdBlfQYpzt/jmnP3A5zbvD9vUisKIApxB4872a1h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1s9LDV-0004UJ-1r; Tue, 21 May 2024 10:51:29 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1s9LDS-002MiS-Tt; Tue, 21 May 2024 10:51:26 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1s9LDS-009MhI-2g;
	Tue, 21 May 2024 10:51:26 +0200
Date: Tue, 21 May 2024 10:51:26 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	Alexandru Ardelean <alexandru.ardelean@analog.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Lee Jones <lee@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Rob Herring <robh@kernel.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Clark Wang <xiaoning.wang@nxp.com>
Subject: Re: [PATCH 5/5] pwm: adp5585: Add Analog Devices ADP5585 support
Message-ID: <dl7a6puox5lc36fpto2fgyfgmpd3uboqc4lcfdtuaxzzsboqld@alw7vyi7pqjz>
References: <20240520195942.11582-1-laurent.pinchart@ideasonboard.com>
 <20240520195942.11582-6-laurent.pinchart@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f7l4z7wuw4trzvr4"
Content-Disposition: inline
In-Reply-To: <20240520195942.11582-6-laurent.pinchart@ideasonboard.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--f7l4z7wuw4trzvr4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Laurent,

On Mon, May 20, 2024 at 10:59:41PM +0300, Laurent Pinchart wrote:
> diff --git a/drivers/pwm/pwm-adp5585.c b/drivers/pwm/pwm-adp5585.c
> new file mode 100644
> index 000000000000..709713d8f47a
> --- /dev/null
> +++ b/drivers/pwm/pwm-adp5585.c
> @@ -0,0 +1,230 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Analog Devices ADP5585 PWM driver
> + *
> + * Copyright 2022 NXP
> + * Copyright 2024 Ideas on Board Oy
> + */

Please document some hardware properties here in the same format as many
other PWM drivers. The things I'd like to read there are:

 - Only supports normal polarity
 - How does the output pin behave when the hardware is disabled
   (typically "low" or "high-Z" or "freeze")
 - Does changing parameters or disabling complete the currently running
   period?
 - Are there glitches in .apply()? E.g. when the new duty_cycle is
   already written but the new period is not.

> +#include <linux/container_of.h>
> +#include <linux/device.h>
> +#include <linux/math.h>
> +#include <linux/minmax.h>
> +#include <linux/mfd/adp5585.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/regmap.h>
> +#include <linux/time.h>

Do you need these all? I wounder about time.h.

> +#define ADP5585_PWM_CHAN_NUM		1
> +
> +#define ADP5585_PWM_OSC_FREQ_HZ		1000000U
> +#define ADP5585_PWM_MIN_PERIOD_NS	(2ULL * NSEC_PER_SEC / ADP5585_PWM_OSC=
_FREQ_HZ)
> +#define ADP5585_PWM_MAX_PERIOD_NS	(2ULL * 0xffff * NSEC_PER_SEC / ADP558=
5_PWM_OSC_FREQ_HZ)
> +
> +struct adp5585_pwm_chip {
> +	struct pwm_chip chip;
> +	struct regmap *regmap;
> +	struct mutex lock;

What does this mutex protect against? You can safely assume that there
are no concurrent calls of the callbacks. (This isn't ensured yet, but I
consider a consumer who does this buggy and it will soon be ensured.)

> +	u8 pin_config_val;
> +};
> +
> +static inline struct adp5585_pwm_chip *
> +to_adp5585_pwm_chip(struct pwm_chip *chip)
> +{
> +	return container_of(chip, struct adp5585_pwm_chip, chip);
> +}
> +
> +static int pwm_adp5585_request(struct pwm_chip *chip, struct pwm_device =
*pwm)
> +{
> +	struct adp5585_pwm_chip *adp5585_pwm =3D to_adp5585_pwm_chip(chip);
> +	unsigned int val;
> +	int ret;
> +
> +	guard(mutex)(&adp5585_pwm->lock);
> +
> +	ret =3D regmap_read(adp5585_pwm->regmap, ADP5585_PIN_CONFIG_C, &val);
> +	if (ret)
> +		return ret;
> +
> +	adp5585_pwm->pin_config_val =3D val;
> +
> +	ret =3D regmap_update_bits(adp5585_pwm->regmap, ADP5585_PIN_CONFIG_C,
> +				 ADP5585_R3_EXTEND_CFG_MASK,
> +				 ADP5585_R3_EXTEND_CFG_PWM_OUT);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_update_bits(adp5585_pwm->regmap, ADP5585_GENERAL_CFG,
> +				 ADP5585_OSC_EN, ADP5585_OSC_EN);
> +	if (ret)
> +		return ret;
> +
> +	return 0;

The last four lines are equivalent to

	return ret;

What is the purpose of this function? Setup some kind of pinmuxing? The
answer to that question goes into a code comment. If it's pinmuxing, is
this a hint to use the pinctrl subsystem? (Maybe it's overkill, but if
it's considered a good idea later, it might be hard to extend the dt
bindings, so thinking about that now might be a good idea.)

> +}
> +
> +static void pwm_adp5585_free(struct pwm_chip *chip, struct pwm_device *p=
wm)
> +{
> +	struct adp5585_pwm_chip *adp5585_pwm =3D to_adp5585_pwm_chip(chip);
> +
> +	guard(mutex)(&adp5585_pwm->lock);
> +
> +	regmap_update_bits(adp5585_pwm->regmap, ADP5585_PIN_CONFIG_C,
> +			   ADP5585_R3_EXTEND_CFG_MASK,
> +			   adp5585_pwm->pin_config_val);

I wonder if writing a deterministic value instead of whatever was in
that register before .request() would be more robust and less
surprising.

> +	regmap_update_bits(adp5585_pwm->regmap, ADP5585_GENERAL_CFG,
> +			   ADP5585_OSC_EN, 0);
> +}
> +
> +static int pwm_adp5585_apply(struct pwm_chip *chip,
> +			     struct pwm_device *pwm,
> +			     const struct pwm_state *state)
> +{
> +	struct adp5585_pwm_chip *adp5585_pwm =3D to_adp5585_pwm_chip(chip);
> +	u32 on, off;
> +	int ret;
> +
> +	if (!state->enabled) {
> +		guard(mutex)(&adp5585_pwm->lock);
> +
> +		return regmap_update_bits(adp5585_pwm->regmap, ADP5585_PWM_CFG,
> +					  ADP5585_PWM_EN, 0);
> +	}
> +
> +	if (state->period < ADP5585_PWM_MIN_PERIOD_NS ||
> +	    state->period > ADP5585_PWM_MAX_PERIOD_NS)
> +		return -EINVAL;

Make this:

	if (state->period < ADP5585_PWM_MIN_PERIOD_NS)
		return -EINVAL;

	period =3D min(ADP5585_PWM_MAX_PERIOD_NS, state->period)
	duty_cycle =3D min(period, state->period);

> +
> +	/*
> +	 * Compute the on and off time. As the internal oscillator frequency is
> +	 * 1MHz, the calculation can be simplified without loss of precision.
> +	 */
> +	on =3D DIV_ROUND_CLOSEST_ULL(state->duty_cycle,
> +				   NSEC_PER_SEC / ADP5585_PWM_OSC_FREQ_HZ);
> +	off =3D DIV_ROUND_CLOSEST_ULL(state->period - state->duty_cycle,
> +				    NSEC_PER_SEC / ADP5585_PWM_OSC_FREQ_HZ);

round-closest is wrong. Testing with PWM_DEBUG should point that out.
The right algorithm is:

	on =3D duty_cycle / (NSEC_PER_SEC / ADP5585_PWM_OSC_FREQ_HZ)
	off =3D period / (NSEC_PER_SEC / ADP5585_PWM_OSC_FREQ_HZ) - on


> +	if (state->polarity =3D=3D PWM_POLARITY_INVERSED)
> +		swap(on, off);

Uhh, no. Either you can do inverted polarity or you cannot. Don't claim
you can.

> [...]
> +static int adp5585_pwm_probe(struct platform_device *pdev)
> +{
> +	struct adp5585_dev *adp5585 =3D dev_get_drvdata(pdev->dev.parent);
> +	struct adp5585_pwm_chip *adp5585_pwm;
> +	int ret;
> +
> +	adp5585_pwm =3D devm_kzalloc(&pdev->dev, sizeof(*adp5585_pwm), GFP_KERN=
EL);
> +	if (!adp5585_pwm)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, adp5585_pwm);
> +
> +	adp5585_pwm->regmap =3D adp5585->regmap;
> +
> +	mutex_init(&adp5585_pwm->lock);
> +
> +	adp5585_pwm->chip.dev =3D &pdev->dev;
> +	adp5585_pwm->chip.ops =3D &adp5585_pwm_ops;
> +	adp5585_pwm->chip.npwm =3D ADP5585_PWM_CHAN_NUM;

That is wrong since commit
05947224ff46 ("pwm: Ensure that pwm_chips are allocated using pwmchip_alloc=
()")

> +	ret =3D devm_pwmchip_add(&pdev->dev, &adp5585_pwm->chip);
> +	if (ret) {
> +		mutex_destroy(&adp5585_pwm->lock);
> +		return dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
> +	}
> +
> +	return 0;
> +}
> +
> +static void adp5585_pwm_remove(struct platform_device *pdev)
> +{
> +	struct adp5585_pwm_chip *adp5585_pwm =3D platform_get_drvdata(pdev);
> +
> +	mutex_destroy(&adp5585_pwm->lock);

Huh, this is a bad idea. The mutex is gone while the pwmchip is still
registered. AFAIK calling mutex_destroy() is optional, and
adp5585_pwm_remove() can just be dropped. Ditto in the error paths of
=2Eprobe().

> +}
> +
> +static const struct of_device_id adp5585_pwm_of_match[] =3D {
> +	{ .compatible =3D "adi,adp5585-pwm" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, adp5585_pwm_of_match);

Is it normal/usual for mfd drivers to use of stuff? I thought they use
plain platform style binding, not sure though.

> +static struct platform_driver adp5585_pwm_driver =3D {
> +	.driver	=3D {
> +		.name =3D "adp5585-pwm",
> +		.of_match_table =3D adp5585_pwm_of_match,
> +	},
> +	.probe =3D adp5585_pwm_probe,
> +	.remove_new =3D adp5585_pwm_remove,
> +};
> +module_platform_driver(adp5585_pwm_driver);
> +
> +MODULE_AUTHOR("Xiaoning Wang <xiaoning.wang@nxp.com>");
> +MODULE_DESCRIPTION("ADP5585 PWM Driver");
> +MODULE_LICENSE("GPL");

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--f7l4z7wuw4trzvr4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmZMYI0ACgkQj4D7WH0S
/k5o2ggAn5MfFbCQP7ri49/q/bz5rZE9zGc3gzfL9Bpoe58kY4ehkuNQU9nNNFLI
Xzz7HWAKjj/kdl//C3bjDN2pxLGWicD0XQurcNncJ6eZJ8ZutQMkCDSGyDrDqge8
s09gq0w5155lkVHQ7JlsubNTg6EjgnYJYeH0PDXd7KLUG8z6lvmHjsbtO+aK5RRy
TiMmZYCiQL8vpP++Hxp49hYEWJEGlfcKuAms26DTBHY4rbZ5SuL8OVG4uK5AB2zF
Tlh86xzjO4MaHHCSvGpJbyEgjpbFP2CFeIK2xTSxRXHpS88m7nRt2KAFyn7Tv/fB
a92OAk1aCppi3eDqvWJKGFA6VGXd5w==
=GkWI
-----END PGP SIGNATURE-----

--f7l4z7wuw4trzvr4--

