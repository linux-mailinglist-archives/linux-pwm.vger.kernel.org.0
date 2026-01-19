Return-Path: <linux-pwm+bounces-7923-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64ACCD3A918
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Jan 2026 13:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5016D304D4A1
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Jan 2026 12:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2560635BDCB;
	Mon, 19 Jan 2026 12:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="why3I2/c"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DBA322B79
	for <linux-pwm@vger.kernel.org>; Mon, 19 Jan 2026 12:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768826127; cv=none; b=jvw1z0AWhijerwcPrhQj1N883U2zy9KKDqUqO+D22bkpD5ZodVd3I/E2B/aM8Is5bllAHZ9MSli/3iv6F6XdIxq4ghoqNKBqyypIE6mtHhNoNmm9y/X9ZcMtT7HlPMBh7nLAODw/rY0nOjHf8zwpT0JBMUZwO58A6nMtGLHaRas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768826127; c=relaxed/simple;
	bh=QgtIrq2v5XTFNi5vlU8fw46Ar/tthUMJiTbRAMcagGQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hMFtqDdlSToW5ZzUVqSDXx//TxREcpv/lBiS0XhEUJxB7k5hrfkPo5WDNu7N1zlVRcgMPwRJfuwfZVHHrkFmJLNNXujhsHhv2uX0nnwzVwUkZZz+Bi+JPpUqhz0NN6t3RWHiYjlq3qf/H+Q6hofIcXo2JvssoxK1oWweVb65vI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=why3I2/c; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-47d5bd981c8so27191405e9.0
        for <linux-pwm@vger.kernel.org>; Mon, 19 Jan 2026 04:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768826123; x=1769430923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L339R8Vsk/eWURHJ0AqPSpw3w1NFXPchbsihcVaLjUM=;
        b=why3I2/cUVdJrdwiko+xycCbGMCLYBh6gO5rNTfm5HRilICJTdQb0UzM286OCmHZ5x
         Az/ENk7+vDBcon8Fs2ADANebi5Z2KIMU2Tb7yeslwJT2ml3MHhxs4gKIa3A5beuB73qD
         uyLz2olrXCOWO1KOWrf5KF/QPKnSKrpct6TjpprI8HB/YIe/jg0oudYl7fgKc6TwaeZa
         kF2EMLOw3evT3kR2EmDPLipZ9Iva9cVEBp0OG2VuBliG8eaSmeRhx8SHY57GKckV8Dyn
         X++SkN+bJhV+haiOBUz7tdjDWNsoONI+LJz+iPeAikjoqspaos6wWS+oCVY9PXVPc8oK
         1b1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768826123; x=1769430923;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L339R8Vsk/eWURHJ0AqPSpw3w1NFXPchbsihcVaLjUM=;
        b=bn1+7cWe0/VZSRvHoERBrQjN98eDLsYTsgFIk2q1xtUVO45m0aNcjjh1W7Zq729bnx
         WRsQO8FhJqnMbTeQR+c7XYyVnY8XVGu/dwYVcCCtUi+/tq1IFBRTKzk88WIDqMM8ycZI
         C8WIlhI4D7308hFJONa/pam9sMCCbNbXPcCB4mDxRs+8l+GmHCZcq3S+iw6HCidPVZ2f
         baLtd9d0UKgwIymLbQUunl3+HDkIP+3oUPAG3W77NcM5oWW9hDcItbPZ25pbVUW5KMF0
         i3MRrvJR/YqxJBC1AmnMJeOr/wXWuiwpIj9+hnqjXAPR2tDDg6rkCMLwWuZDavdDqxmD
         FALw==
X-Forwarded-Encrypted: i=1; AJvYcCUUobzFnsDH8kI5uo2cI7ZUO5p44LVMgcrpnGlUT9V666VMryA6Ed2heHLO7fJIqEiHRxWSonvzsVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbMX0p67R58oWeUwhoJz91bjGZfT0W00UiO9rsUGV1A7vQ0WaN
	OJ4fyCtyQWlA2P7EX7XCx7HzZ3GNahUh1qp1dz4iLA0o9L3uV4HTa4/v02GPaolvt39kRG40Nk/
	SygIAfVThfnwKO6d4nw==
X-Received: from wmbh20.prod.google.com ([2002:a05:600c:a114:b0:47d:586e:2b7b])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:811a:b0:480:1dc6:2686 with SMTP id 5b1f17b1804b1-4801eac0cfcmr114218055e9.13.1768826122871;
 Mon, 19 Jan 2026 04:35:22 -0800 (PST)
