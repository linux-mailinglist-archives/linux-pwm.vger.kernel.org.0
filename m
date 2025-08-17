Return-Path: <linux-pwm+bounces-7082-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39253B292C7
	for <lists+linux-pwm@lfdr.de>; Sun, 17 Aug 2025 12:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3C5F189DD33
	for <lists+linux-pwm@lfdr.de>; Sun, 17 Aug 2025 10:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCA32877DF;
	Sun, 17 Aug 2025 10:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sau3A0p9"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9197C1FBCB5;
	Sun, 17 Aug 2025 10:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755428360; cv=none; b=tAEL4602e9dVSInHAWWqsTCo272L3HVhVxrbpTKcveVRN1vQ62kLm+9d1jG+hq1PTBrjgx+2h5bkPp/Leuv/z8tdYdEcr4v8BKZDIh4PHYiCqcgXXM2O/pxbpdcAkWZXqCgl4RDwXR2DSFlrr+fVjfrlnQlb6Pkce35wNIku9ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755428360; c=relaxed/simple;
	bh=YsJgTTsnsXUMnX2YNiPMLa1RfWqepGr89YgSXk7AUX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M+Fq1pjc0ZVaNgGHqF4TK6uu34+C79wOHbRZXpZqHX6kqXig7NvoLSYvJP8yGtYoE4Fl8Ih1MDQlEhWU+bosCIrwsfvVSoBq3a5SBUCFQpX9Kj50FN6XzLeC5pzamtkyaKVfyNj0TpzrMczo4eqUfTMHGOigGrsBoRQeM7mq3WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sau3A0p9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F988C4CEEB;
	Sun, 17 Aug 2025 10:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755428359;
	bh=YsJgTTsnsXUMnX2YNiPMLa1RfWqepGr89YgSXk7AUX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sau3A0p98zRjWNS2jEXHE5WL+dBNfVSrxqO8/wSlM94f6MA8eeUad5K6+HvrRSLFA
	 ykZj+4NWA3uQQ+48qylfBzmgrcUtfkQrZAOGsEJlgebPPAZyIwk9Nkvkr+i2NONzwK
	 aNkh+KcPbc+UaKFH0MeDBEH2WPg6QLrNNkVYndvem1+TvzAQ7KiVJX26DOAsV/MPTE
	 z0mBr/98Gnfr+OLqVkoRoqbdyUhlm4KjaY/VCxO78L+Z91EL2Ogf4UtJvkx3joCMB2
	 PdylwXPLH8i5DJXFCpkCYnbTz5Kqq4lu0/U6rD+4hyTSQBnRpscVdVqwq6LOTSxHrZ
	 OskFbbyDSlcyQ==
Date: Sun, 17 Aug 2025 12:59:16 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Xi Ruoyao <xry111@xry111.site>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Juxin Gao <gaojuxin@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Xuerui Wang <kernel@xen0n.name>, linux-pwm@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: loongson: Fix LOONGSON_PWM_FREQ_DEFAULT
Message-ID: <n5kdswq7oduruqiruyup4rcdwrs76tlinz26swotzeqklterey@off5cbv5i4e5>
References: <20250816104904.4779-2-xry111@xry111.site>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4mc4hchyujztabjl"
Content-Disposition: inline
In-Reply-To: <20250816104904.4779-2-xry111@xry111.site>


--4mc4hchyujztabjl
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: loongson: Fix LOONGSON_PWM_FREQ_DEFAULT
MIME-Version: 1.0

Hello,

[adding Juxin Gao to Cc:]

On Sat, Aug 16, 2025 at 06:49:05PM +0800, Xi Ruoyao wrote:
> Per the 7A1000 and 7A2000 user manual, the clock frequency of their
> PWM controllers is 50 MHz, not 50 kHz.
>=20
> Fixes: 2b62c89448dd ("pwm: Add Loongson PWM controller support")

A quick glimpse into
https://loongson.github.io/LoongArch-Documentation/Loongson-7A1000-usermanu=
al-EN.pdf
confirms this, so I tend to apply it. I'll wait a bit to give the people
involved in 2b62c89448dd a chance to comment.

Best regards
Uwe

--4mc4hchyujztabjl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmihtgEACgkQj4D7WH0S
/k5rbQf8CY/bnYqpoMTDvYD/tfhlrlJbUrH2oLdGjTFUo6fTLHNKHQmU4mN80JIZ
TsfsPiYAexrvNCqcLUqDc6E0ADiPz8ZSU0slzUebNLabt9L8FPnLx6kqLM7lUdX/
9eUxCxTc1m4WHgOqKfKbQmuRkPQRMl2jTBx405wNJx2Ly/EKIu4f6nf/x12OjJFi
MXlDThXYRF24k2NsYmIrl+T/lEluf6Xj8J/7EbumRP7eL9TblE246RGi03u9BfDR
mxA4d8eVQsf5LliGeJm93TUkvp9cd5oZz6ZGtlsQwNM9rVqr1Y7fUy9tbEwMSL41
cMIVV8bz7ia4tamnjKXi3yGe/Zz+qQ==
=86Nh
-----END PGP SIGNATURE-----

--4mc4hchyujztabjl--

