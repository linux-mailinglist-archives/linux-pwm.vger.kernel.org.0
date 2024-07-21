Return-Path: <linux-pwm+bounces-2868-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBF39383B2
	for <lists+linux-pwm@lfdr.de>; Sun, 21 Jul 2024 09:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09197B20C50
	for <lists+linux-pwm@lfdr.de>; Sun, 21 Jul 2024 07:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1934A79F6;
	Sun, 21 Jul 2024 07:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uILMsfn7"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47D233E1
	for <linux-pwm@vger.kernel.org>; Sun, 21 Jul 2024 07:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721545755; cv=none; b=mcJgkRUK+lw0BrCoWTqi1S+r1cT2hwwiJZ/sEQ8E0nhgnLwtwFXhnJufva7RP32TaU4VLa5SiE2vYT6YZT3GYU+6F/Xa9IHQaP5wXzCGLIkaRHswwBSNGgHrJJhm4ykysPbtmgab5qKW3KWmrDR3xFfm428V61LL+S3Sc979Pi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721545755; c=relaxed/simple;
	bh=pMJdIVFXUV0jPyMfrq9r4HmUqfPE8+RVSkprxtzq3bU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HvkaC2UjeXEmzNDv3PRHeJQmWaeM46MetV3PG+BBGH40u+t2+VJYFwbixrfPRN4aMBhd5mf5vaF/JE77rTE5rimkQ5k6JhTD2TMcmq6LIDYgT5JikRiAV5auR642LGlWvXAAWHdHcA7mE89nIYHg2pJjuCxPNek0+6EncdEb0Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uILMsfn7; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5a20de39cfbso2308855a12.1
        for <linux-pwm@vger.kernel.org>; Sun, 21 Jul 2024 00:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721545750; x=1722150550; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UUDgu7D7Ct1nAM9S+bl/Sf6wVjrqY3o5E3DSE4E1Kng=;
        b=uILMsfn78fs8R8/+JL727Kqg4XyVIazld20dVscuxD3uADOY78aPMx6t+HXSQd7jDe
         iqKiRhPHbQj6CyY3jPToHSM8QPSK82CbHFii2MknpxendNqIJCBP+P6CmZIBy7jsNgbr
         xrlp7WmdNWijeZZA5vpmnizpt6qO5xxw8uA0YCPS4YdYZi2ndSJsb1LW+Oo6BjXtTDjY
         7vuokZODGc01QfeeIiQI3v1iv9wwrsph6DSzODd6mDtfmtBgYSHtDBdkhhTae1KIS5s2
         qdGa10YiKipaVVU7KCJCU3hmOvLGw6PKKuuKe2+SuYBfKv34Gw/a7BvFg54j+AzMIX6b
         kURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721545750; x=1722150550;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UUDgu7D7Ct1nAM9S+bl/Sf6wVjrqY3o5E3DSE4E1Kng=;
        b=vYpSNZcog6DC5ljV1vRAW+/Zv7uenqH/xxgKdWhvvC3TVW+rPwsuMCB542TMks34Q4
         BYg+xeBtOSWGPyb/yuG9qpCjOnaAgR28SUYl2TkSbxsL9nwECRA9uyC94Xbju9inZpbD
         o38x4SZMG5d2Pkz7GP0K3T6uwMr2yCr4UC10ns1WCD5g3W1G4tbxM0i0mlgBz/vCG2dn
         3lQXQ6FFIlUkSV6rEkAxZP/lhQ2VY9e6flov2iejWuHegmsJEeIGJar+Ek6bOek7hnc5
         qCmHu/iSm21pPWYmsgFb0fkyNUCKlSh5g+LBgyXuoeFNuAvV8OoAcdRI/C+biDyLLKbo
         rGWw==
X-Forwarded-Encrypted: i=1; AJvYcCU29IA9rZGfuCqtmZHSBaZ7Q0w1oHyjkDKtmEEndB7VtjYfU+cPFt7vbziuuYw+a8grhR78C7b83Oa+kjCVYl+1dOkteCPlB0c4
X-Gm-Message-State: AOJu0YxozOEshR0Hn6p+6zx3JlkTbSkZ8Ix+toCXDIIGzQ3oanC7ngIE
	0DHfxrrGGQctpvYB+1vGXojCDDybTwZ/IX87aeixDOwWQz+DroEI+bGaDGo3gj0=
