Return-Path: <linux-pwm+bounces-5953-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E58AB57F2
	for <lists+linux-pwm@lfdr.de>; Tue, 13 May 2025 17:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 076CD862C90
	for <lists+linux-pwm@lfdr.de>; Tue, 13 May 2025 15:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B22A1E5B72;
	Tue, 13 May 2025 15:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OjWMegew"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944271A83E8;
	Tue, 13 May 2025 15:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747148536; cv=none; b=Xq+ui/ygNfK5ggCQnfrZUqTOxmdqRHgNs1kdNw+o3BlkrD53S5oneFEUeirQ/Gm2g9GaKBsUyeung75TcVJy/V1+mPUgbQBBorFhfouNk8DBZIgw2305iTE3ac5nhiVjZJyNR+cRtP3cIyebCuNmRVpgGca7d/DEKMmkicWNnkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747148536; c=relaxed/simple;
	bh=WInLL8WA9vIjI6a7eRJXj/qQBRdU8k7DUO65gKcnXzs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P4en/L5NKJe/cpadniw5EZY3VCF0P4xfleZ6CoRDx+EAEGHdEIYrhowBUlIPusescORW0nSYQYwSkKfV852tVQSbvGWVQ0ha5I+hMAupt8bdc30wP8t+6dg9S4w0s0KTuL7SENcoTwjXWOJTqdBqxf5vKtkvMChwCRgGzB1HdGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OjWMegew; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a0adcc3e54so3512943f8f.1;
        Tue, 13 May 2025 08:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747148533; x=1747753333; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p+OzLkN7UqJiKQOxonaRhxSZwqluN/JbQC6AxIU8wfQ=;
        b=OjWMegewb6SRHp+rx4uDTuA1kqAoay58qJCXf/Lrlzi9YmEeDdn1MPvu4aDgCD8jZB
         VmNTDtJVxYAXoEr3Wn/hMaTXYUqVMFUZzItEMKa6LojJilqHG2EFWAOA5PGr4pQYkC3R
         y53HSH5MuTnSflfygedlRmxOOWdF88AkxviMLuDFfCpn1WnSd5/EDRBFECz7dopkG4eZ
         wTwfYVkkUl79WYrQUMk+BZQsbqptI81q8ag/iK4IefZ8xtXw6GEAWcaJnD7Yd8xsLN36
         3uaPvHeXk5SLegV/u0ExIh+/BzMsK/N/BF5rtlZ0Ta3fR7nfhHyGfIhHnrC9oclRApP9
         aZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747148533; x=1747753333;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p+OzLkN7UqJiKQOxonaRhxSZwqluN/JbQC6AxIU8wfQ=;
        b=mvUouhHy0ZotgosVqAjzx9Hs8EA5Iy/9C+rpbAAWKuf+8L9ZFbjGKdKfTw+hlE4UpG
         IxjdBk36sKsJnpJvNBlHMoVnEJZUaNrVXbiZjW7a8GfBOUNHnmxKtY66Cl3vESv/BsyA
         O40JJ9mH22u6kThRQ/PsgorD2E2zS5ftcVCAauq7/zX1E7wUFtEL28DDBIebpM8e8/TV
         mi/+aDqNo3V+wqwbvjcfjBlrK+9ODOZzQquzpOBj6cfkznftUv/47NG9msI2Hs598B+l
         4TcKZxL3Fv6H8GX1fbvZXX0M0jnBHpe9afGFApiOh7WPOczTJGqmLRWQdYYGTdaaKeD1
         z1TQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQ3V4VaOiTXznFCZu12otL1DBXDxmdvxEZ3URlgXpBwe0VU7/zIydQPRAMDERtU2RkqDJIBGGmEVyE@vger.kernel.org, AJvYcCVX3dmrafOS+zEUl7RiDXhOzQaC+0z9h/NuqkgINbw/84R8N84/+y841kxM0MlzJTIWnPZHoyfx1LYg1gY=@vger.kernel.org, AJvYcCVoBhHtWT6S0OfxovQEJYsRlC45RKZcxrliUoFQbzkVSDzgHVb9MCr39E2IGgu0UpfJIX+lE3t2rJiD@vger.kernel.org
