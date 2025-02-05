Return-Path: <linux-pwm+bounces-4774-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FF1A288EE
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Feb 2025 12:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FD9D1888602
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Feb 2025 11:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B1C1519A3;
	Wed,  5 Feb 2025 11:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="clEIarqG"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C01F151995;
	Wed,  5 Feb 2025 11:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738753928; cv=none; b=gngbDraum/JRTpFIVQljYW7/4XuOzLx9KJLXDiAcc4grelaVv8OAxhTUGGsfWfT9h2iAGe9AvmJex5Mk46z9O/XuUCqVfQOa4ELisYzJrmWlHbTFDXmy0qqGhkyhti9z9mZEeaVYIOzc58SYMaWqB7aEdKTLRKSy46H58dLWlY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738753928; c=relaxed/simple;
	bh=JKEieNUi7AK17YQlD/n8fcPUqowFYUp2ArFVbP6jf6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bZPPYyAv4S+lsl2RsXkL3gdLAAKOt5cSdGfFLmmWDbXm4tCJqYnLd6C5frrsemcBJDmaaXF7YM7NUT8a9HNe5p+YFhtURN0UI1sHeWThuMPiOZ8G4GmztG91VJbY0BUULKxvkB1lcUVNxVfgxOLaF4DneAWg0VSl23R/4H37EYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=clEIarqG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24AE0C4CED1;
	Wed,  5 Feb 2025 11:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738753927;
	bh=JKEieNUi7AK17YQlD/n8fcPUqowFYUp2ArFVbP6jf6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=clEIarqGcvwgHEfI9rsO8lSW5/XGdep+850/H9ZwN8cBYhRbajiW3tSgNns5Vs0ke
	 A21xPXhY6CcC5xAsp40nKyYrmevW4IVQR2lAq/DOkAF0Tj60sVw3vD4E7oDpu9FNUa
	 vLdsKWIUbsk8d8sfI1HYFNR3D8RH2a4UDRts0fzMs4yGGSiO+Omg1N3saK53+ezjp6
	 csqJWlSMqXpeF5KmFUaCn3zeAUVAGajiednUSh+xgmBOrsQYmf0CjIYjhHdFUzsWg5
	 DooJ+mxz3upt2Zd5GUmVsmvGxj1xSbHTdhOQXIxQOPFVBcekNz7g/m1G3A88KfeDUm
	 5G01HKNEbf7EQ==
Date: Wed, 5 Feb 2025 12:12:04 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: tiehrpwm: ensures that state.enabled is
 synchronized in .probe()
Message-ID: <yxolbwr62nfdaeobghokx32fihhh56falxpg4u7kex4is7soam@mfswlo4rbkaq>
References: <20250204185540.52233-1-rafael.v.volkmer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5vaexsucjjw4yogh"
Content-Disposition: inline
In-Reply-To: <20250204185540.52233-1-rafael.v.volkmer@gmail.com>


--5vaexsucjjw4yogh
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: tiehrpwm: ensures that state.enabled is
 synchronized in .probe()
MIME-Version: 1.0

Hello Rafael,

first of all: There are several issues regarding code style, checkpatch
reports

	total: 20 errors, 13 warnings, 180 lines checked

Please fix them all for v2 (or mention unfixed ones in the cover text,
ideally with a reasoning). (In case you don't know:

	scripts/checkpatch.pl -g @

; for bonus points add --strict.)

On Tue, Feb 04, 2025 at 03:55:40PM -0300, Rafael V. Volkmer wrote:
> Fixes potential desynchronization of state.enabled in the .probe()
> method by suggesting proper handling of hardware state initialization.
> Adds considerations for implementing .get_hw_state() to check the
> current state of the module by checking physical registers.

I don't understand that. What is .get_hw_state()?

Returning here after reading through the complete patch, I suggest
something like:

	If the hardware is already active during probe, it's not
	asserted that the clock is enabled. So check in
	ehrpwm_pwm_probe() if the enable bit is set and call
	clk_enable() and pm_runtime_get_sync() if yes.

> Signed-off-by: Rafael V. Volkmer <rafael.v.volkmer@gmail.com>
> ---
>  drivers/pwm/pwm-tiehrpwm.c | 151 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 150 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
> index 0125e73b98df..5de213bc3ef5 100644
> --- a/drivers/pwm/pwm-tiehrpwm.c
> +++ b/drivers/pwm/pwm-tiehrpwm.c
> @@ -91,6 +91,20 @@
>  #define AQCSFRC_CSFA_FRCHIGH	BIT(1)
>  #define AQCSFRC_CSFA_DISSWFRC	(BIT(1) | BIT(0))
> =20
> +#define AQCTLA_CAU_MASK   (BIT(5) | BIT(4))
> +#define AQCTLA_CAU_SHIFT  4
> +#define AQCTLA_CAD_MASK   (BIT(9) | BIT(8))
> +#define AQCTLA_CAD_SHIFT  8

Please use

	#define AQCTLA_CAD	GENMASK(9, 8)

