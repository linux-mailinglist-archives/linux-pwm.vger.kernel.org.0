Return-Path: <linux-pwm+bounces-7932-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC44AD3AC1F
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Jan 2026 15:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9D1A4301934E
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Jan 2026 14:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5A437F0EA;
	Mon, 19 Jan 2026 14:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0YobgaC"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265F137C0F0;
	Mon, 19 Jan 2026 14:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768832850; cv=none; b=XNzyR0MWRfluXBjrsbGcegkWUiWzWLdkgBuo9+MxfY9ONroALUwHZzJwaWwFiPXYcE49YcRxfoS2BA3A/G+l0kp79UkgfCKAC5dB+MqXbDyJaLchB/+EjUys7ROxvcxdxom4CtI1sR4SRMea44SWRHzX/QfkWozOh1hES3UvSMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768832850; c=relaxed/simple;
	bh=gx2WRxdeeQ0ApxHAc8QAhCvgVAmIdfItFxqRTPicb30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mc7Vf1bB0fRcax9Vi3/FzCcBjcegwcVihaAK6ekrHulO7UEU3vVaNtW1Gh9QgwSlJ+I0gI3Po42v1Av0g/UQPOa3gIgEj3aK9kahCzCa13fxUs23eBxqk+F17bnhstuCKj+lWB3NDNnImbXFfsJd8kFnZNm03eNwQLWRIpN5+Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0YobgaC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A39AC19423;
	Mon, 19 Jan 2026 14:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768832849;
	bh=gx2WRxdeeQ0ApxHAc8QAhCvgVAmIdfItFxqRTPicb30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y0YobgaC/lfQHCT14JJ8zGU/UTkp4fC2ZbfrAHz5NccX4FWT9hJuf7IdnMD2gg7V1
	 i7gNPkGRiuXbYPdK9MSK5hwkZLpbBjO2XCyVTanwPvXxLCZfF0DzT7ypyT/6kJm4Mv
	 1mOMaEDqK4kN/X4C8wGP0/wwEG+ae8rEDzsA9YU+bX8sre5jLvuRRm86oOHL5fdlnA
	 PIxeaeRzD4RNwAuC2uX7UwVSKHo9WgRgTNF7eYHnUEcpbxcOI6qDw3m+ka23ylP2DD
	 InEprL9tHxMbn1Fy5Y3V4K0KeBLbVqGhhHnl9T/7TMLcIXpP+N7dXUpvX65ERVgLTB
	 5ndOywM0ujl4w==
Date: Mon, 19 Jan 2026 15:27:27 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Danilo Krummrich <dakr@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Fu Wei <wefu@redhat.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org, 
	linux-pwm@vger.kernel.org, linux-clk@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v3 1/3] rust: clk: use the type-state pattern
Message-ID: <20260119-tall-proficient-quetzal-e5e3ad@houat>
References: <20260107-clk-type-state-v3-0-77d3e3ee59c2@collabora.com>
 <20260107-clk-type-state-v3-1-77d3e3ee59c2@collabora.com>
 <20260108-delectable-fennec-of-sunshine-ffca19@houat>
 <98CD0BF6-3350-40B9-B8A9-F569AE3E3220@collabora.com>
 <20260119-thundering-tested-robin-4be817@houat>
 <aW4lCfUyumOKRRJm@google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="e4pmavt6pzvm3wrg"
Content-Disposition: inline
In-Reply-To: <aW4lCfUyumOKRRJm@google.com>


--e4pmavt6pzvm3wrg
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 1/3] rust: clk: use the type-state pattern
MIME-Version: 1.0

On Mon, Jan 19, 2026 at 12:35:21PM +0000, Alice Ryhl wrote:
> > > In fact, I specifically wanted to ensure that this was possible when =
writing
> > > these patches, as it=E2=80=99s needed by drivers. If you want to, I c=
an cover that in
> > > the examples, no worries.
> >=20
> > Yes, that would be great. I do wonder though if it wouldn't make sense
> > to turn it the other way around. It creates a fair share of boilerplate
> > for a number of drivers. Can't we keep Clk the way it is as a
> > lower-level type, and crate a ManagedClk (or whatever name you prefer)
> > that drivers can use, and would be returned by higher-level helpers, if
> > they so choose?
> >=20
> > That way, we do have the typestate API for whoever wants to, without
> > creating too much boilerplate for everybody else.
>=20
> I think that if you still want an API where you just call enable/disable
> directly on it with no protection against unbalanced calls, then that
> should be the special API. Probably called RawClk and functions marked
> unsafe. Unbalanced calls seem really dangerous and use should not be
> encouraged.

Sure, that makes sense to me.

> The current type-state based API is the least-boilerplate option for
> drivers that exist today.

I wasn't saying that we should add boilerplate to the typestate API
either. I was saying that the non-typestated API was common enough that
we probably didn't want boilerplate for it either if possible.

Maxime

--e4pmavt6pzvm3wrg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaW4/TgAKCRAnX84Zoj2+
dg10AYD4zWgs/7eRIJtlCax2uq/sdQN3w1GgVoB7yY3F2f40tVh6viWKHe6iI5S+
hXYgcpYBgJnQ8uMYTat5QqX9A4ksqRvFgnMi0nsmNwRrr55Co/PrhcL05GjFWVWk
EtTgYHeV5A==
=s6QT
-----END PGP SIGNATURE-----

--e4pmavt6pzvm3wrg--

