Return-Path: <linux-pwm+bounces-7319-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E07F3B575CE
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Sep 2025 12:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61F63200010
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Sep 2025 10:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFE92FB62B;
	Mon, 15 Sep 2025 10:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOwoYI0p"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9E42FB627;
	Mon, 15 Sep 2025 10:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757931185; cv=none; b=PWxpu+NHoUlqvGtLgwG5WTVKK1+ZJx04kU9Mj8jrjhafwwua+guKpyCTOqixia7nexpcX3F+qnOJYHkSROMiShqljzeNmSoO/OOqeJzwWfYpclpRh3bFaczcI/SJ8Mj2DS9O/qQeuW+04XdzLnJTXqd6SHMfABYMmz/BM6WnxPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757931185; c=relaxed/simple;
	bh=bb9Mg/D/jEHiaHsLAgrg6OSUxGwRv1ubjnV9xw/kiW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eZBz5YQgCfQfZNU0qaaXuR6rpSDQMfXqjN/HtaFDGesqI3+coM+ji0yRnqXNPLDecdwt8HM3LCyclLrTe4RN3juJufoh3b8Bh1T/lB8E/lRuZIqZ8St/9nmABUP99W7UJVYktfNol237Nqj9kCkiJMnfHLMK8D/dHRf7UslPLbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOwoYI0p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD41C4CEF7;
	Mon, 15 Sep 2025 10:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757931184;
	bh=bb9Mg/D/jEHiaHsLAgrg6OSUxGwRv1ubjnV9xw/kiW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MOwoYI0pzlw7L57/NjzW0kWEOhTeYrPAPpgYGQ+Sb3S7oWReSYYhzrBAzW3yCFmVw
	 LkIGEggrjiW//byAc4Lh9OmKKssKd0v1WGASy9HhwnxwDB5net5ZNWuNGdx5zoZZeA
	 lozqdOKVq/gKDD2zfdHOzTI8oRZzwkA6kHqAGpqHPFzFaJf11ITrsE3SksLByb4KTV
	 UxRvvTVEjyjaeZMTpAWKqWH2CG12frOfhQCJye9XpSxfRpDOIiBKEwiRDVRwwVfpWS
	 tRQfQsGQm032z0j7fhruWg7hFL4rQApVCUicVG9YGIUy7PoHjnJH6v8sz9X6WsR49M
	 hkbTjspEj/ZLw==
Date: Mon, 15 Sep 2025 12:13:02 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Benno Lossin <lossin@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Drew Fustini <fustini@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v14 2/7] rust: pwm: Add Kconfig and basic data structures
Message-ID: <upgthwp3cyohhe2gkzsramzshmvz3icjbhro6hgk2drbbqczi4@ygaanetydgjv>
References: <20250820-rust-next-pwm-working-fan-for-sending-v14-0-df2191621429@samsung.com>
 <CGME20250820083542eucas1p221dacb3b69524b0dd6f7abf870adbe04@eucas1p2.samsung.com>
 <20250820-rust-next-pwm-working-fan-for-sending-v14-2-df2191621429@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zryfvf6d45dfcezd"
Content-Disposition: inline
In-Reply-To: <20250820-rust-next-pwm-working-fan-for-sending-v14-2-df2191621429@samsung.com>


--zryfvf6d45dfcezd
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v14 2/7] rust: pwm: Add Kconfig and basic data structures
MIME-Version: 1.0

Hello Michal,

On Wed, Aug 20, 2025 at 10:35:37AM +0200, Michal Wilczynski wrote:
> Introduce the foundational support for PWM abstractions in Rust.
>=20
> This commit adds the `RUST_PWM_ABSTRACTIONS` Kconfig option to enable
> the feature, along with the necessary build-system support and C
> helpers.
>=20
> It also introduces the first set of safe wrappers for the PWM
> subsystem, covering the basic data carrying C structs and enums:
> - `Polarity`: A safe wrapper for `enum pwm_polarity`.
> - `Waveform`: A wrapper for `struct pwm_waveform`.
> - `Args`: A wrapper for `struct pwm_args`.
> - `State`: A wrapper for `struct pwm_state`.

Args, State and Polarity are only needed for the consumer side of the
PWM API in Rust, right?

I don't particularily like like pwm_args and wonder if this really has
to be exposed to Rust.

I think for State (and thus Polarity) we have to have it for the
forseeable future.

Best regards
Uwe

--zryfvf6d45dfcezd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmjH5qsACgkQj4D7WH0S
/k4H1QgApRy8liAOZrzb3w50HXnIjFUP1zT9oN5uSbu1nwLFcoyPu1JvjbpxW7g1
aMBxeARi3PXREgQ6tZSbrWcb9+PiqySUS8tXIEawBr6Kskazxjtiz1LPYt0sLsuF
z+IRMCWg4pPm8g3t47tYvNOFaBnd49AjzrbPJrrlsDV13eisMsbVfYdr+7ZdPQPC
Evo9Pjzeg6jpKVWmp3OgFN6Mf83dFDB2XJKiZsDYRWuBjM6uJb3roiinPQfzKOAF
zAF32eplMf+6CcGLoBgdVJlkG2hVh/5xBgjYw7Zk9I2zcwuDJ13wvM2umgbtBCVI
aCZYiiFaLX1WA4w+SH6oQNi+C2WebQ==
=pc6O
-----END PGP SIGNATURE-----

--zryfvf6d45dfcezd--

