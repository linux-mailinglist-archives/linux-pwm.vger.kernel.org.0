Return-Path: <linux-pwm+bounces-8048-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AibA/UZgmmZPAMAu9opvQ
	(envelope-from <linux-pwm+bounces-8048-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 03 Feb 2026 16:53:25 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E6BDB8D4
	for <lists+linux-pwm@lfdr.de>; Tue, 03 Feb 2026 16:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 640313141794
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Feb 2026 15:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF503C199C;
	Tue,  3 Feb 2026 15:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JMhDliBQ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D3C3C1964
	for <linux-pwm@vger.kernel.org>; Tue,  3 Feb 2026 15:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770133609; cv=none; b=piPdLKQSFL8os+4ubLW/gbslqQ1rWLnNF9vUcm2qCazQ5dnDk2Ig2z8vrARzrxPDwIgMFIIX3M8TfCe+bumI/aNiRU+lPW34hpfpEqksTWtrKp0Rwx0DiIagHnwVuIFAQo0sscFmmBooqO+eiftdRq4HYovYyR8/1pXjrWPQFpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770133609; c=relaxed/simple;
	bh=WtZdKvjX12D2Jmn1kMkn/+vs+NvlqXqrgcd1O83Ixd4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TV3IJfpk6bVetBqrH+02k8WAoJ3pdytjQrwsV3yvsvuRLwu/6JRHkIwsOovo/sDF7cYg9B6OuwcOmUqdVbfSJ3cagv8vh38q/n6e/pO9jCCMCbnfT5VfBXf+7lN4fYYjVpICv9pQ9/BNUHtv5S/ITyrc/KdVO9woF5YxtsKlx6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JMhDliBQ; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-124627fc58dso9318490c88.1
        for <linux-pwm@vger.kernel.org>; Tue, 03 Feb 2026 07:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770133604; x=1770738404; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wdhof5UcFa0LauNDEG7A5hw9JfGF2S2FIbHiIBJlkVI=;
        b=JMhDliBQdB401m4c4C0KNuAymBVfVm7HIC3RuXQTEm/8bbPFzsTTksVSBFYkqmOyas
         TXkhkwlbVMspSvdCp5nC0BM718ZtxV7B48osVyq9e1zAuefYTAuJogGA5DHYFgwoxQ6w
         xcMWnRMmRdSShoDOXPoQLtJ+C+H2dnQr6FndrE1wF7Ql7lTZ/kYzmsVGqNdTLUxlo0Ja
         a7QdvpZKPZnEUyFzXIvct+1HAHp+4atlbE5lFJJbF2SIgOCQ4MS5BAqTvbO1Q8VxgH4z
         u4EbCQjPrPxXbgmM+oVuRXGuHU84jceziqxUbHg2fIGaFLSa0+mB+oiPSypwmS2vmRCU
         MKmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770133604; x=1770738404;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wdhof5UcFa0LauNDEG7A5hw9JfGF2S2FIbHiIBJlkVI=;
        b=Zt2gQSpU0p+Mm1cBhd8Gu4HQh46MhNf4TgztQHI+v3Fdlbx3fSrYRGB92StkQcpGKG
         FxCjGyIhK8XVyidzY+LaifBIJw4sY6XLlYWh96u6vbjxZtvALjMHgZ97twln7+cOKvs7
         rxBY9vbxLO5fMPB+R0kpJYqLgve2sjiXmWch7S9Vuvuc5aCl+aZO7PM6tqtEh9BEsnwl
         zhSznbZdbBq3EGP1oAoiUuUJURsBG/6744DVnCCZ1Tq10tuYmAOYW3fCe1edJlhiHWsR
         YE+Y1TIl/BM97/zEEEJEBxiqyM/WjCjDYZLHQFBBBsulEVRl5Rj9tMujEGoHy7N5DUYI
         nXQA==
X-Forwarded-Encrypted: i=1; AJvYcCWu4dKXNYmc77u3adXGWfQv1aRvyKLj7JnufSqQQXJt59Fm3vAeRsyRvbYhzsbUOA9XgNAGmK+/G5s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2ZOVmGd0kmd7xHJfPBsHDJ3CTW6aKhA3aMGDH/fYuzYRmEe7v
	+s9JUQO+k2gKF3bVhacYoU0K7TJIX7k2S8+RILhjicJWUkz/w3V4r6G1U66+p02AetTDhMqpFEi
	GnYr+A5uR1Q==
X-Received: from dlcip4.prod.google.com ([2002:a05:7023:c084:b0:124:a6e8:e9eb])
 (user=mmaurer job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6281:b0:11b:9386:8271
 with SMTP id a92af1059eb24-125c10081bamr8120436c88.46.1770133603693; Tue, 03
 Feb 2026 07:46:43 -0800 (PST)
Date: Tue, 03 Feb 2026 15:46:34 +0000
In-Reply-To: <20260203-qcom-socinfo-v2-0-d6719db85637@google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260203-qcom-socinfo-v2-0-d6719db85637@google.com>
X-Developer-Key: i=mmaurer@google.com; a=ed25519; pk=2Ezhl7+fEjTOMVFpplDeak2AdQ8cjJieLRVJdNzrW+E=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770133593; l=2442;
 i=mmaurer@google.com; s=20250429; h=from:subject:message-id;
 bh=WtZdKvjX12D2Jmn1kMkn/+vs+NvlqXqrgcd1O83Ixd4=; b=y1zunl2p/I9o6cmWUb2NnYfAPstnO8iv9BQaW1CxpWleUmklNBei8N2Of6dN4lKwNKIrkORJy
 w7+q2IWbzENDidaJ41cve7e/37dXsY/YHczM8JnE76IbaJ4tUPyi7qM
X-Mailer: b4 0.14.2
Message-ID: <20260203-qcom-socinfo-v2-5-d6719db85637@google.com>
Subject: [PATCH v2 5/6] rust: debugfs: Allow access to device in
 Devres-wrapped scopes
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8048-lists,linux-pwm=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,quicinc.com,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu,collabora.com,linuxfoundation.org,ffwll.ch,samsung.com,intel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmaurer@google.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A3E6BDB8D4
X-Rspamd-Action: no action

This adds support for creating a DebugFS directory which is aware that
it is bound to a device. As a result, callbacks under that directory
have access to a bound device which gives them efficient access to other
Devres, ability to use dev_err! and friends, etc.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 rust/kernel/debugfs.rs | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/rust/kernel/debugfs.rs b/rust/kernel/debugfs.rs
index d7b8014a6474698235203f2b7d8fec96f2bb43f8..ac614d693fa73929d095b669e9ba61958bec609e 100644
--- a/rust/kernel/debugfs.rs
+++ b/rust/kernel/debugfs.rs
@@ -11,6 +11,11 @@
 #[cfg(CONFIG_DEBUG_FS)]
 use crate::sync::Arc;
 use crate::{
+    device::{
+        Bound,
+        Device, //
+    },
+    devres::Devres,
     fmt,
     prelude::*,
     str::CStr,
@@ -722,3 +727,38 @@ fn new(name: &CStr) -> ScopedDir<'data, 'static> {
         }
     }
 }
+
+impl<'a, T: 'a + Send> Devres<Scope<T>> {
+    /// Creates a new scope, which is a directory at the root of the debugfs filesystem,
+    /// associated with some data `T`, enclosed in a [`Devres`] for the provided device.
+    ///
+    /// The `init` closure is called to populate the directory with files and subdirectories. These
+    /// files can reference the data stored in the scope. Because it is stored inside a `Devres`,
+    /// the init method is granted access to a `&Device<Bound>`.
+    ///
+    /// This can be used for cheaply accessing device-protected data inside DebugFS methods or
+    /// accessing device-specific methods (e.g. [`dev_err!`]).
+    ///
+    /// The entire directory tree created within the scope will be removed when the returned
+    /// `Scope` handle is dropped.
+    pub fn dir<E: 'a, F>(
+        dev: &'a Device<Bound>,
+        data: impl PinInit<T, E> + 'a,
+        name: &'a CStr,
+        init: F,
+    ) -> impl PinInit<Self, Error> + 'a
+    where
+        F: for<'data, 'dir> FnOnce(&'data T, &'data Device<Bound>, &'dir ScopedDir<'data, 'dir>)
+            + 'a,
+        Error: From<E>,
+    {
+        Devres::new(
+            dev,
+            Scope::new(data, |data| {
+                let scoped = ScopedDir::new(name);
+                init(data, dev, &scoped);
+                scoped.into_entry()
+            }),
+        )
+    }
+}

-- 
2.53.0.rc2.204.g2597b5adb4-goog


