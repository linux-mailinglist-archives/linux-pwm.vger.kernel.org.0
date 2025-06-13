Return-Path: <linux-pwm+bounces-6335-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2587AD8829
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Jun 2025 11:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5009F7A504D
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Jun 2025 09:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F69291C32;
	Fri, 13 Jun 2025 09:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jb9OlEsI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D64279DCD;
	Fri, 13 Jun 2025 09:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749807825; cv=none; b=j9gCT87uLjZ57clBD1mjuRoMrqpfU9ULNHhPxsZVnKAYFWcs64VwJnVxFFQ+LRU9hNSYRCzLtfrT0hyENpFv6klkq9PZszTKIr5WCNWdm9JW7xu7md6Y7ttjAh4gt8AVOHXFna3AYV4ro1hT3G5n8SofiS55MLB4aYAy4Cu+HWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749807825; c=relaxed/simple;
	bh=/r5J4oq8iJd6QLjq2jn+0vFMrYD+SXX8xgqjlK3OXRM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lQnnKCwncyA/DaZLTdUHQXB/hU7Bkuyt9rL2iDxyGS0EVLYdHasFAbCvVVeb1OpIzUFOLqDIeD/i2P/fwqfuMFp36hQAavtOmoLtkEPRDvt7nRkHebYLq1x/JWWXPKiOYPXmLNjN4QfM3vXBVOdjYhI2aiMEH1827to8ylHOePI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jb9OlEsI; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-450cfb79177so11480935e9.0;
        Fri, 13 Jun 2025 02:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749807821; x=1750412621; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YgBdXP6eqeJ4OmTOn+SIOedx7iFrMLOaHO7I12Vhvgw=;
        b=jb9OlEsIo65RGQ4m9uI5HavCBw+sDN30q9trzFj87SWqxIXcq/g/WZjDrV0H0HH1EX
         eBZWrKSAcLYxwUsPGPmAUooJYkKccPx1zHStQ3qQ7yBExGZJgFH6FF/Z5aeS1fugZrvQ
         RCqbBV22kubGiboGKxEs0x0IKxYjZujaqa5x1KVJ+CySDApXBcy7GG5tDdnJ4J5Qi/VG
         /RdM3I8w2m6EYr8QhUwaT3PSdSUAMNhZfUJqWQfKH5e2e1ULVAMk58/GGhX5pWi7CjOh
         gctev3IjpPEh1Lpsco0/H7l3HV2w9Yk7gu45dIJpec4XrD8u78DWIfHk3zQeWSngoK4f
         5kxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749807821; x=1750412621;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YgBdXP6eqeJ4OmTOn+SIOedx7iFrMLOaHO7I12Vhvgw=;
        b=temJgRwf6OJ8mfOY8OYsPIMMGkbRXNz1BzcDsf9q31jBEYKOuN5RUAbfq92lXs+VNF
         /bDhWRh8znyRM+HA2/OjUThC29X2pxLw4KPPQ63j2DI8YOsFqkNMDCQGPoWobipV8kSA
         BRv/TuM1zC32H6hy390evgUk9ddZelpexqNinOghEH6zD05fqJpPm2aE7/7dunugfNWs
         thNSl/rOpWX0UWB+MIr8Yz68SgDyNIDMlE6itCim7cdqhp/GxLx3//9MPc2CDWVYl6UX
         jDJ5jEm/IFB8ARyttuXzY3/281sACJgR98J/iUusEKOgfvRCGMOZegbvlUQW++BBgurQ
         9Fvw==
X-Forwarded-Encrypted: i=1; AJvYcCUq2UXofK7czBmDy9geP06aqLIG+8On6Fu4r6J1fxKiL8FzF8P91wizYu/IpUjBAoACSLesHyvmRh7D@vger.kernel.org, AJvYcCVM+kHcxe9v0dGtuqeuoycjysIiS9PLH4UpVz2OzWfncgg5jIq5A8wC7nkaZFumLWKU4Lz8SP0tNvatVA==@vger.kernel.org, AJvYcCVga/ffd9I+2zCs/OX/umDz1vXrQIArj9HsyFExv8asVazBSACvytcMWQGifU6lk/qiHv3Zv1fb6VIT@vger.kernel.org, AJvYcCVhP/bftdFRoU7Q+w4tWPIIdQXwzZrHLMzwMz95KXY7gf6yna5jfBjldrSu8Ssl/2vl/4RzMmS3J6O7AGA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn7vKSEXFWTqtZ2ERG/j6AmI+eU7eLYwiEunoLhoTEe7CT3t88
	qiHrcrvZQSw7jkXBLhpeZAs37EjQGJpbz5txLOsu5bD20Us3NVbuA3Fk
X-Gm-Gg: ASbGnctS/0LneCEXvIObbtTjKSdNqGpz7uaZs5STqeFLQrtOHCijA/x/H6lHhQ+ojdx
	/zUhvjDmRkbzLE6naQmJqnhGOf8hNMoNuLktEOUj3UN3l0cfDxfaUxFoi0Ak0x7XOBLk+gABPOw
	+JGwV6UsGv6DSBjZ/mNiF23mQMOzzPjKUm1PS6NpPU4e4eocrXb655U1T2AsVh+Cp3mzEbjh42Y
	dNTJZQimkgH0zp/oR9JAZgmC7Rk1tY/U01lbEAfau1BzPiPgiOK8GQz/+anDJVWp2NCHyr3OzON
	FTOYCk9q6RTcRgGzSk3yStYvqPbKwJgS3LgIs8kS0i8y0DA6WEZng3/lgNb8+kb4ElLEgxwq1M+
	8vVla
