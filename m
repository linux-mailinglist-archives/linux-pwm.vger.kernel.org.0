Return-Path: <linux-pwm+bounces-5642-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F1EA960AC
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Apr 2025 10:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A781179B02
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Apr 2025 08:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C872512FC;
	Tue, 22 Apr 2025 08:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HlkX56DV"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A2623A995;
	Tue, 22 Apr 2025 08:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745309534; cv=none; b=bjH5FVKHuKSmtA911hYjHUjw1tRcnkyIlCvInTzceR1x0Aetke6f1/epmIP8No+puBDD+3iwR9uLcWYOsoezy3S+OmiQCj9nu38VOgdUxo8lDHajGdiR5Hyb/FwJsSaqhBoE9G6S9nbmdzPBxVD6ojHdO90s7crwGPc4slIUhJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745309534; c=relaxed/simple;
	bh=o+B7DdcdLb05OfWKQ1SLmlisRPFRM/Y/beB3LDCwcbw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sLmSg7Ase/4ccU7v6iV6JY0y6Eni0AKqo7+BbHBTiZOTGOko/lIJ3Gutt4mctr/kmNC33PYGCMb6FYbBX1udioltOCvySayPACloPjx7TOXvgjl7eftFsyqCHEh2JZpdT5N/6g9Wvo1/Ovol4fW3h/Dg+NvsoMYca10p+ZsfHPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HlkX56DV; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-39c1ee0fd43so4374841f8f.0;
        Tue, 22 Apr 2025 01:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745309531; x=1745914331; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K9Pqd0JSg3R3Rl01mQeS60ptj7Wfk7YCDGdP4JNmo6A=;
        b=HlkX56DVfMJUKJqgWisnSk/o8thED3aXlFFghYngIBQlOc7BzlRS7oxLA+71HVgO27
         4JFA78uo0mIOSQdAuVBdO2vDoT8oCN+nbr/ECLiTwz3RQpJutRsf8MhcBUF6IbvWjC1R
         PU3X1RznU9uU7qMIBRhGz7ym7EdFfvzvL5fInpe4NGcVsgp2A28/HHkOThSgfByAR4/E
         u2/TuE/MO4hC3QKp6J9+vIYDYXYeFqZA/p56v0bJ1B7YIr+4iBZbgrvVG9QPPpnmUbVu
         9p5HZzupnWcx8Uc3gX+GigJMJ2yzUoUboAOePnNWIVvvA+mmmoe88dxgXHG5doVxY9g+
         wqTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745309531; x=1745914331;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K9Pqd0JSg3R3Rl01mQeS60ptj7Wfk7YCDGdP4JNmo6A=;
        b=FiEd9gbtiKG99kAWM7Ea6iTE0YMdT805omoyPT56IluVOChDFD2hW7Ucv2RV3oCH1q
         i6KG2UQB4a1/qhAIc6P17nfgm59adANh6oDb7UV2YnosiMhO5rV6LdNUcze5s3wsGi3j
         /GYf+4PZDoZCr4w0hufvZEitT+f7KvlmiKI9M3sCNJJTHQ0c643cC3rDiRSDvxYjhwqM
         U/0L+D0/jsUtxgWH0qU+0ClKLXG0FWgp39pJMtRttgRB6C33wKQ3g0DSimeiJLn0zGED
         IbKayRPfvTO0cpCvdbXcyPKezoa0J17YJXH8j749HyCvFfy/XI80QeBzlPOygXbWQz5j
         /2gQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8wadAYbdCT4WlpGGzDwcDiHl6HUxlt3TgzSJmM0/bhPVLUgHfJWq1bc6/3bCnzNyIADtg/MG1jfSJRQ==@vger.kernel.org, AJvYcCUyANcITJvJteYMNUF3xK8Poa9k0iL1ONPxBq9XpDZmoPY+Rne5NRyqdLY92gsutFGZ1yudPLR0wb2Z@vger.kernel.org, AJvYcCW+Zfr+tejQ9I7Rs7Hgss6qA2NvnV5c1jz0Xmr5rWmKYcBx4tL8OabrG3Jye6C/0KzAluTsrwVu7E4cutM=@vger.kernel.org, AJvYcCX3KvTlIIl3vo08XzP5RL3cMs4J221thBoUFM0CBnTWjTWHXVMpwqPBvtKTVTv/7p/QpgjNyiZbnKfX@vger.kernel.org
X-Gm-Message-State: AOJu0YytWBzb/oPBzyylFMbm8HGWshcAurtbfhLQiWuWHUaieSvnKVBu
	z0fIrCcuXdsL7vbECCs0t13QjXqS6pLaWyo85s+sLMKQPOem7rdJ
