Return-Path: <linux-pwm+bounces-5352-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A6BA7D9D8
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Apr 2025 11:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B517A3AF5CF
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Apr 2025 09:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADF9227BA5;
	Mon,  7 Apr 2025 09:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s9R4+8vZ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CE5224B1F;
	Mon,  7 Apr 2025 09:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744018712; cv=none; b=Wejmt547k6ERvKa6HEOU8ufy58YuuA7y1O8iOOBH7C3CPofXE680om5YJR6qiVjMLwV8MRVghMxVO8Y/c8M5CmIqeMg/aqzFKmq5HeK4L0oOETgB9u2TpruXkMz6v8qiE43WFW9c3wEPO4sEDhbqVkmeqe8RPPJ+XeQXiXvd0/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744018712; c=relaxed/simple;
	bh=6w3eFSHcGfr21TV3uewsU0b1m9Ul2CRPKvz+z6S4aBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CmRPonia2ma52d/AvN+JPftZp4jEHzEW/zNNqE4d+RoyLnQ/YBZfGcreo38+lKxKaY3sRJJwpVYyyZnZIRmmGGhRZH4ykKWkVOzTKW+F2q8qR/Q+QAiIjzaHIXMiuu7RHxdlo5oMfmZErkOE1CFs3DaltLoWqy4ZTGpH+Cqrg5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s9R4+8vZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B23C4CEDD;
	Mon,  7 Apr 2025 09:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744018710;
	bh=6w3eFSHcGfr21TV3uewsU0b1m9Ul2CRPKvz+z6S4aBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s9R4+8vZCq6IlmhaWl2Jy5wcRcJzMrxa2CdIvPMkG4H6ckvCj9a6pjxNzeGtcsk1u
	 KSQXBY7lsEhi+aJA/Kd4qs5+Ii99z7jkRfyhSJNXtsOGNdn0NWPPmOTx2BgsF1OaBv
	 pWceKRJPm0VGpIR1figoCYaMDBtXHetoCjzKVL2Grl4EuKpUpJ0Mw1+6Dp4d9PJCnE
	 wfXTo8LJ6CA/UAg1wDmiMj51Vpq6dmUyPxlR2jIlmcNYfccBHFN1b9bTHmgXgw6AJz
	 +cMTAmdHkr+bFlocUSMgBoYkoSUSc46t6vFHgzDEIgI3MXlz6vf4oPhkkPmbUrtR16
	 dkdeqG1mCKT6Q==
Date: Mon, 7 Apr 2025 11:38:27 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Longbin Li <looong.bin@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, ghost <2990955050@qq.com>, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, sophgo@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 2/2] pwm: sophgo: add driver for SG2044
Message-ID: <jnvlo3su4xzsvzte2s3noosycxae5uxhi3vusefpgq462ymqst@jgta6xxmcbtd>
References: <20250407072056.8629-1-looong.bin@gmail.com>
 <20250407072056.8629-3-looong.bin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pdievs2tczsk2og6"
Content-Disposition: inline
In-Reply-To: <20250407072056.8629-3-looong.bin@gmail.com>


--pdievs2tczsk2og6
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/2] pwm: sophgo: add driver for SG2044
MIME-Version: 1.0

On Mon, Apr 07, 2025 at 03:20:39PM +0800, Longbin Li wrote:
> From: ghost <2990955050@qq.com>

Huh, is that a real name?

> Add PWM controller for SG2044.
>=20
> Signed-off-by: Longbin Li <looong.bin@gmail.com>
> ---
>  drivers/pwm/pwm-sophgo-sg2042.c | 162 +++++++++++++++++++++++++++-----
>  1 file changed, 138 insertions(+), 24 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-sophgo-sg2042.c b/drivers/pwm/pwm-sophgo-sg2=
042.c
> index ff4639d849ce..c62e8c758d87 100644
> --- a/drivers/pwm/pwm-sophgo-sg2042.c
> +++ b/drivers/pwm/pwm-sophgo-sg2042.c

The Limitations paragraph needs updating. E.g. SG2044 seems to support
polarity while SG2042 doesn't.

> @@ -26,20 +26,22 @@
>  #include <linux/pwm.h>
>  #include <linux/reset.h>
>=20
> -/*
> - * Offset RegisterName
> - * 0x0000 HLPERIOD0
> - * 0x0004 PERIOD0
> - * 0x0008 HLPERIOD1
> - * 0x000C PERIOD1
> - * 0x0010 HLPERIOD2
> - * 0x0014 PERIOD2
> - * 0x0018 HLPERIOD3
> - * 0x001C PERIOD3
> - * Four groups and every group is composed of HLPERIOD & PERIOD
> - */
> -#define SG2042_PWM_HLPERIOD(chan) ((chan) * 8 + 0)
> -#define SG2042_PWM_PERIOD(chan) ((chan) * 8 + 4)
> +#define REG_HLPERIOD		0x0
> +#define REG_PERIOD		0x4
> +#define REG_GROUP		0x8

