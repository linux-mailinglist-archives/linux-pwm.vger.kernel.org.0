Return-Path: <linux-pwm+bounces-6321-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 444ADAD7447
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Jun 2025 16:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C227D3B619E
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Jun 2025 14:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C749024BD1A;
	Thu, 12 Jun 2025 14:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkdTmTKW"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7812AD0F;
	Thu, 12 Jun 2025 14:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749739209; cv=none; b=SLlV1doeaVHknI/34edVl0uoEvX9ekNlKQD8wEb1Odu6zaf7PGNGzaKo9njJ2MVGyDN9im2Vy6uMu/fIGjXS8vpjkpF6boEC5u2A77NfC1pWLz6qxb2S7nTlgc9lO7/a+QXUj6AYSxcHn7o4j4ean4IJh+qzI/Rw9PFkFLZ9x6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749739209; c=relaxed/simple;
	bh=Y5WcRbSXxyMxHfUoci3SJStu8xIXVE3qYzIP9J0er6c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JMuEVqJSTkBM+3RVN1Q0DmjUPp3lY/JgoUPIoWxbJ4IVIsCqIjGEGbXZViLCSivMbtljcWehGeYSZ/tLN6PrOUsKECs6cdZvLzquUO7937Br3BtuimLzN60pwwNO/IVSRlxeB+/IDXUTIoNpRqsmzK5+9tRcKtNZM1aXLtBQYiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CkdTmTKW; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4530921461aso9358525e9.0;
        Thu, 12 Jun 2025 07:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749739206; x=1750344006; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XO5xW6STrJbOovaRRRVEdzdrcsGsRAbrSNjEp7XD5iI=;
        b=CkdTmTKWXasNutNLpLg7Codhwd+ZbImW/iJajL0gIA0X55aQLCFq3bKoCCfKl/VAAD
         iiACFKt89EGyDTNWnCYaa5ogGMTslOML6QqQO8dQTdJACdLnZOAtaIGVUWJv1SIr2heq
         aqJL9zQDbVP3uZPldOZg1xVBVlTvhBEUnThgNVOJKX48mBxrylhTmDFVsVrffmj2HV3d
         +doI9baDGCSzAYua0ne+dgtc3d+6XcDNmZylzIRmXwsUUyXX0miocXNHZew1Nq3ByBXm
         D/RQ/W2uuk0MENnboiFu+p5MpNXZQq4734pXnoiuYWpT9hMVeocEXwzcp1dagUQ6w1UO
         Sc/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749739206; x=1750344006;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XO5xW6STrJbOovaRRRVEdzdrcsGsRAbrSNjEp7XD5iI=;
        b=kDHWUcEs2PfmbxwOSwiiZAROguYf2hjO40cI4dxI/3X8uZyqKp3lPJdg1KKMeTRSAV
         jpzOlRFfGisksVcqmKdaNSHrE4fOHrcdGnatGYjg1z2jnjWUYpHjtHo+PFSzYtOAB2lP
         3oyNx9B/m+XNueOzU4d86P6PVi/daYbtRYmt0hyA4RtfMdv/YnpnZ78dXiueMjZ24tFH
         vikpET7DJ7thHNxAf9VM4PrQpGaxPZe8oj5xpWDpkd0qv/hFsC1V0laqefyQri1xvrNh
         DPigEEoGCjW2XWWPM5XuD+mIdpx+/+KzJdDtK+sDcmw+WRotkDYK/2Q2yGfs0ixAbEeW
         W0LA==
X-Forwarded-Encrypted: i=1; AJvYcCVF026NlRXFowMqNTokFqerpUz4vZP2ZgbHQOkWkK7SwaVdtpVJAOgXNJXidFguPTdkGDwjmrJqGmASh6E=@vger.kernel.org, AJvYcCWPofUKq5mJIsOq7LFI6jf+wSBnjx4m2/2EJFL34JSLUgy7tAUyu//2P0KpBji0O+8Y+sKC6Oxa0BB9@vger.kernel.org, AJvYcCWUnrUmpKGw6QG8wsQYVeWoyWIHwSwHpJ6EiO725zTp35t6GHv/rkkT1Ie1CYWWUEh59mQnoRs549jJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwL63mJFJAdgp4cRM4bDW2eD+//GJwOswFvdVKhURIHujViogRP
	juvHTxtG4omLIBQ8LiwQabB8ADOEva+nQxIko3WdfjvXE8aZvsfpXmb9
X-Gm-Gg: ASbGnct7DEPKLEcHxiGBxw846hOrt3EBcoU4Z3IMYteTqBOZrbCBEv48FCNJHY/Pp5Z
	cvTCewe72lsSi6mkON1v7d1Dc0TpKgUotgXsCs7ro7tvdPNmbP8dSGQ8CQnwRnWDWioNf7YGlt6
	mXtbIOV2UHH7WmQMQPSGQcGCFmDZ+GLOz+27Rsf55yRvDMRXCnM2a8LmvyGL6kKYk2M76S5/Wvf
	HX6h3eqA+NMri03G0aSq4pPlQra+rpNqj0xOjgmiNv2HRGSsKCOSuKTMq9qjFkf/DsaU/56cGLa
	3v8BZTJ7La7VbC/CbROpnterpFtkxZfw2nNpCIA/gTqnNP56TjirFI4/hxKtBwyYtXf3FQ==
