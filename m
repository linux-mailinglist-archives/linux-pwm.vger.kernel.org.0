Return-Path: <linux-pwm+bounces-9444-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Hx0vKLaBQWrTrgkAu9opvQ
	(envelope-from <linux-pwm+bounces-9444-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 28 Jun 2026 22:19:02 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 198846D4E27
	for <lists+linux-pwm@lfdr.de>; Sun, 28 Jun 2026 22:19:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=YqzpIpo3;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=v6DgoObr;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9444-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9444-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=mailbox.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B51863028F37
	for <lists+linux-pwm@lfdr.de>; Sun, 28 Jun 2026 20:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D9D3B6C15;
	Sun, 28 Jun 2026 20:18:06 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19D13B6BFE;
	Sun, 28 Jun 2026 20:18:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782677886; cv=none; b=hHvnH7eK2/LSWFf2yT+JHoINN8Tdot5z4qU2vf2i6ikbNLIVJ+Fjdhg9Iqxe085+FqfhtewabcdLs4COh2XLImk3v0S1fGkTyaFGdGxhFtm17zjy1azcqMU5dxA3qu8XbyTSQl+SI0umtlLbUvXORPCBozw+0+xm3xldFtQAyPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782677886; c=relaxed/simple;
	bh=Y4wbuB2Q7UtRfee4Zl34eyEe9jsKHEIS7Gdb8j429aY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZLMlvAe37J57WqZbGu3HEnKrh083WX0QgsEebmKWFwFsTnFUkUXIxlGnwoDtmwcU1FVB7RgRuoNHtrEtwXEK+/fjcy13Lpx5B+/TnfqFz7jKXlG3hLBcWqsFNe9ASmocL9WVkfWKtWT4t22SGrHjdRdDlS8/HIfpcejnExHy0B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=YqzpIpo3; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=v6DgoObr; arc=none smtp.client-ip=80.241.56.172
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gpLLr2ypfz9tq3;
	Sun, 28 Jun 2026 22:17:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1782677876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5HOFKh4PR2wybtyQprzVFoqSkRuBhet8B4vwHYABWVM=;
	b=YqzpIpo3L7EZaVwGrCKSWG5+qknchc8wL0MVgqAbrB/EBzrQZ6AWI/dVNHcoieK7j7xCL6
	BAPhntIvWuitag4UHNpvkNsYj1SkoGeOU40q1fMS8OfOxprncMgW+jhNjQVfmUM1w2P8Xy
	bzi20ZjqibOWuQeipRhpwEou0s2IsmSeBvlQUgiQ661ayJybxBnw/fctC+tcYmgVjsh37D
	+bV1kzSLZguKMToLX0S/MMKuaKrMDxdYuBgnIO0ddRyY/chy4FVL3wNLaHCko9+wILmC1F
	yfWQXiDU+ZlRsH3zMn1+AAwQT3gFrAOktTxy3YNGEPbYInndE/LBycsTjK3MCA==
From: Maurice Hieronymus <mhi@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1782677874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5HOFKh4PR2wybtyQprzVFoqSkRuBhet8B4vwHYABWVM=;
	b=v6DgoObrYvyLWvtYtCcWS/hNjenTQ8GcAN/0OzrNlj9m42/HLLfDippnt7w6Ax+USjpT2A
	D2wTFNy7BpFQM2CiWOXMkxgMwvOEQR0tI3zHBc7LzOAoKbj9epCXojMR0RMybsdpisA+M6
	WwglmZZhdceePphzdIldPM9g+EKIc7lRdeJbplwJ79VRLnzOUrPb2nVBfBYpMaz1aT9Qlu
	3qtWoqIVaWOwzHhXHhSVmm6MddrQxR/ZJ3M7iZOLfTSatild5/vX0kJABK1wpdAOWiBohL
	Zb/sMY3+6hO0yjzjeIY7R52BzmTMHToA49naGlB1hRh+TgjDLde2pD6Y4X6Kmw==
Date: Sun, 28 Jun 2026 22:17:29 +0200
Subject: [PATCH v3 1/2] rust: clk: Add `ExclusiveClk` wrapper for
 `clk_rate_exclusive_get`
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260628-rate-exclusive-get-th1520-v3-1-c7ca3ebcf60f@mailbox.org>
References: <20260628-rate-exclusive-get-th1520-v3-0-c7ca3ebcf60f@mailbox.org>
In-Reply-To: <20260628-rate-exclusive-get-th1520-v3-0-c7ca3ebcf60f@mailbox.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782677860; l=3880;
 i=mhi@mailbox.org; s=20260525; h=from:subject:message-id;
 bh=Y4wbuB2Q7UtRfee4Zl34eyEe9jsKHEIS7Gdb8j429aY=;
 b=xKwZuEATbxSwMsq/BqTX+EV73z4sJzVlYz5zbkRq7NQtOVxWxmhVAcEF+6MtVdkG7uJXRBEwl
 cV59Xj0xUg5A8PA+QvTAL3AoFq/Img4YHwS/oxOb/QUu3pL9GK34fyA
X-Developer-Key: i=mhi@mailbox.org; a=ed25519;
 pk=AHlEkGG3hpXZHntlEzF42Ip/LFyXWOgsNUvaHqAnV80=
X-MBO-RS-META: f4sdaq5bogyhktsjn8wgg5nx78msc1t4
X-MBO-RS-ID: 79f967012ba1555c077
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:mturquette@baylibre.com,m:sboyd@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:dakr@kernel.org,m:fustini@kernel.org,m:guoren@kernel.org,m:wefu@redhat.com,m:m.wilczynski@samsung.com,m:ukleinek@kernel.org,m:bmasney@redhat.com,m:daniel.almeida@collabora.com,m:linux-clk@vger.kernel.org,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:linux-pwm@vger.kernel.org,m:mhi@mailbox.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mhi@mailbox.org,linux-pwm@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-9444-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mailbox.org:dkim,mailbox.org:email,mailbox.org:mid,mailbox.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 198846D4E27

Add Rust bindings for `clk_rate_exclusive_get()` and
`clk_rate_exclusive_put()`.

`Clk::rate_exclusive_get()` consumes the `Clk<Enabled>` and returns an
`ExclusiveClk`. The matching put is issued from its Drop impl.
`ExclusiveClk` derefs to `Clk<Enabled>` so existing APIs remain
available on the locked handle.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
---
 rust/kernel/clk.rs | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/rust/kernel/clk.rs b/rust/kernel/clk.rs
index 1412a2f0aedf..89f662b67b95 100644
--- a/rust/kernel/clk.rs
+++ b/rust/kernel/clk.rs
@@ -95,6 +95,7 @@ mod common_clk {
     use core::{
         marker::PhantomData,
         mem::ManuallyDrop,
+        ops::Deref,
         ptr, //
     };
 
@@ -621,6 +622,23 @@ pub fn set_rate(&self, rate: Hertz) -> Result {
             // [`clk_set_rate`].
             to_result(unsafe { bindings::clk_set_rate(self.as_raw(), rate.as_hz()) })
         }
+
+        /// Acquire exclusive control over the clock's rate.
+        ///
+        /// Consumes the [`Clk<Enabled>`] and returns an [`ExclusiveClk`] that releases
+        /// the exclusivity when dropped. While held, no other consumer may change the clock's rate.
+        ///
+        /// Equivalent to the kernel's [`clk_rate_exclusive_get`] API. Must not be called from
+        /// atomic context.
+        ///
+        /// [`clk_rate_exclusive_get`]: https://docs.kernel.org/core-api/kernel-api.html#c.clk_rate_exclusive_get
+        #[inline]
+        pub fn rate_exclusive_get(self) -> Result<ExclusiveClk> {
+            // SAFETY: By the type invariants, self.as_raw() is a valid argument for
+            // clk_rate_exclusive_get.
+            to_result(unsafe { bindings::clk_rate_exclusive_get(self.as_raw()) })?;
+            Ok(ExclusiveClk(self))
+        }
     }
 
     impl<T: ClkState> Clk<T> {
@@ -650,6 +668,55 @@ fn drop(&mut self) {
             unsafe { bindings::clk_put(self.as_raw()) };
         }
     }
+
+    /// A [`Clk<Enabled>`] with exclusive control over its rate.
+    ///
+    /// While an [`ExclusiveClk`] exists, no other consumer of the same clock may change its rate.
+    /// Obtained by calling [`Clk::rate_exclusive_get`]; the exclusivity is released automatically
+    /// when the value is dropped, after which the inner [`Clk<Enabled>`] is dropped as usual.
+    ///
+    /// # Invariants
+    ///
+    /// An [`ExclusiveClk`] instance owns a [`Clk<Enabled>`] for which `clk_rate_exclusive_get` has
+    /// been called and the matching `clk_rate_exclusive_put` has not yet been called.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::clk::{
+    ///     Clk,
+    ///     ExclusiveClk,
+    ///     Enabled //
+    /// };
+    /// use kernel::device::{
+    ///     Bound,
+    ///     Device, //
+    /// };
+    /// use kernel::error::Result;
+    ///
+    /// fn lock_rate(dev: &Device<Bound>) -> Result<ExclusiveClk> {
+    ///     let clk = Clk::<Enabled>::get(dev, None)?;
+    ///     clk.rate_exclusive_get()
+    /// }
+    /// ```
+    pub struct ExclusiveClk(Clk<Enabled>);
+
+    impl Deref for ExclusiveClk {
+        type Target = Clk<Enabled>;
+
+        fn deref(&self) -> &Clk<Enabled> {
+            &self.0
+        }
+    }
+
+    impl Drop for ExclusiveClk {
+        fn drop(&mut self) {
+            // SAFETY: By the type invariants, self.as_raw() is a valid argument for
+            // clk_rate_exclusive_put and balances the clk_rate_exclusive_get call from
+            // Clk::rate_exclusive_get.
+            unsafe { bindings::clk_rate_exclusive_put(self.as_raw()) };
+        }
+    }
 }
 
 #[cfg(CONFIG_COMMON_CLK)]

-- 
2.51.2


