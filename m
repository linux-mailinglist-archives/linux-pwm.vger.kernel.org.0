Return-Path: <linux-pwm+bounces-2590-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D72913945
	for <lists+linux-pwm@lfdr.de>; Sun, 23 Jun 2024 11:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 640911F21542
	for <lists+linux-pwm@lfdr.de>; Sun, 23 Jun 2024 09:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F357442F;
	Sun, 23 Jun 2024 09:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="anrrpZCg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21AE12F382
	for <linux-pwm@vger.kernel.org>; Sun, 23 Jun 2024 09:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719135173; cv=none; b=utL+E7YEgyisB24nsfYCxs2FJqeDyK8K/Ux7keGJS+rZLydZ0gHYz38wpiiESsQHaqHEYoblClEgWXo4Do0YzsLhm3U+eMR7dn5Ew5NrLDHn56Ux99NIxvmqs9MygjGkghOnYa7n44dl82eUtnAWajI8BZbgGaQAHG5qZNAxIRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719135173; c=relaxed/simple;
	bh=f1vzVTAItnDj/hzKcqSSIB/5vFsSyRNvaYwd9zkI6P0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+x44TjATOUTASgd+ue4NSi3q80MrHEQyVjUX7leic3LBYyxA3Pg/NaOsb3bVm50HtWaTAwIKdhfN/RoFNp7AzfJTREiZQHYCevMxPGEjWjTDX1qyju47mRibkEAlFTXRqougLH+MvVEWlCe4F99R52KIbTsCqBhSaguEAcHlG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=anrrpZCg; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a6fdd947967so109612666b.2
        for <linux-pwm@vger.kernel.org>; Sun, 23 Jun 2024 02:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719135168; x=1719739968; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZRC0X6s5dHa4Jeih0U3Qs+Lq8PM7f9uaQUBxoBmKqMg=;
        b=anrrpZCgJkQBl9sbwYsMnY2OIF4RaswAQrSrFTv4UOiPhk1bhPW7D8F4wf4dIKVXmj
         voD8MmNtdZh/3miafuPW5BAVTnDwmEc1sbzzm5dJ+L6Z40EfdQWmPcH0rFC5atCIzNWg
         jfTflFSeckclYtjZzvznbnVfC1QbTWAAcUCTJsYCj5BYZvQ/8FTZ9GVKgD9h+PFKzDpb
         2tURCGfm6flRYoHVQVnu/oSf5jkBH54JdPpmLaaVi6mnb1kn3RvMcp8o29i8M2BJPrc/
         4p59Orbsv36GFO/aEg8I1OxpSZScoyLbloxQzxMfJePZiAB+GCptof2zAJM4Fly/ugtW
         /HZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719135168; x=1719739968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZRC0X6s5dHa4Jeih0U3Qs+Lq8PM7f9uaQUBxoBmKqMg=;
        b=ncVqefCOedAvF0cHgnlnKkJUM5PWl3EBao/y/ov4FgYiwmn78U8NDv6inbrnWr9fws
         9cizN2Dt1N8VNIwq1lROHIavw3UQc+YxmuVpuynXG5AkTYDaviEYUqXxMFEDlGDRil0C
         riFjmU7mEtdEtoF/bmluHTFoZwXUeyVfikjS9FruwgCcuqdmPjrW/eWtGDNbk3JCb1n7
         d09PpNpGxatz/nYiMyTw3/sRd+4lnx55Zf3ta9pbieXcoc+q1oUpl/R1cAWavD1HJ1TW
         mpp+yMi0ye0z92s+c/RtcxsT7boka4OqARP2WDnYb4BHNy0rduSqplwraO0AU7PGBOnn
         /VLQ==
X-Gm-Message-State: AOJu0YyuuRKVEo0vIK1I5uD+q+xPVyPXhzqtmndV9dQQT1dW+VMPF2HV
	7DnelyAeFuxcBDN0Udgh/Gd8ZWuu45qQpF4z8K+FQ/uba4QlCXkIPebTCYfTrfE=
X-Google-Smtp-Source: AGHT+IFnYD75m7jEa2tzZqlDYLnXmTdMG19wrcBuLDkblFE7jlySWlSq5fW54F0UvOfAGbHb8jtmWA==
X-Received: by 2002:a17:906:3552:b0:a6f:b0d0:1beb with SMTP id a640c23a62f3a-a7245ba3c72mr141261466b.24.1719135167581;
        Sun, 23 Jun 2024 02:32:47 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:f00d:9f2c:4dd7:a42f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72464295c1sm78284566b.152.2024.06.23.02.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 02:32:46 -0700 (PDT)
