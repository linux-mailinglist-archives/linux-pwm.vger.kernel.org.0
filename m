Return-Path: <linux-pwm+bounces-6130-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECC2AC4215
	for <lists+linux-pwm@lfdr.de>; Mon, 26 May 2025 17:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 001F6164C19
	for <lists+linux-pwm@lfdr.de>; Mon, 26 May 2025 15:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AFD20E717;
	Mon, 26 May 2025 15:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="njDP9GB1"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896181FFC4F;
	Mon, 26 May 2025 15:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748271988; cv=none; b=WdNoAlczO4Z+FTGUPhmq6CKMVqutcRprWdxQW+O0bvyhRhis96qC/YnBEdXL9ixR714znGJeAEU5t0IHuWpVJ+W189Lrr7Csa6vzmkimIg74bSd6CWiIw+qDp/vt5ZN6vTOlzI1ZOoP2ZBUTsZG3gc2ZdkCiyjB5S3yF3B7NC2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748271988; c=relaxed/simple;
	bh=VDehJEu3mvVGGIZYejoQjoQjPFUQLfXRf+ay1uKxd7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mq29cmm3PB8tjUR5UOT7Q/O8yrCLZn3QR0C4tDW+bqwpulx2KwC4X9p9wrr+RFYnOYwDh+SM5YomAaL9WLyCNe0sHGEUecmBFfuE6CHIshW+M4MdUZYC7YnVIgGDIRIfAd055XJRiorSuvr7nsgv2hJ5OjnS9eccoX6Fr0x6kBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=njDP9GB1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C197C4CEE7;
	Mon, 26 May 2025 15:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748271988;
	bh=VDehJEu3mvVGGIZYejoQjoQjPFUQLfXRf+ay1uKxd7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=njDP9GB1lVt4FpDlHEIy110BDtD4oTMrJnJxIIAsDW8TjajQhmIt8IoiQ+DVE4CFo
	 KWjoVM9tTx3IVTsNqE4IQg3cwGx/Ism/9+rfNB5NGFbZBgtt5ZExvQfqigX/N2DObV
	 xsqnB9NBDWKtYHTlXJ2nC/aUMMKm8bNbcq5jZNvWCl3VExjHadajbOr0w1QjyZ4Tb6
	 GX6EdXL2j0ITEJx4xqSgtEDVP4jQxegr4uSk1YXxOjicaq4Sk4L4hJezlKDjVEa99s
	 Y1YEZiLNULUBcfG7eRjErctBHKzkGZqwXyLT6a+swGaOF4bckjaVRVk4HLGHzJE0LW
	 cOVupe/Ia8WeQ==
Date: Mon, 26 May 2025 17:06:25 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Longbin Li <looong.bin@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 3/3] pwm: sophgo: add driver for SG2044
Message-ID: <jo4ustzbkswmeive5s4tepwhzeoeswa4knfihkzh6eylujeid4@dj2a2nzp2a5v>
References: <20250428013501.6354-1-looong.bin@gmail.com>
 <20250428013501.6354-4-looong.bin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="viwcriticwpgs6cr"
Content-Disposition: inline
In-Reply-To: <20250428013501.6354-4-looong.bin@gmail.com>


--viwcriticwpgs6cr
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 3/3] pwm: sophgo: add driver for SG2044
MIME-Version: 1.0

On Mon, Apr 28, 2025 at 09:34:50AM +0800, Longbin Li wrote:
> Add PWM controller for SG2044 on base of SG2042.
>=20
> Signed-off-by: Longbin Li <looong.bin@gmail.com>
> Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
> ---
>  drivers/pwm/pwm-sophgo-sg2042.c | 89 ++++++++++++++++++++++++++++++++-
>  1 file changed, 87 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-sophgo-sg2042.c b/drivers/pwm/pwm-sophgo-sg2=
042.c
> index 23a83843ba53..5bb92c910540 100644
> --- a/drivers/pwm/pwm-sophgo-sg2042.c
> +++ b/drivers/pwm/pwm-sophgo-sg2042.c
> @@ -13,6 +13,9 @@
>   *   the running period.
>   * - When PERIOD and HLPERIOD is set to 0, the PWM wave output will
>   *   be stopped and the output is pulled to high.
> + * - SG2044 support polarity while SG2042 does not. When PWMSTART is
> + *   false, POLARITY being NORMAL will make output being low,
> + *   POLARITY being INVERSED will make output being high.

Without detailed knowledge about the hardware this isn't understandable.
What is PWMSTART? I think this can just read:

	SG2044 supports both polarities, SG2042 only normal polarity.

The rest is an implementation detail.

>   * See the datasheet [1] for more details.
>   * [1]:https://github.com/sophgo/sophgo-doc/tree/main/SG2042/TRM

This only describes SG2042, right? Can you please add a link for the new
variant?

