Return-Path: <linux-pwm+bounces-8114-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +M1vJJiyjGlLsQAAu9opvQ
	(envelope-from <linux-pwm+bounces-8114-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Feb 2026 17:47:20 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0771A1264BA
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Feb 2026 17:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 38C5B3002E18
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Feb 2026 16:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989ED328B45;
	Wed, 11 Feb 2026 16:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HD0OiU/X"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DE121883E;
	Wed, 11 Feb 2026 16:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770828437; cv=none; b=cC90v+7DYBj5yKSTFsxsbmGT3f6YwgmI4qU+tl4gJHD0cbjwhV7u9RzhOL8MsL6gVF20aIwaxpTYtaqmLLg1u1baOeSC+MuYWAz6TyjWlwQF8c1HPGUnTBz+IiQB5y2IL9Q5yxCvVjGl/3pY5O1v7PhWMKFb1C909mA3vsObx3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770828437; c=relaxed/simple;
	bh=Axd6+FAx+svU01taZF9dBwsFOMn//n4UUyQCxOZzxLE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=bCZWXqyeC5LHibBmCwZ+ZnOSy9lxf/SjP21/Adyplvn4KCQx1ZC89qmDzfr1/Aya7mZzuUeIcAmiYm685Rz9tEFqZRzS6gBbztyYY6xP2OnPKU5GNuC99Phgjs64nvNL1q/6yXfitFBkY2rAl6fAIRmeYdINj39sjTl6CerBRMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HD0OiU/X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B434C4CEF7;
	Wed, 11 Feb 2026 16:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770828437;
	bh=Axd6+FAx+svU01taZF9dBwsFOMn//n4UUyQCxOZzxLE=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=HD0OiU/X9XdxIPhqSht4yMAhClrCU0+gnVun0CaAq5Yb9HV7dl3p8e2GOuzP81AKF
	 LjXvjZqzFdaux5+yWWAZsZ5CqvQqa6Ab+c99OfMXICjFS3xCHxzgWrR2iSI5CqvZt+
	 F8nVhOZTY8JCg42YOpMEXhZ5+3qYBGKaAM8OJvKHaTfEw4H0N5K6GQ37DacuCQs+sN
	 Yxah6cvl7+np9/YZHGg/IMr+itaSy5o5Ve4aiV0tSw+3DE+wpnfRoVaye1PMmcPa7K
	 WMlcMazd4fO80Pw3fNwBlK0HRNFHEHdmBgVbHVme1p+R2iaqooeeLy9/wuBwK+9tAE
	 S0nGTPkw+HslQ==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Feb 2026 17:47:09 +0100
Message-Id: <DGCAAE4YEDLO.299F5M641E90B@kernel.org>
Cc: "Boris Brezillon" <boris.brezillon@collabora.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Alice Ryhl" <aliceryhl@google.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "Viresh Kumar"
 <viresh.kumar@linaro.org>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Thomas Zimmermann"
 <tzimmermann@suse.de>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Drew Fustini" <fustini@kernel.org>, "Guo Ren"
 <guoren@kernel.org>, "Fu Wei" <wefu@redhat.com>,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, "Michael
 Turquette" <mturquette@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-riscv@lists.infradead.org>,
 <linux-pwm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
To: "Maxime Ripard" <mripard@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v3 1/3] rust: clk: use the type-state pattern
References: <518D8B09-B9A1-4DB4-85CD-37A2DD3D5FB1@collabora.com>
 <DFSLCI9U4NCW.2HI2UPUI7G134@kernel.org>
 <20260119-weightless-pelican-of-anger-190db0@houat>
 <DFSN4FDCYHMW.3J3237PEBV2ZP@kernel.org>
 <20260122-majestic-masterful-jaguarundi-d0abde@houat>
 <2F3D3A40-6EF9-46FC-A769-E5A3AAF67E65@collabora.com>
 <20260204-nickel-seal-of-poetry-8fdefb@houat>
 <91A92D84-1F2E-45F3-82EC-6A97D32E2A78@collabora.com>
 <20260204-angelic-vermilion-beagle-fd1507@houat>
 <20260209105047.693f2515@fedora>
 <20260211-flawless-feathered-boar-0b87ad@houat>
In-Reply-To: <20260211-flawless-feathered-boar-0b87ad@houat>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8114-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[collabora.com,google.com,kernel.org,linaro.org,linux.intel.com,suse.de,gmail.com,ffwll.ch,redhat.com,baylibre.com,garyguo.net,protonmail.com,umich.edu,vger.kernel.org,lists.freedesktop.org,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0771A1264BA
X-Rspamd-Action: no action

On Wed Feb 11, 2026 at 5:37 PM CET, Maxime Ripard wrote:
> I do think we can find a compromise though. Miguel suggested for example
> to make the current enable/prepare/disable/unprepare function unsafe,
> and that's totally reasonable to me.
>
> Then we can implement the "managed" clock version on that unsafe API,

What do you mean with "managed" clock? Do you mean devres managed? If so, I
don't think there is any reason to switch to the unsafe API to be able to
implement devres managed APIs (see also [1]).

[1] https://lore.kernel.org/all/DFVW9MS5YLON.CVJDBYQKJ0P6@kernel.org/

> and we would end up with a "raw", unsafe, version kind of equivalent to
> the one we have today, and where callers would have to justify why their
> usage of the API is actually safe, or the new, managed, variant that is
> safe and can be easily used by most drivers.
>
> And we can call these RawClk vs Clk, or Clk vs ManagedClk, or whatever.
>
> How does that sound?

What about we just wait until we have a user that really requires an unsafe=
 API
for some reason? And if it never appears, even better. :)