Date: Sun, 23 Jun 2024 11:32:45 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	broonie@kernel.org, lgirdwood@gmail.com
Subject: Re: [RFC PATCH v2] regulator: pwm-regulator: Make assumptions about
 disabled PWM consistent
Message-ID: <s6lapsx6dukr4ebknbbalbhi7232ivxl2apaqtardfi6f2ybbf@zvlhxlngbgx3>
References: <20240622191504.38374-1-martin.blumenstingl@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="e7ns44t4t2nvw2or"
Content-Disposition: inline
In-Reply-To: <20240622191504.38374-1-martin.blumenstingl@googlemail.com>


--e7ns44t4t2nvw2or
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Martin,

On Sat, Jun 22, 2024 at 09:15:04PM +0200, Martin Blumenstingl wrote:
> Generally it's not known how a disabled PWM behaves. However if the
> bootloader hands over a disabled PWM that drives a regulator and it's
> claimed the regulator is enabled, then the most likely assumption is
> that the PWM emits the inactive level. This is represented by duty_cycle
> =3D 0 even for .polarity =3D=3D PWM_POLARITY_INVERSED.

I'd write: "This is represented by duty_cycle =3D 0 independent of the
polarity."

> Change the implementation to always use duty_cycle =3D 0, regardless of
> the polarity. Also update the code so it keeps a copy of the pwm_state
> around. Both of these changes result in the fact that the logic from
> pwm_regulator_init_boot_on() is much less complex and can be simplified
> to a point where the whole function is not needed anymore.

In my (German) ear the following sounds a bit nicer:

	Both of these changes reduce the complexity of
	pwm_regulator_init_boot_on() to a point where the whole function
	is not needed anymore.

> Suggested-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
> Changes from v1 [0] (which was sent by Uwe):
> - keep the struct pwm_state around to prevent a regression on Meson8b
>   Odroid-C1 boards where just calling pwm_enable() without adjusting
>   the duty_cycle to 0 would hang the board
> - I'm actively looking for input on the commit description and
>   suggestions whether/why Fixes tags should be applied

Apart of the nitpicking above, I like the commit description.

