Return-Path: <linux-pwm+bounces-9693-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6JxlFiAYUmq8LwMAu9opvQ
	(envelope-from <linux-pwm+bounces-9693-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sat, 11 Jul 2026 12:17:04 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9927412F4
	for <lists+linux-pwm@lfdr.de>; Sat, 11 Jul 2026 12:17:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b="M/h8gBoO";
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=p8w14CPZ;
	dmarc=pass (policy=reject) header.from=mailbox.org;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9693-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9693-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3F2A130074BD
	for <lists+linux-pwm@lfdr.de>; Sat, 11 Jul 2026 10:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61416395D8B;
	Sat, 11 Jul 2026 10:17:02 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAD8233927;
	Sat, 11 Jul 2026 10:16:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783765022; cv=none; b=pB7KG0ribP9K1QZ1syyPaEV4NzhNBJQ4cI2oNBD8dCbfYkAVLSErmGqNxOWUhn1TyReyOJgxfIVInovNMI2stfOxzxILGEn/sw7QWpN4VHtdY9dseqf4W0rjSsQgXMr0/3GEjRxeeJ6xTqadrhFdViuMWR0UzAc5jagObCuvbLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783765022; c=relaxed/simple;
	bh=+Q01IOSPpbl6YaJ1sx2U1xpDg/zo1GCHE9ISpCMdGX4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HTyxsuZ3PPvXCexdGDf3E9ZSNpUanEWpIvdYKNKeYARbb547Cw+Tne91IGDa1Yjy30reX6+2dSnAF5ArFC7FOULU4xYMhczYu2w5Bh0ht+Gv8ISEFQN6gO9Iff5eu+NB9YApl3OmRGzfoawdGaijnUxMKLSBGLDHSHlgc1G7HEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=M/h8gBoO; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=p8w14CPZ; arc=none smtp.client-ip=80.241.56.152
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gy4PP0dlZzKvv9;
	Sat, 11 Jul 2026 12:16:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1783765017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=U3ImstQrsA9UW+38lhQ1sNds7gu/oGbkbhambfG/NR0=;
	b=M/h8gBoOZzGcKOjKkhO2U3RWnN/IbG1O1jBcYDl9RQ4AA5snm9OVJEtarFLd9J3rDReFj6
	cNpOq7imAUFtt6EZ8L/lnnrdHaG+lLjh/ygkcd2tV06KZPvPWWJKqTNn2AItsvYuXUB3Qj
	iutPsL6iGbqfXhp6eFBgCIjMRq1ZpedOUVrV22S9WqnVI5V4bQpL41lYMBsFU4uc07gPzh
	+21VEAw93+HcFc9lffr2jdn4pjKKLg6hpVtlv7+7M0dWCcObsRjYFe7i8elsi0z9jB/T7U
	qGi/mlOMjMCU3zWv8qR3f+MamcxyaSqqFh9Ggfh0srW7njLA+ZfE71s8pqrc+Q==
From: Maurice Hieronymus <mhi@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1783765014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=U3ImstQrsA9UW+38lhQ1sNds7gu/oGbkbhambfG/NR0=;
	b=p8w14CPZ0kWEU7bX10C1ghN0UHreb54mtp4opQHTe3FNRthqsgGq7vqIfcp7mTgjL7iyBq
	asnDirQLwQNdcRS9mp5FYmRd7q/e6/mY1/lZZA6ZhUE4vayuQXfwjpLnc4EdrPyfF22o0Y
	8Oo8fFnYiwoNeRIB954FI0S0S3XEnmETjWFaaS4+7O7U5YK2y/nRUrIlLcRoMZHHeyN4LZ
	QG+4EeZFnI3eJ+YZ+OUv3oApZHbkyxJ7rPX3ZnpxbrVP80sOkGemDtSRB6SWmhVkY4KLpe
	DWvoxZOHglK7I3Mq+AvdP1sHQshrQl3Q6nSCWDKgmDXKbpll++Y3b4Unh722zQ==
Subject: [PATCH v4 0/2] rust: clk: Add ExclusiveClk and use it in
 pwm-th1520
Date: Sat, 11 Jul 2026 12:16:28 +0200
Message-Id: <20260711-rate-exclusive-get-th1520-v4-0-8244a0666a71@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43QTW7DIBAF4KtYrEsFw4+NV71H1QWGwUZN4hSI5
 SjK3YuTRVpVirqckeZ7o3chGVPETPrmQhIuMcf5UAf50hA32cOINPo6E2CgmQJNky1IcXW7U44
 L0hELLRNXwGirpTXSeOQdknp/TBjierPfP+o8xVzmdL5FLXzb/kddOGVUSBeYkMhrxtvext0wr
 69zGsnmLvCwqvbMgmppo7RkQ2hBmr+W+GFB98wS1XKtswIHFzQLv63rvYCEX6faabm38Ki0b2q
 EYoYZ6naftJyPSHPZwhzj1rbeK8V9v6ityMHmup/3+1j6xgDjDMA4OYiuM23gghtf3+UaPASjD
 Sj0vK0vXL8BKCEg+94BAAA=
X-Change-ID: 20260526-rate-exclusive-get-th1520-764a949de18e
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, Drew Fustini <fustini@kernel.org>, 
 Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
 Michal Wilczynski <m.wilczynski@samsung.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Brian Masney <bmasney@redhat.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, 
 linux-clk@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-pwm@vger.kernel.org, Maurice Hieronymus <mhi@mailbox.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783765003; l=2054;
 i=mhi@mailbox.org; s=20260525; h=from:subject:message-id;
 bh=+Q01IOSPpbl6YaJ1sx2U1xpDg/zo1GCHE9ISpCMdGX4=;
 b=wrIw8EiPXBMgXwOPtE10nUhaLnGuBvvXnluKQnp020xOGAt974/hFA4jcJSIM/LAIYqar4qEW
 TwOwcYvbqCsAW9XZmIYQ5zix6qVPq2cHcCTaxtX3rG7/0g/ox4qJTaR
X-Developer-Key: i=mhi@mailbox.org; a=ed25519;
 pk=AHlEkGG3hpXZHntlEzF42Ip/LFyXWOgsNUvaHqAnV80=
X-MBO-RS-META: p68pwkc35abrj1qzbhy65xyydo66i3rj
X-MBO-RS-ID: 17a3b90175c5235e027
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:mturquette@baylibre.com,m:sboyd@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:dakr@kernel.org,m:fustini@kernel.org,m:guoren@kernel.org,m:wefu@redhat.com,m:m.wilczynski@samsung.com,m:ukleinek@kernel.org,m:bmasney@redhat.com,m:daniel.almeida@collabora.com,m:linux-clk@vger.kernel.org,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:linux-pwm@vger.kernel.org,m:mhi@mailbox.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mhi@mailbox.org,linux-pwm@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-9693-lists,linux-pwm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailbox.org:from_mime,mailbox.org:email,mailbox.org:mid,mailbox.org:dkim,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DE9927412F4

Add a Rust binding for clk_rate_exclusive_get() / clk_rate_exclusive_put()
and use it in pwm-th1520, which previously carried a TODO noting the
missing binding.

Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
---
Changes in v4:
- Rebased on v5 of https://lore.kernel.org/rust-for-linux/20260706-clk-type-state-v5-0-67c5f326a16c@collabora.com/
- Link to v3: https://lore.kernel.org/r/20260628-rate-exclusive-get-th1520-v3-0-c7ca3ebcf60f@mailbox.org

Changes in v3:
- Add #[inline] to Clk::rate_exclusive_get() (Onur Özkan)
- Drop intra-doc links from the regular SAFETY comments (Onur Özkan)
- Rebase on Daniel Almeida's Clk type-state pattern
  https://lore.kernel.org/rust-for-linux/20260618-clk-type-state-v4-0-8be082786080@collabora.com/
- Use vertical imports in pwm_th1520.rs
- Link to v2: https://lore.kernel.org/r/20260605-rate-exclusive-get-th1520-v2-0-695640bf7249@mailbox.org

Changes in v2:
- Rebase on pwm/for-next
- Remove newline after [`clk_rate_exclusive_get`] comment
- Remove unused [`struct clk`] link
- Put semicolon outside of unsafe block
- Link to v1: https://lore.kernel.org/r/20260526-rate-exclusive-get-th1520-v1-0-34cf034e1764@mailbox.org

---
Maurice Hieronymus (2):
      rust: clk: Add `ExclusiveClk` wrapper for `clk_rate_exclusive_get`
      pwm: th1520: Lock clock rate with clk_rate_exclusive_get

 drivers/pwm/pwm_th1520.rs | 18 ++++++++-----
 rust/kernel/clk.rs        | 67 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+), 6 deletions(-)
---
base-commit: 92010229c4b38897f1319d260162d2f96925ed17
change-id: 20260526-rate-exclusive-get-th1520-764a949de18e
prerequisite-change-id: 20250909-clk-type-state-c01aa7dd551d:v5
prerequisite-patch-id: 2d3dc45c241d9062a0d2546ec649eec7970fa50a
prerequisite-patch-id: 67ad535fe110207ebc79045ba022ebb7137b0309
prerequisite-patch-id: 3d1d8ee5c2a4957edd0807b7a5cb65dabab345b5
prerequisite-patch-id: e2659037b8aaf51831da099cc568ad5b3c24a4dd

Best regards,
-- 
Maurice Hieronymus <mhi@mailbox.org>


