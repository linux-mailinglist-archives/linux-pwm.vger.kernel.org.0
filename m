Return-Path: <linux-pwm+bounces-9143-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MbdyOjCzFGo4PgcAu9opvQ
	(envelope-from <linux-pwm+bounces-9143-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 22:38:08 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 626545CE9B4
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 22:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C03453047BCA
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 20:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705413A544F;
	Mon, 25 May 2026 20:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGqL+gBh"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275EE388395;
	Mon, 25 May 2026 20:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779741094; cv=none; b=fbSg0a7oIubX4vugKB3cZtP2RIXWdUH6jzHAkqpT7AgyeH9zV0kdQspJcBJZAK50211x/ns4QsIF9YxlYsA8z1Q/erG4r/2tZmTV/TRwKr0/NXVO5haBcRQFIPgPcgd6ta0dOLtUi0itCbXe0ABNEEHoO5DCjJik8mgz9oVDWNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779741094; c=relaxed/simple;
	bh=4lUdb3GLV0bIT4cTMl+sMY7+bby0f6VtUE0KQm+Iua8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J/7CmMvJW6Ky25N7ETF/U9Qxx2cxtrjHT5OzzYyaEVafNZ2HQjRjHRTZcGa/d+mrLcDg9mPNf2XeKjNKU6nmS3C3fG7bmTo3FOYB4eri785tG3ts1zwwliwe1j1bJduaEbB2uOv/NEFNOMKCCEe8+4QRt6NYVwfBqCuJQt2G3yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGqL+gBh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C5431F00A3C;
	Mon, 25 May 2026 20:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779741092;
	bh=Se+m8/YyT4y61WXM80uAn3qM9HqLztSmo/d1R/PiPM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iGqL+gBhYw6zBQp6KgNgwxdmLs9m0TBr/SSZlfKne4Vr3qbvp+59sUzQJdbQbKk3K
	 7ZhUFF6yPnVy5leu9VG2kgzIap10ibL87kYsXVKngvbNwTldOJcISU6cYrRSLPffOO
	 P4m0V+pMx/X0UbyYAizJxQ+ck4GYw0FyoqfrTpFe3YP/4T81txh4n9P+BWUaLf2cWh
	 c1Ju9gtCP1meNHqIM0sWVV80XeEjwdARl6QkRf6838/Cz/VVdFdYAsc4hPGKcyc56+
	 im4yJJ6m1uTM2yzVXBCjXT4PRAVoJrfndobKovSkaUasruFtXZvAMTcMLpOWw1K/Ta
	 GwEOCVOvfDPOg==
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
Subject: [PATCH v5 17/24] rust: driver: update module documentation for GAT-based Data type
Date: Mon, 25 May 2026 22:21:04 +0200
Message-ID: <20260525202921.124698-18-dakr@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9143-lists,linux-pwm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[34];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-pwm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.985];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 626545CE9B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Now that all bus driver traits use type Data<'bound>: 'bound, update the
illustrative driver trait in the module documentation to reflect the GAT
pattern and lifetime-parameterized callbacks.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/driver.rs | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
index 558fdef4a1c6..03c0dd713f4c 100644
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


