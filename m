Return-Path: <linux-pwm+bounces-7318-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CF5B57565
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Sep 2025 12:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B53FC7A7BE6
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Sep 2025 09:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58CA2FAC04;
	Mon, 15 Sep 2025 10:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="isaI4Le1"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F1B2F39B7;
	Mon, 15 Sep 2025 10:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757930416; cv=none; b=S+eRf3kmCEzs0GnF+X4C61fiUy97I26jz3rypy9ShCcsb7L/dbBGdBV1eDfkZb4kyfcOwkwc0ezDMxlEWwcrFxknlnA/5Du0eKoQ4suIU+Z3JG/2mIwoUPA4MdMEQNLb1+aaTGhn8AmXHYJNA3DYzes+QmxDDdA3Uk8ydL6V5ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757930416; c=relaxed/simple;
	bh=Pcd9ZToXPQQxmubV3rR5Zi6CoH4Kg5mSLyV/LY5hX/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pUtBxLazMXgaMnb2WfTfI4+TpKzifUseIRUKrMxStFRVO5qZJaVkLNAEMSkKyB+ED9mf6nPqTGUG763KLMCW7yk7mZkYxLLTKbsn3LbId0m54s5hg1t0HdcgNKREmchsYqlVEf7MKWpwl99/+cxuunM+nOq4mRSUqE0lmZYNxHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=isaI4Le1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2424C4CEF1;
	Mon, 15 Sep 2025 10:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757930416;
	bh=Pcd9ZToXPQQxmubV3rR5Zi6CoH4Kg5mSLyV/LY5hX/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=isaI4Le1IUPm5WO/FkjugGY5TihhnnOPPWBqXZATkJqCFu8K+uagSHjhYXaYdBJVO
	 pYj6cFzEwtrwxAkVKFerFQexukNRw9y3ZypQUnHgd14TkKkjUXhKvKhl5pOiCDXE/C
	 //8cMCshz8VQP2Btbaa2ZCG8IX/xMZ5RGNglwqHa4qDfgOFNww4g5zb3zUfsP8m8r+
	 /sRQBTMnpLAtOI52ZR96b0Hu5xrIvRTyXKf3bGrUuDQH5vLvtrFQD5FkhxEK0JCzvP
	 UxJCRydMKaMLvXso4KD37LJgVE2f1+Jy7+fwWUlHR+yofF0VS8dJqXl6YkCDTi/8HB
	 orORk55ceYQQQ==
Date: Mon, 15 Sep 2025 12:00:14 +0200
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
Subject: Re: [PATCH v14 1/7] pwm: Export `pwmchip_release` for external use
Message-ID: <3jxl6gpxwv376ooyny7qkeokeh7nzafttbyoehmwqzrccn5oip@747v6zdnogso>
References: <20250820-rust-next-pwm-working-fan-for-sending-v14-0-df2191621429@samsung.com>
 <CGME20250820083541eucas1p2ad7d78418576b8bc8cbddd8efe83bbe9@eucas1p2.samsung.com>
 <20250820-rust-next-pwm-working-fan-for-sending-v14-1-df2191621429@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ieqpilfwwfgxf4dc"
Content-Disposition: inline
In-Reply-To: <20250820-rust-next-pwm-working-fan-for-sending-v14-1-df2191621429@samsung.com>


--ieqpilfwwfgxf4dc
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v14 1/7] pwm: Export `pwmchip_release` for external use
MIME-Version: 1.0

Hello,

On Wed, Aug 20, 2025 at 10:35:36AM +0200, Michal Wilczynski wrote:
> The upcoming Rust abstraction layer for the PWM subsystem uses a custom
> `dev->release` handler to safely manage the lifetime of its driver
> data.
>=20
> To prevent leaking the memory of the `struct pwm_chip` (allocated by
> `pwmchip_alloc`), this custom handler must also call the original
> `pwmchip_release` function to complete the cleanup.
>=20
> Make `pwmchip_release` a global, exported function so that it can be
> called from the Rust FFI bridge. This involves removing the `static`
> keyword, adding a prototype to the public header, and exporting the
> symbol.
>=20
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>

I still somewhat dislike this patch. Isn't it possible to make the rust
abstraction use the pointer that .release is set to when it calls
pwmchip_alloc()?

(I wouldn't further delay this series for this discussion, this can be
handled just fine at a later point in time.)

Best regards
Uwe

--ieqpilfwwfgxf4dc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmjH46sACgkQj4D7WH0S
/k5CPgf/d9VpIxfV66LPQ8LcyKGHr/z6WLe8e0mXCQBgmb+2uCpwZuAcfd87eAge
Gj0+iGdFuUvqg9fRbzhyd91BvVk/yCcPrg4kWxrECTxVq3ZqoMivnw7cngrXg1k5
gFdHV1Hd294DQHqM8cw4m2CpbS3Uo+2i17f2+hlQcIbGfrChb5Ge3HlZKsaMvd2k
QRw8M4TQVIzt/CUSPAwDgjB22tASqGcyOSczpasXB7XdPI2T8IdUF795FzZrvNvg
VKdgOVk2s82h9mVAImKZOCHPwE/N9Qbe25AaJAFDMkBLjebGEI2hkwFFjt406aNo
edMadB5H+bBdQwPhBaDbH4qsWO1paw==
=yBiS
-----END PGP SIGNATURE-----

--ieqpilfwwfgxf4dc--

