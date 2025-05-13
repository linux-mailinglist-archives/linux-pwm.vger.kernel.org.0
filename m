Return-Path: <linux-pwm+bounces-5958-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B950BAB58B2
	for <lists+linux-pwm@lfdr.de>; Tue, 13 May 2025 17:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8AB586599B
	for <lists+linux-pwm@lfdr.de>; Tue, 13 May 2025 15:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917221B0439;
	Tue, 13 May 2025 15:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QrEgjf+2"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C7C383;
	Tue, 13 May 2025 15:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747150364; cv=none; b=K7KGmuG+JzgaatJntBMXSNERUvbGQRgnCrbMAmXutv9LQpQUjB6dcwZyV7e5PVK9Qo33TCGrbYKzg7oX9Cn2XtLVUncixlCBoxrjs9vgfZjm2tHUP6ZeoMfInYYTc1PhwD4SwlnXxOUyYxjIbA90Fc6gRX98cc8znORFskQ0ePY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747150364; c=relaxed/simple;
	bh=UT68JW61smUQnHQDw8q3TKncsiXQ9tGQUKM0nZ230NU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zr7U6qJuMBHvgyxgAZqSVtDwxOOH1OfDGEFP1GIqbwQDd+N8TYRfQ79Zg5Mb5vx+FWOTegkWQNurGcSxJkdwgaKCGkYStNXGAc9MPDpMWbCgI0nSnrzBEuGF37qSfpUUkrlg/4Cj4FprEgaMg4e4/2nVmpg8xV7M8NQZYPZYaFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QrEgjf+2; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43d2d952eb1so42894685e9.1;
        Tue, 13 May 2025 08:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747150360; x=1747755160; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T+oz213YQXD9ftNesd5CPZa05q7Zz53aF0Fc3bGzVW8=;
        b=QrEgjf+2C+ywDhWm3hzsAkdjJsE/KaRYRaaVF8vBbQAzbzWEleHG6d59rmftDl09Zr
         0ct7POF9ZsXJ8788/klyiBOMiByZCN5e+RP13c+MRF/KRkXuswIIf1Fx6nHp/QqrpCRh
         OP3LJM7HKg71ptKL/57yQ7Esr3lj1vZR2iwfsJG7fruMYFkd2cruybiZqaYv8QQL98n7
         9rnfAUht8prsAjjXpkffk10nbO7jpdkpHbxucre+aEK8lSKdPo2pSDJW/QHfB2y4vLci
         M585UgDaMt5m+9lvMZ26QomY9gTiFHXfUyephr/WjMANGx/W/WjSB6DGCIDKeTsCew85
         7Z8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747150360; x=1747755160;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T+oz213YQXD9ftNesd5CPZa05q7Zz53aF0Fc3bGzVW8=;
        b=DoN4oWrIFRB5n9MHL7+afEISlugoTIwzEmeHPAiQhYK4kKiqiTy4WiCq75GqlVneUX
         uMZ/VdhrrJG5bRtZWpyPPg6lOCU13Thh9Ktb8KPh2cGsKtV2inkJLj+rs9eNudQbEw8a
         3TIg0vYfhpcQ+GvQsEuuSq+xO6C436p7uqQQbYUUbz85Xf5jUvCufzLkYzWhcfHIXcSL
         YBEIybtjfpddNaU4rZCTGkF56dF1sMt06vwmibKMwrGr7/XbaybTnL2zr7afgGxgIxJK
         srgL4KlbE1O6lRK2FiFWPk8qMNaAZ1IlLB3/JCGyc0EAgk/l4jtgHBaTrEigp+NRGOHE
         NTDg==
