Return-Path: <linux-pwm+bounces-2639-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A1C91CB99
	for <lists+linux-pwm@lfdr.de>; Sat, 29 Jun 2024 10:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A3111F22451
	for <lists+linux-pwm@lfdr.de>; Sat, 29 Jun 2024 08:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BCB3A1BF;
	Sat, 29 Jun 2024 08:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VrwDDKk4"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4E63A1AC
	for <linux-pwm@vger.kernel.org>; Sat, 29 Jun 2024 08:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719649051; cv=none; b=mHZOwG9kvvB7KZkjle4aAH1+JK6Afkhorj9yvVxt06aGC22mlPrqfTqP+h0xF7naCJKJA1jVlA7qYpCBdQ46Idk9PmMkuYAwv+OuCnud/x05mL9p7heQnF4ZecID5bpUAeki3MOAr7WszvdU6Qp1M+0J8tREzi3TgBErcsYv3q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719649051; c=relaxed/simple;
	bh=ayjBcEQKA4Ll4QwqUqCL6HvI83JUCea8nFYi8awxJqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6GeI0bOY4zqq1xZFfkvIPhQq7RBSnYOfk2WXKR0/tcTXEd7Qz7DTZjX3JGQi9hcptunDm9UooNPsBQhspjYUO1qnbG/0OCl+2z8CJ6oG3TpXmmQkKmNp5sZALGoJvy2pr4Q7Xp0Ke3nnNWM6bX2ZU6NrWamZk20AWt3obXgBZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VrwDDKk4; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a72420e84feso152023866b.0
        for <linux-pwm@vger.kernel.org>; Sat, 29 Jun 2024 01:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719649047; x=1720253847; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hFaa5lZPC6/4MVkyn0qm5qxSaMmctli5pzYHlowJHrg=;
        b=VrwDDKk4KVoVH4bTl/4pm8HbfaWsbA5eeimhvlhoXTUEu8H0Qwm4lhJZFYJpuX+Cai
         dU8uxWJpE4E/xKihIO0cVe4b1hdhYJPiWVeft461X1h8uZ1zevIeTrOCYWReemL89ZGs
         jM6P+fi/2pvD39jMnTvZg5VDUOHcVvXhuIWBcZwuBuh8ZKDn3a3S/CEaY4vqIp5lKNNE
         l2BsD5dmxAbXUVNWawH8Pjd+64JTZnKvQWaCTUm8WHznTuolazW9j1XmVMNFG+6HbUm5
         pNJmsC7MkFjlj8jlkQa1HuVWdW1hY9HYebfccU3UrYf2ZyD4hg/0TPyKGikO6jZwJnZK
         ZPyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719649047; x=1720253847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hFaa5lZPC6/4MVkyn0qm5qxSaMmctli5pzYHlowJHrg=;
        b=Fj9zaKhH2HSKrzJJt+hwCCk3S41y2OVC33NO5MBv5o3kN4Ud5I/+yiiitOxmZFkkEH
         9laEthLxT4DS/NsKkRgIq7mFf263CzvWCTXswKi0ohDnJshhNUf2Mg8ldlFxgsuI40/n
         iNdBRgVxjpTJCRtBNdvRW4/Hs+3C0jm9emoDUZtpRe238uUjnsDayOQERIcO7UlL/Gbq
         bEqB9FcfMamY7Rum6Nd8fyrfrb869xJCA6lljjojDnomsyAQE2n04l0roE+mvaTvz0L0
         ZFW6XLP8HG2D4TcgzSVBlkVNEkrslQMYgnkK7gqq/EQD4I/BMiT3aL6tXe+YLxAsLwrf
         9fRA==
X-Forwarded-Encrypted: i=1; AJvYcCUKUxVq+AF+DSIWrYUppbKxBT2wMTykBopBslJRZl7Aq2K+grmROblvoxXW4Hrd+EnQXTfBv2QQHW5GxFeJmYJqMKvtXi7HoVms
X-Gm-Message-State: AOJu0Yy2WbvP0NWf5Ci0MLCqLFGcc6vUvWKFasX7ARv9KIV0YeZSfoI8
	tbvBzCHoThx/DHuMFcGC8vIAVJjuiqrAYDtbJeajdwrAMNoUsN6iMUmcnNtiS48=
