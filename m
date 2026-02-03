Return-Path: <linux-pwm+bounces-8042-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBOQKQ4MgmmCOQMAu9opvQ
	(envelope-from <linux-pwm+bounces-8042-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 03 Feb 2026 15:54:06 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDA1DAD65
	for <lists+linux-pwm@lfdr.de>; Tue, 03 Feb 2026 15:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E62B03049ED8
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Feb 2026 14:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CE13ACEE3;
	Tue,  3 Feb 2026 14:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pFDS0747"
X-Original-To: linux-pwm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532333A4F54;
	Tue,  3 Feb 2026 14:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770130444; cv=none; b=dVBVqiEaES75DWDUl/8JXAdAbiY7wqjYjXUC0IOGBNo4E+gx6FeNVqRxlEeNmyrcdcixVp3hZOd7hY0VlJBU2fdygDCCyAeD2vq1d81p+aLTCaBC7b0XNkxw5PHyl2F1J1toEQ2c1jeF9QK8TuhY+SYvPh11bTRaFv9RAj3BkTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770130444; c=relaxed/simple;
	bh=3KcvY6BFAVkYx2CaRlFGKXfmnRMIMtHNvAHM5ApGVvU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CvOO+TARy8OfVTUe0Z1DVEzWmxmErborkoF88hBP/7tFKFXb4oMNdExXWKbXo9Ztj3+ycCPopC9sPxFzMk9Aeuq+O83Lhcv4eqD1cT+itE+F+Sm8Konryo0tN8iPi8xIrgAYPooL70HvYJXpd7ohmdlI63ZWgXPcjd2ArWADmUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pFDS0747; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1770130440;
	bh=3KcvY6BFAVkYx2CaRlFGKXfmnRMIMtHNvAHM5ApGVvU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pFDS0747I6//N0JfFvhOfrFRr349OeRMQajiwIK8cB6QKQ03hqynIuKOrUfpt1l+O
	 dTEBCyQ4QKVRojCCHAFmlJoVLbYxifRL5ffhWX3K36Od5RdlARX8wuWCdIqjEey18u
	 FvjFLQDwvXiAsGytBefZEqsQCL0kPT4BhaYhhfE+K9G/m93jzOjmhYFBjSc2jt55qp
	 BcuFlVbjlyBfZW13v4DFI3pJ6X3jbK5IqEN/XIZ+WjuyeJn5sv4U+NtF8WKY78DFcA
	 7Z1ick3CWWW6UrjT+OZRS/5bLrHmUV3oGyqoQlMCmlr/N+Ee5QkeFCL0rUJSoYMdUa
	 9DyAzghoEakpg==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 72A7317E1276;
	Tue,  3 Feb 2026 15:53:59 +0100 (CET)
Date: Tue, 3 Feb 2026 15:53:54 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Maxime Ripard <mripard@kernel.org>, Daniel Almeida
 <daniel.almeida@collabora.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Drew Fustini <fustini@kernel.org>, Guo Ren
 <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, "Uwe =?UTF-8?B?S2xlaW5l?=
 =?UTF-8?B?LUvDtm5pZw==?=" <ukleinek@kernel.org>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda
 <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo
 <gary@garyguo.net>, "=?UTF-8?B?QmrDtnJu?= Roy Baron"
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org,
 linux-pwm@vger.kernel.org, linux-clk@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v3 1/3] rust: clk: use the type-state pattern
Message-ID: <20260203155354.0cea1f65@fedora>
In-Reply-To: <20260203122631.3a94a935@fedora>
References: <20260107-clk-type-state-v3-0-77d3e3ee59c2@collabora.com>
	<20260107-clk-type-state-v3-1-77d3e3ee59c2@collabora.com>
	<20260108-delectable-fennec-of-sunshine-ffca19@houat>
	<98CD0BF6-3350-40B9-B8A9-F569AE3E3220@collabora.com>
	<20260119-thundering-tested-robin-4be817@houat>
	<aW4lCfUyumOKRRJm@google.com>
	<20260203113902.501e5803@fedora>
	<20260203122631.3a94a935@fedora>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8042-lists,linux-pwm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,collabora.com,linaro.org,linux.intel.com,suse.de,gmail.com,ffwll.ch,redhat.com,baylibre.com,garyguo.net,protonmail.com,umich.edu,vger.kernel.org,lists.freedesktop.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boris.brezillon@collabora.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[collabora.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,collabora.com:email,collabora.com:dkim,gitlab.freedesktop.org:url]
X-Rspamd-Queue-Id: 0DDA1DAD65
X-Rspamd-Action: no action

On Tue, 3 Feb 2026 12:26:31 +0100
Boris Brezillon <boris.brezillon@collabora.com> wrote:

> On Tue, 3 Feb 2026 11:39:02 +0100
> Boris Brezillon <boris.brezillon@collabora.com> wrote:
> 
> > On Mon, 19 Jan 2026 12:35:21 +0000
> > Alice Ryhl <aliceryhl@google.com> wrote:
> >   
> > > On Mon, Jan 19, 2026 at 11:45:57AM +0100, Maxime Ripard wrote:    
> > > > On Thu, Jan 08, 2026 at 11:14:37AM -0300, Daniel Almeida wrote:      
> > > > > > For example, it's quite typical to have (at least) one clock for the bus
> > > > > > interface that drives the register, and one that drives the main
> > > > > > component logic. The former needs to be enabled only when you're
> > > > > > accessing the registers (and can be abstracted with
> > > > > > regmap_mmio_attach_clk for example), and the latter needs to be enabled
> > > > > > only when the device actually starts operating.
> > > > > > 
> > > > > > You have a similar thing for the prepare vs enable thing. The difference
> > > > > > between the two is that enable can be called into atomic context but
> > > > > > prepare can't.
> > > > > > 
> > > > > > So for drivers that would care about this, you would create your device
> > > > > > with an unprepared clock, and then at various times during the driver
> > > > > > lifetime, you would mutate that state.      
> > > 
> > > The case where you're doing it only while accessing registers is
> > > interesting, because that means the Enable bit may be owned by a local
> > > variable. We may imagine an:
> > > 
> > >     let enabled = self.prepared_clk.enable_scoped();
> > >     ... use registers
> > >     drop(enabled);
> > > 
> > > Now ... this doesn't quite work with the current API - the current
> > > Enabled stated owns both a prepare and enable count, but the above keeps
> > > the prepare count in `self` and the enabled count in a local variable.
> > > But it could be done with a fourth state, or by a closure method:
> > > 
> > >     self.prepared_clk.with_enabled(|| {
> > >         ... use registers
> > >     });
> > > 
> > > All of this would work with an immutable variable of type Clk<Prepared>.    
> > 
> > Hm, maybe it'd make sense to implement Clone so we can have a temporary
> > clk variable that has its own prepare/enable refs and releases them
> > as it goes out of scope. This implies wrapping *mut bindings::clk in an
> > Arc<> because bindings::clk is not ARef, but should be relatively easy
> > to do. Posting the quick experiment I did with this approach, in case
> > you're interested [1]  
> 
> This time with a proper RawClk(*mut bindings::clk) wrapper, so we can
> clk_put() called in RawClk::drop() instead of in Clk::drop().
> 
> [1]https://gitlab.freedesktop.org/bbrezillon/linux/-/commit/6fa6cb72f14373b276c61d038bc2b16f49c78f74

And I forgot to drop the ManuallyDrop in that one, but I bet you get the
idea.

