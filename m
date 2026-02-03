Return-Path: <linux-pwm+bounces-8076-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDzNIwxQgmmBSAMAu9opvQ
	(envelope-from <linux-pwm+bounces-8076-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 03 Feb 2026 20:44:12 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6A4DE3AC
	for <lists+linux-pwm@lfdr.de>; Tue, 03 Feb 2026 20:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 121043002915
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Feb 2026 19:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E2D366567;
	Tue,  3 Feb 2026 19:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qpGY1dFj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735A6211A14;
	Tue,  3 Feb 2026 19:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770147848; cv=none; b=mypZgz2LztpfS8KlfgnGHQQtJquoG9OS0R33XtKWzfEtEHXbere0k+ChGLhJTiJKYg/zcM/2fNTL6GMFH8AyUZ4tCmAFb44HhUx++1ssDmFFewxr39sfrz8wE6BNcT8tI3NyZS2E6SAYZ3fRl2Xb8raeyff/lBxeYN+eKUIWYks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770147848; c=relaxed/simple;
	bh=rilX/3q1uO+93ZDSC/0F/Ll3/KF8mSJ95JKd0lqaZJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oJjfVolq961/ro3g8sddy8gKvYH6rlmrf80rHbXJHxW8Xr7RUf5dcWndmGSx6dm3uwS0m8AtBqmH4V4rk0Xusxre1zpfZ4MUdHB0P37GUA/Drr8UzRsx0DmlGTgDBixOQNwnNHjDNNare6LSXU4UdY6XFCcEUGZngqr/uvH+K2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qpGY1dFj; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1770147844;
	bh=rilX/3q1uO+93ZDSC/0F/Ll3/KF8mSJ95JKd0lqaZJ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qpGY1dFjptNczdKqGjEmqbIwaPOAoPjUfMrb8f+7ajMiObg12tZJmRGRHYPr9D65b
	 oVBWhbz1HzB7h0ekQtL4lg4tFgkZi/M0F8vZU6vKM7I9DjZdZA3cjIGrNFPmibzJv7
	 0RoQdzCsm51CDbnr0ugwKWJuQFGtsO/ZaPrDmXlrWVftWiW+hIMJgNivbP3LEap0sa
	 rt5NNjMcxProZY185d2uwk/kT5rtDHAWGg+igEG47dDCnfJ//yAUZ8hzBW+UMHGlfp
	 s08I9cudyTsrycapcwci+65Gc7tQQXA89hZPt0se+gT9sxYVT2uTUoYKwhxqstvDGL
	 iwV7mkkDhai1g==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 805D217E01E7;
	Tue,  3 Feb 2026 20:44:03 +0100 (CET)
Date: Tue, 3 Feb 2026 20:43:54 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Gary Guo <gary@garyguo.net>, Alice Ryhl <aliceryhl@google.com>, Maxime
 Ripard <mripard@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Drew Fustini <fustini@kernel.org>, Guo Ren
 <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, Uwe =?UTF-8?B?S2xlaW5lLUs=?=
 =?UTF-8?B?w7ZuaWc=?= <ukleinek@kernel.org>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda
 <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, =?UTF-8?B?QmrDtnJu?=
 Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org,
 linux-pwm@vger.kernel.org, linux-clk@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v3 1/3] rust: clk: use the type-state pattern
Message-ID: <20260203204354.7032d958@fedora>
In-Reply-To: <B94452FD-5F6F-44D4-80D8-4D4B7004C4B5@collabora.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8076-lists,linux-pwm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[garyguo.net,google.com,kernel.org,linaro.org,linux.intel.com,suse.de,gmail.com,ffwll.ch,redhat.com,baylibre.com,protonmail.com,umich.edu,vger.kernel.org,lists.freedesktop.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boris.brezillon@collabora.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[collabora.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:email,collabora.com:dkim]
X-Rspamd-Queue-Id: AF6A4DE3AC
X-Rspamd-Action: no action

On Tue, 3 Feb 2026 16:26:22 -0300
Daniel Almeida <daniel.almeida@collabora.com> wrote:

> >=20
> > I think it's fine to have all of these:
> > * `Clone` impl
> > * `enable` which consumes `Clk<Prepared>` by value and spit out `Clk<En=
abled>`
> > * `with_enabled` that gives `&Clk<Enabled>`
> >=20
> > This way, if you only want to enable in short time, you can do `with_en=
abled`.
> > If the closure callback wants to keep clock enabled for longer, it can =
just do
> > `.clone()` inside the closure and obtain an owned `Clk<Enabled>`.
> >=20
> > If the user just have a reference and want to enable the callback they =
can do
> > `prepared_clk.clone().enable()` which gives an owned `Clk<Enabled>`. Th=
oughts?
> >=20
> > Best,
> > Gary =20
>=20
>=20
> I=E2=80=99m ok with what you proposed above. The only problem is that imp=
lementing
> clone() is done through an Arc<*mut bindings::clk>  in Boris=E2=80=99 cur=
rent
> design,

It's actually Arc<RawClk> with

    struct RawClk(*mut bindings::clk);

    impl Drop for RawClk {
        fn drop(&mut self) {
            // SAFETY: By the type invariants, self.as_raw() is a valid arg=
ument for // [`clk_put`].
            unsafe { bindings::clk_put(self.0) };
        }
    }

This is because struct clk is not refcounted, so cloning
implies wrapping this object in an Arc, and only calling
clk_put() when the Arc refcnt reaches zero.

> so this requires an extra allocation.

That's true. But the memory overhead should be pretty negligible,
and I don't think the extra indirection makes any noticeable
difference for an actual clk implementation (one that's not a NOP),
since we have indirections all over the place already (clk -> clk_hw,
clk_ops, ...). So I think I'd value ease of use over this small
perfs/mem-usage hit.

