Return-Path: <linux-pwm+bounces-4587-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB20DA0B3D3
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Jan 2025 10:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5CE718853C6
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Jan 2025 10:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D53C1FDA7D;
	Mon, 13 Jan 2025 09:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3koS74+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336681FDA7A;
	Mon, 13 Jan 2025 09:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736762386; cv=none; b=RegoISLOBHY26gUY/eu2vnuzenS7gri9hA3h5+HVQjNBsqMKTadOLkBda25sMVAoz3RR9nIOxLpgaHowuiUt+bxE05SBqrewv4hhdUp32SJ44Kgz8Z0Z+m2bwytojZ+HpzWh4bB9ZYbks5XgMj+WiSqX7stiW+JSirmSuSMtrJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736762386; c=relaxed/simple;
	bh=TMRM1Fv8gFKqdE1UbE2Q54s3+cnYWq6dbIW8R8r14E8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YX6XlgmOBU9y3ty1zWm8DgJneyP1Uej2zbCUgHPLb3dD/4nR+VwJR9hWGhM8KA0p4KqJ4rr9oMmULbxP2IfQtQKWnChc3hP4WxnTCTxP0a9iPSnj7eYayCZciaLabZW8xROjRUX8dO2HJnpImXGUWzT7Nt0Ai7WPZlY1ICwU55o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a3koS74+; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4364a37a1d7so42923915e9.3;
        Mon, 13 Jan 2025 01:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736762383; x=1737367183; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Grvt8EbmAcIHzpg3W1D1PYRlOxZM8ZP8k8Gvt2W5Ydg=;
        b=a3koS74+Kq18Z3I+b4QBzBMrQACLLVius8E6PsBAfjO/drSnB2caFbnioqLK4mcWfU
         vICYnPqya2yD/DHGNvyFWDWRvOlWMHzWTuXkAQFLxGgoc5HNqHIHiduGNn6WBZN/4rzo
         aL1WNOwGsL9PTfIZJexR6F45T02bGUlNewKjmYxlA8zQnQ51g+zl4fSFGQOXDTD3EclM
         lQ3kNEsvuP3sxQITIeuAKBM0d1UHgyDCGBeCHeV9jtcGkSzaBculRPmIdE4K1gffsOgY
         WDQMOLLdZqy5bgJ6Fl67h+vJb7KL+P8mWvv8WdNEe3++UAUw5c+WfnLO62hOQxJW7uuH
         FUBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736762383; x=1737367183;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Grvt8EbmAcIHzpg3W1D1PYRlOxZM8ZP8k8Gvt2W5Ydg=;
        b=TJkqtmxKiQlEjm/TJUVr5KD729fbwa9QgnC4ClqUpYJsDPXKb0tmrBAYBsDkjLSvQr
         /BnExGnGDykA8Woa3kQCtPVemk3Nuv48FbFQo/oyhkH3+cS4zSyPmH4rEuWHNHrT8ThU
         VKy5iG4Va5/maOounCBrvcRVY+veZYwDZfCKULnmRulLI42iHhoNGGYPcQMzOhslv04w
         +gDRFZIzaa/7u1EVqB/vusmTDmOqiI+vDGrVJGefCKtJ7IuIRZD+5FQEpkmq6He+5WLZ
         yVom/ComfXtCI3FQO0mjHprBKrd1GSj3wRJZ6B5ZYw2tLthYGLizB733YKprTywvCbiz
         nhMg==
