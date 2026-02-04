Return-Path: <linux-pwm+bounces-8079-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPTTCyT/gmmagQMAu9opvQ
	(envelope-from <linux-pwm+bounces-8079-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 04 Feb 2026 09:11:16 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B96E2FBA
	for <lists+linux-pwm@lfdr.de>; Wed, 04 Feb 2026 09:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B7A9C300FB62
	for <lists+linux-pwm@lfdr.de>; Wed,  4 Feb 2026 08:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004E938F930;
	Wed,  4 Feb 2026 08:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DsEFJ3Nh"
X-Original-To: linux-pwm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDC936A027;
	Wed,  4 Feb 2026 08:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770192672; cv=none; b=rl4E/+zUXhQHwa6PSyjqbcf2fec5qwyvZABWCdt+Y72hysCNsQ3xYdi/nrHbgwmm8euXT+bFiy6q0YvqFAKq2g3P5Ol6HWC9S1C3EnVIKBqjAJftYd6B82MnbU9P8NaiTqObDNKNqdUttgcpuQrch3C50Qc7KEuS9xL4ES5PBxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770192672; c=relaxed/simple;
	bh=8j8R8MPrfWY6vBRRIpvDiircDbGhdSwDxXfuiVs5GeI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=njr3Td8ocY2hdwhpuEjoCl2LtemEFzWZUSWnT4ypP8igm5JuQHnWcYoPyrVJwoNt8t6dpVfd3FuTVLJ2UBFf+OCeD4OVX5knf3Ru2d35mS+g/2AQrfIRgnRIYH9qC+8aK/pYldPSirN+DeMv7bB1bPTkjNiJRDrMLRWiAxYnvN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DsEFJ3Nh; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1770192670;
	bh=8j8R8MPrfWY6vBRRIpvDiircDbGhdSwDxXfuiVs5GeI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DsEFJ3Nhca0gHPn0WW46xPuzuZwRmLNuOpKTYci/Grpz+8iFbAUufcYWOTdolbhe4
	 4Rju+q4X4pcKmAjKivkByu4y4dJjqVFYuCz5WFEYfcwMkREFh1aD8b/HUnDvbBGA4O
	 K1Tom/wQJod9y9Z6en141msQx34QphBNYgjipqSBG0XBBmR/FBZVfKVSfxPegpTbfj
	 w4RljDBo2vI4n3721FrPdjwSS+bIn9ahzDlJQUGlfuXZledsqf1PdT+3XYuZqoD+lC
	 i/NCr5O3feDTRIiu+CdMizfBKEWtDKIfpGXKb9i0DyOQihsMQ5R5bLUkGRJ15nhaFH
	 ZJJ99EmmtpDZA==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id AE37317E114C;
	Wed,  4 Feb 2026 09:11:09 +0100 (CET)
Date: Wed, 4 Feb 2026 09:11:04 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: "Gary Guo" <gary@garyguo.net>
Cc: "Daniel Almeida" <daniel.almeida@collabora.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Maxime Ripard" <mripard@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, "Viresh Kumar" <viresh.kumar@linaro.org>,
 "Danilo Krummrich" <dakr@kernel.org>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Thomas Zimmermann"
 <tzimmermann@suse.de>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Drew Fustini" <fustini@kernel.org>, "Guo Ren"
 <guoren@kernel.org>, "Fu Wei" <wefu@redhat.com>, Uwe =?UTF-8?B?S2xlaW5l?=
 =?UTF-8?B?LUvDtm5pZw==?= <ukleinek@kernel.org>, "Michael Turquette"
 <mturquette@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>,
 =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, <linux-pm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-riscv@lists.infradead.org>, <linux-pwm@vger.kernel.org>,
 <linux-clk@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] rust: clk: use the type-state pattern
