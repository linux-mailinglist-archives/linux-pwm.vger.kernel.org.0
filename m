Return-Path: <linux-pwm+bounces-6145-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 249C9AC4C06
	for <lists+linux-pwm@lfdr.de>; Tue, 27 May 2025 12:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4CD717C0A9
	for <lists+linux-pwm@lfdr.de>; Tue, 27 May 2025 10:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9EE0253F2D;
	Tue, 27 May 2025 10:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fv30QztK"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B286B2110E;
	Tue, 27 May 2025 10:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748340540; cv=none; b=OL3NRerj+C3lXDIyGpecg8MaWFXkd2L856jA0VUiu6K+yLOTWWjxz/4PfowmJCKJxzLzVF4IstTWiUTsovO4c73wwHdAHl0RhhqUx33WzvKjy2WiNchMfS1ffgM6CXXcW7eQP0BXRX3qzKStDiRK/yYpF845peMsNx2JiSZcS74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748340540; c=relaxed/simple;
	bh=RUaIfTju6q4KJc5UsfnxPADcffSmo0OlVbZ8SY8Mnro=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bakpuQvhMkitRkXNyKge+ILggc6R6hhtxTt71LhVCO75NKGYm4ud+N+N18LAjpak2e1WazxgigGu3EnwhG4/2omg/GBn/osD5egwKIclkbhn1mllcvc0SROmmyJhp9DqlaonYWu8+5HrG7ImIs+N5yQsDPf6FEjcS/LOfc26mg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fv30QztK; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-441c99459e9so19681265e9.3;
        Tue, 27 May 2025 03:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748340537; x=1748945337; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ILodCWyZ8sVROYb0hQ6K3xo+lZX+dJNU60OVJehOf64=;
        b=Fv30QztKa2+u26CycMawqP0p1LIUHN/dFl1tdwBATIHpxZsBcAVUaSea+sPzX+98Br
         tXJcuSNNOcCn7f1Xm8KuK59Iy1hE6GETOQ8KbpZ8wlOl3tt5s9NING7z8ZwJj0FFAQT/
         SLVIdc0cqLP37nDhXoPRDmEexwQDCezV84X2+BskP5Ix/Htd8cbvstAKGR1JnFR0OT1U
         JntkU//jn28X3dF5za1cnhP2X2LRac/qzt1sAoxmmQ8oguI9EOASEnwfQ/oS7kkgw6mW
         lWs1slcVcnF7JbiiFZSBhzJhKlMJ/Baom+Fj9PSySc6kNBUX9hK2/Fri53xEufHACZyK
         pfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748340537; x=1748945337;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ILodCWyZ8sVROYb0hQ6K3xo+lZX+dJNU60OVJehOf64=;
        b=EObxkdAN73RTVpq2+bARTezyMswAeNcrHcKYmdIgDgwdj10jgXSrPz66MRyOFYcwEm
         7vudD8N7jBtNpV/LOJM5uwqu5/guGFfRkSdXaih6z2SZDEmoFaCqcjFElFuv/nXmcDO7
         XcBkxiBsCHeNbRSLnM9xx7AU2UFbFwWqFsAId1nOhvpwgnhkUsfUwsp/b3JKlD597Soc
         dy9RtZcLNhx5HAJdUJ1fS35Lj43+Q+qc4kYH56n3SaYK5dK2CFEINj2U2WiKGfh9FLY3
         3dZtHi5WgbJaTwAOUmiDZdfUk/CBF6hYqT95gqWQn4QKvit+4KGAxJUPfpEE4LlkM0va
         OyHw==
X-Forwarded-Encrypted: i=1; AJvYcCVc1w99RvLeL8+Fb+0RIKDHvSlzXxK/fTM0z6S8e9h8EB1ZlmJUIgA9YenC47JElux2fD9RglX6QVMP@vger.kernel.org, AJvYcCW018Sai0X3ItXzuHSjEBexD5TAsKH7UcvqGR1iplNTU4lECZ76JAmBYWn3FwCxlKIYjBJOfyy36Zjtw2I=@vger.kernel.org, AJvYcCWzT+faYN+QC2iEpKW2lFTZAhUM+XbSw04+AO0O9qeFY7D0v48vVbumukJp2EsDgeLJalszvERiZ4TQ@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj0g8oZATjGnjLDwHwwIqTVrzjfo/fGJguIu0OH/iZhlWl45Ap
	eAK98r9kuzqcgHyqdvoH6B8ngz9aUVX8rY9vFeNNtp7cJjdiZpU1ZBl6
