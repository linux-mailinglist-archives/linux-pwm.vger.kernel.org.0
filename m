Return-Path: <linux-pwm+bounces-6336-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC687AD8863
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Jun 2025 11:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DF10189D212
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Jun 2025 09:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AE7291C2F;
	Fri, 13 Jun 2025 09:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSCDoLHh"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFF1189BB0;
	Fri, 13 Jun 2025 09:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749808106; cv=none; b=RlTipSPE3QcfhtsdTN2JA5bpSdK/5R2auVmdKLdg5XZlgvIxvd9dvhTvlNO8NxlWekhQgs/lthTqbiJFAbtom6kJ2QdRAcofmDE9cvRnrJklJ3q3HXafZixnWOm6vzQtmsgjMtToHZ3VDBIDjwgGz6R9FjSdSAGmcXwLfufkF9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749808106; c=relaxed/simple;
	bh=mOQqltafqqukVQOVE55z8qhbFQfXvd7xHWPXPGiEBF4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rqRnljLHaR7icf3OwV3XKY5mHil8P9CqChNMuH31ha4bUJ1Nxs8CqLCrNxRkMhfJ9QscFtFnDGRrn5nqJgA25sORNQdPyNu+LhmiNZzcZ5rFwO6Yf5mgFtm4IA15F2IF79aHPuPTCuFt1IYmDVGDX/DPGmfGc1gR8jQLnx7Xqfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DSCDoLHh; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-451ebd3d149so12889565e9.2;
        Fri, 13 Jun 2025 02:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749808102; x=1750412902; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=N5TddtOhaJkY/LAu0+57mXKi5xeLr8l9Rd/+/EhGbC8=;
        b=DSCDoLHhmjqY+MEnsA9GtHseDd66DFcPWkx/UT1cua/7Ne2IRVy2KNqfDyvwq9d36K
         ThBuez5OAJO8jkkN08druESlmVs23wNPcPhOmfAIfbGUc2Wc//MWg+2UG3jUX7GUmNW9
         rDsRLGjLWxOgcvFnEEN+IiZduPvD8Y4CLk3w3L/FA8whL3X5npEWZLFKqLEyrEzUbM5n
         xykTEg3tsu8UA/CD7ntDskDt/u8Ldw+wmyinJy79nl2uLUH2X+aqc0iyky70j23doEPo
         cX3xpeaFCU/wnhFIfOPHY4fjv17f/5mX62KWcVSefX74ZTR3/EndkQWTL8ELvaOM1Epo
         09jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749808102; x=1750412902;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N5TddtOhaJkY/LAu0+57mXKi5xeLr8l9Rd/+/EhGbC8=;
        b=NOVLQbU6UzrtrxJ/gAGM5Mt7SUBeRT/rG5M3lNXvloL+gVvl40y4Qgp/CFj2JrB+J0
         gPBEicuQaDLwATOQN+XYonXLw0l0bFcLUOAgH5jpFjXd3yY5wXfFOwFTztl/h5x8WU6p
         /n6YSpTs4xK03BGPt4/ze2SPIREkb4Aew7285sXmKM065KBaE5sk5Q6/OEbZqC0yUzVm
         EaAj6I2KH3zHi7DTAKtO+gwZXvtZ4X5vmk+P2oMt2UBrLVMLbfguqBrfFSYBc7NbVQVU
         /Y5qZ32VKmeBVhGo0nuEoqXmimqmPUUhElvtIA4ET782mOEUmOr3f/Ah+qS2SxYRW0KP
         y+rA==
X-Forwarded-Encrypted: i=1; AJvYcCWKZV6UH8eiZaJlx/PrRTwyavKIlwWuBHT5o8WomTGUPp00zTSagkZg3qJm0wURr16tlFmgCVgHZFYa@vger.kernel.org, AJvYcCXEhZhJCgwh0byhh5jMR0DeSNFmnw6cP2YVMl2QnNF6b1F+TKSi4rrfyYPmeughf//GU60H2JYAWZyL@vger.kernel.org, AJvYcCXTTQeo1wvJQVr2ktyopZOJCJ/ZWoxfAt+2r1EoaBwoMZfIQ6YY5Qw9vnYZXrEDJSRIHVh/h5wtMXcKEEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIU0EZgBmi7n8/+SYo5zLo7zkeLbxVMPLrtMtpMMOq3MAFTO96
	V7+9VeX6L5C6/EelGT/7YZqKLOa/GXndszN+sUzZaEWs9TZbGCsY1Goa