X-Forwarded-Encrypted: i=1; AJvYcCVEZPUfmARg9beX/KwTxu6dDQnF64J1DjwE0ArZmrA1hQe/zIrobfXbSWCWpW68n87+DG3oKRWUtx6U@vger.kernel.org, AJvYcCVoEVZ9ZZh6a/5N74PU2p9KEp81yZCStHBJAhzwY12OCARRFWEN6QRzgUKfRYKPiAkt9wE9qm6CsBvo@vger.kernel.org, AJvYcCWwgcwlXG27Sym9aWhq0kxNmYJLE0J83joF2XuD/f2/KsxQYP2zJnn/775eFHTuiOR3YIUq4mfbDoVxehA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO8mg0l7q8NSDL1dVy3De2q0l3bCtd8oGobjOMTED16/Q+2Zud
	sGSQcufMvZqLd/YZaQpC3ol9BGLKauGYOPwxPxe5mpK3gN/8m3+A
X-Gm-Gg: ASbGncvpD/uaGk0QKzvQ48MOxGoopUasXVVhYsFNuV+an0x5dDUEREQ8Tn0AYjJ+mHW
	A3PuF+7RKkWmcpk50i/MI6wm093UVjCz6axJZeGgvheCQVWBxlUVSuABnU3bL5CE2jchuvvdBlI
	WugR4iR7GcWp0/+GgmzXCRz2URAIjuhTD8yndf/sv+/GG6tsyz7hck0dF+rY27GjNatajmNolwp
	q7hHrmviPWfREfTRt/AkiRFByZ7eRjc4gncSHbKDjNlXV1kmOTJkMn75Ruf4WfAI78+6lIWNLFq
	KNqEbvP9wowKkG8l0UXCkfkqO7irja2rlRIWto6PnbWH7LslvnfQ112z5uOLB9Q=
X-Google-Smtp-Source: AGHT+IEEqIla41XM2QRSNZaVjxuA0YNHDocihYVWf89dbOkRMMMUWWeRk/8zx+2AJpiX1jTCqcZl5w==
X-Received: by 2002:a05:600c:3b85:b0:43b:c5a3:2e1a with SMTP id 5b1f17b1804b1-442d6d11fdemr159223455e9.2.1747150360259;
        Tue, 13 May 2025 08:32:40 -0700 (PDT)
