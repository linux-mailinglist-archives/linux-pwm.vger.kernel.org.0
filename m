Return-Path: <linux-pwm+bounces-4128-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 248EE9D69F9
	for <lists+linux-pwm@lfdr.de>; Sat, 23 Nov 2024 17:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3682281B23
	for <lists+linux-pwm@lfdr.de>; Sat, 23 Nov 2024 16:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F3A34545;
	Sat, 23 Nov 2024 16:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cAmOy4k+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EF617C2;
	Sat, 23 Nov 2024 16:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732378616; cv=none; b=i3j9FpFlpv/DR7frxMtp92TASbsCmN0EfPSKg0Wp2eosK+xPVJ5KyhwBKZLcGagaiFU+zsUQ1PsuuZ3Yooea2fPvbu2DCEZr7LALCM2SPBMmeLOeu3uDqAmK2Ojz6HSlwqfHwRquTbodLSkinht9x0/P/vJoR1sa78tpMC8NOm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732378616; c=relaxed/simple;
	bh=QrYGQca99pNSS32QFKzb/qidE/jOxXtlsHmhzCc+pDA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LpLCHjqoZqsd21WdBkW4SVe7H9ZhQXYR3ja70b4MM3rlpWBlP6E/AJhtYlbYQabBEcXMDeRBFD9ncl6xZ6mKkZnLnL4IFJV0Ki32aE15SUCAYTCT/DPAgFuHmU6ZQZ33Y7xrIxjGjxiw6Ostiu8eTTMXUIkOi/SyWrXt/yOieOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cAmOy4k+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E38C5C4CECD;
	Sat, 23 Nov 2024 16:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732378615;
	bh=QrYGQca99pNSS32QFKzb/qidE/jOxXtlsHmhzCc+pDA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cAmOy4k++gzo23aVP32SGFjjbFY8qxcghka4n+UKd01apBrfSpYYWrlGV2qOPopI5
	 a2uQVLHwaNZ1NwozQEmpT/JdRTf2MWoWuhoKdf10TiuV1tNohyAB8MdpjWvcgWE2hv
	 13jH+4IrWmK1QsMQFpqe5214U3aQ+lVJ8lPofcn3h93G+iDzAh5mlZ8mTQJuO50Xe4
	 EIaFDfqAYylepf3YRIfF7C93/gnIuTvc18C1CmGmLz18OeMfSH5/NIBVjN1YXqCZi/
	 5hQtwQaIRW1feMUrAL36dm0yQUMEZ+2ii2Ppk9kaUk9tVXIqo2EXIf/bQvoWUmwWW8
	 piFgO9B90vv+A==
Date: Sat, 23 Nov 2024 16:16:50 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: frequency: adf4371: add ref doubler and div2
Message-ID: <20241123161650.3487d386@jic23-huawei>
In-Reply-To: <20241122113226.49346-2-antoniu.miclaus@analog.com>
References: <20241122113226.49346-1-antoniu.miclaus@analog.com>
	<20241122113226.49346-2-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 22 Nov 2024 13:32:14 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add support for the reference doubler and the reference divide by 2
> clock.
The question of 'why' these would be set in firmware remains, but
a few trivial comments inline on the implementation.


