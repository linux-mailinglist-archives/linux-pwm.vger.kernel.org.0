Return-Path: <linux-pwm+bounces-9212-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2AryBym/Gmpk8AgAu9opvQ
	(envelope-from <linux-pwm+bounces-9212-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sat, 30 May 2026 12:42:49 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8347560C320
	for <lists+linux-pwm@lfdr.de>; Sat, 30 May 2026 12:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 62C3B3020EBC
	for <lists+linux-pwm@lfdr.de>; Sat, 30 May 2026 10:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5433A5E99;
	Sat, 30 May 2026 10:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="H0TpCUQp"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F49A399340;
	Sat, 30 May 2026 10:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780137689; cv=none; b=eW+UyEHER8zmRVfzjEVa4i2QjxJeAkOUjeEBz3yebzeqBAGt2Mb79lziHVrgwDt9qnoHxmP67fgHZhgjKZblT/HBQx4i9E5ZSgHOvAw74tRT9RP1qIs9FTV4WK5aJmgjQYwHDublJDQR2xDfW4iVAtLC4zL0H1R+EfoVtjjLtAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780137689; c=relaxed/simple;
	bh=8rLJAHarAeoUMg59HygnNpa2WBuECEEdnuMIXACLS/w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KPs5jiGXZS78mIEYmgAdknyzguEUgOHv61apatqhMOtHJUOmg4e2xqidDAZwA1Vh5zSfvYiEbt07lZ1TE9jPP22VwBRXo7x8DREHPd33KsLwUGz8g4svPb+Bx2ox1wVdeGxWoR6JbhApRMlCuX9HH3onzyQIOpLf30EIfaNLB0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=H0TpCUQp; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gSGws0fwFz9tpD;
	Sat, 30 May 2026 12:41:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1780137677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8rLJAHarAeoUMg59HygnNpa2WBuECEEdnuMIXACLS/w=;
	b=H0TpCUQpQ+Dr9Pvt+Ml8uhSOYfjX7mn/HBGzH+0yuyngapzV0xhIUrnYMAJdEkZKOPmlE6
	6bPrr74+kesJtiZhnCMR2utspDjmRTh0V+y5YUqlFI1v2Oao5U1EtfdABClzF15QtEJk1H
	gxs1yT4k1HqDfsZcZ5LF3UFqCT1yqPl0ZC1UssqQDoF3k+s/I20VrYyJ/NkIzAchOlA9Km
	+BHM0PmW/A4hu4H2wR5TS8zwNjY9QHaO6MUIZ5rSR7u6TxQzHjKTYedyOPfyNtpGWBOQR1
	aZiJ4vizjDVX1Ne/E9/IYcBGGe3xJzw3AnG3KrksPAaN8YGjmRcmZRr1ZX+vww==
Message-ID: <47062326dcf87b605cf4def9835394551645caa5.camel@mailbox.org>
Subject: Re: [PATCH RESEND] pwm: th1520: Remove requirement for
 mul_u64_u64_div_u64_roundup
From: Maurice Hieronymus <mhi@mailbox.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>, Drew Fustini	
 <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei
 <wefu@redhat.com>,  Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=	
 <ukleinek@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng	
 <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, =?ISO-8859-1?Q?Bj=F6rn?=
 Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg	 <a.hindborg@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross	 <tmgross@umich.edu>, Danilo Krummrich
 <dakr@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Date: Sat, 30 May 2026 12:41:08 +0200
In-Reply-To: <58245ce0-7271-4b07-b866-0037ff68d92c@samsung.com>
References: 
	<CGME20260525131112eucas1p1d7e4836f71c81686e1f71e4007e344ec@eucas1p1.samsung.com>
		<20260525-pwm-th1520-fix-v1-1-814e537c6812@mailbox.org>
		<8857fc45-b787-4661-b27b-8976e655f7c9@samsung.com>
		<1f550af5b8d1fa2aaa9936d5b0010c156e0cb455.camel@mailbox.org>
	 <58245ce0-7271-4b07-b866-0037ff68d92c@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: w7y49kc766z4x146mxmm6op3a9e9kqhq
X-MBO-RS-ID: 66b95ce410648b2b261
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[samsung.com,kernel.org,redhat.com,garyguo.net,protonmail.com,google.com,umich.edu];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9212-lists,linux-pwm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhi@mailbox.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[mailbox.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mailbox.org:mid,mailbox.org:dkim]
X-Rspamd-Queue-Id: 8347560C320
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

>=20
> Apologies, I have to correct my statement from before after
> discussing
No worries!
> with Uwe. The reason the macro was used in the mentioned driver is
> NOT
> that PWM controllers have 64-bit registers - Uwe isn't aware of that
> being a real pattern either, and I was inferring it from the code
> rather
> than from hardware reality. The actual reason the macros get used
> isn't
> unified across drivers and we should pin that down separately rather
> than block your patch on it.
>=20
> So please hold off on the Rust helper for now - your initial patch
> might
> be the right direction.
>=20
Is there any further conclusion which direction is right? Can we merge
my patch, does it need some change or are we going down the road with
the Rust helpers?

Thanks!

Maurice
> >=20
> > Maurice
> >=20
>=20
> Best regards,