Received: from [10.5.0.2] ([195.158.248.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d687ac8csm167270355e9.33.2025.05.13.08.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 08:32:39 -0700 (PDT)
Message-ID: <c2c32541c31376d90b938f6c3532e195243dadf2.camel@gmail.com>
Subject: Re: [PATCH v3 07/22] mfd: adp5585: refactor how regmap defaults are
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
Date: Tue, 13 May 2025 16:32:39 +0100
In-Reply-To: <20250513150029.GO2936510@google.com>
References: <20250512-dev-adp5589-fw-v3-0-092b14b79a88@analog.com>
	 <20250512-dev-adp5589-fw-v3-7-092b14b79a88@analog.com>
	 <20250513150029.GO2936510@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-05-13 at 16:00 +0100, Lee Jones wrote:
> On Mon, 12 May 2025, Nuno S=C3=A1 via B4 Relay wrote:
>=20
> > From: Nuno S=C3=A1 <nuno.sa@analog.com>
> >=20
> > The only thing changing between variants is the regmap default
> > registers. Hence, instead of having a regmap condig for every variant
> > (duplicating lots of fields), add a chip info type of structure with a
> > regmap id to identify which defaults to use and populate regmap_config
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
> > =C2=A0drivers/mfd/adp5585.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 94 ++=
+++++++++++++++++++++++-----------------
> > ---
> > =C2=A0include/linux/mfd/adp5585.h | 11 ++++++
> > =C2=A02 files changed, 64 insertions(+), 41 deletions(-)
> >=20
> > diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
> > index
> > 19d4a0ab1bb4c261e82559630624059529765fbd..874aed7d7cfe052587720d899096c=
995c1
> > 9667af 100644
> > --- a/drivers/mfd/adp5585.c
> > +++ b/drivers/mfd/adp5585.c
> > @@ -81,41 +81,34 @@ static const u8
> > adp5585_regmap_defaults_04[ADP5585_MAX_REG + 1] =3D {
> > =C2=A0	/* 0x38 */ 0x00, 0x00, 0x00, 0x00, 0x00,
> > =C2=A0};
> > =C2=A0
> > -enum adp5585_regmap_type {
> > -	ADP5585_REGMAP_00,
> > -	ADP5585_REGMAP_02,
> > -	ADP5585_REGMAP_04,
> > +static const struct regmap_config adp5585_regmap_config_template =3D {
> > +	.reg_bits =3D 8,
> > +	.val_bits =3D 8,
> > +	.max_register =3D ADP5585_MAX_REG,
> > +	.volatile_table =3D &adp5585_volatile_regs,
> > +	.cache_type =3D REGCACHE_MAPLE,
> > +	.num_reg_defaults_raw =3D ADP5585_MAX_REG + 1,
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
> > -};
> > +static int adp5585_fill_regmap_config(const struct adp5585_dev *adp558=
5,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct regmap_config *regmap_config=
)
>=20
> I like the general idea.=C2=A0 This is much more scaleable than before.
>=20
> > +{
> > +	*regmap_config =3D adp5585_regmap_config_template;
> > +
> > +	switch (adp5585->info->regmap_type) {
> > +	case ADP5585_REGMAP_00:
> > +		regmap_config->reg_defaults_raw =3D
> > adp5585_regmap_defaults_00;
> > +		return 0;
> > +	case ADP5585_REGMAP_02:
> > +		regmap_config->reg_defaults_raw =3D
> > adp5585_regmap_defaults_02;
> > +		return 0;
> > +	case ADP5585_REGMAP_04:
> > +		regmap_config->reg_defaults_raw =3D
> > adp5585_regmap_defaults_04;
>=20
> You could make this read a tiny bit nicer (as you do with the adp5585->in=
fo
> in a later patch) and make reg_defaults_raw a local variable.

I'm probably missing your point but what would be the benefit? The info is =
done
like that because I wanted the pointer to be 'const'. Here I do not think t=
he
same applies...

>=20
> > +		return 0;
> > +	default:
> > +		return -ENODEV;
> > +	}
> > +}
> > =C2=A0
> > =C2=A0static int adp5585_parse_fw(struct device *dev, struct adp5585_de=
v
> > *adp5585,
> > =C2=A0			=C2=A0=C2=A0=C2=A0 struct mfd_cell **devs)
> > @@ -153,7 +146,7 @@ static void adp5585_osc_disable(void *data)
> > =C2=A0
> > =C2=A0static int adp5585_i2c_probe(struct i2c_client *i2c)
> > =C2=A0{
> > -	const struct regmap_config *regmap_config;
> > +	struct regmap_config regmap_config;
> > =C2=A0	struct adp5585_dev *adp5585;
> > =C2=A0	struct mfd_cell *devs;
> > =C2=A0	unsigned int id;
> > @@ -165,8 +158,15 @@ static int adp5585_i2c_probe(struct i2c_client *i2=
c)
> > =C2=A0
> > =C2=A0	i2c_set_clientdata(i2c, adp5585);
> > =C2=A0
> > -	regmap_config =3D i2c_get_match_data(i2c);
> > -	adp5585->regmap =3D devm_regmap_init_i2c(i2c, regmap_config);
> > +	adp5585->info =3D i2c_get_match_data(i2c);
> > +	if (!adp5585->info)
> > +		return -ENODEV;
> > +
> > +	ret =3D adp5585_fill_regmap_config(adp5585, &regmap_config);
> > +	if (ret)
> > +		return ret;
> > +
> > +	adp5585->regmap =3D devm_regmap_init_i2c(i2c, &regmap_config);
> > =C2=A0	if (IS_ERR(adp5585->regmap))
> > =C2=A0		return dev_err_probe(&i2c->dev, PTR_ERR(adp5585->regmap),
> > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to initialize register
> > map\n");
> > @@ -223,22 +223,34 @@ static int adp5585_resume(struct device *dev)
> > =C2=A0
> > =C2=A0static DEFINE_SIMPLE_DEV_PM_OPS(adp5585_pm, adp5585_suspend,
> > adp5585_resume);
> > =C2=A0
> > +static struct adp5585_info adp5585_info =3D {
> > +	.regmap_type =3D ADP5585_REGMAP_00,
>=20
> Instead of providing this enum, then later another one (id) which is a
> subset of the same thing, why not pass just ADP5585_REGMAP_00, etc
> through the DT .data attribute then match on those?=C2=A0 It will add a
> couple of lines to the switch(info->id) statement, but will save on a
> boat load of static structs and other complexity.
>=20
> For instance:
>=20
> switch (info->id) {
> 	case ADP5585_MAN_ID_VALUE:
>=20
> Would simply become:
>=20
> switch (info->id) {
> 	case ADP5585_REGMAP_00:
> 	case ADP5585_REGMAP_02:
> 	case ADP5585_REGMAP_04:
>=20
> And that's it.

I get the general idea... We will also have to pack the regmap defaults int=
o an
array so that we can easily reference it with 'info->id' which I don't like=
 too
much tbh (but I do see that adp5585_fill_chip_configs() will become simpler=
) . I
guess I can also just move everything into the "main" struct as we will fil=
l
everything during probe (no real reason for struct adp5585_info)=20

Anyways, If you prefer the above I'm not going to argue against it...

>=20
> > +};
> > +
> > +static struct adp5585_info adp5585_02_info =3D {
> > +	.regmap_type =3D ADP5585_REGMAP_02,
> > +};
> > +
> > +static struct adp5585_info adp5585_04_info =3D {
> > +	.regmap_type =3D ADP5585_REGMAP_04,
> > +};
> > +
> > =C2=A0static const struct of_device_id adp5585_of_match[] =3D {
> > =C2=A0	{
> > =C2=A0		.compatible =3D "adi,adp5585-00",
> > -		.data =3D &adp5585_regmap_configs[ADP5585_REGMAP_00],
> > +		.data =3D &adp5585_info,
>=20
> 		.data =3D ADP5585_REGMAP_00,

I see, needs a cast but should work. I personally prefer valid pointers tha=
n
"encoding" integers in here. I know we can start the enum at 1 so that we c=
an
still look for 0 for any possible issue but...


>=20
> > =C2=A0	}, {
> > =C2=A0		.compatible =3D "adi,adp5585-01",
> > -		.data =3D &adp5585_regmap_configs[ADP5585_REGMAP_00],
> > +		.data =3D &adp5585_info,
> > =C2=A0	}, {
> > =C2=A0		.compatible =3D "adi,adp5585-02",
> > -		.data =3D &adp5585_regmap_configs[ADP5585_REGMAP_02],
> > +		.data =3D &adp5585_02_info,
> > =C2=A0	}, {
> > =C2=A0		.compatible =3D "adi,adp5585-03",
> > -		.data =3D &adp5585_regmap_configs[ADP5585_REGMAP_00],
> > +		.data =3D &adp5585_info,
> > =C2=A0	}, {
> > =C2=A0		.compatible =3D "adi,adp5585-04",
> > -		.data =3D &adp5585_regmap_configs[ADP5585_REGMAP_04],
> > +		.data =3D &adp5585_04_info,
> > =C2=A0	},
> > =C2=A0	{ /* sentinel */ }
> > =C2=A0};
> > diff --git a/include/linux/mfd/adp5585.h b/include/linux/mfd/adp5585.h
> > index
> > 016033cd68e46757aca86d21dd37025fd354b801..4b48614970a811a8a95116faa20e5=
8ea4f
> > 19ede6 100644
> > --- a/include/linux/mfd/adp5585.h
> > +++ b/include/linux/mfd/adp5585.h
> > @@ -119,8 +119,19 @@
> > =C2=A0
> > =C2=A0struct regmap;
> > =C2=A0
> > +enum adp5585_regmap_type {
> > +	ADP5585_REGMAP_00,
> > +	ADP5585_REGMAP_02,
> > +	ADP5585_REGMAP_04,
> > +};
> > +
> > +struct adp5585_info {
> > +	enum adp5585_regmap_type regmap_type;
> > +};
> > +
> > =C2=A0struct adp5585_dev {
> > =C2=A0	struct regmap *regmap;
> > +	const struct adp5585_info *info;
> > =C2=A0};
> > =C2=A0
> > =C2=A0#endif
> >=20
> > --=20
> > 2.49.0
> >=20
> >=20

