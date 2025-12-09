Return-Path: <linux-pwm+bounces-7788-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0E8CAFEA1
	for <lists+linux-pwm@lfdr.de>; Tue, 09 Dec 2025 13:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 120153016B9B
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Dec 2025 12:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0FA2FD7BE;
	Tue,  9 Dec 2025 12:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="mFig9Mjb"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9994E22B5A3
	for <linux-pwm@vger.kernel.org>; Tue,  9 Dec 2025 12:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765283207; cv=none; b=CEJl0LHweHNOjUg/9fv7eF8Hb1XhojHK0MpfG75MblpDJJf8LSmcUMh/9CePc1sNIKnsPGGgKeh0/5dFQW/xge9fPA4L0MIRGYAfg50lmnYllEaWg4JLbF+2FmxbnuZu0fVWDTgm+eCf3BTouLFqPcCeCDh9Mh1nCLvMoNDeCXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765283207; c=relaxed/simple;
	bh=Avks0IjssYfrtER/TrW3bZ+L1Cr3foVjqX35DDW3+N8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aJURk/zRGYtJu8JCiikzMNX/7VKGi9QczR8Xq4djmDDQONkJb0UzVkYFnIUw7d8FHdhSEA9O371eiZRNBSWWIrGML9wNeX1LcVPMhfU2fC/F98hZr+ZIi1Sm868+T9G5ntPQuw/2NsppJOdLsxdv2E3VlkhoctLNPY/ocWzVMTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=mFig9Mjb; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id DDE21240103
	for <linux-pwm@vger.kernel.org>; Tue,  9 Dec 2025 13:26:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1765283196; bh=6kRQgAvNv1wCmszLH8/EHGjD0iO0c93xPFEurhW0eac=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=mFig9MjbVH1gkwFFSb7FQQRF5DNZhAO7Lj4Qs5ryln1YLO7QcAv66+PNElpe3VWqd
	 lw4hASgG8M/Ty3iGUOOQbiqGwZ3ceB+boQ8CLYWeaF8NLhrdOi3Y8w3VmNuaAfSj4O
	 IYd3EJnFCfBA+e3yGHmLbCs5ft9Wg7vt+ZdNmKR7Gi+MTrw8sLHEmmT7lOmEQg1fXp
	 0IjPzhRwNx6AwkgM7v06FrL4P577goyXxf/H2z390DxWN2R2bjZU1CO5wskd/XURc7
	 EMfY7B5iWcZn7S7uZBwGyftV7RQz9O5rYRZunj3oD8O8T8iDQYK8KnGI6kAZmFXJPj
	 Hg9bed6NfQZ2Q==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4dQdPj5xygz9rxB;
	Tue,  9 Dec 2025 13:26:33 +0100 (CET)
Message-ID: <a66b337528d700ae92d7940a04c59206e06a8495.camel@posteo.de>
Subject: Re: [PATCH v2] rust: pwm: Add UnregisteredChip wrapper around Chip
From: Markus Probst <markus.probst@posteo.de>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>, Michal
 Wilczynski <m.wilczynski@samsung.com>
Cc: linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, Drew Fustini	
 <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei
 <wefu@redhat.com>,  Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
 <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,  Gary Guo
 <gary@garyguo.net>, =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
Date: Tue, 09 Dec 2025 12:26:36 +0000
In-Reply-To: <zdwto7ahccckl2r3qoculu52lsus3dey2lcur2l3ltrxp5nrcf@djusgl5cdfu3>
References: 
	<CGME20251202181800eucas1p18be878cb74d14444f2df8bdcd7a718ee@eucas1p1.samsung.com>
	 <20251202-pwm_safe_register-v2-1-7a2e0d1e287f@posteo.de>
	 <a3f4e795-e56d-4de0-8b46-5c8ff96d5f77@samsung.com>
	 <zdwto7ahccckl2r3qoculu52lsus3dey2lcur2l3ltrxp5nrcf@djusgl5cdfu3>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 66sLA9g==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-lFLVTFC6qwbla7dI63F6"
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-lFLVTFC6qwbla7dI63F6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2025-12-09 at 09:08 +0100, Uwe Kleine-K=C3=B6nig wrote:
> On Sun, Dec 07, 2025 at 11:16:59PM +0100, Michal Wilczynski wrote:
> > On 12/2/25 19:17, Markus Probst wrote:
> > > The `pwm::Registration::register` function provides no guarantee that=
 the