REG_GROUP belongs to a different category than REG_PERIOD. So please use
a different schema to name it (or drop it, see below).

> +#define REG_POLARITY		0x40
> +
> +#define REG_PWMSTART		0x44
> +#define REG_PWMUPDATE		0x4C
> +#define REG_SHIFTCOUNT		0x80
> +#define REG_SHIFTSTART		0x90

REG_SHIFTCOUNT and REG_SHIFTSTART are unused.

> +#define REG_PWM_OE		0xD0

Actually I liked the old prefix better. E.g. "REG_POLARITY" looks more
generic that it actually is.

> +
> +#define PWM_REG_NUM		0x80

This is unused?

> +
> +#define PWM_POLARITY_MASK(n) BIT(n)
> +#define PWM_HLPERIOD(chan) ((chan) * REG_GROUP + REG_HLPERIOD)
> +#define PWM_PERIOD(chan) ((chan) * REG_GROUP + REG_PERIOD)

((chan) * 8 + 0) is IMHO better. I guess this is subjective because at
least the *8 is repeated several times, but the advantage of not using a
define for 8 (and 0 and 4) is that by looking at

	#define SG2042_PWM_HLPERIOD(chan) ((chan) * 8 + 0)

you immediatly see the offsets of the HLPERIOD register, while for

	#define PWM_HLPERIOD(chan) ((chan) * REG_GROUP + REG_HLPERIOD)

you have to lookup two additional symbols.

Also PWM is a prefix that is too generic.

>  #define SG2042_PWM_CHANNELNUM	4
>=20
> @@ -51,6 +53,12 @@
>  struct sg2042_pwm_ddata {
>  	void __iomem *base;
>  	unsigned long clk_rate_hz;
> +	struct mutex lock;

What does this lock protect? Note that there is a chip lock that is held
when .apply() is called, to serialize apply calls for a single chip. I
guess this can and should be dropped.

> +};
> +
> +struct sg2042_chip_data {
> +	const struct pwm_ops ops;
> +	bool atomic;
>  };
>=20
>  /*
> @@ -62,8 +70,8 @@ static void pwm_sg2042_config(struct sg2042_pwm_ddata *=
ddata, unsigned int chan,
>  {
>  	void __iomem *base =3D ddata->base;
>=20
> -	writel(period_ticks, base + SG2042_PWM_PERIOD(chan));
> -	writel(hlperiod_ticks, base + SG2042_PWM_HLPERIOD(chan));
> +	writel(period_ticks, base + PWM_PERIOD(chan));
> +	writel(hlperiod_ticks, base + PWM_HLPERIOD(chan));

The register renaming adds really quite some noise that is actually
unrelated to this patch. If you really think the register defines need
renaming, do that in a separate patch (and justify it well).

>  }
>=20
>  static int pwm_sg2042_apply(struct pwm_chip *chip, struct pwm_device *pw=
m,
> @@ -104,8 +112,8 @@ static int pwm_sg2042_get_state(struct pwm_chip *chip=
, struct pwm_device *pwm,
>  	u32 hlperiod_ticks;
>  	u32 period_ticks;
>=20
> -	period_ticks =3D readl(ddata->base + SG2042_PWM_PERIOD(chan));
> -	hlperiod_ticks =3D readl(ddata->base + SG2042_PWM_HLPERIOD(chan));
> +	period_ticks =3D readl(ddata->base + PWM_PERIOD(chan));
> +	hlperiod_ticks =3D readl(ddata->base + PWM_HLPERIOD(chan));
>=20
>  	if (!period_ticks) {
>  		state->enabled =3D false;
> @@ -123,13 +131,112 @@ static int pwm_sg2042_get_state(struct pwm_chip *c=
hip, struct pwm_device *pwm,
>  	return 0;
>  }
>=20
> -static const struct pwm_ops pwm_sg2042_ops =3D {
> -	.apply =3D pwm_sg2042_apply,
> -	.get_state =3D pwm_sg2042_get_state,
> +static void pwm_sg2044_config(struct sg2042_pwm_ddata *ddata, struct pwm=
_device *pwm, bool enabled)
> +{
> +	u32 pwm_value;
> +
> +	pwm_value =3D readl(ddata->base + REG_PWMSTART);
> +
> +	if (enabled)
> +		writel(pwm_value | BIT(pwm->hwpwm), ddata->base + REG_PWMSTART);
> +	else
> +		writel(pwm_value & ~BIT(pwm->hwpwm), ddata->base + REG_PWMSTART);
> +}
> +
> +static void pwm_sg2044_set_outputenable(struct sg2042_pwm_ddata *ddata, =
struct pwm_device *pwm,
> +					bool enabled)
> +{
> +	u32 pwm_value;
> +
> +	pwm_value =3D readl(ddata->base + REG_PWM_OE);
> +
> +	if (enabled)
> +		writel(pwm_value | BIT(pwm->hwpwm), ddata->base + REG_PWM_OE);
> +	else
> +		writel(pwm_value & ~BIT(pwm->hwpwm), ddata->base + REG_PWM_OE);
> +}
> +
> +static int pwm_sg2044_set_polarity(struct sg2042_pwm_ddata *ddata, struc=
t pwm_device *pwm,
> +				   const struct pwm_state *state)
> +{
> +	enum pwm_polarity polarity;
> +	u32 pwm_value;
> +
> +	pwm_value =3D readl(ddata->base + REG_POLARITY);
> +
> +	polarity =3D state->polarity;
> +
> +	if (polarity =3D=3D PWM_POLARITY_NORMAL)
> +		pwm_value &=3D ~BIT(pwm->hwpwm);
> +	else
> +		pwm_value |=3D BIT(pwm->hwpwm);
> +
> +	writel(pwm_value, ddata->base + REG_POLARITY);

I like this idiom better than the one used in
pwm_sg2044_set_outputenable() and pwm_sg2044_config(). However drop the
local variable polarity.

> +	return 0;
> +}
> +
> +static int pwm_sg2044_apply(struct pwm_chip *chip, struct pwm_device *pw=
m,
> +			    const struct pwm_state *state)
> +{
> +	struct sg2042_pwm_ddata *ddata =3D pwmchip_get_drvdata(chip);
> +	u32 hlperiod_ticks;
> +	u32 period_ticks;
> +
> +	if (!state->enabled) {
> +		pwm_sg2044_config(ddata, pwm, false);
> +		return 0;
> +	}
> +
> +	pwm_sg2044_set_polarity(ddata, pwm, state);
> +
> +	/*
> +	 * Duration of High level (duty_cycle) =3D HLPERIOD x Period_of_input_c=
lk
> +	 * Duration of One Cycle (period) =3D PERIOD x Period_of_input_clk
> +	 */
> +	period_ticks =3D min(mul_u64_u64_div_u64(ddata->clk_rate_hz, state->per=
iod,
> +					       NSEC_PER_SEC), U32_MAX);
> +	hlperiod_ticks =3D min(mul_u64_u64_div_u64(ddata->clk_rate_hz, state->d=
uty_cycle,
> +						 NSEC_PER_SEC), U32_MAX);

