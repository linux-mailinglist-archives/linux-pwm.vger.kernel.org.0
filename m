Return-Path: <linux-pwm+bounces-7986-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QI2gBXk5cmmadwAAu9opvQ
	(envelope-from <linux-pwm+bounces-7986-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 22 Jan 2026 15:51:37 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4E268275
	for <lists+linux-pwm@lfdr.de>; Thu, 22 Jan 2026 15:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 07D9A8E4131
	for <lists+linux-pwm@lfdr.de>; Thu, 22 Jan 2026 13:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E9331A072;
	Thu, 22 Jan 2026 13:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MiijZP2P"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FEC26A0A7;
	Thu, 22 Jan 2026 13:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769089492; cv=none; b=A7FhzhOB1NTTfL2F7mm2cdUuSyn1SBKMy/IaQQS2yABEjFpeubxD+Tgu9j2Rez3NkyG/zmlgaxmSxx8Ykk5LvbgPRdT2utMtPxunsV196nk5gBNrU/zbfrZsBEHc3zllSVlSLlwQqIcHTE55Zjsj8uBvuqsQ2+5P6+ItzRXaKqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769089492; c=relaxed/simple;
	bh=j8JEqlvIFnXt9gGEm0Oheoh75nKbbz8Bdg2iudx4Y8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eAW7eew5ggT9JIpyjSfqUoSgtpc6bbJhLGct0kz6kUsdnqShdLQkV7OLVz22c5QVDkvn5MdrPq6+ZBgy1OPV7w8lzvh9B5TRbXrL3HOmzkMHVyJjIpJEDndHnN5/jZtxUCXHvoX4f996H3gqgantmq2fX/Om+NZBW5X2yOes/Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MiijZP2P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C125C116C6;
	Thu, 22 Jan 2026 13:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769089491;
	bh=j8JEqlvIFnXt9gGEm0Oheoh75nKbbz8Bdg2iudx4Y8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MiijZP2PgQ7cWwM/BrL4/aHqDuWgWt7buVDitzOLLgQdCeGQbRri9VRoWsknB6BOs
	 MW4NXW6W74RdY0fAsK6Bdd8gp3rRRx5EUSq74/zd+Y3DQk3JDvoomz7nvfQXW4sYLt
	 5NK4v3hzZ1ozM6HXvxIyYNRKjNtql6nEd8fORfMN3aJ57Fm0fNPpqIpF07lBZJNEqe
	 bh1lrnUZrr3xfZB+VMQmhgzNd1DvOX4XxCozUKLJsUOQjxjF4TFLjOaa5sReHLH4/Q
	 rdTHw5qscsZCtb4v7dlQUXKGr6CN30WBw/AIPOWvt9r6gzUfBUhamrC89amGEuE/MZ
	 erbPngC11saWw==
Date: Thu, 22 Jan 2026 14:44:49 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, 
	Alice Ryhl <aliceryhl@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
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
Message-ID: <20260122-majestic-masterful-jaguarundi-d0abde@houat>
References: <20260107-clk-type-state-v3-0-77d3e3ee59c2@collabora.com>
 <20260107-clk-type-state-v3-1-77d3e3ee59c2@collabora.com>
 <20260108-delectable-fennec-of-sunshine-ffca19@houat>
 <98CD0BF6-3350-40B9-B8A9-F569AE3E3220@collabora.com>
 <20260119-thundering-tested-robin-4be817@houat>
 <aW4lCfUyumOKRRJm@google.com>
 <518D8B09-B9A1-4DB4-85CD-37A2DD3D5FB1@collabora.com>
 <DFSLCI9U4NCW.2HI2UPUI7G134@kernel.org>
 <20260119-weightless-pelican-of-anger-190db0@houat>
 <DFSN4FDCYHMW.3J3237PEBV2ZP@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="zgoq7kx6iu4jzgjw"
Content-Disposition: inline
In-Reply-To: <DFSN4FDCYHMW.3J3237PEBV2ZP@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.06 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7986-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	FREEMAIL_CC(0.00)[collabora.com,google.com,kernel.org,linaro.org,linux.intel.com,suse.de,gmail.com,ffwll.ch,redhat.com,baylibre.com,garyguo.net,protonmail.com,umich.edu,vger.kernel.org,lists.freedesktop.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mripard@kernel.org,linux-pwm@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 6D4E268275
X-Rspamd-Action: no action


--zgoq7kx6iu4jzgjw
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 1/3] rust: clk: use the type-state pattern
MIME-Version: 1.0

On Mon, Jan 19, 2026 at 03:37:17PM +0100, Danilo Krummrich wrote:
> On Mon Jan 19, 2026 at 3:18 PM CET, Maxime Ripard wrote:
> > On Mon, Jan 19, 2026 at 02:13:48PM +0100, Danilo Krummrich wrote:
> >> On Mon Jan 19, 2026 at 1:54 PM CET, Daniel Almeida wrote:
> >> >> On 19 Jan 2026, at 09:35, Alice Ryhl <aliceryhl@google.com> wrote:
> >> >> I think that if you still want an API where you just call enable/di=
sable
> >> >> directly on it with no protection against unbalanced calls, then th=
at
> >> >> should be the special API. Probably called RawClk and functions mar=
ked
> >> >> unsafe. Unbalanced calls seem really dangerous and use should not be
> >> >> encouraged.
> >>=20
> >> +1; and unless there is a use-case that requires otherwise, it should =
not even
> >> be possible to do this at all -- at least for driver code.
> >
> > I mean, it's great, it's safe, etc. but it's also suboptimal from a PM
> > perspective on many platforms. It's totally fine to provide nice, safe,
> > ergonomic wrappers for the drivers that don't care (or can't, really),
> > but treating a legitimate optimisation as something we should consider
> > impossible to do is just weird to me.
>=20
> I said that an unsafe API with potentially unbalanced calls is something =
we
> should clearly avoid for drivers. This is *not* equivalent to "treating a
> legitimate optimisation as something we should consider impossible".
>=20
> If we discover use-cases where the current API doesn't work well, we can
> invenstigate further.

I'm not sure I'm following what you're saying, sorry. I've pointed out
such a use-case already.

> >> > I think we should discourage RawClk if at all possible. But if the c=
onsensus
> >> > is that we *really* need this easily-abused thing, I can provide a f=
ollow-up.
> >>=20
> >> I think we should only do this if there are use-case with no alternati=
ve, so far
> >> there haven't been any AFAIK.
> >
> > I don't really care about which alternative we come up with, but look at
> > devm_regmap_init_mmio_clk for example. It is a valid use-case that
> > already exists today, and has had for more than a decade at this point.
>=20
> I don't see the issue with devm_regmap_init_mmio_clk()? It takes a refere=
nce
> count of the clock and prepares it when called and unprepares the clk in =
drops
> its reference in regmap_mmio_free_context() called from the devres callba=
ck.
>=20
> That something we can easily do with the current API, no?

The current one, yes. Doing that in the API suggested here would involve
some boilerplate in all those drivers they don't have right now.

Maxime

--zgoq7kx6iu4jzgjw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaXIp0AAKCRAnX84Zoj2+
dv/rAX9htC+v4VP6TU5rtpJ5yxn/5pIK0gwosc19iO/daFXAUH7fxYosU1HBuveb
KxjMgb8BgMuQtaOp2idk6EzXwAecWf/CAQ08Ci5MNA2QR6rNT2nYPbr8TNKaiLWq
nIzGXz2HvQ==
=cTWW
-----END PGP SIGNATURE-----

--zgoq7kx6iu4jzgjw--