X-Gm-Message-State: AOJu0YwYb7NtUU0lzxqdTaowW5MdwC5oQrVBMTg4n67C0IKUCieBwv0r
	5Ej1mwuEoenIAamXR6jT/L2By+rfGXqTp5m4yCOS3J/uwHbj0lEt
X-Gm-Gg: ASbGncurJmK6XOXkSqwibkTQcFkDHoigVE3jj6GgWo1ba5uGj8aOzdz5Ajb7xk90C/H
	UfnPSuRKCrVwKF36t7hPbSaXxrvAkrGSwL1nZf22tXKc4qJdcmnZJvF9Y/X+rOqm5IscNXpFKUY
	9j/rchXru8YFxMXwkXQfkxILRPBnHeHu+MpnJwPPjwmt2V4IZ5lkovZ7t4Ppc18yaC77p8PmzO9
	30GtpRsaIavGmWY3HdAswvyDg3mc4c+DcxIIec9coXMQjgH8vE7Vjaf2ZWKyIUxZXsFH5o/Rjht
	tSBkDMCnoW2I32D35L7iUrvt0anz4QQmWBonjJn8BSfTegdTlcrW
X-Google-Smtp-Source: AGHT+IEqDtG6ORSOpnz1hH1E5/allMsCMknYWhd3b4CYO4/SXSfG8BHpxF3fH+P/k2Vy1moESrBPYQ==
X-Received: by 2002:a05:6000:2a9:b0:3a0:ad15:440f with SMTP id ffacd0b85a97d-3a1f646d80bmr14552627f8f.8.1747148532591;
        Tue, 13 May 2025 08:02:12 -0700 (PDT)
