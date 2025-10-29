Return-Path: <linux-pwm+bounces-7526-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6A9C19904
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Oct 2025 11:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2B3E934E15A
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Oct 2025 10:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C4C2D949E;
	Wed, 29 Oct 2025 10:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEPuyLSF"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96560155333;
	Wed, 29 Oct 2025 10:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761732255; cv=none; b=LhLA++MzcRW86VTNW2e7RXfhzsvQz7II+yRqsh6aGYGoAtNBaJIUS5BD3jC7oimpXkKV5OgGtpspEmUU/HukdMi361xk3L4oXVlPd25ZDlRysqNheMkKPe7Fv82ywyxuJ4PHk2QjeKcj5YXXhMX3X9HQh+sJAtF/Y5J3qZLcWTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761732255; c=relaxed/simple;
	bh=9EkDS1DJ2fZOAXUw2/HfVLqWdqgIctXJK7bhJgzpr3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JsKCm9xtHviGMgrGCoOizsF0DHbsEaWVHlCY3dF7dFQsXrzghosd2VfakSHTvXhyo6ZbYq0t8pRm7DhWlZ+mkzjP9VP6VaxlyGqhHsgm+Ycp8l7/UY2vt8FeZoWuMPIqWSg57JW4GAWgukXuipVwSKAe0yxTlAvTRajgd+3uo48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEPuyLSF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D0B2C4CEF7;
	Wed, 29 Oct 2025 10:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761732255;
	bh=9EkDS1DJ2fZOAXUw2/HfVLqWdqgIctXJK7bhJgzpr3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OEPuyLSF2EDJR259VKbjKrbAixkoep3+mPQlbzCuFXXW8lk6JasA5n6gE4de/4xeO
	 Yr11i6FAuqWGikCB8lmtGECXyXXVvcEVrNIR7u/LUiYLyYwaKeiMEAFE6ibhdiRI6d
	 1n2mW7GrLXh5SRItmsfHxwD5gpDH/C3aOfM9A+kPtSd/VLZn0mtBi4/7yuU7WQcvvZ
	 FzjBFxv9yeviiF05ShfmE8KX5uyx5jnkcJOgYNfOOjWqU/DAxKA66mvvzPIo6EuSv/
	 XaOmL6xeI1LVAyIzTCZmNBO2iiQAhXXpXh+6IbAd/axzcmj7sSpWzn3sPShpGYI5Cx
	 WUSgAFhtpVBVw==
Date: Wed, 29 Oct 2025 11:04:12 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 0/4] Introduce import_ns support for Rust
Message-ID: <2dedlnknikkrwg5f6ocuvjrogdjuqyg4sg6zkkao4w4yyvvsje@dkt7rco3fen3>
References: <CGME20251028122315eucas1p159b65037cf6f3f710c1917e2464399b5@eucas1p1.samsung.com>
 <20251028-pwm_fixes-v1-0-25a532d31998@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lwldfp7ktswpmmdy"
Content-Disposition: inline
In-Reply-To: <20251028-pwm_fixes-v1-0-25a532d31998@samsung.com>


--lwldfp7ktswpmmdy
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/4] Introduce import_ns support for Rust
MIME-Version: 1.0

Hello,

On Tue, Oct 28, 2025 at 01:22:31PM +0100, Michal Wilczynski wrote:
> This series addresses build warnings reported by `modpost` for the Rust
> PWM driver (`pwm_th1520`) in linux-next:
>=20
> WARNING: modpost: module pwm_th1520 uses symbol pwmchip_release from
> namespace PWM, but does not import it.
>=20
> These warnings occur because Rust modules, like C modules, need to
> declare their dependencies on C symbols exported to specific namespaces
> (using `EXPORT_SYMBOL_NS` in C). This is done by embedding
> "import_ns=3D<NAMESPACE>" tags into the module's `.modinfo` section, which
> `modpost` verifies.  The C macro `MODULE_IMPORT_NS()` handles this, but
> the Rust `module!` macro lacked equivalent functionality.
>=20
> This series introduces the necessary support:
>=20
> Patch 1 extends the core `module!` macro in `rust/macros/module.rs`
> to parse an optional `imports_ns: [...]` field and generate the required
> `import_ns` tags in the `.modinfo` section.
>=20
> Patch 2 adds a convenience macro `module_pwm_platform_driver!` to
> `rust/kernel/pwm.rs`. This macro wraps the standard
> `module_platform_driver!` and automatically adds `imports_ns: ["PWM"]`,
> simplifying module declaration for PWM driver authors.
>=20
> Patch 3 updates the `pwm_th1520` driver to use the new helper macro,
> fixing the build warnings.

Given that for now the pwm_th1520 driver is the only user, does it make
sense to merge this series via my pwm tree? If it goes via a different
tree, I'd like to have a tag to merge into my tree to hand over code
which is free of warnings to Linus in the next merge window.

> Patch 4 includes a minor clippy style fix for the `pwm_th1520` driver.

If you could mention the command that makes this warning visible, I'd be
glad to add that to my repertoire of build checks.

Thanks for addressing the issue
Uwe

--lwldfp7ktswpmmdy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmkB5pkACgkQj4D7WH0S
/k6UYwf/aiVsmV7r/vjSJFC7oRNtghIAzmFFDcufzkGp1TwjNtiHxd4YrClxhsz/
MOcxmpcNkV/v2XVyNiKW0Xyyex/qwXN6tDX2JMFfcV09ShOCL9N4BTXznK0a7BEB
1IGAETAi5P9nQhgoTVFcOvC25+50BprwsewCeiHF/g/kV2RSQJWZnnqO/j4ldZjz
PDnj5fTuh+RlP0v5ylkA3zai6OehtTthAor6zx6MVjn+wrewOMQtD3wLYr/yIkdA
vvarCxMjRTfVV6fe77LkdLPpy+Dfj/j6eLaYGUckmgIyFKMuKu6SrJT5CDiHgtoK
sSpNMbCFNacM7GRgIdYJD70j71Xy+A==
=mmj+
-----END PGP SIGNATURE-----

--lwldfp7ktswpmmdy--

