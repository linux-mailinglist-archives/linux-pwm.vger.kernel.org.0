Return-Path: <linux-pwm+bounces-8921-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEkgDvgGCWouFgQAu9opvQ
	(envelope-from <linux-pwm+bounces-8921-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 02:08:24 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEC455E94A
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 02:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F28E23021B78
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 00:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B74B12CDBE;
	Sun, 17 May 2026 00:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LP2i6WUg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E6B4A02;
	Sun, 17 May 2026 00:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778976274; cv=none; b=DfKXv+VweHPfpgnJu6Hpa0WhZOS2r++jKUvrNRAQ0KiA+Lk8R9aNftDT+7LVobexmeDhoG4GMFVMem7fLi4we9UpDEgfXhHIoTwIaep+cK2E5JVmG5Jn+bf03yUQhzraCxWyTN2QGwlTgyo79xWuPjwouUP8qtEY+Fn1X5EBkRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778976274; c=relaxed/simple;
	bh=f+IsdvlwojPvLZFUcjIecxcaPpxbe1roFDOzzjKR8FE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IFvkkHAIxf633DcGsgOYVvxkPBtO/REb9Q8KM7Y/ACsk6MS9bETUk49/ublA7Z0A2Y7lTOCQLcUqcMCPD+nAwz9AvbgRbPTHU86A36E09ZusC/tTF7MCtNtD/AqgN64Fkg+u7cwtVNFnB4Ndb4cYTRQT33+iV8hhttjQ9nEHllk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LP2i6WUg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0399CC4AF09;
	Sun, 17 May 2026 00:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778976274;
	bh=f+IsdvlwojPvLZFUcjIecxcaPpxbe1roFDOzzjKR8FE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LP2i6WUgJ/Yz9aXIdp15J2D4TND8gZDOOkNt+XdjdF6i5Rb1DOJlbbJe31LdtUWpE
	 zODdfCuv2TDrjwPbZ8lwxh1MyJxKxycD+1JPRWy18gkEH730FOPxbBGLORg1b/RgW9
	 yvytB/KfemmQhULeaCq/NXTgi3RNNVD6LZGd8qTWB3hNSdW29Q54zBXlOa29cU8kBH
	 RCjfCi7qashfkKsISjUCC0enOd2Eu9jGOvOKokNk6KrejtkpDAkZyGaMDuoi3g84w4
	 tq/u/y13QGTfZe7tfFnHKO/ngXBdfOPl1wOiOSbCCBKKYW7O9TWECCdI2CMTTxnQVL
	 C4IA6dgmBQ+1A==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	acourbot@nvidia.com,
	aliceryhl@google.com,
	david.m.ertman@intel.com,
	ira.weiny@intel.com,
	leon@kernel.org,
	viresh.kumar@linaro.org,
	m.wilczynski@samsung.com,
	ukleinek@kernel.org,
	bhelgaas@google.com,
	kwilczynski@kernel.org,
	abdiel.janulgue@gmail.com,
	robin.murphy@arm.com,
	markus.probst@posteo.de,
	ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	tmgross@umich.edu,
	igor.korotin@linux.dev,
	daniel.almeida@collabora.com,
	pcolberg@redhat.com
Cc: driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	nova-gpu@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-pm@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v3 22/27] rust: driver-core: rename 'a lifetime to 'bound
Date: Sun, 17 May 2026 02:01:10 +0200
Message-ID: <20260517000149.3226762-23-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260517000149.3226762-1-dakr@kernel.org>
References: <20260517000149.3226762-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3EEC455E94A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-8921-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Rename the generic lifetime parameter from 'a to 'bound in pci,
platform, i2c and devres. This makes it explicit that the lifetime
represents the device binding scope, consistent with the convention
established by the HRT series.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/devres.rs   | 14 +++++++++-----
 rust/kernel/i2c.rs      |  6 +++---
 rust/kernel/pci/irq.rs  | 38 +++++++++++++++++++-------------------
 rust/kernel/platform.rs | 18 +++++++++---------
 4 files changed, 40 insertions(+), 36 deletions(-)

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index ec63317665f4..58efe80474bd 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -280,10 +280,11 @@ pub fn device(&self) -> &Device {
         &self.dev
     }
 
-    /// Obtain `&'a T`, bypassing the [`Revocable`].
+    /// Obtain `&'bound T`, bypassing the [`Revocable`].
     ///
