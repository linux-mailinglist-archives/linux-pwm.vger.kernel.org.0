Return-Path: <linux-pwm+bounces-3702-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B0D9A3867
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Oct 2024 10:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6C081C237C2
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Oct 2024 08:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB4D18C93C;
	Fri, 18 Oct 2024 08:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Pi0eGeX2"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B7818BBAE
	for <linux-pwm@vger.kernel.org>; Fri, 18 Oct 2024 08:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729239732; cv=none; b=XMW5zm/xVh87SbQmlDNlPEwDYNMWIpOsV5v3Gp2Q+BI8i2naPWs2qHFWKvJ5dCqkucfrLBspX7tHkX2EX1umy1ZQsLn6+CGBoLksJL8LnA69D/mvhIiF2CpFuGzsb+4tNlyo78sUUSqregDPd+6yvKS/l9b8lRsfcrMEZ1ypfnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729239732; c=relaxed/simple;
	bh=PfoSX0vcdBGqEulNMTI8N3WIvciODyJ+lN0v+XJikqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sdjB74e9RZnzM/5031Am/6nO1XSdy6zjuB6z6i+r0y3b151ESIIGqWgWGUaCOvEMe33LK0Oq5EKxdvPi7Kcw3TzZozxIhjvzXyZpme+fU+/yiAxfRGuicguaTYXPCF38MnX8FFoQpRFaASfg/VoWeTUGr/zRyxT0regxmNwIliE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Pi0eGeX2; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43118c9a955so17425185e9.3
        for <linux-pwm@vger.kernel.org>; Fri, 18 Oct 2024 01:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729239728; x=1729844528; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=srHDDYC+Ycf+RS8B2njBjHCnByCJ7cEy0nSCZb8/0go=;
        b=Pi0eGeX2yN1eiiiICXUvntNDk6+mkyNwQfNiP7gQAXvXlLTHVkgvB2gBk4/56l0nDP
         R681eJUNV+7SAxujjd0MXUgyxXM4vlaoZfq+JOlNlt620K2A5qIMUw/BalzmxxEtwT1v
         uhYFnmnzsfvaibvSplL9KAXPZBrDVR0WliV4KrSKnQAi+cxz+C3f3XFM0BbxrGjTvP9B
         Ti1hDH95//Tek0TMSwaeC+esX7CyckkolE5l83LeKQhagtfBAQQvDmn80J0OILhK+bYL
         AFVYJFA3cZuggmoEsjp5md4M2unIldng/b2xBfBQ67+7pP/NWZ6Kv6Y4buFyX5vDsTV0
         eppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729239728; x=1729844528;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=srHDDYC+Ycf+RS8B2njBjHCnByCJ7cEy0nSCZb8/0go=;
        b=woNIhYRFPg9sLZfCpb7xZ3cG4C7pWu/feOiTtOspWCAnyPnQuqScM93uVseq5YRYU4
         31iakyCXK9J8VMumkzLAqN8XgSpSvHqq11VX3cakBjD8m4yAk8GpZ0FHT3FjuRdXnZaH
         UnPhfPbpIFgdSMsQ9oITzXTxhpzcxQ/YVZ4KAaQHTSPCUhQf4kY0HIGR/4avLJIKEpqm
         9fUuaCWt1vHibrtmyQI1qmdldv7YuZJp7nQE7cuon9lCfZP5uK/lvAA3czbaPz+fIEQL
         0WakKFnyKg5NGRbieJpPavuNf2T9KpX3iuGfVvBMbSofO6AeMXjjQM5DO5DSrDIy82ie
         cYhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWORAsIc+LmLXFs+enkeNvKBQvMFH8K7fUcj8pVlW4y+F/d3RicIxjhhAqzir2+G7ynaZVnYKSdMag=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzs5kl8Jrln0cbVeXMETzEdNxhPfe28qbzGCv+pDY4k3FIgsPY
	xAFEgYcP1qiPWnW1uu98xMbPgO8BbnnbJFkwC5pBDbQitqB2SFO4fJvJ0XNwr8o=
X-Google-Smtp-Source: AGHT+IGq/Xim2TdDYfZf2FCKjA4VwApeCGC93blGWI3Ut+huAOlhSQ88nXziiEC+W5XrM+cQyw5AYg==
X-Received: by 2002:a05:600c:1c0a:b0:431:40ca:ce5d with SMTP id 5b1f17b1804b1-4316169a5c0mr11344205e9.23.1729239728199;
        Fri, 18 Oct 2024 01:22:08 -0700 (PDT)
