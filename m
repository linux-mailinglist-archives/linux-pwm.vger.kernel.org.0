Return-Path: <linux-pwm+bounces-6843-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69389B06E1B
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Jul 2025 08:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82E1D7A422A
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Jul 2025 06:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A6B2882A0;
	Wed, 16 Jul 2025 06:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVLTnxBn"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091DE10A1E;
	Wed, 16 Jul 2025 06:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752647958; cv=none; b=I/pHWGH4ym1srpcMyBcAuG5dEIRcmgZzlTzEioFzmnDRXuk97UMgd1Z3bWIY9sy9skHoknJEkgm5oPwSTjYUPXT40IGHz0WyJcSm6I5fRgHhB9X1t8UnsGlrQQCdN+66IMxFHUlfMnEP+csey6yg3Is0EOCF863en8RpbftLSAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752647958; c=relaxed/simple;
	bh=pSlantP/NkSeML/Lc7Vg3kMWCj2y62hfSy8hb5Yrk24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z2QqHqo7jUryehzFhO0firHhlzrtpiwM+lwxd+H39JvEeiNv81Wejg55/1M/hSE+1IkBgnkTaBgeiibPo+BhxV5/tbjKGuPIX3ehsv58yQy3oxL60rPvY5kgd99tpExGrfniS8WI8USzqYoEKczZnjPPPgDjSHgvJL8NrAL/q0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DVLTnxBn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4C0C4CEF0;
	Wed, 16 Jul 2025 06:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752647957;
	bh=pSlantP/NkSeML/Lc7Vg3kMWCj2y62hfSy8hb5Yrk24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DVLTnxBnRHZEFVnchda8W9ALqAbdU84mVhA7opDAdwPeIJIVnJsL7lZhtNUS2BPMN
	 3rMGu561GHwZ0x5y6dbN5spbuRvENzw509xB1LehAjq/Z/rDwE3R7yYIRcnTLolWTC
	 EBJJY3hJaAD84D59c89K/krBbR/JF4F7BCMiuu0N+3pYSg2wgfh4KaPgSaz12fMS0a
	 DCVn8yM6RpO8TfCxv2rimJgccSwTk1iVGU57kw0BMboTVpdBrsYBGn8ea59QXhu2mh
	 lhOd1/aHObmSkNHv21nmQjHCWdcL46RV7/TK5jC+b4ry+b0dZswFezbngmKzXrUbXX
	 lWr+CQDL5WMBw==
Date: Wed, 16 Jul 2025 08:39:14 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: dimitri.fedrau@liebherr.com
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	Dimitri Fedrau <dima.fedrau@gmail.com>
Subject: Re: [PATCH v4 1/2] pwm: mc33xs2410: add hwmon support
Message-ID: <fxzkuflnasxp73fyf262wk5yx7yfnb5druegdujhzll3wjn6r5@n4xg6gs6segi>
References: <20250708-mc33xs2410-hwmon-v4-0-95b9e3ea5f5c@liebherr.com>
 <20250708-mc33xs2410-hwmon-v4-1-95b9e3ea5f5c@liebherr.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cp5qacf6adljg4cq"
Content-Disposition: inline
In-Reply-To: <20250708-mc33xs2410-hwmon-v4-1-95b9e3ea5f5c@liebherr.com>


--cp5qacf6adljg4cq
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 1/2] pwm: mc33xs2410: add hwmon support
MIME-Version: 1.0

Hello Dimitri,

On Tue, Jul 08, 2025 at 06:13:03PM +0200, Dimitri Fedrau via B4 Relay wrote:
> diff --git a/drivers/pwm/pwm-mc33xs2410.c b/drivers/pwm/pwm-mc33xs2410.c
> index a1ac3445ccdb4709d92e0075d424a8abc1416eee..e70ed90bfdac77f5c777f0ba6=
6d670331a515d12 100644
> --- a/drivers/pwm/pwm-mc33xs2410.c
> +++ b/drivers/pwm/pwm-mc33xs2410.c
> @@ -18,10 +18,12 @@
>   *   rather something in between.
>   */
> =20
> +#include <linux/auxiliary_bus.h>
>  #include <linux/bitfield.h>
>  #include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/math64.h>
> +#include <linux/mc33xs2410.h>
>  #include <linux/minmax.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> @@ -120,12 +122,19 @@ static int mc33xs2410_read_reg(struct spi_device *s=
pi, u8 reg, u16 *val, u8 flag
>  	return mc33xs2410_read_regs(spi, &reg, flag, val, 1);
>  }
> =20
> -static int mc33xs2410_read_reg_ctrl(struct spi_device *spi, u8 reg, u16 =
*val)
> +int mc33xs2410_read_reg_ctrl(struct spi_device *spi, u8 reg, u16 *val)
>  {
>  	return mc33xs2410_read_reg(spi, reg, val, MC33XS2410_FRAME_IN_DATA_RD);
>  }
> +EXPORT_SYMBOL_NS_GPL(mc33xs2410_read_reg_ctrl, "PWM_MC33XS2410");

To reduce repetition (a bit) you can consider to define
DEFAULT_SYMBOL_NAMESPACE.

