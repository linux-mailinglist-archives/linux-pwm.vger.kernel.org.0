Return-Path: <linux-pwm+bounces-6340-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DACC1AD8CEE
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Jun 2025 15:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25AB43A49AE
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Jun 2025 13:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0980D14BFA2;
	Fri, 13 Jun 2025 13:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4oSYDAM"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F333595A;
	Fri, 13 Jun 2025 13:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749820395; cv=none; b=u3Z5oZMCC5nHrxf3gjesyu5WT+zbfalQG24OCqofmY91cNXVbp9YRqHGVnd+LhLlrr6acevpWUek9AFsRwdgaGUe3ObhnzDVjk1wS+GvuLhlauUkfMUkPK4WI2Hko6ngYfk+KVB9f/J6ImIp6AwQXZthsMgTD/N2SqQnCFMtMQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749820395; c=relaxed/simple;
	bh=z7yrwrbXGpBGTpwvQT/aav4zuEqLx//LsAXlH7CUP7I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FCV3+j5JvxgEAb5xcO17ROK+aSob45jsb+AGh9WMKyWwNyGSeDM8rwSGq5TyZZM1atNaKcx8rtvnYb/Y7wpJAZuIAkcyAjQSNvHC8w7qTPDl+eP6/NaLvoPjIeafxnuLQVP7qeFiKIl88LVtyNZNwkif+y8Be7BboninRKPt4qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k4oSYDAM; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a4fd1ba177so1323131f8f.0;
        Fri, 13 Jun 2025 06:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749820392; x=1750425192; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=scdu0tkBYEuJpOwEEqDoQiZXqyuNP5dn6mJiyA58X8U=;
        b=k4oSYDAMd8W6QbFDZMUhRDgGd3eFNSrRIH+WGmRbqr7Q9XILT2jl9IIwN+L0llslmZ
         3iGDwsJxv+A1g3HgijQOHiJmGOrs9ctsho5+h2G7SmZejMGgD4QpXG7Cp+BqehMN7Nmq
         ntlfI3ieiSO6hd0Chg9Aml4l2HWbuceJP6s/kgRp6/jrNP4akMhjQtAXm93yX94ijvYz
         8vwsRXfeDQCKyWsej0+ip5EI5dnGXTu64YFzvByzODpzYc6LbfWAH87Dirx8XeiTgbxW
         aBh7mmUBwQa77WrFH6HmQtFfD6v/EHu3GHCzbtp95urkwHV5VazoSHmrP7fxJ5HfdN8+
         N55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749820392; x=1750425192;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=scdu0tkBYEuJpOwEEqDoQiZXqyuNP5dn6mJiyA58X8U=;
        b=dgf3CvJ6q7OJ+vsL5uVwfkAkAq2iyO6RpT37NDobmHeqQ4i/PQQKpPESwDo3aHCqTg
         M4lz8jyK0n7rm9GmM99HHci30cuwENeg6Bc7NXQd1m8ZFLtimEUQyYTJPvdqOlWjZWKC
         6ZeWzGUvsqurVsZCPvyKAz7hBDeQwv3smAh9ewPGC2ZRO9voaSmZE195G2I7il+lUVqQ
         ETkwRAROAAlf+AXC31BR5xooAnv/AWIT7ftJKDUB7aKOodwHT/Gq3pUKOv8kNRBiBj/D
         /jm85wxaYfvT/lkXUYxd2+6yHZYigX5FmuMrocLobRVWt7t8Xffdsw5gT83hQ9u4g06O
         odHA==
X-Forwarded-Encrypted: i=1; AJvYcCUdF3wPw5mpFYzYTU1apguuYHwOJRPyjew9buDHMHGvIiybj1fVfH3113mDyRwR1jWh72fLID4onpIkhOg=@vger.kernel.org, AJvYcCVaAv+U7UGcg6xj88pToexNSoCNbpiz0BjKJDKf7ykm5Q82EZtJi7NCBgGqqRmy7e+ZwuiqRN60dlRm@vger.kernel.org, AJvYcCWrtF4ya5yBIc9JcY5RGWYImMwAfT579oMkMhIvIJtEkrGBiZbzh5u5bq75w2gTLv4IQ9K6rLNGTgduFA==@vger.kernel.org, AJvYcCXu2ngrTVwxpKcY9tRIjWQ/jfu9uhqMc9Vsskq9CGzQ79YY+XnCAJpk8QVNO5OUUS019KsG/KSAUwWK@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl7M55FDLvKqTqaUJDHs/GnNBwX8lcGBVv7xX/JSUYPz6cYQuz
	o5kBryP4EDHbWYQY0o1XrlozeJ6+IpJbSxE48c32U16T1k0K9ax3et6w
