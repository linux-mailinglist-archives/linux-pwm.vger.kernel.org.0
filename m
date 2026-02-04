Return-Path: <linux-pwm+bounces-8083-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MF8zBuMOg2kBhQMAu9opvQ
	(envelope-from <linux-pwm+bounces-8083-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 04 Feb 2026 10:18:27 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F62E3BB6
	for <lists+linux-pwm@lfdr.de>; Wed, 04 Feb 2026 10:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 94DFF3010B92
	for <lists+linux-pwm@lfdr.de>; Wed,  4 Feb 2026 09:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8159F3A1E82;
	Wed,  4 Feb 2026 09:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BvsZkZO9"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1EE3A1E77;
	Wed,  4 Feb 2026 09:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770196691; cv=none; b=LU0eTonHXqAznroQl3drVwhWD/NDyqkuXFRSybyYWWx2PfP4mSYjBzMr39KPvIUJT3e0cShcPAFMl/CSiWqwAPmOKjYQPTUveQHmXM+fmMMuT/V8nlIEu4PvmrgFkGKONhAbqajLDf7Fig7Ny/3wxvkBOs433AX2ke4/O+RuHrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770196691; c=relaxed/simple;
	bh=P7VVEj/kLKZsCTZNYZCLsTQXk/QsOpa5tXm+pUPfS2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eB9FS2QCb92ypgl/O9Iql40t1ocqDyibxwc/HhTHitZKE2VgxMttm21x0yKGOaFG26wBa9vjRcXawmaXU8vUBnnN0U0GhVq/3lWkqs9+ttQDrDn0V1LIu0TroVAPF+oH8cXlJn+VTWTAt5ieo0f12ZRkJ4LlsvlZO2L3piI3EJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BvsZkZO9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68986C4CEF7;
	Wed,  4 Feb 2026 09:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770196690;
	bh=P7VVEj/kLKZsCTZNYZCLsTQXk/QsOpa5tXm+pUPfS2Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BvsZkZO9i1X4RmX9IPdfJ9CVV3Maf+wiFIbDIV6TgxTvWvlV15dyPg9p8RyasquYQ
	 tjV/8plk39JIiBN9hJCPmneVZNjzu68bk/BRAgN9SPDJWJ9b+hns2QuL42v/Orguid
	 IknUvK/KpqQIqBcF3oJwteG2sDsuC+mFlCVUtpan/eI03oo/LN7EneOH1JLejpub2r
	 0TGqdeLh7EJU3F3KYkPmyVFLzlF5dZo7y5j5HT+nNUrP08TaOFPpWF5eFrdnIvs+ZC
	 U/G3Xk8EuoltbuCdape+1kvy+j1k0BZeiTfIpCtgOxZrI4cHqr2FuaSvsJby/iHzC2
	 cm4/ArpITD9nw==
Date: Wed, 4 Feb 2026 10:18:08 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Gary Guo <gary@garyguo.net>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Alice Ryhl <aliceryhl@google.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Danilo Krummrich <dakr@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Fu Wei <wefu@redhat.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org, 
	linux-clk@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v3 1/3] rust: clk: use the type-state pattern
Message-ID: <20260204-cunning-strange-bittern-2bb569@houat>
References: <20260119-thundering-tested-robin-4be817@houat>
 <aW4lCfUyumOKRRJm@google.com>
 <20260203113902.501e5803@fedora>
 <E7286D12-0BD9-4726-B072-FE5A040312B1@collabora.com>
 <20260203150855.77c93e22@fedora>
 <4DD13AE1-C85F-450F-93F2-C7C75766E518@collabora.com>
 <DG5HJPIYMS7B.152WPGG9MZZJ5@garyguo.net>
 <B94452FD-5F6F-44D4-80D8-4D4B7004C4B5@collabora.com>
 <DG5M5MVHTNS4.1CUD61S0PD9NU@garyguo.net>
 <20260204091104.0a9c4a13@fedora>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="o6nwitrag23dn734"
Content-Disposition: inline
In-Reply-To: <20260204091104.0a9c4a13@fedora>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8083-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	FREEMAIL_CC(0.00)[garyguo.net,collabora.com,google.com,kernel.org,linaro.org,linux.intel.com,suse.de,gmail.com,ffwll.ch,redhat.com,baylibre.com,protonmail.com,umich.edu,vger.kernel.org,lists.freedesktop.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mripard@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,garyguo.net:email]
X-Rspamd-Queue-Id: 83F62E3BB6
X-Rspamd-Action: no action


