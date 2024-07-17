Return-Path: <linux-pwm+bounces-2842-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9580C933993
	for <lists+linux-pwm@lfdr.de>; Wed, 17 Jul 2024 11:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1A101F230C0
	for <lists+linux-pwm@lfdr.de>; Wed, 17 Jul 2024 09:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4055B3A8D8;
	Wed, 17 Jul 2024 09:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wOdKmyPb"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A758C37160
	for <linux-pwm@vger.kernel.org>; Wed, 17 Jul 2024 09:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721207099; cv=none; b=q5UjbQeRFlWVU+0gVCbZ+mQDpW/PEIhFKBx6PtT36FTfay2s3oGzAIHfLfdRVxZePQNkMLdnljBfN4fIc8uNUkTwfv832GGejiktwTUOHjuN+2LVU/Tfss3knb2042zRQoEqGgvq5h8IeZxhXZ8dnqagi+pJ6ugyCMiI9awxfzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721207099; c=relaxed/simple;
	bh=Y9eH/S3ugDQ2qJBXk0sZV6jyY+jTBizijLU8n6zxjuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3YGCUrMREIofzvaI+5gJ0UP1A+0/xPRYu82M33o/xJGvboAQPxcbKH7kK+ir3qH9CMS7wehQ3qMkCcmDFY7LxviDptx6kz0wxwuTIpYNLunbIy/njmh8QcNMSzVkOaQABp8mGq8hi67ZlpOxQfcvuK+TjtnqKHAi21dmbQsvFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=wOdKmyPb; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52e94eaf5efso8290708e87.2
        for <linux-pwm@vger.kernel.org>; Wed, 17 Jul 2024 02:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721207094; x=1721811894; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+REiBdUt9fLTjTn3aZcwCqL9kZgI0FUrI3zxX22R/T0=;
        b=wOdKmyPbx6f8MK8735gWzw0Xyrl0NoKmXlsQWySeu8IT+keUhrspWcOspTRYFiGO6R
         +ncLjviuaVDVUdrkK9SFb2yRx+D/aLcvf9iq/5wYATJ7PC0yL4U5xIQl6sEsesovlrHD
         N7Xjm3BjYZA2JfoMtfF0CH8SyTv+nNKLnomNNF+Dley43zk9OeKkB2UiIJbyKRaf25f+
         B5ll2IqtVNmbwSj/rXMgoZWr3PF/fro2rwmj+9wgA4m3IRLKTMdd1CuTDwnahg727GPv
         ARcq50IXC/6ifI28A7qwQ9N4O3tifqadkdNvhi/cHku/Cz/Kqmo1j93bgfY3Cvz8zbu8
         whxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721207094; x=1721811894;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+REiBdUt9fLTjTn3aZcwCqL9kZgI0FUrI3zxX22R/T0=;
        b=wWimKTDEGwZJbh6jyFco/tSp3cF6MxIcjE7RzdPw1yP7sBTxQmCaJAOoXAh+nzHUSN
         EZiRP0+Kj9iVowul0kxbQAUcIQom/DQD7iubKWBIA6A7yiAVE5jpUsJUs6rO0gwtLsw2
         S2XmeydfNlnXCUC0YM66ukjxPSxmelePDIitXmTCwwZ8NAUcuDGF7ndwskEeRtxsRBNW
         VRbhFPu/vbIjSLAIPtt3lFWZ8HYiYIJdyU3Jo9xPYkxfpDjfp36uL2e2QbVdiT2/QP7r
         s8S2UZv0g7GiAuamog0au0exyVlypqD8u99eqjbNSn0hhO1/WWMHyulG08a1HQMWFif2
         0Bnw==
X-Forwarded-Encrypted: i=1; AJvYcCVlwD1vYz4JLgTGL857RIVO3TbF/Y8PgL8xRfo02feu9/D7Tp7J8Pc2wPRsHKX9UDcUb3Aq+A+Cg9UwURRU8sPhj5wJDr0tILZx
X-Gm-Message-State: AOJu0YyFlnj5HQRcRJewkDic3ma43UamfM+IbA81gDJWtdUs6iqWJfXE
	tGCH/8P8iZRDhu109K5pQ1+0P7D1UvW2WXb8d9/Au756rhNVcUItdPdOf2g/Utw=
