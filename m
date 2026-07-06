Return-Path: <linux-pwm+bounces-9611-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Df6BEtDCS2pXZwEAu9opvQ
	(envelope-from <linux-pwm+bounces-9611-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Jul 2026 16:59:28 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2F67124BE
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Jul 2026 16:59:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=collabora.com header.s=zohomail header.b=C3hkFn9l;
	dmarc=pass (policy=none) header.from=collabora.com;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9611-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9611-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2CA4131AE3F0
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Jul 2026 14:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C723A168B;
	Mon,  6 Jul 2026 14:38:42 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003A43988FF;
	Mon,  6 Jul 2026 14:38:39 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783348722; cv=pass; b=pO7u7YdtMzDyq//zdtFanD5n2nczHfJcTCPZwdfmb5RHrOjOYzu73kVD4wmUwS81BdbkvyCyopCN8z0ZViFkPuRFcY2jXlx8jkXwCUz1thVYt5BYVSshd/3CIQYS//ivI391jVIz2z6NyBFNLO2Hh363NT1KBypOYRywkE5KsPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783348722; c=relaxed/simple;
	bh=PFPM2UNU4ub3ov41J7cRh3r2CujDcm6jx7/St/o+q2M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G2KmkBqUQuODc2TIC90rxWD0enhuzbCqtRQisgf4hAP41R7mOUBXY/QQLeLKj/NVAX1N8+gIBEdRNATxevNJr8oNkBZKqYU6da0OOUEObEBoQceVPe5mFQV4u64phIT+XLqK9QR5dX294QreHorg9IlJtif+BhgKr/lVSBAyMvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=C3hkFn9l; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal: i=1; a=rsa-sha256; t=1783348660; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NvGn8r3zpY6nc4+GSExVuuJA9aCZJmGnvrEQ+hG1EssL8DpWnD9ftS7388Sp2i6uSvsznG/m0HXI+pwZXsMoy8RqDzBeo27hoWNO4xTJ+QyTo4pUFs1o8rkbL7q/L0HPZWq1vJwMBwFaLmtoPMi05fT46YYKzhp1KyOw6Jt3OOk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783348660; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=dkVU62S/gN5JMRWsTYF5Oj/LX175vqhgkzvky/2vbBA=; 
	b=Uw80U68Z8M2mHr2XSJWleu1BFrRBkhiccZqCsqq2yg1ZwmlAOOrKMMs8nWt1QVLAfpGTnY/s3+4Bjb+s0YvVmD3LR/tbchUQ6RTcSM/CG7Dcu0cNDiQRaXsfTphNK9aVGSYy8/opwOeCrQ9Hi15JzRxw7i69fUGiC+gfdmiHGyw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783348660;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=dkVU62S/gN5JMRWsTYF5Oj/LX175vqhgkzvky/2vbBA=;
	b=C3hkFn9lISKYjxh/qt7k+028B8J2Bx+Ad8ElADQA5CyVOftG+zfHhO29YRfLETwA
	hXpOtBugSf5dIjMVarV/vHr2VBoBP26whw6gafjZ9tQP4Uk+JKgPqTjRcthu2IMEz4l
	UwwMG2QNkbTXKNW2gXOpJ3EiAvahd51bzAwADVao=
Received: by mx.zohomail.com with SMTPS id 1783348658812763.3840021470712;
	Mon, 6 Jul 2026 07:37:38 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Mon, 06 Jul 2026 11:37:12 -0300
Subject: [PATCH v5 1/4] rust: clk: use the type-state pattern
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-clk-type-state-v5-1-67c5f326a16c@collabora.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,linaro.org,google.com,linux.intel.com,suse.de,gmail.com,ffwll.ch,redhat.com,baylibre.com,garyguo.net,protonmail.com,umich.edu,collabora.com,samsung.com];
	FORGED_SENDER(0.00)[daniel.almeida@collabora.com,linux-pwm@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[35];
	FORGED_RECIPIENTS(0.00)[m:rafael@kernel.org,m:viresh.kumar@linaro.org,m:dakr@kernel.org,m:aliceryhl@google.com,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:tzimmermann@suse.de,m:airlied@gmail.com,m:simona@ffwll.ch,m:fustini@kernel.org,m:guoren@kernel.org,m:wefu@redhat.com,m:ukleinek@kernel.org,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:ojeda@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:daniel.almeida@collabora.com,m:m.wilczynski@samsung.com,m:boqun@kernel.org,m:linux-pm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-riscv@lists.infradead.org,m:linux-pwm@vger.kernel.org,m:linux-clk@vger.kernel.org,m:rust-for-linux@vger.kernel.org,m:boris.brezillon@collabora.com,m:work@onurozkan.dev,m:mhi@mailbox.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-9611-lists,linux-pwm=lfdr.de];
	DKIM_TRACE(0.00)[collabora.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.almeida@collabora.com,linux-pwm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:from_mime,collabora.com:email,collabora.com:mid,collabora.com:dkim,vger.kernel.org:from_smtp,crates.io:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,rcpufreq_dt.rs:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CA2F67124BE

The current Clk abstraction can still be improved on the following issues:

a) It only keeps track of a count to clk_get(), which means that users have
to manually call disable() and unprepare(), or a variation of those, like
disable_unprepare().

b) It allows repeated calls to prepare() or enable(), but it keeps no track
of how often these were called, i.e., it's currently legal to write the
following:

