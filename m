Return-Path: <linux-pwm+bounces-6930-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F2CB18008
	for <lists+linux-pwm@lfdr.de>; Fri,  1 Aug 2025 12:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A06A3AD995
	for <lists+linux-pwm@lfdr.de>; Fri,  1 Aug 2025 10:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905CE2CAB;
	Fri,  1 Aug 2025 10:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FvCKCtvT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251BF15C0
	for <linux-pwm@vger.kernel.org>; Fri,  1 Aug 2025 10:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754043343; cv=none; b=FMgP9tRLG/xmfjcaVrc/VYGCyJ9GoCzczIaSfGePvsZnQOkH4d1oFLKiGUht6TjTgPfFfgpbTfWObjxrbfTp2tJxn/x7NKRbt+RB1BSMxCjfIUvZsUc6E7jkrJ4sJlV/1vQgSynLVBUxD9MiV21b7ueDwfCIZku7M0+u2mxKbhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754043343; c=relaxed/simple;
	bh=+jhTsJDrPSY7wodsQRaAWcfA9H6ipxSTync5wNOJogk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f4mK9ZXRQ9YxZK4HINNwWW777Ih5mpwiCv8FwCSTFyOlmLHfj/Kvq6WpNHtzzgqIp7KjB0sgGKFcphEUbTGcGXkXlilDCFfZUOQG3FfTiHd0AMcYJK63j/b+yLGm4B9xWLRMFFi3icX3SIqgsTklb2lsq2ArAWatKy81NELO7vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FvCKCtvT; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6153a19dddfso2195397a12.1
        for <linux-pwm@vger.kernel.org>; Fri, 01 Aug 2025 03:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1754043338; x=1754648138; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gwLOn6LDayRlaIvdY/6sIIP6vXlKriHMbJQLO2eR9gE=;
        b=FvCKCtvTOEc98fpl80RX4c8TMhUDF6lTQY1WeSb1fNGRcq1yose0Q3fdue6jhO5edL
         y2jhlNCmAukMiKF4XWcy4g33/lO2UbfCeIsWB2GtyovahKZMVLhnrs9voUJwaVGpjW+5
         XoIql3jTMxkQLLbZcYhEnbryPmXOrP/zoWryklEKv8f1x3qsfzWOQKgBw2sFUomTSukV
         0cADdpN99wK9KdWpuGjAlbR2+bV5ShjWEFeEYpzxHEOTGFvUgI++vKCYq3wqbN7QAsNq
         qCoecAj9c52qnLxpWXW44ypJzQ3tBJGZnFk4/32WRVyyKWVfMjoce/FXQWlcCq72qoto
         ENiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754043338; x=1754648138;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gwLOn6LDayRlaIvdY/6sIIP6vXlKriHMbJQLO2eR9gE=;
        b=rkk2ti8LKkpigoXSdwt331IzqD2H/rqhpEQDAolAdZvD2edTslPkx5jGW5Izu9TzZ3
         WXCA/9jMpHIcPk3xzOfAi6bTT2soU9cm0l50hwhKjtLweMPJ5t76Bh9wwTL4gRWBYrJs
         JCKZMj1l3YEiTBgYbCLK0+yB7L+GVHIVtJtAxOVyCxG4bZpWPrtcMbj9UF7hLBVCkqz1
         km6qj5YUpK5Hxb/j5YZeXYGpx5AliaEawexxlJgsQih5uOrygxmfBL3TgQJx+E28Afq7
         0ZRhh+TJR6wJQ6QzwfnK/4OTIuBymhxggefFFejJqpNHiHDOk+TwHPml4dTBNBQbhFE3
         whOA==
X-Gm-Message-State: AOJu0YwCyxk5xOc8jOfKBmvkPneLALi4AbFZ10VnJwTLfdOgGWVYlfFG
	OAi65aMt+DIFHqVq7zYZhKa1S44Rs2gwvMPyyFteJd6KCrQzXe34kZummu9hhRVNFhIuSvjqX24
	ATBhc