Regarding a Fixes tag: I'm unsure if without this patch, the
pwm-regulator driver is broken for your Odroid-C1 board. It's not,
right?
I think I wouldn't add a Fixes tag and just consider this patch a
cleanup then.
=20
> [0] https://lore.kernel.org/lkml/CAFBinCB+S1wOpD-fCbcTORqXSV00Sd7-1GHUKY+=
rO859_dkhOA@mail.gmail.com/T/
>=20
>=20
>  drivers/regulator/pwm-regulator.c | 119 ++++++++++++++----------------
>  1 file changed, 55 insertions(+), 64 deletions(-)
>=20
> diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-re=
gulator.c
> index 7434b6b22d32..5ea354a0654a 100644
> --- a/drivers/regulator/pwm-regulator.c
> +++ b/drivers/regulator/pwm-regulator.c
> @@ -41,6 +41,8 @@ struct pwm_regulator_data {
> =20
>  	/* Enable GPIO */
>  	struct gpio_desc *enb_gpio;
> +
> +	struct pwm_state pwm_state;
>  };
> =20
>  struct pwm_voltages {
> @@ -48,18 +50,33 @@ struct pwm_voltages {
>  	unsigned int dutycycle;
>  };
> =20
> +static int pwm_regulator_apply_state(struct regulator_dev *rdev,
> +				     struct pwm_state *new_state)
> +{
> +	struct pwm_regulator_data *drvdata =3D rdev_get_drvdata(rdev);
> +	int ret;
> +
> +	ret =3D pwm_apply_might_sleep(drvdata->pwm, new_state);
> +	if (ret) {
> +		dev_err(&rdev->dev, "Failed to configure PWM: %d\n", ret);
> +		return ret;
> +	}
> +
> +	drvdata->pwm_state =3D *new_state;
> +
> +	return 0;
> +}
> +
>  /*
>   * Voltage table call-backs
>   */
>  static void pwm_regulator_init_state(struct regulator_dev *rdev)
>  {
>  	struct pwm_regulator_data *drvdata =3D rdev_get_drvdata(rdev);
> -	struct pwm_state pwm_state;
>  	unsigned int dutycycle;
>  	int i;
> =20
> -	pwm_get_state(drvdata->pwm, &pwm_state);
> -	dutycycle =3D pwm_get_relative_duty_cycle(&pwm_state, 100);
> +	dutycycle =3D pwm_get_relative_duty_cycle(&drvdata->pwm_state, 100);
> =20
>  	for (i =3D 0; i < rdev->desc->n_voltages; i++) {
>  		if (dutycycle =3D=3D drvdata->duty_cycle_table[i].dutycycle) {
> @@ -83,18 +100,15 @@ static int pwm_regulator_set_voltage_sel(struct regu=
lator_dev *rdev,
>  					 unsigned selector)
>  {
>  	struct pwm_regulator_data *drvdata =3D rdev_get_drvdata(rdev);
> -	struct pwm_state pstate;
> +	struct pwm_state pstate =3D drvdata->pwm_state;
>  	int ret;
> =20
> -	pwm_init_state(drvdata->pwm, &pstate);
>  	pwm_set_relative_duty_cycle(&pstate,
>  			drvdata->duty_cycle_table[selector].dutycycle, 100);
> =20
> -	ret =3D pwm_apply_might_sleep(drvdata->pwm, &pstate);
> -	if (ret) {
> -		dev_err(&rdev->dev, "Failed to configure PWM: %d\n", ret);
> +	ret =3D pwm_regulator_apply_state(rdev, &pstate);
> +	if (ret)
>  		return ret;
> -	}

If you drop the local variable pstate and just do

	pwm_set_relative_duty_cycle(drvdata->pwm_state,
				drvdata->duty_cycle_table[selector].dutycycle, 100);

you might get a mismatch between actual configuration and
drvdata->pwm_state if pwm_regulator_apply_state() fails, but I think
that doesn't matter and simplifies the code a bit. (Drop the assignment
in pwm_regulator_apply_state() then.)
=20
>  	drvdata->state =3D selector;
> =20
> @@ -115,17 +129,26 @@ static int pwm_regulator_list_voltage(struct regula=
tor_dev *rdev,
>  static int pwm_regulator_enable(struct regulator_dev *dev)
>  {
>  	struct pwm_regulator_data *drvdata =3D rdev_get_drvdata(dev);
> +	struct pwm_state pstate =3D drvdata->pwm_state;
> =20
>  	gpiod_set_value_cansleep(drvdata->enb_gpio, 1);
> =20
> -	return pwm_enable(drvdata->pwm);
> +	pstate.enabled =3D true;
> +
> +	return pwm_regulator_apply_state(dev, &pstate);
>  }
> =20
>  static int pwm_regulator_disable(struct regulator_dev *dev)
>  {
>  	struct pwm_regulator_data *drvdata =3D rdev_get_drvdata(dev);
> +	struct pwm_state pstate =3D drvdata->pwm_state;
> +	int ret;
> +
> +	pstate.enabled =3D false;
> =20
> -	pwm_disable(drvdata->pwm);
> +	ret =3D pwm_regulator_apply_state(dev, &pstate);
> +	if (ret)
> +		return ret;

With that part I'm a bit unhappy. You don't know what the pwm does when
disabled (it might yield a 100% relative duty cycle). So the safe bet is
to use .enabled=3Dtrue, .duty_cycle=3D0 here.

The only code that "knows" if it's safe to disable the PWM is the
lowlevel pwm driver.

>  	gpiod_set_value_cansleep(drvdata->enb_gpio, 0);
> =20
> @@ -139,7 +162,7 @@ static int pwm_regulator_is_enabled(struct regulator_=
dev *dev)
>  	if (drvdata->enb_gpio && !gpiod_get_value_cansleep(drvdata->enb_gpio))
>  		return false;
> =20
> -	return pwm_is_enabled(drvdata->pwm);
> +	return drvdata->pwm_state.enabled;
>  }

Thanks for picking up the task to improve my patch!

Best regards
Uwe

--e7ns44t4t2nvw2or
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmZ367oACgkQj4D7WH0S
/k4ztAf/cF0z2qxi0wFF15GgIT/d2ln7gK9FyKZbrIW970CE6v1noPr6Lx821m+h
I6Q5fthmQ2kQtWWq3jVF1i2RTVbPPI7HStJ6//77mMPbabL7lox47fsbbkKxRi2i
qS7zHMygyn/2ABHblOx7lowJA9pwcFBNpMoP7loXUS6Sg7hPL7byhDAc1k/zqF0m
vtiHrFXE4vj4VweGQNSJbqhedTxNRKZYEy7Zh9MIM8HkvhEf7NDJD6GPop9hMJgN
58Km1mH0O82zwCaUwMFYoiMuRCXhcrFytmKsfTdN6hr7OCDaA9d0PBQx2L0Uy4cO
9TkzfDCGGk/YIOxDShMnm334TYbHUw==
=t4nU
-----END PGP SIGNATURE-----

--e7ns44t4t2nvw2or--