clk.prepare();
clk.prepare();
clk.enable();
clk.enable();

And nothing gets undone on drop().

c) It adds a OptionalClk type that is probably not needed. There is no
"struct optional_clk" in C and we should probably not add one.

d) It does not let a user express the state of the clk through the
type system. For example, there is currently no way to encode that a Clk is
enabled via the type system alone.

In light of the Regulator abstraction that was recently merged, switch this
abstraction to use the type-state pattern instead. It solves both a) and b)
by establishing a number of states and the valid ways to transition between
them. It also automatically undoes any call to clk_get(), clk_prepare() and
clk_enable() as applicable on drop(), so users do not have to do anything
special before Clk goes out of scope.

It solves c) by removing the OptionalClk type, which is now simply encoded
as a Clk whose inner pointer is NULL.

It solves d) by directly encoding the state of the Clk into the type, e.g.:
Clk<Enabled> is now known to be a Clk that is enabled.

The INVARIANTS section for Clk is expanded to highlight the relationship
between the states and the respective reference counts that are owned by
each of them.

The examples are expanded to highlight how a user can transition between
states, as well as highlight some of the shortcuts built into the API.

The current implementation is also more flexible, in the sense that it
allows for more states to be added in the future. This lets us implement
different strategies for handling clocks, including one that mimics the
current API, allowing for multiple calls to prepare() and enable().

The users (cpufreq.rs/ rcpufreq_dt.rs) were updated by this patch (and not
a separate one) to reflect the new changes. This is needed, because
otherwise this patch would break the build.

Link: https://crates.io/crates/sealed [1]
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 drivers/cpufreq/rcpufreq_dt.rs |   2 +-
 drivers/gpu/drm/tyr/driver.rs  |  37 +--
 drivers/pwm/pwm_th1520.rs      |  17 +-
 rust/kernel/clk.rs             | 541 ++++++++++++++++++++++++++++++-----------
 rust/kernel/cpufreq.rs         |   8 +-
 5 files changed, 423 insertions(+), 182 deletions(-)

diff --git a/drivers/cpufreq/rcpufreq_dt.rs b/drivers/cpufreq/rcpufreq_dt.rs
index f17bf64c22e2..9d2ec7df4bac 100644
--- a/drivers/cpufreq/rcpufreq_dt.rs
+++ b/drivers/cpufreq/rcpufreq_dt.rs
@@ -40,7 +40,7 @@ struct CPUFreqDTDevice {
     freq_table: opp::FreqTable,
     _mask: CpumaskVar,
     _token: Option<opp::ConfigToken>,
-    _clk: Clk,
+    _clk: Clk<kernel::clk::Unprepared>,
 }
 
 #[derive(Default)]
diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index 279710b36a10..7a85c86d26c2 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -3,7 +3,7 @@
 use kernel::{
     clk::{
         Clk,
-        OptionalClk, //
+        Enabled, //
     },
     device::{
         Bound,
@@ -49,7 +49,7 @@ pub(crate) struct TyrPlatformDriverData {
     _device: ARef<TyrDrmDevice>,
 }
 
-#[pin_data(PinnedDrop)]
+#[pin_data]
 pub(crate) struct TyrDrmDeviceData {
     pub(crate) pdev: ARef<platform::Device>,
 
@@ -97,13 +97,9 @@ fn probe(
         pdev: &platform::Device<Core>,
         _info: Option<&Self::IdInfo>,
     ) -> impl PinInit<Self, Error> {
-        let core_clk = Clk::get(pdev.as_ref(), Some(c"core"))?;
-        let stacks_clk = OptionalClk::get(pdev.as_ref(), Some(c"stacks"))?;
-        let coregroup_clk = OptionalClk::get(pdev.as_ref(), Some(c"coregroup"))?;
-
-        core_clk.prepare_enable()?;
-        stacks_clk.prepare_enable()?;
-        coregroup_clk.prepare_enable()?;
+        let core_clk = Clk::<Enabled>::get(pdev.as_ref(), Some(c"core"))?;
+        let stacks_clk = Clk::<Enabled>::get_optional(pdev.as_ref(), Some(c"stacks"))?;
+        let coregroup_clk = Clk::<Enabled>::get_optional(pdev.as_ref(), Some(c"coregroup"))?;
 
         let mali_regulator = Regulator::<regulator::Enabled>::get(pdev.as_ref(), c"mali")?;
         let sram_regulator = Regulator::<regulator::Enabled>::get(pdev.as_ref(), c"sram")?;
@@ -122,9 +118,9 @@ fn probe(
         let data = try_pin_init!(TyrDrmDeviceData {
                 pdev: platform.clone(),
                 clks <- new_mutex!(Clocks {
-                    core: core_clk,
-                    stacks: stacks_clk,
-                    coregroup: coregroup_clk,
+                    _core: core_clk,
+                    _stacks: stacks_clk,
+                    _coregroup: coregroup_clk,
                 }),
                 regulators <- new_mutex!(Regulators {
                     _mali: mali_regulator,
@@ -150,17 +146,6 @@ impl PinnedDrop for TyrPlatformDriverData {
     fn drop(self: Pin<&mut Self>) {}
 }
 
-#[pinned_drop]
-impl PinnedDrop for TyrDrmDeviceData {
-    fn drop(self: Pin<&mut Self>) {
-        // TODO: the type-state pattern for Clks will fix this.
-        let clks = self.clks.lock();
-        clks.core.disable_unprepare();
-        clks.stacks.disable_unprepare();
-        clks.coregroup.disable_unprepare();
-    }
-}
-
 // We need to retain the name "panthor" to achieve drop-in compatibility with
 // the C driver in the userspace stack.
 const INFO: drm::DriverInfo = drm::DriverInfo {
@@ -186,9 +171,9 @@ impl drm::Driver for TyrDrmDriver {
 
 #[pin_data]
 struct Clocks {
-    core: Clk,
-    stacks: OptionalClk,
-    coregroup: OptionalClk,
+    _core: Clk<Enabled>,
+    _stacks: Clk<Enabled>,
+    _coregroup: Clk<Enabled>,
 }
 
 #[pin_data]
diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
index ddd44a5ce497..343a1178c5e7 100644
--- a/drivers/pwm/pwm_th1520.rs
+++ b/drivers/pwm/pwm_th1520.rs
@@ -22,7 +22,7 @@
 
 use core::ops::Deref;
 use kernel::{
-    clk::Clk,
+    clk::{Clk, Enabled},
     device::{Bound, Core, Device},
     devres,
     io::{
@@ -89,11 +89,11 @@ struct Th1520WfHw {
 }
 
 /// The driver's private data struct. It holds all necessary devres managed resources.
-#[pin_data(PinnedDrop)]
+#[pin_data]
 struct Th1520PwmDriverData {
     #[pin]
     iomem: devres::Devres<IoMem<TH1520_PWM_REG_SIZE>>,
-    clk: Clk,
+    clk: Clk<Enabled>,
 }
 
 impl pwm::PwmOps for Th1520PwmDriverData {
@@ -298,13 +298,6 @@ fn write_waveform(
     }
 }
 
-#[pinned_drop]
-impl PinnedDrop for Th1520PwmDriverData {
-    fn drop(self: Pin<&mut Self>) {
-        self.clk.disable_unprepare();
-    }
-}
-
 struct Th1520PwmPlatformDriver;
 
 kernel::of_device_table!(
@@ -325,9 +318,7 @@ fn probe(
         let dev = pdev.as_ref();
         let request = pdev.io_request_by_index(0).ok_or(ENODEV)?;
 
-        let clk = Clk::get(dev, None)?;
-
-        clk.prepare_enable()?;
+        let clk = Clk::<Enabled>::get(dev, None)?;
 
         // TODO: Get exclusive ownership of the clock to prevent rate changes.
         // The Rust equivalent of `clk_rate_exclusive_get()` is not yet available.
diff --git a/rust/kernel/clk.rs b/rust/kernel/clk.rs
index 7abbd0767d8c..a9edfdf9db68 100644
--- a/rust/kernel/clk.rs
+++ b/rust/kernel/clk.rs
@@ -80,17 +80,103 @@ fn from(freq: Hertz) -> Self {
 mod common_clk {
     use super::Hertz;
     use crate::{
-        device::Device,
+        device::{Bound, Device},
         error::{from_err_ptr, to_result, Result},
         prelude::*,
     };
 
-    use core::{ops::Deref, ptr};
+    use core::{marker::PhantomData, mem::ManuallyDrop, ptr};
+
+    mod private {
+        pub trait Sealed {}
+
+        impl Sealed for super::Unprepared {}
+        impl Sealed for super::Prepared {}
+        impl Sealed for super::Enabled {}
+    }
+
+    /// A trait representing the different states that a [`Clk`] can be in.
+    pub trait ClkState: private::Sealed {
+        /// Whether the clock should be disabled when dropped.
+        const DISABLE_ON_DROP: bool;
+
+        /// Whether the clock should be unprepared when dropped.
+        const UNPREPARE_ON_DROP: bool;
+    }
+
+    /// A state where the [`Clk`] is not prepared and not enabled.
+    pub struct Unprepared;
+
+    /// A state where the [`Clk`] is prepared but not enabled.
+    pub struct Prepared;
+
+    /// A state where the [`Clk`] is both prepared and enabled.
+    pub struct Enabled;
+
+    impl ClkState for Unprepared {
+        const DISABLE_ON_DROP: bool = false;
+        const UNPREPARE_ON_DROP: bool = false;
+    }
+
+    impl ClkState for Prepared {
+        const DISABLE_ON_DROP: bool = false;
+        const UNPREPARE_ON_DROP: bool = true;
+    }
+
+    impl ClkState for Enabled {
+        const DISABLE_ON_DROP: bool = true;
+        const UNPREPARE_ON_DROP: bool = true;
+    }
+
+    /// An error that can occur when trying to convert a [`Clk`] between states.
+    pub struct Error<State: ClkState> {
+        /// The error that occurred.
+        pub error: kernel::error::Error,
+
+        /// The [`Clk`] that caused the error, so that the operation may be
+        /// retried.
+        pub clk: Clk<State>,
+    }
+
+    impl<State: ClkState> From<Error<State>> for kernel::error::Error {
+        /// Discards the [`Clk`] and keeps only the error code.
+        ///
+        /// This makes the fallible state transitions usable with the `?`
+        /// operator when the caller does not need to retry the operation on the
+        /// original [`Clk`], e.g.:
+        ///
+        /// ```
+        /// use kernel::clk::{Clk, Enabled, Unprepared};
+        /// use kernel::device::{Bound, Device};
+        /// use kernel::error::Result;
+        ///
+        /// fn get_enabled(dev: &Device<Bound>) -> Result<Clk<Enabled>> {
+        ///     let clk = Clk::<Unprepared>::get(dev, Some(c"apb_clk"))?
+        ///         .prepare()?
+        ///         .enable()?;
+        ///     Ok(clk)
+        /// }
+        /// ```
+        #[inline]
+        fn from(err: Error<State>) -> Self {
+            err.error
+        }
+    }
 
     /// A reference-counted clock.
     ///
     /// Rust abstraction for the C [`struct clk`].
     ///
+    /// A [`Clk`] instance represents a clock that can be in one of several
+    /// states: [`Unprepared`], [`Prepared`], or [`Enabled`].
+    ///
+    /// No action needs to be taken when a [`Clk`] is dropped. The calls to
+    /// `clk_unprepare()` and `clk_disable()` will be placed as applicable.
+    ///
+    /// An optional [`Clk`] is treated just like a regular [`Clk`], but its
+    /// inner `struct clk` pointer is `NULL`. This interfaces correctly with the
+    /// C API and also exposes all the methods of a regular [`Clk`] to users.
+    ///
     /// # Invariants
     ///
     /// A [`Clk`] instance holds either a pointer to a valid [`struct clk`] created by the C
@@ -99,19 +185,36 @@ mod common_clk {
     /// Instances of this type are reference-counted. Calling [`Clk::get`] ensures that the
     /// allocation remains valid for the lifetime of the [`Clk`].
     ///
+    /// The [`Prepared`] state is associated with a single count of
+    /// `clk_prepare()`, and the [`Enabled`] state is associated with a single
+    /// count of both `clk_prepare()` and `clk_enable()`.
+    ///
+    /// All states are associated with a single count of `clk_get()`.
+    ///
     /// # Examples
     ///
     /// The following example demonstrates how to obtain and configure a clock for a device.
     ///
     /// ```
-    /// use kernel::clk::{Clk, Hertz};
-    /// use kernel::device::Device;
+    /// use kernel::clk::{Clk, Enabled, Hertz, Unprepared, Prepared};
+    /// use kernel::device::{Bound, Device};
     /// use kernel::error::Result;
     ///
-    /// fn configure_clk(dev: &Device) -> Result {
-    ///     let clk = Clk::get(dev, Some(c"apb_clk"))?;
+    /// fn configure_clk(dev: &Device<Bound>) -> Result {
+    ///     // The fastest way is to use a version of `Clk::get` for the desired
+    ///     // state, i.e.:
+    ///     let clk: Clk<Enabled> = Clk::<Enabled>::get(dev, Some(c"apb_clk"))?;
+    ///
+    ///     // Any other state is also possible, e.g.:
+    ///     let clk: Clk<Prepared> = Clk::<Prepared>::get(dev, Some(c"apb_clk"))?;
     ///
-    ///     clk.prepare_enable()?;
+    ///     // Later:
+    ///     //
+    ///     // `?` works directly thanks to `From<Error<State>>`; the failed
+    ///     // `Clk` is dropped on error. Match on the returned `Error<State>`
+    ///     // instead (its `clk` field is the original `Clk`) if you want to
+    ///     // retry the operation.
+    ///     let clk: Clk<Enabled> = clk.enable()?;
     ///
     ///     let expected_rate = Hertz::from_ghz(1);
     ///
@@ -119,122 +222,339 @@ mod common_clk {
     ///         clk.set_rate(expected_rate)?;
     ///     }
     ///
-    ///     clk.disable_unprepare();
+    ///     // Nothing is needed here. The drop implementation will undo any
+    ///     // operations as appropriate.
+    ///     Ok(())
+    /// }
+    ///
+    /// fn shutdown(clk: Clk<Enabled>) -> Result {
+    ///     // The states can be traversed "in the reverse order" as well:
+    ///     let clk: Clk<Prepared> = clk.disable();
+    ///
+    ///     // This is of type `Clk<Unprepared>`.
+    ///     let clk = clk.unprepare();
+    ///
     ///     Ok(())
     /// }
     /// ```
     ///
+    /// Drivers that need to change a clock's state at runtime (for example to
+    /// enable it on resume and disable it on suspend) can keep it in an enum
+    /// and move between the variants:
+    ///
+    /// ```
+    /// use kernel::clk::{Clk, Enabled, Prepared};
+    /// use kernel::error::Result;
+    ///
+    /// enum DeviceClk {
+    ///     Suspended(Clk<Prepared>),
+    ///     Resumed(Clk<Enabled>),
+    /// }
+    ///
+    /// impl DeviceClk {
+    ///     fn resume(self) -> Result<Self> {
+    ///         Ok(match self {
+    ///             DeviceClk::Suspended(clk) => DeviceClk::Resumed(clk.enable()?),
+    ///             resumed => resumed,
+    ///         })
+    ///     }
+    ///
+    ///     fn suspend(self) -> Result<Self> {
+    ///         Ok(match self {
+    ///             DeviceClk::Resumed(clk) => DeviceClk::Suspended(clk.disable()),
+    ///             suspended => suspended,
+    ///         })
+    ///     }
+    /// }
+    /// ```
+    ///
     /// [`struct clk`]: https://docs.kernel.org/driver-api/clk.html
     #[repr(transparent)]
-    pub struct Clk(*mut bindings::clk);
+    pub struct Clk<T: ClkState> {
+        inner: *mut bindings::clk,
+        _phantom: core::marker::PhantomData<T>,
+    }
 
     // SAFETY: It is safe to call `clk_put` on another thread than where `clk_get` was called.
-    unsafe impl Send for Clk {}
+    unsafe impl<T: ClkState> Send for Clk<T> {}
 
     // SAFETY: It is safe to call any combination of the `&self` methods in parallel, as the
     // methods are synchronized internally.
-    unsafe impl Sync for Clk {}
+    unsafe impl<T: ClkState> Sync for Clk<T> {}
 
-    impl Clk {
-        /// Gets [`Clk`] corresponding to a [`Device`] and a connection id.
+    impl Clk<Unprepared> {
+        /// Gets [`Clk`] corresponding to a bound [`Device`] and a connection
+        /// id.
         ///
         /// Equivalent to the kernel's [`clk_get`] API.
         ///
         /// [`clk_get`]: https://docs.kernel.org/core-api/kernel-api.html#c.clk_get
-        pub fn get(dev: &Device, name: Option<&CStr>) -> Result<Self> {
+        #[inline]
+        pub fn get(dev: &Device<Bound>, name: Option<&CStr>) -> Result<Clk<Unprepared>> {
+            Self::get_unbound(dev, name)
+        }
+
+        /// Gets [`Clk`] corresponding to a [`Device`] and a connection id,
+        /// without requiring the device to be bound.
+        ///
+        /// This is sound because [`clk_get`] and [`clk_put`] do not depend on the
+        /// device being bound to a driver. It is `pub(crate)` because a driver
+        /// should obtain its clocks through a bound device (see [`Clk::get`]); it
+        /// is meant for the few in-tree abstractions that operate on a device
+        /// outside a bind scope, such as the generic DT cpufreq driver.
+        ///
+        /// [`clk_get`]: https://docs.kernel.org/core-api/kernel-api.html#c.clk_get
+        /// [`clk_put`]: https://docs.kernel.org/core-api/kernel-api.html#c.clk_put
+        #[inline]
+        pub(crate) fn get_unbound(dev: &Device, name: Option<&CStr>) -> Result<Clk<Unprepared>> {
             let con_id = name.map_or(ptr::null(), |n| n.as_char_ptr());
 
-            // SAFETY: It is safe to call [`clk_get`] for a valid device pointer.
-            //
+            // SAFETY: It is safe to call [`clk_get`] for a valid device pointer
+            // and any `con_id`, including NULL.
+            let inner = from_err_ptr(unsafe { bindings::clk_get(dev.as_raw(), con_id) })?;
+
             // INVARIANT: The reference-count is decremented when [`Clk`] goes out of scope.
-            Ok(Self(from_err_ptr(unsafe {
-                bindings::clk_get(dev.as_raw(), con_id)
-            })?))
+            Ok(Self {
+                inner,
+                _phantom: PhantomData,
+            })
         }
 
-        /// Obtain the raw [`struct clk`] pointer.
+        /// Behaves the same as [`Self::get`], except when there is no clock
+        /// producer. In this case, instead of returning [`ENOENT`], it returns
+        /// a dummy [`Clk`].
         #[inline]
-        pub fn as_raw(&self) -> *mut bindings::clk {
-            self.0
+        pub fn get_optional(dev: &Device<Bound>, name: Option<&CStr>) -> Result<Clk<Unprepared>> {
+            let con_id = name.map_or(ptr::null(), |n| n.as_char_ptr());
+
+            // SAFETY: It is safe to call [`clk_get`] for a valid device pointer
+            // and any `con_id`, including NULL.
+            let inner = from_err_ptr(unsafe { bindings::clk_get_optional(dev.as_raw(), con_id) })?;
+
+            // INVARIANT: The reference-count is decremented when [`Clk`] goes out of scope.
+            Ok(Self {
+                inner,
+                _phantom: PhantomData,
+            })
         }
 
-        /// Enable the clock.
+        /// Attempts to convert the [`Clk`] to a [`Prepared`] state.
         ///
-        /// Equivalent to the kernel's [`clk_enable`] API.
+        /// Equivalent to the kernel's [`clk_prepare`] API.
         ///
-        /// [`clk_enable`]: https://docs.kernel.org/core-api/kernel-api.html#c.clk_enable
+        /// [`clk_prepare`]: https://docs.kernel.org/core-api/kernel-api.html#c.clk_prepare
         #[inline]
-        pub fn enable(&self) -> Result {
-            // SAFETY: By the type invariants, self.as_raw() is a valid argument for
-            // [`clk_enable`].
-            to_result(unsafe { bindings::clk_enable(self.as_raw()) })
+        pub fn prepare(self) -> Result<Clk<Prepared>, Error<Unprepared>> {
+            // We will be transferring the ownership of our `clk_get()` count to
+            // `Clk<Prepared>`.
+            let clk = ManuallyDrop::new(self);
+
+            // SAFETY: By the type invariants, `clk.as_raw()` is a valid argument
+            // for [`clk_prepare`].
+            to_result(unsafe { bindings::clk_prepare(clk.as_raw()) })
+                // INVARIANT: `clk_prepare()` succeeded, so the returned
+                // `Clk<Prepared>` owns a single count of it, which is released
+                // when it leaves the [`Prepared`] state.
+                .map(|()| Clk {
+                    inner: clk.inner,
+                    _phantom: PhantomData,
+                })
+                .map_err(|error| Error {
+                    error,
+                    clk: ManuallyDrop::into_inner(clk),
+                })
+        }
+    }
+
+    impl Clk<Prepared> {
+        /// Obtains a [`Clk`] from a bound [`Device`] and a connection id and
+        /// prepares it.
+        ///
+        /// Equivalent to calling [`Clk::get`], followed by [`Clk::prepare`],
+        #[inline]
+        pub fn get(dev: &Device<Bound>, name: Option<&CStr>) -> Result<Clk<Prepared>> {
+            Clk::<Unprepared>::get(dev, name)?
+                .prepare()
+                .map_err(|error| error.error)
+        }
+
+        /// Behaves the same as [`Self::get`], except when there is no clock
+        /// producer. In this case, instead of returning [`ENOENT`], it returns
+        /// a dummy [`Clk`].
+        #[inline]
+        pub fn get_optional(dev: &Device<Bound>, name: Option<&CStr>) -> Result<Clk<Prepared>> {
+            Clk::<Unprepared>::get_optional(dev, name)?
+                .prepare()
+                .map_err(|error| error.error)
         }
 
-        /// Disable the clock.
+        /// Converts the [`Clk`] to an [`Unprepared`] state.
         ///
-        /// Equivalent to the kernel's [`clk_disable`] API.
+        /// Equivalent to the kernel's [`clk_unprepare`] API.
         ///
-        /// [`clk_disable`]: https://docs.kernel.org/core-api/kernel-api.html#c.clk_disable
+        /// [`clk_unprepare`]: https://docs.kernel.org/core-api/kernel-api.html#c.clk_unprepare
         #[inline]
-        pub fn disable(&self) {
-            // SAFETY: By the type invariants, self.as_raw() is a valid argument for
-            // [`clk_disable`].
-            unsafe { bindings::clk_disable(self.as_raw()) };
+        pub fn unprepare(self) -> Clk<Unprepared> {
+            // We will be transferring the ownership of our `clk_get()` count to
+            // `Clk<Unprepared>`.
+            let clk = ManuallyDrop::new(self);
+
+            // SAFETY: By the type invariants, `clk.as_raw()` is a valid argument
+            // for [`clk_unprepare`].
+            unsafe { bindings::clk_unprepare(clk.as_raw()) }
+
+            // INVARIANT: The `clk_prepare()` count was released above, so the
+            // returned `Clk<Unprepared>` owns only the `clk_get()` count.
+            Clk {
+                inner: clk.inner,
+                _phantom: PhantomData,
+            }
         }
 
-        /// Prepare the clock.
+        /// Attempts to convert the [`Clk`] to an [`Enabled`] state.
         ///
-        /// Equivalent to the kernel's [`clk_prepare`] API.
+        /// Equivalent to the kernel's [`clk_enable`] API.
         ///
-        /// [`clk_prepare`]: https://docs.kernel.org/core-api/kernel-api.html#c.clk_prepare
+        /// [`clk_enable`]: https://docs.kernel.org/core-api/kernel-api.html#c.clk_enable
         #[inline]
-        pub fn prepare(&self) -> Result {
-            // SAFETY: By the type invariants, self.as_raw() is a valid argument for
-            // [`clk_prepare`].
-            to_result(unsafe { bindings::clk_prepare(self.as_raw()) })
+        pub fn enable(self) -> Result<Clk<Enabled>, Error<Prepared>> {
+            // We will be transferring the ownership of our `clk_get()` and
+            // `clk_prepare()` counts to `Clk<Enabled>`.
+            let clk = ManuallyDrop::new(self);
+
+            // SAFETY: By the type invariants, `clk.as_raw()` is a valid argument
+            // for [`clk_enable`].
+            to_result(unsafe { bindings::clk_enable(clk.as_raw()) })
+                // INVARIANT: `clk_enable()` succeeded, so the returned
+                // `Clk<Enabled>` owns a single count of it, which is released
+                // when it leaves the [`Enabled`] state.
+                .map(|()| Clk {
+                    inner: clk.inner,
+                    _phantom: PhantomData,
+                })
+                .map_err(|error| Error {
+                    error,
+                    clk: ManuallyDrop::into_inner(clk),
+                })
         }
 
-        /// Unprepare the clock.
+        /// Runs `cb` with the clock temporarily enabled.
         ///
-        /// Equivalent to the kernel's [`clk_unprepare`] API.
+        /// The clock is enabled before `cb` runs and disabled again afterwards,
+        /// so the [`Enabled`] state is scoped to the closure and the [`Clk`]
+        /// remains [`Prepared`]. This is convenient for drivers that only need
+        /// the clock running for a short, well-defined section (e.g. while
+        /// touching registers) without giving up ownership of the prepared
+        /// clock or threading it through an intermediate state, e.g.:
         ///
-        /// [`clk_unprepare`]: https://docs.kernel.org/core-api/kernel-api.html#c.clk_unprepare
+        /// ```
+        /// use kernel::clk::{Clk, Enabled, Hertz, Prepared};
+        /// use kernel::error::Result;
+        ///
+        /// fn read_rate(clk: &Clk<Prepared>) -> Result<Hertz> {
+        ///     clk.with_enabled(|clk: &Clk<Enabled>| clk.rate())
+        /// }
+        /// ```
+        ///
+        /// Equivalent to a balanced [`clk_enable`]/[`clk_disable`] pair around
+        /// `cb`.
+        ///
+        /// [`clk_enable`]: https://docs.kernel.org/core-api/kernel-api.html#c.clk_enable
+        /// [`clk_disable`]: https://docs.kernel.org/core-api/kernel-api.html#c.clk_disable
         #[inline]
-        pub fn unprepare(&self) {
-            // SAFETY: By the type invariants, self.as_raw() is a valid argument for
-            // [`clk_unprepare`].
-            unsafe { bindings::clk_unprepare(self.as_raw()) };
+        pub fn with_enabled<R>(&self, cb: impl FnOnce(&Clk<Enabled>) -> R) -> Result<R> {
+            // SAFETY: By the type invariants, `self.as_raw()` is a valid argument for
+            // [`clk_enable`].
+            to_result(unsafe { bindings::clk_enable(self.as_raw()) })?;
+
+            // Borrow the same clock as `Clk<Enabled>` for the duration of `cb`.
+            // It must not be dropped, as that would run `clk_disable`/`clk_put`
+            // against counts owned by `self`; the matching `clk_disable` below
+            // balances the `clk_enable` above instead.
+            //
+            // INVARIANT: The clock is enabled for the lifetime of `enabled`.
+            let enabled = ManuallyDrop::new(Clk::<Enabled> {
+                inner: self.inner,
+                _phantom: PhantomData,
+            });
+
+            let ret = cb(&enabled);
+
+            // SAFETY: The `clk_enable` above succeeded, so this balances it.
+            // `cb` only had a shared reference, so the enable count is unchanged.
+            unsafe { bindings::clk_disable(self.as_raw()) };
+
+            Ok(ret)
         }
+    }
 
-        /// Prepare and enable the clock.
+    impl Clk<Enabled> {
+        /// Gets [`Clk`] corresponding to a bound [`Device`] and a connection id
+        /// and then prepares and enables it.
         ///
-        /// Equivalent to calling [`Clk::prepare`] followed by [`Clk::enable`].
+        /// Equivalent to calling [`Clk::get`], followed by [`Clk::prepare`],
+        /// followed by [`Clk::enable`].
         #[inline]
-        pub fn prepare_enable(&self) -> Result {
-            // SAFETY: By the type invariants, self.as_raw() is a valid argument for
-            // [`clk_prepare_enable`].
-            to_result(unsafe { bindings::clk_prepare_enable(self.as_raw()) })
+        pub fn get(dev: &Device<Bound>, name: Option<&CStr>) -> Result<Clk<Enabled>> {
+            Clk::<Prepared>::get(dev, name)?
+                .enable()
+                .map_err(|error| error.error)
+        }
+
+        /// Behaves the same as [`Self::get`], except when there is no clock
+        /// producer. In this case, instead of returning [`ENOENT`], it returns
+        /// a dummy [`Clk`].
+        #[inline]
+        pub fn get_optional(dev: &Device<Bound>, name: Option<&CStr>) -> Result<Clk<Enabled>> {
+            Clk::<Prepared>::get_optional(dev, name)?
+                .enable()
+                .map_err(|error| error.error)
         }
 
-        /// Disable and unprepare the clock.
+        /// Disables the [`Clk`] and converts it to the [`Prepared`] state.
         ///
-        /// Equivalent to calling [`Clk::disable`] followed by [`Clk::unprepare`].
+        /// Equivalent to the kernel's [`clk_disable`] API.
+        ///
+        /// [`clk_disable`]: https://docs.kernel.org/core-api/kernel-api.html#c.clk_disable
         #[inline]
-        pub fn disable_unprepare(&self) {
-            // SAFETY: By the type invariants, self.as_raw() is a valid argument for
-            // [`clk_disable_unprepare`].
-            unsafe { bindings::clk_disable_unprepare(self.as_raw()) };
+        pub fn disable(self) -> Clk<Prepared> {
+            // We will be transferring the ownership of our `clk_get()` and
+            // `clk_prepare()` counts to `Clk<Prepared>`.
+            let clk = ManuallyDrop::new(self);
+
+            // SAFETY: By the type invariants, `clk.as_raw()` is a valid argument
+            // for [`clk_disable`].
+            unsafe { bindings::clk_disable(clk.as_raw()) };
+
+            // INVARIANT: The `clk_enable()` count was released above, so the
+            // returned `Clk<Prepared>` owns the `clk_get()` and `clk_prepare()`
+            // counts.
+            Clk {
+                inner: clk.inner,
+                _phantom: PhantomData,
+            }
+        }
+    }
+
+    impl<T: ClkState> Clk<T> {
+        /// Obtain the raw [`struct clk`] pointer.
+        #[inline]
+        pub fn as_raw(&self) -> *mut bindings::clk {
+            self.inner
         }
 
         /// Get clock's rate.
         ///
         /// Equivalent to the kernel's [`clk_get_rate`] API.
         ///
+        /// Note that the returned rate is only guaranteed to reflect what the
+        /// hardware is doing once the clock is [`Enabled`].
+        ///
         /// [`clk_get_rate`]: https://docs.kernel.org/core-api/kernel-api.html#c.clk_get_rate
         #[inline]
         pub fn rate(&self) -> Hertz {
-            // SAFETY: By the type invariants, self.as_raw() is a valid argument for
-            // [`clk_get_rate`].
+            // SAFETY: By the type invariants, `self.as_raw()` is a valid argument
+            // for [`clk_get_rate`].
             Hertz(unsafe { bindings::clk_get_rate(self.as_raw()) })
         }
 
@@ -245,88 +565,29 @@ pub fn rate(&self) -> Hertz {
         /// [`clk_set_rate`]: https://docs.kernel.org/core-api/kernel-api.html#c.clk_set_rate
         #[inline]
         pub fn set_rate(&self, rate: Hertz) -> Result {
-            // SAFETY: By the type invariants, self.as_raw() is a valid argument for
-            // [`clk_set_rate`].
+            // SAFETY: By the type invariants, `self.as_raw()` is a valid argument
+            // for [`clk_set_rate`].
             to_result(unsafe { bindings::clk_set_rate(self.as_raw(), rate.as_hz()) })
         }
     }
 
-    impl Drop for Clk {
+    impl<T: ClkState> Drop for Clk<T> {
         fn drop(&mut self) {
-            // SAFETY: By the type invariants, self.as_raw() is a valid argument for [`clk_put`].
-            unsafe { bindings::clk_put(self.as_raw()) };
-        }
-    }
-
-    /// A reference-counted optional clock.
-    ///
-    /// A lightweight wrapper around an optional [`Clk`]. An [`OptionalClk`] represents a [`Clk`]
-    /// that a driver can function without but may improve performance or enable additional
-    /// features when available.
-    ///
-    /// # Invariants
-    ///
-    /// An [`OptionalClk`] instance encapsulates a [`Clk`] with either a valid [`struct clk`] or
-    /// `NULL` pointer.
-    ///
-    /// Instances of this type are reference-counted. Calling [`OptionalClk::get`] ensures that the
-    /// allocation remains valid for the lifetime of the [`OptionalClk`].
-    ///
-    /// # Examples
-    ///
-    /// The following example demonstrates how to obtain and configure an optional clock for a
-    /// device. The code functions correctly whether or not the clock is available.
-    ///
-    /// ```
-    /// use kernel::clk::{OptionalClk, Hertz};
-    /// use kernel::device::Device;
-    /// use kernel::error::Result;
-    ///
-    /// fn configure_clk(dev: &Device) -> Result {
-    ///     let clk = OptionalClk::get(dev, Some(c"apb_clk"))?;
-    ///
-    ///     clk.prepare_enable()?;
-    ///
-    ///     let expected_rate = Hertz::from_ghz(1);
-    ///
-    ///     if clk.rate() != expected_rate {
-    ///         clk.set_rate(expected_rate)?;
-    ///     }
-    ///
-    ///     clk.disable_unprepare();
-    ///     Ok(())
-    /// }
-    /// ```
-    ///
-    /// [`struct clk`]: https://docs.kernel.org/driver-api/clk.html
-    pub struct OptionalClk(Clk);
-
-    impl OptionalClk {
-        /// Gets [`OptionalClk`] corresponding to a [`Device`] and a connection id.
-        ///
-        /// Equivalent to the kernel's [`clk_get_optional`] API.
-        ///
-        /// [`clk_get_optional`]:
-        /// https://docs.kernel.org/core-api/kernel-api.html#c.clk_get_optional
-        pub fn get(dev: &Device, name: Option<&CStr>) -> Result<Self> {
-            let con_id = name.map_or(ptr::null(), |n| n.as_char_ptr());
-
-            // SAFETY: It is safe to call [`clk_get_optional`] for a valid device pointer.
-            //
-            // INVARIANT: The reference-count is decremented when [`OptionalClk`] goes out of
-            // scope.
-            Ok(Self(Clk(from_err_ptr(unsafe {
-                bindings::clk_get_optional(dev.as_raw(), con_id)
-            })?)))
-        }
-    }
-
-    // Make [`OptionalClk`] behave like [`Clk`].
-    impl Deref for OptionalClk {
-        type Target = Clk;
+            if T::DISABLE_ON_DROP {
+                // SAFETY: By the type invariants, self.as_raw() is a valid argument for
+                // [`clk_disable`].
+                unsafe { bindings::clk_disable(self.as_raw()) };
+            }
+
+            if T::UNPREPARE_ON_DROP {
+                // SAFETY: By the type invariants, self.as_raw() is a valid argument for
+                // [`clk_unprepare`].
+                unsafe { bindings::clk_unprepare(self.as_raw()) };
+            }
 
-        fn deref(&self) -> &Clk {
-            &self.0
+            // SAFETY: By the type invariants, self.as_raw() is a valid argument for
+            // [`clk_put`].
+            unsafe { bindings::clk_put(self.as_raw()) };
         }
     }
 }
diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index d8d26870bea2..e837bb1010e0 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -553,8 +553,12 @@ pub fn cpus(&mut self) -> &mut cpumask::Cpumask {
     /// The caller must guarantee that the returned [`Clk`] is not dropped while it is getting used
     /// by the C code.
     #[cfg(CONFIG_COMMON_CLK)]
-    pub unsafe fn set_clk(&mut self, dev: &Device, name: Option<&CStr>) -> Result<Clk> {
-        let clk = Clk::get(dev, name)?;
+    pub unsafe fn set_clk(
+        &mut self,
+        dev: &Device,
+        name: Option<&CStr>,
+    ) -> Result<Clk<crate::clk::Unprepared>> {
+        let clk = Clk::<crate::clk::Unprepared>::get_unbound(dev, name)?;
         self.as_mut_ref().clk = clk.as_raw();
         Ok(clk)
     }

-- 
2.54.0


