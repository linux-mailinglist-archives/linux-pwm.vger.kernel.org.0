Return-Path: <linux-pwm+bounces-9161-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NWZNPTSFWogcgcAu9opvQ
	(envelope-from <linux-pwm+bounces-9161-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 26 May 2026 19:05:56 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9A55DA530
	for <lists+linux-pwm@lfdr.de>; Tue, 26 May 2026 19:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9A88430015B1
	for <lists+linux-pwm@lfdr.de>; Tue, 26 May 2026 17:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55961403EB7;
	Tue, 26 May 2026 17:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGXqJnQZ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16A8403150;
	Tue, 26 May 2026 17:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779815102; cv=none; b=mzAB8DK3M5+yC4ln5S+g/DrZ6R89/BS7SVF0rWvNn2emUg52dXlmu2F5Eb4nNX8/R1TOCtuxHuXjHLGtxPVVVGcV+32RP1RMiaHzr84SEsKLln1TtlZxnfVoln8z2nWiY931ZmBJW5DrvNt65/JRyINGqgVzfzEw+sRGhGxjhm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779815102; c=relaxed/simple;
	bh=Bmm4/5oJi9KaKJVrm0pINiNE79zzQtE0+wYBrXHDIT0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gt4s/lRNUytILnTrh1/OBRodO2X/PfaOENZGBMOdmPOUGM6P2vtxANpc2jslP3u+UgV9LqK5V79ocKo7sebSsH66HGE9E/WFNIC/XZy2MWkGGzbcE22OYcTfeH3hdFRWaAGU60JavF/Hk2/LI3CvMebAohWXC4UMhc5eSpr/6+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGXqJnQZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DBD8BC2BCC4;
	Tue, 26 May 2026 17:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779815102;
	bh=Bmm4/5oJi9KaKJVrm0pINiNE79zzQtE0+wYBrXHDIT0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=oGXqJnQZHWGzlWwHKiqIS2FaY8iaV7C8FtiwziuWuZkn0ztjyNvu4MW4rEbRIJl4n
	 n1kFxLU79LcH9mU6MkWHTS+FuqKDSDjNU48WbrZITIKyW+nc1sq2327sweZqzrPONg
	 pM5eEF3lwuzilQ+iY9jouB7lLTCQ0psleRDPSl4fThorITpbX2Z7XeIzkfxho8EnSE
	 D+JAK17YDxL/C1/Gd3Y+Y6Rp9roCisARFDlRaLfd+6w9D9EK+jAqDLg0dgFm0EkgFA
	 j2uB8c9YObb7xAJfNl3SRuH8uptKgex+bOWGNkQzgqRMzQw0rvm8BRDFijCqmVOHMY
	 D5r7gX3sfTMDw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A35CD5BC8;
	Tue, 26 May 2026 17:05:01 +0000 (UTC)
From: Maurice Hieronymus via B4 Relay <devnull+mhi.mailbox.org@kernel.org>
Date: Tue, 26 May 2026 19:04:57 +0200
Subject: [PATCH 1/2] rust: clk: Add ExclusiveClk wrapper for
 clk_rate_exclusive_get
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-rate-exclusive-get-th1520-v1-1-34cf034e1764@mailbox.org>
References: <20260526-rate-exclusive-get-th1520-v1-0-34cf034e1764@mailbox.org>
In-Reply-To: <20260526-rate-exclusive-get-th1520-v1-0-34cf034e1764@mailbox.org>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, Drew Fustini <fustini@kernel.org>, 
 Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
 Michal Wilczynski <m.wilczynski@samsung.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-clk@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-pwm@vger.kernel.org, Maurice Hieronymus <mhi@mailbox.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779815100; l=3630;
 i=mhi@mailbox.org; s=20260525; h=from:subject:message-id;
 bh=eeAOAa6Y2zm3Hajnun7vvZ2u6PShjeRY9qX+W/KRP+c=;
 b=7Z8IQMFi5xKCCFeuAal3K7kJkXYyGA1HDWZvUu0uVf9KwQYky55CqLDF3yCnETma2JXvhfW9b
 CtNi39i0kGcBkhMafUkqL9gOIVXwCe6aHH0kw4epFcVmIWMtrRdEIcI
X-Developer-Key: i=mhi@mailbox.org; a=ed25519;
 pk=AHlEkGG3hpXZHntlEzF42Ip/LFyXWOgsNUvaHqAnV80=
X-Endpoint-Received: by B4 Relay for mhi@mailbox.org/20260525 with
 auth_id=790
X-Original-From: Maurice Hieronymus <mhi@mailbox.org>
Reply-To: mhi@mailbox.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9161-lists,linux-pwm=lfdr.de,mhi.mailbox.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[baylibre.com,kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,redhat.com,samsung.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[mhi@mailbox.org];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mailbox.org:replyto,mailbox.org:mid,mailbox.org:email]
X-Rspamd-Queue-Id: 2E9A55DA530
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Maurice Hieronymus <mhi@mailbox.org>

Add Rust bindings for clk_rate_exclusive_get() and
clk_rate_exclusive_put().

Clk::rate_exclusive_get() consumes the Clk and returns an ExclusiveClk;
the matching put is issued from its Drop impl. ExclusiveClk derefs to
Clk so existing rate / prepare / enable APIs remain available on the
locked handle.

Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
---
 rust/kernel/clk.rs | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/rust/kernel/clk.rs b/rust/kernel/clk.rs
index 7abbd0767d8c..8cda40cb01e4 100644
--- a/rust/kernel/clk.rs
+++ b/rust/kernel/clk.rs
@@ -249,6 +249,23 @@ pub fn set_rate(&self, rate: Hertz) -> Result {
             // [`clk_set_rate`].
             to_result(unsafe { bindings::clk_set_rate(self.as_raw(), rate.as_hz()) })
         }
+
+        /// Acquire exclusive control over the clock's rate.
+        ///
+        /// Consumes the [`Clk`] and returns an [`ExclusiveClk`] that releases the exclusivity
+        /// when dropped. While held, no other consumer may change the clock's rate.
+        ///
+        /// Equivalent to the kernel's [`clk_rate_exclusive_get`] API. Must not be called from
+        /// atomic context.
+        ///
+        /// [`clk_rate_exclusive_get`]:
+        /// https://docs.kernel.org/core-api/kernel-api.html#c.clk_rate_exclusive_get
+        pub fn rate_exclusive_get(self) -> Result<ExclusiveClk> {
+            // SAFETY: By the type invariants, self.as_raw() is a valid argument for
+            // [`clk_rate_exclusive_get`].
+            to_result(unsafe { bindings::clk_rate_exclusive_get(self.as_raw()) })?;
+            Ok(ExclusiveClk(self))
+        }
     }
 
     impl Drop for Clk {
@@ -329,6 +346,54 @@ fn deref(&self) -> &Clk {
             &self.0
         }
     }
