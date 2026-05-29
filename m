Return-Path: <linux-pwm+bounces-9208-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCrzJfm4GWpByggAu9opvQ
	(envelope-from <linux-pwm+bounces-9208-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 29 May 2026 18:04:09 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C61605413
	for <lists+linux-pwm@lfdr.de>; Fri, 29 May 2026 18:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B8AE303C64F
	for <lists+linux-pwm@lfdr.de>; Fri, 29 May 2026 15:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816D33CAA48;
	Fri, 29 May 2026 15:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=privacyrequired.com header.i=@privacyrequired.com header.b="hWq0NfUP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from latitanza.investici.org (latitanza.investici.org [185.218.207.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA243328FD;
	Fri, 29 May 2026 15:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.218.207.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780069716; cv=none; b=q3Tg2sesRNx76YFr8j3WInqae2haRzxgCaPi2ty4S76IcmtMWRskyYYhaR0cVQxdd5U3IFnPzQHBG5vrhkhKWjERPTAMaCIP2DxdfYb4/8KD4dq6z7vv2EQ+K0SsiMOUt+RyUzP8kNfY7A+crHBoiTdXYBJyUGwAB+0AuZohTAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780069716; c=relaxed/simple;
	bh=y/UeTu/E1r5exlVyd6PZjhTTC8A/Dm1i+hrIlYJiOko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HkOOp9Rg9rZjMYa9bvo+9pcaLBKL93igFeDhDoPVH5vMoNux/EG2DffE+y9Nzv2ouRAKdDdsqifJNDziA+mRX56Wocj6QqE1fsUZdsBYCReq7jn70i2IuE2S5cVidP/1IdMbkSwSjw0rCuwq37Ng49z9vn8QjmkDhP/sEWd4fk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=privacyrequired.com; spf=pass smtp.mailfrom=privacyrequired.com; dkim=pass (1024-bit key) header.d=privacyrequired.com header.i=@privacyrequired.com header.b=hWq0NfUP; arc=none smtp.client-ip=185.218.207.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=privacyrequired.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=privacyrequired.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=privacyrequired.com;
	s=stigmate; t=1780069119;
	bh=nE54WBHYh18XBHfnL0b5qXxtCiVRQLEV3D90GwnfxZ0=;
	h=From:To:Cc:Subject:Date:From;
	b=hWq0NfUPgqiqJmc3usdGSgAYA58479noSbGOwGZyMsmyweq3POdX1KE49t6RqFWCK
	 +fEZXwmhvCefNA6y7RPPynrDHf/U0gqwOQWXew4uEvak6grMVvzy3aRI6Fjxa499cX
	 T5/TA5t7Hrp5F+go+BR3JDpjBHmxu0eMcQQafi+8=
Received: from mx3.investici.org (unknown [127.0.0.1])
	by latitanza.investici.org (Postfix) with ESMTP id 4gRnZR0G95zGpC7;
	Fri, 29 May 2026 15:38:39 +0000 (UTC)
Received: from [185.218.207.228] (mx3.investici.org [185.218.207.228]) (Authenticated sender: laniel_francis@privacyrequired.com) by localhost (Postfix) with ESMTPSA id 4gRnZP4RyDzGp9y;
	Fri, 29 May 2026 15:38:37 +0000 (UTC)
From: Francis Laniel <laniel_francis@privacyrequired.com>
To: Michal Wilczynski <m.wilczynski@samsung.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Benno Lossin <lossin@kernel.org>,
	Gary Guo <gary@garyguo.net>
Cc: Francis Laniel <laniel_francis@privacyrequired.com>,
	Boqun Feng <boqun@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-pwm@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] rust: pwm: use pin_init::zeroed() to initialize pwm_ops
Date: Fri, 29 May 2026 18:38:20 +0300
Message-ID: <20260529153821.126823-1-laniel_francis@privacyrequired.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[privacyrequired.com,reject];
	R_DKIM_ALLOW(-0.20)[privacyrequired.com:s=stigmate];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[privacyrequired.com,kernel.org,protonmail.com,google.com,umich.edu,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-9208-lists,linux-pwm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[privacyrequired.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[laniel_francis@privacyrequired.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pwm];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,privacyrequired.com:email,privacyrequired.com:mid,privacyrequired.com:dkim]
X-Rspamd-Queue-Id: 41C61605413
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Replace unsafe block containing core::mem::zeroed by calling
pin_init::zeroed().
This is safer, as this function is guarded by trait contrary to
core::mem:zeroed().
Also, we can call this because all fields in pwm_ops, i.e. function
pointers in Option<> and usize, are Zeroable.

Link: https://github.com/Rust-for-Linux/linux/issues/1189
Signed-off-by: Francis Laniel <laniel_francis@privacyrequired.com>
---
 rust/kernel/pwm.rs | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/rust/kernel/pwm.rs b/rust/kernel/pwm.rs
index 6c9d667009ef..3427b7d93a03 100644
--- a/rust/kernel/pwm.rs
+++ b/rust/kernel/pwm.rs
@@ -494,9 +494,7 @@ pub(crate) fn as_raw(&self) -> *const bindings::pwm_ops {
 /// This is used to bridge Rust trait implementations to the C `struct pwm_ops`
 /// expected by the kernel.
 pub const fn create_pwm_ops<T: PwmOps>() -> PwmOpsVTable {
-    // SAFETY: `core::mem::zeroed()` is unsafe. For `pwm_ops`, all fields are
-    // `Option<extern "C" fn(...)>` or data, so a zeroed pattern (None/0) is valid initially.
-    let mut ops: bindings::pwm_ops = unsafe { core::mem::zeroed() };
+    let mut ops: bindings::pwm_ops = pin_init::zeroed();
 
     ops.request = Some(Adapter::<T>::request_callback);
     ops.capture = Some(Adapter::<T>::capture_callback);
-- 
2.47.3