>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>  drivers/iio/frequency/adf4371.c | 37 +++++++++++++++++++++++++++++++--
>  1 file changed, 35 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/frequency/adf4371.c b/drivers/iio/frequency/adf4=
371.c
> index b27088464826..02d42652dfdd 100644
> --- a/drivers/iio/frequency/adf4371.c
> +++ b/drivers/iio/frequency/adf4371.c
> @@ -41,6 +41,12 @@
>  #define ADF4371_MOD2WORD_MSK		GENMASK(5, 0)
>  #define ADF4371_MOD2WORD(x)		FIELD_PREP(ADF4371_MOD2WORD_MSK, x)
> =20
> +/* ADF4371_REG22 */
> +#define ADF4371_REF_DOUB_MASK		BIT(5)
> +#define ADF4371_REF_DOUB(x)		FIELD_PREP(ADF4371_REF_DOUB_MASK, x)
> +#define ADF4371_RDIV2_MASK		BIT(4)
> +#define ADF4371_RDIV2(x)		FIELD_PREP(ADF4371_RDIV2_MASK, x)
> +
>  /* ADF4371_REG24 */
>  #define ADF4371_RF_DIV_SEL_MSK		GENMASK(6, 4)
>  #define ADF4371_RF_DIV_SEL(x)		FIELD_PREP(ADF4371_RF_DIV_SEL_MSK, x)
> @@ -70,6 +76,9 @@
>  #define ADF4371_MAX_FREQ_PFD		250000000UL /* Hz */
>  #define ADF4371_MAX_FREQ_REFIN		600000000UL /* Hz */
> =20
> +#define ADF4371_MIN_CLKIN_DOUB_FREQ	10000000ULL /* Hz */
> +#define ADF4371_MAX_CLKIN_DOUB_FREQ	125000000ULL /* Hz */
> +
>  /* MOD1 is a 24-bit primary modulus with fixed value of 2^25 */
>  #define ADF4371_MODULUS1		33554432ULL
>  /* MOD2 is the programmable, 14-bit auxiliary fractional modulus */
> @@ -175,6 +184,8 @@ struct adf4371_state {
>  	unsigned int mod2;
>  	unsigned int rf_div_sel;
>  	unsigned int ref_div_factor;
> +	bool ref_doubler_en;
> +	bool ref_div2_en;
>  	u8 buf[10] __aligned(IIO_DMA_MINALIGN);
>  };
> =20
> @@ -497,22 +508,44 @@ static int adf4371_setup(struct adf4371_state *st)
>  			return ret;
>  	}
> =20
> +	if (device_property_read_bool(&st->spi->dev,
> +				      "adi,reference-doubler-enable"))
> +		st->ref_doubler_en =3D true;
> +
> +	if (device_property_read_bool(&st->spi->dev,
> +				      "adi,reference-div2-enable"))
> +		st->ref_div2_en =3D true;
	st->ref_div2_en =3D device_property_read_bool(dev, "adi,reference-div2-ena=
ble");
Line is a bit long but more readable.
struct device *dev =3D &st->spi->dev; needed at top of function.
+ do the same for ref_doubler_en..

> +
>  	/* Set address in ascending order, so the bulk_write() will work */
>  	ret =3D regmap_update_bits(st->regmap, ADF4371_REG(0x0),
>  				 ADF4371_ADDR_ASC_MSK | ADF4371_ADDR_ASC_R_MSK,
>  				 ADF4371_ADDR_ASC(1) | ADF4371_ADDR_ASC_R(1));
>  	if (ret < 0)
>  		return ret;
> +
> +	if (st->ref_doubler_en &&
> +	    (st->clkin_freq > ADF4371_MAX_CLKIN_DOUB_FREQ ||
> +	     st->clkin_freq < ADF4371_MIN_CLKIN_DOUB_FREQ))
> +		st->ref_doubler_en =3D false;
> +
> +	ret =3D regmap_update_bits(st->regmap,  ADF4371_REG(0x22),
> +				 ADF4371_REF_DOUB_MASK |
> +				 ADF4371_RDIV2_MASK,
> +				 ADF4371_REF_DOUB(st->ref_doubler_en) |
> +				 ADF4371_RDIV2(st->ref_div2_en));
> +	if (ret < 0)
> +		return ret;
> +
>  	/*
>  	 * Calculate and maximize PFD frequency
>  	 * fPFD =3D REFIN =C3=97 ((1 + D)/(R =C3=97 (1 + T)))
>  	 * Where D is the REFIN doubler bit, T is the reference divide by 2,
>  	 * R is the reference division factor
> -	 * TODO: it is assumed D and T equal 0.
>  	 */
>  	do {
>  		st->ref_div_factor++;
> -		st->fpfd =3D st->clkin_freq / st->ref_div_factor;
> +		st->fpfd =3D (st->clkin_freq * (st->ref_doubler_en ? 2 : 1)) /
> +			   (st->ref_div_factor * (st->ref_div2_en ? 2 : 1));
>  	} while (st->fpfd > ADF4371_MAX_FREQ_PFD);
> =20
>  	/* Calculate Timeouts */


