Return-Path: <linux-pwm+bounces-5979-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8286AB6611
	for <lists+linux-pwm@lfdr.de>; Wed, 14 May 2025 10:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DA421660F2
	for <lists+linux-pwm@lfdr.de>; Wed, 14 May 2025 08:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD871CAA96;
	Wed, 14 May 2025 08:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9py4S/y"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC55C27454;
	Wed, 14 May 2025 08:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747211672; cv=none; b=TmrAVB+JtPL36JQXBVJZtA7tX7+1X4LNbUD6e/kTmVVfIseH8YvTqg5OL28vGz7svJcHjw3xW/s8AROPXQZpNZtbcCGJCwmBxcolQK538jEdKIGXdKtWXyhPQMMYtOdokhAvhqqFJtzhT6jKrPItM76WAM2ig33BPDLUrvIh/1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747211672; c=relaxed/simple;
	bh=c3xpjCIOkf2tBkLkY9p/RGP7oLM1K/AjF448pwRTLlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r9KegvF0kwGPFHyHBkdnA8CLl1xYGn2Cw5aX8ZtqeWPc8D+H6mVXGcjuuxAECYrYXO6d1ploQBiRMuaIl/2IL+CuFggWdWpxP00qI3pqs82BgJPzZy0hznmteQEuWm0HFDnmS0PwMsTSW6v1nkCaYc5km6irRifFC2VmSOb2h/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9py4S/y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F07F9C4CEEB;
	Wed, 14 May 2025 08:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747211671;
	bh=c3xpjCIOkf2tBkLkY9p/RGP7oLM1K/AjF448pwRTLlE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d9py4S/ynySIQhb9heuxxcfUFqv8XKXVS3PYNbSw18T/bdwRrZBCmlXpNftUD716U
	 AFVCJjnf+/4BKV9TkCkqI6Ds9D0YbwT2fVRi5fDoei1bXJ/lHjij9ycQYyLQtd2CdI
	 55q1U2uLU31NNqS3AG2qLKR30En8Wix/s9PFghhsRfCgLVS6VjSlWyzwHwG7jFGI/w
	 BpYqz+rsz1OR/u6BicH9l2bY6fk/7SHlcM8FCZgIbxM0GcvdiwtfECOHKSpnRCpGet
	 Y9u6lp0b71S7TivgYd6JsdJS6xbDdxTezxUX50qsF8X0tzvoFHFfwW09wNtrIDpjR5
	 hMOC3/ag8AvwA==
Date: Wed, 14 May 2025 10:34:28 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Russell King <linux@armlinux.org.uk>, 
	Will Deacon <will@kernel.org>, linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v4] pwm: tidyup PWM menu for Renesas
Message-ID: <wytdfpewvcesc6racyrpa4cya7wku6dc65edz7oma7penqrqqq@2g54gyprttxt>
References: <877c2mxrrr.wl-kuninori.morimoto.gx@renesas.com>
 <62gkja5ysv47yos2hcurluudxwvl54uv4ih7pjnmnjrzuik6cs@a5oxhyyy6vsm>
 <CAMuHMdUvR8rp2PaFLsyQ6ZWLqw7OskP-ZwVjRC=AARhK8g-iYQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5ztqzgxq5aru3j5q"
Content-Disposition: inline
In-Reply-To: <CAMuHMdUvR8rp2PaFLsyQ6ZWLqw7OskP-ZwVjRC=AARhK8g-iYQ@mail.gmail.com>


--5ztqzgxq5aru3j5q
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4] pwm: tidyup PWM menu for Renesas
MIME-Version: 1.0

Hello,

On Wed, May 14, 2025 at 08:56:01AM +0200, Geert Uytterhoeven wrote:
> On Tue, 13 May 2025 at 22:19, "Uwe Kleine-K=F6nig" <ukleinek@kernel.org> =
wrote:
> > The obvious options are (in order of my preference):
> >
> >  - Geert declares his renesas-arm-defconfig-for-v6.16 to be stable and I
> >    merge it into my tree and then apply the patch
> >  - I cherry pick 5ad7de623853 in my pwm tree and Geert drops it
> >  - I delay applying the patch until after v6.16-rc1
> >
> > Geert: What is your preference? Let's discuss on irc?
>=20
> My tag renesas-arm-defconfig-for-v6.16-tag2 is stable, as that is
> already merged in the soc tree.
>=20
> However, renaming config symbols always comes with its own set of
> pains: users must notice and adapt when updating their own configs,
> and I do have to manage the non-upstream renesas_defconfig, too.
> What about dropping the rename part? The symbols that currently lack
> a RENESAS-prefix do have fairly unique family prefixes.
>=20
> Morimoto-san: Would that still be OK for you?

I agreed with Geert off-list that merging
renesas-arm-defconfig-for-v6.16-tag2 into the pwm tree and apply the
patch is fine for him.

That's what I did now.

Thanks
Uwe

--5ztqzgxq5aru3j5q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmgkVZEACgkQj4D7WH0S
/k7GpAgAurjzLOUMWO01RfR1EW2lJxEoK8uqt9BAj1w2atKbdVGaedvNZGA/6lT3
yLiaOwPYYqM1Yif1xt9hfLaksUX67lDUNFfqMAC4y+OZsq22p+MxunPr/IjQvA5w
pUX0KNdQlgPQ7ffrq9iCqRbmVYw1Kux+m+IAj6a4HeVQ25diW2BQbx6M97eBZZ1h
gHc+VVMYBoheJ8W3fAswUN/z4/6Gw3ij9+aA8zoWuDyX5A8CEfGFEHJLnPms/IWy
pOKhD6TAEo1SV4XHr6gqxkKUtvP2/x8VdtcK9NwUoHF7FAFM7JkZPl1YQXQlPF+d
E6T+UgqxbkYYJ8OjLhvF+Z1nIYuuIA==
=tAzU
-----END PGP SIGNATURE-----

--5ztqzgxq5aru3j5q--