Message-ID: <20260204091104.0a9c4a13@fedora>
In-Reply-To: <DG5M5MVHTNS4.1CUD61S0PD9NU@garyguo.net>
References: <20260107-clk-type-state-v3-0-77d3e3ee59c2@collabora.com>
	<20260107-clk-type-state-v3-1-77d3e3ee59c2@collabora.com>
	<20260108-delectable-fennec-of-sunshine-ffca19@houat>
	<98CD0BF6-3350-40B9-B8A9-F569AE3E3220@collabora.com>
	<20260119-thundering-tested-robin-4be817@houat>
	<aW4lCfUyumOKRRJm@google.com>
	<20260203113902.501e5803@fedora>
	<E7286D12-0BD9-4726-B072-FE5A040312B1@collabora.com>
	<20260203150855.77c93e22@fedora>
	<4DD13AE1-C85F-450F-93F2-C7C75766E518@collabora.com>
	<DG5HJPIYMS7B.152WPGG9MZZJ5@garyguo.net>
	<B94452FD-5F6F-44D4-80D8-4D4B7004C4B5@collabora.com>
	<DG5M5MVHTNS4.1CUD61S0PD9NU@garyguo.net>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8079-lists,linux-pwm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[collabora.com,google.com,kernel.org,linaro.org,linux.intel.com,suse.de,gmail.com,ffwll.ch,redhat.com,baylibre.com,protonmail.com,umich.edu,vger.kernel.org,lists.freedesktop.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boris.brezillon@collabora.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[collabora.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 98B96E2FBA
X-Rspamd-Action: no action

Hi Gary, Daniel,

On Tue, 03 Feb 2026 20:36:30 +0000
"Gary Guo" <gary@garyguo.net> wrote:

> On Tue Feb 3, 2026 at 7:26 PM GMT, Daniel Almeida wrote:
> > =20
> >>=20
> >> I think it's fine to have all of these:
> >> * `Clone` impl
> >> * `enable` which consumes `Clk<Prepared>` by value and spit out `Clk<E=
nabled>`
> >> * `with_enabled` that gives `&Clk<Enabled>`
> >>=20
> >> This way, if you only want to enable in short time, you can do `with_e=
nabled`.
> >> If the closure callback wants to keep clock enabled for longer, it can=
 just do
> >> `.clone()` inside the closure and obtain an owned `Clk<Enabled>`.
> >>=20
> >> If the user just have a reference and want to enable the callback they=
 can do
> >> `prepared_clk.clone().enable()` which gives an owned `Clk<Enabled>`. T=
houghts?
> >>=20
> >> Best,
> >> Gary =20
> >
> >
> > I=E2=80=99m ok with what you proposed above. The only problem is that i=
mplementing
> > clone() is done through an Arc<*mut bindings::clk>  in Boris=E2=80=99 c=
urrent
> > design, so this requires an extra allocation. =20
>=20
> Hmm, that's a very good point. `struct clk` is already a reference into
> clk_core, so having to put another level of indirection over is not ideal.
> However, if we're going to keep C code unchanged and do a zero-cost abstr=
action
> on the Rust side, then we won't be able to have have multiple prepare/ena=
ble to
> the same `struct clk` with the current design.
>=20
> It feels like we can to do a trade-off and choose from:
> 1. Not be able to have multiple prepare/enable calls on the same `clk` (t=
his can
>    limit users that need dynamically enable/disable clocks, with the very=
 limited
>    exception that closure-callback is fine).
> 2. Do an extra allocation
> 3. Put lifetime on types that represent a prepared/enabled `Clk`
> 4. Change C to make `struct clk` refcounted.

It probably comes to no surprise that I'd be more in favor of option 2
or 4. Maybe option 2 first, so we can get the user-facing API merged
without too much churn, and then we can see if the clk maintainers are
happy adding a refcnt to struct clk to optimize things.

If we really feel that the indirection/memory overhead is going to
hurt us, we can also start with option 1, and extend it to 2 and/or 4
(needed to add a Clone support) when it becomes evident we can't do
without it. But as I was saying in my previous reply to Daniel, I
expect the extra indirection/memory overhead to be negligible since:

1. clks are usually not {prepared,enabled}/{disabled,unprepared} in a
   hot path
2. in the rare occasions where they might be ({dev,cpu}freq ?), this
   clk state change is usually one operation in an ocean of other
   slower operations (regulator reconfiguration, for instance, which
   usually goes over a slow I2C bus, or a
   relatively-faster-but-still-slow SPI one, at least when we compare
   it to an IoMem access for in-SoCs clks). So overall, the clk state
   change might account for a very small portion of the CPU cycles
   spent in this bigger operation
3. if I focus solely on the clk aspect, and look at the existing
   indirections in the clk framework (clk -> clk_core -> clk_{hw,ops} ->
   clk_methods), I'd expect the Arc indirection to be just noise in
   this pre-existing overhead
4. in term of memory, we're talking about 16 more bytes allocated per
   Clk on a 64-bit architecture (refcount is an int, but the alignment
   for the clk pointer forces 4 bytes of padding on most
   architectures). On a 64 bit arch, struct clk is 72 bytes if my math
   is correct, so that's a 22% overhead, compared to 11% overhead if
   the refcount was in struct clk (or in a struct
   refcounted_clk variant if we don't want C users to pay the price).
   Not great, but not terrible either

So yeah my gut feeling is that we might be overthinking this extra
allocation/indirection issue. This being said, one thing I'd really like
to avoid is us being dragged into infinite discussions about a perfect
implementation causing the merging of these changes to be delayed and
other contributions being blocked on this (perfect is the enemy of
good). I mean, option #1 is already an improvement compared to the raw
functions we have at the moment, so if that's the middle-ground we
agree on, I'm happy to give it my R-b.

Regards,

Boris