> > > function isn't called twice with the same pwm chip, which is consider=
ed
> > > unsafe.
> > >=20
> > > Add `pwm::UnregisteredChip` as wrapper around `pwm::Chip`.
> > > Implement `pwm::UnregisteredChip::register` for the registration. Thi=
s
> > > function takes ownership of `pwm::UnregisteredChip` and therefore
> > > guarantees that the registration can't be called twice on the same pw=
m
> > > chip.
> > >=20
> > > Signed-off-by: Markus Probst <markus.probst@posteo.de>
> > > ---
> > > This patch provides the additional guarantee that the pwm chip doesn'=
t
> > > get registered twice.
> > >=20
> > > The following changes were made:
> > > - change the visibility of `pwm::Registration` to private
> > > - remove the `pwm::Registration::register` function
> > > - add `pwm::UnregisteredChip` - a wrapper around `pwm::Chip`
> > > - return `pwm::UnregisteredChip` in `pwm::Chip::new`
> > > - add `pwm::UnregisteredChip::register` for registering the pwm chip
> > >   once
> > > - add Send + Sync bounds to `PwmOps`
> > >=20
> > > Note that I wasn't able to test this patch, due to the lack of hardwa=
re.
> > >=20
> > > Also I was not able to successfully compile drivers/pwm/pwm_th1520.rs=
,
> > > as `clk::Clk` seems to be missing. I haven't found the missing patch
> > > in linux-next nor in
> > >=20
> > > https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git/lo=
g/?h=3Dpwm/for-next
> > >=20
> > > (the tree in which the th1520 pwm driver was merged).
> > > So please verify yourself that the driver compiles and throws no erro=
rs.
>=20
> What does "not able to successfully compile drivers/pwm/pwm_th1520.rs"
> mean? You were unable to find a .config that included CONFIG_PWM_TH1520,
> or you got a compiler error? If it's the latter, ...
>=20
> > I suspect your kernel configuration is missing CONFIG_COMMON_CLK.
>=20
> ... are we missing a dependency for the driver?
I got a compiler error. Enabling CONFIG_COMMON_CLK indeed fixes it.

Without it:
  CLIPPY     drivers/pwm/pwm_th1520.o
error[E0432]: unresolved import `kernel::clk::Clk`
  --> drivers/pwm/pwm_th1520.rs:26:5
   |
26 |     clk::Clk,
   |     ^^^^^^^^ no `Clk` in `clk`

error: aborting due to 1 previous error

For more information about this error, try `rustc --explain E0432`.
make[4]: *** [scripts/Makefile.build:354: drivers/pwm/pwm_th1520.o]
Error 1
make[3]: *** [scripts/Makefile.build:556: drivers/pwm] Error 2
make[2]: *** [scripts/Makefile.build:556: drivers] Error 2
make[1]: *** [/home/markustieger/build/synology/linux-
upstream/Makefile:2010: .] Error 2
make: *** [Makefile:248: __sub-make] Error 2

A simple fix would be to add "depends on COMMON_CLK" in
drivers/pwm/Kconfig for PWM_TH1520.

Thanks
- Markus Probst

>=20
> > Thank you for your work. I've tested this patch successfully.
> > Other than the typo this looks perfect.
> >=20
> > Tested-by: Michal Wilczynski <m.wilczynski@samsung.com>
> > Acked-by: Michal Wilczynski <m.wilczynski@samsung.com>
>=20
> I applied the the patch to
>=20
> 	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/f=
or-nexxt
>=20
> as 6.20 material with Michal's tags and the typo fixed.
>=20
> Thanks
> Uwe

--=-lFLVTFC6qwbla7dI63F6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmk4FXcACgkQNHYf+Oet
Q9KBpQ/+LVKCzqtIaooI/JdA88A52s5Pp7ePykc1lsJBvvCBHqrZntXyTumfvCzS
+/71cPwVCRxSZT7t++Fhr2qSGCMlE11TiK8R8RQQJ6sh3rmT56VtVnueEl+S8xoe
OnurEJsabyY8+tGsAXFPzvFXx15LZJiehPSOVs6VYQQBG7803uALxwFZczqgMKBZ
PWfqevTrUbFroijfLm5lJR8vnB6cLQ/Mbewk/9HXzvJhReDb59edSNV1IHB0ifO4
5FcZeV9dAG2fE04Q+ZkkcyOSopRsbb1hrwIygBFmQqqSiE99f+Ucz0kqFfYqK2z8
Tf++yrEcv0+JQxzX3AwzfUyjmU7m3b01XVywoD1UyHt2pQZTT8z3uFx14KLBBQnC
l9aXe6evwWWzAAjOHRlB+kYt5eNab7Jj/AN6eclR6FFhB6MoYSEBTguQZ2qfPPkZ
gEX2z/RCj9fEWweLYsq8b7EjS0k/selOkCdQ4oUEJdap/EfHYg2kcXBrTgC4229N
R/1mb+U3+5zgFTebKknIIlXwjFTiCXIdnyyHm2ECLcvA8kncfkLlJWqDXUmorVaI
WDvLKvQVUhYq6m8sz/cDGZYbsHnIvUW+HHKVAuM3iN0alGT5rKsVvvRP3g+jcaEV
iCugeIIEoG/7s7LNvE58HHt7pDMktrkNPmplttoz2aoOdpym/W0=
=cGwT
-----END PGP SIGNATURE-----

--=-lFLVTFC6qwbla7dI63F6--

