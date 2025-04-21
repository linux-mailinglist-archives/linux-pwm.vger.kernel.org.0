Return-Path: <linux-pwm+bounces-5627-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DAAA9511F
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Apr 2025 14:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36C701892D2A
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Apr 2025 12:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B196526562D;
	Mon, 21 Apr 2025 12:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dD5ntGB0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F81264A84;
	Mon, 21 Apr 2025 12:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745239128; cv=none; b=aNwS8TTIydq2BZYQLxFMbfh6EU4tA95ukoVMDcNtZcWpZrlvmThEj0giE+fjzcW+a6N/lvZMe333aBfONviRM7nOt67rlR2M8mWWAqE6a1IG7r7o4J6gGCA+mjAw7HSoARjFSjL03VNK3CNwgOqly6jsXP5DQJEbwbmaTooJ+X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745239128; c=relaxed/simple;
	bh=jsMsKIyb2fDl6f9CP/ADLOyyT7Pic5DLRnqGHAcUgyw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hQ53kd8kgkXSzoQyoUKeP6C0YcWxgPfpl4ugXVo/Li5MFSQSR1SlcsfIq8t3umaxOpWlnfzIlVRNJh1OSswHkK5933NfuUSQ8IcOu/Oo7DGiEKJx/jwWHqWRlB2+jZiYbBYM43GBCYssHpb3lQ2AxiQ7bfPkE9GF86yn7rP93jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dD5ntGB0; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3914bc3e01aso2403768f8f.2;
        Mon, 21 Apr 2025 05:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745239125; x=1745843925; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fybgU84SLHbLI6xAir2utR6+UN4jfUGXZzDOQynUc24=;
        b=dD5ntGB0CyDhn4KJxqWQxd8bNjg/kXIKy5VoexQ935x00TGiS9zLyhlX9bT+vg/0LZ
         L6mhMxH/e+dNliPdTU+bWvnNbYcIQNv9XQke7OSnY49XqrXCYA+wV3co/glhdBlr7J1F
         uOCDiJJa7vuASBGlnm068ioAg0a1p8nzBuAxHkhC/fZMdPqHSWVyv0PIkYLg92XdRJvR
         ds3SQWa2m41+hHXCaT9P8y/d5LBdNcj5Crhuj/0gCN9ZTA1Vcbs1fzKgReBrLQJLo6Z/
         n4TYPjYggmbX3czPkz1isu6TfJQkgxzQVbZcKw3binufF1jEiF9XRHZxpGX987IhIUA4
         sX1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745239125; x=1745843925;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fybgU84SLHbLI6xAir2utR6+UN4jfUGXZzDOQynUc24=;
        b=OcvqwJLLagwyA4+Z6WDwP2fyJ4avEzIRQpxwxChYfjSct6pY6AYw3HgzyqmGnqPd9U
         B8QET26pklfY84/+qWOBkl7FR8JT0GXo2ASH01OuyFSLwNzGVUaZracej7Q75P3pI7aX
         bQL2K02HF2kBvrAyjONZzNluN1CCYKhdE0YwtTsCnOZRm00Kwm0efDbxgeOG7z3X2zlE
         xQr86XhW9XeXJXDgYrEjhl+QHatEuQ6KBzmnECK9+1MV2aKF4bZ+w32MwdaPRqpEuhnF
         AOOfTLLtrXj5JbnskebjAKezZMd6oysxdD+kv67j7m+b9w9q75q60iIsV1XfOdjQ6yXj
         hI6A==
X-Forwarded-Encrypted: i=1; AJvYcCU9zmXX2NxgCK5EFdyC0dcTRY7UHM+mLl2DCm4Jn5x2pG0IUggEYIlea54tdmQURKgZcJJK03F4Rdk0@vger.kernel.org, AJvYcCVrQBt77qnhZXDffTvyDSt+uvyZXwxoyvD2fAxPikeCWn/BYV0kYPb+YyI3Engi0z6xxBR2ZTa83SBn@vger.kernel.org, AJvYcCXUEeF3+Zz8w5tE/qyWgnYS4n2QNW9yDuj63ZI+h1jkj+5zXR7Gp5Xi58NeEnOAQU/WPfEKBYiqVR9reTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTZNvdSeiF/x7SZ0g+ZMyblMHrUUW1SlEaqicpDF4Xb94LrINb
	6jvSg5SizwXSqPJ985Fpc+XckgHt435gx5y/lVYDI5paiSjqOniXmKh6G0PhdS4=
