Return-Path: <linux-pwm+bounces-6810-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B64B003BA
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Jul 2025 15:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C94C87BA194
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Jul 2025 13:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA8625F97C;
	Thu, 10 Jul 2025 13:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDXrnUIW"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABA225A620;
	Thu, 10 Jul 2025 13:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752154568; cv=none; b=dkFLXwYWSDsNpib7UzrlJksH99cEnpXv4i71myIvUOsiGriGMMwEAoBNPjADJ3gWebvQUsru2agnhF+pMIPpxFLgXiISkgr6pJ70KrIeAizs1Va8tSiRoiZ0OQ7pdJkiJVOcCHfkeielAuS2yAP48DbFiV0a2CpcL2aN70oHD7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752154568; c=relaxed/simple;
	bh=9U/HceOPkg0DS9fAXJ0Lfad9nJhdWKPl5eqrIs+HbC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fgYHDnxCXSiAdjnl4ch3MoK9cbi/cnA6iCpVM7w170iNo6/LViCcGWEjudVb/UZkXHcF8L1jKbuUR/2lEV5kRVg1uMxvWVWSzc/+LP+IzZ850EEZmrocK6X5ivy0YzHtAH+lBHCaSo/Kyy7l8c7OUsQbOlb//5FHH7ihIBQkz0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bDXrnUIW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87626C4CEE3;
	Thu, 10 Jul 2025 13:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752154568;
	bh=9U/HceOPkg0DS9fAXJ0Lfad9nJhdWKPl5eqrIs+HbC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bDXrnUIWdk1WEgpplj4B8WExCpP0vcKx4ik4gldCnSqOgryb1RG1xkQEXfYhpdFv6
	 VCjpJyxFAoclIKLaBUfrVd2k18sdkmrg4r77Tcfjxm64JxcjOBkV4QxUojNm5gjsvI
	 OiYBZyBF15RGRSopWzXvNnlDCz+/zJgbBCSPtweXitgbNCcfGtZHku5Bq85nLt0Sta
	 1BwPCvP0TJ72khmbLEk/gF/HHv3pqyQWKwubjviWCLkdpQBUaByqPqmiNvo43yPaVh
	 EqEaXYduyC69WHePdnY+gs+Ak8JqcTyrf4NVORSoWw8uip8YfBigPz+/8anspyLe9R
	 ByYxi9TL/3pSw==
Date: Thu, 10 Jul 2025 15:36:05 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Guo Ren <guoren@kernel.org>, 
	Fu Wei <wefu@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Benno Lossin <lossin@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Drew Fustini <fustini@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v10 0/7] Rust Abstractions for PWM subsystem with TH1520
 PWM driver
Message-ID: <judbbl4d3z7nd2wi3grlwf3cmqgdycb5ljyyqx6r4w2zluhmwy@yxrqnf2hcnzw>
References: <CGME20250707094926eucas1p155bd967b6986c4a999776839b1aa1fc6@eucas1p1.samsung.com>
 <20250707-rust-next-pwm-working-fan-for-sending-v10-0-d0c5cf342004@samsung.com>
 <e8a4a821-e7e4-4bcd-a2ac-f6b684b6ceea@samsung.com>
 <DB8AQ15RTAJ2.3QXX8Q2FTFGCP@kernel.org>
 <e494422b-b989-4dc3-9828-b080dbf4c34d@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gtidwru4q5xzuxiv"
Content-Disposition: inline
In-Reply-To: <e494422b-b989-4dc3-9828-b080dbf4c34d@samsung.com>


--gtidwru4q5xzuxiv
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v10 0/7] Rust Abstractions for PWM subsystem with TH1520
 PWM driver
MIME-Version: 1.0

Hello,

On Thu, Jul 10, 2025 at 12:29:59PM +0200, Michal Wilczynski wrote:
> On 7/10/25 12:17, Danilo Krummrich wrote:
> > On Thu Jul 10, 2025 at 10:42 AM CEST, Michal Wilczynski wrote:
> >> I was hoping you could clarify the intended merge path for this series,
> >> as it introduces changes to both the Rust and PWM subsystems.
> >>
> >> Is the expectation that the Rust maintainers will take the abstraction
> >> patches into the Rust tree first? Or would Uwe, as the PWM maintainer,
> >> pull the entire series? Any guidance on the coordination would be very
> >> helpful.
> >=20
> > Except for the helpers I only see PWM code, so this is fully on Uwe's p=
urview I
> > think.
> >=20
> > I see that there is a new MAINTAINERS entry:
> >=20
> > 	PWM SUBSYSTEM BINDINGS [RUST]
> > 	M:	Michal Wilczynski <m.wilczynski@samsung.com>
> > 	S:	Maintained
> > 	F:	rust/helpers/pwm.c
> > 	F:	rust/kernel/pwm.rs
> >=20
> > I assume this is agreed with Uwe?

I suggest to add

	L:	linux-pwm@vger.kernel.org

then I'm happy with it. I'm definitively not capable to review the Rust
details of Rust code. But I think Rust is readable enough that I can
judge the algorithmic parts.

Best regards
Uwe

--gtidwru4q5xzuxiv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhvwbkACgkQj4D7WH0S
/k6yoAgAk02SY03Ptnis1ix+FQupN4IF3FlEmjwh1sv3okzPCCkoQoHQEmR40NWi
hahNNioLOEuKJVHAtFowU5tIW79zPiNHaUTuByh44Xb/NHRRxHQTlhT612aDJmKl
2tOvGdt4YPLK3V9abpk+kaAwwZ5QoWjs8YexssyffZMRxzAmE4e80plkC8yrm922
tRgumP0GJBQNGaH9vDCweni2vkAM46xznNv0XqDfuDSTEETTavkinGz/sB0BI3aL
w6UM96f1Pn7Q9q3lGis7kmUyQKNaImE/qklsv+K0khHEOsa2j8wRdbHFKpJPjnt8
lZs6tH/nHMHVffYc6B0fL1FUiFsMOg==
=P4yP
-----END PGP SIGNATURE-----

--gtidwru4q5xzuxiv--