X-Forwarded-Encrypted: i=1; AJvYcCUk/+PUGqWquNa+vXsWVzf6sY4elE/5L85feA/fdjSmgxwDwvGDVubhaCDJyEsR2ZSusSfT0pVH0R2b@vger.kernel.org, AJvYcCV2XkoAgXTwOLH3gu4GfwIaMXmP88prvWkDqInXCvrQXus29akUG2qkwGtXqhPFqYOBBwpXsbM0iZJ9@vger.kernel.org, AJvYcCVc1qZg9HOIIQimHXq3D/Zb+fQ9dW5uybFyDYx6tcAEdhwVCm4gbJzFwHhvGByC/K/2cl+Y4pn/LiLh@vger.kernel.org, AJvYcCW9ocuHvSSZ6B+hilr8TlI7ZA4KS28N7GOAAUn+3D+AKN0q8tJr+gI3t4xf2GyLgDYJGIUQ49gF2IDGh8fX@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo7iBQJ1YxUdZALebl0MxcHJKXP8630hIZIzdOYo0WU54d5YzJ
	cVJJwRI0kn6geibZcXLboB+H4fA02udOUS26ys9jO1OhF1VuAtMqzTaUJEasBo4=
X-Gm-Gg: ASbGncvH778wcvsO9K28TwTMO4ReeNwxHS5yKdwo6fRuugB4lZOLa4TRrESjIMyIv7N
	/6G9oN+qfrDFSPnfEjanLfaDr0B7yHbAoag5LdY55HlAQ8mTOjgi71QFChueclquq6AkWKIbr2p
	prowVDPFj9ON4E+fGzsc8WfrjC+qBSuQeD6CuCpOE85mEeeTuId/bLhZ0zrtoPugpJRXNKrK542
	DtN4i1En0ikaNJxRxkR5kdx4ENVMp5xbbrM+jCufDi6WSS8VnvuvF/Y5uwmqsXxbtWI2FdC9vto
	CUdJUdRpxCkf391h/Ey0Yk57clzW
X-Google-Smtp-Source: AGHT+IH6+WnazZQZ1/iszbWrpyZBrOYN5kwupmq+LYvYBSZxgwSgIcXmjIXlwFWPfxn1EGARLkE52Q==
X-Received: by 2002:a05:600c:458c:b0:434:a684:9b1 with SMTP id 5b1f17b1804b1-436e267fbb5mr174969135e9.4.1736762383122;
        Mon, 13 Jan 2025 01:59:43 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2da66e6sm174091345e9.4.2025.01.13.01.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 01:59:42 -0800 (PST)
Message-ID: <a71a8fef4ededd143e117af21b51fc63112544d8.camel@gmail.com>
Subject: Re: [PATCH v4 2/3] iio: frequency: adf4371: add refin mode
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org, 
	robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org
Date: Mon, 13 Jan 2025 09:59:42 +0000
In-Reply-To: <f61195c1bcb468baca8cc552c191e469e9db4c3d.camel@gmail.com>
References: <20250109133707.3845-1-antoniu.miclaus@analog.com>
		 <20250109133707.3845-3-antoniu.miclaus@analog.com>
	 <f61195c1bcb468baca8cc552c191e469e9db4c3d.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-01-13 at 09:57 +0000, Nuno S=C3=A1 wrote:
> On Thu, 2025-01-09 at 15:37 +0200, Antoniu Miclaus wrote:
> > Add support for single-ended/differential reference input mode.
> >=20
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > ---
>=20
> Reviewed-by: Nuno Sa <nunbo.sa@analog.com>

Ups, typo:

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