X-Gm-Gg: ASbGncssqKwkehdJSE49KjkYwiU0V/LHAJHE44YDmVuxKpbhQCphuhEkGQJkYTSNke5
	HM0G4nGDBNxmb3qeck7wO5QOIeASSnWfYVUKv3G2XWqLsF0C5Hf73RolsTYZMujWScQz8LYtkwi
	tsSSluYP9qUtZmAnoSuxZN0ssZjJegU00znWNmZTnIcpAyBn+IRbGQFzPcO+ozxtzXgZHQHFHMq
	y214yRr4JGCGlhCEBqI746+js4QUdq9uX3e4OuE5egkRaMceBWmzrB9UgyklMDxxdpV0qhGa9Ah
	x7G1WT0Maq6QLq7PcuIu1pbvajUymetacMzCABBYiOsyGXDZIfrXFqfEL4vpn+8US+lsjYBpp95
	5G1CvjNdW81Q9
X-Google-Smtp-Source: AGHT+IGDFMjvW6EiqwRZlJGPSufQQj819pzcDc2WbmzmkHc5lQa96klOuHliBhuw5hMD39041aOqhw==
X-Received: by 2002:a05:6000:186e:b0:39e:f9ca:4359 with SMTP id ffacd0b85a97d-39efba5c0e0mr8533229f8f.30.1745239125019;
        Mon, 21 Apr 2025 05:38:45 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d6db10csm132502935e9.27.2025.04.21.05.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 05:38:44 -0700 (PDT)
Message-ID: <dd63c35315c2e8252b1451fd44423c0c79e5be45.camel@gmail.com>
Subject: Re: [PATCH v2 14/17] mfd: adp5585: support getting vdd regulator
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, nuno.sa@analog.com
Cc: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, Lee Jones
 <lee@kernel.org>,  Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,  Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?=	 <ukleinek@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Dmitry
 Torokhov <dmitry.torokhov@gmail.com>, Liu Ying <victor.liu@nxp.com>
Date: Mon, 21 Apr 2025 13:38:47 +0100
In-Reply-To: <20250421094801.GM29968@pendragon.ideasonboard.com>
References: <20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com>
	 <20250415-dev-adp5589-fw-v2-14-3a799c3ed812@analog.com>
	 <20250421094801.GM29968@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-04-21 at 12:48 +0300, Laurent Pinchart wrote:
> Hi Nuno,
>=20
> Thank you for the patch.
>=20
> On Tue, Apr 15, 2025 at 03:49:30PM +0100, Nuno S=C3=A1 via B4 Relay wrote=
:
> > From: Nuno S=C3=A1 <nuno.sa@analog.com>
> >=20
> > Make sure we get and enable the VDD supply (if available).
>=20
> Can the regulator be enabled only when needed ?
>=20

Hmm, I guess we could do that for the case where only the PWM device is
"enabled". That said, I don't think the extra complexity for that really pa=
ys
off...

- Nuno S=C3=A1

> > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > ---
> > =C2=A0drivers/mfd/adp5585.c | 5 +++++
> > =C2=A01 file changed, 5 insertions(+)
> >=20
> > diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
> > index
> > c1d51d50dca6c9367d4a1b98a4f8bbec12dbf90b..667cc5bd0745f64eec60837ec3c00=
057af
> > 0cddeb 100644
> > --- a/drivers/mfd/adp5585.c
> > +++ b/drivers/mfd/adp5585.c
> > @@ -18,6 +18,7 @@
> > =C2=A0#include <linux/mod_devicetable.h>
> > =C2=A0#include <linux/module.h>
> > =C2=A0#include <linux/regmap.h>
> > +#include <linux/regulator/consumer.h>
> > =C2=A0#include <linux/types.h>
> > =C2=A0
> > =C2=A0static const struct mfd_cell adp5585_devs[] =3D {
> > @@ -849,6 +850,10 @@ static int adp5585_i2c_probe(struct i2c_client *i2=
c)
> > =C2=A0	adp5585->dev =3D &i2c->dev;
> > =C2=A0	adp5585->irq =3D i2c->irq;
> > =C2=A0
> > +	ret =3D devm_regulator_get_enable(&i2c->dev, "vdd");
> > +	if (ret)
> > +		return ret;
> > +
> > =C2=A0	adp5585->regmap =3D devm_regmap_init_i2c(i2c, info->regmap_confi=
g);
> > =C2=A0	if (IS_ERR(adp5585->regmap))
> > =C2=A0		return dev_err_probe(&i2c->dev, PTR_ERR(adp5585->regmap),

