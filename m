Return-Path: <linux-pwm+bounces-6146-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CFEAC4C23
	for <lists+linux-pwm@lfdr.de>; Tue, 27 May 2025 12:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA411189F329
	for <lists+linux-pwm@lfdr.de>; Tue, 27 May 2025 10:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA3C2550D5;
	Tue, 27 May 2025 10:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+Iw/XEY"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755FD1F7098;
	Tue, 27 May 2025 10:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748341212; cv=none; b=kexU+G2i1qfyKkPKolXioq/FzCTmenxkT4Ul3a5J04Vbn1LAw+iBmUnWNWV4vJ/kJTr7jpTWyNLcXIuw7Wru8mbpb7/gcfu7RoOtl/DRep80odq6kqRIOCaQcAoozImB2qrEUQpz628x42dzKmY03Gt6VFsT9rWwTRuayWDxYts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748341212; c=relaxed/simple;
	bh=K/1efxChq+4+vKPl9H443PBUu8IYs297KO9Y+pksU40=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s50vjsW1KguJ+biVIiMDezfTkmhM5KY+Bt1347cwIUXp22vh+NbB49uP5wC0AxeSIp1t4Dnt48WDB51/h34dwQQxUJjV0aEdfHge5mRfu6QyRBOVzeR1gL97FEpZxUqFFULPrwwuzQrVZOGmBM4sSoXbNkJ92jyU00an9gLFo7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+Iw/XEY; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-604f5691bceso526818a12.0;
        Tue, 27 May 2025 03:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748341209; x=1748946009; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XCEwa8ngEUfu9xRiYkz/FF0aiqymyNYBZ51ThyifP+0=;
        b=C+Iw/XEYBlQDz/s8IVRp5hnqev0LCrxDBPMbT9mvR+vOlIUOCc1ty4kvQg13DI9vj/
         idQl1lXVYSZr2ROzeTYto2h33lUgrwflGxibe7/TACgvSxAWyzLfI8H5S1PI+PEdsgkN
         Pdh+t/q++rXULYrniEZYRAwZ/lxfCIqLdv25J87pM2/MPim5Rv6z3wPBnwjOxgYW2iwH
         1OpvrPzD0twDxzIKRHEnmwjirnHGv1SUn1LM+5R1IUCbZSYUZAVoiVRA4zlIBSW4cJ16
         xhm3fNFn+TSTsbmlbWfWeBjitiUBs0UxjfAloiFAlmY8TLkFSQfUGZvgSgKy82MekvXp
         VKIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748341209; x=1748946009;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XCEwa8ngEUfu9xRiYkz/FF0aiqymyNYBZ51ThyifP+0=;
        b=Wo1MSvaI3lpC9Y3FGOd/yjlhH6p+rlVTHHB60yn2HtBDXa3DF7yw86/t3AHIrxu1hQ
         OLiEwSIBjJLE3qa9AXF4Tk1kIwkRakE6Zg5T56CfVfm3bsR4gpnH0GUPeQ/cumJb6pne
         JwI7c4/lN+vEHbwVJNTUo7Pz4QEefMeD/FFf6TlbJunYTk6XxnGZU+nfinSzo3Q5jlGL
         /VseiicqyevCY97ItqyPg8Gj/+7ub6+8CoiD2PpnDDv0iNtUECcZuLyo5hvw52+W6vDY
         0vQf+PuTnHu4PXDfwDJSoI2bgN3hOWfcF9i/6ZxKFJMM7tEKRgt6LOloZrVyWgKDRLdD
         JgHg==
X-Forwarded-Encrypted: i=1; AJvYcCU2G+OofGxsafEVaQ+8qjndRhbrOAK+fyMmXVetWOW1pBU7FYslbjgbQDIvrKwJTAgv/H7VzrubEuK9@vger.kernel.org, AJvYcCV8Y5tvNsN/aAmpRi/hkX7OtftoMA0+z2chTb+VcfxgPuF4PaFqyxMdAgRuxZ70cZ27EiUCrO7HNzAt@vger.kernel.org, AJvYcCXfFURTKnqXrkEPmqJRKhLu3QpQVAFVqLegW3iJiMH3fqanPrBMiTGkZFFFkPTHIP/JQUccEDhG/OKazEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjoTGJ9HwatzUTNvVs0biKsZr/ukIo0MRdwyPkfUKQdK1fmoQm
	KWOgRBi0uf3Ji6wd8kNZeOmW3Y7JKVtxdIxopYtB+91WdHbvLT3ruO6h
