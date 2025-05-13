Return-Path: <linux-pwm+bounces-5964-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B93CAAB58EC
	for <lists+linux-pwm@lfdr.de>; Tue, 13 May 2025 17:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F926189F1C0
	for <lists+linux-pwm@lfdr.de>; Tue, 13 May 2025 15:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF70924728C;
	Tue, 13 May 2025 15:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eP39cxln"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51E620CCD9;
	Tue, 13 May 2025 15:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747150921; cv=none; b=BycQ8s9qB7Xtd6PENYkwBBaaucWqUIggjyh5KSmDdGyEHd1meFKP2ZJayMxQ8gyQ0kI4DT2MOJ7MgtU9RkMt0AVMsKT3l0e5r/s3Z+Us+AVRHY8hnOHsQyPOEPA971RfrJMkdsLTSar80RmlQ58+/swYdgJDYMAEZg5GCzzOJIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747150921; c=relaxed/simple;
	bh=PigISdD5Y/B0BIhEzNbpxoloLzMAWxzilx8kJW7ZlIg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QdLZZJJmLWb691IUkesuYiPR1z+4pQzBnzHCWAoDSYV78nIUb/Zvbw55SwCHRcrPkz+Gc5fSPDrh+i8GzifL45AP9Yff5BSUbDdvj9fc10sg+tmgrGRcIiKIDCMkrxUBoVPrJ3vNnrQ0Oq+eAVjoKUxoeliu6+mMJRo1MRpaJBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eP39cxln; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-441c99459e9so39116035e9.3;
        Tue, 13 May 2025 08:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747150918; x=1747755718; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bWbr+QP1Fv65TfEs8w3ILaV2H8Bbc/aaV3wOxSfyCIY=;
        b=eP39cxlnVmg1hMTL4HAL7NH3DBzBtAPlYK6Tak/qiVmGIkfhOW0Fl6QpF9t3651pLs
         SF1B2g+z6SbJ74fJppEQjcFG9Mb3Lg7gfUxeHULAo5CimtrVBwEm5MIT5anLeT5FTfAe
         dYM8FY3fgHxdqh+ROLt3v+epgCHcBESE/gDUT330SvnRi10e9GD+KkxD1Bh5izE6eq9s
         +BcLhFkMGm5xCMAlbwd+DsoSpmbtZ1CarZHMTHMPZ3k7r0JAh3hLUVBvgwtf2btwfrCV
         E8Tfgb5xL3OqTFh39APac+9TmgnLUk/0hQ+Z0yfsnBV5WVUl/fShw7PTaj3o6Gqkr2ol
         Y1iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747150918; x=1747755718;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bWbr+QP1Fv65TfEs8w3ILaV2H8Bbc/aaV3wOxSfyCIY=;
        b=CmNRJstmAZmOQ9NcKRZ5h4rxG5I0/J5BH/KSERvM+GNReP1xcdIzpbLmGoCBGFi9Rf
         aNugp3BrFCr5I47xp5TLf8rPOyr5T9SYoAt4umo4oSOFV3KEJWD3n2VL4u8Z0nBp+Own
         VZZjCpVWGDPLEFvTAtSmerEkGx+Jz7uG0ij8mtJqHlPyYU+R1vcch18Gc0Hn3J98YAEY
         gZAcjaunp7R8unXi0OZtqt4vK0U+l3K1u+egu73A/9m+pR+1CRoIFCc151IM6prLKyqY
         uC41vqosYHhAby/QmCZKsf4ZcamEFSh0NppnfBajPrT2wxyclKbLzDot7z+jUe5USdeY
         mm4w==
X-Forwarded-Encrypted: i=1; AJvYcCUpQMSaufr+nJYyDYYfXOv2nV1dsanygxcPAntRzSbqBrF3ct8DRu4lEfn+0J98qANthZwd04v6QhagCQ==@vger.kernel.org, AJvYcCV+yCvvQWrQzAei5qKvWhhNlZO2qZ3vJFKpNZQ4zMsjyQGiwAh72L3ipOpClQ6m+FIE1U1FdqOYGGe2@vger.kernel.org, AJvYcCWpSG7I8QRhrja0jPwTCk1IUxBjIDEZ2pU/TFV67m9FN60FfXKqkCgxF1TEIFam9bFQoWdpu6Tk3MfaLb0=@vger.kernel.org, AJvYcCXmSQeIUk63CYFdg2rQZlYnVsK9VC6t6BIN2zpJOw8chLFNlKMimQGmq4SOPVOtVfJnGeqraNyd2ReA@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx/WqdpnwKTxb7Y6qRwDp7g61aWeVJIzGuNXjh5DPtOr5duv0M
	5mUFbW6YvcfSBmU/uczDVus0EL3NVNW5YahUrlKMVXYbckVtusehTxcdXxPO
