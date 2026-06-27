Return-Path: <linux-pwm+bounces-9435-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DWBwBmfVP2rtYgkAu9opvQ
	(envelope-from <linux-pwm+bounces-9435-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sat, 27 Jun 2026 15:51:35 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 621A16D20BB
	for <lists+linux-pwm@lfdr.de>; Sat, 27 Jun 2026 15:51:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=aEuj47Vk;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9435-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9435-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 197F830075EC
	for <lists+linux-pwm@lfdr.de>; Sat, 27 Jun 2026 13:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E015E340298;
	Sat, 27 Jun 2026 13:51:31 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DC43AEF3A;
	Sat, 27 Jun 2026 13:51:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782568291; cv=none; b=go1VQqZBufjGtRX+Z/HXQo23KbeBRix76v7osrAMxbirBG9ZGCr/hWrHTndZ++aTRrdkB6tQMcUCZ5ed7uWYroyLCeHRYdT47z+LHnLdJOHMPZf9wi1LOPIsvi8Hhmbx7L0YfJaqdPvzQHzSNFdfvFp4Yu/rP7qVFg0NIwh4+lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782568291; c=relaxed/simple;
	bh=Mp3HhFnT4Dn5tymA/irC+FaVJe06bKlOkR6goezdd/I=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=JA/ASURRJbw2H6Xc6ggFjiYk88QPq+CO1DXupRyGBk1USWmd4EF3HPpOqucV7JXpMXhLBhxKmejoTG9nQi32XEWGRJIuDUw44g1Fq06SZm1bZVtYgiKsJwjaUsNBLQ4AxAZskubl7NAxnYYpfhZWfXd936eG1XtnRfMeA1TxhDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aEuj47Vk; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D076D1F000E9;
	Sat, 27 Jun 2026 13:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782568289;
	bh=sZ7kMHOM/UusQZj89sqfP5ZckFAGYTvVqUakUPkV1uQ=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=aEuj47VkimWwfxAw2ZHAEfGEMZKtEMZ6WNWLDw+s3570SNvTizAl0ILVOI17i2A7L
	 AYudOp4K9ZVQti0oj3sp0GHOY0v4wg9twuayqUoC0Jz8/xQZJVi+PWbRe1rcVUcme0
	 23YyTXp4+62dyWzGDNBhKH2kKEDhJpJ9iOPCebxN+YhIKYhKB+vSuhClJuLo0ZnDcP
	 r1yz3J+EducA4gN7IrvtGppM1/3YMfsdh7g816Lb13ia+OwEkpPtg4uviqtif2YGp2
	 jYR49KtLMnGOr/62DXdveI87ZGy85POyH0eHlU74bdr0niz5rL0MFYESyY7yLZ7OX6
	 2Vh7Ryq7ce8VA==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 27 Jun 2026 15:51:23 +0200
Message-Id: <DJJVPW8H183T.1927SIBS40Z40@kernel.org>
Subject: Re: [PATCH v4 2/7] rust: types: introduce ForLt base trait for
 CovariantForLt
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <acourbot@nvidia.com>, <ecourtney@nvidia.com>,
 <m.wilczynski@samsung.com>, <david.m.ertman@intel.com>,
 <ira.weiny@intel.com>, <leon@kernel.org>, <daniel.almeida@collabora.com>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pwm@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260626183630.2585057-1-dakr@kernel.org>
 <20260626183630.2585057-3-dakr@kernel.org>
 <CANiq72=0OOgc6NtbpF0Ysdk3ytRWCGGbWg00u0Le2AzQmKGKxg@mail.gmail.com>
In-Reply-To: <CANiq72=0OOgc6NtbpF0Ysdk3ytRWCGGbWg00u0Le2AzQmKGKxg@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-9435-lists,linux-pwm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:acourbot@nvidia.com,m:ecourtney@nvidia.com,m:m.wilczynski@samsung.com,m:david.m.ertman@intel.com,m:ira.weiny@intel.com,m:leon@kernel.org,m:daniel.almeida@collabora.com,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:driver-core@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pwm@vger.kernel.org,m:rust-for-linux@vger.kernel.org,m:miguel.ojeda.sandonis@gmail.com,m:miguelojedasandonis@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[dakr@kernel.org,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-pwm@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,nvidia.com,samsung.com,intel.com,collabora.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 621A16D20BB

On Sat Jun 27, 2026 at 2:26 PM CEST, Miguel Ojeda wrote:
> If this goes in at the same time as the move (as I assume), then am I
> understanding it right that if someone else was using `ForLt`
> (trait/macro) things would either break at compile-time (which is OK)
> or, in the covariant type case with no `cast_ref()`, it would build,
> but someone could in principle have relied on `ForLt` providing the
> covariance guarantee in unsafe code?

If someone would have unsafely asserted covariance for ForLt it would break=
 at
compile-time like this:

	error[E0199]: implementing the trait `types::for_lt::ForLt` is not unsafe
	   --> rust/kernel/pci/io.rs:158:1
	    |
	158 | unsafe impl<const SIZE: usize> ForLt for Bar<'static, SIZE> {
	    | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	    |
	help: remove `unsafe` from this trait implementation
	    |
	158 - unsafe impl<const SIZE: usize> ForLt for Bar<'static, SIZE> {
	158 + impl<const SIZE: usize> ForLt for Bar<'static, SIZE> {
	    |
=09
	error: aborting due to 1 previous error

The only way this could silently break would be to use ForLt!(), but then d=
on't
use the explicitly provided safe cast_ref() method, and instead open-code i=
t
with an unsafe transmute() assuming covariance from ForLt!().

Even though very unlikely, I do however have an eye on whether another user=
 of
this API appears.

(The whole series also goes into a topic branch based on -rc1 anyway, so I =
can
also always provide a signed tag with just patch 1 and 2 based on -rc1 shou=
ld
the need arise.)

> Acked-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

> We could take the chance to add some missing intra-doc links, but I
> can add a good first issue.

I can add them on apply, or we leave them as good first issue, as you prefe=
r.

Thanks,
Danilo

