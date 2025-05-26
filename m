Return-Path: <linux-pwm+bounces-6123-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5553CAC3AE9
	for <lists+linux-pwm@lfdr.de>; Mon, 26 May 2025 09:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F8C03A3910
	for <lists+linux-pwm@lfdr.de>; Mon, 26 May 2025 07:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04A81DF99C;
	Mon, 26 May 2025 07:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LzTJvrdC"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB331C84CD;
	Mon, 26 May 2025 07:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748245987; cv=none; b=tSxE3THfYaEj58sUWZWWiW9Kw2pJz6a5kkORsos2ydKG7qJRc97KIVkmODp6meOAjegctvms/zuVIXaSe6Lm3JWyFTKxnC4m7kAvgEzU8ArVWiB+IOO1IYLEtC9t6ZpYsX2CXCKtPFHkf8OFYo7C8oeICtzXKH+oGcaCfFW9f7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748245987; c=relaxed/simple;
	bh=BbYGMsfcLHp+/GVsG438+tTvy3Zkb+vofZ3c+RLfKYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hz7J9pL3D9k1hI94JGzWLGfSxtb9Twzk7xtdFwATGmgSiGxcAhTsPy0XCFwGiy14lQfQMF/0Zx0K+jYGqNP6tPtONxAzBO9U09yIK2DKSUIpbnHWkq1C1DvqnjPx2QrRRXosRr9nsWDdmueehmkT8o7JJLe4Q+rLX52RS/2sLxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LzTJvrdC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A1D8C4CEE7;
	Mon, 26 May 2025 07:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748245987;
	bh=BbYGMsfcLHp+/GVsG438+tTvy3Zkb+vofZ3c+RLfKYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LzTJvrdCv3nCLYhYIyEeMGq+fLpz1CGeMaWzTofOe+2rmzvRlodufbGuN+/2f/w4G
	 KBXhQ55ORwcVVU92jYoabGLkCqfcCbu/Gz64FYjnA3kC4n2lXAUvePfc2IaRHyla4G
	 Ns+hSFLf2rSCV8sINX63yJrk1TRm8jqBh5E0hcb4anV7JnDZgm9Gvrq+OYFzNQbVg6
	 pLWkpdIOjUZoamrP4CODlUBJHpD8owQmUlbsTAhXZX78ufwuuEYqQH8JvPFkC41PqF
	 yws+zgWoe3a3BUJlJI8MCWycG58EOYJDeLk1DiLLNyvalOc7drqO6BbjLwasHGacyy
	 4bq16Cx6N3Y1Q==
Date: Mon, 26 May 2025 09:53:04 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Drew Fustini <drew@pdp7.com>, 
	Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH RFC 1/6] rust: Add basic PWM abstractions
Message-ID: <enxctdseecqz765nmd24vziiaksmyhltqfwycdszmfq3s7orjm@lnpc7czuluis>
References: <20250524-rust-next-pwm-working-fan-for-sending-v1-0-bdd2d5094ff7@samsung.com>
 <CGME20250524211520eucas1p1378fbab27f4b1ae8808706c074fa217c@eucas1p1.samsung.com>
 <20250524-rust-next-pwm-working-fan-for-sending-v1-1-bdd2d5094ff7@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ojsy757ta3qba3or"
Content-Disposition: inline
In-Reply-To: <20250524-rust-next-pwm-working-fan-for-sending-v1-1-bdd2d5094ff7@samsung.com>


--ojsy757ta3qba3or
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH RFC 1/6] rust: Add basic PWM abstractions
MIME-Version: 1.0

Hello Michal,

On Sat, May 24, 2025 at 11:14:55PM +0200, Michal Wilczynski wrote:
> Introduce initial Rust abstractions for the Linux PWM subsystem. These
> abstractions provide safe wrappers around the core C data structures and
> functions, enabling the development of PWM chip drivers in Rust.

Oh wow, thanks for rustifying PWM. That might be my chance to actually
learn Rust.

I don't know when I will find the time to look into that in detail but
one thing I'd like to have for Rust support is that the drivers use the
new abstraction (i.e. .round_waveform_tohw() + .round_waveform_fromhw()
+ .read_waveform() + .write_waveform()) instead of the older .apply()
callback.

Best regards
Uwe

--ojsy757ta3qba3or
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmg0Hd0ACgkQj4D7WH0S
/k59QQf/Zie657XEyEobiX+YRFby/LT3J0PihO7GXdaQaMVGvLXBOvDxjG8OeNu0
+ZLs+pGuXMJEBtLuBgN35D8f0MRvrzhYkHLoG4OEMCUXYl8F5PandUtiVaW9YRjQ
Qd5ty0G46BqM2IA20QvxKKkF3AVsirwbNjANp5TvaQTyesJcg/vh++5W0Lt0q7mb
YI8daLWPWRRYwCk8pHmPIMtsjHVTVG6MxvPH+Gg4u3Yd7d5NBb0CyHs4VMtITtFl
XNtNmS8hfXx3VYXyOo5UNFXezymWT31Uu+zPeNRRUIr2wmCiXajJu8m7SmFlk8B1
3LKMk6AoAK7O/+PlI1FfS3OTse1tsg==
=SkCA
-----END PGP SIGNATURE-----

--ojsy757ta3qba3or--

