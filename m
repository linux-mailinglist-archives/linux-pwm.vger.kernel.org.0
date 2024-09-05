Return-Path: <linux-pwm+bounces-3107-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B9896DF40
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Sep 2024 18:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0C24284DF9
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Sep 2024 16:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F9919F489;
	Thu,  5 Sep 2024 16:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sC6/kDgW"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597CE19F479
	for <linux-pwm@vger.kernel.org>; Thu,  5 Sep 2024 16:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725552658; cv=none; b=qQNfbqs8t7m2q3V+3YKqABg4gZ67bTAKnP+oKDktXTPEkAxAIbxys8WMrMBx0Jw8aeqQ9fbFcxrkLe5Vx4VvulTyt2eEIKlQz6zJlGc0+nivVseD3+nw5cVF8lIYLbrztJqU3QrFi3NdwfTvFKTivX0H/KtS6/r1jXkHRqE1BPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725552658; c=relaxed/simple;
	bh=UFsklKB4T8Uv2pYqKRY9mlsDLwYDpsExq9n42ZFvuME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WV14LQJ2WVJ3TlyH+p4LqG0qc5vHGpogADzjci4W/6tzHwRwFUOpqh802WD1lRM5x1TNGN3Zcj/pJRhQLlQUho0XZ69hC8IlkCzKgaLeeOojASxwP2w6zaTAGAgZ2u9aM2/DBznki26m2QpocwmWKDiML8KULH3FzlWRC+d8udU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=sC6/kDgW; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c0aa376e15so509575a12.1
        for <linux-pwm@vger.kernel.org>; Thu, 05 Sep 2024 09:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725552655; x=1726157455; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FmvSoHhDndKZ3y45tzXwCWQPSzV3qf2+rXDuMTj8IDg=;
        b=sC6/kDgW7jbINCIYkTvIYXMV/ncedwGORQW62RI9XFjgtz4/SyJFuZ0FW6TwAF6gdt
         2lBaOIGIL986Lin1uUkGPdxsn9cX7QxTxmUsnzEcHQ7LGrNjDYl5lsUrSQjVsJ9LVqRQ
         dY09iUL19o9vdfDbnln7oxVty/6a22onldPMmVt4EJh7h62SrNMKlQs340ruRlY5bpna
         RrfCDDpujfojcAzBXA6TGWPjE4MnrdHU2mDS+6gAWq956AVUJ1xcrGnDOp3AUAOLSLG9
         tlD1mS+yaHQ/avhQ3mNUwoU5TakOKMRTRRxleRWLTiMGUHxjnIsEVs3IEqhW/136Iowk
         +04g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725552655; x=1726157455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FmvSoHhDndKZ3y45tzXwCWQPSzV3qf2+rXDuMTj8IDg=;
        b=LEZ2pbpsEe3mp2q9aMa+olXy8zde1WWB/E3LWGLaLDjBKaO0ArZh+QOBMzUUOp1JjA
         DaWYTBopRRwKEm/wjbOl8E0CkYB0nUc9qMFMO8a6U9C+L7MZ14yQEi/FgEqMz6oqz6oY
         VSVGiin5NykptyYUOQl2e5bDQhZL6y0bGKVfJQE02I+RZ8B1Hd66QDHChICpwpB4rS+W
         ZEZvItzV3zQ+JoAHgCvVC7ah36HGEyqLVeEm6mBF3FjCoY1AD+vEEVJdAvCKRBXMUIro
         CIQCYanp/8Zl5iDVpNxGxvvfJf7lkkHO0dkFTWJipgXPnHh3BdXCvkuzKXKl4j439qpR
         CtKg==
X-Forwarded-Encrypted: i=1; AJvYcCXoG5Kf5bp9G/yuLr9qNC3AOc9RYKZnp/fPI+pPfBnLewamTlwgJkpqhrJJ2iWiJTxzb/Fgh9GZiCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YynXIT9f+dKZ6adKBc1xB+FfUuc40PbcHDo5gDIug9uBuA6AHXv
	erov/LR3KKVVxzarai4SWAIerWqd2OXxoRgZmvya8+Wwj0JFqOHcSvPu+Jo3GVo=
X-Google-Smtp-Source: AGHT+IG6IDbk7v/HFG6pbnzGX3PkDzdGXmhD8c2zfgnVU3b8YLZ5Kd+Mnq7+b3YgqhjohnggrqFULA==
X-Received: by 2002:a05:6402:159a:b0:5c2:1803:ac65 with SMTP id 4fb4d7f45d1cf-5c3cd78cefdmr3013012a12.21.1725552654495;
        Thu, 05 Sep 2024 09:10:54 -0700 (PDT)
Received: from localhost (p200300f65f01db004d6a46a6454a1385.dip0.t-ipconnect.de. [2003:f6:5f01:db00:4d6a:46a6:454a:1385])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3cc54b287sm1378738a12.30.2024.09.05.09.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 09:10:53 -0700 (PDT)
Date: Thu, 5 Sep 2024 18:10:52 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Maxime Ripard <mripard@kernel.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pwm: allwinner,sun4i-a10-pwm: add top-level
 constraints
Message-ID: <zh5vm65iuzxzr2i5arjpv2m4bfowrx6uyhdtaa5nzdb4hf3fqg@qsnfcyrw54dm>
References: <20240818172828.121728-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="clmudpfclrlqcx4o"
Content-Disposition: inline
In-Reply-To: <20240818172828.121728-1-krzysztof.kozlowski@linaro.org>


--clmudpfclrlqcx4o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Krzysztof,

On Sun, Aug 18, 2024 at 07:28:28PM +0200, Krzysztof Kozlowski wrote:
> Properties with variable number of items per each device are expected to
> have widest constraints in top-level "properties:" block and further
> customized (narrowed) in "if:then:".  Add missing top-level constraints
> for clock-names.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied with Rob's R-b to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next
=2E

Best regards
Uwe

--clmudpfclrlqcx4o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmbZ2AkACgkQj4D7WH0S
/k4nLggAjg/D3fHm7uxQkqwzgFATNnkOhFJd5s1NiHmTxiUQ0OYSXEI4mv4hNxN6
4XtyF8SXGCLWt4T3GDxqM/c5zUTJIc9OxwUfBxud/iP0Ls/MNlCCMdtzJXvhwoMp
TAiu3vhb/cutSHbjPlGQ/A35zl/XDAvXlwxaGJfLIX/y1AkoAIE2nGaLLSQFTv72
ASAeWu6BYbdAs2mEZWVN0ixsqlNVkeHF15+7IQ0uXVs+ukBbVSIZlLkj6PnNcHA5
9MRO7cRENf2OaiO6yzWyeUQDxX0OOz28NNkPeqT6ucEPxNEBE96JJ5yJ4i2ch/F0
CEbdu8DoO/MF82GbO4j3cLV7EdiSsw==
=NPcN
-----END PGP SIGNATURE-----

--clmudpfclrlqcx4o--

