Return-Path: <linux-pwm+bounces-6334-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD493AD7C7F
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Jun 2025 22:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAB701888EC4
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Jun 2025 20:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDC22D5421;
	Thu, 12 Jun 2025 20:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0S2M7k7"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4123D170A26;
	Thu, 12 Jun 2025 20:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749760589; cv=none; b=ZR538M6sVj2E52Ry6+8qipqwob3NCTpFS6Gm5hiMlaarQcsINcksrgqqtV12pXYXrMv5sxpm0XavneWPJzTa0+JjqEYVpHQ91OyhyZf+RdF74MTB91VlI3W6UTRHXLtYNfu8y0L3t63fnm2lHNEYNi9Zs8gRGJYO48goHhvFOtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749760589; c=relaxed/simple;
	bh=X6ZFmCqv+rVQiA6r4vfqa/BBIukFpY3bI33k6qaoFMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RO7l9rdox8xuHsaAgDta5kKFf+d3/7vUdwgfr7pzFG66Twu1XJYDyHWo3S1suh0lMeuHqtwxppCiUfhcX/n6OijfejQz+nSncokUNkdDmF4te4xUp3tOr76GKOxJ8NBChF3L1TGCazp/PpKRPBmuOoieqfFk7/LPm0IFAHH9ehE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0S2M7k7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D087C4CEEA;
	Thu, 12 Jun 2025 20:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749760588;
	bh=X6ZFmCqv+rVQiA6r4vfqa/BBIukFpY3bI33k6qaoFMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i0S2M7k7+SGKzMwSIMzZZEk5sL16d2Rz/FLrH5H6V05cfgV2rfDn9SNLK/jxRW7rO
	 /rDPqMCHc8CpiB0/icznBRUOQj5wcOGy8TVaWLyESU19XBnPcUVOJIAlDRgNRGVsaX
	 g/RGKFXImxrbR92yDWJ/gf7hnH7oRhJon9+YYETDW8FmgaV6KdsleDippxdoFRMQ7m
	 prEEf3bxSA+1gRObi5g80zpz0ZRa3j+asn6UOwy27WAGZud4eqrqdTkhw12dBwmpcv
	 esj6IuleWtNd7rkPZFhwf5Naojmoo0lXKfBbESHB+Du9+kRt5l7Hdwd0JC8wqEF7Vt
	 4YLz04gqNL4bA==
Date: Thu, 12 Jun 2025 22:36:22 +0200
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
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 2/7] pwm: Add Rust driver for T-HEAD TH1520 SoC
Message-ID: <5aam5ff3m24yzsqdh7w2zplccuwmmr2no7jhgmdnxggmhpo4hl@r6iawlw7f42m>
References: <20250610-rust-next-pwm-working-fan-for-sending-v2-0-753e2955f110@samsung.com>
 <CGME20250610125333eucas1p16126b64a0f447a5e9a5ad553d9d7d79d@eucas1p1.samsung.com>
 <20250610-rust-next-pwm-working-fan-for-sending-v2-2-753e2955f110@samsung.com>
 <jbm3qvowi5vskhnjyqlp3xek36gzzqjt35m66eayxi6lmi525t@iefevopxjl53>
 <d1523586-82ca-4863-964f-331718bb1f0e@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5np625sv2e7hqcqz"
Content-Disposition: inline
In-Reply-To: <d1523586-82ca-4863-964f-331718bb1f0e@samsung.com>


--5np625sv2e7hqcqz
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/7] pwm: Add Rust driver for T-HEAD TH1520 SoC
MIME-Version: 1.0

Hello Michael,

On Thu, Jun 12, 2025 at 10:14:13AM +0200, Michal Wilczynski wrote:
> On 6/11/25 08:58, Uwe Kleine-K=F6nig wrote:
> > Huh, if you do the newstyle stuff, .get_state() is wrong. It's either
> > .round_waveform_tohw() + .round_waveform_fromhw() + .read_waveform() +
> > .write_waveform() or .apply() + .get_state(), but don't mix these.
>=20
> In the process of implementing the full "newstyle" waveform API as you
> suggested, I discovered a hardware limitation. After writing new values
> to the period and duty cycle registers, reading them back does not
> return the programmed values, which makes it impossible to reliably
> report the current hardware state.
>=20
> This appears to be a known quirk of the hardware, as the reference C
> driver from T-HEAD [1] also omits the .get_state callback, likely for
> the same reason.

Do you read complete non-sense or e.g. the old configuration until
the current period ends?

I guess would be that .get_state wasn't implemented because this is an
oldoldstyle driver and it works also without that function.

> Given this, would it be acceptable to provide a write-only driver? My
> proposed solution would be to omit the .read_waveform() and
> .round_waveform_fromhw() implementations from my PwmOps trait. This

Please don't skip .round_waveform_fromhw(), that one is needed for
pwm_round_waveform_might_sleep().

I don't like it, but given that the hardware doesn't play along there is
no alternative.

> would mean the driver can correctly set the PWM state, but attempting to
> read it back via sysfs would fail (e.g., with -EOPNOTSUPP), reflecting
> the hardware's capability.

I think there might be another patch opportunity then to make PWM_DEBUG
work with that.

Best regards
Uwe

--5np625sv2e7hqcqz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhLOkMACgkQj4D7WH0S
/k4ucQgAuqXHTYO1I3RV2AzSFsFd2LK5PaRAhfs5MWWKlBDbPjW95mxdlioBxzyq
+fee+3TYWq4FMe9u7ogpJKQvFn7yDZcR5Iy9SH78CnHEAugQG8L0GZ3OkRUQEc5P
OsuxPI6MY19uVPT/phoGVYdRb1X6/X9lvsVg/rItyJTNcChYmqm5cc9QHgv6wY+D
AKFTu2CUaSGuJUQR8WYz8+Z/Mtn/Zy8jgKkoMHosAfELqSZDK5sijuGrTnh03a52
J5FC1Pc5JaqXDJIDXwt3+HqkWi9vnms23HE4Kk4B8oFmJhHuCHP/Sbg6ocx8y5Om
sfhozLUhiIsfiZp/dXwaRpbOdkmJjA==
=jmz9
-----END PGP SIGNATURE-----

--5np625sv2e7hqcqz--

