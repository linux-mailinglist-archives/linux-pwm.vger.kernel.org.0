Return-Path: <linux-pwm+bounces-7786-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E167CAF3EF
	for <lists+linux-pwm@lfdr.de>; Tue, 09 Dec 2025 09:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E7A93011A40
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Dec 2025 08:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476C926CE32;
	Tue,  9 Dec 2025 08:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jd3rxWb/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3F88F4A;
	Tue,  9 Dec 2025 08:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765267721; cv=none; b=eO0MCo0rCQSB7iGB5vjywKsT2H8rAdxXs786RqQish04yd7qAeoWxjhc9a3VqHuz3bDkYmrgfLFWXHSv95xh7Z4dj/t8OKcrTUoBC57ooVG8yZIybWhbJ5hKnXlcrPo5NZgf4dTz6XvDeoy3zjGzvNvFRabhmJT5e9rQM6HzjCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765267721; c=relaxed/simple;
	bh=RtLlcpTfLz2USeJH4EgZ5Bfw+5bkPGymDSn32qHKB5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZH6rnyWgTJadTn/ZGwCDQytiKH6aIppSHZy+9GkZRiqY7WGjKwCCCNRoF3limfB8W7ooNzk+kyTf3+8Uyy4KQQCHuNjPkprmTCUNCUdHtkjR+KXISodGMBAbs3OrUjiRay0K7ncHKo7T4BruPo0woYmHCqsBRlyG5joNAI+J/sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jd3rxWb/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0824C4CEF5;
	Tue,  9 Dec 2025 08:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765267720;
	bh=RtLlcpTfLz2USeJH4EgZ5Bfw+5bkPGymDSn32qHKB5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jd3rxWb/To5DpiKkKBBr2Zs3L2K8wvokog/m9FqvtGHziX/K1HppotDOO9+LU85gX
	 G9UmQlfDAnaVUGVvNAvNgXXuQx0B5h4g4mx88v2qZN1UgddX4KaIDkyUyR08nehqzY
	 DG0H9bRj2a0sYmnHMsCAb3R9wP2F3oTes9RWOLAYuRudGD/MeGxoeVteTLhnH4WUbs
	 tq3+v250cHhl+1AApeR2QllCZFFJXN2+hCHgA0q9+Bw2BMC3xIIvmq9MPmryBTttKy
	 pb0viuh5GF4RK8jRYG6NA7DcxJamvUG11dgvj9bwPMAGETZc1YTMZwrfsJR01KUyua
	 B1CbHPf00fYPA==
Date: Tue, 9 Dec 2025 09:08:37 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Markus Probst <markus.probst@posteo.de>, 
	linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Fu Wei <wefu@redhat.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v2] rust: pwm: Add UnregisteredChip wrapper around Chip
Message-ID: <zdwto7ahccckl2r3qoculu52lsus3dey2lcur2l3ltrxp5nrcf@djusgl5cdfu3>
References: <CGME20251202181800eucas1p18be878cb74d14444f2df8bdcd7a718ee@eucas1p1.samsung.com>
 <20251202-pwm_safe_register-v2-1-7a2e0d1e287f@posteo.de>
 <a3f4e795-e56d-4de0-8b46-5c8ff96d5f77@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s4iw3gf4t2dpvedc"
Content-Disposition: inline
In-Reply-To: <a3f4e795-e56d-4de0-8b46-5c8ff96d5f77@samsung.com>


--s4iw3gf4t2dpvedc
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] rust: pwm: Add UnregisteredChip wrapper around Chip
MIME-Version: 1.0

On Sun, Dec 07, 2025 at 11:16:59PM +0100, Michal Wilczynski wrote:
> On 12/2/25 19:17, Markus Probst wrote:
> > The `pwm::Registration::register` function provides no guarantee that t=
he
> > function isn't called twice with the same pwm chip, which is considered
> > unsafe.
> >=20
> > Add `pwm::UnregisteredChip` as wrapper around `pwm::Chip`.
> > Implement `pwm::UnregisteredChip::register` for the registration. This
> > function takes ownership of `pwm::UnregisteredChip` and therefore
> > guarantees that the registration can't be called twice on the same pwm
> > chip.
> >=20
> > Signed-off-by: Markus Probst <markus.probst@posteo.de>
> > ---
> > This patch provides the additional guarantee that the pwm chip doesn't
> > get registered twice.
> >=20
> > The following changes were made:
> > - change the visibility of `pwm::Registration` to private
> > - remove the `pwm::Registration::register` function
> > - add `pwm::UnregisteredChip` - a wrapper around `pwm::Chip`
> > - return `pwm::UnregisteredChip` in `pwm::Chip::new`
> > - add `pwm::UnregisteredChip::register` for registering the pwm chip
> >   once
> > - add Send + Sync bounds to `PwmOps`
> >=20
> > Note that I wasn't able to test this patch, due to the lack of hardware.
> >=20
> > Also I was not able to successfully compile drivers/pwm/pwm_th1520.rs,
> > as `clk::Clk` seems to be missing. I haven't found the missing patch
> > in linux-next nor in
> >=20
> > https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git/log/=
?h=3Dpwm/for-next
> >=20
> > (the tree in which the th1520 pwm driver was merged).
> > So please verify yourself that the driver compiles and throws no errors.

What does "not able to successfully compile drivers/pwm/pwm_th1520.rs"
mean? You were unable to find a .config that included CONFIG_PWM_TH1520,
or you got a compiler error? If it's the latter, ...

> I suspect your kernel configuration is missing CONFIG_COMMON_CLK.

=2E.. are we missing a dependency for the driver?

> Thank you for your work. I've tested this patch successfully.
> Other than the typo this looks perfect.
>=20
> Tested-by: Michal Wilczynski <m.wilczynski@samsung.com>
> Acked-by: Michal Wilczynski <m.wilczynski@samsung.com>

I applied the the patch to

	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for=
-nexxt

as 6.20 material with Michal's tags and the typo fixed.

Thanks
Uwe

--s4iw3gf4t2dpvedc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmk32QIACgkQj4D7WH0S
/k6nAgf/QrIW2SOzj5VyC7JWffgkMmIgcpXgz5LJAJH69mlroGtDRaNWm6PiGF2+
KmyupX1UWeA+MQnNUyN5q5QafwNI8SpPAyJhQ/RXv5tpYeI25gsTeJg6xRw9STDR
nuaU9VnNRv26IS507511zdmWBGdWtjiup6QzogHlJIBbBe1plzW2nmg4p9jXU66A
8VbobpUWltvz8n7xlaycHOK4tkaPR7DLqiOATWxfBOyipfCbAPsUEjF0M9N8m1W0
As2+iCPEQ3QmnNFIAKr7wdkPDC9V58TStvl72F6yYF3kl0COfihZu3fIsAaPPkiI
ER2GAeFD3+56UAXKGQgYEyB+zuhNDg==
=+IKm
-----END PGP SIGNATURE-----

--s4iw3gf4t2dpvedc--