X-Gm-Gg: ASbGncuITe5vxVOD5iVTqy5B/tlZGVqitPVfHqxp4+CV2bye5xEQnUI9hP7NlN7UjKG
	hzN0AOuIfR59/JieowYp/sYTPqFP2+39sW0h5+DFsHPDcBvuLxJsNIFnGWLsJpZoXbDnSVHaWhX
	WCJAp+TmVZfh1CpGD+XZ/6zsH57XaSUdS18nmltkUUPMX6g7nlaciJsbIiJAABKUp+eD+9dA0mP
	/I+JttiKYE9C7YpaQRV2CU2J/3Rcw41o2jb7YZ7wGt5JUiYOslR1s+MR+HyskuHIWJQMxPZaawZ
	wM4/kB3fzhEGTnZb4JfF9zrmmV00k+YkeYB1xvk3ViCFyTP3V0kv74eaMjw=
X-Google-Smtp-Source: AGHT+IGfsP7rbPrcA26GHVq4q0QaqkyQocyn0BF9lHqRTjXSEj+U6BdTWSsF3KoSeSZ9ZFMgYBCqGw==
X-Received: by 2002:a05:6402:84f:b0:601:de0a:764d with SMTP id 4fb4d7f45d1cf-602da5f3607mr9144694a12.32.1748341208331;
        Tue, 27 May 2025 03:20:08 -0700 (PDT)
Received: from [100.73.1.233] ([195.158.248.117])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6005a6e3ca0sm17809695a12.42.2025.05.27.03.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 03:20:07 -0700 (PDT)
Message-ID: <e54e2ae8a1231ce44e9a0becd14e210f3c8f2bca.camel@gmail.com>
Subject: Re: [PATCH v4 07/20] mfd: adp5585: add support for adp5589
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
Date: Tue, 27 May 2025 11:20:11 +0100
In-Reply-To: <20250523151514.GI1378991@google.com>
References: <20250521-dev-adp5589-fw-v4-0-f2c988d7a7a0@analog.com>
	 <20250521-dev-adp5589-fw-v4-7-f2c988d7a7a0@analog.com>
	 <20250523151514.GI1378991@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-05-23 at 16:15 +0100, Lee Jones wrote:
