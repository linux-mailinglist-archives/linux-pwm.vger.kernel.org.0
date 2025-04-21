Return-Path: <linux-pwm+bounces-5619-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E5BA9509E
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Apr 2025 14:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33FC37A4DE5
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Apr 2025 12:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DB826461D;
	Mon, 21 Apr 2025 12:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UN4Q3lvt"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6503F63D;
	Mon, 21 Apr 2025 12:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745237669; cv=none; b=fqousghoX4HqYRkmc4Z04tNheN2fPGQh41XZpF10SSTNiOgYXm4ix4uQ/vDG0+hjUHFPVPf3QXEtj1G9r2S5Sal+vDe+kPTHQv9tRngrhXkKXhVD0IdMIVoh4VTsmTUzGlaTmWWtpE+OIJlSu6tUhX8F28AOmRe5+tF1uvseVCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745237669; c=relaxed/simple;
	bh=C+4nDR37PBplHiy243pObI+HZmUlHSj82kpnexy6gC0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n3Cdb3XI33vWgIhwJl9H4KrUbggIQjbOg+hM+ZF7XkH/9leV62LldKnWOpJUxfJ7kHc2gmA0tipbPm29bjQEY7yw/C+FWs9yTvtibU3gmKNMLqRRRLdowGyc5GxtcOpVRPXb3syZCwDgy4g4yKTEzO0WAB1m1bcCJ6eQstdtXFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UN4Q3lvt; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso38414065e9.2;
        Mon, 21 Apr 2025 05:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745237666; x=1745842466; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=td7Otdot6XjvGZ7Fvxee48NNbQBtzlOar+C+8YoNcyM=;
        b=UN4Q3lvta0fH17wpmLfpXnXmDvWyeTKyxbFdXbI61hFX4dE0MTqDNFYgxpR8bRwmoP
         HxjbPFqCpJF9vCJQwU8dfRsxc2C3aFj4jDxyp3xWqXM/dkN/IvFA2s9O2EtUcegJyTgv
         x7Hbi2sFkBdB2aw31HqxhWQAJGyQ3gWibU5OsGJ8nsjBmLw7M6rohd9Ipu16epVhnY1r
         +/r97x4EUCaVlF/TFYDHgXNW/Kf2Gt7fayzZ7cs811InLvlHiOBQTX+mmrqhUGXR3Hlj
         0s9CTeOziq6mMQCEahI6X3HKRxElW77hrNOGrpg3HXa906xpBLPQp+VJM5awBNwDM3SP
         vfig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745237666; x=1745842466;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=td7Otdot6XjvGZ7Fvxee48NNbQBtzlOar+C+8YoNcyM=;
        b=rIFCgpAvbXJiME3SRbjur9FB6yt7nim1nmWXorBb3rRCLgd2cs9+HueWxF4qGfsQJG
         OeOxdm7XG4FLABah1ZwyVjhSa+MkEVgC4UscQJGcdGNq24LskBvWim+v3mj1pvHLEumx
         njwfIU7eOe4GQjf12L9keW7mQcx43V07/9E5b1uyD3n+VKH+/pP87ow0qTg/ygn+B3cL
         D7foACqL87erAfza9fhZldiUMUTYUwruNKQJJRL2Ow64EPa1k6pRfd3bpq7F85XXVcKy
         tdB42P7P9Nt9qGSwZsUe7wCmBHSbiouLHOTerbssmyXo4Yszz0+kb+pds8sKiHVqmq2H
         /KEg==
X-Forwarded-Encrypted: i=1; AJvYcCUpw+Pq2FN6fl/noFgptc7EuH7Gwbc35BdVkfTbdiGGLK48tkuHKsWVrxEumQSkXOl70K22yLnTwjKv@vger.kernel.org, AJvYcCWsc63xgXz0yqKdDg4pcydGmQkU08LMYs6EX5YPxD53te9uUHrepzgQsZGE24Iy959J2Ki5hHNQMwlpbwY=@vger.kernel.org, AJvYcCX40eU82rx3PwSSpGo6WPbT75j3dQmQMrCpR+R0P6Sme/XhECE2+O1vJMpuZ+lwbZhk9TFh+4E1KKqC@vger.kernel.org
X-Gm-Message-State: AOJu0YySFqCnPSOo2oNfm935Sg7o6daEN+5pknCMwHJGMPjp89/yG2PC
	XyXJo69827Os1lOBQzEM1JLP50fX5jQh3JTZglTi7FOSje7yKyn6
