Return-Path: <linux-pwm+bounces-6709-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDE5AF6A8C
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Jul 2025 08:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34F4316CCF4
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Jul 2025 06:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3950291C3A;
	Thu,  3 Jul 2025 06:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQ4uNE78"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86259291C29;
	Thu,  3 Jul 2025 06:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751524931; cv=none; b=ZohtSSDwIiMwS0GHLYSa/xaFeIC+J2qyVSia/Ln+8fvzMvoNHQaRGlVMPR7YeQJyd+6XphB/OQ5sL1/UnYrCJECT7WOSIq5pNeC9Ypmfgz0jRVUV71wsQUr4v8E9LXw4oWgDKNlxP2DQiWruQGeEst0Q4YXPa3GgHAD9LupMFvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751524931; c=relaxed/simple;
	bh=cj9NFtN0xsWiVmMtfQkfpbIOndV8+ifluU4LHQQxzFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dKuXXn01Q4ZCCGw1KpEZJhopoXNR3DOcU2LCcbfe04HD39MwcbITaWshmOsW5IrQDyprnet5oqn9FWWLhWi8bs/+XhZUeP2ozA0wTXhi+9zBZdEyWBUmVUqb3q5vlSPPg9xa2BVktQdHhVkV6bjrz9bR2QleicsQMoPed1PvR2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQ4uNE78; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84DD1C4CEEB;
	Thu,  3 Jul 2025 06:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751524931;
	bh=cj9NFtN0xsWiVmMtfQkfpbIOndV8+ifluU4LHQQxzFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jQ4uNE78oOdm1TrK/C+9W1ZcQRpJEDoLeMh2Q891i2oZUfNuQC9x9ASxlBjBehDjV
	 hf5grWtAx5wGkGNO12BwAsksZDxw/m/CTKBSin7i8XggvWBsnFY8jLcO/rXEKLCW/p
	 yACAPwI7zcMvXfIw1gZ+FB3PaRJqMh/l1kiPpTTwt9fscVTyZJYgvsxAf5yTInlI8I
	 1KkDJzQNB4DFmY5tBaASWf9VPdc902hMnxlMjcsv8RN5/gXFaleqLy1zHcLidZexXf
	 8jm9mXqE+dAHArWZUmoi7+IUXAGPGg7iOVU+9rLgXpXecJbQTAUMS378Dhp/hmPqqf
	 pCBxq/moUoNbQ==
Date: Thu, 3 Jul 2025 08:42:08 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Michal Wilczynski <m.wilczynski@samsung.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Guo Ren <guoren@kernel.org>, 
	Fu Wei <wefu@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Benno Lossin <lossin@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Drew Fustini <fustini@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH v7 3/8] rust: pwm: Add core 'Device' and 'Chip' object
 wrappers
Message-ID: <hdc4gweo5orxjzfggelvddpmhesmzkav2w3il7asewg5lswrxh@rslvwmzofedu>
References: <20250702-rust-next-pwm-working-fan-for-sending-v7-0-67ef39ff1d29@samsung.com>
 <CGME20250702134957eucas1p1d84f2ed3014cf98ea3a077c7fae6dea6@eucas1p1.samsung.com>
 <20250702-rust-next-pwm-working-fan-for-sending-v7-3-67ef39ff1d29@samsung.com>
 <aGVMnmoepIVSS0yK@pollux>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uhbdmr5uuwnvygor"
Content-Disposition: inline
In-Reply-To: <aGVMnmoepIVSS0yK@pollux>


--uhbdmr5uuwnvygor
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v7 3/8] rust: pwm: Add core 'Device' and 'Chip' object
 wrappers
MIME-Version: 1.0

Hello Danilo,

On Wed, Jul 02, 2025 at 05:13:34PM +0200, Danilo Krummrich wrote:
> I assume the C API does guarantee that a struct pwm_device *always* holds a
> valid pointer to a struct pwm_chip?

Yes, a pwm_device holds a reference to the chip's dev. So until pwm_put
is called the chip won't go away.

Best regards
Uwe


--uhbdmr5uuwnvygor
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhmJj0ACgkQj4D7WH0S
/k4x3ggAkwamiLd6r0eMJ9/ItKu0S1EKf3GNLQ7p7k9gEWSCQwPbKAiFtWCLYWkp
1BcEI20bHheXAOH5K2vryRS4WOaoy2lP5F8CgYseqkSnfIeWbeUIyR5RuS+Gmfj8
UT937rxoH1bvHiu9X0PYtoN5/DwH423JsT7EhLjyL62ycXzDU6zhB/De7MoIGo05
NSMdLALW12xCzKbAstogGf2v/WwGUvk9bynefxzU0GYpdgX+tl1U6cy7BQR+T6PD
WH6EXgXFcZymtIZ1N1nk7Jt7REFP3vh63x7+bNFRwGJSmyj7pMDU2wR4YYKCcCdi
HRunXxiTYVmJ5jnxMTs2zoE2fIDVNA==
=6vvA
-----END PGP SIGNATURE-----

--uhbdmr5uuwnvygor--

