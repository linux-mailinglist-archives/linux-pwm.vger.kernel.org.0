Return-Path: <linux-pwm+bounces-9063-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NOzMgyaD2r5NgYAu9opvQ
	(envelope-from <linux-pwm+bounces-9063-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 22 May 2026 01:49:32 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CC05AD0C8
	for <lists+linux-pwm@lfdr.de>; Fri, 22 May 2026 01:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD76B30277D4
	for <lists+linux-pwm@lfdr.de>; Thu, 21 May 2026 23:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAA738228F;
	Thu, 21 May 2026 23:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LyhRh4YP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36300371888;
	Thu, 21 May 2026 23:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779406874; cv=none; b=QKItICdXUTcf3Rv9RzIT8gFhaJB/ehR4bxZdAc6dC5iWwEB9wRUwYuJ40upzkCw9WnOFw9dGHZzcpxQBJEI/RJasP1mmr01qyS4HQ3G4ggKDuQVsQeXqYqfzphxxvaaXVh7bTAwdRU3g+NzaxCqwE0PwYxLdaHp3NRujZpa21tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779406874; c=relaxed/simple;
	bh=OQslwCmDtW//31f/bssd5QXIOeASEqVhoSDrONJcCNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j54r3W8O1ybLgI8YkqcYJsQ1sNAmI4t9bbIPbybArvYa6jvtk+kWFP1Zjz9jvDg1CEAKoBFwoph8boZoHR/iByzSs9rkPJJ0wuGSHm66xPxvr9bOtWo8iJU/vIFMv3aTm3jnaOVhi7hkkqrKujpUdUl0tpf+pBwXJ+pUE4zDW4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LyhRh4YP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C25261F00A3C;
	Thu, 21 May 2026 23:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779406869;
	bh=JwcbKbNRK8uAfwmPt5zsBCbjPSi2Kcj3uVLASq+gxic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LyhRh4YPeVfL1qX1kZKG7e/4oRdnyxvm1ypMMuVFPQyzJB2VUBVaYZLOd39JuOICT
	 Ub9YkDZK43HQNUtA3inAbs0dREXFiRSf7elgywVJOGbGZG/RyTjN0vtSd6zitwk+r/
	 PUb+JszKvMDLpz4K98EQ/Gz3rJvZCEeFogVMQfYiv9RvKSEDHJRvOBXvGAKdpsQB76
	 9cKNE1UfQW9/I9ukWnGQanP8BD7dp6YaVWvtOGm/GK/2W4SQ7yJRGkkAfrWcxdx9Jc
	 sbz1tqNWQVp2J2QqnnuOlDQYD6ywO7pSoHH+MoNJinI8U1cXkAPNoKEWGV3XKPDxeR
	 YLt49vmo8xGIg==
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
Subject: [PATCH v4 16/27] rust: driver: update module documentation for GAT-based Data type
Date: Fri, 22 May 2026 01:34:42 +0200
Message-ID: <20260521233501.1191842-17-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521233501.1191842-1-dakr@kernel.org>
References: <20260521233501.1191842-1-dakr@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-9063-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email]
X-Rspamd-Queue-Id: 36CC05AD0C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Now that all bus driver traits use type Data<'bound>: 'bound, update the
illustrative driver trait in the module documentation to reflect the GAT
pattern and lifetime-parameterized callbacks.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/driver.rs | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
index 93df26ec7caf..bf5ba0d27553 100644
--- a/rust/kernel/driver.rs
+++ b/rust/kernel/driver.rs
@@ -18,7 +18,7 @@
 //!     type IdInfo: 'static;
 //!
 //!     /// The type of the driver's bus device private data.
-//!     type Data: Send;
+//!     type Data<'bound>: Send + 'bound;
 //!
 //!     /// The table of OF device ids supported by the driver.
 //!     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = None;
@@ -27,11 +27,16 @@
 //!     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = None;
 //!
 //!     /// Driver probe.
-//!     fn probe(dev: &Device<device::Core<'_>>, id_info: &Self::IdInfo)
-//!         -> impl PinInit<Self::Data, Error>;
+//!     fn probe<'bound>(
+//!         dev: &'bound Device<device::Core<'_>>,
+//!         id_info: &'bound Self::IdInfo,
+//!     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound;
 //!
 //!     /// Driver unbind (optional).
-//!     fn unbind(dev: &Device<device::Core<'_>>, this: Pin<&Self::Data>) {
+//!     fn unbind<'bound>(
+//!         dev: &'bound Device<device::Core<'_>>,
+//!         this: Pin<&Self::Data<'bound>>,
+//!     ) {
 //!         let _ = (dev, this);
 //!     }
 //! }
@@ -46,9 +51,10 @@
 )]
 #![cfg_attr(CONFIG_PCI, doc = "* [`pci::Driver`](kernel::pci::Driver)")]
 //!
-//! The `probe()` callback should return a `impl PinInit<Self::Data, Error>`, i.e. the driver's
-//! private data. The bus abstraction should store the pointer in the corresponding bus device. The
-//! generic [`Device`] infrastructure provides common helpers for this purpose on its
+//! The `probe()` callback should return a
+//! `impl PinInit<Self::Data<'bound>, Error>`, i.e. the driver's private data. The bus
+//! abstraction should store the pointer in the corresponding bus device. The generic
+//! [`Device`] infrastructure provides common helpers for this purpose on its
 //! [`Device<CoreInternal>`] implementation.
 //!
 //! All driver callbacks should provide a reference to the driver's private data. Once the driver
-- 
2.54.0