X-Google-Smtp-Source: AGHT+IECWO1lxZRYT2qdadrixcc6+Dfvn+Es8q3wInLwWOOvOoGPxZb8rEQdmjKisGLzPbLnTl1CNw==
X-Received: by 2002:a50:871d:0:b0:5a1:b0b2:798d with SMTP id 4fb4d7f45d1cf-5a3f089cc4fmr2614907a12.25.1721545749706;
        Sun, 21 Jul 2024 00:09:09 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:4f36:15af:aac:697f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a30aaa3842sm4044283a12.36.2024.07.21.00.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 00:09:09 -0700 (PDT)
Date: Sun, 21 Jul 2024 09:09:07 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Lee Jones <lee@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Rob Herring <robh@kernel.org>, Haibo Chen <haibo.chen@nxp.com>, 
	Clark Wang <xiaoning.wang@nxp.com>, Frank Li <Frank.li@nxp.com>
Subject: Re: [PATCH v5 4/4] pwm: adp5585: Add Analog Devices ADP5585 support
Message-ID: <cc3omm4oaenx6knihusxbez4bntcsa72ht75yvelyyl6irkpwr@uotoqchzdh2o>
References: <20240719203946.22909-1-laurent.pinchart@ideasonboard.com>
 <20240719203946.22909-5-laurent.pinchart@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w2vqc6i5xu3vs527"
Content-Disposition: inline
In-Reply-To: <20240719203946.22909-5-laurent.pinchart@ideasonboard.com>


--w2vqc6i5xu3vs527
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Laurent,

thanks for your reiteration of the series.

Just a few questions and minor suggestions left; see below.

