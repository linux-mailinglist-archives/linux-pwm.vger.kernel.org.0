Return-Path: <linux-pwm+bounces-4588-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1D1A0B3E7
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Jan 2025 11:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 997C3163CBF
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Jan 2025 10:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1781A2045A4;
	Mon, 13 Jan 2025 10:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnzJbHpB"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2BC204598;
	Mon, 13 Jan 2025 10:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736762519; cv=none; b=TCywsa6wIdKp2+7w8aAQVwNfxmxNBqh/xVcxi4kerKE1w6fh4jMGm7uqKIbba77QrdHYNJXrBZdUoI6Zgxb9SQq/btq7ECm/M3cKJZJmYzrFVW+nHIxxEM2gfEPeAtgZRXh51uJzj0D5Q8ZbfMIw/WuT7oLtHJ3Q/mEUyEWMzKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736762519; c=relaxed/simple;
	bh=Zp93LZDd3QBNagnk7+fNe7YH5wK1xnVe+yhnBD8GWC0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EdHehseUOTsFZZMbWscDFcrnvKaMNvcWAFFIECoruHpXmf4+KX9NXMi8uT68NrfLvlP374ite4D0h6uo8HDul1OxBUtveBELbuFNAKtmkjC64EfGsNbSLhnX26ISFvEDaZPeakJYFPbPbxVSNQx+rRkCO9nj6Z4vnuddMMxnADw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LnzJbHpB; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-436a39e4891so27902425e9.1;
        Mon, 13 Jan 2025 02:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736762515; x=1737367315; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJbq1I1DhSpllA/RgnpcOrFfx1FL9FGRnbSfUXCMFIA=;
        b=LnzJbHpBf7Ii7cZtQ5TToopg7CSF5+LxqJNzMJYSRipWOjiFXlbiqZkueYyjNbi1H1
         6Stak7wBFqBC9FWgRgY3d7Z0kFuR8FFBdBmTYZqXQ0RcA5FE4sba7X8rD8AsR4I60yGY
         XrMYp40/NN8N2I5wkfJ3XcQt2bNjAZHpY3hVyR6ufNdH1F5WKJD7qBVM2MhM3+diRXvS
         hZGEc9uBUxEpmTKnd+tib96EftHSuGFjjjfSDWux3YQjOlg5iG+JasHcX2snkXOG52TG
         F4DXUzcEoAowTCj6k6pQYZLHAVP8NeepY7H/CrhmwUaxZ9biMfFj5BihbQVH/r4Ejwbc
         G5/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736762515; x=1737367315;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AJbq1I1DhSpllA/RgnpcOrFfx1FL9FGRnbSfUXCMFIA=;
        b=oV+ZtT3B6PVCKMsNuqo4vtWgf3ssGZNO/W16KRbveMl0BVSB6xOG+3H1CiNMvQHinW
         r9DIQBFlp3YKe/7UY3O7azeXt4UL1Swjy/XoBIdHiOeUlBxUP+ptm11M48/7tIiR622I
         Ck+fPNbtHMe2amsAs2JwYGq8uPTl588+XbwsRVEd+rKrtGMM4zNSpp3sgBIsCxgYGhEw
         oDvOwLYMtxZqst69QbgEkUEiFUSABJUQwJ/jUUkzyPeVYX64HroiXRunhEpBId2OUbo0
         QRwnuObFYaaDpPrGhHb+dtW5s8jMX/iyzIcMRxwJ4tbueauQf/8TRIi8lgt6X3ETDYoO
         iZ/w==
X-Forwarded-Encrypted: i=1; AJvYcCVdntiVVEdF3v9/bwAuOu/xe9iC2O8PAB5SwMR9wo6G1xbYbZ0tL7mET9LKVQqFccnogAteY1cj0EUm@vger.kernel.org, AJvYcCWW5hZJ7FV1xomVI67OGv59yxBoFJO3uRrYVANBa9QDpAVaMoKLJyH6Wecg1uzep2kWUYXsiDzmvQHB+i+3@vger.kernel.org, AJvYcCWe2ZRxSCxF16ZsGDWUPbLqNjZw/4VOaXoLuDb9Lu8OPn/0saYjOZd1Ma7OIFDhnj0IXIHQjrOwNx+l@vger.kernel.org, AJvYcCXCmk2xgU7ZH4r++TVwhb8TXFzI0J0iFwOMa8847iImrwUCYs1YlNs/KX/1c+FFuoPNCpkzpAmBBWX7@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/FTen1j+6vV7QrVwWscNWsApvpICtnUU6FOuihDagFuEQxR7A
	YsKMqae/eKEMczWHXRRkJUCNlwAAkoBaoS3B5vQ2DjYtK369JiaL
X-Gm-Gg: ASbGncu0cAZQ3m5g4sUAD7+mBjWJyWt0jy07RXO06ctLcnx/JyMPtqbA/nUmdwbwkAb
	LkjWULR4OazESB30d3xErDNz1QV4FDRDU5meBq4QZg0sRvSo9KMbJGOYtJQE1oWsDT55jpAZ1NY
	ykCCZt3HBnnF+TMC+Ucw+xEeyQ23y78ymtJ4kZx0LG5HqQvRYB4JGk11feW2v1ZX3z+lqRp/m/G
	FFS6hsWKnh+sDMMlYC1w6PdOydm/Dv9wu5eZTPhdrcqr8d4VIegCsEfgp4q1jtiYlh3iGPFqRU3
	k9DWdpAMdPfJWui+bWBswBDGBaL5
