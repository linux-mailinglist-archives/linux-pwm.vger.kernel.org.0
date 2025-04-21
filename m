Return-Path: <linux-pwm+bounces-5628-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAE7A95129
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Apr 2025 14:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E315A18930C2
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Apr 2025 12:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F09264FBE;
	Mon, 21 Apr 2025 12:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Us+sayJT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED407264FA0;
	Mon, 21 Apr 2025 12:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745239363; cv=none; b=b5l9IyhEEipO3ZpUNgtMXqaI4YOLuSAFvyGcioQwDKnAGu1xcKEcK+gexeqkW7kHZvYMnfKFemdsZe4mrNMYBf0YNDMNEf5si+0bSYUxT2RhyZSbhVxrT6SCP26MtC2wxWJydClmQItixHH0HNfxfrkcFjsD9D9UpzgDJNbBRwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745239363; c=relaxed/simple;
	bh=14yKFiTQ+8PrvUJbscCOQn6R7zO2ILLN/u1O2JSStgc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LNNBLNI/68ziZ8PxU8xd+sdCkJ2EB/Yj1SCOh8FuquHNqOX/x/mmjJwWgWyqwxKXzATR55j/MzqzNORRzBo12Hgu2PIbgKFlDtVgZZRV7vz13voWSzdExmdQOsB/vMWtTu4cmPZ5ryRXCOeJ/t2wRN0dmd/2Ub8o0RQzNdPedAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Us+sayJT; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cfe574976so28447175e9.1;
        Mon, 21 Apr 2025 05:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745239360; x=1745844160; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WNyeArDWUpWi5aV2cLSkN8ia4D6yyS4FYdxWDB7gsvk=;
        b=Us+sayJTgFWgJH1M17oK4zefSlQ0tZ3j2qf6vIhjtIqVzLRMlAKyzRJPH6JffyAcKC
         p9YMwFJwJKOjrpEbveYPLdt8aVh6eaQKZNnr6U3LQc1hvtaEnGxQQKcnMZ/KAFBCWhc1
         eZ0GDpRI4GVukcHPOeWBLnLC3xOkQHq1zwKZZaQoBa/XRyNXHTQ+0LoCsjymPSjY9qHS
         vbZ45wEQ+JAAfrMEvpS3DC0MoryJAEcKCZoT85s6jt3xZN4wzu2wBMB19f3ye1sqfYWd
         WEZ6Xr3eLnjm4AyPObiwR7vdn797i6vEy8SItJL3DXJVP9jZZGZOnEqBliBGL1CAB+jr
         Xqsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745239360; x=1745844160;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WNyeArDWUpWi5aV2cLSkN8ia4D6yyS4FYdxWDB7gsvk=;
        b=lOqi4L4bB7bs4mk6X7TiAj2TAC1mrhVRpAE4MQdQfFL2xZwe7anNTQ2unYylPbcZbR
         QavAgzWQGfGW8rPAs2ZPhispzAsbFnrBTrhx+S08nLPbnWCsPXARiGHJ2c+UJtSUaxXw
         PgnJr1LZ32uucwjW7GXJYiOjeT7iuvAP5fBbE2r9bu9QI6DsQt+7xmTcmG/UIqbHCdSV
         Fp9TIYjkk3Fywpofuf8qnh1wgE6AMIUWM/MVmr3V9aa+vGJMN8BV0R8pqZ0Y0CEqz/MQ
         kPbK1PXc6DC0dF7rez+8SN83pY7sbHo1xiokKGSQDh1foKPEB03CgCbB9ggSwmnqzED2
         xYOg==
X-Forwarded-Encrypted: i=1; AJvYcCVO2/g2hTPmrJZaDuJV2CPuPlb1C03LIplusf2pS2ot9aKPcQDkBt5Csg5m9ZuHaxYnaaAsAukXey7F@vger.kernel.org, AJvYcCWbfn0duKU0pefM5x+wqVtEnqHzI6oT40jHt5IPc12ciGuD6AS49B2kZ6xRJRoGAY0Kxc1RfqOrMQ9o@vger.kernel.org, AJvYcCWoA3jf5bCz+UbsMBkelkCBTd+cfexHbAvfNe2LGR11uu9rRauzYV42PrdJ535ZR8GjG9KWpo2vkvamdsk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhNWVa9iUgNTWMLZ6JYdKifVPlouxRhoZZ6V8Ij8mp6B2MAF2m
	1ZYkpbF35wD/6wEfa+Z8bVRFtEIUisEgFONFlgPLXXgtDfmz9bz4
