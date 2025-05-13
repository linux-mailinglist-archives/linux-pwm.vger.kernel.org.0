Return-Path: <linux-pwm+bounces-5962-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9DFAB58D5
	for <lists+linux-pwm@lfdr.de>; Tue, 13 May 2025 17:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BAD0189D8AF
	for <lists+linux-pwm@lfdr.de>; Tue, 13 May 2025 15:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42B82BE0F3;
	Tue, 13 May 2025 15:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="naqQ9nDp"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0794B2BDC09;
	Tue, 13 May 2025 15:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747150733; cv=none; b=r/ODIN6AMhT6r0emeFqIOE3Nqw8kkYnERbu7jvq5aZggIM1Kz1tZOILtKoLLuxaUYNXt++pqAvF8hTnW0DJt//gw2RMiMVfN2IjYd0E/Yl3a0/eFYgrAttUMF8lV9ypnJBIfRrUItYThnd0qQQqy6JN2WOQc++p3xAKPqpjl9kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747150733; c=relaxed/simple;
	bh=lVfR9a02d9tQODJWCXG7wwL2+rfYsrHP3jFPgP/W/iM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ev0IPyNXVql15UaRMXBo26q9+RWJU7AVKJt8IMejrgnLRsAiuehMKBFb/narMRfYeJJt/lzZGBlccrg2xxJJLtNM90QwA46JHvV5G1CsD+G9AJdSeTrYz4YnEBfwpPWly1ECjTuBqr6Kjxd8Q7DRzFYycqAaOxcqgovPu+MA+/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=naqQ9nDp; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43d0618746bso44310055e9.2;
        Tue, 13 May 2025 08:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747150730; x=1747755530; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4Qxsn6p5aieI07ERVkkI/oiCbHKgcQLeHn2Pfys00EA=;
        b=naqQ9nDpJmiDRBnh9cJxk9/2sCfhNRopgpyLWArrG5NHvngXmQWqokOyMGMZO6TiUP
         00gRcMYmIQD0OpaGXnjYkyzSL9H1hQI51vtUHvxMW9CkYsbvIs1HuiqkfEJK3j9il+Xc
         95rJlISzSYYVBSewuRC2OBIXgKlS1WDcJHJoLQdhKM0/pWJ/H3hVvWqENnrr4T1oJMGW
         3HpsvIHQyH/eWm3K6D+QGNP8pv5gIVVSYnSKTn6MO6BP4/VHXI9KKFyl6BwDsYmArW7Q
         0NACs782vPvHheLtSsS9S5ELY4+ZheIx918h2WVZbZRdrxgUhDCCwmJzWTtj7FbODVST
         cE2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747150730; x=1747755530;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Qxsn6p5aieI07ERVkkI/oiCbHKgcQLeHn2Pfys00EA=;
        b=s24WQendcr9STHB2/ppT/LaeKVQZR/AemGgKtrnRVi4bG8e5l8shPZpdNuIc+oPpAB
         Eg7KjPmxk+wzefPimQ4KHksmobhVL6yk203atidYrMLIMzCFU6rEIYmwZII9irdkwnJc
         7uivpJz8N4guEhjDmIsTypXP1YVy0yc7QO06jJtQJ2/K9SLFd6BiKRBpJm99EF3zPsbL
         KInBbT5WM92SVcl3wL8r5aKnUbhoijPYmE2Y9Mu6iaNMYW3DA+lR8+MsW7MtTi2rTsEF
         UzVPqAD05OBxZe1yyQphEJDD8CaLyFfbZuRR0IPoVj2ZxitWnJdcnoWSym/toOFe1ran
         UQfg==
