Return-Path: <linux-pwm+bounces-7945-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9BCD3B325
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Jan 2026 18:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1528E306CFCD
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Jan 2026 16:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3670288CA6;
	Mon, 19 Jan 2026 16:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/GHQ5rk"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80823205E26;
	Mon, 19 Jan 2026 16:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768841591; cv=none; b=nCorjy9a474fvz3VpnL6U6/mgQdFFWRUkVlgVtO8CSqU22p2OLy1RfEYpOvY10CioQ8wmmJvir/mdoI3iY+PluhXUCkIhZkw1xpPAp44Ab7Fr0H02a+o8XUs5k06id5beTU1GwI6RJeQzLMNXV11VLlz61O4HCef3UE2CMepdOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768841591; c=relaxed/simple;
	bh=2ZkOa9bEBe+GCTApBrgpJ3K+Kz14rXJVbtoTGmBF0vU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XC3WA4vv2WLptEYzM1hxUuAZrXcIibDVycW0hKWo18WDpTMDGkSqxOwVElkmV3XPmTJYZU9ZQZhBkMnjCoG49krmGc2FDn+18tZiCuZ0f/IjFT/6MlIm7zluwbxdSM+ydcUbglU8Sj0RpLwZoC71TnbE9cECQx6BdMmDEGzC6DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/GHQ5rk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9109AC116C6;
	Mon, 19 Jan 2026 16:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768841591;
	bh=2ZkOa9bEBe+GCTApBrgpJ3K+Kz14rXJVbtoTGmBF0vU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R/GHQ5rkIxsHBLAflksNjI8LN/ZvzHFyetNHZkl2nzSxe/2OF79xF4IZJ1hOB3SDI
	 4j8i4Vd4j5D2t2q9CSqe86TgnRTYCaF8aKGrZvhno013ettWe4k2MbodN0XfZWpgMU
	 zKPyAThfTCOfgFKa0cUdPNxL/OHTukriZV4KoCiLWtAbGWy4XVeBaFSR8y5zxwR2gD
	 e6K+LDX/KhQ96uQbdVMRUGk4ee8BulbxRbhVnrmgQ5WgauYmOneDxEdt3qoW3k2qYP
	 JFs01WPCc7fOhHNrUPh4EEPQyJdP1T3iMUE6bLU5+/niaRk6LYBi7oiZ93Z0EcFW3q
	 FFxNMJqIhA4jg==
Date: Mon, 19 Jan 2026 17:53:08 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Fu Wei <wefu@redhat.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Michal Wilczynski <m.wilczynski@samsung.com>
Subject: Re: [PATCH] drivers: pwm: replace `kernel::c_str!` with C-Strings
Message-ID: <2wmijhs5pbrynsgxuropvlxuozsubk7euybxzwc5ox2a3izfci@v6hzmzs5pmml>
References: <20251222-cstr-pwm-v1-1-e8916d976f8d@gmail.com>
 <CAJ-ks9mrpcLaeiGjBcXNqTUwo00Y2MhhHWnWauou6exU1y920Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ag6ssgt3jtvb55cw"
Content-Disposition: inline
In-Reply-To: <CAJ-ks9mrpcLaeiGjBcXNqTUwo00Y2MhhHWnWauou6exU1y920Q@mail.gmail.com>


--ag6ssgt3jtvb55cw
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drivers: pwm: replace `kernel::c_str!` with C-Strings
MIME-Version: 1.0

Hello,

On Sat, Jan 03, 2026 at 09:30:31PM -0500, Tamir Duberstein wrote:
> On Mon, Dec 22, 2025 at 7:24=E2=80=AFAM Tamir Duberstein <tamird@kernel.o=
rg> wrote:
> >
> > From: Tamir Duberstein <tamird@gmail.com>
> >
> > C-String literals were added in Rust 1.77. Replace instances of
> > `kernel::c_str!` with C-String literals where possible.
> >
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > ---
> >  drivers/pwm/pwm_th1520.rs | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
> > index e3b7e77356fc..8ae8f852ec02 100644
> > --- a/drivers/pwm/pwm_th1520.rs
> > +++ b/drivers/pwm/pwm_th1520.rs
> > @@ -22,7 +22,6 @@
> >
> >  use core::ops::Deref;
> >  use kernel::{
> > -    c_str,
> >      clk::Clk,
> >      device::{Bound, Core, Device},
> >      devres,
> > @@ -327,7 +326,7 @@ fn drop(self: Pin<&mut Self>) {
> >      OF_TABLE,
> >      MODULE_OF_TABLE,
> >      <Th1520PwmPlatformDriver as platform::Driver>::IdInfo,
> > -    [(of::DeviceId::new(c_str!("thead,th1520-pwm")), ())]
> > +    [(of::DeviceId::new(c"thead,th1520-pwm"), ())]
> >  );
> >
> >  impl platform::Driver for Th1520PwmPlatformDriver {
> >
> > ---
> > base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> > change-id: 20251222-cstr-pwm-c9b9a4701157
> >
> > Best regards,
> > --
> > Tamir Duberstein <tamird@gmail.com>
> >
>=20
> @Uwe could you please have a look?

I did, but given I'm more or less rust illiterate I would welcome
feedback by Michal Wilczynski. I only now notice that he wasn't on Cc:
up to now.

Best regards
Uwe

--ag6ssgt3jtvb55cw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmluYXIACgkQj4D7WH0S
/k60Vwf+L9+sMF3DsYlxCUroWbaKU2YlEkePawJRhurmC6+MZsBE1EX/+eToCGGy
tqkb4TmjhbSrQdgbZXoyxMXV9XguGzCq7aq0lZ7gI556Zc9iOll2EIJVUKCqjQ7z
CklQ6HQMGB3X9oSXWuIUvfMkVgDej3YRVUIBlQ9WJVzuqoLOTMNYO5ymu0X1ll+Q
mSHDQ9p4fDB7Ef8uIq41Zk+DldPQ+nBSY9TciePw1aApJg4DXmpaOwrBARbXzQdF
8xBi1lN75cvNOvu5HEGYNNMP6QtiwLU5NuA/5SCMJsxl0eP1rXs8Yyg5XLxP8wU/
jKWyRx8IwYFLbkQHfw48pJB/6nGUdw==
=3gtg
-----END PGP SIGNATURE-----

--ag6ssgt3jtvb55cw--

