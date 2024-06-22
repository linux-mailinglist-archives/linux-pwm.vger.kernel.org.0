Return-Path: <linux-pwm+bounces-2586-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F5691345E
	for <lists+linux-pwm@lfdr.de>; Sat, 22 Jun 2024 16:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 958641C20FB8
	for <lists+linux-pwm@lfdr.de>; Sat, 22 Jun 2024 14:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103A316F0ED;
	Sat, 22 Jun 2024 14:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vDNhEICh"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADA479FE
	for <linux-pwm@vger.kernel.org>; Sat, 22 Jun 2024 14:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719065277; cv=none; b=iRtyKmRODmsJVUoj59CHoVOID/DoWYyEshDUlwgWRh2/2Ikv/yPRfF+Tt7Tio/ge2g/BC8zlgmrGYJCYG08hs0XM8hyj/QUJq18/hh2jCb9V7GOYQD7dQSpaTb3gvZJV3jCVXbCNo7bB+8LKr9BhQqdEKRQbT3jJ2f+6XoPv+Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719065277; c=relaxed/simple;
	bh=FPVH1TteRbxp9czl3tIOmPxu8rGiWbUNY7b39N29WMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0pqgXH1qrbK3GiAjVfVh+DduF4qhN0PaDpCpQ3d4kiKuNNduhpfowuHk/5xZ0ZwvIrT05MVoJuxKCJEX35A+kSpPchm+BydyxRI26CKdDMYPN7EIVEEzWbffDFCgrQimulZV4HwNY4wHHsmYclqUWwtrZZejfcKRSWbc3UuaJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vDNhEICh; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57d05e0017aso3526977a12.1
        for <linux-pwm@vger.kernel.org>; Sat, 22 Jun 2024 07:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719065272; x=1719670072; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BK0EhhhBCYtUMCJbzDEEL4WU+z+5yU92rq6hn7UNZ24=;
        b=vDNhEIChvObWjIzfovJhQl/4GwVkv77kIUfEKxfMmGvvuXbw03DM+BAbG6pV3GhI7/
         Jmn1CSa94S38jlwTrRsTXp/03phiCSKksRT1YMXiHGf9enhYm7ve0OCbPbdTRf4QgEOI
         hx+aTLcv853J1QcDDfb+M0knu909t0mxVKlq4UavWTL7jJISi23jbDVCMeOsoGebOktv
         wKZM6bEQzHgmYseoHp/a6piUZ5dzkVbchj6I5TAOPXm/TsHxw1QAjqtX0hIjhSxVIic8
         uMji0Fv174IPIg+pioChCVkgjpcAkP5ZZIWDpjnGqvLiJw5GwD23XwG6JeoniJG+XTNa
         C2Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719065272; x=1719670072;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BK0EhhhBCYtUMCJbzDEEL4WU+z+5yU92rq6hn7UNZ24=;
        b=SkyqiTvuy+sNlOUqgYQu4eONC2c4cng33wv/4H3Ot4HtN29Xvtfiuoj6yfi+X/spc9
         hYVFQx/DXobIb3qa8jYzE1XMpwbrnddNNajRDhMmo5OaqcgebWIFukY28/QnM5cT2Tlq
         uMZaEnFFs52AaPJdtcSogiG6EVlNJHHSYOdq0MDnWEhcvTjc1y4+8bpF+u3r/Drf4QYF
         trJpszbqJTcWEq0KbZvP9yi82mHFimFgmTsWFqhprUwFV/oK7e8bSJUNWx00aNkZ5ocz
         knyeWM9DPpZyAOQIgg7BdfeoKcBgg68qnEMZyjtZycoW1E//nXMiAR5v86Oq3Sb6Gnbd
         1pGg==
X-Gm-Message-State: AOJu0Yz7V3/GtKXR+/R2Hg6knwYd4H925vRGfyJr64CYy1rv61Skt5TE
	n/qdkNpQMpRObDCCEBIpys3Odlnw3+cUOxDA7EIaCJB8aJrxkHYemNsWjFuN0sM=
X-Google-Smtp-Source: AGHT+IHwluZDp5WwQw/tD8WvRLjvWrGRufevjUZLgIGvFz6tE8OA3yqVKBnNAzr1zNc4P+Xkq4NUBw==
X-Received: by 2002:a50:d7d4:0:b0:57c:7599:2c67 with SMTP id 4fb4d7f45d1cf-57d4580ac7dmr693637a12.37.1719065271532;
        Sat, 22 Jun 2024 07:07:51 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d303d7cdesm2387852a12.7.2024.06.22.07.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 07:07:50 -0700 (PDT)
Date: Sat, 22 Jun 2024 16:07:49 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Benjamin Gaignard <benjamin.gaignard@linaro.org>, Lee Jones <lee@kernel.org>, Thierry Reding <treding@nvidia.com>
Cc: linux-pwm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, Trevor Gamblin <tgamblin@baylibre.com>
Subject: Re: [PATCH v2 2/3] pwm: stm32: Fix calculation of prescaler
Message-ID: <xg4lozixh2ovalz74a7ijvjvj3x3nd3eqllup7m7fdq7xzgaql@sl74jicch5a7>
References: <cover.1718979150.git.u.kleine-koenig@baylibre.com>
 <b4d96b79917617434a540df45f20cb5de4142f88.1718979150.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7lyhdyhwialvkaa3"
Content-Disposition: inline
In-Reply-To: <b4d96b79917617434a540df45f20cb5de4142f88.1718979150.git.u.kleine-koenig@baylibre.com>


--7lyhdyhwialvkaa3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

[Dropping Benjamin Gaignard, his address doesn't work]

On Fri, Jun 21, 2024 at 04:37:13PM +0200, Uwe Kleine-K=F6nig wrote:
>  	prescaler =3D mul_u64_u64_div_u64(period_ns, clk_get_rate(priv->clk),
> -					(u64)NSEC_PER_SEC * priv->max_arr);
> -	if (prescaler > 0)
> -		prescaler -=3D 1;
> -
> +					(u64)NSEC_PER_SEC * (priv->max_arr + 1));

priv->max_arr + 1 needs a cast to u64 as max_arr is an u32 that for some
hardware is 0xffffffff.

I fix that when applying.

Best regards
Uwe

--7lyhdyhwialvkaa3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmZ22rIACgkQj4D7WH0S
/k707wf9EYl9VJK32e45RKA2u+UltCCD+nktNjN9VBiS2/HF+EOoHRqhaNs0x0Go
2xSr7aY3QdATUVkJbvr3L4uCV0TDRxmYUHPSx7qsno5gvZNkJ6HCKbKh4ELg5P3b
xkXfQ/7ja4W3I9NF9iGQ9hp5Z8VPvepyj2F4a6l0d856oqQSylaqGiVUBs9nX5eY
4Q1nhMIhbjVsirVT2mHnTZX1Z050XylfAOnqObF5RsbpG2EueadCL4OUV7wtKYbd
9EMou0ykxA5XmaQZECtU4MhZutMGYxTqr5aP4lKZx1QOxIjx7GQ6N4+fB+QNIwRk
UxBpZV4ZHBwRjrbESc1lCzQuBNhOtQ==
=1r5L
-----END PGP SIGNATURE-----

--7lyhdyhwialvkaa3--

