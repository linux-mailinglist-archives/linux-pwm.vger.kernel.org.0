Return-Path: <linux-pwm+bounces-7489-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D64C09027
	for <lists+linux-pwm@lfdr.de>; Sat, 25 Oct 2025 14:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 15C974E3114
	for <lists+linux-pwm@lfdr.de>; Sat, 25 Oct 2025 12:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C90E2F7AAD;
	Sat, 25 Oct 2025 12:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q83Pe8v0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4DF1DE2A7;
	Sat, 25 Oct 2025 12:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761395195; cv=none; b=pM0y53YkEgYYfGx4ooLOZfXiKOc2Z9Qm7rlj6yGqUV1owK+gUC+mljsGxQzVgpGjYCbgRo4tvXrcLtaJNXDZDvJOVcYObhXnk0FfCkduK7O6j+D2HWxJPvyP/VXU7IkiRDab1fqnS+OM7YV+Db3+wYRZ8dF/3/QH2WuMFKz+My8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761395195; c=relaxed/simple;
	bh=XA0LBs60d1Gvp183PYeVpoLINndtx657oSRL5oD+WDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O3c0exkxlfm43REDKaY5eIhiWAcJ4Up1/52VJsSkIbDv1BPZ99zDgqi5yN7GDjDfdHeMULbqPQKgerSpIdohH8TO4FgrP43R5ciYYXuoS45Qc4qJCC8bc1q/ACRaH1+x/bLTPZX3P5P4d6yKdcNbL6e9UKbCHfVAfL2Vto5U6vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q83Pe8v0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9938C4CEF5;
	Sat, 25 Oct 2025 12:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761395194;
	bh=XA0LBs60d1Gvp183PYeVpoLINndtx657oSRL5oD+WDA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q83Pe8v00HZSQX7uT5MUCkv+RSQ0sCD2ZvTt+39uUCtCxY2Q5M3ONxRjtbJ+nLhcw
	 H96l3nQpb3HCrmkwHvUCLROfeQsp9O24gFbw5x2/Sqgy+aN9JdIURBTdBThyEua9L2
	 3vFneTX6dits3KSah7JKehEWXFu4woLfrdttgWSzCDpRT48ZfrJAQTHooLhQ5Dp40q
	 y/TxnimxmWT5jSZBP6YvYF7ADSr9NkX2B7K2vZ/36MJuSe9vbi+T73j4ocC9sak8Ff
	 HX88tCY3ZiQhVI1V6SUV92Vl+Qp8yYsb8rliJELdHADX/FWHUnXl4tvaQeF1DUhBgs
	 Z1Xjj2MNgNZMQ==
Date: Sat, 25 Oct 2025 14:26:31 +0200
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
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	Elle Rhumsaa <elle@weathered-steel.dev>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v16 0/7] Rust Abstractions for PWM subsystem with TH1520
 PWM driver
Message-ID: <47ut33rck4xoh3d7d6t3d7twqag3u7eusbruc2i2veqf2umpga@ipamilvshysw>
References: <CGME20251016133814eucas1p199cb62658c016e84e34d525e7c87f16e@eucas1p1.samsung.com>
 <20251016-rust-next-pwm-working-fan-for-sending-v16-0-a5df2405d2bd@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ue2aydelqwngvqlb"
Content-Disposition: inline
In-Reply-To: <20251016-rust-next-pwm-working-fan-for-sending-v16-0-a5df2405d2bd@samsung.com>


--ue2aydelqwngvqlb
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v16 0/7] Rust Abstractions for PWM subsystem with TH1520
 PWM driver
MIME-Version: 1.0

Hello,

On Thu, Oct 16, 2025 at 03:38:00PM +0200, Michal Wilczynski wrote:
> Michal Wilczynski (7):
>       pwm: Export `pwmchip_release` for external use
>       rust: pwm: Add Kconfig and basic data structures
>       rust: pwm: Add complete abstraction layer
>       pwm: Add Rust driver for T-HEAD TH1520 SoC
>       dt-bindings: pwm: thead: Add T-HEAD TH1520 PWM controller
>       riscv: dts: thead: Add PWM controller node
>       riscv: dts: thead: Add PWM fan and thermal control

I applied patches #1-#5 to

	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-next

. If I should take the riscv dts changes, too, please tell me.

Best regards
Uwe

--ue2aydelqwngvqlb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmj8wfQACgkQj4D7WH0S
/k7+mQgArnA+n9XWQ7YH1TKmkOxj0p/41RfGGWkpSKUxrKtQrhlFAky5iBDQddtZ
L5w7qHIIRJQLc8P1MuUe1zyfX4iodXGazEiFpz7I0wAS3xft3Aa4rqB0qFRFIxGv
bgM2exfnJvjiM21WwGXTniDq/GsDHCYqeazwECCb5+/4amap245Rw1ZWtTDZGIm1
YX7SsPJrZ3X+L38nZN0n/SeVNH3VU5b1e6yXyaQKf7lGOLFutchQqYdLE6Vno+5k
Ul7eJiVK+Zlrl5LKNHdvjMCvi71GBoNbqZZj1xvSLRINwq1lZQgJg6yVI5w9sr/m
F44ES2C4FsgmuPqY74u/UnfUJw8yVw==
=WOZX
-----END PGP SIGNATURE-----

--ue2aydelqwngvqlb--

