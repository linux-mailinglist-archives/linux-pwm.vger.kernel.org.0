Return-Path: <linux-pwm+bounces-6823-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8F8B00D69
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Jul 2025 22:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49F775684A8
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Jul 2025 20:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107C42F0059;
	Thu, 10 Jul 2025 20:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DORON7vg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E90F510;
	Thu, 10 Jul 2025 20:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752180769; cv=none; b=gq66Tx5OK6lkEOnmQWqaaJwXQ9uI36CdwLqZut7apAjSWRQzTlD2yCXPVihh4SZAzFGozSLEs6OeZzecMNoMBm5xrDn+zN3zG/7BJ3glbNH9Ci3XAPJJkDViW6AbNd5AIl8RV0VDn1nsxS85fNI7hQhyh9JJwkTWt28UzKKLPvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752180769; c=relaxed/simple;
	bh=Mglw2ksv6p0jmkNc6ppoxSBvG/wPI1OuhGnfRBEN8og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AesSaMoQEuGlrA436coasItoRjECTie2ulRDVnYyRhwvCkAawMS1G1PUULDHjAbCXC9OSp2ISvmy7ZXNPiizRsK5WUKQVyuJEF3PmZkIBdfZEbghr3UP2vpkH1c4TjqzUgnM/vmbiRtO1xL2dkXDJ/W5k1g5960C2nFCEq6UEfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DORON7vg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC609C4CEE3;
	Thu, 10 Jul 2025 20:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752180768;
	bh=Mglw2ksv6p0jmkNc6ppoxSBvG/wPI1OuhGnfRBEN8og=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DORON7vgn8ny5uJ0L+QkdObMERtukYD5htopGHQZ3hHzt2UVpAtAvylvK9HNubGh8
	 lO8TkEc0vxQ1jLydCGrkdTklJgguo2YcLxyPDASsimPQoP+oYSihcdXks+cjwti4Yw
	 S0lxYVKFH79tz84Qnnv4VCm5d4w3xFiWHR3ode/fv+wpS5NTeK+mozGPykVAuYoMzy
	 b4U9vDkhwdXjwQVqeXjAzJW6kepyG6g2eq/Fg8jYjj4ah/4OecNk2qirhKh/EqUeFe
	 jET2nhXRgHjQjtzRt8mOjrl3XBy+FNFrQ4EzmFGAsfrPcD45tk0ukc1sjxB7EhoNxA
	 CcB0ybi7BPCXw==
Date: Thu, 10 Jul 2025 22:52:45 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, 
	Fu Wei <wefu@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Benno Lossin <lossin@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Drew Fustini <fustini@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH v11 1/3] pwm: Export `pwmchip_release` for external use
Message-ID: <tepvopkizn4jezpqcbhwrcsnsrjacztv6kuv53hidcjbrnrs3c@pfcp45jarcoy>
References: <20250710-rust-next-pwm-working-fan-for-sending-v11-0-93824a16f9ec@samsung.com>
 <CGME20250710185439eucas1p2684255d83d807dfd6f8b9b3caea65df6@eucas1p2.samsung.com>
 <20250710-rust-next-pwm-working-fan-for-sending-v11-1-93824a16f9ec@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="52heviwukb62zeme"
Content-Disposition: inline
In-Reply-To: <20250710-rust-next-pwm-working-fan-for-sending-v11-1-93824a16f9ec@samsung.com>


--52heviwukb62zeme
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v11 1/3] pwm: Export `pwmchip_release` for external use
MIME-Version: 1.0

Hello Michal,

On Thu, Jul 10, 2025 at 08:54:28PM +0200, Michal Wilczynski wrote:
> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index 8cafc483db53addf95591d1ac74287532c0fa0ee..8f0698c09e62b893d63fc258d=
a3c34781183056f 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -478,6 +478,7 @@ static inline bool pwm_might_sleep(struct pwm_device =
*pwm)
> =20
>  /* PWM provider APIs */
>  void pwmchip_put(struct pwm_chip *chip);
> +void pwmchip_release(struct device *dev);

I want this in a separate section because "normal" provider don't need
that. Please add a comment that this is only public for technical
reasons for the Rust wrappers.

I understand you are eager to get this merged, but still I'd ask you to
slow down your patch sending frequency. Currently I tend to not apply it
for v6.17-rc1 as I'd like to have that in next for some time.

With you waiting a bit longer before v11 I would have written that in
reply to the explanation in the v10 thread and we might have saved
one iteration ...

>  struct pwm_chip *pwmchip_alloc(struct device *parent, unsigned int npwm,=
 size_t sizeof_priv);
>  struct pwm_chip *devm_pwmchip_alloc(struct device *parent, unsigned int =
npwm, size_t sizeof_priv);
> =20
> @@ -551,6 +552,10 @@ static inline void pwmchip_put(struct pwm_chip *chip)
>  {
>  }
> =20
> +static inline void pwmchip_release(struct device *dev)
> +{
> +}
> +

Is this needed? There is no user of this function that doesn't depend
on CONFIG_PWM?!

>  static inline struct pwm_chip *pwmchip_alloc(struct device *parent,
>  					     unsigned int npwm,
>  					     size_t sizeof_priv)
>=20

Best regards
Uwe

--52heviwukb62zeme
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhwKBoACgkQj4D7WH0S
/k7Blwf+LeGyU+ZX3f7XS0pHm8zBWkJ0woOP+GYaAZLba3sufqsqBh90rQuPvYFG
yfOmrF9i/IpGim42booPz1OZD+PGe17Wx6+iQ57RuLkXxKfIwqAGfQnBW5BunJWL
b7xkg1vRjmnZdQgixsTRSZoE/QjqSzKYzooogPg/bAtUy92n5vzpafgxy9zqsfZ/
6wtM1Kc/nRir2TbVMFBNlu2ZzjNd9gyTk42gxQBgXqzG7PzA+gdaN1A2n58tdzUd
44aN7WhPOEUPT3GJwyLrkwcKulGPyGY8Do3sYujEV98E5HbRdy5K/Ctsrm3ixD+A
X994v6aaOHQQA0XiVBE695HLVVwLCQ==
=vBNR
-----END PGP SIGNATURE-----

--52heviwukb62zeme--