X-Gm-Gg: ASbGnctz6fvT6Ue1fZlVA3jbDBGu+aalZQsk5+nEmq2Np1BX1wqFJW+tVwcQAGQgy0Q
	6t2LYjTegKGLghUw00nXMm0azJl6NoyA265MErcO0KpFQZIzIBa7TPFJwqZYMFMgSgy5yhm5/df
	KvqjIYlJnavDblXk/XMsDgc5nGAbE1n034DnnHaDtNQ9f4V4vEa20j3V8FqzpIDs+VfzKjsAxP4
	d2G3cN5LaR6QWcKZehZXXiBabBhrkkzawUI7SWg8T2euC0/BVc8Kt1iqLuCN61cyKQ9wQYWESxM
	toqkFWjfGjD2AwTETXPipWpKefyxXlPFkOm2HoM1kAMiz8PCglYPNYbSb05ioqQ=
X-Google-Smtp-Source: AGHT+IGoysQnsXy/soQsabAa0O+rRAtcxxFE3knh2YgWplpAPCt6zg80DJQJrN/bdv/w6KwoMzSGlg==
X-Received: by 2002:a05:600c:a42:b0:441:d228:1fe5 with SMTP id 5b1f17b1804b1-442d6de0f78mr133405165e9.33.1747150917905;
        Tue, 13 May 2025 08:41:57 -0700 (PDT)
