Return-Path: <linux-pwm+bounces-9270-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vd5xB/mkJmqxaQIAu9opvQ
	(envelope-from <linux-pwm+bounces-9270-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 08 Jun 2026 13:18:17 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3916A655944
	for <lists+linux-pwm@lfdr.de>; Mon, 08 Jun 2026 13:18:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=collabora.com header.s=zohomail header.b=XUGTWHrn;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9270-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9270-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=collabora.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C0376300118E
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Jun 2026 11:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE0634107D;
	Mon,  8 Jun 2026 11:09:03 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55DF3A1C9;
	Mon,  8 Jun 2026 11:09:01 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780916943; cv=pass; b=DXqt2aq9PDw4ixuojwaXi7IbeIth2tps57uw+sxrrv99fVPmwDCZirW+rISDY5DuU1F82B+Ae7gSSgkDBg5ynyO9XVm3qRcZMLFqAfd6yZxe1grWAXn/QHNOkguCtJqxKMHCU6Q48CVwvNB9t2lxYs56idEAUy5a1l/whuhG0Qc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780916943; c=relaxed/simple;
	bh=/tb7o9YfkkFDiV4LOWCcRHi0hE5qmxAuEKieOm6ZjM4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=DhcCGkzbux5QtNURONniIDxE011gRZZZCPUQ9oMewRkffkKpDyfi6QRZDkFXxTvwOMIL18k2MrBA1RFGfO3ZucOlNy4X2CNx0aglM1pAzphgYU/Do0csIxcWrEWkncs/aaC/z19XkqdxKcbw7cqcGL5kzmhjwOEy5soSGPAoK1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=XUGTWHrn; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal: i=1; a=rsa-sha256; t=1780916906; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=V77ohDi1FU5qxxWvH1DRlpHx1d9WApt+1XamxW/ICSlhNOMRJJN8mlsDRjM7Hb1QScMIugYflwgv+/w4KK2xaJiCpmo8Z0DtBAvBzJCyoV5ALBVxAJKM8LbVXiVvvcLxFhZ1Qhed0ho/Icg5gctGqt9zydRhZ4NCH2dL4kdVsOQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1780916906; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/tb7o9YfkkFDiV4LOWCcRHi0hE5qmxAuEKieOm6ZjM4=; 
	b=Zi5G9hxbP9Yi5Me8h0nhyCvq3v0pcxHHCF0KfYJ9GvBunaLDhwzHyIAwzG6dCMgLuYwWl9JbUjASPu5A1O+tfLjZ+vn3VTaVW70NirKcCd+go6Fyf2Hn2vv+fPG5vg1FrnaHsebU3oebSdXVQF1zU24e7DmizBJP+5aAJ6P63ac=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780916906;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=/tb7o9YfkkFDiV4LOWCcRHi0hE5qmxAuEKieOm6ZjM4=;
	b=XUGTWHrn0sgfDLuXq/gh6I9o9DPgvj+iImqlEtKZz50yGBUGuYMoGASst237rYA5
	bwnqdwuGBWCqvuHfXQ/jgTF77oyI5aZMd0QmkRIUq+KYVj2ZH+fWjdUeXZ4qbZ9Eec8
	XK33KVVUfuhepLk+GSg4HxQWeV5OVBtwOLa3+4fQ=
Received: by mx.zohomail.com with SMTPS id 1780916903731652.9798968643184;
	Mon, 8 Jun 2026 04:08:23 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v2 0/2] rust: clk: Add ExclusiveClk and use it in
 pwm-th1520
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260605-rate-exclusive-get-th1520-v2-0-695640bf7249@mailbox.org>
Date: Mon, 8 Jun 2026 08:08:04 -0300
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Drew Fustini <fustini@kernel.org>,
 Guo Ren <guoren@kernel.org>,
 Fu Wei <wefu@redhat.com>,
 Michal Wilczynski <m.wilczynski@samsung.com>,
 =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 linux-clk@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org,
 linux-pwm@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <140FE1B3-73CA-45EA-B978-648A1A48B577@collabora.com>
References: <20260605-rate-exclusive-get-th1520-v2-0-695640bf7249@mailbox.org>
To: Maurice Hieronymus <mhi@mailbox.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9270-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mturquette@baylibre.com,m:sboyd@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:dakr@kernel.org,m:fustini@kernel.org,m:guoren@kernel.org,m:wefu@redhat.com,m:m.wilczynski@samsung.com,m:ukleinek@kernel.org,m:linux-clk@vger.kernel.org,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:linux-pwm@vger.kernel.org,m:mhi@mailbox.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[daniel.almeida@collabora.com,linux-pwm@vger.kernel.org];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,redhat.com,samsung.com,vger.kernel.org,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.almeida@collabora.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[collabora.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	APPLE_MAILER_COMMON(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3916A655944

Hi Maurice,

There is some ongoing work to convert Clks to a type state pattern [0]

I wonder if you would be willing to rebase on top of that?
I can push a new version if so.

It seems like we are mostly in agreement with that series, and only
a few nits are missing.

=E2=80=94 Daniel

[0]: =
https://lore.kernel.org/rust-for-linux/20260107-clk-type-state-v3-0-77d3e3=
ee59c2@collabora.com/=