X-Gm-Gg: ASbGncuIf2Nl98i6aXMPTK3Hz0MMeg6dJr7aGX0mJKKeDEmcRSkDIuFVcszIr4uhnme
	JFjxFfPonSk/I/SJDTtATb+MJ/uPpEm6ycTWh3fg3B5ayBL1JqQt0p6XyyLbRbkua04D9VsxDPH
	J24hRqkTYb+vsGYDjg9BLZ96tUc9h1ssh1x5X4ijrMLE8Bpi+vkqkArpZOi0Net7LCPdNDal+HB
	6mO6tXA8zOzLnfnHQ2Wiv4eZ+dKrZrd3mWVdedz8yFVLu3osxfqZaXdkvRKd61+nGa/YvOdloY3
	SsF2EfwdnPIgq0G4g9UYMmpvk9wpNEsxZXKwBO2PS/YzNGaJzmAaVe3yiVxCTuU2yObwL0iheJ2
	CYC7C3l3Z8e0S
X-Google-Smtp-Source: AGHT+IGJAhEWq5tlxAZXl4C6CEztLTvqQ2FPHJA9DjgMTsfu+hDE1w1zinbdPhB9uqP2oll3Q8Q0Kg==
X-Received: by 2002:a05:6000:18a8:b0:391:3915:cffb with SMTP id ffacd0b85a97d-39efbadf01fmr11000991f8f.43.1745309530758;
        Tue, 22 Apr 2025 01:12:10 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d6db117sm163051775e9.26.2025.04.22.01.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 01:12:10 -0700 (PDT)
Message-ID: <aeebf7ddc3bcbb9697ed50565dd1b7ee3eb93479.camel@gmail.com>
Subject: Re: [PATCH v2 14/17] mfd: adp5585: support getting vdd regulator
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: nuno.sa@analog.com, linux-gpio@vger.kernel.org,
 linux-pwm@vger.kernel.org, 	devicetree@vger.kernel.org,
 linux-input@vger.kernel.org, Lee Jones <lee@kernel.org>,  Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,  Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=	
 <ukleinek@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Bartosz
 Golaszewski <brgl@bgdev.pl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Liu Ying <victor.liu@nxp.com>
Date: Tue, 22 Apr 2025 09:12:13 +0100
In-Reply-To: <20250421220958.GW17813@pendragon.ideasonboard.com>
References: <20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com>
	 <20250415-dev-adp5589-fw-v2-14-3a799c3ed812@analog.com>
	 <20250421094801.GM29968@pendragon.ideasonboard.com>
	 <dd63c35315c2e8252b1451fd44423c0c79e5be45.camel@gmail.com>
	 <20250421220958.GW17813@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-04-22 at 01:09 +0300, Laurent Pinchart wrote:
> Hi Nuno,
>=20
> On Mon, Apr 21, 2025 at 01:38:47PM +0100, Nuno S=C3=A1 wrote:
> > On Mon, 2025-04-21 at 12:48 +0300, Laurent Pinchart wrote:
> > > On Tue, Apr 15, 2025 at 03:49:30PM +0100, Nuno S=C3=A1 via B4 Relay w=
rote:
> > > > From: Nuno S=C3=A1 <nuno.sa@analog.com>
> > > >=20
> > > > Make sure we get and enable the VDD supply (if available).
> > >=20
> > > Can the regulator be enabled only when needed ?
> > >=20
> >=20
> > Hmm, I guess we could do that for the case where only the PWM device is
> > "enabled". That said, I don't think the extra complexity for that reall=
y
> > pays
> > off...
>=20
> Or when no GPIO is requested, or when the input device for the keypad is
> not open ? Then can be handled with power optimization for OSC_EN on top
> of this series.
>=20

I guess it can go sideways with enabling/disabling OSC_EN, yes...


> > > > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > > > ---
> > > > =C2=A0drivers/mfd/adp5585.c | 5 +++++
> > > > =C2=A01 file changed, 5 insertions(+)
> > > >=20
> > > > diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
> > > > index
> > > > c1d51d50dca6c9367d4a1b98a4f8bbec12dbf90b..667cc5bd0745f64eec60837ec=
3c000
> > > > 57af
> > > > 0cddeb 100644
> > > > --- a/drivers/mfd/adp5585.c
> > > > +++ b/drivers/mfd/adp5585.c
> > > > @@ -18,6 +18,7 @@
> > > > =C2=A0#include <linux/mod_devicetable.h>
> > > > =C2=A0#include <linux/module.h>
> > > > =C2=A0#include <linux/regmap.h>
> > > > +#include <linux/regulator/consumer.h>
> > > > =C2=A0#include <linux/types.h>
> > > > =C2=A0
> > > > =C2=A0static const struct mfd_cell adp5585_devs[] =3D {
> > > > @@ -849,6 +850,10 @@ static int adp5585_i2c_probe(struct i2c_client
> > > > *i2c)
> > > > =C2=A0	adp5585->dev =3D &i2c->dev;
> > > > =C2=A0	adp5585->irq =3D i2c->irq;
> > > > =C2=A0
> > > > +	ret =3D devm_regulator_get_enable(&i2c->dev, "vdd");
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > =C2=A0	adp5585->regmap =3D devm_regmap_init_i2c(i2c, info-
> > > > >regmap_config);
> > > > =C2=A0	if (IS_ERR(adp5585->regmap))
> > > > =C2=A0		return dev_err_probe(&i2c->dev, PTR_ERR(adp5585-
> > > > >regmap),