X-Gm-Gg: ASbGnctNvPejRHGaAjk9dz+KuoNkSdRUUJBdB/BKUTYWYcxgHaafUeGYFQassddaeAA
	+ri35sS5gTuAgFrwYyUq4hUDzqU3vhI2d6OiWi2Oyyob1sL5YcTI5YK3oSSsqXDulHsfQ9HTQ7t
	yj+6UDo+PJl1cPmcTjvFuz/rKndaoBmXfNCUkrtoCo9qmtDaG511lyyaDT1Ep/CN4hImmqkbdv4
	Z8jYQh0XURoJxaPMZYuEygTIAv3NJqPKa2aGI5XFc/wqakHXiHgQbISy0/luF5j1UPW9kyUEp8n
	/XhG5Hn8dggBj/6Mqj6UIEOPBJ/gf5oMHLX8FjRs71X2ctESa2maRjavX+yvUupjYJtAcA==
X-Google-Smtp-Source: AGHT+IFQNfqcH49B7+ZJZpALbPhHFs2CU7qSI/6ot0EmNd2l5ulmPpgQmrxVmMioW1PHPMelJNZbuA==
X-Received: by 2002:a05:600c:4fc9:b0:43c:ec4c:25b4 with SMTP id 5b1f17b1804b1-44c91ad70d0mr142754285e9.10.1748340536572;
        Tue, 27 May 2025 03:08:56 -0700 (PDT)
