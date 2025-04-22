Return-Path: <linux-pwm+bounces-5640-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B776A95FF2
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Apr 2025 09:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 784AB17480F
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Apr 2025 07:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76AD1EEA23;
	Tue, 22 Apr 2025 07:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bS932h6c"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FB0F510;
	Tue, 22 Apr 2025 07:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745308309; cv=none; b=NY3AeLHVzm6sxJWRYPg9NnSwiz+1WeyFeTTAVPj3q6+HbOQII4R6vzSx5Fct/JxV2D98+h/ifXkg0Fog5HG10MabC7aVG6KQL382E/cQ8jVFEoM1+OqiZuBNBm0hPe/mhfaf+ZXAsCz9JStAiIgi/J6lv4Ls2meD0xKWWGbrG00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745308309; c=relaxed/simple;
	bh=p8A9SsWNSucJAOtTAIrSp7tfeVHaYLI65+WnFcceZ4c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f3b11/gSpvMAIBLJG1gIoeMfYkAyHsGWstctiBhSjh1xucWNrmfFdkl763eFyGPWUsmMFZW2eNfmZpcy2zcw1ZhYbTd1VGZfxlc1+X+Oi4xvYtzdE4/eU1sqEXlkpiKq0JEtSGZnTuMaTxwoAgaFhwwrtvA8Y3hbLKnPhi+0iEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bS932h6c; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cf034d4abso42191055e9.3;
        Tue, 22 Apr 2025 00:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745308306; x=1745913106; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6djv0hrSsmWY30Ufsh89++9FscAdxq7sBYpakrt2oOg=;
        b=bS932h6cCdesd5NXn+mNrfc++11gfbxhitrtmyOQ1XJpBKZ96sAb8K8GDSgGl6OQJa
         tJLymyxnSDCEAZk9uT16sIQZDiPab5VwzsCkvru1I+rKjY3o6k1kuXTbDDFz9BawlETT
         wYZHlPoJ1Z2jFoWJlKI7z5dZ6vO0C8u2bfRGwAC4xe8/HUH+Gx71CGHhNmbctB/lAIT4
         l5yAAzAEo86bolgmWKaklZq2xkfsYpQ/RpOUydgn6W0gjfLDfby1HZQ5f378uu/j2ZL2
         yjf5VnAN0CgvaTDUF4RHfjCq8tloTxqAhJ5fwQpQ03eI1HR4v0OH5+V5IdEPvs56g+8c
         7gJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745308306; x=1745913106;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6djv0hrSsmWY30Ufsh89++9FscAdxq7sBYpakrt2oOg=;
        b=OZ25Lujnfs9/i+D6lk+3GwUUTW5hJjY6YbsTAqIyABDx0aXL0MbT8RWTT2U+sPxWBU
         iol/B0lHI8tVHwDbI1lUDnv5AwG88+33QpPGbBVR6yTFHHfr2HwKMF5ugPA+ag8Fcxp9
         xQ6Vp/ONCUX8ivsuwMF6FRObfcv0Q2EPbr+48dxgxPxuI/AFr8FL7RuERRACVDncGb5C
         g0+mjENalERvZFlDtwM3Wjplx+zxkeZXBCM+xIw4Y1JjnWVLcngr7OBneZwpaJVP+A5C
         bqSFLjuWHMq3pURLpS100lDqB+XgF0srENWGIzlWwrClTfJe9CkfcMP8QYr9ZdpBCo7U
         g4ZA==
X-Forwarded-Encrypted: i=1; AJvYcCUgY0E1IP5q3opdC0QtLKjhLSzX0JA8fBoQ7nGQ2oRMjnI6CGRCdyjFOixK9kfx+Fhnw/LI2K7J3Cv9@vger.kernel.org, AJvYcCVFBRpmko+d8GdnZTDIGhrc7PGid7cfXg4GGhbnXVVC82oILs45A4AGTcJonf2yGRBaWoEqDy0aVkSyeg==@vger.kernel.org, AJvYcCWHrt826fnZF1MV9enFPzd0wdbbbk2DCB1RGPzi8aG87U587z43McLknxcOAmkZpOwL5crgz1U0ioIExl0=@vger.kernel.org, AJvYcCXqhBuMh2VImGXnC9SnhIG3QB9HzGvfxACQn4ceJ6isGT2znZK+hnU4V04MdKCuOJWgMll27JIf/ngA@vger.kernel.org
X-Gm-Message-State: AOJu0YxHYa/iBiGA+9JIPievGTFtD61/ILm0amCOZ/y1qOsZvMSTeRfi
	bIzuq3OuQ5HcWiuY6KZCUpXpSiht+5/xs6OvKP8DLhk6O6frbGTX