X-Gm-Gg: ASbGncuongZk7azb1HIv3pZYdNB2OrkV09wdVlbTlt/sZJ93uBu/DC2olrvopp1y441
	3dYjmSlOGynZYRVFIKha5wC3JqLrskEe79se6PnB/ZIL/hSNvI9FXHhkG7LknixW0iZA5Qg7XbQ
	O3ihj2drSqNJTCVKvZemzW40Ef/eUWl42FFwS279HwfnRqxtvhL9kC2QAh6ag5D9O5N177n811D
	6UU+H59CYoRk1ueDR7TxfADrUo4TeF2NzIwex0sAyHr6yh77fxTyxCucqeLDAnHRj0tfXywJ8mt
	K5PItZc8Ne8rt2+waxqgaJO0E9JqPF5nzY6UajN2B1ZgDq9fWrT2zbhO5ttF6iBbbaqr72UiUbM
	XeJ83sdOmOvGP
X-Google-Smtp-Source: AGHT+IGKTTGWaHLscW+1KvK2MACnOQGtSPCDDDiEvtoDwRyPDxK1sGOVnp/lBTJoQL4402Wbwr6IQA==
X-Received: by 2002:a05:600c:3b0f:b0:440:6a5f:c308 with SMTP id 5b1f17b1804b1-4406ab96a58mr90348535e9.13.1745237665633;
        Mon, 21 Apr 2025 05:14:25 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d5d6f86sm130943695e9.35.2025.04.21.05.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 05:14:25 -0700 (PDT)
Message-ID: <aadec5eae6645e3e9c2f8f09dcf842510515122f.camel@gmail.com>
Subject: Re: [PATCH v2 02/17] mfd: adp5585: enable oscilator during probe
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, nuno.sa@analog.com
Cc: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, Lee Jones
 <lee@kernel.org>,  Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,  Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?=	 <ukleinek@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Dmitry
 Torokhov <dmitry.torokhov@gmail.com>, Liu Ying <victor.liu@nxp.com>
Date: Mon, 21 Apr 2025 13:14:28 +0100
In-Reply-To: <20250421085758.GB29968@pendragon.ideasonboard.com>
References: <20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com>
	 <20250415-dev-adp5589-fw-v2-2-3a799c3ed812@analog.com>
	 <20250421085758.GB29968@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-04-21 at 11:57 +0300, Laurent Pinchart wrote:
> Hi Nuno,
>=20
> Thank you for the patch.
>=20
> On Tue, Apr 15, 2025 at 03:49:18PM +0100, Nuno S=C3=A1 via B4 Relay wrote=
:
> > From: Nuno S=C3=A1 <nuno.sa@analog.com>
> >=20
> > Make sure to enable the oscillator in the top device. This will allow t=
o
> > not control this in the child PWM device as that would not work with
> > future support for keyboard matrix where the oscillator needs to be
> > always enabled (and so cannot be disabled by disabling PWM).
>=20
> Setting this bit unconditionally increases power consumption. It should
> only be set when needed.

Well, not sure if the effort for that pays off... The only usecase were it =
would
make sense to do that would be for PWM. For the other devices (and assuming=
 I'm
right with the GPI case) we need this always set.

- Nuno S=C3=A1

>=20
> > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > ---
> > =C2=A0drivers/mfd/adp5585.c | 16 ++++++++++++++++
> > =C2=A01 file changed, 16 insertions(+)
> >=20
> > diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
> > index
> > 160e0b38106a6d78f7d4b7c866cb603d96ea673e..f17b5f2474cac6a403556694066f4=
38288
> > 264a49 100644
> > --- a/drivers/mfd/adp5585.c
> > +++ b/drivers/mfd/adp5585.c
> > @@ -110,6 +110,13 @@ static const struct regmap_config
> > adp5585_regmap_configs[] =3D {
> > =C2=A0	},
> > =C2=A0};
> > =C2=A0
> > +static void adp5585_osc_disable(void *data)
> > +{
> > +	const struct adp5585_dev *adp5585 =3D data;
> > +
> > +	regmap_write(adp5585->regmap, ADP5585_GENERAL_CFG, 0);
> > +}
> > +
> > =C2=A0static int adp5585_i2c_probe(struct i2c_client *i2c)
> > =C2=A0{
> > =C2=A0	const struct regmap_config *regmap_config;
> > @@ -138,6 +145,15 @@ static int adp5585_i2c_probe(struct i2c_client *i2=
c)
> > =C2=A0		return dev_err_probe(&i2c->dev, -ENODEV,
> > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid device ID 0x%02x\n", id);
> > =C2=A0
> > +	ret =3D regmap_set_bits(adp5585->regmap, ADP5585_GENERAL_CFG,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ADP5585_OSC_EN);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D devm_add_action_or_reset(&i2c->dev, adp5585_osc_disable,
> > adp5585);
> > +	if (ret)
> > +		return ret;
> > +
> > =C2=A0	ret =3D devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_AUTO,
> > =C2=A0				=C2=A0=C2=A0 adp5585_devs, ARRAY_SIZE(adp5585_devs),
> > =C2=A0				=C2=A0=C2=A0 NULL, 0, NULL);