and for the usage then instead of

	cad_action =3D (aqctla_reg & AQCTLA_CAD_MASK) >> AQCTLA_CAD_SHIFT;

better:

	cad_action =3D FIELD_GET(AQCTLA_CAD, aqctla_reg);

> +
> +/* The ePWM hardware encodes compare actions with two bits each:
> + *   00 =3D Do nothing
> + *   01 =3D Clear
> + *   10 =3D Set
> + *   11 =3D Toggle
> + */
> +#define AQ_CLEAR  1
> +#define AQ_SET    2
> +
>  #define NUM_PWM_CHANNEL		2	/* EHRPWM channels */
> =20
>  struct ehrpwm_context {
> @@ -353,6 +367,118 @@ static int ehrpwm_pwm_enable(struct pwm_chip *chip,=
 struct pwm_device *pwm)
>  	return 0;
>  }
> =20
> +static bool ehrpwm_is_enabled(struct pwm_chip *chip)
> +{
> +	struct ehrpwm_pwm_chip *pc =3D to_ehrpwm_pwm_chip(chip);
> +	bool ret;
> +	u16 aqcsfrc_reg;
> +	u8 csfa_bits;
> +	u16 aqctla_reg;
> +
> +	if(chip =3D=3D NULL) {
> +		return -EINVAL;
> +	}

return -EINVAL is bogus for a function returning bool. The solution is
easy: chip is never NULL here, so please drop.=20

> +
> +	aqcsfrc_reg	=3D readw(pc->mmio_base + AQCSFRC);
> +	csfa_bits	=3D (u8)(aqcsfrc_reg & AQCSFRC_CSFA_MASK);

Single space before =3D please.

> +	aqctla_reg	=3D readw(pc->mmio_base + AQCTLA);
> +
> +	ret =3D (csfa_bits !=3D 0u)	 ? false :
> +	      (aqctla_reg =3D=3D 0u) ? false : true;

I didn't understand what these values mean, but this is unreadable. I
prefer:

	if (csfa_bits)
		return false;

	if (aqctla_reg)
		return true;

	return false;

Maybe also add code comments about the semantic to the respective
blocks.

> +
> +	return ret;
> +}
> +
> +static u64 ehrpwm_read_period(struct pwm_chip *chip)
> +{
> +	struct ehrpwm_pwm_chip *pc =3D to_ehrpwm_pwm_chip(chip);
> +	u64 ret;
> +	unsigned long tbclk_rate;
> +	u16 tbprd_reg;
> +	u64 period_cycles;
> +	u64 period_ns;
> +
> +	if(chip =3D=3D NULL) {
> +		return -EINVAL;
> +	}
> +
> +	tbprd_reg =3D readw(pc->mmio_base + TBPRD);
> +	tbclk_rate =3D clk_get_rate(pc->tbclk);
> +	period_cycles =3D tbprd_reg + 1u;
> +=09
> +	/* period_ns =3D (period_cycles * 1e9) / tblck_rate */
> +	period_ns =3D DIV_ROUND_UP_ULL(period_cycles * NSEC_PER_SEC, tbclk_rate=
);
> +=09
> +	ret =3D period_ns;
> +	return ret;

return period_ns;

Given that ehrpwm_read_period() and ehrpwm_read_duty_cycle() are called
directly after another, I suggest to rework the code that clk_get_rate()
is only called once. (Maybe even put it into ehrpwm_pwm_chip.)

> +}
> +
> +static u64 ehrpwm_read_duty_cycle(struct pwm_chip *chip)
> +{
> +	struct ehrpwm_pwm_chip *pc =3D to_ehrpwm_pwm_chip(chip);
> +	u64 ret;
> +	u16 cmpa_reg;
> +	u64 duty_cycles;
> +	u64 duty_ns;
> +	unsigned long tbclk_rate;
> +
> +	if(chip =3D=3D NULL) {
> +		return -EINVAL;
> +	}
> +
> +	cmpa_reg =3D readw(pc->mmio_base + CMPA);
> +	tbclk_rate =3D clk_get_rate(pc->tbclk);
> +	duty_cycles =3D cmpa_reg;
> +	duty_ns =3D DIV_ROUND_UP_ULL(duty_cycles * NSEC_PER_SEC, tbclk_rate);
> +	ret =3D duty_ns;
> +
> +	return ret;
> +}
> +
> +static enum pwm_polarity ehrpwm_read_polarity(struct pwm_chip *chip)
> +{
> +	struct ehrpwm_pwm_chip *pc =3D to_ehrpwm_pwm_chip(chip);
> +	enum pwm_polarity ret;
> +	u16 aqctla_reg;
> +	u8 cau_action;
> +	u8 cad_action;
> +
> +	if(chip =3D=3D NULL) {
> +		return -EINVAL;
> +	}
> +
> +	aqctla_reg	=3D readw(pc->mmio_base + AQCTLA);
> +	cau_action =3D (aqctla_reg & AQCTLA_CAU_MASK) >> AQCTLA_CAU_SHIFT;
> +	cad_action =3D (aqctla_reg & AQCTLA_CAD_MASK) >> AQCTLA_CAD_SHIFT;
> +=09
> +	if (cau_action =3D=3D AQ_SET && cad_action =3D=3D AQ_CLEAR) {
> +		ret =3D PWM_POLARITY_NORMAL;
> +	}
> +	else if (cau_action =3D=3D AQ_CLEAR && cad_action =3D=3D AQ_SET) {
> +		ret =3D PWM_POLARITY_INVERSED;
> +	}

I would expect the compiler to issue a warning here about ret being
uninitialized in some situations.

Not sure checkpatch points that out: } and "else" go on the same line.

