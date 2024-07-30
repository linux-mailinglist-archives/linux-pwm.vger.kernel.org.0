Return-Path: <linux-pwm+bounces-2938-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3200941535
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Jul 2024 17:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 000081C230AB
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Jul 2024 15:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB091A2C1F;
	Tue, 30 Jul 2024 15:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GmYNc+ep"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64AA19F460
	for <linux-pwm@vger.kernel.org>; Tue, 30 Jul 2024 15:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722352445; cv=none; b=sxxHZN6bZpUhxfcSGfJGJGn5Mv2uVjd2KvDx9o5dc2pNSgWdPO9CVeCyNoeT5EGXxxG3jrji/Y9Qv0a7ZmE/JiXeHKwtvfALxV0bbWB3ix3IfFngUQeY3/I4VG6vOi5RjxePMRqi77Fmy7vBVrz3RANkIsVlm8YHuPpMphdlz2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722352445; c=relaxed/simple;
	bh=AdTHQeQ7kLyo3mfmwgSTm9XPXXY74L+sdG/PYhBWOtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pDTGxi9fvuCrHcW5EBlHWjcFMSikD8G4bDzw5/o1zD4tVxdC0pBBty171vU9taOMOdi5CoGo3cHiS0CeiyqghkwMbK35/xLIe4R1vSP8l48FyDa0tn6ytJa+Gbt56d98T5kyah9sptbz+4Ld3geHQ4nO1byK4Eug1WiuD08HwK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GmYNc+ep; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52ed741fe46so5222677e87.0
        for <linux-pwm@vger.kernel.org>; Tue, 30 Jul 2024 08:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722352441; x=1722957241; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AdTHQeQ7kLyo3mfmwgSTm9XPXXY74L+sdG/PYhBWOtE=;
        b=GmYNc+epkEPEL6F3gkJQVfz2nwQKkQyjVDnt1xU3BDsuQVq49zXldJzXvsZvSPedAl
         xJvrdaui8t8p6llOi4hfo29LXpEGCZQ3mqan+i+vO+kZv3sZR/Qsk2zr/HhmFpigS9nh
         4RqB1ocIrsXCGuM3gLW9jhTSiy6cNhVMxOtyDmkgmN+z8AwkRg8n2Q8jeQHViVy1W/1q
         mKxa4NKrcWz6CPB3ynux4pauNsPsHMD068WtrdHjFw1+aUZd57+0gm1mbGYzMDKUbCt1
         N8fx7bM9H2p/UeTuZD5IgjivGJ4EfsqQbyMm3Jmsq7QPhXSD0BDYYXTPIqBFQXuenU+H
         Aokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722352441; x=1722957241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AdTHQeQ7kLyo3mfmwgSTm9XPXXY74L+sdG/PYhBWOtE=;
        b=oiwpV5CESvM7OHsrFC019a9dze48PrF5dzKK1MRRKQWYw7hgFXmROhZ7RwbxAHu3b3
         YH1+uGEbVZyr4NqhV1RggQYgnornK1k5KralUEIx97iOzxqirdDJXrzHEBXMS1z6EhkE
         OnE0PWDBFlmkDs6Zj7XJ0qfZOwa0SXCq7puFvMKOEdM7GDEN7GTp+1RB5KbWVWyTlkCU
         jHCS2HsW5CJ+36h55kc3LwEVWE+O2q8w2NOHZysb0/qSuoQ+VQbLEBZUZtEGSIQZsMPJ
         eR7HFWlo6AOorT4iAIhsAlDK5gGBH+KCe4rmr6lpItm71uDk++sltjwmGOPFHhzKuGsd
         ZbGg==
X-Forwarded-Encrypted: i=1; AJvYcCUfpDwhL6AwxBV7VrNvjPaIEYTIskNwTKsZXGHg531wXUUpULyPrMWbD+zuArd/klgDLeVtFsaz/tEw8802xTnHow4GAh2u9Ily
X-Gm-Message-State: AOJu0Yy/CnFrL+O5ezhtsyAH32BIcElgAH5iguWcmcDxPT/gcnIpnFgM
	5Z5XkNHDKmJihOJEQvuGvgF6++e6EDWy2uBvUwKo9mmbBBR+s6DRgygfHyUv1z1VplW77gYuA6Z
	z
X-Google-Smtp-Source: AGHT+IGLH7u6gNvmP31iep2dgQ8sNneBa4byGkknFmkyHaJGeb6F7VEVA6LUgnVJgSR4NXzXiXtiLw==
X-Received: by 2002:a05:6512:b8a:b0:530:ab86:1e with SMTP id 2adb3069b0e04-530ab8601femr1807985e87.6.1722352440709;
        Tue, 30 Jul 2024 08:14:00 -0700 (PDT)
Received: from localhost (p50915eb1.dip0.t-ipconnect.de. [80.145.94.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad91010sm658249966b.172.2024.07.30.08.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 08:14:00 -0700 (PDT)
Date: Tue, 30 Jul 2024 17:13:58 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: Make info in traces about affected pwm more useful
Message-ID: <pmz5sgzaroljhbyeulvh3mf6izhwna3d2mjueo3udosy45uza5@5dljnvmtpu5v>
References: <20240705211452.1157967-2-u.kleine-koenig@baylibre.com>
 <qye5vuh5hzoemdciohq3x4oofjpvw6pwe777loqacqfmhf4grg@5gtprhv3g377>
 <20240730103910.6de49acf@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ri2nz55ffg37fvyu"
Content-Disposition: inline
In-Reply-To: <20240730103910.6de49acf@gandalf.local.home>


--ri2nz55ffg37fvyu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 10:39:10AM -0400, Steven Rostedt wrote:
> On Tue, 30 Jul 2024 09:22:53 +0200
> Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com> wrote:
>=20
> > I think the patch is obvious enough to be ok even without the tracing
> > maintainer's blessing. I applied it to
> > https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/=
for-next
> > .
>=20
> No problem. Thanks for the Cc. I don't always reply if the patch is pretty
> straight forward. But I do look for things like holes in the TP_struct()
> portion, that would waste ring buffer space. As well as uses of
> dereferencing pointers.

Looking at
https://lore.kernel.org/linux-pwm/7b9c9ee490df1df1de3bbfafd501f45c6cb2ec4c.=
1722261050.git.u.kleine-koenig@baylibre.com
is this also in the "straight forward" category? If not, some feedback
would be appreciated there.

Thanks
Uwe

--ri2nz55ffg37fvyu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmapAzMACgkQj4D7WH0S
/k4QMwf/dmmEA3gl+PIcynIa/JtYamuZSqSBc7oJ9ffWZ8YdfNaMUlcQa16DmIl/
DA5Rg8eX6Y8/ZARJG6xgB8dqgyZFf2al2+oPTE/BOiL/a3qWLsKwlJlwrQ8/FYfc
R9WQtlOYxcRO7L57iGoPR4zQ89y+UiSy0IL57O02NxNSXE130TSB2Ue7gmDEXFn1
PL571J86vCnGNaX5odZsYU/d0ZtsFX2GkuU9sk4W2i+JfZz8s3geDJPGnC0/14SI
xVHneq/7Wgqy7xDM7O/glS1BmYTjbi1P9qYR3cLhaM/sx8xVRg9DbmIsAeZc+c6M
2mCsgAd8lCb8x0Xm8hetCjylkXs/1Q==
=dJbl
-----END PGP SIGNATURE-----

--ri2nz55ffg37fvyu--