X-Gm-Gg: ASbGncsMYLthcmbsfbSl8QdCg/u2A8apNWPuketcrbK0ubtGHHVjJWO4zmLiXbAM4B3
	g4OHWlRu0UE0P0JTpAp771fg8OxWaDCNXyiNqYW1T2TAGeCc6tW6MzyVeXTYh8viq2GO24uaT62
	/kGeG4fmMDDYKNnlAaT9RXbmlvKyXDO/aVq2QC5z4OsWUBc2LfgY5XdEa6A+MHAeMNp4eyH7/l0
	tL+l9dP+Z7+6L07Pkhf3oyzrNM6fC4cpeg15RbAnaTu09A3LcfB6eBRaqBGl+UC17P9KTDg+Gp1
	7NBDp0UcO+sDM/3t8qi0Zc52VRm6wAC49qSC4va/+0RYYB4FvXuGKb3REOGwwzpLefMa55E/AbB
	1MQH3kYERfq8k
X-Google-Smtp-Source: AGHT+IHgE69g6tgTll4IKfMYUkasbGICP4YoqjBw9U5cYGDUjXW4SZ+0qegqSG4i28xzjSk64UO4lg==
X-Received: by 2002:a05:600c:3107:b0:43d:ed:ad07 with SMTP id 5b1f17b1804b1-4406ac21886mr92458185e9.29.1745239360237;
        Mon, 21 Apr 2025 05:42:40 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d5accc2sm134585905e9.14.2025.04.21.05.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 05:42:39 -0700 (PDT)
Message-ID: <66d72f83fd189b4f9a3bebb250a72a5258ef2218.camel@gmail.com>
Subject: Re: [PATCH v2 16/17] mfd: adp5585: add support for a reset pin
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, nuno.sa@analog.com
Cc: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, Lee Jones
 <lee@kernel.org>,  Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,  Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?=	 <ukleinek@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Dmitry
 Torokhov <dmitry.torokhov@gmail.com>, Liu Ying <victor.liu@nxp.com>
Date: Mon, 21 Apr 2025 13:42:43 +0100
In-Reply-To: <20250421094636.GL29968@pendragon.ideasonboard.com>
References: <20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com>
	 <20250415-dev-adp5589-fw-v2-16-3a799c3ed812@analog.com>
	 <20250421094636.GL29968@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-04-21 at 12:46 +0300, Laurent Pinchart wrote:
> Hi Nuno,
>=20
> Thank you for the patch.
>=20
> On Tue, Apr 15, 2025 at 03:49:32PM +0100, Nuno S=C3=A1 via B4 Relay wrote=
:
> > From: Nuno S=C3=A1 <nuno.sa@analog.com>
> >=20
> > Make sure to perform an Hardware reset during probe=C2=A0 if the pin is=
 given
> > in FW.
> >=20
> > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > ---
> > =C2=A0drivers/mfd/adp5585.c | 12 ++++++++++++
> > =C2=A01 file changed, 12 insertions(+)
> >=20
> > diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
> > index
> > 667cc5bd0745f64eec60837ec3c00057af0cddeb..2af110fb28054c8ad6709a9a42cb2=
1919b
> > e433e7 100644
> > --- a/drivers/mfd/adp5585.c
> > +++ b/drivers/mfd/adp5585.c
> > @@ -12,6 +12,7 @@
> > =C2=A0#include <linux/device.h>
> > =C2=A0#include <linux/err.h>
> > =C2=A0#include <linux/i2c.h>
> > +#include <linux/gpio/consumer.h>
>=20
> Alphabetic order please.
>=20
> > =C2=A0#include <linux/mfd/adp5585.h>
> > =C2=A0#include <linux/mfd/core.h>
> > =C2=A0#include <linux/minmax.h>
> > @@ -833,6 +834,7 @@ static int adp5585_i2c_probe(struct i2c_client *i2c=
)
> > =C2=A0{
> > =C2=A0	const struct adp5585_info *info;
> > =C2=A0	struct adp5585_dev *adp5585;
> > +	struct gpio_desc *gpio;
> > =C2=A0	unsigned int id;
> > =C2=A0	int ret;
> > =C2=A0
> > @@ -854,6 +856,16 @@ static int adp5585_i2c_probe(struct i2c_client *i2=
c)
> > =C2=A0	if (ret)
> > =C2=A0		return ret;
> > =C2=A0
> > +	gpio =3D devm_gpiod_get_optional(&i2c->dev, "reset", GPIOD_OUT_HIGH);
> > +	if (IS_ERR(gpio))
> > +		return PTR_ERR(gpio);
> > +
> > +	if (gpio) {
> > +		fsleep(30);
> > +		gpiod_set_value_cansleep(gpio, 0);
> > +		fsleep(60);
>=20
> Where do those values come from ? The only possibly related timing
> information I found in the datasheet indicate a GPIO debounce delay of
> 70=C2=B5s.

Yeps this were just some reasonable values that work. The datasheet does no=
t
mention any timing...

I can add a comment if you like stating there's no defined values in the
datasheet and these values are "just" some values that work.

- Nuno S=C3=A1

>=20
> > +	}
> > +
> > =C2=A0	adp5585->regmap =3D devm_regmap_init_i2c(i2c, info->regmap_confi=
g);
> > =C2=A0	if (IS_ERR(adp5585->regmap))
> > =C2=A0		return dev_err_probe(&i2c->dev, PTR_ERR(adp5585->regmap),