-    /// This method allows to directly obtain a `&'a T`, bypassing the [`Revocable`], by presenting
-    /// a `&'a Device<Bound>` of the same [`Device`] this [`Devres`] instance has been created with.
+    /// This method allows to directly obtain a `&'bound T`, bypassing the
+    /// [`Revocable`], by presenting a `&'bound Device<Bound>` of the same
+    /// [`Device`] this [`Devres`] instance has been created with.
     ///
     /// # Errors
     ///
@@ -316,7 +317,7 @@ pub fn device(&self) -> &Device {
     ///     Ok(())
     /// }
     /// ```
-    pub fn access<'a>(&'a self, dev: &'a Device<Bound>) -> Result<&'a T> {
+    pub fn access<'bound>(&'bound self, dev: &'bound Device<Bound>) -> Result<&'bound T> {
         if self.dev.as_raw() != dev.as_raw() {
             return Err(EINVAL);
         }
@@ -338,7 +339,10 @@ pub fn try_access_with<R, F: FnOnce(&T) -> R>(&self, f: F) -> Option<R> {
     }
 
     /// [`Devres`] accessor for [`Revocable::try_access_with_guard`].
-    pub fn try_access_with_guard<'a>(&'a self, guard: &'a rcu::Guard) -> Option<&'a T> {
+    pub fn try_access_with_guard<'bound>(
+        &'bound self,
+        guard: &'bound rcu::Guard,
+    ) -> Option<&'bound T> {
         self.data().try_access_with_guard(guard)
     }
 }
diff --git a/rust/kernel/i2c.rs b/rust/kernel/i2c.rs
index 7b92d42a2b98..2bb7e54922e5 100644
--- a/rust/kernel/i2c.rs
+++ b/rust/kernel/i2c.rs
@@ -566,11 +566,11 @@ unsafe impl Sync for I2cClient {}
 
 impl Registration {
     /// The C `i2c_new_client_device` function wrapper for manual I2C client creation.
-    pub fn new<'a>(
+    pub fn new<'bound>(
         i2c_adapter: &I2cAdapter,
         i2c_board_info: &I2cBoardInfo,
-        parent_dev: &'a device::Device<device::Bound>,
-    ) -> impl PinInit<Devres<Self>, Error> + 'a {
+        parent_dev: &'bound device::Device<device::Bound>,
+    ) -> impl PinInit<Devres<Self>, Error> + 'bound {
         Devres::new(parent_dev, Self::try_new(i2c_adapter, i2c_board_info))
     }
 
diff --git a/rust/kernel/pci/irq.rs b/rust/kernel/pci/irq.rs
index d9230e105541..92207fd46403 100644
--- a/rust/kernel/pci/irq.rs
+++ b/rust/kernel/pci/irq.rs
@@ -76,19 +76,19 @@ const fn as_raw(self) -> u32 {
 /// This type ties an IRQ vector to the device it was allocated for,
 /// ensuring the vector is only used with the correct device.
 #[derive(Clone, Copy)]
-pub struct IrqVector<'a> {
-    dev: &'a Device<Bound>,
+pub struct IrqVector<'bound> {
+    dev: &'bound Device<Bound>,
     index: u32,
 }
 