> On Wed, 21 May 2025, Nuno S=C3=A1 via B4 Relay wrote:
>=20
> > From: Nuno S=C3=A1 <nuno.sa@analog.com>
> >=20
> > The ADP5589 is a 19 I/O port expander with built-in keypad matrix decod=
er,
> > programmable logic, reset generator, and PWM generator.
> >=20
> > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > ---
> > =C2=A0drivers/mfd/adp5585.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 139 +=
++++++++++++++++++++++++++++++++++++++--
> > ---
> > =C2=A0include/linux/mfd/adp5585.h |=C2=A0 11 ++++
> > =C2=A02 files changed, 134 insertions(+), 16 deletions(-)
> >=20
> > diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
> > index
> > 672f3468bda5be6af85a5982c3626053b4cb59bf..53ac46365e56874a05855f1df1843=
71714
> > 8f181a 100644
> > --- a/drivers/mfd/adp5585.c
> > +++ b/drivers/mfd/adp5585.c
> > @@ -29,6 +29,11 @@ static const struct mfd_cell
> > adp5585_devs[ADP5585_DEV_MAX] =3D {
> > =C2=A0	MFD_CELL_NAME("adp5585-pwm"),
> > =C2=A0};
> > =C2=A0
> > +static const struct mfd_cell adp5589_devs[] =3D {
> > +	MFD_CELL_NAME("adp5589-gpio"),
> > +	MFD_CELL_NAME("adp5589-pwm"),
> > +};
> > +
> > =C2=A0static const struct regmap_range adp5585_volatile_ranges[] =3D {
> > =C2=A0	regmap_reg_range(ADP5585_ID, ADP5585_GPI_STATUS_B),
> > =C2=A0};
> > @@ -38,6 +43,15 @@ static const struct regmap_access_table
> > adp5585_volatile_regs =3D {
> > =C2=A0	.n_yes_ranges =3D ARRAY_SIZE(adp5585_volatile_ranges),
> > =C2=A0};
> > =C2=A0
> > +static const struct regmap_range adp5589_volatile_ranges[] =3D {
> > +	regmap_reg_range(ADP5585_ID, ADP5589_GPI_STATUS_C),
> > +};
> > +
> > +static const struct regmap_access_table adp5589_volatile_regs =3D {
> > +	.yes_ranges =3D adp5589_volatile_ranges,
> > +	.n_yes_ranges =3D ARRAY_SIZE(adp5589_volatile_ranges),
> > +};
> > +
> > =C2=A0/*
> > =C2=A0 * Chip variants differ in the default configuration of pull-up a=
nd pull-
> > down
> > =C2=A0 * resistors, and therefore have different default register value=
s:
> > @@ -81,6 +95,45 @@ static const u8
> > adp5585_regmap_defaults_04[ADP5585_MAX_REG + 1] =3D {
> > =C2=A0	/* 0x38 */ 0x00, 0x00, 0x00, 0x00, 0x00,
> > =C2=A0};
> > =C2=A0
> > +static const u8 adp5589_regmap_defaults_00[ADP5589_MAX_REG + 1] =3D {
>=20
> Why +1?
>=20
> > +	/* 0x00 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > +	/* 0x08 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > +	/* 0x10 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > +	/* 0x18 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > +	/* 0x20 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > +	/* 0x28 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > +	/* 0x30 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > +	/* 0x38 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > +	/* 0x40 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > +	/* 0x48 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > +};
> > +
> > +static const u8 adp5589_regmap_defaults_01[ADP5589_MAX_REG + 1] =3D {
> > +	/* 0x00 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > +	/* 0x08 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > +	/* 0x10 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > +	/* 0x18 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > +	/* 0x20 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > +	/* 0x28 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > +	/* 0x30 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > +	/* 0x38 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x20, 0x00, 0x00,
> > +	/* 0x40 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > +	/* 0x48 */ 0x00, 0x00, 0x00, 0x00, 0x20, 0x00, 0x00,
> > +};
> > +
> > +static const u8 adp5589_regmap_defaults_02[ADP5589_MAX_REG + 1] =3D {
> > +	/* 0x00 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > +	/* 0x08 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > +	/* 0x10 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > +	/* 0x18 */ 0x00, 0x41, 0x01, 0x00, 0x11, 0x04, 0x00, 0x00,
> > +	/* 0x20 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > +	/* 0x28 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > +	/* 0x30 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > +	/* 0x38 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > +	/* 0x40 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > +	/* 0x48 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > +};
> > +
> > =C2=A0/* -1 since the enum starts at 1 for error checking in
> > i2c_get_match_data()*/
> > =C2=A0static const u8 *adp5585_regmap_defaults[ADP5585_MAX - 1] =3D {
> > =C2=A0	[ADP5585_00 - 1] =3D adp5585_regmap_defaults_00,
> > @@ -88,6 +141,9 @@ static const u8 *adp5585_regmap_defaults[ADP5585_MAX=
 - 1]
> > =3D {
> > =C2=A0	[ADP5585_02 - 1] =3D adp5585_regmap_defaults_02,
> > =C2=A0	[ADP5585_03 - 1] =3D adp5585_regmap_defaults_00,
> > =C2=A0	[ADP5585_04 - 1] =3D adp5585_regmap_defaults_04,
> > +	[ADP5589_00 - 1] =3D adp5589_regmap_defaults_00,
> > +	[ADP5589_01 - 1] =3D adp5589_regmap_defaults_01,
> > +	[ADP5589_02 - 1] =3D adp5589_regmap_defaults_02,
> > =C2=A0};
> > =C2=A0
> > =C2=A0static const struct regmap_config adp5585_regmap_config_template =
=3D {
> > @@ -99,11 +155,39 @@ static const struct regmap_config
> > adp5585_regmap_config_template =3D {
> > =C2=A0	.num_reg_defaults_raw =3D ADP5585_MAX_REG + 1,
> > =C2=A0};
> > =C2=A0
> > -static void adp5585_fill_regmap_config(const struct adp5585_dev *adp55=
85,
> > +static const struct regmap_config adp5589_regmap_config_template =3D {
> > +	.reg_bits =3D 8,
> > +	.val_bits =3D 8,
> > +	.max_register =3D ADP5589_MAX_REG,
> > +	.volatile_table =3D &adp5589_volatile_regs,
> > +	.cache_type =3D REGCACHE_MAPLE,
> > +	.num_reg_defaults_raw =3D ADP5589_MAX_REG + 1,
>=20
> This is 0x4F, but there are only 0x4E values?

Well, you want to write all registers while i < num_reg_defaults_raw. So, t=
o
actually write in ADP5589_MAX_REG, you need + 1. IOW, if your max register
address is 8 and you want to write it, your array map needs to be able go u=
ntil
index 8.

- Nuno S=C3=A1

> > +};
> > +
> > +static int adp5585_fill_variant_config(struct adp5585_dev *adp5585,
> > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct regmap_config *re=
gmap_config)
> > =C2=A0{
> > -	*regmap_config =3D adp5585_regmap_config_template;
> > +	switch (adp5585->variant) {
> > +	case ADP5585_00:
> > +	case ADP5585_01:
> > +	case ADP5585_02:
> > +	case ADP5585_03:
> > +	case ADP5585_04:
> > +		*regmap_config =3D adp5585_regmap_config_template;
> > +		adp5585->id =3D ADP5585_MAN_ID_VALUE;
> > +		break;
> > +	case ADP5589_00:
> > +	case ADP5589_01:
> > +	case ADP5589_02:
> > +		*regmap_config =3D adp5589_regmap_config_template;
> > +		adp5585->id =3D ADP5589_MAN_ID_VALUE;
> > +		break;
> > +	default:
> > +		return -ENODEV;
>=20
> If you take my previous advice, this will become ERR_PTR();
>=20
> > +	}
> > +
> > =C2=A0	regmap_config->reg_defaults_raw =3D adp5585_regmap_defaults[adp5=
585-
> > >variant - 1];
> > +	return 0;
> > =C2=A0}
> > =C2=A0
> > =C2=A0static void adp5585_remove_devices(void *dev)
> > @@ -111,29 +195,35 @@ static void adp5585_remove_devices(void *dev)
> > =C2=A0	mfd_remove_devices(dev);
> > =C2=A0}
> > =C2=A0
> > -static int adp5585_add_devices(struct device *dev)
> > +static int adp5585_add_devices(const struct adp5585_dev *adp5585)
> > =C2=A0{
> > +	const struct mfd_cell *cells;
> > =C2=A0	int ret;
> > =C2=A0
> > -	if (device_property_present(dev, "#pwm-cells")) {
> > -		ret =3D mfd_add_devices(dev, PLATFORM_DEVID_AUTO,
> > -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &adp5585_devs[ADP5585_DEV_PWM], 1,
> > NULL, 0, NULL);
> > +	if (adp5585->id =3D=3D ADP5585_MAN_ID_VALUE)
> > +		cells =3D adp5585_devs;
> > +	else
> > +		cells =3D adp5589_devs;
> > +
> > +	if (device_property_present(adp5585->dev, "#pwm-cells")) {
> > +		ret =3D mfd_add_devices(adp5585->dev, PLATFORM_DEVID_AUTO,
>=20
> Instead of making all of these changes, add the following at the top:
>=20
> 	struct device *dev =3D adp5585->dev;
>=20
> ... and continue using the short form.

ack

>=20
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &cells[ADP5585_DEV_PWM], 1, NULL, 0=
,
> > NULL);
> > =C2=A0		if (ret)
> > -			return dev_err_probe(dev, ret, "Failed to add pwm
> > device\n");
> > +			return dev_err_probe(adp5585->dev, ret, "Failed to
> > add pwm device\n");
> > =C2=A0	}
> > =C2=A0
> > -	if (device_property_present(dev, "#gpio-cells")) {
> > -		ret =3D mfd_add_devices(dev, PLATFORM_DEVID_AUTO,
> > -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &adp5585_devs[ADP5585_DEV_GPIO], 1,
> > NULL, 0, NULL);
> > +	if (device_property_present(adp5585->dev, "#gpio-cells")) {
> > +		ret =3D mfd_add_devices(adp5585->dev, PLATFORM_DEVID_AUTO,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &cells[ADP5585_DEV_GPIO], 1, NULL, =
0,
> > NULL);
> > =C2=A0		if (ret) {
> > -			ret =3D dev_err_probe(dev, ret, "Failed to add gpio
> > device\n");
> > +			ret =3D dev_err_probe(adp5585->dev, ret, "Failed to
> > add gpio device\n");
> > =C2=A0			goto out_error;
> > =C2=A0		}
> > =C2=A0	}
> > =C2=A0
> > -	return devm_add_action_or_reset(dev, adp5585_remove_devices, dev);
> > +	return devm_add_action_or_reset(adp5585->dev,
> > adp5585_remove_devices, adp5585->dev);
> > =C2=A0out_error:
> > -	mfd_remove_devices(dev);
> > +	mfd_remove_devices(adp5585->dev);
> > =C2=A0	return ret;
> > =C2=A0}
> > =C2=A0
> > @@ -161,19 +251,24 @@ static int adp5585_i2c_probe(struct i2c_client *i=
2c)
> > =C2=A0	if (!adp5585->variant)
> > =C2=A0		return -ENODEV;
> > =C2=A0
> > -	adp5585_fill_regmap_config(adp5585, &regmap_config);
> > +	ret =3D adp5585_fill_variant_config(adp5585, &regmap_config);
> > +	if (ret)
> > +		return ret;
> > =C2=A0
> > =C2=A0	adp5585->regmap =3D devm_regmap_init_i2c(i2c, &regmap_config);
> > =C2=A0	if (IS_ERR(adp5585->regmap))
> > =C2=A0		return dev_err_probe(&i2c->dev, PTR_ERR(adp5585->regmap),
> > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to initialize register
> > map\n");
> > =C2=A0
> > +	adp5585->dev =3D &i2c->dev;
> > +
> > =C2=A0	ret =3D regmap_read(adp5585->regmap, ADP5585_ID, &id);
> > =C2=A0	if (ret)
> > =C2=A0		return dev_err_probe(&i2c->dev, ret,
> > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to read device ID\n");
> > =C2=A0
> > -	if ((id & ADP5585_MAN_ID_MASK) !=3D ADP5585_MAN_ID_VALUE)
> > +	id &=3D ADP5585_MAN_ID_MASK;
> > +	if (id !=3D adp5585->id)
> > =C2=A0		return dev_err_probe(&i2c->dev, -ENODEV,
> > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid device ID 0x%02x\n", id);
> > =C2=A0
> > @@ -193,7 +288,7 @@ static int adp5585_i2c_probe(struct i2c_client *i2c=
)
> > =C2=A0	if (ret)
> > =C2=A0		return ret;
> > =C2=A0
> > -	return adp5585_add_devices(&i2c->dev);
> > +	return adp5585_add_devices(adp5585);
> > =C2=A0}
> > =C2=A0
> > =C2=A0static int adp5585_suspend(struct device *dev)
> > @@ -233,6 +328,18 @@ static const struct of_device_id adp5585_of_match[=
] =3D {
> > =C2=A0	}, {
> > =C2=A0		.compatible =3D "adi,adp5585-04",
> > =C2=A0		.data =3D (void *)ADP5585_04,
> > +	}, {
> > +		.compatible =3D "adi,adp5589-00",
> > +		.data =3D (void *)ADP5589_00,
> > +	}, {
> > +		.compatible =3D "adi,adp5589-01",
> > +		.data =3D (void *)ADP5589_01,
> > +	}, {
> > +		.compatible =3D "adi,adp5589-02",
> > +		.data =3D (void *)ADP5589_02,
> > +	}, {
> > +		.compatible =3D "adi,adp5589",
> > +		.data =3D (void *)ADP5589_00,
> > =C2=A0	},
> > =C2=A0	{ /* sentinel */ }
> > =C2=A0};
> > diff --git a/include/linux/mfd/adp5585.h b/include/linux/mfd/adp5585.h
> > index
> > 2813b20e638b6e73ef198e43af07ef29ff25f273..40c87981e5a24f8a175cc41e38b14=
95ed9
> > f194e5 100644
> > --- a/include/linux/mfd/adp5585.h
> > +++ b/include/linux/mfd/adp5585.h
> > @@ -117,6 +117,12 @@
> > =C2=A0#define ADP5585_BANK(n)			((n) >=3D 6 ? 1 : 0)
> > =C2=A0#define ADP5585_BIT(n)			((n) >=3D 6 ? BIT((n) - 6) : BIT(n))
> > =C2=A0
> > +/* ADP5589 */
> > +#define		ADP5589_MAN_ID_VALUE		0x10
> > +#define ADP5589_GPI_STATUS_C		0x18
> > +#define ADP5589_INT_EN			0x4e
> > +#define ADP5589_MAX_REG			ADP5589_INT_EN
> > +
> > =C2=A0struct regmap;
> > =C2=A0
> > =C2=A0enum adp5585_variant {
> > @@ -125,12 +131,17 @@ enum adp5585_variant {
> > =C2=A0	ADP5585_02,
> > =C2=A0	ADP5585_03,
> > =C2=A0	ADP5585_04,
> > +	ADP5589_00,
> > +	ADP5589_01,
> > +	ADP5589_02,
> > =C2=A0	ADP5585_MAX
> > =C2=A0};
> > =C2=A0
> > =C2=A0struct adp5585_dev {
> > =C2=A0	struct regmap *regmap;
> > +	struct device *dev;
>=20
> Can you pop this at the top please.
>=20
> It has a higher standing (in my own head *twitch*) than regmap.

Sure.

>=20
> > =C2=A0	enum adp5585_variant variant;
> > +	unsigned int id;
> > =C2=A0};
> > =C2=A0
> > =C2=A0#endif
> >=20
> > --=20
> > 2.49.0
> >=20
> >=20

