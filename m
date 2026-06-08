Return-Path: <linux-pwm+bounces-9272-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0RWiIF8tJ2rvswIAu9opvQ
	(envelope-from <linux-pwm+bounces-9272-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 08 Jun 2026 23:00:15 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8506665A956
	for <lists+linux-pwm@lfdr.de>; Mon, 08 Jun 2026 23:00:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=t+EDzGgf;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9272-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9272-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=mailbox.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 27BF8300CBED
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Jun 2026 21:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E473E3AEB29;
	Mon,  8 Jun 2026 21:00:00 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722B93A9628;
	Mon,  8 Jun 2026 20:59:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780952400; cv=none; b=kmXzPK+qJbCTUBe6g1t9IRIYUYWJSKOPz6r9YX27r582QuNTdXgmRBDpvRcs4QjnR+j9VTeGBTSyNDkcrmzWAwSg+fkKK7ApEIHg6OWAz6rJJzZ2kQfYQBWxsVoQedO5MoJXCSrKPKzAYYbB2aEs0l+DJ0csxk8Fmm6qo1mJbVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780952400; c=relaxed/simple;
	bh=U+OfQweIOD1gShe2+QuxUov9IeGEl5ViBFprqcyr6fc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WkqZd7NvIe7UpGiCH5sRUcThSo7NTl2zOwSn/rEm5Hb+NSQCuIzQ4+LjgrlowTaaYOp5McjCwuYtc2pbt/rA7eP7FRHT0VvtvoFNFmnVXR+a3+TYwmPr3H7XjDaz9xDUW+tNYxHwUzVCPs4ALK7zxKcFUp8tpldwEButsJX8kzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=t+EDzGgf; arc=none smtp.client-ip=80.241.56.151
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gZ4DP2HrGz9tgY;
	Mon,  8 Jun 2026 22:59:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1780952389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U+OfQweIOD1gShe2+QuxUov9IeGEl5ViBFprqcyr6fc=;
	b=t+EDzGgfSG0GZyqmiau5dOYEo2iquULVn1WY5kaoOiTUQLbnyd+XOiLbbHhU+PSqDz+LPx
	F0x3PnkQYGji0n60ArWtDXnCapCtxIyEUvslOaayKtf8gwY3CE85Fv4MQFF5I5ZxLcu+8d
	dHPTHBD10/43Cy7LXLo+kZTOxlV5nz5hrDHZ2nCADHPrKwYGhcUmk2aWXIo/QD93eMTTaL
	WuLTjOuQ0l2QcUBjij1awUA5Tso8H/7a/35ZEHxSRl2utkFR5hqIN4u5hwzsaA70lsrfVi
	LCiDpv/KkEhuBwur7VfmQpGwXDP7sr7usxqhJs+o93vDOqiIZ+VXFj/HCaSUsQ==
Message-ID: <e99b78d7aea835ab2960517e0c308b08538146ea.camel@mailbox.org>
Subject: Re: [PATCH v2 0/2] rust: clk: Add ExclusiveClk and use it in
 pwm-th1520
From: Maurice Hieronymus <mhi@mailbox.org>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>,  Miguel Ojeda <ojeda@kernel.org>, Boqun Feng
 <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,  =?ISO-8859-1?Q?Bj=F6rn?=
 Roy Baron	 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg	 <a.hindborg@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross	 <tmgross@umich.edu>, Danilo Krummrich
 <dakr@kernel.org>, Drew Fustini	 <fustini@kernel.org>, Guo Ren
 <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,  Michal Wilczynski
 <m.wilczynski@samsung.com>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
 <ukleinek@kernel.org>, 	linux-clk@vger.kernel.org,
 rust-for-linux@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, 	linux-pwm@vger.kernel.org
Date: Mon, 08 Jun 2026 22:59:36 +0200
In-Reply-To: <140FE1B3-73CA-45EA-B978-648A1A48B577@collabora.com>
References: 
	<20260605-rate-exclusive-get-th1520-v2-0-695640bf7249@mailbox.org>
	 <140FE1B3-73CA-45EA-B978-648A1A48B577@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 4419fd374748a8af19f
X-MBO-RS-META: 8quwtpkkm6yeim94go9bw3qkw9e67cnd
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9272-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:daniel.almeida@collabora.com,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:dakr@kernel.org,m:fustini@kernel.org,m:guoren@kernel.org,m:wefu@redhat.com,m:m.wilczynski@samsung.com,m:ukleinek@kernel.org,m:linux-clk@vger.kernel.org,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:linux-pwm@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[mhi@mailbox.org,linux-pwm@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,redhat.com,samsung.com,vger.kernel.org,lists.infradead.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhi@mailbox.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[mailbox.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8506665A956

On Mon, 2026-06-08 at 08:08 -0300, Daniel Almeida wrote:
> Hi Maurice,
>=20
> There is some ongoing work to convert Clks to a type state pattern
> [0]
>=20
> I wonder if you would be willing to rebase on top of that?
> I can push a new version if so.
Definitely! Just let me know when you pushed a new version. Thanks for
that.
>=20
> It seems like we are mostly in agreement with that series, and only
> a few nits are missing.
>=20
> =E2=80=94 Daniel
>=20
> [0]:
> https://lore.kernel.org/rust-for-linux/20260107-clk-type-state-v3-0-77d3e=
3ee59c2@collabora.com/