X-Google-Smtp-Source: AGHT+IE1MQcw5XqPWmhELteUJAGg6G/f7zdNsvsFs5aYx4eY3O1yvitQtH1A6wC9h6Vq5TO1tIGkHg==
X-Received: by 2002:a05:6512:3f16:b0:52c:e01f:3665 with SMTP id 2adb3069b0e04-52ee53b15eemr833414e87.25.1721207093377;
        Wed, 17 Jul 2024 02:04:53 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc5d202fsm421896666b.78.2024.07.17.02.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 02:04:52 -0700 (PDT)
Date: Wed, 17 Jul 2024 11:04:50 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	Clark Wang <xiaoning.wang@nxp.com>, Haibo Chen <haibo.chen@nxp.com>, 
	Jindong Yue <jindong.yue@nxp.com>
Subject: Re: [PATCH 4/6] pwm: adp5585: add adp5585 PWM support
Message-ID: <u7xii4lfvjk6gbpmq7qtqckoznddiyno7xsaa74ufuxwdob532@wxuawwiwjpgm>
References: <20240716-adi-v1-0-79c0122986e7@nxp.com>
 <20240716-adi-v1-4-79c0122986e7@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ehgbnkhnzwpb5gdt"
Content-Disposition: inline
In-Reply-To: <20240716-adi-v1-4-79c0122986e7@nxp.com>


--ehgbnkhnzwpb5gdt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Clark,

On Tue, Jul 16, 2024 at 03:28:27PM -0400, Frank Li wrote:
> From: Clark Wang <xiaoning.wang@nxp.com>
>=20
> Add PWM function support for MFD adp5585.
>=20
> Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> Signed-off-by: Jindong Yue <jindong.yue@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pwm/Kconfig       |   8 ++
>  drivers/pwm/Makefile      |   1 +
>  drivers/pwm/pwm-adp5585.c | 215 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 224 insertions(+)
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 3e53838990f5b..baaadf877b9c6 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -38,6 +38,14 @@ config PWM_DEBUG
>  	  It is expected to introduce some runtime overhead and diagnostic
>  	  output to the kernel log, so only enable while working on a driver.
> =20
> +config PWM_ADP5585
> +	tristate "ADP5585 PWM support"
> +	depends on MFD_ADP5585
> +	help
> +	  This option enables support for on-chip PWM found
> +	  on Analog Devices ADP5585.
> +
> +
>  config PWM_AB8500
>  	tristate "AB8500 PWM support"
>  	depends on AB8500_CORE && ARCH_U8500

alphabetic ordering (by config symbol) please.

> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 0be4f3e6dd432..161131a261e94 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -2,6 +2,7 @@
>  obj-$(CONFIG_PWM)		+=3D core.o
>  obj-$(CONFIG_PWM_AB8500)	+=3D pwm-ab8500.o
>  obj-$(CONFIG_PWM_APPLE)		+=3D pwm-apple.o
> +obj-$(CONFIG_PWM_ADP5585)	+=3D pwm-adp5585.o
>  obj-$(CONFIG_PWM_ATMEL)		+=3D pwm-atmel.o
>  obj-$(CONFIG_PWM_ATMEL_HLCDC_PWM)	+=3D pwm-atmel-hlcdc.o
>  obj-$(CONFIG_PWM_ATMEL_TCB)	+=3D pwm-atmel-tcb.o

alphabetic ordering please.

> diff --git a/drivers/pwm/pwm-adp5585.c b/drivers/pwm/pwm-adp5585.c
> new file mode 100644
> index 0000000000000..f578d24df5c74
> --- /dev/null
> +++ b/drivers/pwm/pwm-adp5585.c
> @@ -0,0 +1,215 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * PWM driver for Analog Devices ADP5585 MFD
> + *
> + * Copyright 2024 NXP
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/mfd/adp5585.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/slab.h>
> +#include <linux/time.h>
> +
> +#define ADP5585_PWM_CHAN_NUM		1