>   */
> @@ -26,6 +29,10 @@
>  #include <linux/pwm.h>
>  #include <linux/reset.h>
>=20
> +#define SG2044_PWM_POLARITY		0x40
> +#define SG2044_PWM_PWMSTART		0x44
> +#define SG2044_PWM_OE			0xd0
> +
>  #define SG2042_PWM_HLPERIOD(chan) ((chan) * 8 + 0)
>  #define SG2042_PWM_PERIOD(chan) ((chan) * 8 + 4)
>=20
> @@ -72,8 +79,8 @@ static void pwm_set_dutycycle(struct pwm_chip *chip, st=
ruct pwm_device *pwm,
>  	period_ticks =3D min(mul_u64_u64_div_u64(ddata->clk_rate_hz, state->per=
iod, NSEC_PER_SEC), U32_MAX);
>  	hlperiod_ticks =3D min(mul_u64_u64_div_u64(ddata->clk_rate_hz, state->d=
uty_cycle, NSEC_PER_SEC), U32_MAX);
>=20
> -	dev_dbg(pwmchip_parent(chip), "chan[%u]: PERIOD=3D%u, HLPERIOD=3D%u\n",
> -		pwm->hwpwm, period_ticks, hlperiod_ticks);
> +	dev_dbg(pwmchip_parent(chip), "chan[%u]: ENABLE=3D%u, PERIOD=3D%u, HLPE=
RIOD=3D%u, POLARITY=3D%u\n",
> +		pwm->hwpwm, state->enabled, period_ticks, hlperiod_ticks, state->polar=
ity);
>=20
>  	pwm_sg2042_config(ddata, pwm->hwpwm, period_ticks, hlperiod_ticks);
>  }
> @@ -123,6 +130,74 @@ static int pwm_sg2042_get_state(struct pwm_chip *chi=
p, struct pwm_device *pwm,
>  	return 0;
>  }
>=20
> +static void pwm_sg2044_set_start(struct sg2042_pwm_ddata *ddata, struct =
pwm_device *pwm,
> +				 bool enabled)
> +{
> +	u32 pwm_value;
> +
> +	pwm_value =3D readl(ddata->base + SG2044_PWM_PWMSTART);

Please use a variable name that matches the register this is used for.

> +	if (enabled)
> +		pwm_value |=3D BIT(pwm->hwpwm);
> +	else
> +		pwm_value &=3D ~BIT(pwm->hwpwm);
> +
> +	writel(pwm_value, ddata->base + SG2044_PWM_PWMSTART);
> +}
> +
> +static void pwm_sg2044_set_outputdir(struct sg2042_pwm_ddata *ddata, str=
uct pwm_device *pwm,
> +				     bool enabled)
> +{
> +	u32 pwm_value;
> +
> +	pwm_value =3D readl(ddata->base + SG2044_PWM_OE);
> +
> +	if (enabled)
> +		pwm_value |=3D BIT(pwm->hwpwm);
> +	else
> +		pwm_value &=3D ~BIT(pwm->hwpwm);
> +
> +	writel(pwm_value, ddata->base + SG2044_PWM_OE);
> +}
> +
> +static void pwm_sg2044_set_polarity(struct sg2042_pwm_ddata *ddata, stru=
ct pwm_device *pwm,
> +				    const struct pwm_state *state)
> +{
> +	u32 pwm_value;
> +
> +	pwm_value =3D readl(ddata->base + SG2044_PWM_POLARITY);
> +
> +	if (state->polarity =3D=3D PWM_POLARITY_NORMAL)
> +		pwm_value &=3D ~BIT(pwm->hwpwm);
> +	else
> +		pwm_value |=3D BIT(pwm->hwpwm);
> +
> +	writel(pwm_value, ddata->base + SG2044_PWM_POLARITY);
> +}
> +
> +static int pwm_sg2044_apply(struct pwm_chip *chip, struct pwm_device *pw=
m,
> +			    const struct pwm_state *state)
> +{
> +	struct sg2042_pwm_ddata *ddata =3D pwmchip_get_drvdata(chip);
> +
> +	pwm_sg2044_set_polarity(ddata, pwm, state);
> +
> +	pwm_set_dutycycle(chip, pwm, state);
> +
> +	/*
> +	 * re-enable PWMSTART to refresh the register period
> +	 */
> +	pwm_sg2044_set_start(ddata, pwm, false);

I don't understand the effect of the START register.=20

> +	if (!state->enabled)
> +		return 0;
> +
> +	pwm_sg2044_set_outputdir(ddata, pwm, true);
> +	pwm_sg2044_set_start(ddata, pwm, true);
> +
> +	return 0;
> +}
> +
>  static const struct sg2042_chip_data sg2042_chip_data =3D {
>  	.ops =3D {
>  		.apply =3D pwm_sg2042_apply,

Best regards
Uwe

--viwcriticwpgs6cr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmg0g24ACgkQj4D7WH0S
/k7dIggAo+YTusAZB1ob16Tw3EM+pCp99BlXFNjlZ41rn20Fd9JAUzE0qSfA9eOV
ZYyEmuv+7p5Simy9BqbKtJw0qgiklqBuO104ab41OS9+xSI/+G9HvED9W2u88MrX
qyaWrqXvKF4f3PxU9f6oJggIhnAz8BJp2ZEDQfRUGb+Abyf/Kz6YYddcnIH/tA9w
5VQW/aYwMakE60kq1qe1iZs5k+WjGNbOyjfZwbsZ8wPBPm24opp3FFrCnozjbN6v
OsyCmyup0ZesIod/tYzjekCP9Czl4RiffGUVpJjDI1LIfrf/3NpQZMiR7uDUvcrN
R84G2/lOOCvPFcINYZST/0Y0ezK8bA==
=s+7h
-----END PGP SIGNATURE-----

--viwcriticwpgs6cr--

