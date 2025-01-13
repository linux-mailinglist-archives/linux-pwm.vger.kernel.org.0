Return-Path: <linux-pwm+bounces-4586-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59960A0B3B6
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Jan 2025 10:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C75537A41F7
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Jan 2025 09:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65401FDA78;
	Mon, 13 Jan 2025 09:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlT+pHkc"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03BC1FDA75;
	Mon, 13 Jan 2025 09:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736762268; cv=none; b=oZ8gRHf1B+S3NNZL3rZ0xcdroTau1NPtuLJ5DjuL2dnHqVsvU9KZGzJZpE2Zs3liKCLu6T03KYos/x0PfJa/wE/XoFhzok6+1V49ZiSoSR0g9G40v/f6P59YsAmyqLP3MAv5HE4hEcgcErC776Oc/CAgrguCSUpuZ2oAXKOsADE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736762268; c=relaxed/simple;
	bh=Ak5A9WC39pcHHqwhiYHeLBhfOZ1U66L88Nfafv/TBuY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=taY5mv1elRSW9fNGz9aPAXRXOSVpyO6Qkf7XGBf36O63d7tG4pXXky/QOv0SM4vsRssPRtoZvvElJoJxVfpsJdH7BYJcnaVuZlHlU2goIiSdgXhSI/LB1BYw5CvNjOYPLxetPGjPM46He8S7gZ3g2YNrSP32oWHuEwNDI6TofDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JlT+pHkc; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3862ca8e0bbso3206484f8f.0;
        Mon, 13 Jan 2025 01:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736762265; x=1737367065; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=crb9w7N1Br9cnzSnVNojrFERCcDugXpqOLqpJee+IV4=;
        b=JlT+pHkc2gJ+xfoSigYPCo4ad0OD1WOK/uoHmgoYx5HhThdgOT9J6yspEmWH36XSNn
         3M8XZtSwngqlOjS7ASMW/NF9KlX+F7aXO06M4nP1emXQCVyJnV8MrzcT06irReQJhm/g
         tjge0L/yT8QkLnzt40iquDmZnHiicSXgKxJZkPn0uxXkQWX1PDBk79s/0x/Sw/oa2eLM
         hP2NUCZ+nc4F+oNbyHV/OraJT46KT7OTeG0ha3fEOe3harr+tDCwOIvZoxYtSjnNh/JP
         kRyelLQqaHqi5RMEzLN7YFdkU8nuj/Rwx93FR6aGIru8/9PgJ0Lh5nh04LdveYmRfcrP
         0kXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736762265; x=1737367065;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=crb9w7N1Br9cnzSnVNojrFERCcDugXpqOLqpJee+IV4=;
        b=AuCKzLJeurkN5Nc9tWxLq1AMbC0oTMqNoTZ79hi1z8HwKmNYMdiTAXa+gnk8QTS/VT
         Tc8igGOlKFSP6SBwbzPUJvF1ixY1hje59eKXiNhNLGRPxvH7eKCTW1vLhg+U09RNOmbj
         uTgt7W79+RqOYLXd9KhiUwJz47it0J0eHFzX6SDVmtvv1PZlMLLUGUqEWlne08OUaH+C
         FgrzgIqcMrO0G1p1eO4oIcjMQAF1M82mJS3IfDnHMX636RkTi6OyI/K022o4bdifrOP5
         XtMWDbmbzbgrg2LDXsecm2rQdVjgiHa+7tzvQiMC+oKReIzIQNfj3P928y6STlw3E9SJ
         qqnQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0Gt6T5aE9Cr0Nbmt8k4vHpYodNI0VpK0bOkCw5lYD4Aa3E0M91yAfT1F1ZKF+8j3AdJ+mkf1QsCBh@vger.kernel.org, AJvYcCX9nSVDa1/oC4fdEJwdrot2AbNIUAIPMlMScfWJiXVHZ85C90uw4H85ypaoPP+mjh3ST+G4xIzjAHWT@vger.kernel.org, AJvYcCXI62WvEIhBZVPRLRZzNXRS3kNk4OnnKCqiKagPicnddHy+wdsaijGql1xb4NM1bu3lDCFa+tnrfeG2RBkj@vger.kernel.org, AJvYcCXsQpotF60CL1GwZGJEMi4oY42Tm3Atg6y4kSUyDVUpakLwfupegPY7R1yFeh16xvQuoR0V2zeyRUAD@vger.kernel.org
X-Gm-Message-State: AOJu0YzQV7WHAoQqR8A2DmDu0D5oxbE9Lzi3y8ES6aAIagO1mCPjSrNk
	RvIele+h/ImPzP+x7Ep1DvVqB9SYNPzDdaglD2XSowa4Ktu/lqKGAzJ1v3bh+0g=
X-Gm-Gg: ASbGncsPlwUA1xHC8NcH90hp7bpNxn+jUCiMHjmlnuYjEhRuSKWwN3AQr4RUN8n2oN4
	0ZbAnuU7pXctQLDUhduND98yIF/2dQAqL1kb63ksoddXJnPnl0tHWoHYve5DX04pGILaIxNfgjX
	9pzds6qstzcYvzHOerToXbIV0EKqHRmzM+H0qrUiFRcrqAmsXvIpmdRUhpsCNFK6x6FGe8/3KkS
	HoZxmYUv8tqxrU5VzK92pTgMZBJ4NxP1CC2GsHDk7mD0kk3s0HHxbn+MPLYJwLW6hFGYJyNU5OD
	Jq81MYvTsAziYcVzMAhZwepD4jt3