Received: from [10.5.0.2] ([195.158.248.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a2ce36sm16737956f8f.71.2025.05.13.08.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 08:02:11 -0700 (PDT)
Message-ID: <8863db9b433d4911abba4480bb6ac59f799ed5c5.camel@gmail.com>
Subject: Re: [PATCH v3 02/22] mfd: adp5585: only add devices given in FW
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
Date: Tue, 13 May 2025 16:02:11 +0100
In-Reply-To: <20250513143450.GM2936510@google.com>
References: <20250512-dev-adp5589-fw-v3-0-092b14b79a88@analog.com>
	 <20250512-dev-adp5589-fw-v3-2-092b14b79a88@analog.com>
	 <20250513143450.GM2936510@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-05-13 at 15:34 +0100, Lee Jones wrote:
> On Mon, 12 May 2025, Nuno S=C3=A1 via B4 Relay wrote:
>=20
> > From: Nuno S=C3=A1 <nuno.sa@analog.com>
> >=20
> > Not all devices (features) of the adp5585 device are mandatory to be
> > used in all platforms. Hence, check what's given in FW and dynamically
> > create the mfd_cell array to be given to devm_mfd_add_devices().
> >=20
> > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > ---
> > =C2=A0drivers/mfd/adp5585.c | 45 ++++++++++++++++++++++++++++++++++++++=
+++----
> > =C2=A01 file changed, 41 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
> > index
> > 160e0b38106a6d78f7d4b7c866cb603d96ea673e..02f9e8c1c6a1d8b9516c060e0024d=
69886
> > e9fb7a 100644
> > --- a/drivers/mfd/adp5585.c
> > +++ b/drivers/mfd/adp5585.c
> > @@ -17,7 +17,13 @@
> > =C2=A0#include <linux/regmap.h>
> > =C2=A0#include <linux/types.h>
> > =C2=A0
> > -static const struct mfd_cell adp5585_devs[] =3D {
> > +enum {
> > +	ADP5585_DEV_GPIO,
> > +	ADP5585_DEV_PWM,
> > +	ADP5585_DEV_MAX
> > +};
> > +
> > +static const struct mfd_cell adp5585_devs[ADP5585_DEV_MAX] =3D {
> > =C2=A0	{ .name =3D "adp5585-gpio", },
> > =C2=A0	{ .name =3D "adp5585-pwm", },
> > =C2=A0};
> > @@ -110,12 +116,40 @@ static const struct regmap_config
> > adp5585_regmap_configs[] =3D {
> > =C2=A0	},
> > =C2=A0};
> > =C2=A0
> > +static int adp5585_parse_fw(struct device *dev, struct adp5585_dev
> > *adp5585,
> > +			=C2=A0=C2=A0=C2=A0 struct mfd_cell **devs)
> > +{
> > +	unsigned int has_pwm =3D 0, has_gpio =3D 0, rc =3D 0;
> > +
> > +	if (device_property_present(dev, "#pwm-cells"))
> > +		has_pwm =3D 1;
>=20
> This is a little sloppy.=C2=A0 Instead of using throwaway local variables=
, do
> what you're going to do in the if statement.
>=20

Then I would need to realloc my device cells... But as I realized below, th=
is is
indeed not needed.

> > +	if (device_property_present(dev, "#gpio-cells"))
> > +		has_gpio =3D 1;
> > +
> > +	if (!has_pwm && !has_gpio)
> > +		return -ENODEV;
>=20
> Are we really dictating which child devices to register based on random
> DT properties?=C2=A0 Why not register them anyway and have them fail if t=
he
> information they need is not available?=C2=A0 Missing / incorrect propert=
ies
> usually get a -EINVAL.

Well, this was something Laurent asked for... In the previous version I was
registering all the devices unconditionally.
=20
>=20
> > +	*devs =3D devm_kcalloc(dev, has_pwm + has_gpio, sizeof(struct
> > mfd_cell),
> > +			=C2=A0=C2=A0=C2=A0=C2=A0 GFP_KERNEL);
> > +	if (!*devs)
> > +		return -ENOMEM;
> > +
> > +	if (has_pwm)
> > +		(*devs)[rc++] =3D adp5585_devs[ADP5585_DEV_PWM];
> > +	if (has_gpio)
> > +		(*devs)[rc++] =3D adp5585_devs[ADP5585_DEV_GPIO];
>=20
> Passing around pointers to pointers for allocation (and later, pointer
> to functions) is not the way we wish to operate.=C2=A0 See how all of the
> other MFD drivers handle selective sub-drivers.

Any pointer from the top of your head (example driver)? Honestly, I do not =
see
this being that bad. Pretty much is a dynamic array of struct mfd_cel but
anyways, no strong feelings

But... I was actually being very stupid. First I did looked at an API to on=
ly
add one mfd device and failed to realize that I can use devm_mfd_add_device=
s()
with n_devs =3D 1

Nevermind, will refactor in v4

>=20
> > +	return rc;
> > +}
> > +
> > =C2=A0static int adp5585_i2c_probe(struct i2c_client *i2c)
> > =C2=A0{
> > =C2=A0	const struct regmap_config *regmap_config;
> > =C2=A0	struct adp5585_dev *adp5585;
> > +	struct mfd_cell *devs;
> > =C2=A0	unsigned int id;
> > -	int ret;
> > +	int ret, n_devs;
> > =C2=A0
> > =C2=A0	adp5585 =3D devm_kzalloc(&i2c->dev, sizeof(*adp5585), GFP_KERNEL=
);
> > =C2=A0	if (!adp5585)
> > @@ -138,9 +172,12 @@ static int adp5585_i2c_probe(struct i2c_client *i2=
c)
> > =C2=A0		return dev_err_probe(&i2c->dev, -ENODEV,
> > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid device ID 0x%02x\n", id);
> > =C2=A0
> > +	n_devs =3D adp5585_parse_fw(&i2c->dev, adp5585, &devs);
> > +	if (n_devs < 0)
> > +		return n_devs;
> > +
> > =C2=A0	ret =3D devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_AUTO,
> > -				=C2=A0=C2=A0 adp5585_devs, ARRAY_SIZE(adp5585_devs),
> > -				=C2=A0=C2=A0 NULL, 0, NULL);
> > +				=C2=A0=C2=A0 devs, n_devs, NULL, 0, NULL);
> > =C2=A0	if (ret)
> > =C2=A0		return dev_err_probe(&i2c->dev, ret,
> > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to add child devices\n");
> >=20
> > --=20
> > 2.49.0
> >=20
> >=20

