Return-Path: <linux-pwm+bounces-5483-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99575A89795
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Apr 2025 11:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA59516F8CA
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Apr 2025 09:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E88B1C84BD;
	Tue, 15 Apr 2025 09:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tcOqwLtm"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3968633F
	for <linux-pwm@vger.kernel.org>; Tue, 15 Apr 2025 09:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744708343; cv=none; b=Ag8VPBmsmnE782aF6Smz5mNtqlYXHDCI2VUolkcCxLz3ZTEK3sxQQDQkeGm5UIjPxsJIPEtmZb19i0wCQVT5qNfcQ0ujrKQ92i1eEmLiCXB/sIlafnAVQXm6BHRzw6xerU/0oeFeDchhA7/x4i+RCs9QlD1aYVoM1+/zpHmiAhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744708343; c=relaxed/simple;
	bh=4+cRdY/LRgMqQlUiZ/eaaXhks1nc7k5wYTZjPihB8bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSRf6aZtlWBHBJ1wKHarJDuaYFxsvD3Ft3PNEIeoHiHUbjeOL8zwcxc4PFuu/IohsEDyEWmLGdrLYIwcs9Be4moQL4o4udIwAA4wHPhKTXGIK1VfeLHGFLxHghWXK6C5+vfY21lVXS7B3211nzR7D7RDq9NdpgTJlh6AHqPWzr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tcOqwLtm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B158C4CEDD;
	Tue, 15 Apr 2025 09:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744708342;
	bh=4+cRdY/LRgMqQlUiZ/eaaXhks1nc7k5wYTZjPihB8bc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tcOqwLtmhzqUhvvWVZngzJxPU72UYZmbQ+o4S0sFkhxHqOYVb4QIECBUTM5eXKp9P
	 P3X1PRLQ4qTX/78w7lAC5frgd6NLcKpahT8OzoLCyRu7P1Dd4xRfjaCx3v+ZVFxubG
	 ZLXQBhqBaWJRPlvwB5BNAclBLWuZjLUh+JCInQZ6UeiZtEf+qC1SM4ope24tUR+5Ox
	 Kg3ou6lQ+CbZf7gyq79wljG24ep8+qr/E0S8eWot6wOI8eT3WhRW7rkWScFDLyTXU6
	 4xqfx04LBp6klzrEzTjvezN2s7QItCfah8ZSS+iNohBvRkKp78CT+SFBhKOPYqdooi
	 Y07rCcrdNr1SA==
Date: Tue, 15 Apr 2025 11:12:19 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Juxin Gao <gaojuxin@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, linux-pwm@vger.kernel.org
Subject: Re: [PATCH] pwm: loongson: Fix u32 overflow in waveform calculation
Message-ID: <63vagloqo44d4cuchym74japb6z6ui72o7oaz2wdjc4qdgpno2@4j54mhumertx>
References: <20250412122124.1636152-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ukjrsdsbmwgktt6r"
Content-Disposition: inline
In-Reply-To: <20250412122124.1636152-2-u.kleine-koenig@baylibre.com>


--ukjrsdsbmwgktt6r
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: loongson: Fix u32 overflow in waveform calculation
MIME-Version: 1.0

Hello Binbin,

On Sat, Apr 12, 2025 at 02:21:24PM +0200, Uwe Kleine-K=F6nig wrote:
> mul_u64_u64_div_u64() returns an u64 that might be bigger than U32_MAX.
> To properly handle this case it must not be directly assigned to an u32
> value.
>=20
> Use a wider type for duty and period to make the idiom:
>=20
> 	duty =3D mul_u64_u64_div_u64(...)
> 	if (duty > U32_MAX)
> 		duty =3D U32_MAX;
>=20
> actually work as intended.
>=20
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Link: https://lore.kernel.org/r/44f3c764-8b65-49a9-b3ad-797e9fbb96f5@stan=
ley.mountain
> Fixes: 322fc380cea1 ("pwm: Add Loongson PWM controller support")
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

I would have expected some feedback on such a bug report and patch from
someone who was just added to the MAINTAINERS file claiming to maintain
this driver.

I applied this patch now to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next
and still accept review tags for it.

Best regards
Uwe

--ukjrsdsbmwgktt6r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmf+IuYACgkQj4D7WH0S
/k71hwgAq+bckTpmh83sypQqAZT6W9PY2eaHTGO7hawu9xGccq0oOEgTgC8mZ1hn
cuMA2kJJFmmYbUKwhx7zWmPLZMlJ/rE9kI8lFnAlykS3ryy2vLcxSaK65Tknb3KJ
FUQwEeUP19PhpzCwmUqmmAu3ZAgywvaR9A+8W3PLfGbVS/uGnpmch/KxXwCl9/Wq
BRPk+JU9NT0DQaa3fYJwOvtuc2+dkWF2FLij8rTDorYyw5j6eiPsdVBJwuY5g+nS
3hSsSe8VlyNwJVHfZJo2QVuA+napNa2FXYrxowj2p9UKt7if3TmvEuSuvyli5pjk
HAbNCjrMlljwIBuTxJsUAc09xggl1A==
=nmw7
-----END PGP SIGNATURE-----

--ukjrsdsbmwgktt6r--