-impl<'a> IrqVector<'a> {
+impl<'bound> IrqVector<'bound> {
     /// Creates a new [`IrqVector`] for the given device and index.
     ///
     /// # Safety
     ///
     /// - `index` must be a valid IRQ vector index for `dev`.
     /// - `dev` must point to a [`Device`] that has successfully allocated IRQ vectors.
-    unsafe fn new(dev: &'a Device<Bound>, index: u32) -> Self {
+    unsafe fn new(dev: &'bound Device<Bound>, index: u32) -> Self {
         Self { dev, index }
     }
 
@@ -98,10 +98,10 @@ fn index(&self) -> u32 {
     }
 }
 
-impl<'a> TryInto<IrqRequest<'a>> for IrqVector<'a> {
+impl<'bound> TryInto<IrqRequest<'bound>> for IrqVector<'bound> {
     type Error = Error;
 
-    fn try_into(self) -> Result<IrqRequest<'a>> {
+    fn try_into(self) -> Result<IrqRequest<'bound>> {
         // SAFETY: `self.as_raw` returns a valid pointer to a `struct pci_dev`.
         let irq = unsafe { bindings::pci_irq_vector(self.dev.as_raw(), self.index()) };
         if irq < 0 {
@@ -129,12 +129,12 @@ impl IrqVectorRegistration {
     ///
     /// Allocates IRQ vectors and registers them with devres for automatic cleanup.
     /// Returns a range of valid IRQ vectors.
-    fn register<'a>(
-        dev: &'a Device<Bound>,
+    fn register<'bound>(
+        dev: &'bound Device<Bound>,
         min_vecs: u32,
         max_vecs: u32,
         irq_types: IrqTypes,
-    ) -> Result<RangeInclusive<IrqVector<'a>>> {
+    ) -> Result<RangeInclusive<IrqVector<'bound>>> {
         // SAFETY:
         // - `dev.as_raw()` is guaranteed to be a valid pointer to a `struct pci_dev`
         //   by the type invariant of `Device`.
@@ -173,13 +173,13 @@ fn drop(&mut self) {
 
 impl Device<device::Bound> {
     /// Returns a [`kernel::irq::Registration`] for the given IRQ vector.
-    pub fn request_irq<'a, T: crate::irq::Handler + 'static>(
-        &'a self,
-        vector: IrqVector<'a>,
+    pub fn request_irq<'bound, T: crate::irq::Handler + 'static>(
+        &'bound self,
+        vector: IrqVector<'bound>,
         flags: irq::Flags,
         name: &'static CStr,
-        handler: impl PinInit<T, Error> + 'a,
-    ) -> impl PinInit<irq::Registration<T>, Error> + 'a {
+        handler: impl PinInit<T, Error> + 'bound,
+    ) -> impl PinInit<irq::Registration<T>, Error> + 'bound {
         pin_init::pin_init_scope(move || {
             let request = vector.try_into()?;
 
@@ -188,13 +188,13 @@ pub fn request_irq<'a, T: crate::irq::Handler + 'static>(
     }
 
     /// Returns a [`kernel::irq::ThreadedRegistration`] for the given IRQ vector.
-    pub fn request_threaded_irq<'a, T: crate::irq::ThreadedHandler + 'static>(
-        &'a self,
-        vector: IrqVector<'a>,
+    pub fn request_threaded_irq<'bound, T: crate::irq::ThreadedHandler + 'static>(
+        &'bound self,
+        vector: IrqVector<'bound>,
         flags: irq::Flags,
         name: &'static CStr,
-        handler: impl PinInit<T, Error> + 'a,
-    ) -> impl PinInit<irq::ThreadedRegistration<T>, Error> + 'a {
+        handler: impl PinInit<T, Error> + 'bound,
+    ) -> impl PinInit<irq::ThreadedRegistration<T>, Error> + 'bound {
         pin_init::pin_init_scope(move || {
             let request = vector.try_into()?;
 
diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 6e4437866c30..44f68da5432d 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -337,13 +337,13 @@ macro_rules! define_irq_accessor_by_index {
         $handler_trait:ident
     ) => {
         $(#[$meta])*
-        pub fn $fn_name<'a, T: irq::$handler_trait + 'static>(
-            &'a self,
+        pub fn $fn_name<'bound, T: irq::$handler_trait + 'static>(
+            &'bound self,
             flags: irq::Flags,
             index: u32,
             name: &'static CStr,
-            handler: impl PinInit<T, Error> + 'a,
-        ) -> impl PinInit<irq::$reg_type<T>, Error> + 'a {
+            handler: impl PinInit<T, Error> + 'bound,
+        ) -> impl PinInit<irq::$reg_type<T>, Error> + 'bound {
             pin_init::pin_init_scope(move || {
                 let request = self.$request_fn(index)?;
 
@@ -366,13 +366,13 @@ macro_rules! define_irq_accessor_by_name {
         $handler_trait:ident
     ) => {
         $(#[$meta])*
-        pub fn $fn_name<'a, T: irq::$handler_trait + 'static>(
-            &'a self,
+        pub fn $fn_name<'bound, T: irq::$handler_trait + 'static>(
+            &'bound self,
             flags: irq::Flags,
-            irq_name: &'a CStr,
+            irq_name: &'bound CStr,
             name: &'static CStr,
-            handler: impl PinInit<T, Error> + 'a,
-        ) -> impl PinInit<irq::$reg_type<T>, Error> + 'a {
+            handler: impl PinInit<T, Error> + 'bound,
+        ) -> impl PinInit<irq::$reg_type<T>, Error> + 'bound {
             pin_init::pin_init_scope(move || {
                 let request = self.$request_fn(irq_name)?;
 
-- 
2.54.0


