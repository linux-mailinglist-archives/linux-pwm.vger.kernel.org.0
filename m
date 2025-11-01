Return-Path: <linux-pwm+bounces-7577-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6261AC2795A
	for <lists+linux-pwm@lfdr.de>; Sat, 01 Nov 2025 09:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B08F54E22D1
	for <lists+linux-pwm@lfdr.de>; Sat,  1 Nov 2025 08:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD8225C822;
	Sat,  1 Nov 2025 08:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jgX6xL9F"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503401A0BF3;
	Sat,  1 Nov 2025 08:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761984423; cv=none; b=nSx7RJXIRJ15l9dhtZlXV5ysAmfnTk5wl8S3hNHCHycOctfVRxDFlg2een0JSdIMpzKK3051eaPmumkwImxtt0PGGtXWRiM0RViblgJMtYgIhaoE42abCVKkOaYKRM3YPylH1DF9kYQgDBB8x4kMfZT8mE13B+/u7uCCYJqc1r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761984423; c=relaxed/simple;
	bh=G/Jcr2WP/cPGUf9Bk+5VxA0ZTOL+7p5/wefrl26pvuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PpF6nzoeGMsXNQlOzpD8j45WoKqsWacS9HeXbKyg31+U7QPxALNUXOjg4oRuPSNyIBDZdh9riRatpkYl9OqynuHprpc5u4+M5MD1SVzrF5DvII+ADLa6W5+TBO6aMOg48mmBq5NLOliq56NYbzTxp/nB9WUc//TLOQMw/CrDd/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jgX6xL9F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3791FC4CEF1;
	Sat,  1 Nov 2025 08:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761984422;
	bh=G/Jcr2WP/cPGUf9Bk+5VxA0ZTOL+7p5/wefrl26pvuU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jgX6xL9FRABC9/zPye3aZ3S733GzdIqPWf2fgzW3yjKoE9aXXAERGZFbjTszexFf+
	 70ZpoqX7K9DWoCgD5fvJajvx6Iewm9liRnLS2QIB35aP5lRunwDZms9dMC4RNbfwvr
	 532Q1dkMl+/MOQskQCNaQyRPK5r10pPS2z3IJo74ulRB8s1ZPrZETsFG+HRkIJgIw2
	 DGk80xJMhqRBEHs7tf8vchk22i2xHiv8aDYwdLodCL9zNjx/s2jPRGQCLv7JgSub12
	 nkYSeR8OdaQ/ZCmlv/7Y8yFRScetZrds90yLTeYsJKRR5kaXOwcsEezeWEkFfETbN+
	 ObwH9QzHipeCg==
Date: Sat, 1 Nov 2025 09:06:59 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Daniel Gomez <da.gomez@kernel.org>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Michal Wilczynski <m.wilczynski@samsung.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org, linux-modules@vger.kernel.org
Subject: Re: [PATCH 1/4] rust: macros: Add support for 'imports_ns' to module!
Message-ID: <ltzoyvyzmyf6ltdpolovjlsd44uuswkrbtlakzps376ohc23wn@mgqnvgv77tez>
References: <20251028-pwm_fixes-v1-0-25a532d31998@samsung.com>
 <CGME20251028122316eucas1p2733987cd4c1eb8f83d6572d542e76d2a@eucas1p2.samsung.com>
 <20251028-pwm_fixes-v1-1-25a532d31998@samsung.com>
 <h3sivr3uuzr5oodqe326svchbw3rzo4f4nw4chpeee2jwzjq3j@bdtecauehkn4>
 <CANiq72nNxVJeMZdESrrB+LGmdRK+M5AGZbUw-x2aE-Qa-=HtJQ@mail.gmail.com>
 <4654398f-324c-4465-88eb-8cadde6160dc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="usbfmskd44ovktpd"
Content-Disposition: inline
In-Reply-To: <4654398f-324c-4465-88eb-8cadde6160dc@kernel.org>


--usbfmskd44ovktpd
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/4] rust: macros: Add support for 'imports_ns' to module!
MIME-Version: 1.0

Hello Daniel, hello Miguel,

On Fri, Oct 31, 2025 at 02:12:29PM +0100, Daniel Gomez wrote:
> On 31/10/2025 13.57, Miguel Ojeda wrote:
> > On Fri, Oct 31, 2025 at 8:47=E2=80=AFAM Uwe Kleine-K=C3=B6nig <ukleinek=
@kernel.org> wrote:
> > > Can I have some blessing to take this patch via my pwm tree? Would you
> > > prefer a tag to also merge it into your tree? Then I would apply it on
> > > top of 6.18-rc1 and provide a tag for you to merge.
> >=20
> > Sounds fine to me, but I am Cc'ing the modules maintainers since they
> > were not, just in case:

Good idea, thanks for catching that.

> > Acked-by: Miguel Ojeda <ojeda@kernel.org>
> > [...]
>=20
> Uwe, that's okay from modules side:
>=20
> Acked-by: Daniel Gomez <da.gomez@samsung.com>

Thanks for your Acks, I applied patches #1-#3 to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next
(#4 was applied already).
=20
> FYI, I haven't merged Andreas's patches (rust: extend `module!` macro with
> integer parameter support) yet, which add rust/macros/module.rs to our
> MAINTAINERS file list. So, it's fine from modules side to go through your=
 tree.
> I was aiming to merge these patches along with some others for this week =
but
> I've found a regression in kmod testing introduced in the latest v6.18-rc=
1,
> which is taking me some extra time.

If the issues you mentioned are sorted out and you apply patches that
conflict with the changes I committed, please get in touch that we
coordinate if/how to sort them out.

Also if the need for a tag to share the commit arises, please coordinate
and don't just merge the just now created commits, as I like to be able
to rewrite my tree for late Acks etc. So I'd like to prepare and know
when commits become set in stone.

Best regards
Uwe

--usbfmskd44ovktpd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmkFv6AACgkQj4D7WH0S
/k6QQAf/ZAkDEyqE7MH4fqSdX0BKyDtZcv4Lt4GumeKupHHVRA5dkdUIGoamRHO1
odjELXXO+7Em0roeVXdjnh3W6J2FjINqP8NYvXXN2bT3WjCL2CVWh1+X0kj6Odlr
5lPowTPcu82u+fqUa758zMy55NYoeK4BEgrxSRPDamM9st2sivebaANBMKY1aSGw
NgUFvhdmYcA8eWfEE5FfNhLfcfy/mjP/ogZ5p3/l7/5MqG7bmNsWin8r0u81k06m
e081JkotlTeg9J2gAlnD61AZyn77/LP5764h5CiFYrFD18uK0ZHtfW3xqnT+jeKe
/E9CAoE8NvNtI1FpAChL2Q7++uAr6g==
=x5ke
-----END PGP SIGNATURE-----

--usbfmskd44ovktpd--