X-Google-Smtp-Source: AGHT+IEgJVa7T9a/v6a+QdCQd7PLGm4gVqm4zt6VpmQF3J4pe3zCCTagGbfhHOAbgCS0XpfwKgiFSw==
X-Received: by 2002:a05:600c:198a:b0:450:d00d:cc with SMTP id 5b1f17b1804b1-45326e9018amr64987205e9.2.1749739205818;
        Thu, 12 Jun 2025 07:40:05 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e25302dsm21987815e9.26.2025.06.12.07.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 07:40:05 -0700 (PDT)
Message-ID: <4736b759609a9939b3a99a5c87df0fd5518a6af0.camel@gmail.com>
Subject: Re: [PATCH v4 03/20] mfd: adp5585: enable oscilator during probe
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
Date: Thu, 12 Jun 2025 15:40:12 +0100
In-Reply-To: <20250612142001.GH381401@google.com>
References: <20250521-dev-adp5589-fw-v4-0-f2c988d7a7a0@analog.com>
	 <20250521-dev-adp5589-fw-v4-3-f2c988d7a7a0@analog.com>
	 <20250612142001.GH381401@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-06-12 at 15:20 +0100, Lee Jones wrote:
> On Wed, 21 May 2025, Nuno S=C3=A1 via B4 Relay wrote:
>=20
> > From: Nuno S=C3=A1 <nuno.sa@analog.com>
> >=20
> > Make sure to enable the oscillator in the top device. This will allow t=
o
> > not control this in the child PWM device as that would not work with
> > future support for keyboard matrix where the oscillator needs to be
> > always enabled (and so cannot be disabled by disabling PWM).
> >=20
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > ---
> > =C2=A0drivers/mfd/adp5585.c=C2=A0=C2=A0=C2=A0=C2=A0 | 23 ++++++++++++++=
+++++++++
> > =C2=A0drivers/pwm/pwm-adp5585.c |=C2=A0 5 -----
> > =C2=A02 files changed, 23 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
> > index
> > 806867c56d6fb4ef1f461af26a424a3a05f46575..f3b74f7d6040413d066eb6dbaecfa=
3d5e6
> > ee06bd 100644
> > --- a/drivers/mfd/adp5585.c
> > +++ b/drivers/mfd/adp5585.c
> > @@ -147,6 +147,13 @@ static int adp5585_add_devices(struct device *dev)
> > =C2=A0	return ret;
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
> > @@ -175,6 +182,22 @@ static int adp5585_i2c_probe(struct i2c_client *i2=
c)
> > =C2=A0		return dev_err_probe(&i2c->dev, -ENODEV,
> > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid device ID 0x%02x\n", id);
> > =C2=A0
> > +	/*
> > +	 * Enable the internal oscillator, as it's shared between multiple
> > +	 * functions.
> > +	 *
> > +	 * As a future improvement, power consumption could possibly be
> > +	 * decreased in some use cases by enabling and disabling the
> > oscillator
> > +	 * dynamically based on the needs of the child drivers.
>=20
> This is normal.=C2=A0 What's stopping us from doing this from the offset?

This is always needed when we have the input device registered. From my tes=
ting,
we also need it for GPIOs configured as input. So basically the only reason=
 this
is not being done now is that it would not be trivial or really straightfor=
ward
and honestly the series is already big enough :)

Laurent also agreed with this not being mandatory now so hopefully it's als=
o
fine with you.

- Nuno S=C3=A1
>=20
> > +	 */
> > +	ret =3D regmap_set_bits(adp5585->regmap, ADP5585_GENERAL_CFG,
> > ADP5585_OSC_EN);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D devm_add_action_or_reset(&i2c->dev, adp5585_osc_disable,
> > adp5585);
> > +	if (ret)
> > +		return ret;
> > +
> > =C2=A0	return adp5585_add_devices(&i2c->dev);
> > =C2=A0}
> > =C2=A0
> > diff --git a/drivers/pwm/pwm-adp5585.c b/drivers/pwm/pwm-adp5585.c
> > index
> > 40472ac5db6410a33e4f790fe8e6c23b517502be..c8821035b7c1412a55a642e6e8a46=
b66e6
> > 93a5af 100644
> > --- a/drivers/pwm/pwm-adp5585.c
> > +++ b/drivers/pwm/pwm-adp5585.c
> > @@ -62,7 +62,6 @@ static int pwm_adp5585_apply(struct pwm_chip *chip,
> > =C2=A0	int ret;
> > =C2=A0
> > =C2=A0	if (!state->enabled) {
> > -		regmap_clear_bits(regmap, ADP5585_GENERAL_CFG,
> > ADP5585_OSC_EN);
> > =C2=A0		regmap_clear_bits(regmap, ADP5585_PWM_CFG, ADP5585_PWM_EN);
> > =C2=A0		return 0;
> > =C2=A0	}
> > @@ -100,10 +99,6 @@ static int pwm_adp5585_apply(struct pwm_chip *chip,
> > =C2=A0	if (ret)
> > =C2=A0		return ret;
> > =C2=A0
> > -	ret =3D regmap_set_bits(regmap, ADP5585_GENERAL_CFG, ADP5585_OSC_EN);
> > -	if (ret)
> > -		return ret;
> > -
> > =C2=A0	return regmap_set_bits(regmap, ADP5585_PWM_CFG, ADP5585_PWM_EN);
> > =C2=A0}
> > =C2=A0
> >=20
> > --=20
> > 2.49.0
> >=20
> >=20