This is only used once. I'd prefer to pass the 1 verbatim to
pwmchip_alloc.

> +#define ADP5585_PWM_FASTEST_PERIOD_NS	2000
> +#define ADP5585_PWM_SLOWEST_PERIOD_NS	131070000

Funny number. I wonder where this comes from.

> +struct adp5585_pwm_chip {
> +	struct device *parent;
> +	struct mutex lock;
> +	u8 pin_config_val;
> +};
> +
> +static inline struct adp5585_pwm_chip *
> +to_adp5585_pwm_chip(struct pwm_chip *chip)
> +{
> +	return pwmchip_get_drvdata(chip);
> +}
> +
> +static int adp5585_pwm_reg_read(struct adp5585_pwm_chip *adp5585_pwm, u8=
 reg, u8 *val)
> +{
> +	struct adp5585_dev *adp5585  =3D dev_get_drvdata(adp5585_pwm->parent);

s/  / /;
ditto below in adp5585_pwm_reg_write().

> +
> +	return adp5585->read_reg(adp5585, reg, val);
> +}
> +
> +static int adp5585_pwm_reg_write(struct adp5585_pwm_chip *adp5585_pwm, u=
8 reg, u8 val)
> +{
> +	struct adp5585_dev *adp5585  =3D dev_get_drvdata(adp5585_pwm->parent);
> +
> +	return adp5585->write_reg(adp5585, reg, val);
> +}
> +
> +static int pwm_adp5585_get_state(struct pwm_chip *chip, struct pwm_devic=
e *pwm,
> +				 struct pwm_state *state)
> +{
> +	struct adp5585_pwm_chip *adp5585_pwm =3D to_adp5585_pwm_chip(chip);
> +	u32 on, off;
> +	u8 temp;
> +
> +	/* get period */
> +	adp5585_pwm_reg_read(adp5585_pwm, ADP5585_PWM_OFFT_LOW, &temp);
> +	off =3D temp;
> +	adp5585_pwm_reg_read(adp5585_pwm, ADP5585_PWM_OFFT_HIGH, &temp);
> +	off |=3D temp << 8;
> +	adp5585_pwm_reg_read(adp5585_pwm, ADP5585_PWM_ONT_LOW, &temp);
> +	on =3D temp;
> +	adp5585_pwm_reg_read(adp5585_pwm, ADP5585_PWM_ONT_HIGH, &temp);
> +	on |=3D temp << 8;
> +	state->period =3D (on + off) * NSEC_PER_USEC;
> +
> +	state->duty_cycle =3D on;
> +	state->polarity =3D PWM_POLARITY_NORMAL;
> +
> +	/* get channel status */
> +	adp5585_pwm_reg_read(adp5585_pwm, ADP5585_PWM_CFG, &temp);
> +	state->enabled =3D temp & ADP5585_PWM_CFG_EN;
> +
> +	return 0;
> +}
> +
> +static int pwm_adp5585_apply(struct pwm_chip *chip,
> +			     struct pwm_device *pwm,
> +			     const struct pwm_state *state)
> +{
> +	struct adp5585_pwm_chip *adp5585_pwm =3D to_adp5585_pwm_chip(chip);
> +	u32 on, off;
> +	u8 enabled;
> +	int ret;
> +
> +	if (state->period > ADP5585_PWM_SLOWEST_PERIOD_NS ||
> +	    state->period < ADP5585_PWM_FASTEST_PERIOD_NS)
> +		return -EINVAL;
> +
> +	guard(mutex)(&adp5585_pwm->lock);

What does this protect? You're allowed (and expected) to assume that the
consumer serializes calls to .apply() for a single pwm_device. Given
that you have npwm=3D1 I think this lock can be dropped.

> +	/* set on/off cycle*/
> +	on =3D DIV_ROUND_CLOSEST_ULL(state->duty_cycle, NSEC_PER_USEC);
> +	off =3D DIV_ROUND_CLOSEST_ULL((state->period - state->duty_cycle), NSEC=
_PER_USEC);

Please enable PWM_DEBUG your tests and make sure it doesn't produce
warnings. (Hint: round_closest is wrong)

> +	ret =3D adp5585_pwm_reg_write(adp5585_pwm, ADP5585_PWM_OFFT_LOW, off & =
ADP5585_REG_MASK);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D adp5585_pwm_reg_write(adp5585_pwm, ADP5585_PWM_OFFT_HIGH,
> +				    (off >> 8) & ADP5585_REG_MASK);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D adp5585_pwm_reg_write(adp5585_pwm, ADP5585_PWM_ONT_LOW, on & AD=
P5585_REG_MASK);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D adp5585_pwm_reg_write(adp5585_pwm, ADP5585_PWM_ONT_HIGH,
> +				    (on >> 8) & ADP5585_REG_MASK);
> +	if (ret)
> +		return ret;

How does the hardware behave in between these register writes? Can it
happen that an intermediate state is visible on the output pin? (E.g.
because off is already written but on is still the old value. Or even
off is only partly written after the first byte write.)

Please document this behaviour in a paragraph at the top of the driver
in the same way as many other PWM drivers do it. The details should be
extractable by

	sed -rn '/Limitations:/,/\*\/?$/p' drivers/pwm/*.c

> +
> +	/* enable PWM and set to continuous PWM mode*/

Missing space before comment ending delimiter

> +	adp5585_pwm_reg_read(adp5585_pwm, ADP5585_PWM_CFG, &enabled);
> +	if (state->enabled)
> +		ret =3D adp5585_pwm_reg_write(adp5585_pwm, ADP5585_PWM_CFG, ADP5585_PW=
M_CFG_EN);
> +	else
> +		ret =3D adp5585_pwm_reg_write(adp5585_pwm, ADP5585_PWM_CFG, 0);
> +
> +	return ret;
> +}
> +
> +static int pwm_adp5585_request(struct pwm_chip *chip, struct pwm_device =
*pwm)
> +{
> +	struct adp5585_pwm_chip *adp5585_pwm =3D to_adp5585_pwm_chip(chip);
> +	u8 reg_cfg;
> +	int ret;
> +
> +	guard(mutex)(&adp5585_pwm->lock);
> +
> +	adp5585_pwm_reg_read(adp5585_pwm, ADP5585_PIN_CONFIG_C, &adp5585_pwm->p=
in_config_val);
> +	reg_cfg =3D adp5585_pwm->pin_config_val & ~ADP5585_PIN_CONFIG_R3_MASK;
> +	reg_cfg |=3D ADP5585_PIN_CONFIG_R3_PWM;
> +	ret =3D adp5585_pwm_reg_write(adp5585_pwm, ADP5585_PIN_CONFIG_C, reg_cf=
g);

ret is only written to here, ditto for &adp5585_pwm->pin_config_val.

> +
> +	adp5585_pwm_reg_read(adp5585_pwm, ADP5585_GENERAL_CFG, &adp5585_pwm->pi=
n_config_val);
> +	reg_cfg |=3D ADP5585_GENERAL_CFG_OSC_EN;
> +	ret =3D adp5585_pwm_reg_write(adp5585_pwm, ADP5585_GENERAL_CFG, reg_cfg=
);

Please add a comment about what is happening here. I assume this sets up
pinmuxing and enabled the oscillator. I wonder if it is sensible to do
the latter only in .apply() iff state->enabled =3D true.

> +
> +	return ret;
> +}
> +
> +static void pwm_adp5585_free(struct pwm_chip *chip, struct pwm_device *p=
wm)
> +{
> +	struct adp5585_pwm_chip *adp5585_pwm =3D to_adp5585_pwm_chip(chip);
> +	u8 reg_cfg;
> +
> +	guard(mutex)(&adp5585_pwm->lock);
> +
> +	adp5585_pwm_reg_read(adp5585_pwm, ADP5585_PIN_CONFIG_C, &reg_cfg);
> +	reg_cfg &=3D ~ADP5585_PIN_CONFIG_R3_MASK;
> +	reg_cfg |=3D adp5585_pwm->pin_config_val & ADP5585_PIN_CONFIG_R3_MASK;
> +	adp5585_pwm_reg_write(adp5585_pwm, ADP5585_PIN_CONFIG_C, reg_cfg);

It would be consequent to clear ADP5585_GENERAL_CFG_OSC_EN in this
function given that it's set in .request().

> +}
> +
> +static const struct pwm_ops adp5585_pwm_ops =3D {
> +	.request =3D pwm_adp5585_request,
> +	.free =3D pwm_adp5585_free,
> +	.get_state =3D pwm_adp5585_get_state,
> +	.apply =3D pwm_adp5585_apply,
> +};
> +
> +static int adp5585_pwm_probe(struct platform_device *pdev)
> +{
> +	struct adp5585_pwm_chip *adp5585_pwm;
> +	struct pwm_chip *chip;
> +	unsigned int npwm =3D ADP5585_PWM_CHAN_NUM;
> +	int ret;
> +
> +	chip =3D devm_pwmchip_alloc(&pdev->dev, npwm, sizeof(*adp5585_pwm));
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);

