Return-Path: <linux-pwm+bounces-5620-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F69BA950C4
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Apr 2025 14:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE2603B2FB2
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Apr 2025 12:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D769E264638;
	Mon, 21 Apr 2025 12:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOQbM8Xk"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2C313212A;
	Mon, 21 Apr 2025 12:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745238070; cv=none; b=n/TBgOXqTGM8NV6fSxT96W6c2mQg4D8WxbjKduNzRi9WKb2uJcSBzrgeEPKUgfdnGYRhADRsICiDF+MtOIjaYScJmCaiDCOmzKShP/Qcn3DqfnuMCCCEexLFaHX8qzArmjm84TUFzESYFm/ZXt+Ez6mMbsOJMDNWROzhcSkmOAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745238070; c=relaxed/simple;
	bh=FOeXhkkVgbW9taSLiMsmkyXlWH9oHpVRMuwNxquXCWw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NG+YVwX5hlwxtp0BpFS6+5pAv2vwoR2dfA12kjeQkW1DdIPiifyA2SGzxcGyyGGXwkDO7BYgoh0rDZDty17cQYyusaBHD1xD0Vqx94TIZFQHOk96X4OJfKFlHUHnhb5MKyTQwnzUFkUrqxb0dl4mbZynaHoMAJFSWj9QK0CISuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OOQbM8Xk; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-39ee5ac4321so4158376f8f.1;
        Mon, 21 Apr 2025 05:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745238067; x=1745842867; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I305Krk8QG350ocyLsdwoASX0Z32CoLXWq9VyLahcUo=;
        b=OOQbM8XkuXONZ82a2wEn5m6O2Hx/PbTpx2Zrx/yqHpyXMYcGUkJ+/d7HJ6N8bScfCn
         JWnB/QX9XAMCibU7cvqLNRzlKWpvG88E623bMsL0ESREZ70XXRpHm5j4pvdHz0QQNAaV
         uaF1LAYSd2eaICZtPQyoND6NzrM0ZTr/nVEpTmxdjaDXLXAcHz0VjzEsyH5wUfT2tyzb
         Fa0VoU1+5ty5Rs8TNN8ygKicmIDDd2AZn4g3dkIB9yQRXNv9Ft9YVYiZRpinhnGN23yc
         WlsI+ng6jhVzl9BRU6mwhEVzxm3yJBN5dzNQ21edHKuJT8bsYWjWjNYS+3fTDSm7E8x6
         +Eqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745238067; x=1745842867;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I305Krk8QG350ocyLsdwoASX0Z32CoLXWq9VyLahcUo=;
        b=ZOjOwacFSUAohhV0W3cfGzFhqQAbxZ7FzksSYsyzVRm9MphW43T0FkVgK3c1lFh8d9
         JIu4uspLfd3qzhIzP/h7E5IzmcUVc4JBQB6OxR9UiXKikD9FFb+F6gPr0SDr4IY2Qrbq
         TZHnpbXCO9XGZrK1Zs83k1ioDLxYVfcGJu4/UbCqsWDWiARuwnRlcJ+/6evIDZVT474s
         ZGLHjApm8GXe+ZjKyQU4a27i5pkeG1h/vylXXnsvhQXMlr/Vm6sdStMxrzT1in5R5trP
         j55ObCI8ks7sYGt+ruzKGArTYJp4BX7UMW6M+GH8VcTwjIGA7XGC+08X8IgTcj+LdTR8
         ypTg==
X-Forwarded-Encrypted: i=1; AJvYcCUDKtQsuXSUrhLxJKQ81o86FeOJqd1eavne0kOV0kwiNngAGw1qRFxz61b/RPK0MlPLhAXiQ2JKfBLl@vger.kernel.org, AJvYcCVDz+fasciU38XoaUuYL5cyrfk9WZ9Yy70PymPKkb8N34xwLPjXUscAQ8L3UszNZ5U37OluWK2KBVtmijU=@vger.kernel.org, AJvYcCWZWqpD7j3hxqmsMp62eDVwojird+ct4gnEQQHg3NYUi5jqnqEZ39a2yHpd3WDVGfxMNyCzdISyWodB@vger.kernel.org
X-Gm-Message-State: AOJu0YwJN6Qhw6vcvMRs8tuuMCMW7dLYpbGMsAyyJtg4B80BqGuJvMpK
	bx5kqozLFiBcmWE7uyzY3l+rayfWCZbyNBpVSWfehtH1f92VOwot
