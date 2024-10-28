Return-Path: <linux-pwm+bounces-3943-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA04B9B321C
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Oct 2024 14:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22458B22BA5
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Oct 2024 13:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89051DC1A7;
	Mon, 28 Oct 2024 13:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPQ9SFnX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB021D54CF;
	Mon, 28 Oct 2024 13:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730123238; cv=none; b=j0YrSjrR0FoWC7FcOhnYysZvZGzL+jGL3oRihvYPIgDCeHe5OfnhqbLnQG6So6wnH4FgztFhA+BE91zuGr6kCRFarCk+1CRadHyCBI1qlAWJJNYupa22xU8Vrs/GDutCPDuCkQT6gEFF6BF+WAj/70oHUKoLVJ/LUTvWyA280vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730123238; c=relaxed/simple;
	bh=8s/mZf1L6/y/OYJYKbZFRk1Snr0ZeY+NM9BdafdPHs0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rXYCLIig3MCEVg8MStRa/fTzk7zuhUwRHLBKqYfiKNUNFEJXJKoa0onnmkBUsWhliAHgkB+18yZjYjXgRtO876HPC1YMlgjR90d+BI/+cOu+ih5nliCkgCB+wr0oN/pc6WJmyWG4yV2Zayyac7ocry5z7hDiEloHuZTafDPrq2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PPQ9SFnX; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4315839a7c9so45392175e9.3;
        Mon, 28 Oct 2024 06:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730123235; x=1730728035; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZsxyqRGblyfBnN2T5zskhfYxekR5jpDhOYENtex4m50=;
        b=PPQ9SFnXbareFKF3M4CZDlBTAdAS/DElFpC/dyq6SLKwU5YWm0SkO84o/kUdUNiPWs
         S+oQEZpJ4JEtBIR7l87G2nmWb8r7ejLboxnghRcG1Fi/19oQU14EcEan4oeZUhcI0XFF
         Gs/ckpha98z8YsiwWMbrwuXFIBnPgzZ7UioPGv2duwYS+WH7V8wkrO1J5oHEYIHO39IF
         X+iEOgrvATcsR7lxKT5KujNQMB24vWAU9x6pb/BhRQopJ6ePsA+Rm68Mraej2JOSxO5h
         vfsK9WN+hMmK5Wp2QaU5p3N7ZxrJMF5A8ieolJKDPkPlT14mFYvzrYqAICjIiXZ6UjK8
         Z2NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730123235; x=1730728035;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZsxyqRGblyfBnN2T5zskhfYxekR5jpDhOYENtex4m50=;
        b=dtXiWSxqE+RZ1n+rzLoTfjQncjuQvUInTCCVzZDNILao7tiCNE8iWeSQA9MOy03oWc
         5ZMsO1dgIQGrif3aTyf/NK7qFk5BducsSyqjozOI/28tbB2Ppt3IbeFD3RDCL4rqHpmo
         EO3H+XEBTcp6zu4/49NDYBHpO/e5peQJ9AgvcT2ODGOl2ZFxbiHlJkw4K7TClataxOqW
         rjiqovTTHCQhFVolKaxAbe3pLr+saK4X/gPp+P82nCaxckSnPZcsSKzpfE/7JHtqRhlS
         1abdc2KLj2IXEzfEoJz5dRYAIXppLWdtCuGMuhrOZ+8Ni2FiDVkcSYUmk1qBBH04dWoB
         ZIhQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/VkfOSuMmf7jRNGIM8b4fh9pNfMlxTempikSITs4I4eksq8UNjUxDVO4HRyNjX9CHBvWd3D9+P6Tv@vger.kernel.org, AJvYcCVRFzRPq1VLBylw5WJu6es0Aeo1WCqEk69nT9hQXMnx4hN91DYTFgO2gtzJJfBb3AKMsB6/fNnglwR2@vger.kernel.org, AJvYcCVw3cQn4UKvrTasTfwC8nzzTynCXAt1KoL1vD7m8UWiBEKxsQPpSseW8gHsMU90ySd8Ld3k3k9dSrrc@vger.kernel.org, AJvYcCWNrJXIb6ViU7PosioOrk0niP7jF9SocMTp1SWIy5OOmzz38NaqVsHiiXxjWtzGjNLAvR/eslSc14Kz@vger.kernel.org, AJvYcCXG1MH511Jk4M/3Q15K8CIUcsbkgmKt7FRuMkrvgRogx1s9LE8jXvjrQi+OPjzolrWmUYuP8X0+UXxrEMAV@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbx63+zffjH7fUPWQkqAKhuAvrYGAXoTf3VmZ2jB1kSOR0Fck3
	VuuHC6ekpMcUkb0cyEKESleW/HFaiSsv3s3eoleHFtCEtKh3d4l+