On Fri, Jul 19, 2024 at 11:39:46PM +0300, Laurent Pinchart wrote:
> From: Clark Wang <xiaoning.wang@nxp.com>
>=20
> The ADP5585 is a 10/11 input/output port expander with a built in keypad
> matrix decoder, programmable logic, reset generator, and PWM generator.
> This driver supports the PWM function using the platform device
> registered by the core MFD driver.
>=20
> The driver is derived from an initial implementation from NXP, available
> in commit 113113742208 ("MLK-25922-1 pwm: adp5585: add adp5585 PWM
> support") in their BSP kernel tree. It has been extensively rewritten.
>=20
> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Would your changes justify a Co-developed-by:?

> diff --git a/drivers/pwm/pwm-adp5585.c b/drivers/pwm/pwm-adp5585.c
> new file mode 100644
> index 000000000000..472a4c20b7a9
> --- /dev/null
> +++ b/drivers/pwm/pwm-adp5585.c
> @@ -0,0 +1,189 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Analog Devices ADP5585 PWM driver
> + *
> + * Copyright 2022 NXP
> + * Copyright 2024 Ideas on Board Oy
> + *
> + * Limitations:
> + * - The .apply() operation executes atomically, but may not wait for the
> + *   period to complete (this is not documented and would need to be tes=
ted).

So writing to ADP5585_PWM_OFFT and ADP5585_PWM_ONT is shadowed until
what happens?

> + * - Disabling the PWM drives the output pin to a low level immediately.
> + * - The hardware can only generate normal polarity output.
> + */
> +
> +#include <asm/byteorder.h>
> +
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/math64.h>
> +#include <linux/mfd/adp5585.h>
> +#include <linux/minmax.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/regmap.h>
> +#include <linux/time.h>
> +#include <linux/types.h>
> +
> +#define ADP5585_PWM_CHAN_NUM		1
> +
> +#define ADP5585_PWM_OSC_FREQ_HZ		1000000U
> +#define ADP5585_PWM_MIN_PERIOD_NS	(2ULL * NSEC_PER_SEC / ADP5585_PWM_OSC=
_FREQ_HZ)
> +#define ADP5585_PWM_MAX_PERIOD_NS	(2ULL * 0xffff * NSEC_PER_SEC / ADP558=
5_PWM_OSC_FREQ_HZ)
> +
> +static int pwm_adp5585_request(struct pwm_chip *chip, struct pwm_device =
*pwm)
> +{
> +	struct regmap *regmap =3D pwmchip_get_drvdata(chip);
> +	int ret;
> +
> +	ret =3D regmap_update_bits(regmap, ADP5585_PIN_CONFIG_C,
> +				 ADP5585_R3_EXTEND_CFG_MASK,
> +				 ADP5585_R3_EXTEND_CFG_PWM_OUT);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_update_bits(regmap, ADP5585_GENERAL_CFG,
> +				  ADP5585_OSC_EN, ADP5585_OSC_EN);

The purpose of this function is pinmuxing and oscillator enabling,
right? Would it make sense to enable the oscillator only in .apply() with
=2Eenabled =3D true to save some power?

> +}
> +
> +static void pwm_adp5585_free(struct pwm_chip *chip, struct pwm_device *p=
wm)
> +{
> +	struct regmap *regmap =3D pwmchip_get_drvdata(chip);
> +
> +	regmap_update_bits(regmap, ADP5585_PIN_CONFIG_C,
> +			   ADP5585_R3_EXTEND_CFG_MASK,
> +			   ADP5585_R3_EXTEND_CFG_GPIO4);
> +	regmap_update_bits(regmap, ADP5585_GENERAL_CFG,
> +			   ADP5585_OSC_EN, 0);
> +}
> +
> +static int pwm_adp5585_apply(struct pwm_chip *chip,
> +			     struct pwm_device *pwm,
> +			     const struct pwm_state *state)
> +{
> +	struct regmap *regmap =3D pwmchip_get_drvdata(chip);
> +	u64 period, duty_cycle;
> +	u32 on, off;
> +	__le16 val;
> +	int ret;
> +
> +	if (!state->enabled)
> +		return regmap_update_bits(regmap, ADP5585_PWM_CFG,
> +					  ADP5585_PWM_EN, 0);
> +
> +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> +		return -EINVAL;
> +
> +	if (state->period < ADP5585_PWM_MIN_PERIOD_NS)
> +		return -EINVAL;
> +
> +	period =3D min(state->period, ADP5585_PWM_MAX_PERIOD_NS);
> +	duty_cycle =3D min(state->duty_cycle, period);
> +
> +	/*
> +	 * Compute the on and off time. As the internal oscillator frequency is
> +	 * 1MHz, the calculation can be simplified without loss of precision.
> +	 */
> +	on =3D div_u64(duty_cycle, NSEC_PER_SEC / ADP5585_PWM_OSC_FREQ_HZ);
> +	off =3D div_u64(period, NSEC_PER_SEC / ADP5585_PWM_OSC_FREQ_HZ) - on;
> +
> +	val =3D cpu_to_le16(off);
> +	ret =3D regmap_bulk_write(regmap, ADP5585_PWM_OFFT_LOW, &val, 2);
> +	if (ret)
> +		return ret;
> +
> +	val =3D cpu_to_le16(on);
> +	ret =3D regmap_bulk_write(regmap, ADP5585_PWM_ONT_LOW, &val, 2);
> +	if (ret)
> +		return ret;
> +
> +	/* Enable PWM in continuous mode and no external AND'ing. */
> +	ret =3D regmap_update_bits(regmap, ADP5585_PWM_CFG,
> +				 ADP5585_PWM_IN_AND | ADP5585_PWM_MODE |
> +				 ADP5585_PWM_EN, ADP5585_PWM_EN);
> +	if (ret)
> +		return ret;
> +
> +	return 0;

This could be simplified to just:

	return regmap_update_bits(...);

(but some people feel strong here, so just a suggestion)

> +}
> +
> +static int pwm_adp5585_get_state(struct pwm_chip *chip,
> +				 struct pwm_device *pwm,
> +				 struct pwm_state *state)
> +{
> +	struct regmap *regmap =3D pwmchip_get_drvdata(chip);
> +	unsigned int on, off;
> +	unsigned int val;
> +	__le16 on_off;
> +	int ret;
> +
> +	ret =3D regmap_bulk_read(regmap, ADP5585_PWM_OFFT_LOW, &on_off, 2);
> +	if (ret)
> +		return ret;
> +	off =3D le16_to_cpu(on_off);
> +
> +	ret =3D regmap_bulk_read(regmap, ADP5585_PWM_ONT_LOW, &on_off, 2);
> +	if (ret)
> +		return ret;
> +	on =3D le16_to_cpu(on_off);
> +
> +	state->duty_cycle =3D on * (NSEC_PER_SEC / ADP5585_PWM_OSC_FREQ_HZ);
> +	state->period =3D (on + off) * (NSEC_PER_SEC / ADP5585_PWM_OSC_FREQ_HZ);
> +
> +	state->polarity =3D PWM_POLARITY_NORMAL;
> +
> +	regmap_read(regmap, ADP5585_PWM_CFG, &val);
> +	state->enabled =3D !!(val & ADP5585_PWM_EN);
> +
> +	return 0;
> +}
> +
> +static const struct pwm_ops adp5585_pwm_ops =3D {
> +	.request =3D pwm_adp5585_request,
> +	.free =3D pwm_adp5585_free,
> +	.apply =3D pwm_adp5585_apply,
> +	.get_state =3D pwm_adp5585_get_state,
> +};
> +
> +static int adp5585_pwm_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct adp5585_dev *adp5585 =3D dev_get_drvdata(dev->parent);
> +	struct pwm_chip *chip;
> +	int ret;
> +
> +	chip =3D devm_pwmchip_alloc(dev, ADP5585_PWM_CHAN_NUM, 0);

