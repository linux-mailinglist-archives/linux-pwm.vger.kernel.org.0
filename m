Return-Path: <linux-pwm+bounces-8708-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGB0HADg72kHHQEAu9opvQ
	(envelope-from <linux-pwm+bounces-8708-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Apr 2026 00:15:28 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB7047B426
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Apr 2026 00:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EBA2430D0A72
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Apr 2026 22:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFF33AB283;
	Mon, 27 Apr 2026 22:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BopU7sLk"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A848226F2BE;
	Mon, 27 Apr 2026 22:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777327959; cv=none; b=kNaDRx+vHizcldBk9bTyT26pr84552ov2Rq9mhkp01VlY6+Om1yrKIrnJC8Rdh0cirn5cSRrM+1uKKSogFH0ZLkY53c5MzBIUkLM50wKsWnItd5Tx9F7oi7AKVzkt+IQhPsWZ3Gg9s+Z1bahgApduASKLvJ+EsDHD8KOztCcCxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777327959; c=relaxed/simple;
	bh=LHxKj2Sqgk+a3BT1FgcDoIHc1Tx9bGrGlwRiqgYkiCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SQgPiCOR4CiyvihL8hlO7XnoTkwp+PmMHKwQpxK3xBKtKXXjzjlxho8ukK1GsJ2GyksP035xr+CQv8tCmKGJ8XDBJGwepTFwhIUIEJlrVmbQPrtLx7Mqktah2YCDDfOo0U6dYWsLSB0sgMYkMuSW3LbbftrMJlPj04e74H4z2c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BopU7sLk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE6DBC19425;
	Mon, 27 Apr 2026 22:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777327959;
	bh=LHxKj2Sqgk+a3BT1FgcDoIHc1Tx9bGrGlwRiqgYkiCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BopU7sLkdBecu6RzsUKESdx7jKEorWFsjYHninRucrKzOsyfaIZxAnbqOXmsf78yA
	 LmBdvjlPHJ97CZ3/RZFmbxtU/RuVlMvkjTGHeIFrwlvhMgK2HPW6Rrym9ig+Kg/QTQ
	 xcRNBDNx2WH4AgWRSd2W2W5BkQBYSPhfArdATJ+MhZUf3RGa4k1d+M/Pvkp8a/Ww6p
	 3Zv6Vz+kqxpkom45ckoM2Sf3kOI9wASJPg8k0aANf6FSFjcEg1HtidmpZK5UhjWmu8
	 N46jRAPCJSQNUMHtm8CK2gtUrh0gGJdFLV7OXWW/i1SOHOSTeGmvoLbqBN476do3CH
	 GhapsOt446RNw==
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
	tmgross@umich.edu
Cc: driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	nova-gpu@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-pm@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 05/24] rust: driver: make Adapter trait lifetime-parameterized
Date: Tue, 28 Apr 2026 00:11:03 +0200
Message-ID: <20260427221155.2144848-6-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260427221155.2144848-1-dakr@kernel.org>
References: <20260427221155.2144848-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1CB7047B426
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8708-lists,linux-pwm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Parameterize the Adapter trait with a lifetime, changing the id_info(),
of_id_info() and acpi_id_info() methods to take &'a Device<Bound> and
return &'a Self::IdInfo instead of &'static.

This is needed for the ForLt conversion of bus driver traits. Once
Driver becomes lifetime-parameterized, its IdInfo associated type may
depend on the lifetime parameter. With Adapter<'a>, the impl can set
IdInfo = <F::Of<'a> as Driver<'a>>::IdInfo and the lifetime flows
through naturally, avoiding the need for transmute.

For the current non-lifetime-parameterized Driver trait, this is a no-op
type relaxation; IdInfo is 'static and &'static coerces to &'a.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/driver.rs   | 16 ++++++++++------
 rust/kernel/i2c.rs      | 10 +++++-----
 rust/kernel/platform.rs |  4 ++--
 3 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
index 29a67b12c872..91490040d77e 100644
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
@@ -289,7 +293,7 @@ fn init(
 /// of a device and a driver.
 ///
 /// It provides bus independent functions for device / driver interactions.
-pub trait Adapter {
+pub trait Adapter<'a> {
     /// The type holding driver private data about each device id supported by the driver.
     type IdInfo: 'static;
 
@@ -299,7 +303,7 @@ pub trait Adapter {
     /// Returns the driver's private data from the matching entry in the [`acpi::IdTable`], if any.
     ///
     /// If this returns `None`, it means there is no match with an entry in the [`acpi::IdTable`].
-    fn acpi_id_info(dev: &device::Device) -> Option<&'static Self::IdInfo> {
+    fn acpi_id_info(dev: &'a Device<Bound>) -> Option<&'a Self::IdInfo> {
         #[cfg(not(CONFIG_ACPI))]
         {
             let _ = dev;
@@ -333,7 +337,7 @@ fn acpi_id_info(dev: &device::Device) -> Option<&'static Self::IdInfo> {
     /// Returns the driver's private data from the matching entry in the [`of::IdTable`], if any.
     ///
     /// If this returns `None`, it means there is no match with an entry in the [`of::IdTable`].
-    fn of_id_info(dev: &device::Device) -> Option<&'static Self::IdInfo> {
+    fn of_id_info(dev: &'a Device<Bound>) -> Option<&'a Self::IdInfo> {
         #[cfg(not(CONFIG_OF))]
         {
             let _ = dev;
@@ -369,7 +373,7 @@ fn of_id_info(dev: &device::Device) -> Option<&'static Self::IdInfo> {
     ///
     /// If this returns `None`, it means that there is no match in any of the ID tables directly
     /// associated with a [`device::Device`].
-    fn id_info(dev: &device::Device) -> Option<&'static Self::IdInfo> {
+    fn id_info(dev: &'a Device<Bound>) -> Option<&'a Self::IdInfo> {
         let id = Self::acpi_id_info(dev);
         if id.is_some() {
             return id;
diff --git a/rust/kernel/i2c.rs b/rust/kernel/i2c.rs
index cde3dd7a6cc7..08d310aa9d6b 100644
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
+impl<'a, T: Driver + 'static> driver::Adapter<'a> for Adapter<T> {
     type IdInfo = T::IdInfo;
 
     fn of_id_table() -> Option<of::IdTable<Self::IdInfo>> {
diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 7ff69e3eea90..1585b6a1ac45 100644
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
+impl<'a, T: Driver + 'static> driver::Adapter<'a> for Adapter<T> {
     type IdInfo = T::IdInfo;
 
     fn of_id_table() -> Option<of::IdTable<Self::IdInfo>> {
-- 
2.54.0


