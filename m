Return-Path: <linux-pwm+bounces-5961-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E190AB58CD
	for <lists+linux-pwm@lfdr.de>; Tue, 13 May 2025 17:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 974A2189B24E
	for <lists+linux-pwm@lfdr.de>; Tue, 13 May 2025 15:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5A52BE7A3;
	Tue, 13 May 2025 15:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Syqps0pO"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3502BE117;
	Tue, 13 May 2025 15:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747150674; cv=none; b=Q8jyQ7aqBSVHzmGn5C878k0dlzfAnLqdUBRaFozBbdCjmCvk2MTziP3845Fjumw6XHz5HsfwfLJGlJO4UIYb7n9cSiZ3p8KDXS326E3qQsbk8+1N80O1E34TkZu1VgQDcG7pJPdoWz8M0rh3mLhr7smPDvBBl9VRp9iwd5Aguv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747150674; c=relaxed/simple;
	bh=5l2doDToLEPmdZE7AuxpWPXbwx5alOhIjqLBE27TJ2A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xcv83MuTQqD2uKPdSXNNUY8IDpzXFIGMaLnxbgSQFxX5x3bbdDVC2OVnr4KB/pW/cbnmnVmCcBbVbKpJ7Lcf/NP3n5GwPK+fcTerqJx+ESCYwGhCUBihtOjTxgzvzm4kItzQSwP7ckCzeLS5cQMdP5fLR3uBMfSxQi1GETLGYFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Syqps0pO; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso57523605e9.2;
        Tue, 13 May 2025 08:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747150671; x=1747755471; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kgzuDoSyIyXB7kCkiVQDi/YeomQIU9vE514Tli0g7N4=;
        b=Syqps0pO7HvebDK/En4AxXnYZpZxchuGc7iVMLMe+WGNuLWCzCmmHWkhDff4qtpSld
         hbCrs831X/bkhCXldhl3n8kE+PeukcHND+DQEwXD4QWTMq4y/IvwN76Bpfm9UGIf1faj
         /rQba72kba6ISZy5ymKDmN6tQhPZiDx0KMXW1G6zEJnc3WYQ6iqqy/k9jl4nXVd22m1l
         8rbg3xn8eG2lNsCp3lGbmk2q4RDjliOwKhNJs1FuZ37Q5gpeu0TeWhCG5xEQ3ivixhmU
         ZoHf3mUI1YH5Dp7Y/zXSZjl2qapSovZUmYYKEgJobdpNpR0fLXBgDnBUxB64H1vTb19B
         JKWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747150671; x=1747755471;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kgzuDoSyIyXB7kCkiVQDi/YeomQIU9vE514Tli0g7N4=;
        b=KWZur7ebDdi7DhWxx7K5W0cCQDiR14f/tGf4DR7hYw/ia6rFwZI66PLVkux9oIlG10
         /p4V5Y7PSRV5xju438HYBwiG+NlWsXXCvD3+62OrSRul3JQqBtFB2oyXgEJsDJddb3Ic
         p8UNw1p/x++74mp2WowJc3RafgVOv+1x92k2QTTH0W4s3bP3nWJQvz2bqa2COdwe/NXE
         BZK5/XVyzjda2twYVlYzbTMuAQXbF33OqnUf1p3SmrOIu7vt9kWbGXzXKNxvIuRhhid9
         +fAs66vk3yYC3yYBHPJ2ZQHmuilHOeSvFMV5rbNBa17s+JGsBHBOrSPfbVN7oPIjKWv8
         hDSw==
X-Forwarded-Encrypted: i=1; AJvYcCUdO7cZkKguq3gRRHde8S+JwVupCi0iX/1sU/CJtoSe9tzA9Ch8V0krE9qsTenQ6FG8hS9BCzPvp6XZ@vger.kernel.org, AJvYcCV8l+rnGSUV1HNSgRoOwEQ2azxvrttPttDtfptYpIzvkDH2kqMuHiSUqo5twbZnTfDqkeFVenCl6EeJhAE=@vger.kernel.org, AJvYcCVsRqpl+1LkczB1YobEMiIU9osSdXPHCgCqUlNVNj7XsxX/90MW/QF32HBUJ9PM8e1h+XvnSQL6Jwlb@vger.kernel.org, AJvYcCW81SXi3NSaYs85gkWVk0ZZHbUOmUuCND480EbpkYrTY5rtnVBkwZ3ltUcobP7qkcXOawLnUw91B6HU7g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzOgPZg2vHrrzTNE91/ueHWRtB7jAWztHrkLKOn6dGEh50+8PF8
	LXskI2ctcx6PjdMve2MS6AuqyeswrOyHfmUEYJYIPeNbnkyZugvD
