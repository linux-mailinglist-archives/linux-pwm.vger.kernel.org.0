Return-Path: <linux-pwm+bounces-9610-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ydaoJLTdS2q5bgEAu9opvQ
	(envelope-from <linux-pwm+bounces-9610-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Jul 2026 18:54:12 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D91E7138BB
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Jul 2026 18:54:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=collabora.com header.s=zohomail header.b=YzEdmPKh;
	dmarc=pass (policy=none) header.from=collabora.com;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9610-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9610-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C57703251E5A
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Jul 2026 14:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB8839AD51;
	Mon,  6 Jul 2026 14:38:38 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B06B3911AB;
	Mon,  6 Jul 2026 14:38:36 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783348718; cv=pass; b=s2cvGjy+e+WjBykt4UkI2UT7JzL9jb/0SBIJg333L1rC1aCNWWdRChOzLWqMBD73T/t31Ebf8hscpTvtzmGUqN3j9TUD0wMf8XnVgbHBrFyb5zoZqRTugTtsNAK0oVcm6Vp+c32WZiMlvjUSm61XCtkyRBnszPSknHiOuCT42zA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783348718; c=relaxed/simple;
	bh=tF7AljJwtTFuS1zxSK2Z1txTblLIjES1aUAsy+O4Oho=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J/haB9sGGX2y3kIJ2c7MqA4CbOIDEPZM/Y/YkFfE0xMRt6PF5h5Mgufgkqs97f+L1xllB6qOvwBYvf/BMTby1Cv+k4JyDIrbM8cM9r0IhKtVE+/me+BOdOZQcTvuiQp7qupiX5tqxFpxb444A0DgYsODu6Od7w8MajO2bM6o6zY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=YzEdmPKh; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal: i=1; a=rsa-sha256; t=1783348674; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fC1kHJIMI8EMzhCyfTZIwXDwzqZYFG38b79rW8RQkMPYTnLqa4c8q5FLuPef2MGonvs0ZHWpER0zycLEn8/EWEWZPXvBXa49Z7GWAMbMKWcQuauWo1oHKwa3gEBCuLVNCXOp3gM5aWu4B60+VGGpoCDUiiPICt3mxOjt8SlcRQ0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783348674; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=nGOFMadA6trjWagAE4R3R81yB6gXYE/D7KXnaPswwtM=; 
	b=bkpGybzdDSxBGUdhE67Doit2e7emaIN/k/WQRzsR284jOj4TwFMlnV20DjFC0EYX2w4SgRewjKCFv+rRZFE3iXTD7q2ohPikTUbOmUc15qI7ohe2IpkWUwuHxBBWwNQKwwtIq2HtgMCzu/bWtpLi/LwqpMV0qALQ4mhs9qSCKSc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783348674;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=nGOFMadA6trjWagAE4R3R81yB6gXYE/D7KXnaPswwtM=;
	b=YzEdmPKh2Mco7bA/gnkich800xFRjea/TYKt8ZXIBjyjE847Aag1jdJEok9MojSF
	aHzgfkog4KgjaIRW3cCdAjWRGWtVvLN/PG+YRLhYW3Cgx91WZx0H0x1s2U3R/bM83lt
	PVFS8C5E7PnvRD4Nc8gDdIGpaiXDXvHU46oY+yx8=
Received: by mx.zohomail.com with SMTPS id 1783348672663992.9747630995766;
	Mon, 6 Jul 2026 07:37:52 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Mon, 06 Jul 2026 11:37:14 -0300
Subject: [PATCH v5 3/4] rust: clk: add devres-managed clks
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-clk-type-state-v5-3-67c5f326a16c@collabora.com>
References: <20260706-clk-type-state-v5-0-67c5f326a16c@collabora.com>
In-Reply-To: <20260706-clk-type-state-v5-0-67c5f326a16c@collabora.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Danilo Krummrich <dakr@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Michal Wilczynski <m.wilczynski@samsung.com>, Boqun Feng <boqun@kernel.org>, 
 Boqun Feng <boqun@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org, 
 linux-pwm@vger.kernel.org, linux-clk@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, Maurice <mhi@mailbox.org>
X-Mailer: b4 0.15.2
X-ZohoMailClient: External
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:rafael@kernel.org,m:viresh.kumar@linaro.org,m:dakr@kernel.org,m:aliceryhl@google.com,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:tzimmermann@suse.de,m:airlied@gmail.com,m:simona@ffwll.ch,m:fustini@kernel.org,m:guoren@kernel.org,m:wefu@redhat.com,m:ukleinek@kernel.org,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:ojeda@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:daniel.almeida@collabora.com,m:m.wilczynski@samsung.com,m:boqun@kernel.org,m:linux-pm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-riscv@lists.infradead.org,m:linux-pwm@vger.kernel.org,m:linux-clk@vger.kernel.org,m:rust-for-linux@vger.kernel.org,m:boris.brezillon@collabora.com,m:work@onurozkan.dev,m:mhi@mailbox.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,linaro.org,google.com,linux.intel.com,suse.de,gmail.com,ffwll.ch,redhat.com,baylibre.com,garyguo.net,protonmail.com,umich.edu,collabora.com,samsung.com];
	FORGED_SENDER(0.00)[daniel.almeida@collabora.com,linux-pwm@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[35];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-9610-lists,linux-pwm=lfdr.de];
	DKIM_TRACE(0.00)[collabora.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.almeida@collabora.com,linux-pwm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2D91E7138BB

The clk API allows fine-grained control, but some drivers might be
more interested in a "set and forget" API.

Expand the current API to support this. The clock will automatically be
disabled, unprepared and freed when the device is unbound from the bus
without further intervention by the driver.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/kernel/clk.rs | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/rust/kernel/clk.rs b/rust/kernel/clk.rs
index dd5fd656271e..b9a44f83843a 100644
--- a/rust/kernel/clk.rs
+++ b/rust/kernel/clk.rs
@@ -96,6 +96,52 @@ impl Sealed for super::Prepared {}
         impl Sealed for super::Enabled {}
     }
 
