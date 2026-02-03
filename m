Return-Path: <linux-pwm+bounces-8047-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FjoN30YgmmZPAMAu9opvQ
	(envelope-from <linux-pwm+bounces-8047-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 03 Feb 2026 16:47:09 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AE6DB7CF
	for <lists+linux-pwm@lfdr.de>; Tue, 03 Feb 2026 16:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0EE9D303D8D0
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Feb 2026 15:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3533C1983;
	Tue,  3 Feb 2026 15:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o47zouml"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB79C3C1965
	for <linux-pwm@vger.kernel.org>; Tue,  3 Feb 2026 15:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770133604; cv=none; b=Zt620aFVxTTyGjk0IeRBgohWEPbbJLH9bl3I8M09eYH7KpZQT2yDJbvYvKjLZ1F5MsHxZsBfSq49gim1NBZu433CT5dShiGz9UAzOm/YV2zcQy88HQyWn/0+HNNLKVWTrszIDqstj64CErymcm+duq9gHxCA/qBXvVmKdsOUKNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770133604; c=relaxed/simple;
	bh=sLbxFTX2mTYV2vSHOwak0YCZYcQva6hVw82FQCeYKlk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=glARXJ22z6fwxmG+IF1isxSohj754CRq2ExPInPb/03xuM168A03lIALSnV/zYVzp247Ux5IGh/rXJKA3eyhJ3HYIkZ22DCfINBesf/ZjiSKsGTdGFaQrxtztB8XoWwKUcmI82lflVLXRZgfiG37dYDTV7Dzwlz6jICr3trD8LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o47zouml; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2b708fa4093so18384955eec.0
        for <linux-pwm@vger.kernel.org>; Tue, 03 Feb 2026 07:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770133602; x=1770738402; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yriD2nT/Os7MHztKIgeqU92FBaPsLQ1akZyLJCP9KTY=;
        b=o47zoumlJdrRlPy6ZNnwUnLc/OELYrP8hjk4+NsdIelT0dGOyfVWUtWoByfnCo+ubt
         U6Nvufmiict84IsqfV/SmComuIvgXZu/ywEpnNzbL8RyThvn3LgaK5sgfV3cVSyl/B6k
         jbPXn/q8cMFIC+8bQMQ6AWijqDRKi6bIekaJxx1JzexituXxJ+lISMQDNKPFhwPuA9UY
         cnwKY5ZtsQCukha4vODVvtUiYDsCSJBmK0Iz/eyPOkBjsHEec96kfOT3rLMfhUTk3+M7
         3V0zMVa28w+kNPLgRBpS3oPHUbyUrAqKK/IUAPN6zhino3tzd6q3famHirNjIWgDKxnz
         CIXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770133602; x=1770738402;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yriD2nT/Os7MHztKIgeqU92FBaPsLQ1akZyLJCP9KTY=;
        b=f4e7V9SGkgK2sZpiSxMos2pAJ7Truy8DSPDtyiFuTdetXkqWXm7P7TuzxNhV+mwv1l
         mFmogiB2mZgtgLGep4HMgHY8ExPq7SaEDSLIm+JVqt7l9di3VNY/Ulx4OZlQzXbQi2U0
         Zdky9Hw/gAPGNK4AGteKMJhHOe3fhOKxXVxv4jjv23E9CQ/iwCRe+MfpeiyzyF41THzc
         Zcwi17OhJb9Ak35LyaGIN5cMoa+iNpFUVjeHEbYJwA7jJdr2KZ/J80YFTDcq8GdCdZtU
         ocskCUdfSj9j5bxUJ8/nU72jUNRoZBaSDzr1xBqazl35Fb8LX/PCn1D3ans2ZJHsPQgb
         Sz8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUWB8dZW2QAi7yidAVaXquVaz+pEalKvE6sDhhRAyWMbn6jbkkK+2GglVpHyE8jjUZsGVENWwP1vXY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvt14mVXdjtft2R+Q6Sekmw/qKJbi9Mv8EWX9FGopNy+Q7hUvC
	CST/04JVScZjxI0j/1/FH/CJNFxTIMwSdslz3azM5RKSPesym2PTKZvZiiTPT/4O3UkJ7S1oHte
	KuaogDisdQQ==
X-Received: from dybhk18.prod.google.com ([2002:a05:7301:2892:b0:2b7:d91:b4a2])
 (user=mmaurer job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:7491:b0:2b7:f28d:c8c1
 with SMTP id 5a478bee46e88-2b8327328c7mr4126eec.0.1770133601984; Tue, 03 Feb
 2026 07:46:41 -0800 (PST)
Date: Tue, 03 Feb 2026 15:46:33 +0000
In-Reply-To: <20260203-qcom-socinfo-v2-0-d6719db85637@google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260203-qcom-socinfo-v2-0-d6719db85637@google.com>
X-Developer-Key: i=mmaurer@google.com; a=ed25519; pk=2Ezhl7+fEjTOMVFpplDeak2AdQ8cjJieLRVJdNzrW+E=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770133593; l=1096;
 i=mmaurer@google.com; s=20250429; h=from:subject:message-id;
 bh=sLbxFTX2mTYV2vSHOwak0YCZYcQva6hVw82FQCeYKlk=; b=lrUfeO8BzxGoH2q0cLzXZitIHc5mxhrmhIP1EvIGlTolROpSubzosdu4ukDgERhXMbVdgqt6B
 hy4MuPfZ3YMDwryq+n6Z7b1/52uJBUTXJBD7xC/OlPQKkhC26hmI+cu
X-Mailer: b4 0.14.2
Message-ID: <20260203-qcom-socinfo-v2-4-d6719db85637@google.com>
Subject: [PATCH v2 4/6] rust: auxiliary: Support accessing raw aux pointer
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8047-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B5AE6DB7CF
X-Rspamd-Action: no action

While it's preferable to add bindings in the kernel crate rather than
using raw pointers where possible, access to the raw aux pointer is
required to pass it to C interfaces provided by a driver.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 rust/kernel/auxiliary.rs | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index 93c0db1f66555c97ec7dc58825e97c47c0154e54..1a88277f0fd9ea5ff32cc534dfe5682009de94c2 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -237,7 +237,11 @@ pub struct Device<Ctx: device::DeviceContext = device::Normal>(
 );
 
 impl<Ctx: device::DeviceContext> Device<Ctx> {
-    fn as_raw(&self) -> *mut bindings::auxiliary_device {
+    /// Returns the underlying auxiliary device
+    ///
+    /// Prefer to add bindings in the kernel crate for any use other than calling driver-specific
+    /// functions.
+    pub fn as_raw(&self) -> *mut bindings::auxiliary_device {
         self.0.get()
     }
 

-- 
2.53.0.rc2.204.g2597b5adb4-goog