X-Gm-Gg: ASbGnctIpRcumUmRvZOZQ8zbcTv3h36XEL/sQ19UnTOkB5I3I5CegIgvYYFyjxHcqkT
	fkRB3SfbD0QcdpgHenX6w7IDkFxAA+ZJB3wLO6AJZuZUiymdOZylZw/EWAnGjTDuDgfH6M4O7zH
	yRY58idnPmkonptSnTXv37+QDJy4E30skcU3OFMvxafu3W+U4C0TqeGicj686pqD2gEZ/0V3Mfl
	NqAP6itCg9sb8/QOHJ8c3WFDUuxUpl3EHYZ9NPERDcIAWJRRzmb3wUaO7/lEmua+YSL2OML17CW
	S+2zyJZY3MreWkjaNEO2GTMKMe3PIkyi6+nCQqudG2EteLjy+KJJ
X-Google-Smtp-Source: AGHT+IEVpQTObPQfTvA/sEQnGHZu0TiEGwPKyE/muFlvNFf3K68hZXnEPIBXhBi5DVlzBTnA2ngkPQ==
X-Received: by 2002:a05:600c:384e:b0:43c:fe9f:ab90 with SMTP id 5b1f17b1804b1-442d6ddf558mr122837585e9.28.1747150670567;
        Tue, 13 May 2025 08:37:50 -0700 (PDT)