X-Google-Smtp-Source: AGHT+IEaMnX9f99M5juFDdQtCZlSuDbzfix/UTewKGazKULpgnC6R/ClJ2JcKzAb86RtdywHgYeaMQ==
X-Received: by 2002:a05:600c:4694:b0:42c:b7f9:4bbd with SMTP id 5b1f17b1804b1-4319ad0aefbmr82631875e9.26.1730123234546;
        Mon, 28 Oct 2024 06:47:14 -0700 (PDT)
Received: from ?IPv6:2001:a61:34c9:ea01:14b4:7ed9:5135:9381? ([2001:a61:34c9:ea01:14b4:7ed9:5135:9381])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058bb1bc3sm9429291f8f.110.2024.10.28.06.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 06:47:14 -0700 (PDT)
Message-ID: <3c37f4bf94e0e85c9ecea93b487b7e49a81096a1.camel@gmail.com>
Subject: Re: [PATCH RFC v4 06/15] spi: offload-trigger: add PWM trigger
 driver
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Lars-Peter Clausen
	 <lars@metafoo.de>, David Jander <david@protonic.nl>, Martin Sperl
	 <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org
Date: Mon, 28 Oct 2024 14:47:13 +0100
In-Reply-To: <85184d56-b0c5-449a-9b69-cd141b186d6f@baylibre.com>
References: 
	<20241023-dlech-mainline-spi-engine-offload-2-v4-0-f8125b99f5a1@baylibre.com>
	 <20241023-dlech-mainline-spi-engine-offload-2-v4-6-f8125b99f5a1@baylibre.com>
	 <b47e7168a58e840f65c1ef150c914c077905fabf.camel@gmail.com>
	 <85184d56-b0c5-449a-9b69-cd141b186d6f@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-10-25 at 11:28 -0500, David Lechner wrote:
> On 10/25/24 7:07 AM, Nuno S=C3=A1 wrote:
> > Hi David,
> >=20
> > Looks mostly good... Just one minor comments from me.
> >=20
> > On Wed, 2024-10-23 at 15:59 -0500, David Lechner wrote:
> > > Add a new driver for a generic PWM trigger for SPI offloads.
> > >=20
> > > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > > ---
> > >=20
>=20
> ...
>=20
> > > +static bool spi_offload_trigger_pwm_match(void *priv,
> > > +					=C2=A0 enum spi_offload_trigger_type type,
> > > +					=C2=A0 u64 *args, u32 nargs)
> > > +{
> > > +	if (nargs)
> > > +		return false;
> > > +
> > > +	return type =3D=3D SPI_OFFLOAD_TRIGGER_PERIODIC;
> >=20
> > Hmm will we ever be in a place where a trigger provide might have multi=
ple types?
> > If
> > so, then I'm mostly fine with this match() callback. But we could still=
 avoid it
> > if
> > we use a bitmask for trigger types and having any trigger provider to g=
ive the
> > supported types. Then the core could pretty much do the match between t=
he
> > requested
> > trigger type and what the provider supports.
>=20
> We will still need some callback though to handle drivers that use
> phandle args.

Hmmm true.
>=20
> >=20
> > > +}
> > > +
> > > +static int spi_offload_trigger_pwm_validate(void *priv,
> > > +					=C2=A0=C2=A0=C2=A0 struct spi_offload_trigger_config
> > > *config)
> > > +{
> > > +	struct spi_offload_trigger_pwm_state *st =3D priv;
> > > +	struct spi_offload_trigger_periodic *periodic =3D &config->periodic=
;
> > > +	struct pwm_waveform wf =3D { };
> > > +	int ret;
> > > +
> > > +	if (config->type !=3D SPI_OFFLOAD_TRIGGER_PERIODIC)
> > > +		return -EINVAL;
> >=20
> > Checking the above every time seems redundant to me. We should match it=
 once
> > during
> > the trigger request and then just use that trigger type. Otherwise I'm =
not seeing
> > the
> > point of the match() callback.
> >=20
>=20
> Here it is validating struct spi_offload_trigger_config has the right
> type, which is needed before we can safely trust that the correct
> union member was used in that struct. So it has a different purpose from
> the match check.
>=20

I'm still not convinced tbh. We already pass in the type for the match() ca=
llback
which is done when we get the trigger. I don't expect (at least at this poi=
nt) for a
given offload trigger to dynamically change. And if we do allow that, we sh=
ould still
need a new API to change between triggers (which could then be another vali=
dation
point). But key point is that at any given time, only one trigger should be=
 "in use".
For this first simple case It really feels that passing around the trigger =
type (and
validating on every API) is redundant. We could do it once in the match() c=
allback
and the pwm driver could then assume the periodic trigger is the one being =
use.

Having said the above, this really does not matter that much so I'm not arg=
uing more.
If you prefer to be extra cautious, fair enough :)

- Nuno S=C3=A1