X-Gm-Gg: ASbGncvwATgbTlGskCSzzLrGMpkfg0RIuENqlzpBRHm4NTrPfUaq91TwuOkwd56TMnC
	NxF5SoRpIhWe5sc1zce/OS/9NTaKgGyZZSS8fjmYiYUpgffRJMjqql0hQk+8ZZQnK910ArhleGP
	ggkSe7/NJoo2J0zi+SaL6IIqlZgiUtO89s/+N7OpV4Iscc68wsMJj+oyAOBdx99xhF2WolwfNVP
	EO9a65d5C8DbNjAHdfQCDFPUkHQIu/5LIoE7RFWHF8++SXd1JbdXNSccwLhRiZRfBmgevfi8rd0
	36nmRg3Etrz6kLfuvFWwFLdzXX2uJh8oeqvd/FeFAyKz+NiPwduI2dkHv9Geg0QX7HSwJK/xJgE
	90eG8
X-Google-Smtp-Source: AGHT+IHg77+nucEhyst9VrWFL2Lk7m2dUyskosJZM4+vUPyjeyRnqQoRb7JgIZ3+fHDnVpURI99pKw==
X-Received: by 2002:a05:6000:2313:b0:3a4:eee4:f73a with SMTP id ffacd0b85a97d-3a56d943393mr729516f8f.22.1749820392050;
        Fri, 13 Jun 2025 06:13:12 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b0898fsm2391383f8f.54.2025.06.13.06.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 06:13:11 -0700 (PDT)
Message-ID: <4afcac4b89465e8e058332bac0dd2efe1f4ee934.camel@gmail.com>
Subject: Re: [PATCH v4 13/20] mfd: adp5585: support reset and unlock events
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
Date: Fri, 13 Jun 2025 14:13:18 +0100
In-Reply-To: <20250613130757.GQ381401@google.com>
References: <20250521-dev-adp5589-fw-v4-0-f2c988d7a7a0@analog.com>
	 <20250521-dev-adp5589-fw-v4-13-f2c988d7a7a0@analog.com>
	 <20250612145542.GK381401@google.com>
	 <1fafdee7c86efdb4aebe3b1c4391f48807aa0aef.camel@gmail.com>
	 <20250613130757.GQ381401@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-06-13 at 14:07 +0100, Lee Jones wrote:
> On Fri, 13 Jun 2025, Nuno S=C3=A1 wrote:
>=20
> > On Thu, 2025-06-12 at 15:55 +0100, Lee Jones wrote:
> > > On Wed, 21 May 2025, Nuno S=C3=A1 via B4 Relay wrote:
> > >=20
> > > > From: Nuno S=C3=A1 <nuno.sa@analog.com>
> > > >=20
> > > > The ADP558x family of devices can be programmed to respond to some
> > > > especial events, In case of the unlock events, one can lock the key=
pad
> > > > and use KEYS or GPIs events to unlock it. For the reset events, one=
 can
> > > > again use a combinations of GPIs/KEYs in order to generate an event=
 that