Received: from [10.5.0.2] ([195.158.248.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d67d5c7bsm174421685e9.4.2025.05.13.08.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 08:37:50 -0700 (PDT)
Message-ID: <bbbd7ec7818f9dbcb753e2e47f03fe820489adce.camel@gmail.com>
Subject: Re: [PATCH v3 02/22] mfd: adp5585: only add devices given in FW
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Lee Jones <lee@kernel.org>, nuno.sa@analog.com,
 linux-gpio@vger.kernel.org, 	linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, 	linux-input@vger.kernel.org, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=	
 <ukleinek@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Bartosz
 Golaszewski <brgl@bgdev.pl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Liu Ying <victor.liu@nxp.com>
Date: Tue, 13 May 2025 16:37:49 +0100
In-Reply-To: <20250513151948.GA23592@pendragon.ideasonboard.com>
References: <20250512-dev-adp5589-fw-v3-0-092b14b79a88@analog.com>
	 <20250512-dev-adp5589-fw-v3-2-092b14b79a88@analog.com>
	 <20250513143450.GM2936510@google.com>
	 <8863db9b433d4911abba4480bb6ac59f799ed5c5.camel@gmail.com>
	 <20250513151948.GA23592@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-05-13 at 17:19 +0200, Laurent Pinchart wrote:
> On Tue, May 13, 2025 at 04:02:11PM +0100, Nuno S=C3=A1 wrote:
> > On Tue, 2025-05-13 at 15:34 +0100, Lee Jones wrote:
> > > On Mon, 12 May 2025, Nuno S=C3=A1 via B4 Relay wrote:
> > >=20
> > > > From: Nuno S=C3=A1 <nuno.sa@analog.com>
> > > >=20
> > > > Not all devices (features) of the adp5585 device are mandatory to b=
e
> > > > used in all platforms. Hence, check what's given in FW and dynamica=
lly
> > > > create the mfd_cell array to be given to devm_mfd_add_devices().
> > > >=20
> > > > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > > > ---
> > > > =C2=A0drivers/mfd/adp5585.c | 45 ++++++++++++++++++++++++++++++++++=
+++++++---
> > > > -
> > > > =C2=A01 file changed, 41 insertions(+), 4 deletions(-)
> > > >=20
> > > > diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
> > > > index
> > > > 160e0b38106a6d78f7d4b7c866cb603d96ea673e..02f9e8c1c6a1d8b9516c060e0=
024d6
> > > > 9886
> > > > e9fb7a 100644
> > > > --- a/drivers/mfd/adp5585.c
> > > > +++ b/drivers/mfd/adp5585.c
> > > > @@ -17,7 +17,13 @@
> > > > =C2=A0#include <linux/regmap.h>
> > > > =C2=A0#include <linux/types.h>
> > > > =C2=A0
> > > > -static const struct mfd_cell adp5585_devs[] =3D {
> > > > +enum {
> > > > +	ADP5585_DEV_GPIO,
> > > > +	ADP5585_DEV_PWM,
> > > > +	ADP5585_DEV_MAX
> > > > +};
> > > > +
> > > > +static const struct mfd_cell adp5585_devs[ADP5585_DEV_MAX] =3D {
> > > > =C2=A0	{ .name =3D "adp5585-gpio", },
> > > > =C2=A0	{ .name =3D "adp5585-pwm", },
> > > > =C2=A0};
> > > > @@ -110,12 +116,40 @@ static const struct regmap_config
> > > > adp5585_regmap_configs[] =3D {
> > > > =C2=A0	},
> > > > =C2=A0};
> > > > =C2=A0
> > > > +static int adp5585_parse_fw(struct device *dev, struct adp5585_dev
> > > > *adp5585,
> > > > +			=C2=A0=C2=A0=C2=A0 struct mfd_cell **devs)
> > > > +{
> > > > +	unsigned int has_pwm =3D 0, has_gpio =3D 0, rc =3D 0;
> > > > +
> > > > +	if (device_property_present(dev, "#pwm-cells"))
> > > > +		has_pwm =3D 1;
> > >=20
> > > This is a little sloppy.=C2=A0 Instead of using throwaway local varia=
bles, do
> > > what you're going to do in the if statement.
> >=20
> > Then I would need to realloc my device cells... But as I realized below=
,
> > this is
> > indeed not needed.
> >=20
> > > > +	if (device_property_present(dev, "#gpio-cells"))
> > > > +		has_gpio =3D 1;
> > > > +
> > > > +	if (!has_pwm && !has_gpio)
> > > > +		return -ENODEV;
> > >=20
> > > Are we really dictating which child devices to register based on rand=
om
> > > DT properties?=C2=A0 Why not register them anyway and have them fail =
if the
>=20
> The properties are not random.
>=20
> > > information they need is not available?=C2=A0 Missing / incorrect pro=
perties
> > > usually get a -EINVAL.
> >=20
> > Well, this was something Laurent asked for... In the previous version I=
 was
> > registering all the devices unconditionally.
>=20
> Registering them all means we'll get error messages in the kernel log
> when the corresponding drivers will probe, while nothing is actually
> wrong. That's fairly confusing for the user.
>=20
> In an ideal situation we would have child nodes in DT and only register
> child devices for existing child nodes. Unfortunately the DT bindings
> were not designed that way, so we have to live with the current
> situation.
>=20
> > > > +	*devs =3D devm_kcalloc(dev, has_pwm + has_gpio, sizeof(struct
> > > > mfd_cell),
> > > > +			=C2=A0=C2=A0=C2=A0=C2=A0 GFP_KERNEL);
> > > > +	if (!*devs)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	if (has_pwm)
> > > > +		(*devs)[rc++] =3D adp5585_devs[ADP5585_DEV_PWM];
> > > > +	if (has_gpio)
> > > > +		(*devs)[rc++] =3D adp5585_devs[ADP5585_DEV_GPIO];
> > >=20
> > > Passing around pointers to pointers for allocation (and later, pointe=
r
> > > to functions) is not the way we wish to operate.=C2=A0 See how all of=
 the
> > > other MFD drivers handle selective sub-drivers.
> >=20
> > Any pointer from the top of your head (example driver)? Honestly, I do =
not
> > see
> > this being that bad. Pretty much is a dynamic array of struct mfd_cel b=
ut
> > anyways, no strong feelings
>=20
> I don't find it that bad either. I don't think you should use
> devm_kcalloc() though, as the memory should be freed as soon as it's not
> needed anymore.
>=20

Agreed... Sometimes I do forget we also have __free(kfree) even though I us=
ed it
in the keyboard driver.

> > But... I was actually being very stupid. First I did looked at an API t=
o
> > only
>=20
> Occasionally overseeing a possible solution isn't being stupid. Or at
> least I hope it isn't, otherwise I would be very stupid too.
>=20

I know :)...=20

> > add one mfd device and failed to realize that I can use
> > devm_mfd_add_devices()
> > with n_devs =3D 1
> >=20
> > Nevermind, will refactor in v4
> >=20
> > > > +	return rc;
> > > > +}
> > > > +
> > > > =C2=A0static int adp5585_i2c_probe(struct i2c_client *i2c)
> > > > =C2=A0{
> > > > =C2=A0	const struct regmap_config *regmap_config;
> > > > =C2=A0	struct adp5585_dev *adp5585;
> > > > +	struct mfd_cell *devs;
> > > > =C2=A0	unsigned int id;
> > > > -	int ret;
> > > > +	int ret, n_devs;
> > > > =C2=A0
> > > > =C2=A0	adp5585 =3D devm_kzalloc(&i2c->dev, sizeof(*adp5585),
> > > > GFP_KERNEL);
> > > > =C2=A0	if (!adp5585)
> > > > @@ -138,9 +172,12 @@ static int adp5585_i2c_probe(struct i2c_client
> > > > *i2c)
> > > > =C2=A0		return dev_err_probe(&i2c->dev, -ENODEV,
> > > > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid device ID 0x%02x\n", id=
);
> > > > =C2=A0
> > > > +	n_devs =3D adp5585_parse_fw(&i2c->dev, adp5585, &devs);
> > > > +	if (n_devs < 0)
> > > > +		return n_devs;
> > > > +
> > > > =C2=A0	ret =3D devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_AUTO,
> > > > -				=C2=A0=C2=A0 adp5585_devs,
> > > > ARRAY_SIZE(adp5585_devs),
> > > > -				=C2=A0=C2=A0 NULL, 0, NULL);
> > > > +				=C2=A0=C2=A0 devs, n_devs, NULL, 0, NULL);
> > > > =C2=A0	if (ret)
> > > > =C2=A0		return dev_err_probe(&i2c->dev, ret,
> > > > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to add child devices\n")=
;
> > > >=20