This is the same calculation as for sg2042. I think I'd put that in a
function that is used by both variants.

> +	dev_dbg(pwmchip_parent(chip), "chan[%u]: PERIOD=3D%u, HLPERIOD=3D%u\n",
> +		pwm->hwpwm, period_ticks, hlperiod_ticks);

Now that there are more register values, please add them all to the
debug output.

> +	pwm_sg2042_config(ddata, pwm->hwpwm, period_ticks, hlperiod_ticks);
> +
> +	guard(mutex)(&ddata->lock);
> +
> +	/*
> +	 * re-enable PWMSTART to refresh the register period
> +	 */
> +	pwm_sg2044_config(ddata, pwm, false);

pwm_sg2044_config() is conceptually different to pwm_sg2042_config().
This is irritating, so please find a better name.

> +	pwm_sg2044_set_outputenable(ddata, pwm, true);
> +	pwm_sg2044_config(ddata, pwm, true);
> +
> +	return 0;
> +}
> +
> +static const struct sg2042_chip_data sg2042_chip_data =3D {
> +	.ops =3D {
> +		.apply =3D pwm_sg2042_apply,
> +		.get_state =3D pwm_sg2042_get_state,
> +	},
> +	.atomic =3D true,
> +};
> +
> +static const struct sg2042_chip_data sg2044_chip_data =3D {
> +	.ops =3D {
> +		.apply =3D pwm_sg2044_apply,
> +		.get_state =3D pwm_sg2042_get_state,
> +	},
> +	.atomic =3D false,

If you drop the mutex don't forget to drop this one, too.

>  };

Best regards
Uwe

--pdievs2tczsk2og6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfznREACgkQj4D7WH0S
/k5IGQgAuKXpR7T10Khnr9B2l20fU/CYqEoy5dSxjYN0+CoYrIAQuN06iXb2kGk7
L62b9E0X9INBEJZClH5a6BpNVCOhkcDc+rs2XYL7Aq8248jVS74ybVoZByyRqi/b
B5sKVoGbh+cHPJjmtVxzvUr83hedydWfqNt43tUfjhjsa5zUPmk+zUvsZ6qh2Jzw
wH9jLYMmMH13kGrEo0szGFqM3DLI6UldaTIUBueFnZjHHxxct5cxFUwdLWGNoUvK
xwmykjwSxOKLWqT0kQuot0gG9bxZFsd6O3s0Y9SADPcaUMYckc0uptjWaaQNifr5
miGS4qqA5OBH+ZCZlche16tmPnzvxw==
=xehm
-----END PGP SIGNATURE-----

--pdievs2tczsk2og6--