+
+    /// A [`Clk`] with exclusive control over its rate.
+    ///
+    /// While an [`ExclusiveClk`] exists, no other consumer of the same clock may change its rate.
+    /// Obtained by calling [`Clk::rate_exclusive_get`]; the exclusivity is released automatically
+    /// when the value is dropped, after which the inner [`Clk`] is dropped as usual.
+    ///
+    /// # Invariants
+    ///
+    /// An [`ExclusiveClk`] instance owns a [`Clk`] for which `clk_rate_exclusive_get` has been
+    /// called and the matching `clk_rate_exclusive_put` has not yet been called.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::clk::{Clk, ExclusiveClk};
+    /// use kernel::device::Device;
+    /// use kernel::error::Result;
+    ///
+    /// fn lock_rate(dev: &Device) -> Result<ExclusiveClk> {
+    ///     let clk = Clk::get(dev, None)?;
+    ///     clk.prepare_enable()?;
+    ///     clk.rate_exclusive_get()
+    /// }
+    /// ```
+    ///
+    /// [`struct clk`]: https://docs.kernel.org/driver-api/clk.html
+    pub struct ExclusiveClk(Clk);
+
+    // Make [`ExclusiveClk`] behave like [`Clk`].
+    impl Deref for ExclusiveClk {
+        type Target = Clk;
+
+        fn deref(&self) -> &Clk {
+            &self.0
+        }
+    }
+
+    impl Drop for ExclusiveClk {
+        fn drop(&mut self) {
+            // SAFETY: By the type invariants, self.as_raw() is a valid argument for
+            // [`clk_rate_exclusive_put`] and balances the [`clk_rate_exclusive_get`] call from
+            // [`Clk::rate_exclusive_get`].
+            unsafe {
+                bindings::clk_rate_exclusive_put(self.as_raw());
+            }
+        }
+    }
 }
 
 #[cfg(CONFIG_COMMON_CLK)]

-- 
2.51.2