X-Gm-Gg: ASbGncvAnRqVTTjJ19SCkQRh6WCauOMWjqleURoG0SJUiKsk1SqwdSuL6ILTOgRqJgx
	iZDtiuoJGBoJRboXzvmEJX44i5NlsjZs1CO39Y1Wf6awkSWCYZ4hojssBQkNhG0nS1vGTdTcVYD
	0PhPWlDPXtoyou/xcqJh0HLjGy9X8IZHPTlgmN5He9JVjAhHp3MelYc5QdxmHR/wDu7w1gr2WbB
	hh0ga3bmX3WXqnJ/JRbdrhtiPftcqK8B+EQ3ZfxDqTmATBMa99CuNqXcNEdN1wnuKvMu9mbpd9C
	f4joNA2O9FqisJWDyR16SB2+12SXtDgyBlWkpJ//ZdyGUEhIlqHuUmhNt//3LAeTQVmK3Q==
X-Google-Smtp-Source: AGHT+IG59S6Gd8Nugwhzdfm3/dQQkqaSAT16iX50bBqr0NH6EQw2Lt1xnI5j29t7hs539zMMxhEo6Q==
X-Received: by 2002:a05:6000:4313:b0:3a4:f7db:6ff7 with SMTP id ffacd0b85a97d-3a56878834emr2476961f8f.52.1749808101610;
        Fri, 13 Jun 2025 02:48:21 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b089a7sm1807759f8f.49.2025.06.13.02.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 02:48:21 -0700 (PDT)
Message-ID: <1fafdee7c86efdb4aebe3b1c4391f48807aa0aef.camel@gmail.com>
Subject: Re: [PATCH v4 13/20] mfd: adp5585: support reset and unlock events
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
Date: Fri, 13 Jun 2025 10:48:28 +0100
In-Reply-To: <20250612145542.GK381401@google.com>
References: <20250521-dev-adp5589-fw-v4-0-f2c988d7a7a0@analog.com>
	 <20250521-dev-adp5589-fw-v4-13-f2c988d7a7a0@analog.com>
	 <20250612145542.GK381401@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-06-12 at 15:55 +0100, Lee Jones wrote:
> On Wed, 21 May 2025, Nuno S=C3=A1 via B4 Relay wrote:
>=20
> > From: Nuno S=C3=A1 <nuno.sa@analog.com>
> >=20
> > The ADP558x family of devices can be programmed to respond to some
> > especial events, In case of the unlock events, one can lock the keypad
> > and use KEYS or GPIs events to unlock it. For the reset events, one can
> > again use a combinations of GPIs/KEYs in order to generate an event tha=
t
> > will trigger the device to generate an output reset pulse.
> >=20
> > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > ---
> > =C2=A0drivers/mfd/adp5585.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 270
> > +++++++++++++++++++++++++++++++++++++++++++-
> > =C2=A0include/linux/mfd/adp5585.h |=C2=A0 39 +++++++
> > =C2=A02 files changed, 308 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
> > index
> > dcc09c898dd7990b39e21cb2324fa66ae171a802..6737d622a7ed9f280c439399f3709=
ca816
> > 2dee01 100644
> > --- a/drivers/mfd/adp5585.c
> > +++ b/drivers/mfd/adp5585.c
> > @@ -170,6 +170,9 @@ static const struct adp5585_regs adp5585_regs =3D {
> > =C2=A0	.int_en =3D ADP5585_INT_EN,
> > =C2=A0	.gen_cfg =3D ADP5585_GENERAL_CFG,
> > =C2=A0	.poll_ptime_cfg =3D ADP5585_POLL_PTIME_CFG,
> > +	.reset_cfg =3D ADP5585_RESET_CFG,
> > +	.reset1_event_a =3D ADP5585_RESET1_EVENT_A,
> > +	.reset2_event_a =3D ADP5585_RESET2_EVENT_A,
> > =C2=A0};
> > =C2=A0
> > =C2=A0static const struct adp5585_regs adp5589_regs =3D {
> > @@ -177,8 +180,50 @@ static const struct adp5585_regs adp5589_regs =3D =
{
> > =C2=A0	.int_en =3D ADP5589_INT_EN,
> > =C2=A0	.gen_cfg =3D ADP5589_GENERAL_CFG,
> > =C2=A0	.poll_ptime_cfg =3D ADP5589_POLL_PTIME_CFG,
> > +	.reset_cfg =3D ADP5589_RESET_CFG,
> > +	.reset1_event_a =3D ADP5589_RESET1_EVENT_A,
> > +	.reset2_event_a =3D ADP5589_RESET2_EVENT_A,
> > =C2=A0};
> > =C2=A0
> > +static int adp5585_validate_event(const struct adp5585_dev *adp5585,
> > unsigned int ev)
> > +{
> > +	if (adp5585->has_pin6) {
> > +		if (ev >=3D ADP5585_ROW5_KEY_EVENT_START && ev <=3D
> > ADP5585_ROW5_KEY_EVENT_END)
> > +			return 0;
> > +		if (ev >=3D ADP5585_GPI_EVENT_START && ev <=3D
> > ADP5585_GPI_EVENT_END)
> > +			return 0;
> > +
> > +		return dev_err_probe(adp5585->dev, -EINVAL,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid unlock/reset event(%u) for
> > this device\n", ev);
> > +	}
> > +
> > +	if (ev >=3D ADP5585_KEY_EVENT_START && ev <=3D ADP5585_KEY_EVENT_END)
> > +		return 0;
> > +	if (ev >=3D ADP5585_GPI_EVENT_START && ev <=3D ADP5585_GPI_EVENT_END)=
 {
> > +		/* if it's GPI6 */
>=20
> You have to tell us why this is a problem.
>=20
> Nit: Comments should start with an upper case char.

The error message kind of states the problem :). But I'll put it in the com=
ment.

- Nuno S=C3=A1
>=20
> > +		if (ev =3D=3D (ADP5585_GPI_EVENT_START + 5))
> > +			return dev_err_probe(adp5585->dev, -EINVAL,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid unlock/reset
> > event(%u). R5 not available\n",
> > +					=C2=A0=C2=A0=C2=A0=C2=A0 ev);
> > +		return 0;
> > +	}
> > +
> > +	return dev_err_probe(adp5585->dev, -EINVAL,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid unlock/reset event(%u) for this
> > device\n", ev);
> > +}
> > +
> > +static int adp5589_validate_event(const struct adp5585_dev *adp5585,
> > unsigned int ev)
> > +{
> > +	if (ev >=3D ADP5589_KEY_EVENT_START && ev <=3D ADP5589_KEY_EVENT_END)
> > +		return 0;
> > +	if (ev >=3D ADP5589_GPI_EVENT_START && ev <=3D ADP5589_GPI_EVENT_END)
> > +		return 0;
> > +
> > +	return dev_err_probe(adp5585->dev, -EINVAL,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid unlock/reset event(%u) for this
> > device\n",
> > +			=C2=A0=C2=A0=C2=A0=C2=A0 ev);
>=20
> This line break is unnecessary.
>=20
> > +}
> > +
> > =C2=A0static int adp5585_fill_variant_config(struct adp5585_dev *adp558=
5,
> > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct regmap_config *re=
gmap_config)
> > =C2=A0{
> > @@ -191,6 +236,8 @@ static int adp5585_fill_variant_config(struct
> > adp5585_dev *adp5585,
> > =C2=A0		*regmap_config =3D adp5585_regmap_config_template;
> > =C2=A0		adp5585->id =3D ADP5585_MAN_ID_VALUE;
> > =C2=A0		adp5585->regs =3D &adp5585_regs;
> > +		if (adp5585->variant =3D=3D ADP5585_01)
> > +			adp5585->has_pin6 =3D true;
> > =C2=A0		break;
> > =C2=A0	case ADP5589_00:
> > =C2=A0	case ADP5589_01:
> > @@ -198,6 +245,8 @@ static int adp5585_fill_variant_config(struct
> > adp5585_dev *adp5585,
> > =C2=A0		*regmap_config =3D adp5589_regmap_config_template;
> > =C2=A0		adp5585->id =3D ADP5589_MAN_ID_VALUE;
> > =C2=A0		adp5585->regs =3D &adp5589_regs;
> > +		adp5585->has_unlock =3D true;
> > +		adp5585->has_pin6 =3D true;
> > =C2=A0		break;
> > =C2=A0	default:
> > =C2=A0		return -ENODEV;
> > @@ -207,6 +256,168 @@ static int adp5585_fill_variant_config(struct
> > adp5585_dev *adp5585,
> > =C2=A0	return 0;
> > =C2=A0}
> > =C2=A0
> > +static int adp5585_parse_ev_array(const struct adp5585_dev *adp5585, c=
onst
> > char *prop, u32 *events,
> > +				=C2=A0 u32 *n_events, u32 max_evs, bool
> > reset_ev)
> > +{
> > +	struct device *dev =3D adp5585->dev;
> > +	unsigned int ev;
> > +	int ret;
> > +
> > +	/*
> > +	 * The device has the capability of handling special events through
> > GPIs or a Keypad:
> > +	 *=C2=A0 unlock events: Unlock the keymap until one of the configured
> > events is detected.
> > +	 *=C2=A0 reset events: Generate a reset pulse when one of the configu=
red
> > events is detected.
> > +	 */
> > +	ret =3D device_property_count_u32(dev, prop);
> > +	if (ret < 0)
> > +		return 0;
> > +
> > +	*n_events =3D ret;
> > +
> > +	if (!adp5585->has_unlock && !reset_ev)
> > +		return dev_err_probe(dev, -EOPNOTSUPP, "Unlock keys not
> > supported\n");
> > +
> > +	if (*n_events > max_evs)
> > +		return dev_err_probe(dev, -EINVAL,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid number of keys(%u > %u) for
> > %s\n",
> > +				=C2=A0=C2=A0=C2=A0=C2=A0 *n_events, max_evs, prop);
> > +
> > +	ret =3D device_property_read_u32_array(dev, prop, events, *n_events);
> > +	if (ret)
> > +		return ret;
> > +
> > +	for (ev =3D 0; ev < *n_events; ev++) {
> > +		/* for unlock events, 127 is a wildcard */
>=20
> As above and throughout the series.
>=20
> If you define the wildcard magic number you can drop the comment.
>=20
> > +		if (!reset_ev && events[ev] =3D=3D 127)
> > +			continue;
> > +
> > +		if (adp5585->id =3D=3D ADP5585_MAN_ID_VALUE)
> > +			ret =3D adp5585_validate_event(adp5585, events[ev]);
> > +		else
> > +			ret =3D adp5589_validate_event(adp5585, events[ev]);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int adp5585_unlock_ev_parse(struct adp5585_dev *adp5585)
> > +{
> > +	struct device *dev =3D adp5585->dev;
> > +	int ret;
> > +
> > +	ret =3D adp5585_parse_ev_array(adp5585, "adi,unlock-events", adp5585-
> > >unlock_keys,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0 &adp5585->nkeys_unlock,
> > ARRAY_SIZE(adp5585->unlock_keys),
> > +				=C2=A0=C2=A0=C2=A0=C2=A0 false);
> > +	if (ret)
> > +		return ret;
> > +	if (!adp5585->nkeys_unlock)
> > +		return 0;
> > +
> > +	ret =3D device_property_read_u32(dev, "adi,unlock-trigger-sec",
> > &adp5585->unlock_time);
> > +	if (!ret) {
> > +		if (adp5585->unlock_time > ADP5585_MAX_UNLOCK_TIME_SEC)
> > +			return dev_err_probe(dev, -EINVAL,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid unlock time(%u >
> > %d)\n",
> > +					=C2=A0=C2=A0=C2=A0=C2=A0 adp5585->unlock_time,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0 ADP5585_MAX_UNLOCK_TIME_SEC);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int adp5585_reset_ev_parse(struct adp5585_dev *adp5585)
> > +{
> > +	struct device *dev =3D adp5585->dev;
> > +	u32 prop_val;
> > +	int ret;
> > +
> > +	ret =3D adp5585_parse_ev_array(adp5585, "adi,reset1-events", adp5585-
> > >reset1_keys,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0 &adp5585->nkeys_reset1,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0 ARRAY_SIZE(adp5585->reset1_keys),
> > true);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D adp5585_parse_ev_array(adp5585, "adi,reset2-events",
> > +				=C2=A0=C2=A0=C2=A0=C2=A0 adp5585->reset2_keys,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0 &adp5585->nkeys_reset2,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0 ARRAY_SIZE(adp5585->reset2_keys),
> > true);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (!adp5585->nkeys_reset1 && !adp5585->nkeys_reset2)
> > +		return 0;
> > +
> > +	if (adp5585->nkeys_reset1 && device_property_read_bool(dev,
> > "adi,reset1-active-high"))
> > +		adp5585->reset_cfg |=3D FIELD_PREP(ADP5585_RESET1_POL, 1);
> > +
> > +	if (adp5585->nkeys_reset2 && device_property_read_bool(dev,
> > "adi,reset2-active-high"))
> > +		adp5585->reset_cfg |=3D FIELD_PREP(ADP5585_RESET2_POL, 1);
> > +
> > +	if (device_property_read_bool(dev, "adi,rst-passthrough-enable"))
> > +		adp5585->reset_cfg |=3D FIELD_PREP(ADP5585_RST_PASSTHRU_EN,
> > 1);
> > +
> > +	ret =3D device_property_read_u32(dev, "adi,reset-trigger-ms",
> > &prop_val);
> > +	if (!ret) {
> > +		switch (prop_val) {
> > +		case 0:
> > +			adp5585->reset_cfg |=3D
> > FIELD_PREP(ADP5585_RESET_TRIG_TIME, 0);
> > +			break;
> > +		case 1000:
> > +			adp5585->reset_cfg |=3D
> > FIELD_PREP(ADP5585_RESET_TRIG_TIME, 1);
> > +			break;
> > +		case 1500:
> > +			adp5585->reset_cfg |=3D
> > FIELD_PREP(ADP5585_RESET_TRIG_TIME, 2);
> > +			break;
> > +		case 2000:
> > +			adp5585->reset_cfg |=3D
> > FIELD_PREP(ADP5585_RESET_TRIG_TIME, 3);
> > +			break;
> > +		case 2500:
> > +			adp5585->reset_cfg |=3D
> > FIELD_PREP(ADP5585_RESET_TRIG_TIME, 4);
> > +			break;
> > +		case 3000:
> > +			adp5585->reset_cfg |=3D
> > FIELD_PREP(ADP5585_RESET_TRIG_TIME, 5);
> > +			break;
> > +		case 3500:
> > +			adp5585->reset_cfg |=3D
> > FIELD_PREP(ADP5585_RESET_TRIG_TIME, 6);
> > +			break;
> > +		case 4000:
> > +			adp5585->reset_cfg |=3D
> > FIELD_PREP(ADP5585_RESET_TRIG_TIME, 7);
> > +			break;
> > +		default:
> > +			return dev_err_probe(dev, -EINVAL,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid value(%u) for
> > adi,reset-trigger-ms\n",
> > +					=C2=A0=C2=A0=C2=A0=C2=A0 prop_val);
> > +		}
> > +	}
> > +
> > +	ret =3D device_property_read_u32(dev, "adi,reset-pulse-width-us",
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &prop_val);
>=20
> Odd line break.
>=20
> > +	if (!ret) {
> > +		switch (prop_val) {
> > +		case 500:
> > +			adp5585->reset_cfg |=3D
> > FIELD_PREP(ADP5585_PULSE_WIDTH, 0);
> > +			break;
> > +		case 1000:
> > +			adp5585->reset_cfg |=3D
> > FIELD_PREP(ADP5585_PULSE_WIDTH, 1);
> > +			break;
> > +		case 2000:
> > +			adp5585->reset_cfg |=3D
> > FIELD_PREP(ADP5585_PULSE_WIDTH, 2);
> > +			break;
> > +		case 10000:
> > +			adp5585->reset_cfg |=3D
> > FIELD_PREP(ADP5585_PULSE_WIDTH, 3);
> > +			break;
> > +		default:
> > +			return dev_err_probe(dev, -EINVAL,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid value(%u) for
> > adi,reset-pulse-width-us\n",
> > +					=C2=A0=C2=A0=C2=A0=C2=A0 prop_val);
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > =C2=A0static void adp5585_remove_devices(void *dev)
> > =C2=A0{
> > =C2=A0	mfd_remove_devices(dev);
> > @@ -307,6 +518,59 @@ static int adp5585_setup(struct adp5585_dev *adp55=
85)
> > =C2=A0	unsigned int reg_val, i;
> > =C2=A0	int ret;
> > =C2=A0
> > +	/* Configure the device with reset and unlock events */
> > +	for (i =3D 0; i < adp5585->nkeys_unlock; i++) {
> > +		ret =3D regmap_write(adp5585->regmap, ADP5589_UNLOCK1 + i,
> > +				=C2=A0=C2=A0 adp5585->unlock_keys[i] |
> > ADP5589_UNLOCK_EV_PRESS);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	if (adp5585->nkeys_unlock) {
> > +		ret =3D regmap_update_bits(adp5585->regmap,
> > ADP5589_UNLOCK_TIMERS,
> > +					 ADP5589_UNLOCK_TIMER, adp5585-
> > >unlock_time);
> > +		if (ret)
> > +			return ret;
> > +
> > +		ret =3D regmap_set_bits(adp5585->regmap, ADP5589_LOCK_CFG,
> > ADP5589_LOCK_EN);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	for (i =3D 0; i < adp5585->nkeys_reset1; i++) {
> > +		ret =3D regmap_write(adp5585->regmap, regs->reset1_event_a +
> > i,
> > +				=C2=A0=C2=A0 adp5585->reset1_keys[i] |
> > ADP5585_RESET_EV_PRESS);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	for (i =3D 0; i < adp5585->nkeys_reset2; i++) {
> > +		ret =3D regmap_write(adp5585->regmap, regs->reset2_event_a +
> > i,
> > +				=C2=A0=C2=A0 adp5585->reset2_keys[i] |
> > ADP5585_RESET_EV_PRESS);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	if (adp5585->nkeys_reset1 || adp5585->nkeys_reset2) {
> > +		ret =3D regmap_write(adp5585->regmap, regs->reset_cfg,
> > adp5585->reset_cfg);
> > +		if (ret)
> > +			return ret;
> > +
> > +		reg_val =3D 0;
>=20
> Initialisation during declaration is preferred.
>=20
> > +		/* If there's a reset1 event, then R4 is used as an output
> > for the reset signal */
> > +		if (adp5585->nkeys_reset1)
> > +			reg_val =3D ADP5585_R4_EXTEND_CFG_RESET1;
> > +		/* If there's a reset2 event, then C4 is used as an output
> > for the reset signal */
> > +		if (adp5585->nkeys_reset2)
> > +			reg_val |=3D ADP5585_C4_EXTEND_CFG_RESET2;
> > +
> > +		ret =3D regmap_update_bits(adp5585->regmap, regs->ext_cfg,
> > +					 ADP5585_C4_EXTEND_CFG_MASK |
> > ADP5585_R4_EXTEND_CFG_MASK,
> > +					 reg_val);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > =C2=A0	/* Clear any possible event by reading all the FIFO entries */
> > =C2=A0	for (i =3D 0; i < ADP5585_EV_MAX; i++) {
> > =C2=A0		ret =3D regmap_read(adp5585->regmap, ADP5585_FIFO_1 + i,
> > &reg_val);
> > @@ -351,7 +615,11 @@ static int adp5585_parse_fw(struct adp5585_dev
> > *adp5585)
> > =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid value(%u) for poll-
> > interval\n", prop_val);
> > =C2=A0	}
> > =C2=A0
> > -	return 0;
> > +	ret =3D adp5585_unlock_ev_parse(adp5585);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return adp5585_reset_ev_parse(adp5585);
> > =C2=A0}
> > =C2=A0
> > =C2=A0static void adp5585_irq_disable(void *data)
> > diff --git a/include/linux/mfd/adp5585.h b/include/linux/mfd/adp5585.h
> > index
> > b6baf87907a567fe975f8b24f3c36753e6145066..5a1de5ae4bb144ed49a03a4e9e93e=
b614a
> > be9fa3 100644
> > --- a/include/linux/mfd/adp5585.h
> > +++ b/include/linux/mfd/adp5585.h
> > @@ -68,6 +68,7 @@
> > =C2=A0#define ADP5585_GPIO_DIRECTION_A	0x27
> > =C2=A0#define ADP5585_GPIO_DIRECTION_B	0x28
> > =C2=A0#define ADP5585_RESET1_EVENT_A		0x29
> > +#define		ADP5585_RESET_EV_PRESS		BIT(7)
> > =C2=A0#define ADP5585_RESET1_EVENT_B		0x2a
> > =C2=A0#define ADP5585_RESET1_EVENT_C		0x2b
> > =C2=A0#define ADP5585_RESET2_EVENT_A		0x2c
> > @@ -118,6 +119,13 @@
> > =C2=A0#define ADP5585_MAX_REG			ADP5585_INT_EN
> > =C2=A0
> > =C2=A0#define ADP5585_PIN_MAX			11
> > +#define ADP5585_MAX_UNLOCK_TIME_SEC	7
> > +#define ADP5585_KEY_EVENT_START		1
> > +#define ADP5585_KEY_EVENT_END		25
> > +#define ADP5585_GPI_EVENT_START		37
> > +#define ADP5585_GPI_EVENT_END		47
> > +#define ADP5585_ROW5_KEY_EVENT_START	1
> > +#define ADP5585_ROW5_KEY_EVENT_END	30
> > =C2=A0
> > =C2=A0/* ADP5589 */
> > =C2=A0#define		ADP5589_MAN_ID_VALUE		0x10
> > @@ -128,6 +136,20 @@
> > =C2=A0#define ADP5589_GPO_DATA_OUT_A		0x2a
> > =C2=A0#define ADP5589_GPO_OUT_MODE_A		0x2d
> > =C2=A0#define		ADP5589_GPIO_DIRECTION_A	0x30
> > +#define ADP5589_UNLOCK1			0x33
> > +#define		ADP5589_UNLOCK_EV_PRESS		BIT(7)
> > +#define ADP5589_UNLOCK_TIMERS		0x36
> > +#define		ADP5589_UNLOCK_TIMER		GENMASK(2, 0)
> > +#define ADP5589_LOCK_CFG		0x37
> > +#define		ADP5589_LOCK_EN			BIT(0)
> > +#define ADP5589_RESET1_EVENT_A		0x38
> > +#define ADP5589_RESET2_EVENT_A		0x3B
> > +#define ADP5589_RESET_CFG		0x3D
> > +#define		ADP5585_RESET2_POL		BIT(7)
> > +#define		ADP5585_RESET1_POL		BIT(6)
> > +#define		ADP5585_RST_PASSTHRU_EN		BIT(5)
> > +#define		ADP5585_RESET_TRIG_TIME		GENMASK(4,
> > 2)
> > +#define		ADP5585_PULSE_WIDTH		GENMASK(1, 0)
> > =C2=A0#define ADP5589_PWM_OFFT_LOW		0x3e
> > =C2=A0#define ADP5589_PWM_ONT_LOW		0x40
> > =C2=A0#define ADP5589_PWM_CFG			0x42
> > @@ -138,6 +160,10 @@
> > =C2=A0#define ADP5589_MAX_REG			ADP5589_INT_EN
> > =C2=A0
> > =C2=A0#define ADP5589_PIN_MAX			19
> > +#define ADP5589_KEY_EVENT_START		1
> > +#define ADP5589_KEY_EVENT_END		88
> > +#define ADP5589_GPI_EVENT_START		97
> > +#define ADP5589_GPI_EVENT_END		115
> > =C2=A0
> > =C2=A0struct regmap;
> > =C2=A0
> > @@ -158,6 +184,9 @@ struct adp5585_regs {
> > =C2=A0	unsigned int ext_cfg;
> > =C2=A0	unsigned int int_en;
> > =C2=A0	unsigned int poll_ptime_cfg;
> > +	unsigned int reset_cfg;
> > +	unsigned int reset1_event_a;
> > +	unsigned int reset2_event_a;
> > =C2=A0};
> > =C2=A0
> > =C2=A0struct adp5585_dev {
> > @@ -167,8 +196,18 @@ struct adp5585_dev {
> > =C2=A0	struct blocking_notifier_head event_notifier;
> > =C2=A0	enum adp5585_variant variant;
> > =C2=A0	unsigned int id;
> > +	bool has_unlock;
> > +	bool has_pin6;
> > =C2=A0	int irq;
> > =C2=A0	unsigned int ev_poll_time;
> > +	unsigned int unlock_time;
> > +	unsigned int unlock_keys[2];
> > +	unsigned int nkeys_unlock;
> > +	unsigned int reset1_keys[3];
> > +	unsigned int nkeys_reset1;
> > +	unsigned int reset2_keys[2];
> > +	unsigned int nkeys_reset2;
> > +	u8 reset_cfg;
> > =C2=A0};
> > =C2=A0
> > =C2=A0#endif
> >=20
> > --=20
> > 2.49.0
> >=20
> >=20

