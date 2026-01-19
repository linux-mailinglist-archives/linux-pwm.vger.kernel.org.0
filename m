Return-Path: <linux-pwm+bounces-7947-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C8FD3B55A
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Jan 2026 19:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5471530006F8
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Jan 2026 18:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A532023F294;
	Mon, 19 Jan 2026 18:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRlQFESh"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819A17405A;
	Mon, 19 Jan 2026 18:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768846626; cv=none; b=t0FVlO43daQcQoK+/P/O90IrPz9QtztgQmltDo7JcGWvhka2nfoMY3ykGVS4vGXUTTNG38hCX9Vh4DTtxRTM+xRBphG4TiLuXAqa+Saa5V1WSctnMxP9npaKhEIKmidPY7pIkvK8TiIv3hHe2kuXzEFdK1A/JWg5zPovAhCLWnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768846626; c=relaxed/simple;
	bh=zASyTGTQSFQPJTz6S2zuESVkideM51IYDimBNABRwqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F9ttw+bMGOcYxJOn6s7lb7C/U8sOaFo/pW14dc195ie9G2/d5QonUlkwj211SRkQaioGrlnW2Rzj64XUFMI2OqwHR9FRvtfbWvGMEJT517cJs8UVsB1okKT+7geWnLx2DSpSXcZajBOH61ASeD/WmYhCorS3UchRMM5/aNMPJlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRlQFESh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 919A2C116C6;
	Mon, 19 Jan 2026 18:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768846626;
	bh=zASyTGTQSFQPJTz6S2zuESVkideM51IYDimBNABRwqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LRlQFESht6e4DgS3rlGx5mdBh0UUnubb9Ru922ypel3X2jJvCjB6dDJ7xbEZL82FB
	 naP4QD4KjY1U58W+f7IuM85z0+HiOD1rnnaXmuuDNi3+7eLOdSmqt/Cmd2MxnH9G0u
	 KtmFAqw3VR3HjARY3OMsCBA8fdjuomW4ILkM50ajVKIqSfJS+7KKe1a8Luoq0taKs6
	 Q+bgoEdRxk2wtAleUWaUbRam0Emir4rNGUbwomq6ucX7vza72uDgQU7s5wBcFWrU1E
	 O2WGdAlvLvbqY2/kDKq35PWwIsq8k2r7jBplgFPWJe9rXShC890nck5z5+aUJtOfFg
	 azQhMLqpI41kQ==
Date: Mon, 19 Jan 2026 19:17:03 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Tamir Duberstein <tamird@gmail.com>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Fu Wei <wefu@redhat.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Michal Wilczynski <m.wilczynski@samsung.com>
Subject: Re: [PATCH] drivers: pwm: replace `kernel::c_str!` with C-Strings
Message-ID: <w3drdr2cm65ypplvwn3h7js25isshjqjqooqqkgg5d5zfh3ium@lveyiholocqh>
References: <20251222-cstr-pwm-v1-1-e8916d976f8d@gmail.com>
 <CAJ-ks9mrpcLaeiGjBcXNqTUwo00Y2MhhHWnWauou6exU1y920Q@mail.gmail.com>
 <2wmijhs5pbrynsgxuropvlxuozsubk7euybxzwc5ox2a3izfci@v6hzmzs5pmml>
 <CANiq72mSxtO0s8xGhgYemfz9DvvwDzC0fsF2covGFspduDz5XA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w3lb7nkuiao4zq7t"
Content-Disposition: inline
In-Reply-To: <CANiq72mSxtO0s8xGhgYemfz9DvvwDzC0fsF2covGFspduDz5XA@mail.gmail.com>


--w3lb7nkuiao4zq7t
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH] drivers: pwm: replace `kernel::c_str!` with C-Strings
MIME-Version: 1.0

Hello,

On Mon, Jan 19, 2026 at 07:01:33PM +0100, Miguel Ojeda wrote:
> (@Tamir: in the future, for patches like this, and especially since
> the patch was split from a series and was a multi-step/multi-cycle
> migration etc., it probably helps to give maintainers some context
> with Link: tags to the ones above).

And ideally also point out dependencies explicitly (also if there are
none). This gives a cosy feeling to your friendly but clueless
maintainer :-)

Best regards
Uwe

--w3lb7nkuiao4zq7t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmludRwACgkQj4D7WH0S
/k5oAgf/Ud0/7uDeUSMZsd6kQyuPiKtJSS4z9jpPGAb9PEV7iK+W4To8qZjkMuFx
Xg+PHxvy4deeONIKn13FTbrP0o0WMTXiBV8i6mm5Nw0PU6W1uDTtVEaa6YZFWaE4
3ZpofamlGM33QmyxNh0RkomtukOqIjYryaja/MCLdGEmWqUlldEVw3bM8UKO8YQI
6SPkHvpMbNmgYzhW3+3+T4baB7McdA764v8OKT5bq3j6aOHY6zOPJeA8Me0B3ydq
J3JTYrQD3o5L0uDaPh/aElS40nNLLIHUwQ193WBUjEwZlIEX/vzCFpuZwROvWHW7
AWU+14FPIoJzCoizBbcM5tOBubrcxA==
=qsY4
-----END PGP SIGNATURE-----

--w3lb7nkuiao4zq7t--