X-Gm-Gg: ASbGncueFedeCX4xLPCAn+6eTWJp5gXaKTNuiI3s4F2ZXHLWUQR5HNtr457jgxjClKL
	ukpoCR8dO3CMgzs5pjJ96d4QwulFxFC45/NlDvXfYTKtqhk7CF+Forsa48OoZLbbNJrplfMOZ2Z
	Bf9EVUZk7vZODUmCvhxtlItIX9VDTXzXkVYDL0MopHjIz78JuuMAayLL/2t81NTuk86KBRuIxlM
	y/0NfCuTKRZoeggdQyZd9XMgjjlUaaRm6DGNrWYWeUsjBIIQ4RF7vKMWawS7JbRS6cN4Fi6igQB
	W3ty4QfQlS+G/ln6kYugABUjy5uEf+wvqU1NH/TBygIsvvcu2wEIMdKIg/EMDoly74dAYU+eWZj
	9/GktiQqFECzvIzmR4Qo0yfuhOxRO/+Y/XaxBqeMAPWXhE3fNIMo3DxE0XS8PBAVC
X-Google-Smtp-Source: AGHT+IHZu/jjg8t5Yr2pITuFU4ddHVLv4Nbv5n3jBDDgka+5QyOIUuxCKsdagJjDeUJqrFfxIUtArA==
X-Received: by 2002:a05:6402:13cf:b0:615:539b:7adc with SMTP id 4fb4d7f45d1cf-615cde3ca8dmr2188446a12.27.1754043338318;
        Fri, 01 Aug 2025 03:15:38 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-615a91138easm2499195a12.56.2025.08.01.03.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 03:15:37 -0700 (PDT)
Date: Fri, 1 Aug 2025 12:15:36 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: David Lechner <david@lechnology.com>
Subject: Re: [PATCH] pwm: tiecap: Document behaviour of hardware disable
Message-ID: <nh5tyoasilsubrhfyiw725wrtmfi5l4m2lq7n5zyt6zed5f2vl@mwpxuuix37ek>
References: <20250730080219.183181-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kocrs76av5zgaowe"
Content-Disposition: inline
In-Reply-To: <20250730080219.183181-2-u.kleine-koenig@baylibre.com>


--kocrs76av5zgaowe
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: tiecap: Document behaviour of hardware disable
MIME-Version: 1.0

Hello,

On Wed, Jul 30, 2025 at 10:02:20AM +0200, Uwe Kleine-K=F6nig wrote:
> According to David Lechner[1] disabling a tiecap PWM makes the PWM pin
> an input. The reported problem is fixed in commit deaeeda2051f
> ("backlight: pwm_bl: Don't rely on a disabled PWM emiting inactive
> state"). Document the behaviour in the driver for future reference.
>=20
> [1] https://lore.kernel.org/linux-pwm/39a472c0-ba24-de7b-8783-a16a71b172c=
d@lechnology.com
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

Applied to

	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for=
-nexxt

as 6.18-rc1 material with David's R-b tag.

Thanks
Uwe

--kocrs76av5zgaowe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmiMk8UACgkQj4D7WH0S
/k5Zawf/d5MT+UOWnTDYGy095QswAEO68dzsg8wScwXoK60tAtDgdOwDu5ATnM4f
M7rTPdHMx1TRKAZVRGM2gXzC6ZQw7roIJ4tHjBYHbm+AlQlr0Vyyso0wuLCkonzQ
KyvQShKP6ltjtJXcJzgx1VIvB0NAgPp2BEgaMM5hTHEZBEg0iyCBOcMe4U1Jjfwg
mWeBkW1OkodTyQv0J8RGaVBzVPp6je/XcslP8MNAZn+Cb4j6qswkEVmzmuEJtZfL
69LBtP7IkrN7Pggwe3BBbyyCxKoep9fm9r+aawTQbnGewa3yPhlVwF4MtVzF7LsX
7O+KxtJxe8UVRFitzHNk4F8qEIObMg==
=68Xb
-----END PGP SIGNATURE-----

--kocrs76av5zgaowe--

