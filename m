Return-Path: <linux-pwm+bounces-5951-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7A6AB579F
	for <lists+linux-pwm@lfdr.de>; Tue, 13 May 2025 16:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CB2019E32FA
	for <lists+linux-pwm@lfdr.de>; Tue, 13 May 2025 14:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F46E1AAA11;
	Tue, 13 May 2025 14:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbCfaRFE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EDA74C14;
	Tue, 13 May 2025 14:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747147944; cv=none; b=cp029k2MIuL/RvChtwoaBzsUfLjskweHR3ITtVBmIBesfUHTuTg0kvojy1Tua8hyv/dhIbhhPQ3HNR/KpmpDPncrX7Hmn1hX28Nx3cCX1J8Ek8Dz+YKH1kw91q0Isj7KkGdyKCnXQtc6me200i07pgKAZFEZyacnhEqvq6toD30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747147944; c=relaxed/simple;
	bh=5aDU6OkJffzsgTsPnqz6E1KgUCy/DEuGEYl7z4KWf8w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MjFe7txhXNxZmNftRVySGIADbpyJ5k42mCA3Y5yZnJXv/6sfZdr8jrbOY+23NDhNN+GD4+dfR5tEt5fN81mSJA6wIIXXgqLyByrvjWAmZwJOu1roU/ShnvtkUK08AssTIP/qpWfnfMHWP35Hp3xcfTCwc2/jJHbS99c8qbco6Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QbCfaRFE; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cfdc2c8c9so33225685e9.2;
        Tue, 13 May 2025 07:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747147941; x=1747752741; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BtUBi7drBB+cXFEzK9hPG3JrXPoNrKKCJnRpWc9LEtM=;
        b=QbCfaRFEOO66sh0wbP+gQZvhluZuQeUIKE6K6LEiUkK4cMKkFsJgYVa1oECUhoyI3V
         uvAKzCOI5ZmXKwGPamgAJv+ZoIBKCHG3FqMwXnTSFPM/ZGo7vsF0udG4LZeTh5vO+966
         o6hniW56P5c9zTqeEEAVC5zeZzNxl3Dvjoptp2RGPmoShlBB1GouW1iFLCnbwiv2//aO
         2Ys5j3qCFsd4WY2sbh05z1IyAgQRhEKCKGTyZ4GLCpkgW78/vplX7ct1XTmfcU7mPZ36
         c6hU+xImWwLRrG8qYsq5Ac+4oxNcefUpb16Nn9UTbikyiI7SZCfwnS/14Yg+CaySqcXB
         NppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747147941; x=1747752741;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BtUBi7drBB+cXFEzK9hPG3JrXPoNrKKCJnRpWc9LEtM=;
        b=FXUHArwuu3ZJw92YGuj+lgtGLQ+Gd3t65G54lTORNYHvuTcWgyRqqTskYzACy5SGCf
         LLHfotmCG7bPS9URW91Y59G022Z6y6+8g8xCVFVeYq6sU3/Rk0qV7P5pz0FoPS8qJ/KH
         RZun6Kh857SxSQAeNp2JzJdWP0OX3xwjY6Fkiimh0IViQKB2nRDFJ/Nl1rayT1Gixasm
         Pw7Lj3dJ5ETO5N8il89CuDpHarKmyrUxoJsP+v4NXv/sZV3QYJOhoqr2Y6xlQV/CoXaz
         LhutWuXpKtOGcMahr5JXyfVRZvK6s06EudNxnmlvijPA7xBC6jVtXg9afHGgo039FMqw
         7RgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVW9soI2bD7GamhxNKUSZDpTmFFqVouc4lKE/rTDu1TPCHrbNfjsOLnnTlK1sVoG2a6qwOpcIoPSwQp@vger.kernel.org, AJvYcCVyAmSGAHS1/esfM2knfKy6RAabqOZcniqAGjdKdg1tTIBfwnTZI/gZ+p7d5MgHmE5X7bqc3Tb13dca@vger.kernel.org, AJvYcCXe0wVpOmqQpCEzw1tAPrlDIz3n83x0E3ZKk10xlZzmZTy4DTp+LCy7SGwAnOMP0FlwcvxT+8v6ZQhL+vI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0tyZegsfxZjKSBEGp/nH+6p9BDFFi9+kowZeY2QRuMrjC09yN
	OtZ6BCKzBT/d7OEEHDvGfFlcXKV8v6OuBjcIBi0pBmZ39/z/GN671ErnE9oc
