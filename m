Return-Path: <linux-pwm+bounces-6311-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E129AD670B
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Jun 2025 07:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0B20179ABD
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Jun 2025 05:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCAC1C84CE;
	Thu, 12 Jun 2025 05:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p36EjwWz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A878F40;
	Thu, 12 Jun 2025 05:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749704520; cv=none; b=E4HAkj4rTxYQsXSWcvUmlVZSqjrSzcW3RyFrtNxJubp4+WoUVFRMUOtQWlVIwSKvc6rCEWX1YZXoACpu759oksXxv5HSkjVhZvrRgsgPTa809KYci7NM9YjZvYykv1bZEtjo+t9iEtC01G0HsFMa/q1gPY6VWK6m+848q+gNuYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749704520; c=relaxed/simple;
	bh=AtroGsAe8tO4vVOIvU9dZHQFrQmVDJFDiGO4t+qeGxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OxtVDxp9L162+ndcrIRQ3U+ZLOhJtRRRpPhsnrZ0vDzOpFfCewwb3KNgOSteZCqi4CyH5edVuFCa6VwzRjRJanXbtS7Q9/+w/WVailNiIaF3fAqOoSlDu5rQFjqdXWSzCCQ1vhdq+kzyEaQDRj5fbV5088S331etOI7R6h9sn4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p36EjwWz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B056C4CEEA;
	Thu, 12 Jun 2025 05:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749704520;
	bh=AtroGsAe8tO4vVOIvU9dZHQFrQmVDJFDiGO4t+qeGxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p36EjwWzOyew02KLXojOZJEFfyicj5NHustdqU8N+dsi1IDmylP1c8gN3qks1itWY
	 me2jipboB28iWBiTsqUO/GaetMRgUflT+wIoiYUjzdarPmtHZTlexvOeh2FpQFlIiB
	 tmqLKmihEz0qniwD96JID3jgHjsjSFyhPquQLjPxgByUTBuDGuBAvTpMjbO9N7Zhz2
	 3g2JFPiNzTW71iZB1+er7DSSAzbJlurmx97+56uHNiAfSc3aUr9kw2oS8yMgcMbNEl
	 eWhL1AK6GHUABpFlLu156DKXuFbHz1V4yN5SC54F+8dibyD7rLKT+BzGsCyoOeMQlL
	 eI3GbtCoOJ4iA==
Date: Thu, 12 Jun 2025 07:01:57 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Drew Fustini <drew@pdp7.com>
Cc: Michal Wilczynski <m.wilczynski@samsung.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Benno Lossin <lossin@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 0/7] Rust Abstractions for PWM subsystem with TH1520
 PWM driver
Message-ID: <t26bhukukjzy7e4d2omtvjchxxzlnfyx54ku7xbytcnxkuk7xk@6tap2t3z2oaq>
References: <CGME20250610125330eucas1p2a573627ca8f124fe11e725c2d75bdcc9@eucas1p2.samsung.com>
 <20250610-rust-next-pwm-working-fan-for-sending-v2-0-753e2955f110@samsung.com>
 <aEifXZnLxKd2wa0w@x1>
 <6ca6016e-3b17-48a0-ad8d-bb05317aa100@samsung.com>
 <aEoWtviFl0vYATXe@x1>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xq7etcxgxyqwg5gi"
Content-Disposition: inline
In-Reply-To: <aEoWtviFl0vYATXe@x1>


--xq7etcxgxyqwg5gi
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 0/7] Rust Abstractions for PWM subsystem with TH1520
 PWM driver
MIME-Version: 1.0

Hello Drew,

On Wed, Jun 11, 2025 at 04:52:22PM -0700, Drew Fustini wrote:
> I also enabled the pwm fan driver. However, there is a probe failure:
>=20
> [    1.250921] pwm-fan pwm-fan: Failed to configure PWM: -524
> [    1.256546] pwm-fan pwm-fan: probe with driver pwm-fan failed with err=
or -524

524 =3D ENOTSUPP, so it seems the request had duty_offset > 0. Does your
fan use PWM_POLARITY_INVERTED? If so, try without that flag. If your fan
really needs an inverted PWM this of course makes fan control buggy.
With the next revision it should work fine (as a duty_offset > 0 should
get rounded down to 0).

Best regards
Uwe

--xq7etcxgxyqwg5gi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhKX0IACgkQj4D7WH0S
/k5cmwgAojpI13yoKGdS0NWryMcPvKU5a+1JbPt59o4PXbaSw5knpBShYrBVXz/I
7d18yAnyyXsniwR1hd0KJPktunPYQR6xtv6d6TiaoiJhfziuznFm6d/lbC4ORtJe
pXXEp1J1wCQobTjVt6PTmqNSkqStH5vAl6uEEb/0zHIiJ7DGKlqu7cKqlkeo6InV
e/1Qsf85Pkc8v57zQBRoukYNU2MjJNh12bBfeYX8jCsxkU2FZuYljB22ByRqH15S
hTJVeizgoIuoxNWKiI4nL1nVAr0YF40ieDXvpFIAHDbkPuu2hvvWzsl49PX9yWjs
kgjE/rz6QmYYc90F6zSylgYQ14rObA==
=nVye
-----END PGP SIGNATURE-----

--xq7etcxgxyqwg5gi--