X-Google-Smtp-Source: AGHT+IEzlZbiVzNwCaAYSI9mj9zdyEk/quq7aRuxSMth/3Sm6XHHNECBTBj00CH8oOSaIlqqL+ayTA==
X-Received: by 2002:a05:6000:470d:b0:382:4ab4:b3e5 with SMTP id ffacd0b85a97d-38a87087028mr19511494f8f.0.1736762265245;
        Mon, 13 Jan 2025 01:57:45 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a9362947dsm10214864f8f.40.2025.01.13.01.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 01:57:44 -0800 (PST)
Message-ID: <f61195c1bcb468baca8cc552c191e469e9db4c3d.camel@gmail.com>
Subject: Re: [PATCH v4 2/3] iio: frequency: adf4371: add refin mode
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org, 
	robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org
Date: Mon, 13 Jan 2025 09:57:44 +0000
In-Reply-To: <20250109133707.3845-3-antoniu.miclaus@analog.com>
References: <20250109133707.3845-1-antoniu.miclaus@analog.com>
	 <20250109133707.3845-3-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-01-09 at 15:37 +0200, Antoniu Miclaus wrote:
> Add support for single-ended/differential reference input mode.
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

Reviewed-by: Nuno Sa <nunbo.sa@analog.com>

> changes in v4:
> =C2=A0- parse input clock depending on the name and adjust the refin mode
> =C2=A0=C2=A0 accordingly.
> =C2=A0drivers/iio/frequency/adf4371.c | 28 ++++++++++++++++++++++++++--
> =C2=A01 file changed, 26 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/frequency/adf4371.c b/drivers/iio/frequency/adf4=
371.c
> index b27088464826..50450e7b5464 100644
> --- a/drivers/iio/frequency/adf4371.c
> +++ b/drivers/iio/frequency/adf4371.c
> @@ -41,6 +41,10 @@
> =C2=A0#define ADF4371_MOD2WORD_MSK		GENMASK(5, 0)
> =C2=A0#define ADF4371_MOD2WORD(x)		FIELD_PREP(ADF4371_MOD2WORD_MSK, x)
> =C2=A0
> +/* ADF4371_REG22 */
> +#define ADF4371_REFIN_MODE_MASK		BIT(6)
> +#define ADF4371_REFIN_MODE(x)		FIELD_PREP(ADF4371_REFIN_MODE_MASK,
> x)
> +
> =C2=A0/* ADF4371_REG24 */
> =C2=A0#define ADF4371_RF_DIV_SEL_MSK		GENMASK(6, 4)
> =C2=A0#define ADF4371_RF_DIV_SEL(x)		FIELD_PREP(ADF4371_RF_DIV_SEL_MSK, x=
)
> @@ -69,6 +73,7 @@
> =C2=A0
> =C2=A0#define ADF4371_MAX_FREQ_PFD		250000000UL /* Hz */
> =C2=A0#define ADF4371_MAX_FREQ_REFIN		600000000UL /* Hz */
> +#define ADF4371_MAX_FREQ_REFIN_SE	500000000UL /* Hz */
> =C2=A0
> =C2=A0/* MOD1 is a 24-bit primary modulus with fixed value of 2^25 */
> =C2=A0#define ADF4371_MODULUS1		33554432ULL
> @@ -175,6 +180,7 @@ struct adf4371_state {
> =C2=A0	unsigned int mod2;
> =C2=A0	unsigned int rf_div_sel;
> =C2=A0	unsigned int ref_div_factor;
> +	bool ref_diff_en;
> =C2=A0	u8 buf[10] __aligned(IIO_DMA_MINALIGN);
> =C2=A0};
> =C2=A0
> @@ -503,6 +509,17 @@ static int adf4371_setup(struct adf4371_state *st)
> =C2=A0				 ADF4371_ADDR_ASC(1) |
> ADF4371_ADDR_ASC_R(1));
> =C2=A0	if (ret < 0)
> =C2=A0		return ret;
> +
> +	if ((st->ref_diff_en && st->clkin_freq > ADF4371_MAX_FREQ_REFIN) ||
> +	=C2=A0=C2=A0=C2=A0 (!st->ref_diff_en && st->clkin_freq > ADF4371_MAX_FR=
EQ_REFIN_SE))
> +		return -EINVAL;
> +
> +	ret =3D regmap_update_bits(st->regmap,=C2=A0 ADF4371_REG(0x22),
> +				 ADF4371_REFIN_MODE_MASK,
> +				 ADF4371_REFIN_MODE(st->ref_diff_en));
> +	if (ret < 0)
> +		return ret;
> +
> =C2=A0	/*
> =C2=A0	 * Calculate and maximize PFD frequency
> =C2=A0	 * fPFD =3D REFIN =C3=97 ((1 + D)/(R =C3=97 (1 + T)))
> @@ -572,9 +589,16 @@ static int adf4371_probe(struct spi_device *spi)
> =C2=A0	indio_dev->channels =3D st->chip_info->channels;
> =C2=A0	indio_dev->num_channels =3D st->chip_info->num_channels;
> =C2=A0
> +	st->ref_diff_en =3D false;
> +
> =C2=A0	st->clkin =3D devm_clk_get_enabled(&spi->dev, "clkin");
> -	if (IS_ERR(st->clkin))
> -		return PTR_ERR(st->clkin);
> +	if (IS_ERR(st->clkin)) {
> +		st->clkin =3D devm_clk_get_enabled(&spi->dev, "clkin-diff");
> +		if (IS_ERR(st->clkin))
> +			return PTR_ERR(st->clkin);
> +
> +		st->ref_diff_en =3D true;
> +	}
> =C2=A0
> =C2=A0	st->clkin_freq =3D clk_get_rate(st->clkin);
> =C2=A0