X-Forwarded-Encrypted: i=1; AJvYcCUK6hhPVgkLmJnAwlLX4uN/jvOLj+4IbA/YM/nPud/uOA+ATbIQiod4tTof9GUV9Cafx4g+wuCDB8ac@vger.kernel.org, AJvYcCVVdRi3+Y3yFAF2KHMMlvHudRUKd4xfOCLfo26hY0m+w/ccXAhy/Mo2v59L/gUxQyVLDQk8bB7dCmPw@vger.kernel.org, AJvYcCVeZXgV9mycf2WdVBg1Mis++3ty9OU/YZ6BMDAl8pWwVa6edUjkSJbWwnClSb2vbYRqKBDnkTgmLSgQJ6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDdWyb3HUGYZms7pwOeo3yE9FKbC+1czUqUTM/BuSGczTMrss5
	yXO9FfpawMsrm+DNlWwVdw9V6nNgtH74UQzn0TDKW1awC2cfePhp
X-Gm-Gg: ASbGncsuCYmiHFehc2brBEvJDwavhMlMe2PRoAb6NZAoyZCOPXX3u8RaoWJ/1IglMXN
	HzJGv2HZnPxzSLL9D5H+F2wWySraRbfzaxxo0cKqLt8/9ID5f7vsJEnvA8Wk4EpNrk7cogTW7bx
	NrTSjwZyN+7DIdGjhLZwRAnwhuWDLDnkz8VRY3ZITGSSFvSuj9AphovcG42IppvjI77p5FjKm39
	Mjrm6PIaDN0vI0qxsE5cK5MdIMjv6gxrE4hxmUfTip/VQZ5qm/FewLWMiEiri4Y7Oo2gEVSjuS0
	RcV+IhGSt2ENrrWQTVuPlZ6eMpN0nh1iMRl7nnJPRx8/0uFXVznt
X-Google-Smtp-Source: AGHT+IGP7GmWSCAflnVT21BJUwDm4XywvkIT0s7pjchQpaDbf2ZFRTxweyorvUIjrJC2sslQ46Uy5w==
X-Received: by 2002:a05:600c:3d8a:b0:43d:94:cfe6 with SMTP id 5b1f17b1804b1-442d6dacbe7mr178946145e9.16.1747150729959;
        Tue, 13 May 2025 08:38:49 -0700 (PDT)
Received: from [10.5.0.2] ([195.158.248.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442ea45c209sm47088345e9.17.2025.05.13.08.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 08:38:49 -0700 (PDT)
Message-ID: <09e625d30a864ddcd5d4b8266a80a62ac49e8b6f.camel@gmail.com>
Subject: Re: [PATCH v3 03/22] mfd: adp5585: enable oscilator during probe
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, nuno.sa@analog.com
Cc: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, Lee Jones
 <lee@kernel.org>,  Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,  Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?=	 <ukleinek@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Dmitry
 Torokhov <dmitry.torokhov@gmail.com>, Liu Ying <victor.liu@nxp.com>
Date: Tue, 13 May 2025 16:38:49 +0100
In-Reply-To: <20250513152423.GB23592@pendragon.ideasonboard.com>
References: <20250512-dev-adp5589-fw-v3-0-092b14b79a88@analog.com>
	 <20250512-dev-adp5589-fw-v3-3-092b14b79a88@analog.com>
	 <20250513152423.GB23592@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-05-13 at 17:24 +0200, Laurent Pinchart wrote:
> Hi Nuno,
>=20
> Thank you for the patch.
>=20
> On Mon, May 12, 2025 at 01:38:55PM +0100, Nuno S=C3=A1 via B4 Relay wrote=
:
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
>=20
> Could you add a comment here to explain what's going on ? Something
> along the lines of
>=20
> 	/*
> 	 * Enable the internal oscillator, as it's shared between multiple
> 	 * functions.
> 	 *
> 	 * As a future improvement, power consumption could possibly be
> 	 * decreased in some use cases by enabling and disabling the
> oscillator
> 	 * dynamically based on the needs of the child drivers.
> 	 */
>=20

Sure, I can add a similar remark in the regulator patch

Thanks!

> With that,
>=20
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>=20
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
> > =C2=A0				=C2=A0=C2=A0 devs, n_devs, NULL, 0, NULL);
> > =C2=A0	if (ret)