--o6nwitrag23dn734
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 1/3] rust: clk: use the type-state pattern
MIME-Version: 1.0

On Wed, Feb 04, 2026 at 09:11:04AM +0100, Boris Brezillon wrote:
> Hi Gary, Daniel,
>=20
> On Tue, 03 Feb 2026 20:36:30 +0000
> "Gary Guo" <gary@garyguo.net> wrote:
>=20
> > On Tue Feb 3, 2026 at 7:26 PM GMT, Daniel Almeida wrote:
> > > =20
> > >>=20
> > >> I think it's fine to have all of these:
> > >> * `Clone` impl
> > >> * `enable` which consumes `Clk<Prepared>` by value and spit out `Clk=
<Enabled>`
> > >> * `with_enabled` that gives `&Clk<Enabled>`
> > >>=20
> > >> This way, if you only want to enable in short time, you can do `with=
_enabled`.
> > >> If the closure callback wants to keep clock enabled for longer, it c=
an just do
> > >> `.clone()` inside the closure and obtain an owned `Clk<Enabled>`.
> > >>=20
> > >> If the user just have a reference and want to enable the callback th=
ey can do
> > >> `prepared_clk.clone().enable()` which gives an owned `Clk<Enabled>`.=
 Thoughts?
> > >>=20
> > >> Best,
> > >> Gary =20
> > >
> > >
> > > I=E2=80=99m ok with what you proposed above. The only problem is that=
 implementing
> > > clone() is done through an Arc<*mut bindings::clk>  in Boris=E2=80=99=
 current
> > > design, so this requires an extra allocation. =20
> >=20
> > Hmm, that's a very good point. `struct clk` is already a reference into
> > clk_core, so having to put another level of indirection over is not ide=
al.
> > However, if we're going to keep C code unchanged and do a zero-cost abs=
traction
> > on the Rust side, then we won't be able to have have multiple prepare/e=
nable to
> > the same `struct clk` with the current design.
> >=20
> > It feels like we can to do a trade-off and choose from:
> > 1. Not be able to have multiple prepare/enable calls on the same `clk` =
(this can
> >    limit users that need dynamically enable/disable clocks, with the ve=
ry limited
> >    exception that closure-callback is fine).
> > 2. Do an extra allocation
> > 3. Put lifetime on types that represent a prepared/enabled `Clk`
> > 4. Change C to make `struct clk` refcounted.
>=20
> It probably comes to no surprise that I'd be more in favor of option 2
> or 4. Maybe option 2 first, so we can get the user-facing API merged
> without too much churn, and then we can see if the clk maintainers are
> happy adding a refcnt to struct clk to optimize things.
>=20
> If we really feel that the indirection/memory overhead is going to
> hurt us, we can also start with option 1, and extend it to 2 and/or 4
> (needed to add a Clone support) when it becomes evident we can't do
> without it. But as I was saying in my previous reply to Daniel, I
> expect the extra indirection/memory overhead to be negligible since:
>=20
> 1. clks are usually not {prepared,enabled}/{disabled,unprepared} in a
>    hot path
> 2. in the rare occasions where they might be ({dev,cpu}freq ?), this
>    clk state change is usually one operation in an ocean of other
>    slower operations (regulator reconfiguration, for instance, which
>    usually goes over a slow I2C bus, or a
>    relatively-faster-but-still-slow SPI one, at least when we compare
>    it to an IoMem access for in-SoCs clks). So overall, the clk state
>    change might account for a very small portion of the CPU cycles
>    spent in this bigger operation

I'm not even too worried about that one. devfreq and cpufreq will
typically adjust the clock rate while device is active, and thus the
clock is enabled. So we shouldn't have a prepared -> enabled transition
in the path that adjust the device / cpu rate, it would have happened
before.

Maxime

--o6nwitrag23dn734
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaYMOzwAKCRAnX84Zoj2+
doB8AYCfx9IZOlLCZ2nw2gkPQkwwMDlcj5etfelzJqKGoQ1Blw8+W8r6ng1eq07z
cLHVaE0BgJrwYQAoxvhIjBTgEYBe2ph4BRLtr784a1qlhn5ISI7HvPvTlIAIQY6Z
X2wiFMonHg==
=OqKD
-----END PGP SIGNATURE-----

--o6nwitrag23dn734--

