Return-Path: <linux-pwm+bounces-8704-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOIXGl7f72kiHQEAu9opvQ
	(envelope-from <linux-pwm+bounces-8704-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Apr 2026 00:12:46 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0864A47B29B
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Apr 2026 00:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28337301F994
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Apr 2026 22:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16A33A6B81;
	Mon, 27 Apr 2026 22:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0DI94d2"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D09226F2BE;
	Mon, 27 Apr 2026 22:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777327934; cv=none; b=c3eckqKjr15VOdAf+CsfstMljBZdQBWpENWpGfqrAxSZVFa3g9o96fHkbSIfEHqEvU0/eSj0K1QKMZVmxQR1Ae7M6YIMW+MmyrLtQ47XAw+nY69bbA872jBXlmxEi8AgJfXQRaz/kJwwKQQh6cHHInYdhXHjcFSJCVMlYOe+T7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777327934; c=relaxed/simple;
	bh=ju+F7o8Yl0nyozmN8SThTNujs1B0GOs/rWyZh4FMitg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K7jRC9E0QPx4ICGqiA3JeTPrkoLcMYfmwj74Aq0vp/hDTJZhwABw7V/zpOrVtmYU6OgJ32sSE3p54HAushcwMnTEXfmCdA21eZ/zA40DDQTKJ6+AMXWBJlGfu8b2HSOSTtuyS2K8+hqSegopyk5coW4X2Vsdrj2koa01TD/+TeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B0DI94d2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F904C19425;
	Mon, 27 Apr 2026 22:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777327934;
	bh=ju+F7o8Yl0nyozmN8SThTNujs1B0GOs/rWyZh4FMitg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B0DI94d2eRFKDr3/VwZbkkFsvz36IGsGDJhc8SmdCK5Z5cARqCTNNFlEfE9EwcpKg
	 IqSQS7X0la8Qy4Uu9wC5Z47YmGqMDrIdAB6CIl7Kk2CYVGhaghWLzWUiChXNp6wGK3
	 sGHygogvD8WI7CopuAM5NyRz9NXzAEZ2ipxldU+Ssx0W/HgaH3OWWeAc2NDKawW9FY
	 NY9+I9h8GlXTG1y/UVjx2uovH8iyQ0xKNgmXJQmPg844taSQlRztSkbNfwkrxs9aY1
	 IyaoJNYxpsYna35Tk2JTSso2ezu9t73QM1O73Zhb6F2DLvze3BSEujdZ+SjyNc+Zjd
	 7nyxZcE1D64lQ==
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
Subject: [PATCH 01/24] rust: driver core: drop drvdata before devres release
Date: Tue, 28 Apr 2026 00:10:59 +0200
Message-ID: <20260427221155.2144848-2-dakr@kernel.org>
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
X-Rspamd-Queue-Id: 0864A47B29B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8704-lists,linux-pwm=lfdr.de];
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

Move the post_unbind_rust callback before devres_release_all() in
device_unbind_cleanup().

With drvdata() removed, the driver's bus device private data is only
accessible by the owning driver itself. It is hence safe to drop the
driver's bus device private data before devres actions are released.

This reordering is the key enabler for Higher-Ranked Lifetime Types
(HRT) in Rust device drivers -- it allows driver structs to hold direct
references to devres-managed resources, because the bus device private
data (and with it all such references) is guaranteed to be dropped while
the underlying devres resources are still alive.

Without this change, devres resources would be freed first, leaving the
driver's bus device private data with dangling references during its
destructor.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/base/dd.c             | 2 +-
 include/linux/device/driver.h | 4 ++--
 rust/kernel/driver.rs         | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 5799a60fd058..be59d2e13a15 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -593,9 +593,9 @@ static DEVICE_ATTR_RW(state_synced);
 
 static void device_unbind_cleanup(struct device *dev)
 {
-	devres_release_all(dev);
 	if (dev->driver->p_cb.post_unbind_rust)
 		dev->driver->p_cb.post_unbind_rust(dev);
+	devres_release_all(dev);
 	arch_teardown_dma_ops(dev);
 	kfree(dev->dma_range_map);
 	dev->dma_range_map = NULL;
diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
index bbc67ec513ed..38e9a4679447 100644
--- a/include/linux/device/driver.h
+++ b/include/linux/device/driver.h
@@ -123,8 +123,8 @@ struct device_driver {
 	struct driver_private *p;
 	struct {
 		/*
-		 * Called after remove() and after all devres entries have been
-		 * processed. This is a Rust only callback.
+		 * Called after remove() but before devres entries are released.
+		 * This is a Rust only callback.
 		 */
 		void (*post_unbind_rust)(struct device *dev);
 	} p_cb;
diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
index 36de8098754d..8f0e50729215 100644
--- a/rust/kernel/driver.rs
+++ b/rust/kernel/driver.rs
@@ -189,8 +189,8 @@ extern "C" fn post_unbind_callback(dev: *mut bindings::device) {
         // INVARIANT: `dev` is valid for the duration of the `post_unbind_callback()`.
         let dev = unsafe { &*dev.cast::<device::Device<device::CoreInternal>>() };
 
-        // `remove()` and all devres callbacks have been completed at this point, hence drop the
-        // driver's device private data.
+        // `remove()` has been completed at this point; devres resources are still valid and will
+        // be released after the driver's bus device private data is dropped.
         //
         // SAFETY: By the safety requirements of the `Driver` trait, `T::DriverData` is the
         // driver's device private data type.
-- 
2.54.0