Error message using dev_err_probe() please.

> +
> +	adp5585_pwm =3D to_adp5585_pwm_chip(chip);
> +	adp5585_pwm->parent =3D pdev->dev.parent;
> +
> +	platform_set_drvdata(pdev, adp5585_pwm);
> +
> +	chip->ops =3D &adp5585_pwm_ops;
> +	mutex_init(&adp5585_pwm->lock);
> +
> +	ret =3D devm_pwmchip_add(&pdev->dev, chip);
> +	if (ret)
> +		dev_err(&pdev->dev, "failed to add PWM chip: %d\n", ret);

Please use dev_err_probe().

> +
> +	return ret;
> +}
> +
> +static void adp5585_pwm_remove(struct platform_device *pdev)
> +{
> +	struct pwm_chip *chip =3D platform_get_drvdata(pdev);
> +
> +	pwmchip_remove(chip);

Did you test this? I'd expect this to explode.

> +}
> +
> +static const struct of_device_id adp5585_pwm_of_match[] =3D {
> +	{.compatible =3D "adp5585-pwm", },

Missing space after the opening brace.

> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, adp5585_pwm_of_match);
> +
> +static struct platform_driver adp5585_pwm_driver =3D {
> +	.driver	=3D {
> +		.name	=3D "adp5585-pwm",
> +		.of_match_table =3D adp5585_pwm_of_match,
> +	},
> +	.probe		=3D adp5585_pwm_probe,
> +	.remove		=3D adp5585_pwm_remove,
> +};
> +module_platform_driver(adp5585_pwm_driver);
> +
> +MODULE_AUTHOR("Xiaoning Wang <xiaoning.wang@nxp.com>");

The email address matches one of the S-o-b lines, the name however is
different. Is this by mistake?

> +MODULE_DESCRIPTION("ADP5585 PWM Driver");
> +MODULE_LICENSE("GPL");

--ehgbnkhnzwpb5gdt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmaXiTAACgkQj4D7WH0S
/k5w3AgAsGbCPSxLacT5kGp/37SXTEIYM5B0a0vkkzPr8XTV/jpgpjIX2TOYxfSO
Oa5LktMECFBkveY1RovhPbMNlzhot3t2FhHymfpdGFhVM0ykmLS3v+QD13dslEDw
ZyvBTDa+/7fi8WiF4YJ8cgyvLfTyJ/X7K2N8ki44p4REAYtTMQg6Npq+2ZTvC4iF
iQ8KrOROIrKnR/FmHMAxrS3ykvEvdIbXjv13FoZVER2wS1z+XNJ+vwN3wlAq+rQM
g7gu1SSBtA8fRVxG6UNzXuSwJBZNJGYL02st6IE/Z+0dX7KJMzOni8IMC+qO2EFI
ZXIOW8DP4kpOp+30prNT/8xHBYWUIw==
=IUGp
-----END PGP SIGNATURE-----

--ehgbnkhnzwpb5gdt--

