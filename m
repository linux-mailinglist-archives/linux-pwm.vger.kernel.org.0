Return-Path: <linux-pwm+bounces-4754-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54755A24901
	for <lists+linux-pwm@lfdr.de>; Sat,  1 Feb 2025 13:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C95F9161DAE
	for <lists+linux-pwm@lfdr.de>; Sat,  1 Feb 2025 12:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B211187859;
	Sat,  1 Feb 2025 12:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kyiZ/TOU"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB681AD39;
	Sat,  1 Feb 2025 12:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738413159; cv=none; b=IKIEQF5eTRdzZZfrEJSHuml+EgoUXiO2N4uCiHa0BG71VHN+VWUczvcopUgCPN12I1ZstseuNGTWkZaD8czwAm0fcp5SwiJGZJRavC83ZBGtY4vYdXgBLhl8kSxFdQ7dMTaTvgvTRhquWIy2Q0fcGjkppZcY5utyMGwGhRnsdS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738413159; c=relaxed/simple;
	bh=PEzHjKXdPuc1LDdBff3EJ1flAP94t2mCgTXKApRYVEo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jjIpPoa8wfsl/kTanRfD2c93JFFhGJHvtaTtR8/K/syPXfZ5G75GaEhnrJeaWSsbd00hUCvOZTWQNrjFNvYa85UgTv67n2IU7NT4xPpYFC7FgHqYRY4gREMvyDfz+9kBzwjKVu6CZwkfa0oRxj7vwZVVi7hybJlJHs+EkMCF1xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kyiZ/TOU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAB55C4CED3;
	Sat,  1 Feb 2025 12:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738413158;
	bh=PEzHjKXdPuc1LDdBff3EJ1flAP94t2mCgTXKApRYVEo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kyiZ/TOUoiIY7UQYF8RPeL049LDgknw1q61Sv0fChCMZH2T4LSGy3Kd+Y+xmqqSil
	 NMwortEcmrgK3IVifSVsoTpuwUg6kE5RQHJBSONppdc+/CGm/iIpVNJz0UrS58+Jz4
	 U0N0fq7XlxgMEIepkqvZkdtTCcguOxKKLV83lgLkcM9kECJmiEjM7PvqHL1eoOZbo+
	 j9aEvK+BAgHIB4B4StpYhdLHKaMyw9aOEaaRrJZDMLSk/yTNq3WVrnamq/k/FtSs29
	 DIMAEiv84LkDDZ8QTVTNRT7OE0LIOd98piloR+8grn62JzIem0Vik6yULpGtb4NFJE
	 euxUmceCOp9vA==
Date: Sat, 1 Feb 2025 12:32:30 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, Nuno Sa <nuno.sa@analog.com>
Subject: Re: [PATCH v6 2/3] iio: frequency: adf4371: add refin mode
Message-ID: <20250201123230.017884a2@jic23-huawei>
In-Reply-To: <20250127101026.5320-3-antoniu.miclaus@analog.com>
References: <20250127101026.5320-1-antoniu.miclaus@analog.com>
	<20250127101026.5320-3-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Jan 2025 12:10:22 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add support for single-ended/differential reference input mode.
>=20
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> no changes in v6.
This needed a rebase. There is no st->clkin any more.

Rather than go around again, I fixed it up as:
diff --git a/drivers/iio/frequency/adf4371.c b/drivers/iio/frequency/adf437=
1.c
index 205dfd341489..41155af3c4f6 100644
--- a/drivers/iio/frequency/adf4371.c
+++ b/drivers/iio/frequency/adf4371.c
@@ -593,10 +593,10 @@ static int adf4371_probe(struct spi_device *spi)
=20
        st->ref_diff_en =3D false;