X-Google-Smtp-Source: AGHT+IGWVtvMZoMdHAjt86iIdZkY95urg35Hr65e9D5aIHiB4jdN4b9pUH3SsWpl3h4KU+OMMfFoWg==
X-Received: by 2002:a17:906:a083:b0:a6f:bafe:d658 with SMTP id a640c23a62f3a-a751455bbeemr27018366b.68.1719649046516;
        Sat, 29 Jun 2024 01:17:26 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:850d:6139:5a25:72d0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72ab065241sm143565866b.108.2024.06.29.01.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jun 2024 01:17:26 -0700 (PDT)
Date: Sat, 29 Jun 2024 10:17:24 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Sean Anderson <sean.anderson@seco.com>
Cc: Michal Simek <michal.simek@amd.com>, linux-pwm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] pwm: xilinx: Simplify using devm_ functions
Message-ID: <6rkltdvnlvbwuvo6i6m5yxms4zquajowdbvfzvyocrswggigq6@beosz2owe42w>
References: <20240628063524.92907-2-u.kleine-koenig@baylibre.com>
 <4a8452c9-9991-4bed-9210-e369bf11818d@seco.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2cd2sjerw25a6vu3"
Content-Disposition: inline
In-Reply-To: <4a8452c9-9991-4bed-9210-e369bf11818d@seco.com>


--2cd2sjerw25a6vu3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Sean,

On Fri, Jun 28, 2024 at 05:04:47PM -0400, Sean Anderson wrote:
> On 6/28/24 02:35, Uwe Kleine-K=F6nig wrote:
> > -     ret =3D clk_prepare_enable(priv->clk);
> > +     ret =3D devm_clk_rate_exclusive_get(dev, priv->clk);
> >       if (ret)
> > -             return dev_err_probe(dev, ret, "Clock enable failed\n");
> > -     clk_rate_exclusive_get(priv->clk);
> > +             return dev_err_probe(dev, ret,
> > +                                  "Failed to lock clock rate\n");
>=20
> Isn't this actually "failed to allocate memory"? clk_rate_exclusive_get c=
an't fail.

There was a thread about clk_rate_exclusive_get() and its return code
some time ago[1]. I intend to pick up the discussion from there, this is
a preparation for it.

So yes, devm_clk_rate_exclusive_get() can only fail with -ENOMEM, but as
this isn't obvious for a casual reader, I like having the error handling
using dev_err_probe() in place. And since commit 2f3cfd2f4b7c ("driver
core: Make dev_err_probe() silent for -ENOMEM") this is also fine (at
least IMHO, I don't expect to have the agreement from everyone).

> Anyway,
>=20
> Reviewed-by: Sean Anderson <sean.anderson@seco.com>

Thanks!

Best regards
Uwe

[1] https://lore.kernel.org/all/cover.1702400947.git.u.kleine-koenig@pengut=
ronix.de

--2cd2sjerw25a6vu3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmZ/wxEACgkQj4D7WH0S
/k4h/Qf/b3IqAM+7f1Jr0vFW7q69J/3X5S9CaQxGm6OZIt3Ph1tGsPVnjoONpg0f
iVTL7v8o4wvICX9N8D07oL/Bj1M0cbTNoHCrdx06W3dSKOlc1SwXKKKQ/8oIWJSF
DmJEv3o06W1DQTbE3YuSTljKnSGEQ8cBy7pK3DDCkxQFoCAfaGedaaE4BCQkALHe
TAUH6L5WcvNZ1rNezeFi30/A3vM2FiiUexNz3XeUIG42gHS9tNGT7/KoOftznrlL
iC5FEC+4DK1JCiGT/rHBTIidiliUd1UFNa0XQeqNw3+5Ety5PI5T7g9X1RmkxUTY
y2uvKzKTKpce6OV32vxYciQnKmyoVQ==
=HozB
-----END PGP SIGNATURE-----

--2cd2sjerw25a6vu3--

