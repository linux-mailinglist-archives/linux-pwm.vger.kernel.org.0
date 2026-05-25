Return-Path: <linux-pwm+bounces-9131-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIwhFJmxFGoHPgcAu9opvQ
	(envelope-from <linux-pwm+bounces-9131-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 22:31:21 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F2A5CE757
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 22:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 20F37301FAA7
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 20:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482E0388363;
	Mon, 25 May 2026 20:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cc/Sa11s"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAC13451A7;
	Mon, 25 May 2026 20:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779741008; cv=none; b=DY4q7xApSI6siXpYo9YTph1jS90cP6p2ghY4Xim3DFo0j1qOoSQewgfwa4KywqXCzoodbpfZnGD8/NJlgjSZhSQrXFL0xZDdGgOTsyn25bMXnaMhxKORzhriOYYNeHcDhoxsg6EQHnAawlBUd7XCSXWCIbPZZQxLrr4paUS4WRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779741008; c=relaxed/simple;
	bh=DzmbuehWP/n+z9bBA3kIKR03PtD9qEhtHM53dYd3cEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YsXk+oYvX8LmnROxesJRlvzcVPLghqhliC56Ws+cx/TFyLCxDJJgyXNIaycVe0gR8VUPqftDLC3UfwSHFl46+QtsSfhxA1nrehLfiynNBKawplC2pfCLaOI0IfhkjTLVzwdidthJ6/0RlhgWnuntGZV6pc5p9tUY0mtNrxICpZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cc/Sa11s; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D261F00A3A;
	Mon, 25 May 2026 20:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779741006;
	bh=chpl2dAT305MB/BwkNuO7Y8z5fBgSREADsJUl5S4kCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cc/Sa11s9zjXzmchlAii/dpVBnPe8UJOcKIAC3wyF7B/6LT1W150LAfz/J4YslPHV
	 gj/GWvUTSSHfWc3sUghykHhwCZq7bUJX+3gMmnBNRQ6s8xEYupgjmLQtzFnRTdFM9d
	 TkCUihgzbCPQ48zNJvaTILpSSimR8v0W4P2OAKKjgS82npPAYXmaogacuxIH+Dx8Kw
	 R2r0bratOD5sGpALpE+ll/rVNqZU/aKaduqKMSGbo4Nr9bmRH5kr0NozLAcvCYoHnH
	 73ljS70s/HS31DVgbc0sXYlK5kRFTeixW67Xtywa7nPBwL0TyGcBQLI6d790uzSULx
	 iKSGpVNc8J8fA==
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
Subject: [PATCH v5 05/24] rust: driver core: drop drvdata before devres release
Date: Mon, 25 May 2026 22:20:52 +0200
Message-ID: <20260525202921.124698-6-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525202921.124698-1-dakr@kernel.org>
References: <20260525202921.124698-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-9131-lists,linux-pwm=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.985];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,nvidia.com:email,garyguo.net:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D0F2A5CE757
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/base/dd.c             | 2 +-
 include/linux/device/driver.h | 4 ++--
 rust/kernel/driver.rs         | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 1dc1e3528043..73801b40a416 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -595,9 +595,9 @@ static DEVICE_ATTR_RW(state_synced);
 
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
index 5fd1cfd64e93..a95dafaa9d68 100644
--- a/rust/kernel/driver.rs
+++ b/rust/kernel/driver.rs
@@ -193,8 +193,8 @@ extern "C" fn post_unbind_callback(dev: *mut bindings::device) {
         // INVARIANT: `dev` is valid for the duration of the `post_unbind_callback()`.
         let dev = unsafe { &*dev.cast::<device::Device<device::CoreInternal>>() };
 
-        // `remove()` and all devres callbacks have been completed at this point, hence drop the
-        // driver's device private data.
+        // `remove()` has been completed at this point; devres resources are still valid and will
+        // be released after the driver's bus device private data is dropped.
         //
         // SAFETY: By the safety requirements of the `Driver` trait, `T::DriverData` is the
         // driver's bus device private data type.
-- 
2.54.0


