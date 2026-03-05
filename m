Return-Path: <linux-pwm+bounces-8176-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAFVKiFCqWkZ3gAAu9opvQ
	(envelope-from <linux-pwm+bounces-8176-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 05 Mar 2026 09:43:13 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3514320DA1B
	for <lists+linux-pwm@lfdr.de>; Thu, 05 Mar 2026 09:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1BB283001BF7
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Mar 2026 08:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB2B374E66;
	Thu,  5 Mar 2026 08:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OU7o98Qc"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83764374E5C
	for <linux-pwm@vger.kernel.org>; Thu,  5 Mar 2026 08:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772700189; cv=none; b=BjxQMnvZ1ymz6ERRCsVbIQ2u+7mdC1HZ2KKCGmHVlEjFGNWd7RzxqxweqE9eRGLWtVQugrlINMEOEPZ5jEKSb772vuOlNQv5R7C4txXMN/HVp+0AmESFDW9x1CIRGVgR2onFNnuv0hk9TRNtA9lH3ZOF1lyDicGAqMLzjjPqqiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772700189; c=relaxed/simple;
	bh=mbnSWoGtpVXDY2O/y7CT2oXvHtcIcvxxDazvTWMlsag=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j1htEwRMZZX/7lIezJlkARSaqrAF++3Pb7qb1N3lHkQcdvTvym352fbWqgLFg1oEutIWM1fuEnPlZQbl0b9yjeFQ9XMnFqDXH22GI3EaCoptxVjf4Z+rw8rWHfdkoDkSYnrvC9i6kLtBZSLQl6q/BEH2mTvhW394liLd1XInvcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OU7o98Qc; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4836cc0b38eso78933295e9.2
        for <linux-pwm@vger.kernel.org>; Thu, 05 Mar 2026 00:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772700185; x=1773304985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ImdwXMFzfOswNPEOQHnijbZ5BxVnmvmjujol0/tafME=;
        b=OU7o98QcuPVQYKb9DcL7V1O+c1AaYuWMz390SqtiMJOIli46Gr7spJayvSgOzH1Rc8
         /eOfoKZYvJ4aeZimQ5X2CoB5rAKThlUyfPSaG+BMTrn9J7ytSTXrT7llVCcx5zBz4Jn6
         30irGrazQvupfYSz6xfQg73/rigoijIQC8vievagVrIGF1OlaVeznra1DyxMlhJp++6Y
         2R/I3u+oGM1In7960b1S+n3cmgoWETLXsOSaGEfun8QklPw6jeifKw32QGdwvF5uqmB6
         /Pzfe9v9eSKaHpSstLupNYsf6LhZmRAum64bUjjgCiBxV90LQUtnvZx9bMlExTIKyVlz
         bM3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772700185; x=1773304985;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ImdwXMFzfOswNPEOQHnijbZ5BxVnmvmjujol0/tafME=;
        b=wPbbGriGTpbPLqcNJKTgO38hgqlWIsXNBgkxjir914z5MDN5eizktgIRyUWUyU+u+K
         Ggf3xJsplN3zrNK4keHfEY62jcdeRab4k7V54QcST83oro7YBJYW4Dwm1aT0oLAepAef
         QycPMXBIsaw7FYiVQEGDq2Nyuy6dxsCfVdzCl8gRkvImtvFoqPmO5e+xbe1+5XjA5dX1
         AHXstnZwsj8a/5ep1MSH4LdxyZI/PjdBnCQWttHDg8zuGp8NqUDy2quw9TFRdOgmhFQ1
         qojQUcVuBAe4Zngh/WWzZFpw72TcYrpLh9J+ATxM3Ydyn4QlQfGJS8rX5MTxXt+omvU4
         /EZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxjpPlxXdp/9zjzdtxGTuikVekX61e74UyqpNPDnijP8YdV8FbsZC1E939GIhbQEotA5GW6j8h3y4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiIK3wBPZE/HVFuM2otCVJhrbqTg5T28JUjpXlpRsVUBc7IPw1
	sXv5T0s/07clz88u35psoIA34xDI1iOA6l3tUEWSMPgpJv6k4wR45vRhCFsq8YN3RkOj+48mjoY
	KTuVsV89CI19Yoy82ww==
X-Received: from wmj21.prod.google.com ([2002:a05:600c:255:b0:480:69c2:3949])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3e8f:b0:477:73e9:dc17 with SMTP id 5b1f17b1804b1-485198d8b81mr83642225e9.35.1772700184640;
 Thu, 05 Mar 2026 00:43:04 -0800 (PST)
Date: Thu, 5 Mar 2026 08:43:03 +0000
In-Reply-To: <aak9ZBJenK1DSCEt@monoceros>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260113-clk-send-sync-v4-0-712bc7d94a79@google.com>
 <CGME20260113151335eucas1p157cd966c5f0f4e477fb11272810a0ae8@eucas1p1.samsung.com>
 <20260113-clk-send-sync-v4-3-712bc7d94a79@google.com> <90657b83-1cff-4c7d-adde-9b560c2be7c2@samsung.com>
 <3cfeounnaphhezvjpz5igswml6iu3b6jhwhjn2g4ziimjdoefi@ge4ezxx6jxlr> <aak9ZBJenK1DSCEt@monoceros>
Message-ID: <aalCF0Egy6gWXdBK@google.com>
Subject: Re: [PATCH v4 3/3] pwm: th1520: remove impl Send/Sync for Th1520PwmDriverData
From: Alice Ryhl <aliceryhl@google.com>
To: "Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=" <ukleinek@kernel.org>
Cc: Stephen Boyd <sboyd@kernel.org>, Michal Wilczynski <m.wilczynski@samsung.com>, 
	Michael Turquette <mturquette@baylibre.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	linux-clk@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 3514320DA1B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8176-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,samsung.com,baylibre.com,linux.intel.com,redhat.com,linaro.org,gmail.com,garyguo.net,protonmail.com,umich.edu,collabora.com,vger.kernel.org,lists.freedesktop.org,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 09:24:33AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> On Tue, Jan 20, 2026 at 09:48:48AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > On Mon, Jan 19, 2026 at 10:45:56PM +0100, Michal Wilczynski wrote:
> > > On 1/13/26 16:12, Alice Ryhl wrote:
> > > > Now that clk implements Send and Sync, we no longer need to manuall=
y
> > > > implement these traits for Th1520PwmDriverData. Thus remove the
> > > > implementations.
> > >=20
> > > I thought this was already merged :-).
> > >=20
> > > Reviewed-by: Michal Wilczynski <m.wilczynski@samsung.com>
> >=20
> > If I understand correctly this patch 3 depends on the first patch of
> > this series so I cannot pick it up via the pwm tree *now*. There is
> > another patch pending for the th1520 PWM driver, but as of now git seem=
s
> > to cope well when merging the pwm's tree for-next with this patch.  So
> > it's fine for me if the series is picked up for 6.20-rc1 via the clock
> > tree.
>=20
> That didn't happen (with s/6.20/7.0/), so this patch is still open in my
> todo list. Is the first patch still considered for the clk subsystem?
> What is the plan for the pwm patch?

It's been on my todo list to try and contact Stephen to see if he can
take these patches, or if he is okay with them going through another
tree, but I have not gotten around to it. He has not replied on the list
to any version of this series.

Alice