Received: from localhost (p509151f9.dip0.t-ipconnect.de. [80.145.81.249])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431606ab65fsm14691865e9.1.2024.10.18.01.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 01:22:07 -0700 (PDT)
Date: Fri, 18 Oct 2024 10:22:06 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Sean Young <sean@mess.org>
Cc: Chi-Wen Weng <cwweng.linux@gmail.com>, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, ychuang3@nuvoton.com, 
	schung@nuvoton.com
Subject: Re: [PATCH 2/2] pwm: Add Nuvoton PWM controller support
Message-ID: <obu4hy7dwioinyn3npwy42lwmijd2sctdsy4b3lad3d6bfvaq5@gzbcnua3unuv>
References: <20241018034857.568-1-cwweng.linux@gmail.com>
 <20241018034857.568-3-cwweng.linux@gmail.com>
 <ZxISVBz1Os0T4eqP@gofer.mess.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gelwutqfbadgpdny"
Content-Disposition: inline
In-Reply-To: <ZxISVBz1Os0T4eqP@gofer.mess.org>


--gelwutqfbadgpdny
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/2] pwm: Add Nuvoton PWM controller support
MIME-Version: 1.0

Hello Sean,

On Fri, Oct 18, 2024 at 08:46:28AM +0100, Sean Young wrote:
> > +static int nuvoton_pwm_apply(struct pwm_chip *chip, struct pwm_device =
*pwm,
> > +			     const struct pwm_state *state)
> > +{
> > +	struct nuvoton_pwm *nvtpwm;
> > +	unsigned int ch =3D pwm->hwpwm;
> > +
> > +	nvtpwm =3D to_nuvoton_pwm(chip);
> > +	if (state->enabled) {
> > +		u64 duty_cycles, period_cycles;
> > +
> > +		/* Calculate the duty and period cycles */
> > +		duty_cycles =3D mul_u64_u64_div_u64(nvtpwm->clkrate,
> > +						  state->duty_cycle, NSEC_PER_SEC);
> > +		if (duty_cycles > 0xFFFF)
> > +			duty_cycles =3D 0xFFFF;
> > +
> > +		period_cycles =3D mul_u64_u64_div_u64(nvtpwm->clkrate,
> > +						    state->period, NSEC_PER_SEC);
> > +		if (period_cycles > 0xFFFF)
> > +			period_cycles =3D 0xFFFF;
>=20
> If a period is not supported, return -EINVAL - maybe even do a dev_err().
> Same for the duty cycle above. It might make sense to calculate the period
> first, so that the error is more likely to be about the period than the
> duty cycle.

That's a wrong advice. Drivers are supposed to implement the highest
period possible that is not bigger than the requested one. So clamping
the value to 0xFFFF looks right.

However I wonder what happens in hardware if period_cycles =3D=3D 0. If that
disables the hardware that is something to catch and return an error
for.

> Then again I don't know if all the drivers do this, but at least some of
> them do.

Yeah, and I hesitate to align them because their behaviour might be
relied on. But for new drivers the above rule applies.

(And with the new waveform stuff, consumers can rely on the rounding
rule and even query the resulting waveform before calling the equivalent
of pwm_apply_might_sleep().


> > +	chip->ops =3D &nuvoton_pwm_ops;
>=20
> I think you can add chip->atomic =3D true; here

ack.

Best regards
Uwe

--gelwutqfbadgpdny
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcSGqsACgkQj4D7WH0S
/k5R/Qf+OhKRH7FMIqfL+DOoX2BNksRDESeq3YgIfF/4QcgEHT+rqkeAMyx4ogd1
A53Z2Ctl83dbogKFMbkh/T6mIjoUBldHzJCtXnHKPkBX+O9G5ZfmUdxhdOfflM6f
qse1Nw1AFAOsSDMB6pA3SQdFiqTrCoJhvSH6/JGU91SqhqlV5CEV41UEbC0LmixG
GoVA9CLC+nXpIF3XdqNODyHm3W0Wd5ISbRYEMNuAm1fTWReZfSkESPiVPINeitfA
O1fqKI+XvLMloIiVm8c2hmQk8Ey+aBh+4k5k4/eqxWx2A+T0G2tgx0i4ClvdKvkz
0MfiT/P4Zorru85PUPiJLFu5Q0E95g==
=ezQS
-----END PGP SIGNATURE-----

--gelwutqfbadgpdny--

