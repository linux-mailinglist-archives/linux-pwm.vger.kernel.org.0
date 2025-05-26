Return-Path: <linux-pwm+bounces-6129-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0881FAC41F0
	for <lists+linux-pwm@lfdr.de>; Mon, 26 May 2025 16:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAF0B1775E7
	for <lists+linux-pwm@lfdr.de>; Mon, 26 May 2025 14:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC1520F06A;
	Mon, 26 May 2025 14:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3MFvLKG"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E37E433AC;
	Mon, 26 May 2025 14:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748271577; cv=none; b=HNdP44JbOBJIDjpd/AK/CwkRJoZZwz/asHOQM9Rs/iKMU3h4r4CViOfYeXFdWeX7XpJbGDRzZIF2ketQYsQuhiA+5PHzzvX6SC0jB5xtzzi7EtS2cizq5sqJaXJRxkGYAE2EDegDh3ZZ3tTAHd7At6p3oAdw0WxC+vSf0QHQaf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748271577; c=relaxed/simple;
	bh=E8SaAUgrX/X3dekablDtQmiUY499qEqCSuaUoBIMc4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YV12vJrDYUAf/atC0QV3kpxbYLN9rcAkr8bSkLgl+4RZbzgDcxhnsSa1WiF80bhvmd64BuAXGHB0uLHj9n05rDEivddVCmB/CVS6rS6vRWe262HUBKoG3WLRWCPkiqzpwrMhczAIJ55qt48nqd+UwbRwpTNMuwkr9XYIA9K4z5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3MFvLKG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AC43C4CEE7;
	Mon, 26 May 2025 14:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748271576;
	bh=E8SaAUgrX/X3dekablDtQmiUY499qEqCSuaUoBIMc4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z3MFvLKGV43p1eBMXVMy4czAhTXOz2ctCEOeVW2WnXnaTrpA/Q1ifkqOkKuCR9hQU
	 w00FPOZ4osYXe03owq6G0dRPSqmrd+XAffAauMuPgLkHKhjNh/TzUMuaEQtX+Yk9yi
	 9dGrirNlbBxKgDHBOMh/4zG7zPPuwz5zs/cq3k6PnLWIdwQRVDf/nqc48pHxJ9Qrff
	 7S5ntnrO8nuYuwOH6YCsowbLnRqQ30cWeOe3ZcmA58WVEqYvce1wnJhgpXEDYlK5TY
	 n6jC2/MwptaZ/AuiJLH76ugtEGlu6fAYbiWlst+dFQ+vSIpvU/4XBHRg8nB9dCbfHE
	 +wYm/DVOMNFlA==
Date: Mon, 26 May 2025 16:59:34 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Longbin Li <looong.bin@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 2/3] pwm: sophgo: reorganize the code structure
Message-ID: <l57yh42pb7cfbnk5z4zo473vb5pac6t4hnpg36m3iph3og4wom@kmd35myokcgp>
References: <20250428013501.6354-1-looong.bin@gmail.com>
 <20250428013501.6354-3-looong.bin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="y6wrgiquygeci5im"
Content-Disposition: inline
In-Reply-To: <20250428013501.6354-3-looong.bin@gmail.com>


--y6wrgiquygeci5im
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 2/3] pwm: sophgo: reorganize the code structure
MIME-Version: 1.0

Hello,

On Mon, Apr 28, 2025 at 09:34:49AM +0800, Longbin Li wrote:
> As the driver logic can be used in both SG2042 and SG2044, it
> will be better to reorganize the code structure.
>=20
> Signed-off-by: Longbin Li <looong.bin@gmail.com>
> Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
> ---
>  drivers/pwm/pwm-sophgo-sg2042.c | 62 +++++++++++++++++++--------------
>  1 file changed, 35 insertions(+), 27 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-sophgo-sg2042.c b/drivers/pwm/pwm-sophgo-sg2=
042.c
> index ff4639d849ce..23a83843ba53 100644
> --- a/drivers/pwm/pwm-sophgo-sg2042.c
> +++ b/drivers/pwm/pwm-sophgo-sg2042.c
> @@ -26,18 +26,6 @@
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