>=20
> > changes in v4:
> > =C2=A0- parse input clock depending on the name and adjust the refin mo=
de
> > =C2=A0=C2=A0 accordingly.
> > =C2=A0drivers/iio/frequency/adf4371.c | 28 ++++++++++++++++++++++++++--
> > =C2=A01 file changed, 26 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/iio/frequency/adf4371.c
> > b/drivers/iio/frequency/adf4371.c
> > index b27088464826..50450e7b5464 100644
> > --- a/drivers/iio/frequency/adf4371.c
> > +++ b/drivers/iio/frequency/adf4371.c
> > @@ -41,6 +41,10 @@
> > =C2=A0#define ADF4371_MOD2WORD_MSK		GENMASK(5, 0)
> > =C2=A0#define ADF4371_MOD2WORD(x)		FIELD_PREP(ADF4371_MOD2WORD_MSK, x)
> > =C2=A0
> > +/* ADF4371_REG22 */
> > +#define ADF4371_REFIN_MODE_MASK		BIT(6)
> > +#define ADF4371_REFIN_MODE(x)		FIELD_PREP(ADF4371_REFIN_MODE_MASK,
> > x)
> > +
> > =C2=A0/* ADF4371_REG24 */
> > =C2=A0#define ADF4371_RF_DIV_SEL_MSK		GENMASK(6, 4)
> > =C2=A0#define ADF4371_RF_DIV_SEL(x)		FIELD_PREP(ADF4371_RF_DIV_SEL_MSK,
> > x)
> > @@ -69,6 +73,7 @@
> > =C2=A0
> > =C2=A0#define ADF4371_MAX_FREQ_PFD		250000000UL /* Hz */
> > =C2=A0#define ADF4371_MAX_FREQ_REFIN		600000000UL /* Hz */
> > +#define ADF4371_MAX_FREQ_REFIN_SE	500000000UL /* Hz */
> > =C2=A0
> > =C2=A0/* MOD1 is a 24-bit primary modulus with fixed value of 2^25 */
> > =C2=A0#define ADF4371_MODULUS1		33554432ULL
> > @@ -175,6 +180,7 @@ struct adf4371_state {
> > =C2=A0	unsigned int mod2;
> > =C2=A0	unsigned int rf_div_sel;
> > =C2=A0	unsigned int ref_div_factor;
> > +	bool ref_diff_en;
> > =C2=A0	u8 buf[10] __aligned(IIO_DMA_MINALIGN);
> > =C2=A0};
> > =C2=A0
> > @@ -503,6 +509,17 @@ static int adf4371_setup(struct adf4371_state *st)
> > =C2=A0				 ADF4371_ADDR_ASC(1) |
> > ADF4371_ADDR_ASC_R(1));
> > =C2=A0	if (ret < 0)
> > =C2=A0		return ret;
> > +
> > +	if ((st->ref_diff_en && st->clkin_freq > ADF4371_MAX_FREQ_REFIN) ||
> > +	=C2=A0=C2=A0=C2=A0 (!st->ref_diff_en && st->clkin_freq >
> > ADF4371_MAX_FREQ_REFIN_SE))
> > +		return -EINVAL;
> > +
> > +	ret =3D regmap_update_bits(st->regmap,=C2=A0 ADF4371_REG(0x22),
> > +				 ADF4371_REFIN_MODE_MASK,
> > +				 ADF4371_REFIN_MODE(st->ref_diff_en));
> > +	if (ret < 0)
> > +		return ret;
> > +
> > =C2=A0	/*
> > =C2=A0	 * Calculate and maximize PFD frequency
> > =C2=A0	 * fPFD =3D REFIN =C3=97 ((1 + D)/(R =C3=97 (1 + T)))
> > @@ -572,9 +589,16 @@ static int adf4371_probe(struct spi_device *spi)
> > =C2=A0	indio_dev->channels =3D st->chip_info->channels;
> > =C2=A0	indio_dev->num_channels =3D st->chip_info->num_channels;
> > =C2=A0
> > +	st->ref_diff_en =3D false;
> > +
> > =C2=A0	st->clkin =3D devm_clk_get_enabled(&spi->dev, "clkin");
> > -	if (IS_ERR(st->clkin))
> > -		return PTR_ERR(st->clkin);
> > +	if (IS_ERR(st->clkin)) {
> > +		st->clkin =3D devm_clk_get_enabled(&spi->dev, "clkin-diff");
> > +		if (IS_ERR(st->clkin))
> > +			return PTR_ERR(st->clkin);
> > +
> > +		st->ref_diff_en =3D true;
> > +	}
> > =C2=A0
> > =C2=A0	st->clkin_freq =3D clk_get_rate(st->clkin);
> > =C2=A0
>=20


