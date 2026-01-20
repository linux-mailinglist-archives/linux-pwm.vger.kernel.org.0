Return-Path: <linux-pwm+bounces-7958-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 75135D3C27B
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Jan 2026 09:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CE899646E82
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Jan 2026 08:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5976C3559CA;
	Tue, 20 Jan 2026 08:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PliWaud5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2332E2EB5AF;
	Tue, 20 Jan 2026 08:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768898356; cv=none; b=M+AtgYtpA5Yn/hAv1viVdBaw6f12TRVnN6oV2vevUc4CEOWO7pAKlzFaK6fdvTkRKYFzgHxlVFUTwe0KNgBJpUsVLu7HKTnwqYoOKfTTzCUdDFlR+LQFfUXXJkviD0nTOsMjebupsCGctovxn0Pc4B+AMmGYDigmJ/3fD5AAMHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768898356; c=relaxed/simple;
	bh=4BsRuPSOnjDi5faQkQXbt5AD6hpnYNqK4kLb4+PdhXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJ94vl8alF2LLzaqSjCg3qpPklU1dP0hfVLHdNyCDw6c6nga80rn2zpxLMdHCclCjqai1/B8s2HsDrsYz71jFWGOPFlgIH7Fec/vU4OfgrsSiDATItMkXhPR5tpii17VB07YsMDg9t2iXKcDnaJ8ctMArXMhOWmOEURs2bjDydg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PliWaud5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B8EC16AAE;
	Tue, 20 Jan 2026 08:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768898355;
	bh=4BsRuPSOnjDi5faQkQXbt5AD6hpnYNqK4kLb4+PdhXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PliWaud5nG5JDjIa2ujDTKQkmmSdPKaDi2LsIIIrUEef+84M0282Vj1Pqoc4BRb5E
	 RvewXuQMlaJywVGAMjuRxDzwm3Whcg3i/tFt/NhPm+2Pxg3Ug1l+sA5GWLDaSEDmpL
	 r0JqA9hRctC4IKP5Df8Sw8ZXpkooQBLGnbBRa8oQ/c+xeZov/eHliLxFPGHoaIFFQE
	 3auUCdqtxvNF7aZW1OUwHi6EW/ShYTHpQTzOd7gLbVjWH/tbBHAA5UwLCpjZyjmTJ9
	 ePv2Y3b/fH4CN3zMt/dlFO7g6R/4KQbV8V14tFrVWqD5d4b8hBB6fv+snRv2RzfJAY
	 MxODOH0pm2BuQ==
Date: Tue, 20 Jan 2026 09:39:12 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Tamir Duberstein <tamird@kernel.org>
Cc: Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Fu Wei <wefu@redhat.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Tamir Duberstein <tamird@gmail.com>, 
	Michal Wilczynski <m.wilczynski@samsung.com>
Subject: Re: [PATCH] drivers: pwm: replace `kernel::c_str!` with C-Strings
Message-ID: <o4uvwymm73wnehs5zb7lqgv3mjv235jpprfqrsb6oxscxhmmjh@25u7wrb7yo2i>
References: <20251222-cstr-pwm-v1-1-e8916d976f8d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ed7x3rrm3oecwey2"
Content-Disposition: inline
In-Reply-To: <20251222-cstr-pwm-v1-1-e8916d976f8d@gmail.com>


--ed7x3rrm3oecwey2
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drivers: pwm: replace `kernel::c_str!` with C-Strings
MIME-Version: 1.0

Hello,

On Mon, Dec 22, 2025 at 01:24:46PM +0100, Tamir Duberstein wrote:
> From: Tamir Duberstein <tamird@gmail.com>
>=20
> C-String literals were added in Rust 1.77. Replace instances of
> `kernel::c_str!` with C-String literals where possible.
>=20
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Applied to

	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for=
-next

as merge window material with the R-b tags by Michal Wilczynski and
Daniel Almeida.

(Side note, b4 told me:

	  =E2=9C=97 No key: openssh/tamird@gmail.com

=2E It's not clear to me how to verify this signature. My experiments
include:

	$ b4 kr --show-keys 20251222-cstr-pwm-v1-1-e8916d976f8d@gmail.com
	---
	No keys found in the thread.

and looking at
https://lore.kernel.org/linux-pwm/20251222-cstr-pwm-v1-1-e8916d976f8d@gmail=
=2Ecom/raw
where I see

	X-Developer-Key: i=3Dtamird@gmail.com; a=3Dopenssh; fpr=3DSHA256:264rPmnnr=
b+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

which IIUC isn't enough to verify the next mail signed with the same
key. Am I missing something? I very appreciate signing your work, but if
there is no way for me (or anyone else) to verify it, there is no gain.)

Thanks
Uwe

--ed7x3rrm3oecwey2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmlvPy4ACgkQj4D7WH0S
/k4GUwf/cN2KMOHwQlXBx5q3HyGl20R3D0ZA5lcodFAP7JPSuZLpaUAMcWqtI2Um
+RQ7fBlZd3QOmA8yJrJEo5cIY6BKELFVn3kmg1COT7FxfuVnNCCn7jMD946ods/m
JLBlWWGDyvxDJeTQD+qvRrV0Y/VrRTrfUCRv88S/TUgpUAojzQ23KpeXjlL/HWCg
j6KhzEPjIxCK/6CrfDD1Yp1KY4OiYofzRvIUbn6MPX4aomj0OYtltKs/8U/+2kxh
ijbc25GyCDCG6No+T8Q7qy+u5InV3Y1SIX9hIlkfQCdp8lKdwesS6AMPd4NFSjH7
qb3ni9RcUxP2B++oySqxJD96lrlyHg==
=w+Dz
-----END PGP SIGNATURE-----

--ed7x3rrm3oecwey2--