+    /// Obtains and enables a [`devres`]-managed [`Clk`] for a bound device.
+    ///
+    /// [`devres`]: crate::devres::Devres
+    #[inline]
+    pub fn devm_enable(dev: &Device<Bound>, name: Option<&CStr>) -> Result {
+        let name = name.map_or(ptr::null(), |n| n.as_char_ptr());
+
+        // SAFETY: It is safe to call [`devm_clk_get_enabled`] with a valid
+        // device pointer.
+        from_err_ptr(unsafe { bindings::devm_clk_get_enabled(dev.as_raw(), name) })?;
+        Ok(())
+    }
+
+    /// Obtains and enables a [`devres`]-managed [`Clk`] for a bound device.
+    ///
+    /// This does not print any error messages if the clock is not found.
+    ///
+    /// [`devres`]: crate::devres::Devres
+    #[inline]
+    pub fn devm_enable_optional(dev: &Device<Bound>, name: Option<&CStr>) -> Result {
+        let name = name.map_or(ptr::null(), |n| n.as_char_ptr());
+
+        // SAFETY: It is safe to call [`devm_clk_get_optional_enabled`] with a
+        // valid device pointer.
+        from_err_ptr(unsafe { bindings::devm_clk_get_optional_enabled(dev.as_raw(), name) })?;
+        Ok(())
+    }
+
+    /// Same as [`devm_enable_optional`], but also sets the rate.
+    #[inline]
+    pub fn devm_enable_optional_with_rate(
+        dev: &Device<Bound>,
+        name: Option<&CStr>,
+        rate: Hertz,
+    ) -> Result {
+        let name = name.map_or(ptr::null(), |n| n.as_char_ptr());
+
+        // SAFETY: It is safe to call
+        // [`devm_clk_get_optional_enabled_with_rate`] with a valid device
+        // pointer.
+        from_err_ptr(unsafe {
+            bindings::devm_clk_get_optional_enabled_with_rate(dev.as_raw(), name, rate.as_hz())
+        })?;
+        Ok(())
+    }
+
     /// A trait representing the different states that a [`Clk`] can be in.
     pub trait ClkState: private::Sealed {
         /// Whether the clock is enabled in this state.

-- 
2.54.0