X-Gm-Gg: ASbGncv9p5vAhxutn56+0jU+8BHh8/gP/gX7dXFHc7ZwCuYC1YSspeHsgQjNYonfmZw
	GplRi/xYzecR064EvPVxu0Sa81IfIKTUTi/sE5xLn7JQ/wBr33efUOMSr9KB+rGdi15H5QrXIQz
	ZUrWoHB6hSNbwNgvmfqqBLH+XpMbKFtF6Bm0CTaC9tDjORVvF0XF2sFZQi4tmHi28zxJvxARNWg
	ovhE+YV4XUo46mUHMKQ3dyz1foMqcmLsvo0DBcHo+zZBuHxc+5tHO2DDClfmOVsBAIeq32Ryprq
	XD1VfFuv90mw8kFVLN1kcg+c9RLPvqM1iz1JiKVmxiZ3+5VQioo6Hpvg77mucyyW8Dw+pDEx9m8
	7bsbUVmdA15fN
X-Google-Smtp-Source: AGHT+IESwOPHjM8O1YZ5lCX8ZyGWZCiNwtt+nEmXof5SDgHSfOI/0OBlD9OJSniVhnkb3pF+82Xsmw==
X-Received: by 2002:a05:6000:2903:b0:39c:30d9:3b5c with SMTP id ffacd0b85a97d-39efbad53f0mr9081654f8f.39.1745238066620;
        Mon, 21 Apr 2025 05:21:06 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d6dfe2esm133591175e9.34.2025.04.21.05.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 05:21:05 -0700 (PDT)
Message-ID: <36b161e08547dc2d5abd36340c596e2147d82ce7.camel@gmail.com>
Subject: Re: [PATCH v2 06/17] mfd: adp5585: add support for adp5589
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, nuno.sa@analog.com
Cc: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, Lee Jones
 <lee@kernel.org>,  Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,  Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?=	 <ukleinek@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Dmitry
 Torokhov <dmitry.torokhov@gmail.com>, Liu Ying <victor.liu@nxp.com>
Date: Mon, 21 Apr 2025 13:21:08 +0100
In-Reply-To: <20250421091559.GE29968@pendragon.ideasonboard.com>
References: <20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com>
	 <20250415-dev-adp5589-fw-v2-6-3a799c3ed812@analog.com>
	 <20250421091559.GE29968@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-04-21 at 12:15 +0300, Laurent Pinchart wrote:
> Hi Nuno,
>=20
> Thank you for the patch.
>=20
> On Tue, Apr 15, 2025 at 03:49:22PM +0100, Nuno S=C3=A1 via B4 Relay wrote=
:
> > From: Nuno S=C3=A1 <nuno.sa@analog.com>
> >=20
> > The ADP5589 is a 19 I/O port expander with built-in keypad matrix decod=
er,
> > programmable logic, reset generator, and PWM generator.
> >=20
> > This patch adds the foundation to add support for the adp5589 gpio and =
pwm
> > drivers. Most importantly, we need to differentiate between some
> > registers addresses. It also hints to future keymap support.
>=20
> Please split this in two patches, one that reworks the driver to support
> different register addresses, and one that adds adp5589 support.
>=20
> > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > ---
> > =C2=A0drivers/mfd/adp5585.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 223
> > +++++++++++++++++++++++++++++++++++++++++---
> > =C2=A0include/linux/mfd/adp5585.h |=C2=A0 57 ++++++++++-
> > =C2=A02 files changed, 268 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
> > index
> > fafe3ad93ea196e1eb8e79fecba58f36f12167eb..c3586c0d6aa2e7e7d946679934106=
10be7
> > fc3672 100644
> > --- a/drivers/mfd/adp5585.c
> > +++ b/drivers/mfd/adp5585.c
> > @@ -25,6 +25,13 @@ static const struct mfd_cell adp5585_devs[] =3D {
> > =C2=A0
> > =C2=A0};
> > =C2=A0
> > +static const struct mfd_cell adp5589_devs[] =3D {
> > +	MFD_CELL_NAME("adp5589-keys"),
> > +	MFD_CELL_NAME("adp5589-gpio"),
> > +	MFD_CELL_NAME("adp5589-pwm"),
> > +
> > +};
> > +
> > =C2=A0static const struct regmap_range adp5585_volatile_ranges[] =3D {
> > =C2=A0	regmap_reg_range(ADP5585_ID, ADP5585_GPI_STATUS_B),
> > =C2=A0};
> > @@ -34,6 +41,15 @@ static const struct regmap_access_table
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
> > @@ -77,10 +93,52 @@ static const u8
> > adp5585_regmap_defaults_04[ADP5585_MAX_REG + 1] =3D {
> > =C2=A0	/* 0x38 */ 0x00, 0x00, 0x00, 0x00, 0x00,
> > =C2=A0};
> > =C2=A0
> > +static const u8 adp5589_regmap_defaults_00[ADP5589_MAX_REG + 1] =3D {
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
> > =C2=A0enum adp5585_regmap_type {
> > =C2=A0	ADP5585_REGMAP_00,
> > =C2=A0	ADP5585_REGMAP_02,
> > =C2=A0	ADP5585_REGMAP_04,
> > +	ADP5589_REGMAP_00,
> > +	ADP5589_REGMAP_01,
> > +	ADP5589_REGMAP_02,
> > =C2=A0};
> > =C2=A0
> > =C2=A0static const struct regmap_config adp5585_regmap_configs[] =3D {
> > @@ -111,6 +169,131 @@ static const struct regmap_config
> > adp5585_regmap_configs[] =3D {
> > =C2=A0		.reg_defaults_raw =3D adp5585_regmap_defaults_04,
> > =C2=A0		.num_reg_defaults_raw =3D sizeof(adp5585_regmap_defaults_04),
> > =C2=A0	},
> > +	[ADP5589_REGMAP_00] =3D {
> > +		.reg_bits =3D 8,
> > +		.val_bits =3D 8,
> > +		.max_register =3D ADP5589_MAX_REG,
> > +		.volatile_table =3D &adp5589_volatile_regs,
> > +		.cache_type =3D REGCACHE_MAPLE,
> > +		.reg_defaults_raw =3D adp5589_regmap_defaults_00,
> > +		.num_reg_defaults_raw =3D sizeof(adp5589_regmap_defaults_00),
> > +	},
> > +	[ADP5589_REGMAP_01] =3D {
> > +		.reg_bits =3D 8,
> > +		.val_bits =3D 8,
> > +		.max_register =3D ADP5589_MAX_REG,
> > +		.volatile_table =3D &adp5589_volatile_regs,
> > +		.cache_type =3D REGCACHE_MAPLE,
> > +		.reg_defaults_raw =3D adp5589_regmap_defaults_01,
> > +		.num_reg_defaults_raw =3D sizeof(adp5589_regmap_defaults_01),
> > +	},
> > +	[ADP5589_REGMAP_02] =3D {
> > +		.reg_bits =3D 8,
> > +		.val_bits =3D 8,
> > +		.max_register =3D ADP5589_MAX_REG,
> > +		.volatile_table =3D &adp5589_volatile_regs,
> > +		.cache_type =3D REGCACHE_MAPLE,
> > +		.reg_defaults_raw =3D adp5589_regmap_defaults_02,
> > +		.num_reg_defaults_raw =3D sizeof(adp5589_regmap_defaults_02),
> > +	},
> > +};
> > +
> > +static const struct adp5585_regs adp5585_regs =3D {
> > +	.debounce_dis_a =3D ADP5585_DEBOUNCE_DIS_A,
> > +	.rpull_cfg_a =3D ADP5585_RPULL_CONFIG_A,
> > +	.gpo_data_a =3D ADP5585_GPO_DATA_OUT_A,
> > +	.gpo_out_a =3D ADP5585_GPO_OUT_MODE_A,
> > +	.gpio_dir_a =3D ADP5585_GPIO_DIRECTION_A,
> > +	.gpi_stat_a =3D ADP5585_GPI_STATUS_A,
> > +	.pwm_cfg =3D ADP5585_PWM_CFG,
> > +	.pwm_offt_low =3D ADP5585_PWM_OFFT_LOW,
> > +	.pwm_ont_low =3D ADP5585_PWM_ONT_LOW,
> > +	.gen_cfg =3D ADP5585_GENERAL_CFG,
> > +	.ext_cfg =3D ADP5585_PIN_CONFIG_C,
> > +};
>=20
> Why does this need to be stored in this driver, and not in the drivers
> for the gpio and pwm cells ? If the kernel is compiled without e.g. the
> adp5585-pwm driver, we shouldn't waste memory here by adding data that
> only the adp5585-pwm driver needs.
>=20

I don't really think the memory we would save to be that relevant but I can
better separate things. I guess i went like this because there's some share=
d
variables that will have to be in the top level structs and I did not wante=
d to
have a "global" and "local" regs thingy...

- Nuno S=C3=A1

> > +
> > +static const struct adp5585_regs adp5589_regs =3D {
> > +	.debounce_dis_a =3D ADP5589_DEBOUNCE_DIS_A,
> > +	.rpull_cfg_a =3D ADP5589_RPULL_CONFIG_A,
> > +	.gpo_data_a =3D ADP5589_GPO_DATA_OUT_A,
> > +	.gpo_out_a =3D ADP5589_GPO_OUT_MODE_A,
> > +	.gpio_dir_a =3D ADP5589_GPIO_DIRECTION_A,
> > +	.gpi_stat_a =3D ADP5589_GPI_STATUS_A,
> > +	.pwm_cfg =3D ADP5589_PWM_CFG,
> > +	.pwm_offt_low =3D ADP5589_PWM_OFFT_LOW,
> > +	.pwm_ont_low =3D ADP5589_PWM_ONT_LOW,
> > +	.gen_cfg =3D ADP5589_GENERAL_CFG,
> > +	.ext_cfg =3D ADP5589_PIN_CONFIG_D,
> > +};
> > +
> > +static const struct adp5585_info adp5585_info =3D {
> > +	.adp5585_devs =3D adp5585_devs,
> > +	.regmap_config =3D &adp5585_regmap_configs[ADP5585_REGMAP_00],
> > +	.n_devs =3D ARRAY_SIZE(adp5585_devs),
> > +	.id =3D ADP5585_MAN_ID_VALUE,
> > +	.regs =3D &adp5585_regs,
> > +	.max_rows =3D ADP5585_MAX_ROW_NUM,
> > +	.max_cols =3D ADP5585_MAX_COL_NUM,
>=20
> Same here, the max_rows and max_cols fields don't seem to belong to this
> driver.
>=20
> > +};
> > +
> > +static const struct adp5585_info adp5585_01_info =3D {
> > +	.adp5585_devs =3D adp5585_devs,
> > +	.regmap_config =3D &adp5585_regmap_configs[ADP5585_REGMAP_00],
> > +	.n_devs =3D ARRAY_SIZE(adp5585_devs),
> > +	.id =3D ADP5585_MAN_ID_VALUE,
> > +	.regs =3D &adp5585_regs,
> > +	.max_rows =3D ADP5585_MAX_ROW_NUM,
> > +	.max_cols =3D ADP5585_MAX_COL_NUM,
> > +};
> > +
> > +static const struct adp5585_info adp5585_02_info =3D {
> > +	.adp5585_devs =3D adp5585_devs,
> > +	.regmap_config =3D &adp5585_regmap_configs[ADP5585_REGMAP_02],
> > +	.n_devs =3D ARRAY_SIZE(adp5585_devs),
> > +	.id =3D ADP5585_MAN_ID_VALUE,
> > +	.regs =3D &adp5585_regs,
> > +	.max_rows =3D ADP5585_MAX_ROW_NUM,
> > +	.max_cols =3D ADP5585_MAX_COL_NUM,
> > +};
> > +
> > +static const struct adp5585_info adp5585_04_info =3D {
> > +	.adp5585_devs =3D adp5585_devs,
> > +	.regmap_config =3D &adp5585_regmap_configs[ADP5585_REGMAP_04],
> > +	.n_devs =3D ARRAY_SIZE(adp5585_devs),
> > +	.id =3D ADP5585_MAN_ID_VALUE,
> > +	.regs =3D &adp5585_regs,
> > +	.max_rows =3D ADP5585_MAX_ROW_NUM,
> > +	.max_cols =3D ADP5585_MAX_COL_NUM,
> > +};
> > +
> > +static const struct adp5585_info adp5589_info =3D {
> > +	.adp5585_devs =3D adp5589_devs,
> > +	.regmap_config =3D &adp5585_regmap_configs[ADP5589_REGMAP_00],
> > +	.n_devs =3D ARRAY_SIZE(adp5589_devs),
> > +	.id =3D ADP5589_MAN_ID_VALUE,
> > +	.regs =3D &adp5589_regs,
> > +	.max_rows =3D ADP5589_MAX_ROW_NUM,
> > +	.max_cols =3D ADP5589_MAX_COL_NUM,
> > +};
> > +
> > +static const struct adp5585_info adp5589_01_info =3D {
> > +	.adp5585_devs =3D adp5589_devs,
> > +	.regmap_config =3D &adp5585_regmap_configs[ADP5589_REGMAP_01],
> > +	.n_devs =3D ARRAY_SIZE(adp5589_devs),
> > +	.id =3D ADP5589_MAN_ID_VALUE,
> > +	.regs =3D &adp5589_regs,
> > +	.max_rows =3D ADP5589_MAX_ROW_NUM,
> > +	.max_cols =3D ADP5589_MAX_COL_NUM,
> > +};
> > +
> > +static const struct adp5585_info adp5589_02_info =3D {
> > +	.adp5585_devs =3D adp5589_devs,
> > +	.regmap_config =3D &adp5585_regmap_configs[ADP5589_REGMAP_02],
> > +	.n_devs =3D ARRAY_SIZE(adp5589_devs),
> > +	.id =3D ADP5589_MAN_ID_VALUE,
> > +	.regs =3D &adp5589_regs,
> > +	.max_rows =3D ADP5589_MAX_ROW_NUM,
> > +	.max_cols =3D ADP5589_MAX_COL_NUM,
> > =C2=A0};
> > =C2=A0
> > =C2=A0static void adp5585_osc_disable(void *data)
> > @@ -122,7 +305,7 @@ static void adp5585_osc_disable(void *data)
> > =C2=A0
> > =C2=A0static int adp5585_i2c_probe(struct i2c_client *i2c)
> > =C2=A0{
> > -	const struct regmap_config *regmap_config;
> > +	const struct adp5585_info *info;
> > =C2=A0	struct adp5585_dev *adp5585;
> > =C2=A0	unsigned int id;
> > =C2=A0	int ret;
> > @@ -133,8 +316,13 @@ static int adp5585_i2c_probe(struct i2c_client *i2=
c)
> > =C2=A0
> > =C2=A0	i2c_set_clientdata(i2c, adp5585);
> > =C2=A0
> > -	regmap_config =3D i2c_get_match_data(i2c);
> > -	adp5585->regmap =3D devm_regmap_init_i2c(i2c, regmap_config);
> > +	info =3D i2c_get_match_data(i2c);
> > +	if (!info)
> > +		return -ENODEV;
>=20
> Can this happen ?
>=20
> > +
> > +	adp5585->info =3D info;
>=20
> Drop the local info variable and assign the value to adp5585->info
> directly.
>=20
> > +
> > +	adp5585->regmap =3D devm_regmap_init_i2c(i2c, info->regmap_config);
> > =C2=A0	if (IS_ERR(adp5585->regmap))
> > =C2=A0		return dev_err_probe(&i2c->dev, PTR_ERR(adp5585->regmap),
> > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to initialize register
> > map\n");
> > @@ -144,7 +332,8 @@ static int adp5585_i2c_probe(struct i2c_client *i2c=
)
> > =C2=A0		return dev_err_probe(&i2c->dev, ret,
> > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to read device ID\n");
> > =C2=A0
> > -	if ((id & ADP5585_MAN_ID_MASK) !=3D ADP5585_MAN_ID_VALUE)
> > +	id &=3D ADP5585_MAN_ID_MASK;
> > +	if (id !=3D adp5585->info->id)
> > =C2=A0		return dev_err_probe(&i2c->dev, -ENODEV,
> > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid device ID 0x%02x\n", id);
> > =C2=A0
> > @@ -158,8 +347,8 @@ static int adp5585_i2c_probe(struct i2c_client *i2c=
)
> > =C2=A0		return ret;
> > =C2=A0
> > =C2=A0	ret =3D devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_AUTO,
> > -				=C2=A0=C2=A0 adp5585_devs, ARRAY_SIZE(adp5585_devs),
> > -				=C2=A0=C2=A0 NULL, 0, NULL);
> > +				=C2=A0=C2=A0 adp5585->info->adp5585_devs,
> > +				=C2=A0=C2=A0 adp5585->info->n_devs, NULL, 0, NULL);
> > =C2=A0	if (ret)
> > =C2=A0		return dev_err_probe(&i2c->dev, ret,
> > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to add child devices\n");
> > @@ -191,19 +380,31 @@ static DEFINE_SIMPLE_DEV_PM_OPS(adp5585_pm,
> > adp5585_suspend, adp5585_resume);
> > =C2=A0static const struct of_device_id adp5585_of_match[] =3D {
> > =C2=A0	{
> > =C2=A0		.compatible =3D "adi,adp5585-00",
> > -		.data =3D &adp5585_regmap_configs[ADP5585_REGMAP_00],
> > +		.data =3D &adp5585_info,
> > =C2=A0	}, {
> > =C2=A0		.compatible =3D "adi,adp5585-01",
> > -		.data =3D &adp5585_regmap_configs[ADP5585_REGMAP_00],
> > +		.data =3D &adp5585_01_info,
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
> > +	}, {
> > +		.compatible =3D "adi,adp5589-00",
> > +		.data =3D &adp5589_info,
> > +	}, {
> > +		.compatible =3D "adi,adp5589-01",
> > +		.data =3D &adp5589_01_info,
> > +	}, {
> > +		.compatible =3D "adi,adp5589-02",
> > +		.data =3D &adp5589_02_info,
> > +	}, {
> > +		.compatible =3D "adi,adp5589",
> > +		.data =3D &adp5589_info,
> > =C2=A0	},
> > =C2=A0	{ /* sentinel */ }
> > =C2=A0};
> > diff --git a/include/linux/mfd/adp5585.h b/include/linux/mfd/adp5585.h
> > index
> > 016033cd68e46757aca86d21dd37025fd354b801..dffe1449de01dacf8fe78cf0e87d1=
f176d
> > 11f620 100644
> > --- a/include/linux/mfd/adp5585.h
> > +++ b/include/linux/mfd/adp5585.h
> > @@ -104,9 +104,11 @@
> > =C2=A0#define		ADP5585_INT_CFG			BIT(1)
> > =C2=A0#define		ADP5585_RST_CFG			BIT(0)
> > =C2=A0#define ADP5585_INT_EN			0x3c
> > -
> > =C2=A0#define ADP5585_MAX_REG			ADP5585_INT_EN
> > =C2=A0
> > +#define ADP5585_MAX_ROW_NUM		6
> > +#define ADP5585_MAX_COL_NUM		5
> > +
> > =C2=A0/*
> > =C2=A0 * Bank 0 covers pins "GPIO 1/R0" to "GPIO 6/R5", numbered 0 to 5=
 by the
> > =C2=A0 * driver, and bank 1 covers pins "GPIO 7/C0" to "GPIO 11/C4", nu=
mbered 6
> > to
> > @@ -117,10 +119,63 @@
> > =C2=A0#define ADP5585_BANK(n)			((n) >=3D 6 ? 1 : 0)
> > =C2=A0#define ADP5585_BIT(n)			((n) >=3D 6 ? BIT((n) - 6) : BIT(n))
> > =C2=A0
> > +/* ADP5589 */
> > +#define		ADP5589_MAN_ID_VALUE		0x10
> > +#define ADP5589_GPI_STATUS_A		0x16
> > +#define ADP5589_GPI_STATUS_C		0x18
> > +#define ADP5589_RPULL_CONFIG_A		0x19
> > +#define ADP5589_DEBOUNCE_DIS_A		0x27
> > +#define ADP5589_GPO_DATA_OUT_A		0x2a
> > +#define ADP5589_GPO_OUT_MODE_A		0x2d
> > +#define	ADP5589_GPIO_DIRECTION_A	0x30
>=20
> Indentation looks wrong.
>=20
> > +#define ADP5589_PWM_OFFT_LOW		0x3e
> > +#define ADP5589_PWM_ONT_LOW		0x40
> > +#define ADP5589_PWM_CFG			0x42
> > +#define ADP5589_PIN_CONFIG_D		0x4C
> > +#define ADP5589_GENERAL_CFG		0x4d
> > +#define ADP5589_INT_EN			0x4e
> > +#define ADP5589_MAX_REG			ADP5589_INT_EN
> > +
> > +#define ADP5589_MAX_ROW_NUM		8
> > +#define ADP5589_MAX_COL_NUM		11
> > +
> > +/*
> > + * Bank 0 covers pins "GPIO 1/R0" to "GPIO 8/R7", numbered 0 to 7 by t=
he
> > + * driver, bank 1 covers pins "GPIO 9/C0" to "GPIO 16/C7", numbered 8 =
to
> > + * 15 and bank 3 covers pins "GPIO 17/C8" to "GPIO 19/C10", numbered 1=
6 to
> > 18.
> > + */
> > +#define ADP5589_BANK(n)			((n) >> 3)
> > +#define ADP5589_BIT(n)			BIT((n) & 0x7)
> > +
> > +struct adp5585_regs {
> > +	unsigned int debounce_dis_a;
> > +	unsigned int rpull_cfg_a;
> > +	unsigned int gpo_data_a;
> > +	unsigned int gpo_out_a;
> > +	unsigned int gpio_dir_a;
> > +	unsigned int gpi_stat_a;
> > +	unsigned int pwm_cfg;
> > +	unsigned int pwm_offt_low;
> > +	unsigned int pwm_ont_low;
> > +	unsigned int gen_cfg;
> > +	unsigned int ext_cfg;
> > +};
> > +
> > +struct adp5585_info {
> > +	const struct mfd_cell *adp5585_devs;
> > +	const struct regmap_config *regmap_config;
> > +	const struct adp5585_regs *regs;
> > +	unsigned int n_devs;
> > +	unsigned int id;
> > +	u8 max_rows;
> > +	u8 max_cols;
> > +};
> > +
> > =C2=A0struct regmap;
> > =C2=A0
> > =C2=A0struct adp5585_dev {
> > =C2=A0	struct regmap *regmap;
> > +	const struct adp5585_info *info;
> > =C2=A0};
> > =C2=A0
> > =C2=A0#endif

