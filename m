Return-Path: <linux-pwm+bounces-6532-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87963AE8596
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Jun 2025 16:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24DC518864EE
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Jun 2025 14:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AB9263F5F;
	Wed, 25 Jun 2025 14:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHMxm2Zb"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F014B263F22;
	Wed, 25 Jun 2025 14:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750860326; cv=none; b=bf6Kt2sKFOzPMyppQbM+tEX+Sdg93ert8dnci2kbswFGcZWlP+vKgmNwGTGqetK1SXawIiX+GzdgUpzF7xQ5jdsoYclekPDEZ9uZ1DIv8LQkEuXPt8oAUTSouho0t3NqqRrLgNPMKVWcWK0YPSBl8+q1az0zLE4ZHMTtqu1N9Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750860326; c=relaxed/simple;
	bh=riLdd5+MDpL2DCfxQ37cyxD+TU6nR3iPtqrq+d4xA5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fmGA1RlVm/CzQC7YPH3i+8kFhGoMTsZotGU1UX1sXhoG0DcMpvhQyM25cqvjKTBILGUbWHx4HhihF5XUHNVeVUolEOfpXBs7agsF4fyFvO/1iJxW7Ct5BvsLDy6SfnLlmb6oeLZgw20KLH0L4raNLhtUZj5XqlKTysy9T2IL/fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHMxm2Zb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388CAC4CEEA;
	Wed, 25 Jun 2025 14:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750860325;
	bh=riLdd5+MDpL2DCfxQ37cyxD+TU6nR3iPtqrq+d4xA5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hHMxm2ZbQ4XkvYV1DsPM4VqmwWiIZGuZ7nDPTNJfx1brZQJRa25WRirGPmqjk+1bI
	 i1i+cDBLFmTXxdlhWEaxlb3C03ot2jiWBrZ+HDboPZrNmhmCZywE2zjLgTa1cLwZ53
	 dyg22/GtZBR7Fv2ZXNyDDjqhGlXdUHvM2SDHcWlt7Ab1k4Mo+OsHt1zysaikSR8Fa5
	 C6NbZjSCuHz1ilnTEOt9Gvnvcss7ZR2A5sB8/LAHsZGDxclM0W2gMrig9f6yeVsbHL
	 TgWD3EqLFRFAOE6xMaCvHs69/PWPxspv8cp+T/pKCyrNsMim0VcM1NoJkQ3xB3D80c
	 Gdk0trZ9gM50A==
Date: Wed, 25 Jun 2025 16:05:22 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@intel.com>, Benjamin Larsson <benjamin.larsson@genexis.eu>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH v16 2/2] pwm: airoha: Add support for EN7581 SoC
Message-ID: <ucygzs2tom6ukfaqg5gujt2uiluawhfccaxjrxyisxuut2u4zi@rlhjecrfwkyz>
References: <20250625000059.20040-1-ansuelsmth@gmail.com>
 <20250625000059.20040-2-ansuelsmth@gmail.com>
 <dehsalp2za4i6jgod6ej6gqhestljo7qost66jzmql52n2zecp@imtgipg24lv5>
 <685ba7d9.df0a0220.e1b22.e6c2@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jjitsmuq2jnwbm6s"
Content-Disposition: inline
In-Reply-To: <685ba7d9.df0a0220.e1b22.e6c2@mx.google.com>


--jjitsmuq2jnwbm6s
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v16 2/2] pwm: airoha: Add support for EN7581 SoC
MIME-Version: 1.0

Hello Christian,

On Wed, Jun 25, 2025 at 09:40:07AM +0200, Christian Marangi wrote:
> On Wed, Jun 25, 2025 at 09:24:33AM +0200, Uwe Kleine-K=F6nig wrote:
> > On Wed, Jun 25, 2025 at 02:00:39AM +0200, Christian Marangi wrote:
> > > +	/*
> > > +	 * Period goes at 4ns step, normalize it to check if we can
> > > +	 * share a generator.
> > > +	 */
> > > +	period_ns =3D rounddown_u64(period_ns, AIROHA_PWM_PERIOD_TICK_NS);
> >=20
> > I don't understand why you need that. If you clamp to
> > AIROHA_PWM_PERIOD_MAX_NS first, you don't need the (expensive) 64-bit
> > operation. If you compare using ticks instead of ns you don't even need
> > to round down, but just do the division that you end up doing anyhow.
>=20
> Correct me if I'm wrong but=20

I will :-)
=20
> #define NSEC_PER_SEC	1000000000L
> #define AIROHA_PWM_PERIOD_MAX_NS       (1 * NSEC_PER_SEC)
>=20
> doesn't fit u32 so an u64 is needed.

1000000000 =3D 0x3b9aca00, that are 30 bits.
=20
> And using ns until the apply process is handy for bucket sharing. I can
> change it to reference ticks but I think the round is necessary.

It's only handy as you track ns for the buckets. Changing that to
ticks, too, makes this all naturally fit again.
=20
> You want to change everything to reference tick? (honestly this is a
> good chance to introduce this missing API, since I feel also other might
> benefits from this)

I don't understand that, but I think yes. Doing the bucket selection in
ticks sounds right.

Best regards
Uwe

--jjitsmuq2jnwbm6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhcAiAACgkQj4D7WH0S
/k7vzgf8Dqo863izCP0slue3JHgjxuqX8V0NBopvhm0vd2/N30HzS+H/VqgZDf8N
kkcjndkpBrDzfZLQHqt6ixP3CFQH+3sFuHNTC0EA7bX8BOzxtVI7AdyNsfEx6Yvp
a8REle1vUuxH9YX4a9Qg7yEMB8hiCPt+OO/NGmK4ijRfOt8rJDmG4mXg4rYK6vf0
k76qOtxX3sZZwrIUQRoTeptnOgfnp5cADmHPBUO0zR3DXavw6eOxXK3biLYchiT2
VOOxu1zFBhjlScjMP/YLKOpAnma5AL+kzLLACdarwYqjTi9tnANGh5GVytag3j/Z
m2HfF0w5y+9OfEXvKGSXDPvXxhGyxA==
=eQt8
-----END PGP SIGNATURE-----

--jjitsmuq2jnwbm6s--

