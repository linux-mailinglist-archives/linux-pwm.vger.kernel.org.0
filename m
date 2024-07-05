Return-Path: <linux-pwm+bounces-2713-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED810928F60
	for <lists+linux-pwm@lfdr.de>; Sat,  6 Jul 2024 00:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 978051F229DA
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Jul 2024 22:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1256914533C;
	Fri,  5 Jul 2024 22:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qNIIt0re"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DA7A955
	for <linux-pwm@vger.kernel.org>; Fri,  5 Jul 2024 22:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720219331; cv=none; b=EYzjVXQEdZnClX1X/Wx2lKZeMYDAOWHRHZvn/3AebK43uQi+dD6rH51ypSlmwEOEB9HMAp11VCuUu664zveMven7MBk9RyAhl7/MdECXWUAz4MNt88zHUMSszrJManSC5PDDros99q1m8eDRRGgrRwhiLz+CZuJWzYx3oR4iJmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720219331; c=relaxed/simple;
	bh=+1Lr931Ji2xs5C0zMhD0sH6nldfcx+12+E5/gBrSJBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8ZNrisVgFo25HYnTtgcRv1+ggHdpopANV8ML9aXIqU9dEEeq9TVeKd7Euq9GmkBHlFnuJYLP6NQWP2gpG+zaK3Oc4LzbPoRHKK50smyglmRiiu6sUToF68c/OVsaNeAcVGSqdrkcCWFxc4hXuxvFHqilizhU55aXT5n+Cf0CBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qNIIt0re; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-58bac81f39bso2721846a12.2
        for <linux-pwm@vger.kernel.org>; Fri, 05 Jul 2024 15:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720219326; x=1720824126; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mUppU/lkzU3xzcHPedeqIyGAOs2uN9mWGr+GLHwrHbU=;
        b=qNIIt0reyc5DC7Ai2eHw4A7bfvubtqp25Mh2iTUY4vkjvf77J7E1c0W7/L7193pSe2
         fPgn8nY9Hs6KGSdaRet/5IFH/mWeG2SyhHUiVu6POJDhGfRbkzV/EqNUGQirdFcgvuuR
         vIR8Bw6Bs3EajE1dcw0F3e8ENDUDh5pai+KbRzcIvTRCObjAxrczwfQmpPUpVzf5icVs
         YHrxb2LMXvUMZmvrEbVNNhQ1NIE7NOmJxkynTDCIoh//cGlOSXA3u6peJZx5HRaESOh4
         JoiprlI9qz3faHwlz6KYMXRXv96A979jJAuevNoq4zdhOFN5qGOowJLQndRvXMWZj7DB
         +iIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720219326; x=1720824126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mUppU/lkzU3xzcHPedeqIyGAOs2uN9mWGr+GLHwrHbU=;
        b=IMSkWGBvhWPdaiLYTN9DtwXQJU8LLv03PSIrYzdyCxb12NX8NSr4dTdYaP2swEfKzV
         oDOucpUD9WRp/x5E2xUYeTggz87yCMxKYq4CpHR6MXt7wBCHeTA1I/YEyle4y065myYT
         3FSRevesgKM+YXfyRd0At2BMWIuL9Z7fNmuJ+YicMVZXctMYGbb02f5MJ+kKyHFab3iH
         QnFPGH731HJtluxLk01u/PPZpd+3unzAHB8+AJQgLr5t/ss1WCsz0KlY8GHgMrjErNpv
         cXfsSY4O+idkNKAqnykPnw/TekCGNePSJAS6fBi6LoHsEHN0TjD/VOPrsEsZrfXGRbNr
         p+Iw==
X-Gm-Message-State: AOJu0Yxn55p2kqPuEAm41kUKBhq4TP5SC0VeoeIuv/PdoXryGGRes/6z
	zifNidjFSeAmTtbbPmreOoeRUFzMhzQHIgoOD+gunXVIuC2MUJEGhpv9I0yaTtE=
X-Google-Smtp-Source: AGHT+IFZWboItQiUJ7AeUQsVS+Sh3p6421pIOvP7OOoXRqly+gYjGtaBz5w2pohD9dZz2VYUXg+IUA==
X-Received: by 2002:a17:906:f296:b0:a77:cdaa:88a7 with SMTP id a640c23a62f3a-a77cdaa8ac0mr196896266b.48.1720219325508;
        Fri, 05 Jul 2024 15:42:05 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:5898:1844:403c:d2d6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a77dea1d4fcsm32264466b.127.2024.07.05.15.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 15:42:04 -0700 (PDT)
Date: Sat, 6 Jul 2024 00:42:02 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc: linux-pwm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] pwm: stm32: Always do lazy disabling
Message-ID: <kanykpgvxz57wuv2quejts3r32shfiwew2nangl6bn4qrows6m@7h2rchpeeemc>
References: <20240703110010.672654-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qofqf7sh33crvhqo"
Content-Disposition: inline
In-Reply-To: <20240703110010.672654-2-u.kleine-koenig@baylibre.com>


--qofqf7sh33crvhqo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

[Updated Benjamin's email address]

On Wed, Jul 03, 2024 at 01:00:06PM +0200, Uwe Kleine-K=F6nig wrote:
> When the state changes from enabled to disabled, polarity, duty_cycle
> and period are not configured in hardware and TIM_CCER_CCxE is just
> cleared. However if the state changes from one disabled state to
> another, all parameters are written to hardware because the early exit
> from stm32_pwm_apply() is only taken if the pwm is currently enabled.
>=20
> This yields surprises like: Applying
>=20
> 	{ .period =3D 1, .duty_cycle =3D 0, .enabled =3D false }
>=20
> succeeds if the pwm is initially on, but fails if it's already off
> because 1 is a too small period.
>=20
> Update the check for lazy disable to always exit early if the target
> state is disabled, no matter what is currently configured.
>=20
> Fixes: 7edf7369205b ("pwm: Add driver for STM32 plaftorm")
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

I applied this to my pwm/for-next branch. I applied it directly on top
of my last PR to Linus and rebased pwm/for-next on top of it, as it's a
fix that should come early. I won't send it for inclusion before 6.10,
but if another PR will become necessary before 6.10, I'll include this
patch.

Best regards
Uwe

--qofqf7sh33crvhqo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmaIdrgACgkQj4D7WH0S
/k5e8Qf/X6nczzHSx3sD+fghW/1L2ZuyMey9JqaDIh3XV/9CLj2kB3b7YgQ64gEr
HDr2vAUfUDXyutAf3CGmR0fpoVcBM1SUd4l2ZDdR6R1Ts2gfK2czk2UoWp82WEmK
t0M9e0wi4S5KKkxLtOWn0CeExH1zSNM7tXJ7EjATW6miL/mqSJdi4ifmKWFho3Vi
UuT4BpZcDjhzVH8gKxmlmALa/0prq62ogPuDHAbHjQ/jZ++J//25xh1/S5DVRKMx
eq+7cPZJJIPPR3qTjgSD62HDC9h3w5m5JvDfLb+gtSkAS8iCc6WxRUbZ/bc4b8nf
jJZvg3/y5wWY/atwKFuLMnaAUkGNkw==
=PxZ8
-----END PGP SIGNATURE-----

--qofqf7sh33crvhqo--

