Return-Path: <linux-pwm+bounces-9117-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPLWK7ZKFGpeMQcAu9opvQ
	(envelope-from <linux-pwm+bounces-9117-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 15:12:22 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5685CAEFF
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 15:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 779EB30125F9
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 13:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17927383C64;
	Mon, 25 May 2026 13:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPSwMGGI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A9B383333;
	Mon, 25 May 2026 13:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779714667; cv=none; b=NAiiEcJVWsqRU0vPa4s2maSMLTdfaKBWMNVd3ETmOI1FEynZ6I6VduoobG1HLWFObBBvU3SbIe0g9WdeaAuWH8z0jPyKMbZvgFnYg2EOMjAidJf9qrIHfz1VumKbRbQ6pTPHDep1ktKDR2gIukqHyrpX8Ipdmv/sfSdsBEhF2bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779714667; c=relaxed/simple;
	bh=gJANdD9WR/rwlZqdxsUyvXHtL/APVzUZ/BRP6GSj70E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jilmI6uj3OsJbT8ILsuORZFtAZNImSyifdpqODy2WeDGQRAD0HcaEMrQcdjKubTAYcbfZgPTtwzGVGLl9MIIQymkkGwqo6Wg+OC8KBvThViRtMDPspPsbLHvmjtHkzjW+9ZwxBMDSqQ4mV5i/gVfsN7GABBDtBD3Y8ncPqlkwWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPSwMGGI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79A46C2BCB3;
	Mon, 25 May 2026 13:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779714666;
	bh=gJANdD9WR/rwlZqdxsUyvXHtL/APVzUZ/BRP6GSj70E=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=nPSwMGGIsREma719TJA2EZFDAyb0rfjfADB8MttgtWnho3snTSKEMuG7Es5ExXe5L
	 F/ENqiqs8QQQAXAuCbgGL2CWjni2uFKqG/d/axxwpBe+yc/v0l7tCQhZjcHxwVM4Ir
	 KEOvXlHgydqL7HbKqPawRnPKRI5K8SkybEwLqZpppoaZ9Hdb48QWWusuozIjxFPTOP
	 vFOcFLITVEgS8Vm0xurjVISgOXkmw/iOjp9qriqRJLS1ChLewpoRnKGcvUoR6WvsuK
	 4m3g0dK+8yBMtjYou+8e3454m+7sSM5ecpdxPEWOByW5NM6+LGEEEY3/IT8333U+cZ
	 ce+hccCZ/cP2Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF51CD5BC9;
	Mon, 25 May 2026 13:11:06 +0000 (UTC)
From: Maurice Hieronymus via B4 Relay <devnull+mhi.mailbox.org@kernel.org>
Date: Mon, 25 May 2026 15:11:02 +0200
Subject: [PATCH RESEND] pwm: th1520: Remove requirement for
 mul_u64_u64_div_u64_roundup
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-pwm-th1520-fix-v1-1-814e537c6812@mailbox.org>
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
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779714665; l=2775;
 i=mhi@mailbox.org; s=20260525; h=from:subject:message-id;
 bh=pPwMlhdLEIKx7tKQw28S2ur5hibHwE9OvuL0BMwNJFI=;
 b=2CY1YOoHuBr6u2vNL2LHaCbZfS8c/Z4MpUQbK76cVxR4pFQ7J6JKYPOmCZp6RzS5uoV/ehCKe
 ehBfc6H4FxyCb4WyrRuUDfbLeENx3YhhB4ifWpzHxSRGYx63rQBQft2
X-Developer-Key: i=mhi@mailbox.org; a=ed25519;
 pk=AHlEkGG3hpXZHntlEzF42Ip/LFyXWOgsNUvaHqAnV80=
X-Endpoint-Received: by B4 Relay for mhi@mailbox.org/20260525 with
 auth_id=790
X-Original-From: Maurice Hieronymus <mhi@mailbox.org>
Reply-To: mhi@mailbox.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9117-lists,linux-pwm=lfdr.de,mhi.mailbox.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,redhat.com,samsung.com,garyguo.net,protonmail.com,google.com,umich.edu];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	HAS_REPLYTO(0.00)[mhi@mailbox.org];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-pwm@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mailbox.org:url,mailbox.org:replyto,mailbox.org:mid,mailbox.org:email]
X-Rspamd-Queue-Id: 1D5685CAEFF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Maurice Hieronymus <mhi@mailbox.org>

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
Note: Resending v1 because my mail server (mailbox.org) was
unable to deliver the original submission to @kernerl.org
recipients. Going through the b4 web submission endpoint this
time. No changes to the patch content.
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