X-Google-Smtp-Source: AGHT+IEM4+rm5ud9t+Currc7xiyBbGnkx6p0kXJc04KU79+mXiD7GMGEBm9lbv+kuvXUXN/rTwi6RA==
X-Received: by 2002:adf:b1d9:0:b0:386:32ca:9e22 with SMTP id ffacd0b85a97d-38a87308c2bmr14173012f8f.41.1736762515471;
        Mon, 13 Jan 2025 02:01:55 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4c1e0bsm11560658f8f.100.2025.01.13.02.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 02:01:55 -0800 (PST)
Message-ID: <876666dd6e63749aae7bd291bde2cd9724b9de00.camel@gmail.com>
Subject: Re: [PATCH v4 3/3] iio: frequency: adf4371: add ref doubler
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org, 
	robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org
Date: Mon, 13 Jan 2025 10:01:54 +0000
In-Reply-To: <20250109133707.3845-4-antoniu.miclaus@analog.com>
References: <20250109133707.3845-1-antoniu.miclaus@analog.com>
	 <20250109133707.3845-4-antoniu.miclaus@analog.com>
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
> Add support for the reference doubler.
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

LGTM:

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> no changes in v4.
> =C2=A0drivers/iio/frequency/adf4371.c | 16 ++++++++++++++--
> =C2=A01 file changed, 14 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/frequency/adf4371.c b/drivers/iio/frequency/adf4=
371.c
> index 50450e7b5464..a57fc24a6799 100644
> --- a/drivers/iio/frequency/adf4371.c
> +++ b/drivers/iio/frequency/adf4371.c
> @@ -44,6 +44,8 @@
> =C2=A0/* ADF4371_REG22 */
> =C2=A0#define ADF4371_REFIN_MODE_MASK		BIT(6)
> =C2=A0#define ADF4371_REFIN_MODE(x)		FIELD_PREP(ADF4371_REFIN_MODE_MASK,
> x)
> +#define ADF4371_REF_DOUB_MASK		BIT(5)
> +#define ADF4371_REF_DOUB(x)		FIELD_PREP(ADF4371_REF_DOUB_MASK, x)\
> =C2=A0
> =C2=A0/* ADF4371_REG24 */
> =C2=A0#define ADF4371_RF_DIV_SEL_MSK		GENMASK(6, 4)
> @@ -75,6 +77,9 @@
> =C2=A0#define ADF4371_MAX_FREQ_REFIN		600000000UL /* Hz */
> =C2=A0#define ADF4371_MAX_FREQ_REFIN_SE	500000000UL /* Hz */
> =C2=A0
> +#define ADF4371_MIN_CLKIN_DOUB_FREQ	10000000ULL /* Hz */
> +#define ADF4371_MAX_CLKIN_DOUB_FREQ	125000000ULL /* Hz */
> +
> =C2=A0/* MOD1 is a 24-bit primary modulus with fixed value of 2^25 */
> =C2=A0#define ADF4371_MODULUS1		33554432ULL
> =C2=A0/* MOD2 is the programmable, 14-bit auxiliary fractional modulus */
> @@ -481,7 +486,7 @@ static const struct iio_info adf4371_info =3D {
> =C2=A0static int adf4371_setup(struct adf4371_state *st)
> =C2=A0{
> =C2=A0	unsigned int synth_timeout =3D 2, timeout =3D 1, vco_alc_timeout =
=3D 1;
> -	unsigned int vco_band_div, tmp;
> +	unsigned int vco_band_div, tmp, ref_doubler_en =3D 0;
> =C2=A0	int ret;
> =C2=A0
> =C2=A0	/* Perform a software reset */
> @@ -514,8 +519,14 @@ static int adf4371_setup(struct adf4371_state *st)
> =C2=A0	=C2=A0=C2=A0=C2=A0 (!st->ref_diff_en && st->clkin_freq > ADF4371_M=
AX_FREQ_REFIN_SE))
> =C2=A0		return -EINVAL;
> =C2=A0
> +	if (st->clkin_freq < ADF4371_MAX_CLKIN_DOUB_FREQ &&
> +	=C2=A0=C2=A0=C2=A0 st->clkin_freq > ADF4371_MIN_CLKIN_DOUB_FREQ)
> +		ref_doubler_en =3D 1;
> +
> =C2=A0	ret =3D regmap_update_bits(st->regmap,=C2=A0 ADF4371_REG(0x22),
> +				 ADF4371_REF_DOUB_MASK |
> =C2=A0				 ADF4371_REFIN_MODE_MASK,
> +				 ADF4371_REF_DOUB(ref_doubler_en) |
> =C2=A0				 ADF4371_REFIN_MODE(st->ref_diff_en));
> =C2=A0	if (ret < 0)
> =C2=A0		return ret;
> @@ -529,7 +540,8 @@ static int adf4371_setup(struct adf4371_state *st)
> =C2=A0	 */
> =C2=A0	do {
> =C2=A0		st->ref_div_factor++;
> -		st->fpfd =3D st->clkin_freq / st->ref_div_factor;
> +		st->fpfd =3D st->clkin_freq * (1 + ref_doubler_en) /
> +			=C2=A0=C2=A0 st->ref_div_factor;
> =C2=A0	} while (st->fpfd > ADF4371_MAX_FREQ_PFD);
> =C2=A0
> =C2=A0	/* Calculate Timeouts */