Date: Mon, 19 Jan 2026 12:35:21 +0000
In-Reply-To: <20260119-thundering-tested-robin-4be817@houat>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260107-clk-type-state-v3-0-77d3e3ee59c2@collabora.com>
 <20260107-clk-type-state-v3-1-77d3e3ee59c2@collabora.com> <20260108-delectable-fennec-of-sunshine-ffca19@houat>
 <98CD0BF6-3350-40B9-B8A9-F569AE3E3220@collabora.com> <20260119-thundering-tested-robin-4be817@houat>
Message-ID: <aW4lCfUyumOKRRJm@google.com>
Subject: Re: [PATCH v3 1/3] rust: clk: use the type-state pattern
From: Alice Ryhl <aliceryhl@google.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Danilo Krummrich <dakr@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Drew Fustini <fustini@kernel.org>, 
	Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	"Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=" <ukleinek@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org, 
	linux-clk@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 11:45:57AM +0100, Maxime Ripard wrote:
> On Thu, Jan 08, 2026 at 11:14:37AM -0300, Daniel Almeida wrote:
> > > For example, it's quite typical to have (at least) one clock for the =
bus
> > > interface that drives the register, and one that drives the main
> > > component logic. The former needs to be enabled only when you're
> > > accessing the registers (and can be abstracted with
> > > regmap_mmio_attach_clk for example), and the latter needs to be enabl=
ed
> > > only when the device actually starts operating.
> > >=20
> > > You have a similar thing for the prepare vs enable thing. The differe=
nce
> > > between the two is that enable can be called into atomic context but
> > > prepare can't.
> > >=20
> > > So for drivers that would care about this, you would create your devi=
ce
> > > with an unprepared clock, and then at various times during the driver
> > > lifetime, you would mutate that state.

The case where you're doing it only while accessing registers is
interesting, because that means the Enable bit may be owned by a local
variable. We may imagine an:

    let enabled =3D self.prepared_clk.enable_scoped();
    ... use registers
    drop(enabled);

Now ... this doesn't quite work with the current API - the current
Enabled stated owns both a prepare and enable count, but the above keeps
the prepare count in `self` and the enabled count in a local variable.
But it could be done with a fourth state, or by a closure method:

    self.prepared_clk.with_enabled(|| {
        ... use registers
    });

All of this would work with an immutable variable of type Clk<Prepared>.

> > > AFAIU, encoding the state of the clock into the Clk type (and thus
> > > forcing the structure that holds it) prevents that mutation. If not, =
we
> > > should make it clearer (by expanding the doc maybe?) how such a patte=
rn
> > > can be supported.
> > >=20
> > > Maxime
> >=20
> > IIUC, your main point seems to be about mutating the state at runtime? =
This is
> > possible with this code. You can just have an enum, for example:
> >=20
> > enum MyClocks {
> >     Unprepared(Clk<Unprepared>),
> >     Prepared(Clk<Prepared>),
> >     Enabled(Clk<Enabled>),=20
> > }

I believe you need an extra state if the state is not bound to the scope
of a function:

enum MyClocks {
    Unprepared(Clk<Unprepared>),
    Prepared(Clk<Prepared>),
    Enabled(Clk<Enabled>),=20
    Transitioning,
}

since mem::replace() needs a new value before you can take ownership of
the existing Clk value.

> > In fact, I specifically wanted to ensure that this was possible when wr=
iting
> > these patches, as it=E2=80=99s needed by drivers. If you want to, I can=
 cover that in
> > the examples, no worries.
>=20
> Yes, that would be great. I do wonder though if it wouldn't make sense
> to turn it the other way around. It creates a fair share of boilerplate
> for a number of drivers. Can't we keep Clk the way it is as a
> lower-level type, and crate a ManagedClk (or whatever name you prefer)
> that drivers can use, and would be returned by higher-level helpers, if
> they so choose?
>=20
> That way, we do have the typestate API for whoever wants to, without
> creating too much boilerplate for everybody else.

I think that if you still want an API where you just call enable/disable
directly on it with no protection against unbalanced calls, then that
should be the special API. Probably called RawClk and functions marked
unsafe. Unbalanced calls seem really dangerous and use should not be
encouraged.

The current type-state based API is the least-boilerplate option for
drivers that exist today.

Alice

