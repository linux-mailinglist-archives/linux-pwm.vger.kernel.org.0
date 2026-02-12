Return-Path: <linux-pwm+bounces-8124-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INHVBnfdjWna8AAAu9opvQ
	(envelope-from <linux-pwm+bounces-8124-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Feb 2026 15:02:31 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1829712E0F1
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Feb 2026 15:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3B9083010818
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Feb 2026 14:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35869357A55;
	Thu, 12 Feb 2026 14:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nkcGJitf"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C5B35BDDC
	for <linux-pwm@vger.kernel.org>; Thu, 12 Feb 2026 14:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770904946; cv=pass; b=Cl7YNI+Bz89kdQg/Qhv1E6Ht7wB43d1i0449SM1B7TFDTZSENONfWwesWzS+XyaFQJzGc0dEKOGEpOHwUhMOqo9PiIDY0W6vcPyBroRv/np4ZMv3UIbr+qnjBso/ooam1ng4U92LGdMEiFKvLN237o095o+FWiA8TNAXCczAkPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770904946; c=relaxed/simple;
	bh=JQdMCRkRLmIpXiZMZIzEwhlQnq6p9FnzGfa9kKgZNL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hYxznSLGB1CCynpCxlqh50zwJLcMCrpczSb+M6wawCgtnCfZ53g81f2bnscLVGyRuMrCC2p0lNHqQTfEXioN/ghm0B9lItIOgkeOGWcGKclruEARABKmtGMRbnYtwHQLjn8bHy0Rzmzoa5C3zjK5NzzGg0dQFHW4fXcAONOXvsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nkcGJitf; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4359249bbacso1468627f8f.0
        for <linux-pwm@vger.kernel.org>; Thu, 12 Feb 2026 06:02:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770904942; cv=none;
        d=google.com; s=arc-20240605;
        b=NCdB2VPqSahLAMb3Q7OeNn1JPR80lnlhxJRjvn1vufo8WmUD6ayqtr0XB+iylzUmET
         zRY34WKKy+oCdyiuSigFEMfriRym5emmelMq+r41+CNFCfNnCN8fHnYQ5GnQlITuOcWe
         M7IYGo2bWsmr3MBSdB1IsLiAurI8rQ8N0a/2wo9XJ3U9x/zqcRoq8zg684zMQE8Kw0OO
         6e3TWbUubTd6osrpcuO3uLOcVzVEL+vtsC/0L8x/ON5FVypUzimIG7CCA4/mHbxtrfBc
         pSD5I6gug4A/VED5+J6a2psXlkM2p2oEDdQQF590mr5llBYyKjWbrwISqOR9hDA0Xg0m
         TYvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JQdMCRkRLmIpXiZMZIzEwhlQnq6p9FnzGfa9kKgZNL0=;
        fh=/EB7vw9Do2hNpSTKVDW1kzBZ9tcRS1jwrb9a1e7YbPs=;
        b=MlP4hNTTFtF4lRZ7JzD+uXutf9L/GEx/smcu2Q4HR0jj61nGomfg+l5thI/bI/f8cN
         oxdFFu6Chcfh/hbBiWmO/l2iWooCm0KhKlmLMq9P0pAJWTDri79hH9MXMVBKCusRDuxM
         xQ4ncov+mICqz/9JqiZ9SrJ+7qBZ6n9g6j0B2BslvCWsm4lbWTEHxfLFdrECmA1WV4k4
         yMBzTK+Eau6KGbXDN+kydHj/Ph0FqtUd2pToQQSrdhwFM8iLCP5jJoRsrDF8UPIngODI
         NVoucY8YbGP1q66NyuOQR0VkfRcfTdFsOqxjCWuZ/u7THg7WXDtaEZDGSFUAgOU7/0eT
         O6YA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770904942; x=1771509742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQdMCRkRLmIpXiZMZIzEwhlQnq6p9FnzGfa9kKgZNL0=;
        b=nkcGJitfKN0G4OfJOrGGOkiJ4pep0Vj2H3zB2WHtir1skPnmZ2efKXXR4RuUFigA5R
         ELKCWtFkouZOXQnuR0tL7jhAx2Gr3bBXjvO6KWK6fH14AMZAPZj/G+9C9kA/EAS30mPk
         erAIoqjIVqObUE03pQFYFbtSuwZ7sFMM/8U8ZglXH1Q1vMITd/9c0J8am3BJd15dD3fJ
         qC8I4R+q8RlUzVM4NB7AN5O2+nKrj49RVgzuaf5a9dOCqcokCwbYzx6CPe5RLVR4uLMJ
         /rRAhxT6hS+Upz6G+tuDxAu8TfJXQvY9zC+jXEZRHS70MH9x4H4jBPbnxCT6tyPMqBQv
         7j0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770904942; x=1771509742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JQdMCRkRLmIpXiZMZIzEwhlQnq6p9FnzGfa9kKgZNL0=;
        b=gesougQ7qNf5Y1Nbio8ocv1cY1iFnf7a/LD3R7IstoxROGMJjDKTauUa9QxqMEYxdt
         f6ZZhuwVhyFAONSMGewNw/XPN4S8X1/x1Yhz8w26jM6Hfqwz41YN/37+b36A+b1BtiYz
         sAewgJm0lJ709OeJt8+OceR75tsHX2EtBsKjanMcntxIpQ0aW0M0MBbGrpz3smPp1Px8
         0NwF4Kkk0n11j1HEhYKmrtS4wAXKLShQAzht8WW1+NbUZ/BAsHUpPqfAhhsPidkmE5TF
         2DprIjHMuA3eSqoFEemBe7TPuyPQjxcGdPAzU1rAMf7xB6ANmgdHCkfMK+U9g8w5SYe/
         Au4w==
X-Forwarded-Encrypted: i=1; AJvYcCV4kh6s1miyWbJFIfNnBZtAd4aq9/9DOCAjvf8FC5v0uuexT3ZhHCxDjeiHh+e1ZkZgFFSOg0cxQFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKyMb7mmuwaXo5ULjsKJ0DXxv3SvLPSVz+iAjbCrtvRzUrEdPj
	H5pgiSrViGG8qCzq/nLRanwTu3BSXqOO0lTuz7nTBorgPdGXZoGHWPlE8htVGGG6e+Eu9G3MXji
	mpto2oY8L0AIDcYgui9V+4NaM94nSlv1XtZsuYUqK
X-Gm-Gg: AZuq6aIPn5lilewXWQWGWwq8EjvlNHE87A5uLz4FPM3dJhJKL1FrQz1DokN1EG8f6Iq
	NiyxbyXUKoUNGiVlGZjTEwQ4LPGSKb9ZhDdWu8woFxQXbVPRb0DfORtnpRC2ZAFTFmynx3CBk5C
	xIWLTX9LzywWmOdjZJVHA/xezX8CwxqvZV+7+07E5XgdpUP7qCagTpG9ODXajQEGqlKJm5/8oCH
	rUklofD39VEMtVssKKX2IWujZ297AVb5Mhd/sSoB1tDPl8Eu+2+5axMRgYM2uOWjqU/b2oDzsWk
	VBnl/QboysWEPD1xLrO4qKedWAEzjC1LZTiGITIMLYvUo3rH8JGb9t7vx/jt0eo2elNv/A==
X-Received: by 2002:a05:6000:208a:b0:435:932e:f924 with SMTP id
 ffacd0b85a97d-4378e6d8d92mr4583407f8f.2.1770904941572; Thu, 12 Feb 2026
 06:02:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119-weightless-pelican-of-anger-190db0@houat>
 <DFSN4FDCYHMW.3J3237PEBV2ZP@kernel.org> <20260122-majestic-masterful-jaguarundi-d0abde@houat>
 <2F3D3A40-6EF9-46FC-A769-E5A3AAF67E65@collabora.com> <20260204-nickel-seal-of-poetry-8fdefb@houat>
 <91A92D84-1F2E-45F3-82EC-6A97D32E2A78@collabora.com> <20260204-angelic-vermilion-beagle-fd1507@houat>
 <20260209105047.693f2515@fedora> <20260211-flawless-feathered-boar-0b87ad@houat>
 <CAH5fLgiQE7mJBpAxv6xTVKKFWadg2GdVe31hRM6gNk3Vah61MA@mail.gmail.com> <20260212-lumpy-uptight-petrel-cac725@houat>
In-Reply-To: <20260212-lumpy-uptight-petrel-cac725@houat>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 12 Feb 2026 15:02:09 +0100
X-Gm-Features: AZwV_Qg2-1q5B4F446nU29Cn7SlWuusys2TSQd4MD8qGMnFLRNj2Nk7LREIXN9Y
Message-ID: <CAH5fLghyg-QzT11gehvwTb2ii4FA-dkse=QtYD0Tc5MT5Dhd7A@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] rust: clk: use the type-state pattern
To: Maxime Ripard <mripard@kernel.org>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Danilo Krummrich <dakr@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Drew Fustini <fustini@kernel.org>, 
	Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org, 
	linux-pwm@vger.kernel.org, linux-clk@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8124-lists,linux-pwm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[30];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,linux-pwm@vger.kernel.org];
	FREEMAIL_CC(0.00)[collabora.com,kernel.org,linaro.org,linux.intel.com,suse.de,gmail.com,ffwll.ch,redhat.com,baylibre.com,garyguo.net,protonmail.com,umich.edu,vger.kernel.org,lists.freedesktop.org,lists.infradead.org];
	TAGGED_RCPT(0.00)[linux-pwm];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1829712E0F1
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 2:38=E2=80=AFPM Maxime Ripard <mripard@kernel.org> =
wrote:
>
> Hi Alice,
>
> On Thu, Feb 12, 2026 at 09:16:51AM +0100, Alice Ryhl wrote:
> > If you make the raw API unsafe, then that's okay but any use of an
> > unsafe API from a driver will receive very hard scrutiny.
>
> And that's totally fair to me. If drivers want to have a more optimal
> but potentially unsafe use of the API, then it should be flagged,
> documented and scrutinized.
>
> > Yes, there are occasionally good reasons to use unsafe from drivers,
> > but the entire point of this Rust exercise is to isolate unsafe code
> > outside of drivers as much as possible.
>
> So, aside from the risk of fuckups, are you concerned about something
> here? Do you expect that scrutiny to be constly on the maintenance side
> of things?

Well I do think it's mostly the risk of mistakes, yes.

> I guess what I'm asking is: except for the obvious "review" cost
> associated with it, why would that be a probleme if we have, say, a few
> dozen drivers using that unsafe API?

The reason I wouldn't really suggest the unsafe API is that, if I'm
the reviewer of said driver, then my review will be "just use a safe
API instead".

For example, if you really want explicit inc/dec calls for
convenience, we can make a safe API with a counter that returns an
error if you decrement more times than you have previously
incremented. Or if you prefer something else, I can think of several
other safe APIs.

> > If Daniel's proposal is inconvenient for some drivers, it would be far
> > better to have a third API that is both safe and convenient for those
> > drivers.
>
> Yeah, I guess I was expecting that one to come after we have a few
> unsafe drivers using it and we do need to consolidate / make it safe.

For most things, we implemented and used the safe API from the very
start. I'm not going to say there are never exceptions to that because
there *are* exceptions. But I don't really see why clk should be one
of them.

Alice

