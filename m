Return-Path: <linux-pwm+bounces-9223-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DPyGIYvsHmqwZAAAu9opvQ
	(envelope-from <linux-pwm+bounces-9223-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 02 Jun 2026 16:45:31 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5D762F6A4
	for <lists+linux-pwm@lfdr.de>; Tue, 02 Jun 2026 16:45:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=privacyrequired.com header.s=stigmate header.b=FAoBtotV;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9223-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9223-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=privacyrequired.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C3FBF30202A1
	for <lists+linux-pwm@lfdr.de>; Tue,  2 Jun 2026 14:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C903BAD82;
	Tue,  2 Jun 2026 14:30:26 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BBA1DA60D;
	Tue,  2 Jun 2026 14:30:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410626; cv=none; b=O0H3uFvLRFNA59sywgIFyHlE9X6X/DnmsOB1aOjarkqypstDJTHXPeOi/i7cutqcOSt8KfiwPYKvbC90UreYCc8gIrNyUl4o1H+yrlobqqnpKWmB0VGjX37DMRDT4oe5/cvmOC6IV0ghw+Sd2kb/njzu78dZrLlf56bV97q1D1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410626; c=relaxed/simple;
	bh=16i/JJjNhoMN1c1Ms7nybdLc81QMezO68mt+246DxSo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E7NzJyIsbfJb9leu2OIcd/5XjZZCZda+RAXtKEOxNc0ppYzcI8+GYvnXGv3jHq/tG/1rAlrO6R1VUUynA6oES9uycqNkQz2gw2TuW+c8npimZ+tthMKDeRC1hRijty/jhLxsMIJ5pA+L/cQPvR0NBzM7WUwDZkxq4P0FIcdOXrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=privacyrequired.com; spf=pass smtp.mailfrom=privacyrequired.com; dkim=pass (1024-bit key) header.d=privacyrequired.com header.i=@privacyrequired.com header.b=FAoBtotV; arc=none smtp.client-ip=93.190.126.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=privacyrequired.com;
	s=stigmate; t=1780410619;
	bh=6TKcjPnH0nC1FrF6sUHUFL2v1lRBfi1+s/MSYZAUc40=;
	h=From:To:Cc:Subject:Date:From;
	b=FAoBtotVFVugE4ZqRUGdbc1U50XhYOIsxJMvVfIaa1j4lY/0QOWH44C0Ih+6jth6M
	 dayy6jErXtVxhoAZo3648e9zrIrpA0I/q9IVbBSQMfWxdr23KWu/SJl8/K7jPRo6nJ
	 kWOhPqdy6dRf8ah51sWH0WJzWURCVhFnOg626QXo=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4gVCsl6PH7z11MR;
	Tue, 02 Jun 2026 14:30:19 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4gVCsk3BrBz11Ll;
	Tue, 02 Jun 2026 14:30:18 +0000 (UTC)
From: Francis Laniel <laniel_francis@privacyrequired.com>
To: Michal Wilczynski <m.wilczynski@samsung.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Benno Lossin <lossin@kernel.org>,
	Gary Guo <gary@garyguo.net>
Cc: Francis Laniel <laniel_francis@privacyrequired.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Boqun Feng <boqun@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-pwm@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] rust: pwm: replace `core::mem::zeroed` with `pin_init::zeroed`
Date: Tue,  2 Jun 2026 17:30:00 +0300
Message-ID: <20260602143002.38390-1-laniel_francis@privacyrequired.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[privacyrequired.com,reject];
	R_DKIM_ALLOW(-0.20)[privacyrequired.com:s=stigmate];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[privacyrequired.com,nvidia.com,kernel.org,protonmail.com,google.com,umich.edu,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-9223-lists,linux-pwm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[laniel_francis@privacyrequired.com,linux-pwm@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:m.wilczynski@samsung.com,m:ojeda@kernel.org,m:ukleinek@kernel.org,m:lossin@kernel.org,m:gary@garyguo.net,m:laniel_francis@privacyrequired.com,m:acourbot@nvidia.com,m:boqun@kernel.org,m:bjorn3_gh@protonmail.com,m:a.hindborg@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:dakr@kernel.org,m:linux-pwm@vger.kernel.org,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[laniel_francis@privacyrequired.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[privacyrequired.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[privacyrequired.com:mid,privacyrequired.com:dkim,privacyrequired.com:from_mime,privacyrequired.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:email,samsung.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2F5D762F6A4

All types in `bindings` implement `Zeroable` if they can, so use
`pin_init::zeroed` instead of relying on `unsafe` code.

If this ends up not compiling in the future, something in bindgen or on
the C side changed and is most likely incorrect.

Link: https://github.com/Rust-for-Linux/linux/issues/1189
Signed-off-by: Francis Laniel <laniel_francis@privacyrequired.com>
Suggested-by: Benno Lossin <lossin@kernel.org>
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Acked-by: Michal Wilczynski <m.wilczynski@samsung.com>
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


