Return-Path: <linux-pwm+bounces-8043-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6B/hNKcZgmmZPAMAu9opvQ
	(envelope-from <linux-pwm+bounces-8043-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 03 Feb 2026 16:52:07 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EC2DB87C
	for <lists+linux-pwm@lfdr.de>; Tue, 03 Feb 2026 16:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 405BA30E3E2F
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Feb 2026 15:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A502C3B95FC;
	Tue,  3 Feb 2026 15:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZbFNFk2g"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C9F3BFE44
	for <linux-pwm@vger.kernel.org>; Tue,  3 Feb 2026 15:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770133600; cv=none; b=bnDDp3v4Z4ZY/bIyVYYepjqBT2r0FW8YTIYk14NS7mPZu3ncwLPlRLX0vpX6/1MJSYBmIOVP9x1CYa+RQooS7PysHgALndHkeWfbpBFa/wjHfNSguM6sESrWkrw1PK2JHjwTu3I7nL0FyEWZ7iIcI4ydojVtfV/5E96t1pQklDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770133600; c=relaxed/simple;
	bh=toV72FONVd+c77Jdi9/X05RZt7qiox3e/hnCpHZii2E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EMJhStlFeiXyu5ADzDIpzL34lWf2oCHwUwiCiqAWz20QYUAUph55aYk0n5ZFV82EQaVasOEwKxN6lZDObaG9SW5UkGo76g8qmkowHrbdicbbx3keMXZGwZQXCCAYgCKnkg8Ff0jVzpHTx69f6KHiqUxb4eveo1Ovx5k4qVU9cKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZbFNFk2g; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2b7ef896edcso14447388eec.0
        for <linux-pwm@vger.kernel.org>; Tue, 03 Feb 2026 07:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770133597; x=1770738397; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h/wJPUnQVMCcHAFscBghK0MQ8yiIElHndU1rZLXdeks=;
        b=ZbFNFk2gSwMTms9IgyqABz1Tfmdd70Jk9hs6D8rXVhNnDQYCX4qhfqmhECBZTceWcR
         4f1dESGCKHR3g2cDj9DE/x2reuG4HACMs/B0BeCtkvByHsOJzNmahqr8++Qy2/85I5rB
         0G3MnhIW55WPfcfNhuZiTU6KhoKn64Ci3CeRNc8yVzovWg6kdb/gRgrGGp5RY+R28IPn
         eR0wgZ+vCgRkh6+T14q1HU16VnX7C+78Wao8XP4nNS7vfCtBF3cjZ8aVPc1XW5+AEklt
         6nr1Q2aKhTyCyDrRa6UfJJ+9wZ7qDHGHogTjMhd9K8R+6l/jJh6oDh6TqkuE7W5qQgKz
         6IEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770133597; x=1770738397;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h/wJPUnQVMCcHAFscBghK0MQ8yiIElHndU1rZLXdeks=;
        b=PO1GJdTIm9jX/M0g8wCU0eBYjQMMX16oWqTPnv3tdATNyZ/sLThOKViGn4oF9rVRR1
         XBEci3NZ97mLvxwMDeCHoJqvl4pU7dc9yYa7PEpzOPYA5dI0wOXujHepSMS1a6fEIwyx
         qaD2Yj6NwvIXxkUvGPeIUlavUqJpZ7lDwvvoeTpBPzX3omca5xZqy6r3TNo59GziG8/b
         EaUhWeUK/IJTQkkADY4Obtiv26tBl4TyioLDoo7XItH/EkXRybnoIRj9/AXsb3Kr83B1
         6cY5vunLkCi/vyyCKJXOzzUSp/4s5wNLw1AheJ0wFaJGjpl3gOHpnlyQ3S2UzjiWv7/y
         xppg==
X-Forwarded-Encrypted: i=1; AJvYcCVvQJIe7+2rv1h4JpHZR0oMNitf2I7pYa9x5d/hchxzU6jcAKUyY6koifkuVm4VCW3yd0T/mEKeqiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFjORGZwLLHMR5xKW13G5E9iTpCN22/p6jFyeqpjIIpM7S8CXG
	QoEgtc+fKdIHyeGRjPyFG8+IZyVM1ouxylpg80OF5e22hF8aDcSE3hCj0QVG9+nZ5Eiln85iPhN
	lE4cw43epyA==
X-Received: from dybny37.prod.google.com ([2002:a05:7300:e825:b0:2ae:51e3:c162])
 (user=mmaurer job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:7bc2:b0:2b7:20c6:36dc
 with SMTP id 5a478bee46e88-2b7c8960b21mr6824371eec.42.1770133597088; Tue, 03
 Feb 2026 07:46:37 -0800 (PST)
Date: Tue, 03 Feb 2026 15:46:30 +0000
In-Reply-To: <20260203-qcom-socinfo-v2-0-d6719db85637@google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260203-qcom-socinfo-v2-0-d6719db85637@google.com>
X-Developer-Key: i=mmaurer@google.com; a=ed25519; pk=2Ezhl7+fEjTOMVFpplDeak2AdQ8cjJieLRVJdNzrW+E=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770133593; l=1885;
 i=mmaurer@google.com; s=20250429; h=from:subject:message-id;
 bh=toV72FONVd+c77Jdi9/X05RZt7qiox3e/hnCpHZii2E=; b=HmKT9Wjpe5u2hTdJ2Tcoag2Ev49Zm6fhsS7eX/dQiAxY/wxuUniXmJdhtGMd67QiHayfpx34L
 0bkddcnyzhZATSmzQBb6PghYphGlfrft9E9n7goPvqOGq6riqINeZyj
X-Mailer: b4 0.14.2
Message-ID: <20260203-qcom-socinfo-v2-1-d6719db85637@google.com>
Subject: [PATCH v2 1/6] rust: Add sparse_array! helper macro
From: Matthew Maurer <mmaurer@google.com>
To: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Satya Durga Srinivasu Prabhala <satyap@quicinc.com>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Michal Wilczynski <m.wilczynski@samsung.com>, Dave Ertman <david.m.ertman@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>
Cc: Trilok Soni <tsoni@quicinc.com>, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	linux-pwm@vger.kernel.org, Matthew Maurer <mmaurer@google.com>
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,quicinc.com,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu,collabora.com,linuxfoundation.org,ffwll.ch,samsung.com,intel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8043-lists,linux-pwm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmaurer@google.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 55EC2DB87C
X-Rspamd-Action: no action

An idiom in C code is to have an array of nullable values which is
partially initialized via `{ [0] = x, [7] = y}`. Because Rust expects
everything to be fully initialized, it does not have this idiom by
default.

`sparse_array!` allows declaration of `[Option<T>; _]` constants to
allow Rust code to more easily mimic the safe version of this pattern.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
Co-developed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/slice.rs | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/rust/kernel/slice.rs b/rust/kernel/slice.rs
index ca2cde13506196d46c9169aa6e4ab2ac42af6f5b..826b6f77f0d07775bd22837cc1773b59ec96936c 100644
--- a/rust/kernel/slice.rs
+++ b/rust/kernel/slice.rs
@@ -47,3 +47,40 @@ fn as_flattened_mut(&mut self) -> &mut [T] {
         self.flatten_mut()
     }
 }
+
+/// Create a sparse array of `[Option<T>; _]`.
+///
+/// This is intended for use when C code would write `{ [0] = x, [7] = y}` to perform partial
+/// initialization of an array.
+///
+/// # Example
+/// ```
+/// use kernel::sparse_array;
+/// const FOO: &[Option<usize>] = &sparse_array! {
+///   0: 10,
+///   7: 16,
+/// };
+/// assert_eq!(FOO[0], Some(10));
+/// assert_eq!(FOO[1], None);
+/// assert_eq!(FOO[7], Some(16));
+/// ```
+#[macro_export]
+macro_rules! sparse_array {
+    ($(
+        $index:literal: $value:expr
+    ),* $(,)?) => {{
+        const SIZE: usize = {
+            let mut size = 0;
+            $(if $index >= size {
+                size = $index + 1;
+            })*
+            size
+        };
+
+        const {
+            let mut arr = [None; SIZE];
+            $(arr[$index] = Some($value);)*
+            arr
+        }
+    }}
+}

-- 
2.53.0.rc2.204.g2597b5adb4-goog