X-Google-Smtp-Source: AGHT+IG4AdnrKYhEj9om9klcX+7UHN63ZdaXLucczjaNwDjA9y2v5NjoaYrtHezNsx2qXF+9kThYEQ==
X-Received: by 2002:a05:600c:3545:b0:442:d9f2:c6ef with SMTP id 5b1f17b1804b1-45334a805cdmr25886375e9.2.1749807821261;
        Fri, 13 Jun 2025 02:43:41 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e253f64sm46360845e9.27.2025.06.13.02.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 02:43:40 -0700 (PDT)
Message-ID: <0889d513f037d60f4154fa7872db31f1aa46a252.camel@gmail.com>
Subject: Re: [PATCH v4 03/20] mfd: adp5585: enable oscilator during probe
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Lee Jones <lee@kernel.org>
Cc: nuno.sa@analog.com, linux-gpio@vger.kernel.org,
 linux-pwm@vger.kernel.org, 	devicetree@vger.kernel.org,
 linux-input@vger.kernel.org, Rob Herring	 <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley	 <conor+dt@kernel.org>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,  Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Dmitry
 Torokhov	 <dmitry.torokhov@gmail.com>, Laurent Pinchart	
 <laurent.pinchart@ideasonboard.com>, Liu Ying <victor.liu@nxp.com>
Date: Fri, 13 Jun 2025 10:43:48 +0100
In-Reply-To: <20250612152029.GO381401@google.com>
References: <20250521-dev-adp5589-fw-v4-0-f2c988d7a7a0@analog.com>
	 <20250521-dev-adp5589-fw-v4-3-f2c988d7a7a0@analog.com>
	 <20250612142001.GH381401@google.com>
	 <4736b759609a9939b3a99a5c87df0fd5518a6af0.camel@gmail.com>
	 <20250612152029.GO381401@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-06-12 at 16:20 +0100, Lee Jones wrote:
> On Thu, 12 Jun 2025, Nuno S=C3=A1 wrote:
>=20
> > On Thu, 2025-06-12 at 15:20 +0100, Lee Jones wrote:
> > > On Wed, 21 May 2025, Nuno S=C3=A1 via B4 Relay wrote:
> > >=20
> > > > From: Nuno S=C3=A1 <nuno.sa@analog.com>
> > > >=20
> > > > Make sure to enable the oscillator in the top device. This will all=
ow to
> > > > not control this in the child PWM device as that would not work wit=
h
> > > > future support for keyboard matrix where the oscillator needs to be
> > > > always enabled (and so cannot be disabled by disabling PWM).
> > > >=20
> > > > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > > > ---
> > > > =C2=A0drivers/mfd/adp5585.c=C2=A0=C2=A0=C2=A0=C2=A0 | 23 ++++++++++=
+++++++++++++
> > > > =C2=A0drivers/pwm/pwm-adp5585.c |=C2=A0 5 -----
> > > > =C2=A02 files changed, 23 insertions(+), 5 deletions(-)
> > > >=20
> > > > diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
> > > > index
> > > > 806867c56d6fb4ef1f461af26a424a3a05f46575..f3b74f7d6040413d066eb6dba=
ecfa3
> > > > d5e6
> > > > ee06bd 100644
> > > > --- a/drivers/mfd/adp5585.c
> > > > +++ b/drivers/mfd/adp5585.c
> > > > @@ -147,6 +147,13 @@ static int adp5585_add_devices(struct device *=
dev)
> > > > =C2=A0	return ret;
> > > > =C2=A0}
> > > > =C2=A0
> > > > +static void adp5585_osc_disable(void *data)
> > > > +{
> > > > +	const struct adp5585_dev *adp5585 =3D data;
> > > > +
> > > > +	regmap_write(adp5585->regmap, ADP5585_GENERAL_CFG, 0);
> > > > +}
> > > > +
> > > > =C2=A0static int adp5585_i2c_probe(struct i2c_client *i2c)
> > > > =C2=A0{
> > > > =C2=A0	const struct regmap_config *regmap_config;
> > > > @@ -175,6 +182,22 @@ static int adp5585_i2c_probe(struct i2c_client
> > > > *i2c)
> > > > =C2=A0		return dev_err_probe(&i2c->dev, -ENODEV,
> > > > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid device ID 0x%02x\n", id=
);
> > > > =C2=A0
> > > > +	/*
> > > > +	 * Enable the internal oscillator, as it's shared between
> > > > multiple
> > > > +	 * functions.
> > > > +	 *
> > > > +	 * As a future improvement, power consumption could possibly be
> > > > +	 * decreased in some use cases by enabling and disabling the
> > > > oscillator
> > > > +	 * dynamically based on the needs of the child drivers.
> > >=20
> > > This is normal.=C2=A0 What's stopping us from doing this from the off=
set?
> >=20
> > This is always needed when we have the input device registered. From my
> > testing,
> > we also need it for GPIOs configured as input. So basically the only re=
ason
> > this
> > is not being done now is that it would not be trivial or really
> > straightforward
> > and honestly the series is already big enough :)
>=20
> Agreed!
>=20
> > Laurent also agreed with this not being mandatory now so hopefully it's=
 also
> > fine with you.
>=20
> If there is no explicit plan to do this in the future, you may as well
> remove the comment.=C2=A0 TODOs have a tendency to rot after code is
> accepted.

Will do. At least me, I can't commit and guarantee I'll do this in the near
future. So if unless someone can commit to this, I'll remove the TODO in th=
e
next version.

- Nuno S=C3=A1

