Return-Path: <linux-pwm+bounces-6708-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97538AF6A7D
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Jul 2025 08:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 368EF3A999A
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Jul 2025 06:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D59C28E61C;
	Thu,  3 Jul 2025 06:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cS5FQ8gM"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D434428DB64;
	Thu,  3 Jul 2025 06:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751524797; cv=none; b=YFFc6GE0kC87GsniRj3aqzd3YeeppQMyDwc77olbEuRpa4dTzSAVIk+JyB9v1lh2IszwRmTsoi4LpwZ9lTbXh1JVS0i8WPEtBakeBQ+hz+Bgxy6ruWzjWM8oTkZHlR0M7bOfztds4kL1UnYxsPligZ9/CnUT5S75fwmfflkuFJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751524797; c=relaxed/simple;
	bh=1DtlZynAbxcmMxWYKeQcPOcJpWmoGbzRY8KCjYTzAis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YgAuONex4d/AIsN4cHo2QOMwOYZgxJUqIzik64/bIXaYEW20mTzg6Qmw2QFGgjyOo6HxSYjgFUES/pyF0S+SrR097UTSlsAK5Xk+beA3vLosOCUv1Ulrzr8limZmuqOcVxv0X+yOGN7/81RMRRKCxcqBd0jTr3dCCH1NqwKV50M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cS5FQ8gM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E384BC4CEE3;
	Thu,  3 Jul 2025 06:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751524797;
	bh=1DtlZynAbxcmMxWYKeQcPOcJpWmoGbzRY8KCjYTzAis=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cS5FQ8gMszaFgkYhG56UX54AdDKAwwzMqYB2vBos0tW737XDwGF+bSJhEc/o5SyFC
	 OF8r2fRbofRYSQ1lnxy5miJJdvv138TZLLWOkhsqf2ouwK3Kc9HBFPdFYd56MIFzqh
	 +dM3duCn1iQxvHaHABRgViJ30kl0xSAjSyZy253Mm6zBVinAesr8A4yow5RCrxMQA0
	 Mwzuc/mjVfoVAl0Xw2/ewYBWevRlNvdUFBh58Y2Qy+zc495OjXmF1wFmEMvwA2g9ml
	 nzGZQXpmkwCKp59P+qTUoYzGORHjxqMnnJsIZ/o0+R2A9XGul4t8JCG5gw0q+s8Zz+
	 6sY85TfA+g47A==
Date: Thu, 3 Jul 2025 08:39:54 +0200
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
	Drew Fustini <fustini@kernel.org>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 1/8] pwm: Expose PWM_WFHWSIZE in public header
Message-ID: <3zjmaymc3igas3727ztzcz4d3znzvlfz7imutbxyg7msunxgia@vjbi6w6ltpdk>
References: <20250702-rust-next-pwm-working-fan-for-sending-v7-0-67ef39ff1d29@samsung.com>
 <CGME20250702134955eucas1p2ca553f63f44c63a56ba0b2c605edd097@eucas1p2.samsung.com>
 <20250702-rust-next-pwm-working-fan-for-sending-v7-1-67ef39ff1d29@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4cwjgneerhc2aidc"
Content-Disposition: inline
In-Reply-To: <20250702-rust-next-pwm-working-fan-for-sending-v7-1-67ef39ff1d29@samsung.com>


--4cwjgneerhc2aidc
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v7 1/8] pwm: Expose PWM_WFHWSIZE in public header
MIME-Version: 1.0

Hello,

On Wed, Jul 02, 2025 at 03:45:29PM +0200, Michal Wilczynski wrote:
> The WFHWSIZE constant defines the maximum size for the hardware-specific
> waveform representation buffer. It is currently local to
> drivers/pwm/core.c, which makes it inaccessible to external tools like
> bindgen.
>=20
> Move the constant to include/linux/pwm.h to make it part of the public
> API. As part of this change, rename it to PWM_WFHWSIZE to follow
> standard kernel conventions for namespacing macros in public headers.
>=20
> This allows bindgen to automatically generate a corresponding constant
> for the Rust PWM abstractions, ensuring the value remains synchronized
> between the C core and Rust code and preventing future maintenance
> issues.
>=20
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>

I applied this patch to

https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next

=2E I'll send it to go into 6.17-rc1.

Best regards
Uwe

--4cwjgneerhc2aidc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhmJbcACgkQj4D7WH0S
/k6vIgf/VFdOtcN1pAHYA6D+CVT6lbWvBSe+1+kT38EEWMDE1b7EujnCp8iKiNPR
lB49p+x/4539DvpYU66nlHfKs3MhDV6ak40iRqDoKII3TweO7mB5pUPuYrpvgMdO
GRf1LrvM0MCyu3MAdjqpVrS+1WJ+ZAbhMI+ZylcoVgsQJak+JbyxVsQiTwpRPA/z
024vC662vG77U0fdP5vrHMd+ukrZU3dEbrLmzzDIlF1IPTqox3KZj2NkmZ6h/I+Y
XS/ehi8GRA6gkF1fzaRX2UJeHLKL9LwKZzyeSswqccDp4LbmVbYw0ADFGa/EIB6I
VIr96Ebgndy9FmRm63jGrzyLut6ObQ==
=8UCx
-----END PGP SIGNATURE-----

--4cwjgneerhc2aidc--