=20
-       st->clkin =3D devm_clk_get_enabled(&spi->dev, "clkin");
-       if (IS_ERR(st->clkin)) {
-               st->clkin =3D devm_clk_get_enabled(&spi->dev, "clkin-diff");
-               if (IS_ERR(st->clkin))
+       clkin =3D devm_clk_get_enabled(&spi->dev, "clkin");
+       if (IS_ERR(clkin)) {
+               clkin =3D devm_clk_get_enabled(&spi->dev, "clkin-diff");
+               if (IS_ERR(clkin))
                        return dev_err_probe(&spi->dev, PTR_ERR(clkin),
                                     "Failed to get clkin/clkin-diff\n");
                st->ref_diff_en =3D true;


>  drivers/iio/frequency/adf4371.c | 31 +++++++++++++++++++++++++++----
>  1 file changed, 27 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/iio/frequency/adf4371.c b/drivers/iio/frequency/adf4=
371.c
> index d752507e0c98..205dfd341489 100644
> --- a/drivers/iio/frequency/adf4371.c
> +++ b/drivers/iio/frequency/adf4371.c
> @@ -42,6 +42,10 @@
>  #define ADF4371_MOD2WORD_MSK		GENMASK(5, 0)
>  #define ADF4371_MOD2WORD(x)		FIELD_PREP(ADF4371_MOD2WORD_MSK, x)
> =20
> +/* ADF4371_REG22 */
> +#define ADF4371_REFIN_MODE_MASK		BIT(6)
> +#define ADF4371_REFIN_MODE(x)		FIELD_PREP(ADF4371_REFIN_MODE_MASK, x)
> +
>  /* ADF4371_REG24 */
>  #define ADF4371_RF_DIV_SEL_MSK		GENMASK(6, 4)
>  #define ADF4371_RF_DIV_SEL(x)		FIELD_PREP(ADF4371_RF_DIV_SEL_MSK, x)
> @@ -70,6 +74,7 @@
> =20
>  #define ADF4371_MAX_FREQ_PFD		250000000UL /* Hz */
>  #define ADF4371_MAX_FREQ_REFIN		600000000UL /* Hz */
> +#define ADF4371_MAX_FREQ_REFIN_SE	500000000UL /* Hz */
> =20
>  /* MOD1 is a 24-bit primary modulus with fixed value of 2^25 */
>  #define ADF4371_MODULUS1		33554432ULL
> @@ -176,6 +181,7 @@ struct adf4371_state {
>  	unsigned int mod2;
>  	unsigned int rf_div_sel;
>  	unsigned int ref_div_factor;
> +	bool ref_diff_en;
>  	u8 buf[10] __aligned(IIO_DMA_MINALIGN);
>  };
> =20
> @@ -505,6 +511,17 @@ static int adf4371_setup(struct adf4371_state *st)
>  				 ADF4371_ADDR_ASC(1) | ADF4371_ADDR_ASC_R(1));
>  	if (ret < 0)
>  		return ret;
> +
> +	if ((st->ref_diff_en && st->clkin_freq > ADF4371_MAX_FREQ_REFIN) ||
> +	    (!st->ref_diff_en && st->clkin_freq > ADF4371_MAX_FREQ_REFIN_SE))
> +		return -EINVAL;
> +
> +	ret =3D regmap_update_bits(st->regmap,  ADF4371_REG(0x22),
> +				 ADF4371_REFIN_MODE_MASK,
> +				 ADF4371_REFIN_MODE(st->ref_diff_en));
> +	if (ret < 0)
> +		return ret;
> +
>  	/*
>  	 * Calculate and maximize PFD frequency
>  	 * fPFD =3D REFIN =C3=97 ((1 + D)/(R =C3=97 (1 + T)))
> @@ -574,10 +591,16 @@ static int adf4371_probe(struct spi_device *spi)
>  	indio_dev->channels =3D st->chip_info->channels;
>  	indio_dev->num_channels =3D st->chip_info->num_channels;
> =20
> -	clkin =3D devm_clk_get_enabled(&spi->dev, "clkin");
> -	if (IS_ERR(clkin))
> -		return dev_err_probe(&spi->dev, PTR_ERR(clkin),
> -				     "Failed to get clkin\n");
> +	st->ref_diff_en =3D false;
> +
> +	st->clkin =3D devm_clk_get_enabled(&spi->dev, "clkin");
> +	if (IS_ERR(st->clkin)) {
> +		st->clkin =3D devm_clk_get_enabled(&spi->dev, "clkin-diff");
> +		if (IS_ERR(st->clkin))
> +			return dev_err_probe(&spi->dev, PTR_ERR(clkin),
> +				     "Failed to get clkin/clkin-diff\n");
> +		st->ref_diff_en =3D true;
> +	}
> =20
>  	st->clkin_freq =3D clk_get_rate(clkin);
> =20