Received: from [100.73.1.233] ([195.158.248.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-44fcced3cb5sm19168305e9.1.2025.05.27.03.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 03:08:55 -0700 (PDT)
Message-ID: <a94be0ebad027a58a9665253e0d94ff014691cd2.camel@gmail.com>
Subject: Re: [PATCH v4 06/20] mfd: adp5585: refactor how regmap defaults are
 handled
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Lee Jones <lee@kernel.org>, nuno.sa@analog.com
Cc: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, Rob Herring	
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
 <ukleinek@kernel.org>,  Linus Walleij <linus.walleij@linaro.org>, Bartosz
 Golaszewski <brgl@bgdev.pl>, Dmitry Torokhov	 <dmitry.torokhov@gmail.com>,
 Laurent Pinchart	 <laurent.pinchart@ideasonboard.com>, Liu Ying
 <victor.liu@nxp.com>
Date: Tue, 27 May 2025 11:08:59 +0100
In-Reply-To: <20250523150338.GH1378991@google.com>
References: <20250521-dev-adp5589-fw-v4-0-f2c988d7a7a0@analog.com>
	 <20250521-dev-adp5589-fw-v4-6-f2c988d7a7a0@analog.com>
	 <20250523150338.GH1378991@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-05-23 at 16:03 +0100, Lee Jones wrote:
> On Wed, 21 May 2025, Nuno S=C3=A1 via B4 Relay wrote:
>=20
> > From: Nuno S=C3=A1 <nuno.sa@analog.com>
> >=20
> > The only thing changing between variants is the regmap default
> > registers. Hence, instead of having a regmap condig for every variant
>=20
> Spellcheck.
>=20
> > (duplicating lots of fields), add a chip info type of structure with a
> > regmap id to identify which defaults to use and populate regmap_config
>=20
> "ID"
>=20
> > at runtime given a template plus the id. Also note that between
> > variants, the defaults can be the same which means the chip info
> > structure can be used in more than one compatible.
> >=20
> > This will also make it simpler adding new chips with more variants.
> >=20
> > Also note that the chip info structures are deliberately not const as
> > they will also contain lots of members that are the same between the
> > different devices variants and so we will fill those at runtime.
> >=20
> > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > ---
> > =C2=A0drivers/mfd/adp5585.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 74 ++=
+++++++++++++++++++---------------------
> > ---
> > =C2=A0include/linux/mfd/adp5585.h | 10 ++++++
> > =C2=A02 files changed, 44 insertions(+), 40 deletions(-)
> >=20
> > diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
> > index
> > 179dc284833ae8f39eefc6787dd2c7158dfd3ad7..672f3468bda5be6af85a5982c3626=
053b4
> > cb59bf 100644
> > --- a/drivers/mfd/adp5585.c
> > +++ b/drivers/mfd/adp5585.c
> > @@ -81,42 +81,31 @@ static const u8
> > adp5585_regmap_defaults_04[ADP5585_MAX_REG + 1] =3D {
> > =C2=A0	/* 0x38 */ 0x00, 0x00, 0x00, 0x00, 0x00,
> > =C2=A0};
> > =C2=A0
> > -enum adp5585_regmap_type {
> > -	ADP5585_REGMAP_00,
> > -	ADP5585_REGMAP_02,
> > -	ADP5585_REGMAP_04,
> > +/* -1 since the enum starts at 1 for error checking in
> > i2c_get_match_data()*/
>=20
> Space before the '*'.
>=20
> > +static const u8 *adp5585_regmap_defaults[ADP5585_MAX - 1] =3D {
> > +	[ADP5585_00 - 1] =3D adp5585_regmap_defaults_00,
> > +	[ADP5585_01 - 1] =3D adp5585_regmap_defaults_00,
> > +	[ADP5585_02 - 1] =3D adp5585_regmap_defaults_02,
> > +	[ADP5585_03 - 1] =3D adp5585_regmap_defaults_00,
> > +	[ADP5585_04 - 1] =3D adp5585_regmap_defaults_04,
>=20
> Just leave the first entry blank.=C2=A0 No need for all he gymnastics.

alright

>=20
> > =C2=A0};
> > =C2=A0
> > -static const struct regmap_config adp5585_regmap_configs[] =3D {
> > -	[ADP5585_REGMAP_00] =3D {
> > -		.reg_bits =3D 8,
> > -		.val_bits =3D 8,
> > -		.max_register =3D ADP5585_MAX_REG,
> > -		.volatile_table =3D &adp5585_volatile_regs,
> > -		.cache_type =3D REGCACHE_MAPLE,
> > -		.reg_defaults_raw =3D adp5585_regmap_defaults_00,
> > -		.num_reg_defaults_raw =3D sizeof(adp5585_regmap_defaults_00),
> > -	},
> > -	[ADP5585_REGMAP_02] =3D {
> > -		.reg_bits =3D 8,
> > -		.val_bits =3D 8,
> > -		.max_register =3D ADP5585_MAX_REG,
> > -		.volatile_table =3D &adp5585_volatile_regs,
> > -		.cache_type =3D REGCACHE_MAPLE,
> > -		.reg_defaults_raw =3D adp5585_regmap_defaults_02,
> > -		.num_reg_defaults_raw =3D sizeof(adp5585_regmap_defaults_02),
> > -	},
> > -	[ADP5585_REGMAP_04] =3D {
> > -		.reg_bits =3D 8,
> > -		.val_bits =3D 8,
> > -		.max_register =3D ADP5585_MAX_REG,
> > -		.volatile_table =3D &adp5585_volatile_regs,
> > -		.cache_type =3D REGCACHE_MAPLE,
> > -		.reg_defaults_raw =3D adp5585_regmap_defaults_04,
> > -		.num_reg_defaults_raw =3D sizeof(adp5585_regmap_defaults_04),
> > -	},
> > +static const struct regmap_config adp5585_regmap_config_template =3D {
> > +	.reg_bits =3D 8,
> > +	.val_bits =3D 8,
> > +	.max_register =3D ADP5585_MAX_REG,
> > +	.volatile_table =3D &adp5585_volatile_regs,
> > +	.cache_type =3D REGCACHE_MAPLE,
> > +	.num_reg_defaults_raw =3D ADP5585_MAX_REG + 1,
> > =C2=A0};
> > =C2=A0
> > +static void adp5585_fill_regmap_config(const struct adp5585_dev *adp55=
85,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct regmap_config *regmap_=
config)
> > +{
> > +	*regmap_config =3D adp5585_regmap_config_template;
>=20
> Return struct regmap_config * instead.
>=20
> > +	regmap_config->reg_defaults_raw =3D adp5585_regmap_defaults[adp5585-
> > >variant - 1];
>=20
> Does this really warrant a separate function?

In this particular patch, not really. But since I know how things will evol=
ve :)

- Nuno S=C3=A1

>=20
> > +}
> > +
> > =C2=A0static void adp5585_remove_devices(void *dev)
> > =C2=A0{
> > =C2=A0	mfd_remove_devices(dev);
> > @@ -157,7 +146,7 @@ static void adp5585_osc_disable(void *data)
> > =C2=A0
> > =C2=A0static int adp5585_i2c_probe(struct i2c_client *i2c)
> > =C2=A0{
> > -	const struct regmap_config *regmap_config;
> > +	struct regmap_config regmap_config;
> > =C2=A0	struct adp5585_dev *adp5585;
> > =C2=A0	unsigned int id;
> > =C2=A0	int ret;
> > @@ -168,8 +157,13 @@ static int adp5585_i2c_probe(struct i2c_client *i2=
c)
> > =C2=A0
> > =C2=A0	i2c_set_clientdata(i2c, adp5585);
> > =C2=A0
> > -	regmap_config =3D i2c_get_match_data(i2c);
> > -	adp5585->regmap =3D devm_regmap_init_i2c(i2c, regmap_config);
> > +	adp5585->variant =3D (enum
> > adp5585_variant)(uintptr_t)i2c_get_match_data(i2c);
> > +	if (!adp5585->variant)
> > +		return -ENODEV;
> > +
> > +	adp5585_fill_regmap_config(adp5585, &regmap_config);
> > +
> > +	adp5585->regmap =3D devm_regmap_init_i2c(i2c, &regmap_config);
> > =C2=A0	if (IS_ERR(adp5585->regmap))
> > =C2=A0		return dev_err_probe(&i2c->dev, PTR_ERR(adp5585->regmap),
> > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to initialize register
> > map\n");
> > @@ -226,19 +220,19 @@ static DEFINE_SIMPLE_DEV_PM_OPS(adp5585_pm,
> > adp5585_suspend, adp5585_resume);
> > =C2=A0static const struct of_device_id adp5585_of_match[] =3D {
> > =C2=A0	{
> > =C2=A0		.compatible =3D "adi,adp5585-00",
> > -		.data =3D &adp5585_regmap_configs[ADP5585_REGMAP_00],
> > +		.data =3D (void *)ADP5585_00,
> > =C2=A0	}, {
> > =C2=A0		.compatible =3D "adi,adp5585-01",
> > -		.data =3D &adp5585_regmap_configs[ADP5585_REGMAP_00],
> > +		.data =3D (void *)ADP5585_01,
> > =C2=A0	}, {
> > =C2=A0		.compatible =3D "adi,adp5585-02",
> > -		.data =3D &adp5585_regmap_configs[ADP5585_REGMAP_02],
> > +		.data =3D (void *)ADP5585_02,
> > =C2=A0	}, {
> > =C2=A0		.compatible =3D "adi,adp5585-03",
> > -		.data =3D &adp5585_regmap_configs[ADP5585_REGMAP_00],
> > +		.data =3D (void *)ADP5585_03,
> > =C2=A0	}, {
> > =C2=A0		.compatible =3D "adi,adp5585-04",
> > -		.data =3D &adp5585_regmap_configs[ADP5585_REGMAP_04],
> > +		.data =3D (void *)ADP5585_04,
> > =C2=A0	},
> > =C2=A0	{ /* sentinel */ }
> > =C2=A0};
> > diff --git a/include/linux/mfd/adp5585.h b/include/linux/mfd/adp5585.h
> > index
> > 016033cd68e46757aca86d21dd37025fd354b801..2813b20e638b6e73ef198e43af07e=
f29ff
> > 25f273 100644
> > --- a/include/linux/mfd/adp5585.h
> > +++ b/include/linux/mfd/adp5585.h
> > @@ -119,8 +119,18 @@
> > =C2=A0
> > =C2=A0struct regmap;
> > =C2=A0
> > +enum adp5585_variant {
> > +	ADP5585_00 =3D 1,
> > +	ADP5585_01,
> > +	ADP5585_02,
> > +	ADP5585_03,
> > +	ADP5585_04,
> > +	ADP5585_MAX
> > +};
> > +
> > =C2=A0struct adp5585_dev {
> > =C2=A0	struct regmap *regmap;
> > +	enum adp5585_variant variant;
> > =C2=A0};
> > =C2=A0
> > =C2=A0#endif
> >=20
> > --=20
> > 2.49.0
> >=20
> >=20