Received: from [10.5.0.2] ([195.158.248.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd3b7b83sm208753075e9.33.2025.05.13.08.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 08:41:57 -0700 (PDT)
Message-ID: <b7d128f89166af4cd2e4faa7e7eb6c16969e2d10.camel@gmail.com>
Subject: Re: [PATCH v3 07/22] mfd: adp5585: refactor how regmap defaults are
 handled
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Lee Jones
	 <lee@kernel.org>
Cc: nuno.sa@analog.com, linux-gpio@vger.kernel.org,
 linux-pwm@vger.kernel.org, 	devicetree@vger.kernel.org,
 linux-input@vger.kernel.org, Rob Herring	 <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley	 <conor+dt@kernel.org>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,  Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Dmitry
 Torokhov	 <dmitry.torokhov@gmail.com>, Liu Ying <victor.liu@nxp.com>
Date: Tue, 13 May 2025 16:41:57 +0100
In-Reply-To: <20250513153559.GD23592@pendragon.ideasonboard.com>
References: <20250512-dev-adp5589-fw-v3-0-092b14b79a88@analog.com>
	 <20250512-dev-adp5589-fw-v3-7-092b14b79a88@analog.com>
	 <20250513150029.GO2936510@google.com>
	 <20250513153559.GD23592@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-05-13 at 17:35 +0200, Laurent Pinchart wrote:
> On Tue, May 13, 2025 at 04:00:29PM +0100, Lee Jones wrote:
> > On Mon, 12 May 2025, Nuno S=C3=A1 via B4 Relay wrote:
> >=20
> > > From: Nuno S=C3=A1 <nuno.sa@analog.com>
> > >=20
> > > The only thing changing between variants is the regmap default
> > > registers. Hence, instead of having a regmap condig for every variant
> > > (duplicating lots of fields), add a chip info type of structure with =
a
> > > regmap id to identify which defaults to use and populate regmap_confi=
g
> > > at runtime given a template plus the id. Also note that between
> > > variants, the defaults can be the same which means the chip info
> > > structure can be used in more than one compatible.
> > >=20
> > > This will also make it simpler adding new chips with more variants.
> > >=20
> > > Also note that the chip info structures are deliberately not const as
> > > they will also contain lots of members that are the same between the
> > > different devices variants and so we will fill those at runtime.
> > >=20
> > > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > > ---
> > > =C2=A0drivers/mfd/adp5585.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 94 =
+++++++++++++++++++++++++---------------
> > > -----
> > > =C2=A0include/linux/mfd/adp5585.h | 11 ++++++
> > > =C2=A02 files changed, 64 insertions(+), 41 deletions(-)
> > >=20
> > > diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
> > > index
> > > 19d4a0ab1bb4c261e82559630624059529765fbd..874aed7d7cfe052587720d89909=
6c995
> > > c19667af 100644
> > > --- a/drivers/mfd/adp5585.c
> > > +++ b/drivers/mfd/adp5585.c
> > > @@ -81,41 +81,34 @@ static const u8
> > > adp5585_regmap_defaults_04[ADP5585_MAX_REG + 1] =3D {
> > > =C2=A0	/* 0x38 */ 0x00, 0x00, 0x00, 0x00, 0x00,
> > > =C2=A0};
> > > =C2=A0
> > > -enum adp5585_regmap_type {
> > > -	ADP5585_REGMAP_00,
> > > -	ADP5585_REGMAP_02,
> > > -	ADP5585_REGMAP_04,
> > > +static const struct regmap_config adp5585_regmap_config_template =3D=
 {
> > > +	.reg_bits =3D 8,
> > > +	.val_bits =3D 8,
> > > +	.max_register =3D ADP5585_MAX_REG,
> > > +	.volatile_table =3D &adp5585_volatile_regs,
> > > +	.cache_type =3D REGCACHE_MAPLE,
> > > +	.num_reg_defaults_raw =3D ADP5585_MAX_REG + 1,
> > > =C2=A0};
> > > =C2=A0
> > > -static const struct regmap_config adp5585_regmap_configs[] =3D {
> > > -	[ADP5585_REGMAP_00] =3D {
> > > -		.reg_bits =3D 8,
> > > -		.val_bits =3D 8,
> > > -		.max_register =3D ADP5585_MAX_REG,
> > > -		.volatile_table =3D &adp5585_volatile_regs,
> > > -		.cache_type =3D REGCACHE_MAPLE,
> > > -		.reg_defaults_raw =3D adp5585_regmap_defaults_00,
> > > -		.num_reg_defaults_raw =3D
> > > sizeof(adp5585_regmap_defaults_00),
> > > -	},
> > > -	[ADP5585_REGMAP_02] =3D {
> > > -		.reg_bits =3D 8,
> > > -		.val_bits =3D 8,
> > > -		.max_register =3D ADP5585_MAX_REG,
> > > -		.volatile_table =3D &adp5585_volatile_regs,
> > > -		.cache_type =3D REGCACHE_MAPLE,
> > > -		.reg_defaults_raw =3D adp5585_regmap_defaults_02,
> > > -		.num_reg_defaults_raw =3D
> > > sizeof(adp5585_regmap_defaults_02),
> > > -	},
> > > -	[ADP5585_REGMAP_04] =3D {
> > > -		.reg_bits =3D 8,
> > > -		.val_bits =3D 8,
> > > -		.max_register =3D ADP5585_MAX_REG,
> > > -		.volatile_table =3D &adp5585_volatile_regs,
> > > -		.cache_type =3D REGCACHE_MAPLE,
> > > -		.reg_defaults_raw =3D adp5585_regmap_defaults_04,
> > > -		.num_reg_defaults_raw =3D
> > > sizeof(adp5585_regmap_defaults_04),
> > > -	},
> > > -};
> > > +static int adp5585_fill_regmap_config(const struct adp5585_dev *adp5=
585,
> > > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct regmap_config
> > > *regmap_config)
> >=20
> > I like the general idea.=C2=A0 This is much more scaleable than before.
> >=20
> > > +{
> > > +	*regmap_config =3D adp5585_regmap_config_template;
> > > +
> > > +	switch (adp5585->info->regmap_type) {
> > > +	case ADP5585_REGMAP_00:
> > > +		regmap_config->reg_defaults_raw =3D
> > > adp5585_regmap_defaults_00;
> > > +		return 0;
> > > +	case ADP5585_REGMAP_02:
> > > +		regmap_config->reg_defaults_raw =3D
> > > adp5585_regmap_defaults_02;
> > > +		return 0;
> > > +	case ADP5585_REGMAP_04:
> > > +		regmap_config->reg_defaults_raw =3D
> > > adp5585_regmap_defaults_04;
> >=20
> > You could make this read a tiny bit nicer (as you do with the adp5585->=
info
> > in a later patch) and make reg_defaults_raw a local variable.
>=20
> And as ADP585_REGMAP_* is an enum and we have to handle all values, you
> can replace the switch with a static const array lookup.

ack

>=20
> > > +		return 0;
> > > +	default:
> > > +		return -ENODEV;
> > > +	}
> > > +}
> > > =C2=A0
> > > =C2=A0static int adp5585_parse_fw(struct device *dev, struct adp5585_=
dev
> > > *adp5585,
> > > =C2=A0			=C2=A0=C2=A0=C2=A0 struct mfd_cell **devs)
> > > @@ -153,7 +146,7 @@ static void adp5585_osc_disable(void *data)
> > > =C2=A0
> > > =C2=A0static int adp5585_i2c_probe(struct i2c_client *i2c)
> > > =C2=A0{
> > > -	const struct regmap_config *regmap_config;
> > > +	struct regmap_config regmap_config;
> > > =C2=A0	struct adp5585_dev *adp5585;
> > > =C2=A0	struct mfd_cell *devs;
> > > =C2=A0	unsigned int id;
> > > @@ -165,8 +158,15 @@ static int adp5585_i2c_probe(struct i2c_client *=
i2c)
> > > =C2=A0
> > > =C2=A0	i2c_set_clientdata(i2c, adp5585);
> > > =C2=A0
> > > -	regmap_config =3D i2c_get_match_data(i2c);
> > > -	adp5585->regmap =3D devm_regmap_init_i2c(i2c, regmap_config);
> > > +	adp5585->info =3D i2c_get_match_data(i2c);
> > > +	if (!adp5585->info)
> > > +		return -ENODEV;
> > > +
> > > +	ret =3D adp5585_fill_regmap_config(adp5585, &regmap_config);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	adp5585->regmap =3D devm_regmap_init_i2c(i2c, &regmap_config);
> > > =C2=A0	if (IS_ERR(adp5585->regmap))
> > > =C2=A0		return dev_err_probe(&i2c->dev, PTR_ERR(adp5585->regmap),
> > > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to initialize register
> > > map\n");
> > > @@ -223,22 +223,34 @@ static int adp5585_resume(struct device *dev)
> > > =C2=A0
> > > =C2=A0static DEFINE_SIMPLE_DEV_PM_OPS(adp5585_pm, adp5585_suspend,
> > > adp5585_resume);
> > > =C2=A0
> > > +static struct adp5585_info adp5585_info =3D {
> > > +	.regmap_type =3D ADP5585_REGMAP_00,
> >=20
> > Instead of providing this enum, then later another one (id) which is a
> > subset of the same thing, why not pass just ADP5585_REGMAP_00, etc
> > through the DT .data attribute then match on those?=C2=A0 It will add a
> > couple of lines to the switch(info->id) statement, but will save on a
> > boat load of static structs and other complexity.
> >=20
> > For instance:
> >=20
> > switch (info->id) {
> > 	case ADP5585_MAN_ID_VALUE:
> >=20
> > Would simply become:
> >=20
> > switch (info->id) {
> > 	case ADP5585_REGMAP_00:
> > 	case ADP5585_REGMAP_02:
> > 	case ADP5585_REGMAP_04:
> >=20
> > And that's it.
> >=20
> > > +};
> > > +
> > > +static struct adp5585_info adp5585_02_info =3D {
> > > +	.regmap_type =3D ADP5585_REGMAP_02,
> > > +};
> > > +
> > > +static struct adp5585_info adp5585_04_info =3D {
> > > +	.regmap_type =3D ADP5585_REGMAP_04,
> > > +};
> > > +
> > > =C2=A0static const struct of_device_id adp5585_of_match[] =3D {
> > > =C2=A0	{
> > > =C2=A0		.compatible =3D "adi,adp5585-00",
> > > -		.data =3D &adp5585_regmap_configs[ADP5585_REGMAP_00],
> > > +		.data =3D &adp5585_info,
> >=20
> > 		.data =3D ADP5585_REGMAP_00,
> >=20
> > > =C2=A0	}, {
> > > =C2=A0		.compatible =3D "adi,adp5585-01",
> > > -		.data =3D &adp5585_regmap_configs[ADP5585_REGMAP_00],
> > > +		.data =3D &adp5585_info,
> > > =C2=A0	}, {
> > > =C2=A0		.compatible =3D "adi,adp5585-02",
> > > -		.data =3D &adp5585_regmap_configs[ADP5585_REGMAP_02],
> > > +		.data =3D &adp5585_02_info,
> > > =C2=A0	}, {
> > > =C2=A0		.compatible =3D "adi,adp5585-03",
> > > -		.data =3D &adp5585_regmap_configs[ADP5585_REGMAP_00],
> > > +		.data =3D &adp5585_info,
> > > =C2=A0	}, {
> > > =C2=A0		.compatible =3D "adi,adp5585-04",
> > > -		.data =3D &adp5585_regmap_configs[ADP5585_REGMAP_04],
> > > +		.data =3D &adp5585_04_info,
> > > =C2=A0	},
> > > =C2=A0	{ /* sentinel */ }
> > > =C2=A0};
> > > diff --git a/include/linux/mfd/adp5585.h b/include/linux/mfd/adp5585.=
h
> > > index
> > > 016033cd68e46757aca86d21dd37025fd354b801..4b48614970a811a8a95116faa20=
e58ea
> > > 4f19ede6 100644
> > > --- a/include/linux/mfd/adp5585.h
> > > +++ b/include/linux/mfd/adp5585.h
> > > @@ -119,8 +119,19 @@
> > > =C2=A0
> > > =C2=A0struct regmap;
> > > =C2=A0
> > > +enum adp5585_regmap_type {
> > > +	ADP5585_REGMAP_00,
> > > +	ADP5585_REGMAP_02,
> > > +	ADP5585_REGMAP_04,
> > > +};
> > > +
> > > +struct adp5585_info {
> > > +	enum adp5585_regmap_type regmap_type;
> > > +};
> > > +
> > > =C2=A0struct adp5585_dev {
> > > =C2=A0	struct regmap *regmap;
> > > +	const struct adp5585_info *info;
> > > =C2=A0};
> > > =C2=A0
> > > =C2=A0#endif

