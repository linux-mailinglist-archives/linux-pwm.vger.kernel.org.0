Return-Path: <linux-pwm+bounces-9442-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id n6ckD32BQWrJrgkAu9opvQ
	(envelope-from <linux-pwm+bounces-9442-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 28 Jun 2026 22:18:05 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B8F6D4E0B
	for <lists+linux-pwm@lfdr.de>; Sun, 28 Jun 2026 22:18:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=P0k1buk9;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b="JGcUz/Bj";
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9442-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9442-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=mailbox.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 783DE300D14F
	for <lists+linux-pwm@lfdr.de>; Sun, 28 Jun 2026 20:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4673B637F;
	Sun, 28 Jun 2026 20:18:01 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FD22BEC2E;
	Sun, 28 Jun 2026 20:17:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782677881; cv=none; b=TPQSaHrTXlvSS5Piem5/zSI505ZgjltdkHEjjIqLK8musseKwVEYCP43cwfI6HfgrhpPxLURIBGoAB486C8B3HoD+IMtyRo3N6R9cEph5wzapqxXmCckKTlS3ST+0jLNFKxQZcYKYA0hqCFQgWoxadowFussuSFlhQhezIVW5s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782677881; c=relaxed/simple;
	bh=xif+QOYVfTkTh915IArvTrN/H12Ehq+umM4Is5gGqAk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=q4vwuyywNFwYyPox3Bol8KurP1B1AUyJ5iUs8Ct1OPkCLxGScUVrfwhlyphUkaMfYR8EllxCGaexj34MW9ka070f+12jFOgc71oAHrR6/ATwBTHVjuegSJBGxHFBhtyYsJ/Fk/LyOIlTM2+/D92bQG16PxXzWJKa84b4QQPSQfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=P0k1buk9; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=JGcUz/Bj; arc=none smtp.client-ip=80.241.56.171
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gpLLk5zXkz9sld;
	Sun, 28 Jun 2026 22:17:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1782677870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ie6nZOtCCEs/4gM6JA/fBtqmGphyj1Qv1SevnnJ4fyY=;
	b=P0k1buk9fkz39VlR3zNbcqO4XRsKRXCaMH2TOID74YIpIAEX0L/y259I5F9TPinSTFr9M1
	MbrOWMWCoaan14F1d7Liy7HGJzcpwRFXnxaQCQVJXJpYG9Pv5TzBgJ8VKKd/d3536vSbZa
	Bbh309vV7OOQl5H8if0WvobXC3KsD+xWkvV2erE4daK4i7irw/Y+DerUdZrw4AV/O6FDzN
	wX79HYb4vfkIlJV7Ks+yb6GpZPsEzXNYZNxOr2jN6V4INlvDysD0AEqkasUu2MiqeD0lOR
	QZIAT1Jhq9x9GZI70XDReTfhAiMwu/q6vdkr2rRYrH7C+fwdEG7432LV2sGUtg==
From: Maurice Hieronymus <mhi@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1782677868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ie6nZOtCCEs/4gM6JA/fBtqmGphyj1Qv1SevnnJ4fyY=;
	b=JGcUz/BjqQ40tRChZ4sPwrJ4u4DIUmkkBNCMm5ttNO7kMaOeCSKYV8VQsNqKlpnHXkxe6N
	iqni2TXY9YGTNACQkUc7mHj6DD0B3B+u91pDwo3Rg+VTA6dt+4fz25g94e036pREbD+ZVp
	FjO2zNK0db/x3kkKsYWwflrZDQwyV5Za27Wb9oipxvMeGARZBMT8/zL/9VZ551nHKllgiC
	QOF9KlM5+pSMf6f7EV5eVkq208rmmvJGoalRMHvuRjtVmUcA1EBvji4u9C7hGAvBd6vH49
	0VXvMR45fvgnEpf8FCV9M6gddsqFdwgpU4j7MLxOGdbdpXJ4igTfkZUwwAr/zw==
Subject: [PATCH v3 0/2] rust: clk: Add ExclusiveClk and use it in
 pwm-th1520
Date: Sun, 28 Jun 2026 22:17:28 +0200
Message-Id: <20260628-rate-exclusive-get-th1520-v3-0-c7ca3ebcf60f@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42QO27DMBBEryKwDgP+aarKPYIU/CwlIpJlk7Qgw
 /DdQ9mFkSZIOQPsm9m5oQI5QUF9d0MZ1lTScmyCv3XIj/Y4AE6hacQIU0QyhbOtgGHz06WkFfA
 AFdeRSkawVsIaYQLQA6B2f8oQ0/Zgf341PaZSl3x9RK10d/9DXSkmmAsfCRdAW8bHbNPklu19y
 QPauSt7sRrtLxZrLGWkEsRFzYT5zbo/S2c4X9oO9dn8NUPftQhJDDHYT9+4Xk+AS93DPKHW6hC
 kpKFfxf68s6X5yzyn2neHQLj3glnBHLU8Usmlljoq6aLTbTUtuZE8tgr3H0ct8DuSAQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782677860; l=1774;
 i=mhi@mailbox.org; s=20260525; h=from:subject:message-id;
 bh=xif+QOYVfTkTh915IArvTrN/H12Ehq+umM4Is5gGqAk=;
 b=j8OVFl6Qn7Y9f7bAHBMjQEbRY9neZadP0D1+PLGyVCHN7qqKKgBsKC2flsOzyMiG8XsIiFfW2
 RBVBGnQS7eNAR81LFLn6bH2ZdmuGwpcWJRabobBPYNDekKEQe3n+AIL
X-Developer-Key: i=mhi@mailbox.org; a=ed25519;
 pk=AHlEkGG3hpXZHntlEzF42Ip/LFyXWOgsNUvaHqAnV80=
X-MBO-RS-META: yxzgidr591ib5afmf87ktj48uz8j9749
X-MBO-RS-ID: 334c0e422a882688ded
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
	FORGED_RECIPIENTS(0.00)[m:mturquette@baylibre.com,m:sboyd@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:dakr@kernel.org,m:fustini@kernel.org,m:guoren@kernel.org,m:wefu@redhat.com,m:m.wilczynski@samsung.com,m:ukleinek@kernel.org,m:bmasney@redhat.com,m:daniel.almeida@collabora.com,m:linux-clk@vger.kernel.org,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:linux-pwm@vger.kernel.org,m:mhi@mailbox.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[mhi@mailbox.org,linux-pwm@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-9442-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mailbox.org:dkim,mailbox.org:email,mailbox.org:mid,mailbox.org:from_mime,pwm_th1520.rs:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 85B8F6D4E0B

Add a Rust binding for clk_rate_exclusive_get() / clk_rate_exclusive_put()
and use it in pwm-th1520, which previously carried a TODO noting the
missing binding.

Based on clk/clk-next

Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
---
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
base-commit: 8d03cc42a42b1a3f1535757f65bfb74a9753953f
change-id: 20260526-rate-exclusive-get-th1520-764a949de18e
prerequisite-change-id: 20250909-clk-type-state-c01aa7dd551d:v4
prerequisite-patch-id: 03177c5f8e355964643fc1eb78016c702a84f3d4
prerequisite-patch-id: a5c5ccd624964eda85aab9f425c6340ede7fcf5d
prerequisite-patch-id: 92bd8e4df3194eff330e1bc2fc3386d21c3c56d0

Best regards,
-- 
Maurice Hieronymus <mhi@mailbox.org>


