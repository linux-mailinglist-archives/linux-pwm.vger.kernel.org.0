Return-Path: <linux-pwm+bounces-9242-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +EWFIKIYIWqL/AAAu9opvQ
	(envelope-from <linux-pwm+bounces-9242-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 04 Jun 2026 08:18:10 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CECC063D364
	for <lists+linux-pwm@lfdr.de>; Thu, 04 Jun 2026 08:18:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=r7Y7EfoO;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9242-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9242-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=mailbox.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3CC530022A1
	for <lists+linux-pwm@lfdr.de>; Thu,  4 Jun 2026 06:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711FE3D47B7;
	Thu,  4 Jun 2026 06:11:20 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA7D3D5248;
	Thu,  4 Jun 2026 06:11:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780553480; cv=none; b=qIk0exY5A7KzZfyDkhk+sFfhr0T+2uin22dsB9mjr82E8p8bYUXapLDRIN/Zh5qGarnLDuGBoqs7WK/MI9RLwQRDKgHUSdp+EEv8tjz4h+yxX2Ta5gR0ZuRBtndHY6y3J8T9N0D7FiDQGLLlyjym9RKXIzA736pvKMwwf3VNyR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780553480; c=relaxed/simple;
	bh=CBYbMz5FezKMMS2rtw4TjIxhbup+kPw5i/fGW3S+F4U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tqxuKd0lGHiH4xB8iwtTms7E6C4oYEMPxMONwK/iiaNzKRNm2dbOruwTbplDN2hWFB5s/J+ZeMM3wdcQk+QHixthel6NP4kQi98b9EX5FrX7Yohw4vtkVAMOOQLht2txCIJ5TRwPSZYfDTdfyeKQfPdQ7+j8b3Fh+1WAZ2qXoCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=r7Y7EfoO; arc=none smtp.client-ip=80.241.56.151
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gWDhy3TK1z9tYd;
	Thu,  4 Jun 2026 08:11:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1780553474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CBYbMz5FezKMMS2rtw4TjIxhbup+kPw5i/fGW3S+F4U=;
	b=r7Y7EfoOtMPl3kOml41+BEJJVGO63Tm/g1xvvvFAu24KxYiqLXDzSVVAfyzouEAbM3uO1c
	yJDB1+Z6RadzKaCn3XAjDE6a1ztN83lAYsU5XuI4zQEQZHaQB1iW3x0LrW3bHn708Lx2XN
	kA5ZUwKc29oC5WzcD/spCQ8gaS/XDysZSZ33W1/c3bu36mlipkdfGuhlBRL7C5tCLNv22c
	mKhUsgK125Tspi/48lcNWSO8dIV0K+8xXa4LLrvG/2s4WzFENqSUU1PpzMR14OlunV9/pY
	PkiXiX6ohvHINxue6aevNjoUDLDCwtaMO+wCM4SB9dgZfWxcL0Tze6p/cyMl0Q==
Message-ID: <50095a4839fdaaf9522a2ccf26d19e3f7bb98866.camel@mailbox.org>
Subject: Re: [PATCH 0/2] rust: clk: Add ExclusiveClk and use it in pwm-th1520
From: Maurice Hieronymus <mhi@mailbox.org>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>,  Miguel Ojeda <ojeda@kernel.org>, Boqun Feng
 <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,  =?ISO-8859-1?Q?Bj=F6rn?=
 Roy Baron	 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg	 <a.hindborg@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross	 <tmgross@umich.edu>, Danilo Krummrich
 <dakr@kernel.org>, Drew Fustini	 <fustini@kernel.org>, Guo Ren
 <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,  Michal Wilczynski
 <m.wilczynski@samsung.com>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
 <ukleinek@kernel.org>
Cc: linux-clk@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-pwm@vger.kernel.org
Date: Thu, 04 Jun 2026 08:11:06 +0200
In-Reply-To: <20260526-rate-exclusive-get-th1520-v1-0-34cf034e1764@mailbox.org>
References: 
	<20260526-rate-exclusive-get-th1520-v1-0-34cf034e1764@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: b569da53ff35be8ec8c
X-MBO-RS-META: okhenwescwhzk8xbub6q5gdfgio1gcqx
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mturquette@baylibre.com,m:sboyd@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:dakr@kernel.org,m:fustini@kernel.org,m:guoren@kernel.org,m:wefu@redhat.com,m:m.wilczynski@samsung.com,m:ukleinek@kernel.org,m:linux-clk@vger.kernel.org,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:linux-pwm@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[mhi@mailbox.org,linux-pwm@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-9242-lists,linux-pwm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_TO(0.00)[baylibre.com,kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,redhat.com,samsung.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhi@mailbox.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[mailbox.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailbox.org:mid,mailbox.org:dkim,mailbox.org:from_mime,mailbox.org:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CECC063D364

On Tue, 2026-05-26 at 19:04 +0200, Maurice Hieronymus via B4 Relay
wrote:
> Add a Rust binding for clk_rate_exclusive_get() /
> clk_rate_exclusive_put()
> and use it in pwm-th1520, which previously carried a TODO noting the
> missing binding.
>=20
> Based on pwm/for-next.
>=20
> Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
> ---
> Maurice Hieronymus (2):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rust: clk: Add ExclusiveClk wrapper for cl=
k_rate_exclusive_get
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pwm: th1520: Lock clock rate with clk_rate=
_exclusive_get
>=20
> =C2=A0drivers/pwm/pwm_th1520.rs |=C2=A0 8 +++---
> =C2=A0rust/kernel/clk.rs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 65
> +++++++++++++++++++++++++++++++++++++++++++++++
> =C2=A02 files changed, 68 insertions(+), 5 deletions(-)
> ---
> base-commit: 0e5e0db3e954b32a410ab4f74a4faac7a0e8889f
> change-id: 20260526-rate-exclusive-get-th1520-764a949de18e
>=20
> Best regards,

Any opinions on this patch?

