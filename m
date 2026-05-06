Return-Path: <linux-pwm+bounces-8798-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBFNIuG4+2k0DwAAu9opvQ
	(envelope-from <linux-pwm+bounces-8798-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 06 May 2026 23:55:45 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA054E0E4B
	for <lists+linux-pwm@lfdr.de>; Wed, 06 May 2026 23:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0928F30416F0
	for <lists+linux-pwm@lfdr.de>; Wed,  6 May 2026 21:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4893B3C13;
	Wed,  6 May 2026 21:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lC59G5IQ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1A431715C;
	Wed,  6 May 2026 21:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778104309; cv=none; b=gTBgcqzcAkmqXVOV+Lt9RfEiQvsCJpKTqUKllGHt6227ERqwDyy4i4bxuFpAEsfu72e7K0lskbI1DoPxkPl/NmO4n4p0xTdhWzWB+Lrx8svCmnnbpGIYG5lvrykIB9u5JQK6wtaJQSpf4nisIJb27JRSQcRMEThFGaEvNT2BXEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778104309; c=relaxed/simple;
	bh=CVDhFuv85MahzpR44TGGEknLyGLiFPiboA4gD9I6zS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GI+4zdnobPW7RKEeBFJEcSz38H4WPTxzrrvw/pPnlspPuRApAXSB/58kx6wtY/9a6flUGWcFG27S3sStN9fehjKQhDa5dR0l/HyygOTeNzpPecyfrfgLc8SRUVugI+Hfhk8vlEetyQ5WQiSx4USNX3MAkUadPsg6LlXvb53ChXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lC59G5IQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D540C2BCFD;
	Wed,  6 May 2026 21:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778104308;
	bh=CVDhFuv85MahzpR44TGGEknLyGLiFPiboA4gD9I6zS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lC59G5IQUtnI0r9rKzsfpRnjxCA4QoqhhAHTrZbDMn9NJB9otwvq6J28fuVy6FlTU
	 pUOiPOtnFhFKeBu/0gmzCdBItP7k1DS2aTfMjfZ6HahvH38FqCuIJEjhpY0aKLdo5W
	 nuJp+Lwns+zU1zs6qG6ppV6fPcalY8WI7V2ms+7A3s4TuJgatnoHrZZXQsU6V0maG0
	 T4pZA3VnsL5SQq6QiH88UL/h+nENC/ZLRzODlM6leQUjLvSN8J7eNu1Of1gptHDsc4
	 1iHZoWTm21Aa11dFgB9t5X20T8TOz1GP+Z72WWwTA6x9aQ/EwKACq2bl9D9RbIzktD
	 fwmf1H9LDyAtg==
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
	daniel.almeida@collabora.com
Cc: driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	nova-gpu@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-pm@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v2 04/25] rust: driver: make Adapter trait lifetime-parameterized
Date: Wed,  6 May 2026 23:50:40 +0200
Message-ID: <20260506215113.851360-5-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506215113.851360-1-dakr@kernel.org>
References: <20260506215113.851360-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DDA054E0E4B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com];
	TAGGED_FROM(0.00)[bounces-8798-lists,linux-pwm=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Parameterize the Adapter trait with a lifetime, changing the id_info(),
of_id_info() and acpi_id_info() methods to take &'bound Device<Bound> and
return &'bound Self::IdInfo instead of &'static.

This is needed for the ForLt conversion of bus driver traits. Once
Driver becomes lifetime-parameterized, its IdInfo associated type may
depend on the lifetime parameter. With Adapter<'bound>, the impl can set
IdInfo = <F::Of<'bound> as Driver<'bound>>::IdInfo and the lifetime flows
through naturally, avoiding the need for transmute.

For the current non-lifetime-parameterized Driver trait, this is a no-op
type relaxation; IdInfo is 'static and &'static coerces to &'bound.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/driver.rs   | 16 ++++++++++------
 rust/kernel/i2c.rs      | 10 +++++-----
 rust/kernel/platform.rs |  4 ++--
 3 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
index 2ab3c0050117..e462535f545d 100644
--- a/rust/kernel/driver.rs
+++ b/rust/kernel/driver.rs
@@ -96,7 +96,11 @@
 
 use crate::{
     acpi,
-    device,
+    device::{
+        self,
+        Bound,
+        Device, //
+    },
     of,
     prelude::*,
     types::{
@@ -192,7 +196,7 @@ extern "C" fn post_unbind_callback(dev: *mut bindings::device) {
         // a `struct device`.
         //
         // INVARIANT: `dev` is valid for the duration of the `post_unbind_callback()`.
-        let dev = unsafe { &*dev.cast::<device::Device<device::CoreInternal>>() };
+        let dev = unsafe { &*dev.cast::<Device<device::CoreInternal>>() };
 
         // `remove()` has been completed at this point; devres resources are still valid and will
         // be released after the driver's bus device private data is dropped.
@@ -309,7 +313,7 @@ unsafe fn acpi_of_match_device(
 /// of a device and a driver.
 ///
 /// It provides bus independent functions for device / driver interactions.
-pub trait Adapter {
+pub trait Adapter<'bound> {
     /// The type holding driver private data about each device id supported by the driver.
     type IdInfo: 'static;
 
@@ -319,7 +323,7 @@ pub trait Adapter {
     /// Returns the driver's private data from the matching entry in the [`acpi::IdTable`], if any.
     ///
     /// If this returns `None`, it means there is no match with an entry in the [`acpi::IdTable`].
-    fn acpi_id_info(dev: &device::Device) -> Option<&'static Self::IdInfo> {
+    fn acpi_id_info(dev: &'bound Device<Bound>) -> Option<&'bound Self::IdInfo> {
         #[cfg(not(CONFIG_ACPI))]
         {
             let _ = dev;
@@ -353,7 +357,7 @@ fn acpi_id_info(dev: &device::Device) -> Option<&'static Self::IdInfo> {
     /// Returns the driver's private data from the matching entry in the [`of::IdTable`], if any.
     ///
     /// If this returns `None`, it means there is no match with an entry in the [`of::IdTable`].
-    fn of_id_info(dev: &device::Device) -> Option<&'static Self::IdInfo> {
+    fn of_id_info(dev: &'bound Device<Bound>) -> Option<&'bound Self::IdInfo> {
         let table = Self::of_id_table()?;
 
         #[cfg(not(any(CONFIG_OF, CONFIG_ACPI)))]
@@ -417,7 +421,7 @@ fn of_id_info(dev: &device::Device) -> Option<&'static Self::IdInfo> {
     ///
     /// If this returns `None`, it means that there is no match in any of the ID tables directly
     /// associated with a [`device::Device`].
-    fn id_info(dev: &device::Device) -> Option<&'static Self::IdInfo> {
+    fn id_info(dev: &'bound Device<Bound>) -> Option<&'bound Self::IdInfo> {
         let id = Self::acpi_id_info(dev);
         if id.is_some() {
             return id;
diff --git a/rust/kernel/i2c.rs b/rust/kernel/i2c.rs
index cde3dd7a6cc7..208c73aa3ce3 100644
--- a/rust/kernel/i2c.rs
+++ b/rust/kernel/i2c.rs
@@ -162,8 +162,8 @@ extern "C" fn probe_callback(idev: *mut bindings::i2c_client) -> kernel::ffi::c_
         // INVARIANT: `idev` is valid for the duration of `probe_callback()`.
         let idev = unsafe { &*idev.cast::<I2cClient<device::CoreInternal>>() };
 
-        let info =
-            Self::i2c_id_info(idev).or_else(|| <Self as driver::Adapter>::id_info(idev.as_ref()));
+        let info = Self::i2c_id_info(idev)
+            .or_else(|| <Self as driver::Adapter<'_>>::id_info(idev.as_ref()));
 
         from_result(|| {
             let data = T::probe(idev, info);
@@ -198,14 +198,14 @@ extern "C" fn shutdown_callback(idev: *mut bindings::i2c_client) {
     }
 
     /// The [`i2c::IdTable`] of the corresponding driver.
-    fn i2c_id_table() -> Option<IdTable<<Self as driver::Adapter>::IdInfo>> {
+    fn i2c_id_table() -> Option<IdTable<<Self as driver::Adapter<'static>>::IdInfo>> {
         T::I2C_ID_TABLE
     }
 
     /// Returns the driver's private data from the matching entry in the [`i2c::IdTable`], if any.
     ///
     /// If this returns `None`, it means there is no match with an entry in the [`i2c::IdTable`].
-    fn i2c_id_info(dev: &I2cClient) -> Option<&'static <Self as driver::Adapter>::IdInfo> {
+    fn i2c_id_info(dev: &I2cClient) -> Option<&'static <Self as driver::Adapter<'static>>::IdInfo> {
         let table = Self::i2c_id_table()?;
 
         // SAFETY:
@@ -225,7 +225,7 @@ fn i2c_id_info(dev: &I2cClient) -> Option<&'static <Self as driver::Adapter>::Id
     }
 }
 
-impl<T: Driver + 'static> driver::Adapter for Adapter<T> {
+impl<'bound, T: Driver + 'static> driver::Adapter<'bound> for Adapter<T> {
     type IdInfo = T::IdInfo;
 
     fn of_id_table() -> Option<of::IdTable<Self::IdInfo>> {
diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 7ff69e3eea90..506731a648c2 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -101,7 +101,7 @@ extern "C" fn probe_callback(pdev: *mut bindings::platform_device) -> kernel::ff
         //
         // INVARIANT: `pdev` is valid for the duration of `probe_callback()`.
         let pdev = unsafe { &*pdev.cast::<Device<device::CoreInternal>>() };
-        let info = <Self as driver::Adapter>::id_info(pdev.as_ref());
+        let info = <Self as driver::Adapter<'_>>::id_info(pdev.as_ref());
 
         from_result(|| {
             let data = T::probe(pdev, info);
@@ -127,7 +127,7 @@ extern "C" fn remove_callback(pdev: *mut bindings::platform_device) {
     }
 }
 
-impl<T: Driver + 'static> driver::Adapter for Adapter<T> {
+impl<'bound, T: Driver + 'static> driver::Adapter<'bound> for Adapter<T> {
     type IdInfo = T::IdInfo;
 
     fn of_id_table() -> Option<of::IdTable<Self::IdInfo>> {
-- 
2.54.0


