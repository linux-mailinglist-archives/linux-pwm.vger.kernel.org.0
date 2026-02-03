Return-Path: <linux-pwm+bounces-8046-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKhhBJIYgmmZPAMAu9opvQ
	(envelope-from <linux-pwm+bounces-8046-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 03 Feb 2026 16:47:30 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84090DB7DD
	for <lists+linux-pwm@lfdr.de>; Tue, 03 Feb 2026 16:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1B03C3099894
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Feb 2026 15:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4C73C196B;
	Tue,  3 Feb 2026 15:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QWWpbDi+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634423BFE5D
	for <linux-pwm@vger.kernel.org>; Tue,  3 Feb 2026 15:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770133603; cv=none; b=pijY2K7M9Rxjh1NHCkY1xxy9mvHVn0pOXZG3UQA+5IUxNzl1mJ5nkFf+N3FtTXWKYLBsj4jSDbwsAH/DMojcYLx6tTGPQOuq0fHo2UKlcIv7ZhEj0gnb74E4ahLldASqQdl3wSL9p3Iz5sXfsRcZ8AGyeJlz1cfsxwdYnVsHsto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770133603; c=relaxed/simple;
	bh=RwCJ/xEwqbjligRdRo7donBAUlsdrVxdbuTW9DJLV3g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n2Idcy9UrPGPpd0cgUDwTkqqI5OUG2SUdA7YhEmIw2vsiKacKgUEDam4DvxRxGddla8Sdm6Ltxb2/Oj48CkLbQZyyo2cyAVVlSWTprzx/9f6DU3Qt0O3N/2tuliFTkLfXSbgfTMjdxTr39eVHqNuKoiIWouCIFnNdHreK0dgoSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QWWpbDi+; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2b74aff34efso10550374eec.1
        for <linux-pwm@vger.kernel.org>; Tue, 03 Feb 2026 07:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770133600; x=1770738400; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KdXVf1jtiVVdnaqb+rLnoB8/QmUjcxzniTwKjo2bXrU=;
        b=QWWpbDi+07DEGZt/vbKJ4gHNZQvQ9xKkTh6732LHW4Pw7iLWmQPaPw40lm/jK1iXFv
         RsaY+EyR9ugT8iRjNWYsQIz1WYyFkALVnbRps2rNI4MePXVn+R3HTfn0sd47SAYRESmm
         VdM68Uzak3YXOm3T1MiTs9pny8iOXHAQNiiR7Bh2L17xpL4bISRbqjE8xe8bNPD/bimA
         q/3aMkFxtIKqOqH49AuO4K/nB7Hwzc7iyMgpG40QINdvujP6h3q2gDd1SxJ0DR4OehQW
         YlWFgqYRM8NgxMibh9YHCkNx1FQ84lHH14/keobHJFY1ilaYorqUT27KXV8kqoFJVS7N
         W85A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770133600; x=1770738400;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KdXVf1jtiVVdnaqb+rLnoB8/QmUjcxzniTwKjo2bXrU=;
        b=iWcbNU+yyDUBZu8NXq1O1QQEZil6M2bGJlmPLCaHvVrICewt4B7qPCIH0Dz8wPeaWa
         v74opJsBxqqlZqap6cmPstCaXd9vYVvV96+rlpSoMyBOizxFwCBw37LSEKHbKdPyZGFX
         Wfm0A15c6wu5+1q58WZVd+5xfACCAnKlxMYO7uWlJsw6UKQ4GyXUhlDMyoh7QNxEoPVd
         tJB9f4TpZ4BJMZJI9q1EOO2E1XLXQSGZ0wdhxLxRXBuzkBXHs3vswK6xFeX7XOKmI8OG
         nTrZ5fnhMJTWZaDawCydX9GLuirFVq9Tkmk4Juu03Cz86a6BvMtvDX6NqmgfIzd9U2od
         CY9A==
X-Forwarded-Encrypted: i=1; AJvYcCUK/UIGYhYh9WXGowppVeSeyRS/prG0quUJt1KW5uk+AsZyVH0KbpWzn6g3a4eBGPh8oooBKbI5C4k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfv0GhOa5FJliqCNht94SKCs6qYvPQc8zmK838UuxV//P4BOhW
	obo6uPWeV+g8L1yG2Tn0GnBmIOZeCH8M9ZueVwoDCC6ganGuycflhqgxVOm+lODD9LXRjLwyq/q
	DDE90NXkEQQ==
X-Received: from dycrt20.prod.google.com ([2002:a05:693c:2d94:b0:2b6:c6a7:636a])
 (user=mmaurer job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:3002:b0:2b6:c617:f795
 with SMTP id 5a478bee46e88-2b7c86663c1mr7418033eec.17.1770133600442; Tue, 03
 Feb 2026 07:46:40 -0800 (PST)
Date: Tue, 03 Feb 2026 15:46:32 +0000
In-Reply-To: <20260203-qcom-socinfo-v2-0-d6719db85637@google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260203-qcom-socinfo-v2-0-d6719db85637@google.com>
X-Developer-Key: i=mmaurer@google.com; a=ed25519; pk=2Ezhl7+fEjTOMVFpplDeak2AdQ8cjJieLRVJdNzrW+E=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770133593; l=2963;
 i=mmaurer@google.com; s=20250429; h=from:subject:message-id;
 bh=RwCJ/xEwqbjligRdRo7donBAUlsdrVxdbuTW9DJLV3g=; b=SQdCmaIOesp2nNqbcmI1qfM3G5NEMlAiTI7JoMUcwHSNW8vyq+fqK1lL17+OwnTzARN5rGU+z
 9PyU4DL3NSyDmB3rGdnOpkIMgMGTW/9HGTk/h/gqJgPbPfyQrUyBmYk
X-Mailer: b4 0.14.2
Message-ID: <20260203-qcom-socinfo-v2-3-d6719db85637@google.com>
Subject: [PATCH v2 3/6] rust: device: Support testing devices for equality
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8046-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 84090DB7DD
X-Rspamd-Action: no action

This allows device drivers to check if, for example, an auxiliary
devices is one of its children by comparing the parent field, or
checking if a device parameter is its own device.

Also convert existing `.as_raw() != .as_raw()` to  use this new
implementation.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 rust/kernel/device.rs     | 8 ++++++++
 rust/kernel/devres.rs     | 2 +-
 rust/kernel/drm/driver.rs | 2 +-
 rust/kernel/pwm.rs        | 2 +-
 4 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 94e0548e76871d8b7de309c1f1c7b77bb49738ed..aa10359d3ebdd1c99cc567a35b89f52ddb2ee050 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -516,6 +516,14 @@ unsafe impl Send for Device {}
 // synchronization in `struct device`.
 unsafe impl Sync for Device {}
 
+impl<Ctx: DeviceContext, Ctx2: DeviceContext> PartialEq<Device<Ctx2>> for Device<Ctx> {
+    fn eq(&self, other: &Device<Ctx2>) -> bool {
+        self.as_raw() == other.as_raw()
+    }
+}
+
+impl<Ctx: DeviceContext> Eq for Device<Ctx> {}
+
 /// Marker trait for the context or scope of a bus specific device.
 ///
 /// [`DeviceContext`] is a marker trait for types representing the context of a bus specific
diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index cdc49677022a6b466e771d9d8cf3818ab9b9112d..20126daad193370868661b9412937937eda6d3c4 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -281,7 +281,7 @@ pub fn device(&self) -> &Device {
     /// }
     /// ```
     pub fn access<'a>(&'a self, dev: &'a Device<Bound>) -> Result<&'a T> {
-        if self.dev.as_raw() != dev.as_raw() {
+        if self.dev.as_ref() != dev {
             return Err(EINVAL);
         }
 
diff --git a/rust/kernel/drm/driver.rs b/rust/kernel/drm/driver.rs
index f30ee4c6245cda72ac72852bf9362736d8fe992f..497ef46028d560bc9649dbbdf69316ce4fce8199 100644
--- a/rust/kernel/drm/driver.rs
+++ b/rust/kernel/drm/driver.rs
@@ -139,7 +139,7 @@ pub fn new_foreign_owned(
     where
         T: 'static,
     {
-        if drm.as_ref().as_raw() != dev.as_raw() {
+        if drm.as_ref() != dev {
             return Err(EINVAL);
         }
 
diff --git a/rust/kernel/pwm.rs b/rust/kernel/pwm.rs
index cb00f8a8765c8ec58ed78a73275b022b02bf7aa3..033f778909a2633acbc25d5a21a1c8a7b8e41a70 100644
--- a/rust/kernel/pwm.rs
+++ b/rust/kernel/pwm.rs
@@ -680,7 +680,7 @@ impl<T: 'static + PwmOps + Send + Sync> Registration<T> {
     /// calling `pwmchip_remove`. This function should be called from the driver's `probe`.
     pub fn register(dev: &device::Device<Bound>, chip: ARef<Chip<T>>) -> Result {
         let chip_parent = chip.device().parent().ok_or(EINVAL)?;
-        if dev.as_raw() != chip_parent.as_raw() {
+        if dev != chip_parent {
             return Err(EINVAL);
         }
 

-- 
2.53.0.rc2.204.g2597b5adb4-goog