This seems to be still correct? Why remove it then?

>  #define SG2042_PWM_HLPERIOD(chan) ((chan) * 8 + 0)
>  #define SG2042_PWM_PERIOD(chan) ((chan) * 8 + 4)
>=20
> @@ -53,6 +41,10 @@ struct sg2042_pwm_ddata {
>  	unsigned long clk_rate_hz;
>  };
>=20
> +struct sg2042_chip_data {
> +	const struct pwm_ops ops;
> +};
> +
>  /*
>   * period_ticks: PERIOD
>   * hlperiod_ticks: HLPERIOD
> @@ -66,21 +58,13 @@ static void pwm_sg2042_config(struct sg2042_pwm_ddata=
 *ddata, unsigned int chan,
>  	writel(hlperiod_ticks, base + SG2042_PWM_HLPERIOD(chan));
>  }
>=20
> -static int pwm_sg2042_apply(struct pwm_chip *chip, struct pwm_device *pw=
m,
> -			    const struct pwm_state *state)
> +static void pwm_set_dutycycle(struct pwm_chip *chip, struct pwm_device *=
pwm,

This is not a global pwm API function, so please stick to the pwm_sg2042
prefix.

> +			      const struct pwm_state *state)
>  {
>  	struct sg2042_pwm_ddata *ddata =3D pwmchip_get_drvdata(chip);
>  	u32 hlperiod_ticks;
>  	u32 period_ticks;
>=20
> -	if (state->polarity =3D=3D PWM_POLARITY_INVERSED)
> -		return -EINVAL;
> -
> -	if (!state->enabled) {
> -		pwm_sg2042_config(ddata, pwm->hwpwm, 0, 0);
> -		return 0;
> -	}
> -
>  	/*
>  	 * Duration of High level (duty_cycle) =3D HLPERIOD x Period_of_input_c=
lk
>  	 * Duration of One Cycle (period) =3D PERIOD x Period_of_input_clk
> [...]
> @@ -123,13 +123,16 @@ static int pwm_sg2042_get_state(struct pwm_chip *ch=
ip, struct pwm_device *pwm,
>  	return 0;
>  }
>=20
> -static const struct pwm_ops pwm_sg2042_ops =3D {
> -	.apply =3D pwm_sg2042_apply,
> -	.get_state =3D pwm_sg2042_get_state,
> +static const struct sg2042_chip_data sg2042_chip_data =3D {
> +	.ops =3D {
> +		.apply =3D pwm_sg2042_apply,
> +		.get_state =3D pwm_sg2042_get_state,
> +	}
>  };
>=20
>  static const struct of_device_id sg2042_pwm_ids[] =3D {
> -	{ .compatible =3D "sophgo,sg2042-pwm" },
> +	{ .compatible =3D "sophgo,sg2042-pwm",
> +	  .data =3D &sg2042_chip_data },

I would have expected that checkpatch doesn't like that. At least I
don't. Please make this

	{
		.compatible =3D ...;
		.data =3D ...;
	},

>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, sg2042_pwm_ids);

--y6wrgiquygeci5im
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmg0gdMACgkQj4D7WH0S
/k4J4Qf8CHX9dIGtIPbLOS9813DI9uLk4w5rJKuXFCntm61HNC7eEe0RbGwRynoZ
A8E3zWI+tt4ZUmLp3nTHtrXTa3DBSG7FLpHXWCB7GogJcfcJ3NMgkqA9jJf6gjDY
ogojTOXZ8Uti38J4uXeupkpybGA/ulpdAMaDlF8gx3l8NiVzg4Eycn7yV2Z0UBhB
L1+TUXRyGKV6PZ0aKCZzVAGhBUGY3C09T5jF7xFL0ap500i5mRYeK2R+HU8ZJ8fi
Nel1QgRdVXOxIZt+/zYOQB7021f9AqTwns1oxxTN24CXN6TzsDY4dTBlnPCG5uqt
RA6ku7ja1Ot/ELHxpUYuQBSMEg+8Cg==
=dnJY
-----END PGP SIGNATURE-----

--y6wrgiquygeci5im--

