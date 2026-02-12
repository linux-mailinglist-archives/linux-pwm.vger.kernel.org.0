Return-Path: <linux-pwm+bounces-8120-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOr1ETucjWlT5QAAu9opvQ
	(envelope-from <linux-pwm+bounces-8120-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Feb 2026 10:24:11 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E703212BD46
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Feb 2026 10:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 852B7308C2B2
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Feb 2026 09:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C012E2DB7A6;
	Thu, 12 Feb 2026 09:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tu8+kgNT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B21298CC4;
	Thu, 12 Feb 2026 09:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770888203; cv=none; b=SD+59MQQnQcgnNsw/eFyAvjUz1mGO0Ma8SeBvV8MPt0bUsB8de03j68FvS06et8E5Tv+hCSQAW3qSEUUBZnEgsXDeiW5M1H59K4Pdu6jMfrP0v//wFBnIuLGeC7HOvX89Z0/gB7sOsnxWpcYQwwWdpTnEnWWHd2i/uU5Ef+d4I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770888203; c=relaxed/simple;
	bh=Bd0vkkESwpTKZrM6Vj4/m5riIZawL87UTsB4+AHYnNg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=YMqr7qObt1zlBvRYqkD1Smt3gkTB53nMyg4y+hc9E7aNd19Oosts61RwgQQiyIQYWq9mH9M9qGCvHWhcfVKLFDs7+4CeQyKLTSkYJXkuKLoCk46nI+2KrDUq40H104wtQPuuoUYqT6FxXB8uMLtWvWifkgp86Z0AlqHqbzupntE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tu8+kgNT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A151BC19424;
	Thu, 12 Feb 2026 09:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770888203;
	bh=Bd0vkkESwpTKZrM6Vj4/m5riIZawL87UTsB4+AHYnNg=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=tu8+kgNTsI25fjEIsePbpW59UwxIvafjlf1pasP2zMu512PKeIgPylM/1OArUzV6T
	 vf/ycxcTeVizc6s4S3CnGwKJS4UDfVhHqOj4BHC3HIVQdyfjr3HbQTM+iPghBAGWsc
	 vUIzJH4quJs90SP6wD5GFiadmkJlIRKdmOjuYZx0KcOjryG0S5fq4+lhH3yrEEHP8n
	 WoFhQqjaPatTkRju6OnjsCIWDVehxF8EiDB8nrUdvlRm5PNubZV6+hPXWC4wtMYwqf
	 DeYNpb4bIDz8lByRQXpC/fVg8EmZfmZozq0mNVeOGBi5y/RK+4jkixgwHk15ZDoYK5
	 r0Q42I2WSLPXg==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Feb 2026 10:23:16 +0100
Message-Id: <DGCVH2B2OSFR.1C912TO7G7DGL@kernel.org>
Subject: Re: [PATCH v3 1/3] rust: clk: use the type-state pattern
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
References: <20260119-weightless-pelican-of-anger-190db0@houat>
 <DFSN4FDCYHMW.3J3237PEBV2ZP@kernel.org>
 <20260122-majestic-masterful-jaguarundi-d0abde@houat>
 <2F3D3A40-6EF9-46FC-A769-E5A3AAF67E65@collabora.com>
 <20260204-nickel-seal-of-poetry-8fdefb@houat>
 <91A92D84-1F2E-45F3-82EC-6A97D32E2A78@collabora.com>
 <20260204-angelic-vermilion-beagle-fd1507@houat>
 <20260209105047.693f2515@fedora>
 <20260211-flawless-feathered-boar-0b87ad@houat>
 <DGCAAE4YEDLO.299F5M641E90B@kernel.org>
 <20260212-obedient-faithful-koel-d8aaf6@houat>
In-Reply-To: <20260212-obedient-faithful-koel-d8aaf6@houat>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8120-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E703212BD46
X-Rspamd-Action: no action

On Thu Feb 12, 2026 at 8:59 AM CET, Maxime Ripard wrote:
> On Wed, Feb 11, 2026 at 05:47:09PM +0100, Danilo Krummrich wrote:
>> On Wed Feb 11, 2026 at 5:37 PM CET, Maxime Ripard wrote:
>> > I do think we can find a compromise though. Miguel suggested for examp=
le
>> > to make the current enable/prepare/disable/unprepare function unsafe,
>> > and that's totally reasonable to me.
>> >
>> > Then we can implement the "managed" clock version on that unsafe API,
>>=20
>> What do you mean with "managed" clock? Do you mean devres managed? If so=
, I
>> don't think there is any reason to switch to the unsafe API to be able t=
o
>> implement devres managed APIs (see also [1]).
>>=20
>> [1] https://lore.kernel.org/all/DFVW9MS5YLON.CVJDBYQKJ0P6@kernel.org/
>
> By that, I mean what Daniel has been proposing to achieve with this serie=
s.
>
>> > and we would end up with a "raw", unsafe, version kind of equivalent t=
o
>> > the one we have today, and where callers would have to justify why the=
ir
>> > usage of the API is actually safe, or the new, managed, variant that i=
s
>> > safe and can be easily used by most drivers.
>> >
>> > And we can call these RawClk vs Clk, or Clk vs ManagedClk, or whatever=
.
>> >
>> > How does that sound?
>>=20
>> What about we just wait until we have a user that really requires an uns=
afe API
>> for some reason? And if it never appears, even better. :)
>
> It works *today*.
>
> And the "oh but driver is using the API" is kind of ironic in the
> context of the Rust bindings which have globally been in that situation
> for years. You can't argue it both ways.

I can't remember ever advocating for merging code that does not have at lea=
st a
user in prospect.

> Either way, I'm not sure what the point of that submission was if you
> will just dismiss diverging opinions, including attempts to compromise.

Sorry -- I'm a bit confused here, since I did not submit this code.

I'm also not dismissing your opinion; I just have a different one.

In particular, I don't think we need an unsafe API until we see a concrete
example where the proposed safe API does not work (and no other safe API wo=
uld
work either).

Framing a difference in opinion as "dismissing diverging opinions" doesn't =
feel
fair to me.

> Do whatever you want, but it's really hard to root for you some times.

I'm starting to wonder if the mail is addressed to me in the first place.

Thanks,
Danilo