> +
> +	return ret;
> +}
> +
> +static int ehrpwm_get_hw_state(struct pwm_chip *chip, struct pwm_device =
*pwm,=20
> +								struct pwm_state *state)

The canonical name for this function is ehrpwm_pwm_get_state. And I
would have expected an assignment to .get_state in ehrpwm_pwm_ops.

> +{
> +	int ret;
> +
> +	if(chip =3D=3D NULL || pwm =3D=3D NULL || state =3D=3D NULL){
> +		return -EINVAL;
> +	}
> +
> +	state->enabled =3D ehrpwm_is_enabled(chip);
> +	state->period =3D ehrpwm_read_period(chip);
> +    state->duty_cycle =3D ehrpwm_read_duty_cycle(chip);
> +    state->polarity =3D ehrpwm_read_polarity(chip);
> +
> +	return ret;
> +}
> +
>  static void ehrpwm_pwm_disable(struct pwm_chip *chip, struct pwm_device =
*pwm)
>  {
>  	struct ehrpwm_pwm_chip *pc =3D to_ehrpwm_pwm_chip(chip);
> @@ -449,8 +575,10 @@ static int ehrpwm_pwm_probe(struct platform_device *=
pdev)
>  {
>  	struct device_node *np =3D pdev->dev.of_node;
>  	struct ehrpwm_pwm_chip *pc;
> +	struct pwm_state state;
>  	struct pwm_chip *chip;
>  	struct clk *clk;
> +	bool tbclk_enabled;
>  	int ret;
> =20
>  	chip =3D devm_pwmchip_alloc(&pdev->dev, NUM_PWM_CHANNEL, sizeof(*pc));
> @@ -501,10 +629,31 @@ static int ehrpwm_pwm_probe(struct platform_device =
*pdev)
>  	platform_set_drvdata(pdev, chip);
>  	pm_runtime_enable(&pdev->dev);
> =20
> +	ehrpwm_get_hw_state(chip, &chip->pwms[0], &state);
> +	if(state.enabled =3D=3D true) {

Given that you only use state.enabled here, maybe shorten that to

	if (ehrpwm_is_enabled(...))

> +		ret =3D clk_prepare_enable(pc->tbclk);

While it's a good idea to enable the clock if the PWM is already running
at probe time, this must happen before pwmchip_add().

> +		if (ret) {    =20
> +			dev_err(&pdev->dev, "clk_prepare_enable() failed: %d\n", ret);

Please use dev_err_probe() here.

> +			goto err_pwmchip_remove;
> +		}
> +           =20
> +		tbclk_enabled =3D true;
> +		ret =3D pm_runtime_get_sync(&pdev->dev);
> +		if(ret < 0) {
> +			dev_err(&pdev->dev, "pm_runtime_get_sync() failed: %d\n", ret);
> +			clk_disable_unprepare(pc->tbclk);
> + 			goto err_pwmchip_remove;
> +		}
> + 	}
> +
>  	return 0;
> =20
> +err_pwmchip_remove:
> +	pwmchip_remove(chip);
> +
>  err_clk_unprepare:
> -	clk_unprepare(pc->tbclk);
> +	if(tbclk_enabled)
> +		clk_unprepare(pc->tbclk);
> =20
>  	return ret;
>  }

Best regards
Uwe

--5vaexsucjjw4yogh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmejR4IACgkQj4D7WH0S
/k5spQgAiQ06Ai9F5Iyj2p1FUcJcpFHV3mOJ9R4483myQw+nfUQZSl5FHRfANR50
IvyKZ8exb6VGJfOcHWOaK1SkePB0v6U3DF38ExguM7VRaZhOJR10H8LUNzCCIW59
RSSM/pUcZJ36HI56ji6xCbmvGyzdtPcSwbf2hUEzibH9On7lF6T/t8r4zUXSva8d
jxU1PJV4Muwh29SlfzjyOoOfyiBvHLl5vsn/ZWl3hWAvPNI2eQA/5mrxFTHz7aHB
tL0Yxfb3kzP41VL83lms57HELqyZ8UYXVD6/IAeKwTkglip/G8TaDwdHOJ4XSO+U
s76gRbQgNwUp7epwoObEyuDxfy8itA==
=YHJ6
-----END PGP SIGNATURE-----

--5vaexsucjjw4yogh--

