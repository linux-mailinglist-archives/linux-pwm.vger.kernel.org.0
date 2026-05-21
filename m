Return-Path: <linux-pwm+bounces-9043-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gN2NLR7YDmr2CQYAu9opvQ
	(envelope-from <linux-pwm+bounces-9043-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 21 May 2026 12:02:06 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0765A2DC2
	for <lists+linux-pwm@lfdr.de>; Thu, 21 May 2026 12:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7E2D312AD45
	for <lists+linux-pwm@lfdr.de>; Thu, 21 May 2026 09:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DF537F8AE;
	Thu, 21 May 2026 09:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="nSU0Lq5H";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="YiYx2wtD"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908E837FF54;
	Thu, 21 May 2026 09:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779357276; cv=none; b=Kpu6TxmE0SDwVd/5eWiV7/SzmXg/+YGsHgSjJNjhFZv3ijKizCG/9zj8ItjnNkDuP0DJt96wNzmajFf6XVfbKQmAuFD4ahEzbSuhabzraFF1r0PGHow/FmKyxAf7i/pShwn/wt6nHRu2KfLhnVmTq2yw9bKmb+oflIu43/qAf8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779357276; c=relaxed/simple;
	bh=O5JSAKkDwgIWKtGeQopbZHKrSeY9OSjYeqvakGnnEwA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=G7jXbGUWi/0WoT96sI1Zt6SRe/k5gP5E38kO8YtF38nJfQxR1+E1vYZ115D4pBVCMKKuYQKE0uOrXXE1BwW8mPxDDsk9EK0iHhe4Of5W28ZzNQ4DVuQig/LxXWTpmfwfhRRva2e/lBTRcpO3OfnmKYghUvDd/VS1YnH1WIun6zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=nSU0Lq5H; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=YiYx2wtD; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gLkK33WwPz9t4w;
	Thu, 21 May 2026 11:54:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1779357271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZBfCE1tFEw1bHwVhbXsEcGvBGEMDeaoxSgRqgJTJ9o0=;
	b=nSU0Lq5HyQqkFkbqIdXT9Blb6N3UNZVpqN2iMx+JHIbrRf7cbbc1oZxM7akGlRFWHUmn/8
	DSICq3E7PaJJKqT293eciMZ3QB5aLZTEXg6FH/WtFQp8IBHdO0UbQGboSbQ5Qnf3/EmssM
	Xi0/Or1PcE9zP3/rvInQVNlTih54f5XlkHOjdpNogIMJAwxePMlCzdQXBxshmrb2zMBAck
	0oDgI0Z8tLs3thJptkKRM6M7C0zn+lS2mKxWIHR3j31VQLJk8SOrwWgiHB1ZYAtwbbNrh/
	VINV8uDDeYvyzSuRMf95MX9RtOQ7JgjXm0CDr2Oaiud9Qbd6GbgfPiHatAuovg==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=YiYx2wtD;
	spf=pass (outgoing_mbo_mout: domain of mhi@mailbox.org designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=mhi@mailbox.org
From: Maurice Hieronymus <mhi@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1779357269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZBfCE1tFEw1bHwVhbXsEcGvBGEMDeaoxSgRqgJTJ9o0=;
	b=YiYx2wtDp2CyM5Y6pBWSfoab5hHzcMT97ZjKyxRkzjDhxCyALo0IFwC6Yl/Bl6/Q5UKIOw
	7v6UXSIdYdoLa2z+881yGo8+yBG/VA7Jtzn4/fdV3KjpmdAAMzvkTIuDL4f2dHHBSz68RG
	2sKu49Qexh2u6PCCUSJil2fAMy9MT6bQNYdW/yn2REH5uyQMnxdwQlnLxDObanAUbpCJn0
	3KMllb+Ndo9YA1x+L18bs3cDVveqz0R14/2VEN68PWa7V9E7y1hyiN/afHf+QE8d5p5183
	KqPLsyl4SEeynNqRdR9M25Q92+z2lgvqMvlqyiIsZi7u69Nf9KLyZQAaF7LBrQ==
Date: Thu, 21 May 2026 11:53:59 +0200
Subject: [PATCH] pwm: th1520: Remove requirement for
 mul_u64_u64_div_u64_roundup
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-pwm-th1520-fix-v1-1-df9cd956dab4@mailbox.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUyND3YLyXN2SDENTIwPdtMwKXYtUE1NTU4ukpBRjQyWgpoKiVKAw2MD
 o2NpaAH9Rl1JgAAAA
X-Change-ID: 20260521-pwm-th1520-fix-8e45558bbd31
To: Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, Michal Wilczynski <m.wilczynski@samsung.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Maurice Hieronymus <mhi@mailbox.org>
X-MBO-RS-ID: c7d68cde2b283687114
X-MBO-RS-META: u84cfcd635d5m45as961oynfre6h9ony
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,redhat.com,samsung.com,garyguo.net,protonmail.com,google.com,umich.edu];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9043-lists,linux-pwm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhi@mailbox.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[mailbox.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailbox.org:email,mailbox.org:mid,mailbox.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: EA0765A2DC2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The cycle register is always u32, so cycles_to_ns() can take a u32
instead of a u64. With that narrowing, cycles * NSEC_PER_SEC is at most
u32::MAX * 1e9 (~4.3e18), which fits in u64 without overflow. The
saturating arithmetic is therefore no longer needed, and the ceiling
division can use Rust's u64::div_ceil() directly instead of the
open-coded numerator/denominator form.

This also drops the TODO referring to a future
mul_u64_u64_div_u64_roundup kernel helper, which is no longer required.

Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
---
 drivers/pwm/pwm_th1520.rs | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
index ddd44a5ce497..933c1ec59c2a 100644
--- a/drivers/pwm/pwm_th1520.rs
+++ b/drivers/pwm/pwm_th1520.rs
@@ -67,16 +67,10 @@ fn ns_to_cycles(ns: u64, rate_hz: u64) -> u64 {
     ns.saturating_mul(rate_hz) / NSEC_PER_SEC_U64
 }
 
-fn cycles_to_ns(cycles: u64, rate_hz: u64) -> u64 {
+fn cycles_to_ns(cycles: u32, rate_hz: u64) -> u64 {
     const NSEC_PER_SEC_U64: u64 = time::NSEC_PER_SEC as u64;
 
-    // TODO: Replace with a kernel helper like `mul_u64_u64_div_u64_roundup`
-    // once available in Rust.
-    let numerator = cycles
-        .saturating_mul(NSEC_PER_SEC_U64)
-        .saturating_add(rate_hz - 1);
-
-    numerator / rate_hz
+    (u64::from(cycles) * NSEC_PER_SEC_U64).div_ceil(rate_hz)
 }
 
 /// Hardware-specific waveform representation for TH1520.
@@ -192,15 +186,15 @@ fn round_waveform_fromhw(
             return Ok(());
         }
 
-        wf.period_length_ns = cycles_to_ns(u64::from(wfhw.period_cycles), rate_hz);
+        wf.period_length_ns = cycles_to_ns(wfhw.period_cycles, rate_hz);
 
-        let duty_cycles = u64::from(wfhw.duty_cycles);
+        let duty_cycles = wfhw.duty_cycles;
 
         if (wfhw.ctrl_val & TH1520_PWM_FPOUT) != 0 {
             wf.duty_length_ns = cycles_to_ns(duty_cycles, rate_hz);
             wf.duty_offset_ns = 0;
         } else {
-            let period_cycles = u64::from(wfhw.period_cycles);
+            let period_cycles = wfhw.period_cycles;
             let original_duty_cycles = period_cycles.saturating_sub(duty_cycles);
 
             // For an inverted signal, `duty_length_ns` is the high time (period - low_time).

---
base-commit: 3936b25815ee686a273ca7bbdc9ae19af5e608a3
change-id: 20260521-pwm-th1520-fix-8e45558bbd31

Best regards,
-- 
Maurice Hieronymus <mhi@mailbox.org>