ADP5585_PWM_CHAN_NUM is only used once. I would prefer passing a plain 1
here, as this makes the output of $(grep devm_pwmchip_alloc) a bit more
useful.

> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +
> +	device_set_of_node_from_dev(dev, dev->parent);
> +
> +	pwmchip_set_drvdata(chip, adp5585->regmap);
> +	chip->ops =3D &adp5585_pwm_ops;
> +
> +	ret =3D devm_pwmchip_add(dev, chip);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to add PWM chip\n");
> +
> +	return 0;
> +}
> +
> +static const struct platform_device_id adp5585_pwm_id_table[] =3D {
> +	{ "adp5585-pwm" },
> +	{ /* Sentinel */ },

The trailing comma should be dropped here.

> +};
> +MODULE_DEVICE_TABLE(platform, adp5585_pwm_id_table);
> +
> +static struct platform_driver adp5585_pwm_driver =3D {
> +	.driver	=3D {
> +		.name =3D "adp5585-pwm",
> +	},
> +	.probe =3D adp5585_pwm_probe,
> +	.id_table =3D adp5585_pwm_id_table,
> +};
> +module_platform_driver(adp5585_pwm_driver);
> +
> +MODULE_AUTHOR("Xiaoning Wang <xiaoning.wang@nxp.com>");
> +MODULE_DESCRIPTION("ADP5585 PWM Driver");
> +MODULE_LICENSE("GPL");

Thanks
Uwe

--w2vqc6i5xu3vs527
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmactBAACgkQj4D7WH0S
/k5GhQf/T0W255qx1/fAMkVpmRQ4+r1A+CRpUEOBXfOOFQuF4/g5qjsviPUZzGZj
aERxHd2wOGrxO+9Qak6o3pXbA7O3UJl6CjYiCwfgfOZfFdaJI7yZAlyG9XSDXWAQ
wDscjrTmSRaC812MT8/UuIoBl2kWJRa57PzrLqDmmh/oCG0XpzbIs4MIaB5jyz2/
TOMPTL/0xZFLUDn39s+DqlyUi1QtpJE9JAfQYFs0Rvcj/ZZOdqm7fVaj3ZN72/WO
uUTPM9xY323XHWLGL6rm2pnPfKqrz1o6GLiqkOg5z4TvAj7m0a+pB4150vjGY0XP
cHKLUVTiqVP1cEJbAPCw0J/W+MH1cQ==
=/hhJ
-----END PGP SIGNATURE-----

--w2vqc6i5xu3vs527--

