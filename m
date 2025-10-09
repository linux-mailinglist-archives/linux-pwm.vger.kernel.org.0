Return-Path: <linux-pwm+bounces-7429-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD2DBCA51C
	for <lists+linux-pwm@lfdr.de>; Thu, 09 Oct 2025 19:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C1283A2132
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Oct 2025 17:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243FB237A4F;
	Thu,  9 Oct 2025 17:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YSDSAwKi"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39E2235045;
	Thu,  9 Oct 2025 17:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760029523; cv=none; b=gZTdeC1+pG8EVb9AUfwU1/VqQ/MDRFgy1vp/W4g6XyrQnizpdf5rapqskAc4p0Aj7Hd7ID80Jq5hItztD2vJYtUtMbDEqmzJQFRp5GZ0CRiDD+mmlEZX5XC1gZNqSszeWw/76YLTouQxlHQvDvGZdqonN2THMQeBF5+Qsh9lSME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760029523; c=relaxed/simple;
	bh=K/920CR2Ytam1wn7N7JUroePPcHUf353y47OxV5zx1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rpKwv3g0I2tNy8ClmF5gvkNOExP/Ay8pZQvZzZLAr1QLALvetzU0eVyxiAA6VXzEWqZxtIjMuAjLr63C9wYmKMxjPFZYWdt5jBTCq2aEw57r2BohuXPRjSbNp7UGhJqn0c3mmQE9i8Z0HXyz3w0UCodJTsudwkgetRp6cBJUqvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YSDSAwKi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E870BC4CEE7;
	Thu,  9 Oct 2025 17:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760029522;
	bh=K/920CR2Ytam1wn7N7JUroePPcHUf353y47OxV5zx1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YSDSAwKixJwAcuHpinVRh5i8UjuDftvpwmX8U+4+hsr3pjU0Kbr04cRyidWCCnkKM
	 0Zjz/FeI+Ghya5Hv1eFFXoyr2eNZIcuCC1Rgs9j5NzmzqKQcRH0rNdrDwWL8L4FPlc
	 12dmobDe6OngdQ5rB86UsySfUB3ZwpGiX9MhYMHlO2DlkXCuNys8WYxZbOrZU7DXq6
	 2ORjBMXNo7aZziGRzAzMsbtE7rQNSvZXAcexQzPtX4GsFPF+oPa4dnSVExXvVg4EGk
	 1YAqe20JovGVMdObbjqS2teB6rD0y/UbPgM7xVj0Q3ahKEZSDk64uxCety8RxbxE6n
	 ipKVeFwUr/wpw==
Date: Thu, 9 Oct 2025 19:05:20 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Elle Rhumsaa <elle@weathered-steel.dev>
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
	Drew Fustini <fustini@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v15 3/7] rust: pwm: Add complete abstraction layer
Message-ID: <pxwzgjl4men4ia2jfky6i4pcpzmlxnuorzltfsurrosz27atbz@n2x7bt77nd5n>
References: <20250930-rust-next-pwm-working-fan-for-sending-v15-0-5661c3090877@samsung.com>
 <CGME20250930122733eucas1p1017471af8564a40f60be74c5ae50bbc4@eucas1p1.samsung.com>
 <20250930-rust-next-pwm-working-fan-for-sending-v15-3-5661c3090877@samsung.com>
 <aN2Vrf97-uCR41x9@archiso>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5mhwlegpqwr4uy3k"
Content-Disposition: inline
In-Reply-To: <aN2Vrf97-uCR41x9@archiso>


--5mhwlegpqwr4uy3k
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v15 3/7] rust: pwm: Add complete abstraction layer
MIME-Version: 1.0

Hello Elle,

On Wed, Oct 01, 2025 at 08:57:17PM +0000, Elle Rhumsaa wrote:
> On Tue, Sep 30, 2025 at 02:20:34PM +0200, Michal Wilczynski wrote:
> > [... 700+ lines trimmed]
>=20
> Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>

Can you please trim the quoted part when you reply to only contain the
relevant part? Having to scroll several pages to see your one-line reply
is not a good use of my time. Multiply that by the number of recipients
of your mail.

Thanks
Uwe

--5mhwlegpqwr4uy3k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmjn600ACgkQj4D7WH0S
/k5XeAgAnu0TfZoOsdkntucLzQ0zg0HTTAqaoe7N7MdLgsQQHxRpQxck6cJb3Vw+
1J8jo8DQzCi+lwytWM5iubVukxGFCxFV5h4Qp0bW7/eYCK/fTscZ7g7uuKO+GS0D
7s0Lr6MOsfe1MjqHyqAMKZYHWQjwZresPWVJCpyuInAhCoV60f1SSEoWsrwkpdZX
CFREtKf1Gn5yYj0cNQHl8ubNIZ3uW4tlbvj93wZjztMXQROG/8tvJ29vcUTdSqDR
UbF+xPvIu1hVRAtLjGwm3PBioLnwB01cV0g427s3pDSwNRUrsEC4flnJAqKa9r1g
PvYN7XNxSwfgteGrqDjFVby3Ap8cBw==
=Y2eC
-----END PGP SIGNATURE-----

--5mhwlegpqwr4uy3k--