> -static int mc33xs2410_modify_reg(struct spi_device *spi, u8 reg, u8 mask=
, u8 val)
> +int mc33xs2410_read_reg_diag(struct spi_device *spi, u8 reg, u16 *val)
> +{
> +	return mc33xs2410_read_reg(spi, reg, val, 0);
> +}
> +EXPORT_SYMBOL_NS_GPL(mc33xs2410_read_reg_diag, "PWM_MC33XS2410");
> +
> +int mc33xs2410_modify_reg(struct spi_device *spi, u8 reg, u8 mask, u8 va=
l)
>  {
>  	u16 tmp;
>  	int ret;
> @@ -139,6 +148,7 @@ static int mc33xs2410_modify_reg(struct spi_device *s=
pi, u8 reg, u8 mask, u8 val
> =20
>  	return mc33xs2410_write_reg(spi, reg, tmp);
>  }
> +EXPORT_SYMBOL_NS_GPL(mc33xs2410_modify_reg, "PWM_MC33XS2410");
> =20
>  static u8 mc33xs2410_pwm_get_freq(u64 period)
>  {
> @@ -297,6 +307,52 @@ static const struct pwm_ops mc33xs2410_pwm_ops =3D {
>  	.get_state =3D mc33xs2410_pwm_get_state,
>  };
> =20
> +static void mc33xs2410_adev_release(struct device *dev)
> +{
> +	struct auxiliary_device *adev =3D to_auxiliary_dev(dev);
> +
> +	kfree(adev);
> +}
> +
> +static void mc33xs2410_unregister_adev(void *_adev)
> +{
> +	struct auxiliary_device *adev =3D _adev;
> +
> +	auxiliary_device_delete(adev);
> +	auxiliary_device_uninit(adev);
> +}

This is a copy of auxiliary_device_destroy(). But see below.

> +static int mc33xs2410_hwmon_register(struct device *dev)
> +{
> +	struct auxiliary_device *adev;
> +	int ret;
> +
> +	adev =3D kzalloc(sizeof(*adev), GFP_KERNEL);
> +	if (!adev)
> +		return -ENOMEM;
> +
> +	adev->name =3D "hwmon";
> +	adev->dev.parent =3D dev;
> +	adev->dev.release =3D mc33xs2410_adev_release;
> +	adev->id =3D 0;
> +
> +	ret =3D auxiliary_device_init(adev);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D auxiliary_device_add(adev);
> +	if (ret) {
> +		auxiliary_device_uninit(adev);
> +		return ret;
> +	}
> +
> +	ret =3D devm_add_action_or_reset(dev, mc33xs2410_unregister_adev, adev);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}

This function is equivalent to devm_auxiliary_device_create(dev, "hwmon", N=
ULL);

> +
>  static int mc33xs2410_reset(struct device *dev)
>  {
>  	struct gpio_desc *reset_gpio;
> @@ -361,6 +417,10 @@ static int mc33xs2410_probe(struct spi_device *spi)
>  	if (ret < 0)
>  		return dev_err_probe(dev, ret, "Failed to add pwm chip\n");
> =20
> +	ret =3D mc33xs2410_hwmon_register(dev);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to register hwmon device\n");
> +
>  	return 0;
>  }
> =20
> diff --git a/include/linux/mc33xs2410.h b/include/linux/mc33xs2410.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..15a0b0b595fe00a369cee45f2=
d30b2d912b612bb
> --- /dev/null
> +++ b/include/linux/mc33xs2410.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2024 Liebherr-Electronics and Drives GmbH
> + */
> +#ifndef _MC33XS2410_H
> +#define _MC33XS2410_H
> +
> +#include <linux/spi/spi.h>
> +
> +int mc33xs2410_read_reg_ctrl(struct spi_device *spi, u8 reg, u16 *val);
> +int mc33xs2410_read_reg_diag(struct spi_device *spi, u8 reg, u16 *val);
> +int mc33xs2410_modify_reg(struct spi_device *spi, u8 reg, u8 mask, u8 va=
l);
> +
> +#endif /* _MC33XS2410_H */

I consider it elegant to have the

	MODULE_IMPORT_NS("PWM_MC33XS2410")

in the header. This is nice because the namespacing is completely
transparant to consumers and all they need it the right #include as if
there was no namespacing at all.

Best regards
Uwe

--cp5qacf6adljg4cq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmh3SQ8ACgkQj4D7WH0S
/k7dogf/V7cx3CrdKtVxJOhZAyq/GfuKlI8dAfYvaIvx5yklxYhZRwt3NmHRyCiS
mYeqBI8NbW3mSLSeSFqM4SP536zjDcfTdQOO8sPanOJuemUODBtNSJ83WeamiOwF
BgM6P7uleU8qfBd4qRzdaTek0epl/ct7Zl1qXh8WGyoaOp2ar+5codrhoWEo9B39
zr55Dj+G0JI/gtjGxFcjEe1nll/h4Lgn8LDM5HKs0sZuoiXNv796K/fE0vHUgHdR
i2sdOfNUv1lP4W9Dcc03n4yd/eQA5OhY6ESFmh622P58MNxnH672LrxBqBTpjdtY
2tWUc4pI8wqVOpbs4zxn6SBZUi2WWw==
=HKUd
-----END PGP SIGNATURE-----

--cp5qacf6adljg4cq--

