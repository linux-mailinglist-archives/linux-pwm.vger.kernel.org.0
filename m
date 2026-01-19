Return-Path: <linux-pwm+bounces-7950-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E01EED3BA02
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Jan 2026 22:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CFFC3022A97
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Jan 2026 21:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDCE2E4247;
	Mon, 19 Jan 2026 21:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7iBdI5N"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC4423B604;
	Mon, 19 Jan 2026 21:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768858182; cv=none; b=sx4xdOYVWE/gspsnLdVOUOJC5uY10rEJCoY53Y0/imrPIPvRbXxCc5PZG/TTmIXyzA9OLKi9Cr5jNjQvvyWisD7UJXbjKDGKL8D02naX2BLWMEluP2ABEmSotBB8K1DbMcRmbO8ZIpWJm4Q9qrlthLk2vlfW8CHv3ibTkbVg5D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768858182; c=relaxed/simple;
	bh=aM3fXKuu9EbVI+nuRpMYzyEQTSgopGTeW8u5LNhUyEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LItaeVicKMj4vP2RSQt3k29DNK0Zwv3gka/5tb+hyzjp5Fkdu4JvWqABqF2i1JLY2BOd0SRak2myKpK+fcmQyePoZ1ZKYptyuB8HSGuwpduYSEJL9kl7qne9rLzd/1YBsCYfWIKyG04Kf/obmxw6HzpA+tmw0AXnWiF6+4hbxkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7iBdI5N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D346CC19425;
	Mon, 19 Jan 2026 21:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768858182;
	bh=aM3fXKuu9EbVI+nuRpMYzyEQTSgopGTeW8u5LNhUyEY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i7iBdI5NlT48VwxU49+ne/xz5KXHbUAiJjlGISO6NUPpXcRMwQVnK7ndApRB7dXXy
	 kKB8u/phqsa6NfMP9GBU6D5k5E5P/ZQp4lQOsAfieBDCoaNfGOqE3raNdI/DbC9hWx
	 M+Ux3/ChrM6Dc0NMijZSUCrDox4NpQGFl9f9yUTjrAa6Mvr7fvZMFlQHXb06a0GxEC
	 QFgmn/wVR3FXj007LhyWnWh0TR1LlsYFb8ieqO2Ut7CWXe4h46jvJ6NW282R3P5HJi
	 f6SKL/MPlcjm0IOaG6PKg3rmy3QpSGi99qVS7MmdFjxmN+WoFmQLVJlQ4RY8E8vrf3
	 CjkolmWt8v+4Q==
Date: Mon, 19 Jan 2026 22:29:39 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add myself as reviewer for PWM rust drivers
Message-ID: <3ceisrg5swq5gx6qciudduf4dex5hecrhiwmqdao3c7ccy7ik7@m7kyf4lv7e4m>
References: <CGME20260119205601eucas1p159c1d9e17776f68d0367058f1d97e3ea@eucas1p1.samsung.com>
 <20260119-maintain_rust_drivers-v1-1-88711afc559e@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="os2ho4gvef2mjnlv"
Content-Disposition: inline
In-Reply-To: <20260119-maintain_rust_drivers-v1-1-88711afc559e@samsung.com>


--os2ho4gvef2mjnlv
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] MAINTAINERS: Add myself as reviewer for PWM rust drivers
MIME-Version: 1.0

On Mon, Jan 19, 2026 at 09:54:58PM +0100, Michal Wilczynski wrote:
> I would like to help with reviewing the Rust part of the PWM drivers.
> While I maintain the Rust bindings, adding this separate entry ensures I
> am automatically CC-ed on the driver implementations (drivers/pwm/*.rs)
>=20
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>

thanks for this patch.

I will probably send a fixes PR before 6.19, and think will include this
patch to have 6.19 already fixed in this regard.

Best regards
Uwe

--os2ho4gvef2mjnlv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmluokEACgkQj4D7WH0S
/k5UAAf+Mu2i9+xidhHxJw8CsORCW8s+QCFC23Gnbk+axpuJT2Ziedjs+E/WjJ5m
bKqpAysYllAooI2bBZQnyezl+bmAOmYM4W1jmVFSKV5Zu4EcYXBqZj1+M67VT2sy
1e6lvF/Fi5LKAv4Omb8XYql0Loi3wS0vfWNyi5ZL3o2J9UVTDndz5BcppVgumvc1
NCjXRS2h5jvSMZhlSom9tsAuUv9mJRpGyDHWBgrqzZwPt0taQxngIpQGGJC8oylT
+96CZe7VpZ/LXzROhOGCWt3o/EuYeJ/UwxJUolvTH1AoZZIUjiCoZzgc6IJBeJWR
lHMGuK0Q1y6gaOA3z3W99dAWmFsV1A==
=gx0A
-----END PGP SIGNATURE-----

--os2ho4gvef2mjnlv--