X-Gm-Gg: ASbGncuZqwsTdsBigU8KQgBGqmYAuoiIzP8L1IHTrMA61OkWyvuKEOHXWuDju22EZh4
	c9jGr7RgRrf/oPqCZ2RNNIjubGSO4mhfVI0aMCB0du+Tu6PRXrcsfkWwLi2VOVGMkKjfvtV4Vmo
	us1XcBAGTbj2N6lX61+F3/YtKoWGOJF8+lBCWlVEwBQemngYQQQNwjz/8XMupMhNfTHffH5v1a/
	cavpGv26zlx7dUrFnoHzF6ZJ9ODsyuDkCzi9D1jfeTAIu5R2tQrx3ToHyW1hm4QFeV1yQmVqQmP
	AKRobYP0/XSgj1VnzULALbJ2eIvm3kvGQiRJevQLabjEwlcdewWOOYqEH4QdsjB6KoXzIbsEHCT
	od9ktL4BEuzIw
X-Google-Smtp-Source: AGHT+IELxCrkEchhXI14TALXVQ/6X3nTA5CNhScrJT3DqohnqZeQJSB21S7jq2OX38IgV96EgyxzAQ==
X-Received: by 2002:a05:600c:3107:b0:43c:e7a7:aea0 with SMTP id 5b1f17b1804b1-4406ac1fa5emr114305745e9.26.1745308305570;
        Tue, 22 Apr 2025 00:51:45 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa4a4d67sm14449803f8f.94.2025.04.22.00.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 00:51:45 -0700 (PDT)
Message-ID: <3156ad917b95ea6e29be7151d841f0a63294f23b.camel@gmail.com>
Subject: Re: [PATCH v2 06/17] mfd: adp5585: add support for adp5589
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: nuno.sa@analog.com, linux-gpio@vger.kernel.org,
 linux-pwm@vger.kernel.org, 	devicetree@vger.kernel.org,
 linux-input@vger.kernel.org, Lee Jones <lee@kernel.org>,  Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,  Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=	
 <ukleinek@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Bartosz
 Golaszewski <brgl@bgdev.pl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Liu Ying <victor.liu@nxp.com>
Date: Tue, 22 Apr 2025 08:51:48 +0100
In-Reply-To: <20250421220617.GV17813@pendragon.ideasonboard.com>
References: <20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com>
	 <20250415-dev-adp5589-fw-v2-6-3a799c3ed812@analog.com>
	 <20250421091559.GE29968@pendragon.ideasonboard.com>
	 <36b161e08547dc2d5abd36340c596e2147d82ce7.camel@gmail.com>
	 <20250421220617.GV17813@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-04-22 at 01:06 +0300, Laurent Pinchart wrote:
> Hi Nuno,
>=20
> On Mon, Apr 21, 2025 at 01:21:08PM +0100, Nuno S=C3=A1 wrote:
> > On Mon, 2025-04-21 at 12:15 +0300, Laurent Pinchart wrote:
> > > On Tue, Apr 15, 2025 at 03:49:22PM +0100, Nuno S=C3=A1 via B4 Relay w=
rote:
> > > > From: Nuno S=C3=A1 <nuno.sa@analog.com>
> > > >=20
> > > > The ADP5589 is a 19 I/O port expander with built-in keypad matrix
> > > > decoder,
> > > > programmable logic, reset generator, and PWM generator.
> > > >=20
> > > > This patch adds the foundation to add support for the adp5589 gpio =
and
> > > > pwm
> > > > drivers. Most importantly, we need to differentiate between some
> > > > registers addresses. It also hints to future keymap support.
> > >=20
> > > Please split this in two patches, one that reworks the driver to supp=
ort
> > > different register addresses, and one that adds adp5589 support.
> > >=20
> > > > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > > > ---
> > > > =C2=A0drivers/mfd/adp5585.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2=
23
> > > > +++++++++++++++++++++++++++++++++++++++++---
> > > > =C2=A0include/linux/mfd/adp5585.h |=C2=A0 57 ++++++++++-
> > > > =C2=A02 files changed, 268 insertions(+), 12 deletions(-)
> > > >=20
> > > > diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
> > > > index
> > > > fafe3ad93ea196e1eb8e79fecba58f36f12167eb..c3586c0d6aa2e7e7d94667993=
41061
> > > > 0be7fc3672 100644
> > > > --- a/drivers/mfd/adp5585.c
> > > > +++ b/drivers/mfd/adp5585.c
> > > > @@ -25,6 +25,13 @@ static const struct mfd_cell adp5585_devs[] =3D =
{
> > > > =C2=A0
> > > > =C2=A0};
> > > > =C2=A0
> > > > +static const struct mfd_cell adp5589_devs[] =3D {
> > > > +	MFD_CELL_NAME("adp5589-keys"),
> > > > +	MFD_CELL_NAME("adp5589-gpio"),
> > > > +	MFD_CELL_NAME("adp5589-pwm"),
> > > > +
> > > > +};
> > > > +
> > > > =C2=A0static const struct regmap_range adp5585_volatile_ranges[] =
=3D {
> > > > =C2=A0	regmap_reg_range(ADP5585_ID, ADP5585_GPI_STATUS_B),
> > > > =C2=A0};
> > > > @@ -34,6 +41,15 @@ static const struct regmap_access_table
> > > > adp5585_volatile_regs =3D {
> > > > =C2=A0	.n_yes_ranges =3D ARRAY_SIZE(adp5585_volatile_ranges),
> > > > =C2=A0};
> > > > =C2=A0
> > > > +static const struct regmap_range adp5589_volatile_ranges[] =3D {
> > > > +	regmap_reg_range(ADP5585_ID, ADP5589_GPI_STATUS_C),
> > > > +};
> > > > +
> > > > +static const struct regmap_access_table adp5589_volatile_regs =3D =
{
> > > > +	.yes_ranges =3D adp5589_volatile_ranges,
> > > > +	.n_yes_ranges =3D ARRAY_SIZE(adp5589_volatile_ranges),
> > > > +};
> > > > +
> > > > =C2=A0/*
> > > > =C2=A0 * Chip variants differ in the default configuration of pull-=
up and
> > > > pull-down
> > > > =C2=A0 * resistors, and therefore have different default register v=
alues:
> > > > @@ -77,10 +93,52 @@ static const u8
> > > > adp5585_regmap_defaults_04[ADP5585_MAX_REG + 1] =3D {
> > > > =C2=A0	/* 0x38 */ 0x00, 0x00, 0x00, 0x00, 0x00,
> > > > =C2=A0};
> > > > =C2=A0
> > > > +static const u8 adp5589_regmap_defaults_00[ADP5589_MAX_REG + 1] =
=3D {
> > > > +	/* 0x00 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > > > +	/* 0x08 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > > > +	/* 0x10 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > > > +	/* 0x18 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > > > +	/* 0x20 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > > > +	/* 0x28 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > > > +	/* 0x30 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > > > +	/* 0x38 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > > > +	/* 0x40 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > > > +	/* 0x48 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > > > +};
> > > > +
> > > > +static const u8 adp5589_regmap_defaults_01[ADP5589_MAX_REG + 1] =
=3D {
> > > > +	/* 0x00 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > > > +	/* 0x08 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > > > +	/* 0x10 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > > > +	/* 0x18 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > > > +	/* 0x20 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > > > +	/* 0x28 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > > > +	/* 0x30 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > > > +	/* 0x38 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x20, 0x00, 0x00,
> > > > +	/* 0x40 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > > > +	/* 0x48 */ 0x00, 0x00, 0x00, 0x00, 0x20, 0x00, 0x00,
> > > > +};
> > > > +
> > > > +static const u8 adp5589_regmap_defaults_02[ADP5589_MAX_REG + 1] =
=3D {
> > > > +	/* 0x00 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > > > +	/* 0x08 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > > > +	/* 0x10 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > > > +	/* 0x18 */ 0x00, 0x41, 0x01, 0x00, 0x11, 0x04, 0x00, 0x00,
> > > > +	/* 0x20 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > > > +	/* 0x28 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > > > +	/* 0x30 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > > > +	/* 0x38 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > > > +	/* 0x40 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > > > +	/* 0x48 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > > > +};
> > > > +
> > > > =C2=A0enum adp5585_regmap_type {
> > > > =C2=A0	ADP5585_REGMAP_00,
> > > > =C2=A0	ADP5585_REGMAP_02,
> > > > =C2=A0	ADP5585_REGMAP_04,
> > > > +	ADP5589_REGMAP_00,
> > > > +	ADP5589_REGMAP_01,
> > > > +	ADP5589_REGMAP_02,
> > > > =C2=A0};
> > > > =C2=A0
> > > > =C2=A0static const struct regmap_config adp5585_regmap_configs[] =
=3D {
> > > > @@ -111,6 +169,131 @@ static const struct regmap_config
> > > > adp5585_regmap_configs[] =3D {
> > > > =C2=A0		.reg_defaults_raw =3D adp5585_regmap_defaults_04,
> > > > =C2=A0		.num_reg_defaults_raw =3D
> > > > sizeof(adp5585_regmap_defaults_04),
> > > > =C2=A0	},
> > > > +	[ADP5589_REGMAP_00] =3D {
> > > > +		.reg_bits =3D 8,
> > > > +		.val_bits =3D 8,
> > > > +		.max_register =3D ADP5589_MAX_REG,
> > > > +		.volatile_table =3D &adp5589_volatile_regs,
> > > > +		.cache_type =3D REGCACHE_MAPLE,
> > > > +		.reg_defaults_raw =3D adp5589_regmap_defaults_00,
> > > > +		.num_reg_defaults_raw =3D
> > > > sizeof(adp5589_regmap_defaults_00),
> > > > +	},
> > > > +	[ADP5589_REGMAP_01] =3D {
> > > > +		.reg_bits =3D 8,
> > > > +		.val_bits =3D 8,
> > > > +		.max_register =3D ADP5589_MAX_REG,
> > > > +		.volatile_table =3D &adp5589_volatile_regs,
> > > > +		.cache_type =3D REGCACHE_MAPLE,
> > > > +		.reg_defaults_raw =3D adp5589_regmap_defaults_01,
> > > > +		.num_reg_defaults_raw =3D
> > > > sizeof(adp5589_regmap_defaults_01),
> > > > +	},
> > > > +	[ADP5589_REGMAP_02] =3D {
> > > > +		.reg_bits =3D 8,
> > > > +		.val_bits =3D 8,
> > > > +		.max_register =3D ADP5589_MAX_REG,
> > > > +		.volatile_table =3D &adp5589_volatile_regs,
> > > > +		.cache_type =3D REGCACHE_MAPLE,
> > > > +		.reg_defaults_raw =3D adp5589_regmap_defaults_02,
> > > > +		.num_reg_defaults_raw =3D
> > > > sizeof(adp5589_regmap_defaults_02),
> > > > +	},
> > > > +};
> > > > +
> > > > +static const struct adp5585_regs adp5585_regs =3D {
> > > > +	.debounce_dis_a =3D ADP5585_DEBOUNCE_DIS_A,
> > > > +	.rpull_cfg_a =3D ADP5585_RPULL_CONFIG_A,
> > > > +	.gpo_data_a =3D ADP5585_GPO_DATA_OUT_A,
> > > > +	.gpo_out_a =3D ADP5585_GPO_OUT_MODE_A,
> > > > +	.gpio_dir_a =3D ADP5585_GPIO_DIRECTION_A,
> > > > +	.gpi_stat_a =3D ADP5585_GPI_STATUS_A,
> > > > +	.pwm_cfg =3D ADP5585_PWM_CFG,
> > > > +	.pwm_offt_low =3D ADP5585_PWM_OFFT_LOW,
> > > > +	.pwm_ont_low =3D ADP5585_PWM_ONT_LOW,
> > > > +	.gen_cfg =3D ADP5585_GENERAL_CFG,
> > > > +	.ext_cfg =3D ADP5585_PIN_CONFIG_C,
> > > > +};
> > >=20
> > > Why does this need to be stored in this driver, and not in the driver=
s
> > > for the gpio and pwm cells ? If the kernel is compiled without e.g. t=
he
> > > adp5585-pwm driver, we shouldn't waste memory here by adding data tha=
t
> > > only the adp5585-pwm driver needs.
> >=20
> > I don't really think the memory we would save to be that relevant but I=
 can
> > better separate things. I guess i went like this because there's some s=
hared
> > variables that will have to be in the top level structs and I did not w=
anted
> > to
> > have a "global" and "local" regs thingy...
>=20
> I understand, and I think it's at least partly a coding style
> preference. Personally, I find that having child-specific data in child
> drivers makes the code easier to read, as it increases locality.
> Otherwise, I have to look through multiple child drivers to see if and
> where each field is used.

No strong feelings on my side. So, I'll give this a shot in v3

>=20
> > > > +
> > > > +static const struct adp5585_regs adp5589_regs =3D {
> > > > +	.debounce_dis_a =3D ADP5589_DEBOUNCE_DIS_A,
> > > > +	.rpull_cfg_a =3D ADP5589_RPULL_CONFIG_A,
> > > > +	.gpo_data_a =3D ADP5589_GPO_DATA_OUT_A,
> > > > +	.gpo_out_a =3D ADP5589_GPO_OUT_MODE_A,
> > > > +	.gpio_dir_a =3D ADP5589_GPIO_DIRECTION_A,
> > > > +	.gpi_stat_a =3D ADP5589_GPI_STATUS_A,
> > > > +	.pwm_cfg =3D ADP5589_PWM_CFG,
> > > > +	.pwm_offt_low =3D ADP5589_PWM_OFFT_LOW,
> > > > +	.pwm_ont_low =3D ADP5589_PWM_ONT_LOW,
> > > > +	.gen_cfg =3D ADP5589_GENERAL_CFG,
> > > > +	.ext_cfg =3D ADP5589_PIN_CONFIG_D,
> > > > +};
> > > > +
> > > > +static const struct adp5585_info adp5585_info =3D {
> > > > +	.adp5585_devs =3D adp5585_devs,
> > > > +	.regmap_config =3D &adp5585_regmap_configs[ADP5585_REGMAP_00],
> > > > +	.n_devs =3D ARRAY_SIZE(adp5585_devs),
> > > > +	.id =3D ADP5585_MAN_ID_VALUE,
> > > > +	.regs =3D &adp5585_regs,
> > > > +	.max_rows =3D ADP5585_MAX_ROW_NUM,
> > > > +	.max_cols =3D ADP5585_MAX_COL_NUM,
> > >=20
> > > Same here, the max_rows and max_cols fields don't seem to belong to t=
his
> > > driver.
> > >=20
> > > > +};
> > > > +
> > > > +static const struct adp5585_info adp5585_01_info =3D {
> > > > +	.adp5585_devs =3D adp5585_devs,
> > > > +	.regmap_config =3D &adp5585_regmap_configs[ADP5585_REGMAP_00],
> > > > +	.n_devs =3D ARRAY_SIZE(adp5585_devs),
> > > > +	.id =3D ADP5585_MAN_ID_VALUE,
> > > > +	.regs =3D &adp5585_regs,
> > > > +	.max_rows =3D ADP5585_MAX_ROW_NUM,
> > > > +	.max_cols =3D ADP5585_MAX_COL_NUM,
> > > > +};
> > > > +
> > > > +static const struct adp5585_info adp5585_02_info =3D {
> > > > +	.adp5585_devs =3D adp5585_devs,
> > > > +	.regmap_config =3D &adp5585_regmap_configs[ADP5585_REGMAP_02],
> > > > +	.n_devs =3D ARRAY_SIZE(adp5585_devs),
> > > > +	.id =3D ADP5585_MAN_ID_VALUE,
> > > > +	.regs =3D &adp5585_regs,
> > > > +	.max_rows =3D ADP5585_MAX_ROW_NUM,
> > > > +	.max_cols =3D ADP5585_MAX_COL_NUM,
> > > > +};
> > > > +
> > > > +static const struct adp5585_info adp5585_04_info =3D {
> > > > +	.adp5585_devs =3D adp5585_devs,
> > > > +	.regmap_config =3D &adp5585_regmap_configs[ADP5585_REGMAP_04],
> > > > +	.n_devs =3D ARRAY_SIZE(adp5585_devs),
> > > > +	.id =3D ADP5585_MAN_ID_VALUE,
> > > > +	.regs =3D &adp5585_regs,
> > > > +	.max_rows =3D ADP5585_MAX_ROW_NUM,
> > > > +	.max_cols =3D ADP5585_MAX_COL_NUM,
> > > > +};
> > > > +
> > > > +static const struct adp5585_info adp5589_info =3D {
> > > > +	.adp5585_devs =3D adp5589_devs,
> > > > +	.regmap_config =3D &adp5585_regmap_configs[ADP5589_REGMAP_00],
> > > > +	.n_devs =3D ARRAY_SIZE(adp5589_devs),
> > > > +	.id =3D ADP5589_MAN_ID_VALUE,
> > > > +	.regs =3D &adp5589_regs,
> > > > +	.max_rows =3D ADP5589_MAX_ROW_NUM,
> > > > +	.max_cols =3D ADP5589_MAX_COL_NUM,
> > > > +};
> > > > +
> > > > +static const struct adp5585_info adp5589_01_info =3D {
> > > > +	.adp5585_devs =3D adp5589_devs,
> > > > +	.regmap_config =3D &adp5585_regmap_configs[ADP5589_REGMAP_01],
> > > > +	.n_devs =3D ARRAY_SIZE(adp5589_devs),
> > > > +	.id =3D ADP5589_MAN_ID_VALUE,
> > > > +	.regs =3D &adp5589_regs,
> > > > +	.max_rows =3D ADP5589_MAX_ROW_NUM,
> > > > +	.max_cols =3D ADP5589_MAX_COL_NUM,
> > > > +};
> > > > +
> > > > +static const struct adp5585_info adp5589_02_info =3D {
> > > > +	.adp5585_devs =3D adp5589_devs,
> > > > +	.regmap_config =3D &adp5585_regmap_configs[ADP5589_REGMAP_02],
> > > > +	.n_devs =3D ARRAY_SIZE(adp5589_devs),
> > > > +	.id =3D ADP5589_MAN_ID_VALUE,
> > > > +	.regs =3D &adp5589_regs,
> > > > +	.max_rows =3D ADP5589_MAX_ROW_NUM,
> > > > +	.max_cols =3D ADP5589_MAX_COL_NUM,
> > > > =C2=A0};
> > > > =C2=A0
> > > > =C2=A0static void adp5585_osc_disable(void *data)
> > > > @@ -122,7 +305,7 @@ static void adp5585_osc_disable(void *data)
> > > > =C2=A0
> > > > =C2=A0static int adp5585_i2c_probe(struct i2c_client *i2c)
> > > > =C2=A0{
> > > > -	const struct regmap_config *regmap_config;
> > > > +	const struct adp5585_info *info;
> > > > =C2=A0	struct adp5585_dev *adp5585;
> > > > =C2=A0	unsigned int id;
> > > > =C2=A0	int ret;
> > > > @@ -133,8 +316,13 @@ static int adp5585_i2c_probe(struct i2c_client
> > > > *i2c)
> > > > =C2=A0
> > > > =C2=A0	i2c_set_clientdata(i2c, adp5585);
> > > > =C2=A0
> > > > -	regmap_config =3D i2c_get_match_data(i2c);
> > > > -	adp5585->regmap =3D devm_regmap_init_i2c(i2c, regmap_config);
> > > > +	info =3D i2c_get_match_data(i2c);
> > > > +	if (!info)
> > > > +		return -ENODEV;
> > >=20
> > > Can this happen ?
> > >=20
> > > > +
> > > > +	adp5585->info =3D info;
> > >=20
> > > Drop the local info variable and assign the value to adp5585->info
> > > directly.
> > >=20
> > > > +
> > > > +	adp5585->regmap =3D devm_regmap_init_i2c(i2c, info-
> > > > >regmap_config);
> > > > =C2=A0	if (IS_ERR(adp5585->regmap))
> > > > =C2=A0		return dev_err_probe(&i2c->dev, PTR_ERR(adp5585-
> > > > >regmap),
> > > > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to initialize register
> > > > map\n");
> > > > @@ -144,7 +332,8 @@ static int adp5585_i2c_probe(struct i2c_client =
*i2c)
> > > > =C2=A0		return dev_err_probe(&i2c->dev, ret,
> > > > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to read device ID\n");
> > > > =C2=A0
> > > > -	if ((id & ADP5585_MAN_ID_MASK) !=3D ADP5585_MAN_ID_VALUE)
> > > > +	id &=3D ADP5585_MAN_ID_MASK;
> > > > +	if (id !=3D adp5585->info->id)
> > > > =C2=A0		return dev_err_probe(&i2c->dev, -ENODEV,
> > > > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid device ID 0x%02x\n", id=
);
> > > > =C2=A0
> > > > @@ -158,8 +347,8 @@ static int adp5585_i2c_probe(struct i2c_client =
*i2c)
> > > > =C2=A0		return ret;
> > > > =C2=A0
> > > > =C2=A0	ret =3D devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_AUTO,
> > > > -				=C2=A0=C2=A0 adp5585_devs,
> > > > ARRAY_SIZE(adp5585_devs),
> > > > -				=C2=A0=C2=A0 NULL, 0, NULL);
> > > > +				=C2=A0=C2=A0 adp5585->info->adp5585_devs,
> > > > +				=C2=A0=C2=A0 adp5585->info->n_devs, NULL, 0,
> > > > NULL);
> > > > =C2=A0	if (ret)
> > > > =C2=A0		return dev_err_probe(&i2c->dev, ret,
> > > > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to add child devices\n")=
;
> > > > @@ -191,19 +380,31 @@ static DEFINE_SIMPLE_DEV_PM_OPS(adp5585_pm,
> > > > adp5585_suspend, adp5585_resume);
> > > > =C2=A0static const struct of_device_id adp5585_of_match[] =3D {
> > > > =C2=A0	{
> > > > =C2=A0		.compatible =3D "adi,adp5585-00",
> > > > -		.data =3D &adp5585_regmap_configs[ADP5585_REGMAP_00],
> > > > +		.data =3D &adp5585_info,
> > > > =C2=A0	}, {
> > > > =C2=A0		.compatible =3D "adi,adp5585-01",
> > > > -		.data =3D &adp5585_regmap_configs[ADP5585_REGMAP_00],
> > > > +		.data =3D &adp5585_01_info,
> > > > =C2=A0	}, {
> > > > =C2=A0		.compatible =3D "adi,adp5585-02",
> > > > -		.data =3D &adp5585_regmap_configs[ADP5585_REGMAP_02],
> > > > +		.data =3D &adp5585_02_info,
> > > > =C2=A0	}, {
> > > > =C2=A0		.compatible =3D "adi,adp5585-03",
> > > > -		.data =3D &adp5585_regmap_configs[ADP5585_REGMAP_00],
> > > > +		.data =3D &adp5585_info,
> > > > =C2=A0	}, {
> > > > =C2=A0		.compatible =3D "adi,adp5585-04",
> > > > -		.data =3D &adp5585_regmap_configs[ADP5585_REGMAP_04],
> > > > +		.data =3D &adp5585_04_info,
> > > > +	}, {
> > > > +		.compatible =3D "adi,adp5589-00",
> > > > +		.data =3D &adp5589_info,
> > > > +	}, {
> > > > +		.compatible =3D "adi,adp5589-01",
> > > > +		.data =3D &adp5589_01_info,
> > > > +	}, {
> > > > +		.compatible =3D "adi,adp5589-02",
> > > > +		.data =3D &adp5589_02_info,
> > > > +	}, {
> > > > +		.compatible =3D "adi,adp5589",
> > > > +		.data =3D &adp5589_info,
> > > > =C2=A0	},
> > > > =C2=A0	{ /* sentinel */ }
> > > > =C2=A0};
> > > > diff --git a/include/linux/mfd/adp5585.h b/include/linux/mfd/adp558=
5.h
> > > > index
> > > > 016033cd68e46757aca86d21dd37025fd354b801..dffe1449de01dacf8fe78cf0e=
87d1f
> > > > 176d
> > > > 11f620 100644
> > > > --- a/include/linux/mfd/adp5585.h
> > > > +++ b/include/linux/mfd/adp5585.h
> > > > @@ -104,9 +104,11 @@
> > > > =C2=A0#define		ADP5585_INT_CFG			BIT(1)
> > > > =C2=A0#define		ADP5585_RST_CFG			BIT(0)
> > > > =C2=A0#define ADP5585_INT_EN			0x3c
> > > > -
> > > > =C2=A0#define ADP5585_MAX_REG			ADP5585_INT_EN
> > > > =C2=A0
> > > > +#define ADP5585_MAX_ROW_NUM		6
> > > > +#define ADP5585_MAX_COL_NUM		5
> > > > +
> > > > =C2=A0/*
> > > > =C2=A0 * Bank 0 covers pins "GPIO 1/R0" to "GPIO 6/R5", numbered 0 =
to 5 by
> > > > the
> > > > =C2=A0 * driver, and bank 1 covers pins "GPIO 7/C0" to "GPIO 11/C4"=
, numbered
> > > > 6
> > > > to
> > > > @@ -117,10 +119,63 @@
> > > > =C2=A0#define ADP5585_BANK(n)			((n) >=3D 6 ? 1 : 0)
> > > > =C2=A0#define ADP5585_BIT(n)			((n) >=3D 6 ? BIT((n) - 6) :
> > > > BIT(n))
> > > > =C2=A0
> > > > +/* ADP5589 */
> > > > +#define		ADP5589_MAN_ID_VALUE		0x10
> > > > +#define ADP5589_GPI_STATUS_A		0x16
> > > > +#define ADP5589_GPI_STATUS_C		0x18
> > > > +#define ADP5589_RPULL_CONFIG_A		0x19
> > > > +#define ADP5589_DEBOUNCE_DIS_A		0x27
> > > > +#define ADP5589_GPO_DATA_OUT_A		0x2a
> > > > +#define ADP5589_GPO_OUT_MODE_A		0x2d
> > > > +#define	ADP5589_GPIO_DIRECTION_A	0x30
> > >=20
> > > Indentation looks wrong.
> > >=20
> > > > +#define ADP5589_PWM_OFFT_LOW		0x3e
> > > > +#define ADP5589_PWM_ONT_LOW		0x40
> > > > +#define ADP5589_PWM_CFG			0x42
> > > > +#define ADP5589_PIN_CONFIG_D		0x4C
> > > > +#define ADP5589_GENERAL_CFG		0x4d
> > > > +#define ADP5589_INT_EN			0x4e
> > > > +#define ADP5589_MAX_REG			ADP5589_INT_EN
> > > > +
> > > > +#define ADP5589_MAX_ROW_NUM		8
> > > > +#define ADP5589_MAX_COL_NUM		11
> > > > +
> > > > +/*
> > > > + * Bank 0 covers pins "GPIO 1/R0" to "GPIO 8/R7", numbered 0 to 7 =
by
> > > > the
> > > > + * driver, bank 1 covers pins "GPIO 9/C0" to "GPIO 16/C7", numbere=
d 8
> > > > to
> > > > + * 15 and bank 3 covers pins "GPIO 17/C8" to "GPIO 19/C10", number=
ed 16
> > > > to
> > > > 18.
> > > > + */
> > > > +#define ADP5589_BANK(n)			((n) >> 3)
> > > > +#define ADP5589_BIT(n)			BIT((n) & 0x7)
> > > > +
> > > > +struct adp5585_regs {
> > > > +	unsigned int debounce_dis_a;
> > > > +	unsigned int rpull_cfg_a;
> > > > +	unsigned int gpo_data_a;
> > > > +	unsigned int gpo_out_a;
> > > > +	unsigned int gpio_dir_a;
> > > > +	unsigned int gpi_stat_a;
> > > > +	unsigned int pwm_cfg;
> > > > +	unsigned int pwm_offt_low;
> > > > +	unsigned int pwm_ont_low;
> > > > +	unsigned int gen_cfg;
> > > > +	unsigned int ext_cfg;
> > > > +};
> > > > +
> > > > +struct adp5585_info {
> > > > +	const struct mfd_cell *adp5585_devs;
> > > > +	const struct regmap_config *regmap_config;
> > > > +	const struct adp5585_regs *regs;
> > > > +	unsigned int n_devs;
> > > > +	unsigned int id;
> > > > +	u8 max_rows;
> > > > +	u8 max_cols;
> > > > +};
> > > > +
> > > > =C2=A0struct regmap;
> > > > =C2=A0
> > > > =C2=A0struct adp5585_dev {
> > > > =C2=A0	struct regmap *regmap;
> > > > +	const struct adp5585_info *info;
> > > > =C2=A0};
> > > > =C2=A0
> > > > =C2=A0#endif

