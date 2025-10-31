Return-Path: <linux-pwm+bounces-7569-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00848C239AE
	for <lists+linux-pwm@lfdr.de>; Fri, 31 Oct 2025 08:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 275431898F24
	for <lists+linux-pwm@lfdr.de>; Fri, 31 Oct 2025 07:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B46E28B4F0;
	Fri, 31 Oct 2025 07:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sPhR7nl2"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E212115E8B;
	Fri, 31 Oct 2025 07:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761896860; cv=none; b=ZGYa5UA+Jt2+4QIbazPPAxuNXupcn0qZnMk6M8xx/m1MkJ5Y/gRRZ0viRbHIq2hSWC0ek0ey7m+9UAK9UrzX+sFU0DCkG2CinJ8+RK/FSrXHG7VYV2pKgSSvc08L4AuCZlkvh6kc5jTsQgIJ06TeSylTNbp+Ue2fXg+VML1wcHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761896860; c=relaxed/simple;
	bh=7GmpMUcbzk3IQ7Nc39bFAOvP0kWu7uS4b5WKDgdELi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=and6nLJaIWyeamiKhMASVEYDXB0dWyR3ZeZoJ6DPt85uWOeNUNnKk9umdEd3mZgyGZN2tFCpUgc6+q1ByrbKTbsN2MiAZ6LmzxxikhSna0ELAIw3Eyh/g2pORymbcQHr3eku0Y0KfliQAi5qYsK8j+XlkbOymFuNCARXtiHTnjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sPhR7nl2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09DACC4CEF8;
	Fri, 31 Oct 2025 07:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761896859;
	bh=7GmpMUcbzk3IQ7Nc39bFAOvP0kWu7uS4b5WKDgdELi0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sPhR7nl2fhn2TNbDxPnu9RgTr3vBzLt1y7c26zXBBCO0tkA1GR2wSDFXagCGhCBzl
	 HV35U/h4eoM9O6dxrv6UcjV8VQvpJduydaNFEMCJC05nzGJgwt6zSoLMkGkA85q0RK
	 mFvql6USWFFEb2/XJsR0W3JZqNm89fVoHsIo4Sny/Tw7Enk3imrpixHLz3xsy4a/uA
	 +6jlx/+0V0EU12obrPIaAP5oCzcxazoL9hsXWY4qI6hlAiNCKLkNdStudLg2ap4TL/
	 zi1s11JBuOnEcXV44LUUuPjJEiIkGWSxWPwu80hs2aNXJj3VttFW0y4HC9WyU1dU6S
	 9hLZW5Sv6yXGA==
Date: Fri, 31 Oct 2025 08:47:36 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>
Cc: Michal Wilczynski <m.wilczynski@samsung.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 1/4] rust: macros: Add support for 'imports_ns' to module!
Message-ID: <h3sivr3uuzr5oodqe326svchbw3rzo4f4nw4chpeee2jwzjq3j@bdtecauehkn4>
References: <20251028-pwm_fixes-v1-0-25a532d31998@samsung.com>
 <CGME20251028122316eucas1p2733987cd4c1eb8f83d6572d542e76d2a@eucas1p2.samsung.com>
 <20251028-pwm_fixes-v1-1-25a532d31998@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ecrpz7cwozvvwprk"
Content-Disposition: inline
In-Reply-To: <20251028-pwm_fixes-v1-1-25a532d31998@samsung.com>


--ecrpz7cwozvvwprk
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/4] rust: macros: Add support for 'imports_ns' to module!
MIME-Version: 1.0

Hello,

I already asked this in reply to the cover letter, but the question was
lost on the way (no offense!), so I'm asking again. As it only really
affects this patch, I'm doing that here:

On Tue, Oct 28, 2025 at 01:22:32PM +0100, Michal Wilczynski wrote:
> Kernel modules that use C symbols exported via `EXPORT_SYMBOL_NS` must
> declare this dependency for `modpost` verification. C modules achieve
> this by using the `MODULE_IMPORT_NS(NAMESPACE)` macro, which embeds an
> `import_ns=3D<NAMESPACE>` tag into the `.modinfo` section.
>=20
> The Rust `module!` macro lacked the ability to generate these tags,
> resulting in build warnings for Rust drivers (like the PWM driver) that
> call namespaced C functions.
>=20
> Modify the `module!` macro's internal parser (`ModuleInfo`) to accept a
> new optional field `imports_ns`, which takes an array of namespace
> strings.  Update the code generator (`ModInfoBuilder::emit`) loop to
> iterate over these strings and emit the corresponding
> `import_ns=3D<NAMESPACE>` tags into the `.modinfo` section using the
> existing `#[link_section]` mechanism.
>=20
> This provides the necessary infrastructure for Rust modules to correctly
> declare their C namespace dependencies.
>=20
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  rust/macros/module.rs | 8 ++++++++
>  1 file changed, 8 insertions(+)

Can I have some blessing to take this patch via my pwm tree? Would you
prefer a tag to also merge it into your tree? Then I would apply it on
top of 6.18-rc1 and provide a tag for you to merge.

Best regards
Uwe

--ecrpz7cwozvvwprk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmkEaZUACgkQj4D7WH0S
/k43lgf+LJYRV7/XhylyloNNOExBGW6OxuOAexD36boCRoglcjhV86Q2uMyIjEzN
i8a/laz8cvofAPfyuKZINk44WfDiGolM6Ncee2fXergLU/wQ1BNCHjBv5ceRzF7h
hYMXVSkFZXdpQIFT3Fb/dVlPhTvYH/MNHKPsYKBvSb3gnmJZi6VB/JnEq3rFCMDk
GhOmZURIVBPZZ47EqWPAxkF3uxwZMXcDrgcYp5SidQgsXkTiR8oRMutPMm6TGdu6
MgR62vBP6MalplxmqsxDJ1YNB/e7cNxxv6vo/O/ljyqZUBDr2GEkBxPysxWcm48N
5LhG2qlEyrGDF/mw46sdzgJhkm7+NQ==
=Hn2I
-----END PGP SIGNATURE-----

--ecrpz7cwozvvwprk--

