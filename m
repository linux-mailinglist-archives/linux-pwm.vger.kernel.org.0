Return-Path: <linux-pwm+bounces-8065-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MMvA1opgmnFPwMAu9opvQ
	(envelope-from <linux-pwm+bounces-8065-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 03 Feb 2026 17:59:06 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72278DC66C
	for <lists+linux-pwm@lfdr.de>; Tue, 03 Feb 2026 17:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 578AC3009165
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Feb 2026 16:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95AF3D3307;
	Tue,  3 Feb 2026 16:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SQB8eyyQ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D273D3302;
	Tue,  3 Feb 2026 16:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770137746; cv=none; b=OuTtQPWqfhkpRpyseLJg1ulKNYsVm/FS2KJdg2SKmKYsILWdDzFzkdOkXExsldaDLU1ebLYR1TiJDdg86idN7IcbEitsY0TxZ6HtxVhtSn3UyiGSGQ/N4xlO/8nXCuaszo92/xEUHAftirLkfl4INxa5omfWs02jMOim3NlqCIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770137746; c=relaxed/simple;
	bh=kV4Ge2gh5t0HmAlwXC8n3adoRIP/5wSBNzlEZwjgwdE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YlWtXD+mqQlN/SeQZXIOH4zIyG5+LqMFBMBdpkCvm4gOAZc0V5tsBGeus6w09XB7EYysIRVNbi/Zym3hyRiVmDHXlepztBC8GwtJFVZKn2acDDZ1WKi5iw/HQSRv04mQhGh2ShkVgBgZnrj0kB9DuEOMVPWKMdywERkCazqbaYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SQB8eyyQ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1770137743;
	bh=kV4Ge2gh5t0HmAlwXC8n3adoRIP/5wSBNzlEZwjgwdE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SQB8eyyQ7m+9HKt1io93UcEwuHpqqVLhVaeRvzwZEyF6X8SsHu5YfL0Nwg3LvkoWp
	 rpRu700K7s/cTrZj0RFpQBmgbvLE/Gs31SFRRWVIX78vAR8eV8hQvmWVuR+g22BtTC
	 tQ6y3ygF9n2mXKYnkgbI7ezPoNaoJ6SBrmO0/tuilNzm8O8eUG/pbJzzAjLi2Tq9B/
	 /K7txIANL3FnTYNVLgFB8ygumSmzb6xji2/ZEBFTxSGzQ132DsEKdSlsd43Q7YyC9W
	 CRhDBrkNzYSHqUTXy3L8B1jXkBk41Hq9NzOzCD3H8ydlVSGR42QuORztpZ997mKUA2
	 fp05L7juKT2dA==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5CE7E17E1274;
	Tue,  3 Feb 2026 17:55:42 +0100 (CET)
Date: Tue, 3 Feb 2026 17:55:36 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Maxime Ripard <mripard@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
 <viresh.kumar@linaro.org>, Danilo Krummrich <dakr@kernel.org>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Drew Fustini <fustini@kernel.org>, Guo Ren
 <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, Uwe =?UTF-8?B?S2xlaW5lLUs=?=
 =?UTF-8?B?w7ZuaWc=?= <ukleinek@kernel.org>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda
 <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo
 <gary@garyguo.net>, =?UTF-8?B?QmrDtnJu?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org,
 linux-pwm@vger.kernel.org, linux-clk@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v3 1/3] rust: clk: use the type-state pattern
Message-ID: <20260203175536.1a77abbc@fedora>
In-Reply-To: <4DD13AE1-C85F-450F-93F2-C7C75766E518@collabora.com>
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
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8065-lists,linux-pwm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,kernel.org,linaro.org,linux.intel.com,suse.de,gmail.com,ffwll.ch,redhat.com,baylibre.com,garyguo.net,protonmail.com,umich.edu,vger.kernel.org,lists.freedesktop.org,lists.infradead.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boris.brezillon@collabora.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[collabora.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 72278DC66C
X-Rspamd-Action: no action

On Tue, 3 Feb 2026 13:28:15 -0300
Daniel Almeida <daniel.almeida@collabora.com> wrote:

> >> Now, this may not be the end of the world in this
> >> particular case, but for API consistency, I'd say we should probably a=
void this
> >> behavior.
> >>=20
> >> I see that Alice suggested a closure approach. IMHO, we should use that
> >> instead. =20
> >=20
> > The closure, while being useful for the above local clk-enablement
> > example, doesn't allow for passing some Clk<Enabled> guard around, like
> > you would do with a lock Guard, and I believe that's a useful thing to
> > have. =20
>=20
>=20
> Wdym? You=E2=80=99d still get a &Clk<Enabled> that you can pass around, i=
.e.:
>=20
>    self.prepared_clk.with_enabled(|clk: &Clk<Enabled> | {
>        ... use registers, pass &Clk<Enabled> as needed
>    });
>=20
> This is now not about clone() vs not clone(), but more about limiting the=
 scope of the
> Enabled state, which would cater to the use-case you mentioned IIUC.

Fair enough. I guess it's more a matter of taste for that particular
case, and I'm not fundamentally opposed to adding this closure approach.

What the clone approach allows that's not doable with the closure
AFAICT, is something like:

	let prep_clk =3D Clk::get(...)?.prepare()?;

	let comp_a =3D MyComponentA {
		prepared_clk: prep_clk.clone(),
	}

	let comp_b =3D MyComponentB {
		enabled_clk: prep_clk.enable()?,
	}

and have the guarantee that, as long as comp_a is alive the underlying
clk is at-least-Prepared, and as long as comp_b is alive the underlying
clk is Enabled.

