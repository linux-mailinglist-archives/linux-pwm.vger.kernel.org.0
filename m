Return-Path: <linux-pwm+bounces-8029-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEFiA0m7gWm7JAMAu9opvQ
	(envelope-from <linux-pwm+bounces-8029-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 03 Feb 2026 10:09:29 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 32400D69A9
	for <lists+linux-pwm@lfdr.de>; Tue, 03 Feb 2026 10:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3473E300683B
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Feb 2026 09:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E8E396B8D;
	Tue,  3 Feb 2026 09:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZFatVTox"
X-Original-To: linux-pwm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459A47260F;
	Tue,  3 Feb 2026 09:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770109763; cv=none; b=Mc1U+gFD7tJfIV+7FPmrTvF+1jiM9dKqNDMc9qsfB+Msn7SCcl4068m0pnxIOo8BNsWO8LeyTnB8BTLCGs+7qa1i7qnRcjEkI4G2rY2N9VYOQQ10SwBvhzNMAl94x0DWoDod+o2QsuVlAM5Jv+8/yGcf8EkCHvxUSI3KIMm1PKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770109763; c=relaxed/simple;
	bh=X7jzLZ1GgbMnGkSzg2P6TINP/UEVUi+UuFD6WvVbSxI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DA4juV0oImeXce7aqj0b4KaIIfXZgcyQdgZQgiAmyFqlojygFKNpNNI1DXzwdVo0imaydRe681riDnO0zGMlaXJolIIuT5BlzfUya79j/ElYGNoEFu9Ngdym8/Ch7Q2Io9jaJFJAWnHKWjHFNvASwpaTQjGApbk9bHOgsRbK854=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZFatVTox; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1770109760;
	bh=X7jzLZ1GgbMnGkSzg2P6TINP/UEVUi+UuFD6WvVbSxI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZFatVToxDXh4OwgdhbjFjXaOgCJU6JZAujnQlkaozaIVHjVFryZrSDyEFFhWw7Dde
	 DLTH3PD5JoMagk7qYK3kH1V8AjraHnhM5T2a1qj8snpWNY9xQ7YaweaWpLBE2jgoKY
	 KgjsOWUMIKOmJJlU8yOwmpsR4ghuvUXWvya6/uyjkxfjMfejARwbzAsddQKibn/6ji
	 M7XapaCo7JLZYZNkHmsmCb/TtbEKMcItKPGOpOGuBzceyoN0Kk8TK+clcecM1qCrCy
	 6OmvvOrV3XVaiX8JrMdndc+czEOTHamjC851t5mx78kTiEMUlHh/xLat/r3OIIKGSx
	 hsgcwAJUHjUUQ==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 603B717E00A3;
	Tue,  3 Feb 2026 10:09:19 +0100 (CET)
Date: Tue, 3 Feb 2026 10:09:13 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: "Gary Guo" <gary@garyguo.net>
Cc: "Daniel Almeida" <daniel.almeida@collabora.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Viresh Kumar" <viresh.kumar@linaro.org>, "Danilo
 Krummrich" <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Drew
 Fustini" <fustini@kernel.org>, "Guo Ren" <guoren@kernel.org>, "Fu Wei"
 <wefu@redhat.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <ukleinek@kernel.org>, "Michael Turquette" <mturquette@baylibre.com>,
 "Stephen Boyd" <sboyd@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun.feng@gmail.com>, =?UTF-8?B?QmrDtnJu?= Roy Baron
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-riscv@lists.infradead.org>,
 <linux-pwm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] rust: clk: use the type-state pattern
Message-ID: <20260203100913.6d224657@fedora>
In-Reply-To: <20260202171038.10e51e18@fedora>
References: <20260107-clk-type-state-v3-0-77d3e3ee59c2@collabora.com>
	<20260107-clk-type-state-v3-1-77d3e3ee59c2@collabora.com>
	<DFSMRQFIYQPO.1A38Y84XZ1GZO@garyguo.net>
	<20260202171038.10e51e18@fedora>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8029-lists,linux-pwm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[collabora.com,kernel.org,linaro.org,google.com,linux.intel.com,suse.de,gmail.com,ffwll.ch,redhat.com,baylibre.com,protonmail.com,umich.edu,vger.kernel.org,lists.freedesktop.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boris.brezillon@collabora.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[collabora.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,collabora.com:email,collabora.com:dkim]
X-Rspamd-Queue-Id: 32400D69A9
X-Rspamd-Action: no action

Hello Daniel,

On Mon, 2 Feb 2026 17:10:38 +0100
Boris Brezillon <boris.brezillon@collabora.com> wrote:

> > > -#[pin_data(PinnedDrop)]
> > > +#[pin_data]
> > >  pub(crate) struct TyrData {
> > >      pub(crate) pdev: ARef<platform::Device>,
> > >  
> > > @@ -92,13 +92,9 @@ fn probe(
> > >          pdev: &platform::Device<Core>,
> > >          _info: Option<&Self::IdInfo>,
> > >      ) -> impl PinInit<Self, Error> {
> > > -        let core_clk = Clk::get(pdev.as_ref(), Some(c_str!("core")))?;
> > > -        let stacks_clk = OptionalClk::get(pdev.as_ref(), Some(c_str!("stacks")))?;
> > > -        let coregroup_clk = OptionalClk::get(pdev.as_ref(), Some(c_str!("coregroup")))?;
> > > -
> > > -        core_clk.prepare_enable()?;
> > > -        stacks_clk.prepare_enable()?;
> > > -        coregroup_clk.prepare_enable()?;
> > > +        let core_clk = Clk::<Enabled>::get(pdev.as_ref(), Some(c_str!("core")))?;    
> > 
> > Ah, more turbofish.. I'd really want to avoid them if possible.
> > 
> > Any disadvantage on just ask the user to chain `.get().prepare_enable()?`? This
> > way it is also clear that some action is performed.  
> 
> I've just disc

Sorry, I've hit the reply button before I had finished writing my
answer. So I was about to say that I had started writing something
similar without knowing this series existed, and I feel like we'd don't
really need those prepare_enable() shortcuts that exist in C. We might
has well just go:

	Clk::get(dev, Some(c_str!("core"))).prepare()?.enable()?;

and have the following variant-specofoc functions

- Clk<Unprepared>::get[_optional]() (no get on Prepared and Enabled
  variants)
- Clk<Unprepared>::prepare()
- Clk<Prepared>::{enable,unprepare}()
- Clk<Enabled>::{disable}()

Regards,

Boris