X-Gm-Gg: ASbGncuTot7MDztxUVvrvwNKmG1CF2wRKW9DTHfF8eAPnuoMSIDhdzMW5P9FiHuc1OQ
	BBBgu3wdIbXyIhOyUMqTCXJTTP3eAI33+Q5DmKPsWogKKDzw0BsvsAYISlM2OC/nV20SfrisfLt
	oscNrVpC7fddfgo4m1tPh6HdpWo395+3PPpo07PKYPoTTDXAgw6a5mp1s/0LWyTizruze9Y1V6+
	8gYVUKBjRbPrbdaJ4+0QT0pjS1XRxKKXGWApefDYEnTJgab75UFFkk4Gyzz1CYPrvfCTgPdggSh
	PhLnVkRzwFHn02tCv3vA5DRMdK1apEAqETpwUL6365Etx6V/LTOa
X-Google-Smtp-Source: AGHT+IFhFqhFnyQlgNgjWev5W6MiX5oqGtj/0NAeUmmplDp1v7d0JOxrTw/cyIJG0wjlSaIhyYs2rg==
X-Received: by 2002:a05:600c:4451:b0:43d:526:e0ce with SMTP id 5b1f17b1804b1-442d6dc51e8mr129641265e9.21.1747147940888;
        Tue, 13 May 2025 07:52:20 -0700 (PDT)
Received: from [10.5.0.2] ([195.158.248.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd32f3c2sm213513235e9.15.2025.05.13.07.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 07:52:20 -0700 (PDT)
Message-ID: <12d73022533c250ecd5af696fbcb90dbad8fc88d.camel@gmail.com>
Subject: Re: [PATCH v3 03/22] mfd: adp5585: enable oscilator during probe
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
Date: Tue, 13 May 2025 15:52:20 +0100
In-Reply-To: <20250513142618.GL2936510@google.com>
References: <20250512-dev-adp5589-fw-v3-0-092b14b79a88@analog.com>
	 <20250512-dev-adp5589-fw-v3-3-092b14b79a88@analog.com>
	 <20250513142618.GL2936510@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-05-13 at 15:26 +0100, Lee Jones wrote:
> On Mon, 12 May 2025, Nuno S=C3=A1 via B4 Relay wrote:
>=20
> > From: Nuno S=C3=A1 <nuno.sa@analog.com>
> >=20
> > Make sure to enable the oscillator in the top device. This will allow t=
o
> > not control this in the child PWM device as that would not work with
> > future support for keyboard matrix where the oscillator needs to be
> > always enabled (and so cannot be disabled by disabling PWM).
> >=20
> > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > ---
> > =C2=A0drivers/mfd/adp5585.c | 16 ++++++++++++++++
> > =C2=A01 file changed, 16 insertions(+)
> >=20
> > diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
> > index
> > 02f9e8c1c6a1d8b9516c060e0024d69886e9fb7a..d693b1ead05128e02f671ca465f9c=
72cab
> > 3b3395 100644
> > --- a/drivers/mfd/adp5585.c
> > +++ b/drivers/mfd/adp5585.c
> > @@ -143,6 +143,13 @@ static int adp5585_parse_fw(struct device *dev, st=
ruct
> > adp5585_dev *adp5585,
> > =C2=A0	return rc;
> > =C2=A0}
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
> > @@ -176,6 +183,15 @@ static int adp5585_i2c_probe(struct i2c_client *i2=
c)
> > =C2=A0	if (n_devs < 0)
> > =C2=A0		return n_devs;
> > =C2=A0
> > +	ret =3D regmap_set_bits(adp5585->regmap, ADP5585_GENERAL_CFG,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ADP5585_OSC_EN);
>=20
> Nit: Consider unwrapping to 100-chars to avoid these simple line breaks.
>=20
> Other than that, looks okay.

This topic is always hard as some other maintainers perfect the rule "keep =
the
80 char and only go 100 if readability is hurt). Personally, I do prefer 10=
0 so
happy to do it here.

>=20
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D devm_add_action_or_reset(&i2c->dev, adp5585_osc_disable,
> > adp5585);
> > +	if (ret)
> > +		return ret;
> > +
> > =C2=A0	ret =3D devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_AUTO,
> > =C2=A0				=C2=A0=C2=A0 devs, n_devs, NULL, 0, NULL);
> > =C2=A0	if (ret)
> >=20
> > --=20
> > 2.49.0
> >=20
> >=20