> > > > will trigger the device to generate an output reset pulse.
> > > >=20
> > > > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > > > ---
> > > > =C2=A0drivers/mfd/adp5585.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2=
70
> > > > +++++++++++++++++++++++++++++++++++++++++++-
> > > > =C2=A0include/linux/mfd/adp5585.h |=C2=A0 39 +++++++
> > > > =C2=A02 files changed, 308 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
> > > > index
> > > > dcc09c898dd7990b39e21cb2324fa66ae171a802..6737d622a7ed9f280c439399f=
3709c
> > > > a816
> > > > 2dee01 100644
> > > > --- a/drivers/mfd/adp5585.c
> > > > +++ b/drivers/mfd/adp5585.c
> > > > @@ -170,6 +170,9 @@ static const struct adp5585_regs adp5585_regs =
=3D {
> > > > =C2=A0	.int_en =3D ADP5585_INT_EN,
> > > > =C2=A0	.gen_cfg =3D ADP5585_GENERAL_CFG,
> > > > =C2=A0	.poll_ptime_cfg =3D ADP5585_POLL_PTIME_CFG,
> > > > +	.reset_cfg =3D ADP5585_RESET_CFG,
> > > > +	.reset1_event_a =3D ADP5585_RESET1_EVENT_A,
> > > > +	.reset2_event_a =3D ADP5585_RESET2_EVENT_A,
> > > > =C2=A0};
> > > > =C2=A0
> > > > =C2=A0static const struct adp5585_regs adp5589_regs =3D {
> > > > @@ -177,8 +180,50 @@ static const struct adp5585_regs adp5589_regs =
=3D {
> > > > =C2=A0	.int_en =3D ADP5589_INT_EN,
> > > > =C2=A0	.gen_cfg =3D ADP5589_GENERAL_CFG,
> > > > =C2=A0	.poll_ptime_cfg =3D ADP5589_POLL_PTIME_CFG,
> > > > +	.reset_cfg =3D ADP5589_RESET_CFG,
> > > > +	.reset1_event_a =3D ADP5589_RESET1_EVENT_A,
> > > > +	.reset2_event_a =3D ADP5589_RESET2_EVENT_A,
> > > > =C2=A0};
> > > > =C2=A0
> > > > +static int adp5585_validate_event(const struct adp5585_dev *adp558=
5,
> > > > unsigned int ev)
> > > > +{
> > > > +	if (adp5585->has_pin6) {
> > > > +		if (ev >=3D ADP5585_ROW5_KEY_EVENT_START && ev <=3D
> > > > ADP5585_ROW5_KEY_EVENT_END)
> > > > +			return 0;
> > > > +		if (ev >=3D ADP5585_GPI_EVENT_START && ev <=3D
> > > > ADP5585_GPI_EVENT_END)
> > > > +			return 0;
> > > > +
> > > > +		return dev_err_probe(adp5585->dev, -EINVAL,
> > > > +				=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid unlock/reset event(%u)
> > > > for
> > > > this device\n", ev);
> > > > +	}
> > > > +
> > > > +	if (ev >=3D ADP5585_KEY_EVENT_START && ev <=3D
> > > > ADP5585_KEY_EVENT_END)
> > > > +		return 0;
> > > > +	if (ev >=3D ADP5585_GPI_EVENT_START && ev <=3D
> > > > ADP5585_GPI_EVENT_END) {
> > > > +		/* if it's GPI6 */
> > >=20
> > > You have to tell us why this is a problem.
> > >=20
> > > Nit: Comments should start with an upper case char.
> >=20
> > The error message kind of states the problem :). But I'll put it in the
> > comment.
>=20
> I don't think it does.=C2=A0 Remember, people reading this do not know th=
e
> H/W as well as you do.=C2=A0 How is GPI6 even related to R5?

Yeah, you might be right. GPI6 is the same pin as R5. In a variation of the=
 chip
we have this extra pin (though the datasheet refers to it as R5) that can e=
ither
be used as part of the keypad or a GPIO. In the other variants, it's a rese=
t
pin.

The check is making sure we're not trying to configure an unlock/reset even=
t on
a pin that do not exist. But I get your point, for me it's clear that R5 =
=3D=3D
GPI6. Me not being consistent in the comments/messages won't help anyone re=
ading
the code.

- Nuno S=C3=A1

>=20
> > - Nuno S=C3=A1
> > >=20
> > > > +		if (ev =3D=3D (ADP5585_GPI_EVENT_START + 5))
> > > > +			return dev_err_probe(adp5585->dev, -EINVAL,
> > > > +					=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid unlock/reset
> > > > event(%u). R5 not available\n",
> > > > +					=C2=A0=C2=A0=C2=A0=C2=A0 ev);
> > > > +		return 0;
> > > > +	}
>=20
> [...]

