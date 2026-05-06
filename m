Return-Path: <linux-pwm+bounces-8815-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAoSEWK5+2kxEAAAu9opvQ
	(envelope-from <linux-pwm+bounces-8815-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 06 May 2026 23:57:54 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C69FF4E0F53
	for <lists+linux-pwm@lfdr.de>; Wed, 06 May 2026 23:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A01130A729C
	for <lists+linux-pwm@lfdr.de>; Wed,  6 May 2026 21:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7E23B531A;
	Wed,  6 May 2026 21:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pCcSNroA"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7702B3B4E81;
	Wed,  6 May 2026 21:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778104423; cv=none; b=rxN+N7TgPH9P40ZN4INv438SWyoQNt6CAFlpBChT/+ma2RFJWG5pBaiZa9Da8yFmfbDooNoig/WAmqlz9Lh8a0PiFLnkeua3JEpidNQYD1mQuNzsAj+EastjLqBYos3BO6GPEmd6sDVHY/A5LGK7kAUymcNSnlqEk7b5uoAnUTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778104423; c=relaxed/simple;
	bh=rJ9Zf42krWnw6GFHxY+YcEyrmhC+ZgJmklrrd85+jss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dTte6Cgp7MR2CK30cYbUszyH6MdwSF060SHDqCiWFfyXriuijFY3Dg3Bna/bpuA3EOo+3rPivNSC/iMHl8SBuXUFtUzMLmm+AxLjwc16lBqGKMRd5nxEByw77NNYHqkKiwxQpDAdBxB3ADDo7ULIW3rEzIllP+r+CxhbtO8S4sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pCcSNroA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCFD0C2BCB2;
	Wed,  6 May 2026 21:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778104423;
	bh=rJ9Zf42krWnw6GFHxY+YcEyrmhC+ZgJmklrrd85+jss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pCcSNroALL1xSHMZYPlVdmtM878HCCVaqIiIa7SXFqPg3QO8LXrVN0UIeXAACWsb2
	 3eZa+yTNX5aqqXWSbA/6P8FV2bbn9g9MPjQhrKmL7DBHKW9BK/AVe2kLp8vkm/sBas
	 jXoCs+rS7WXRP2Or5zhlmF8oJVqLGs/y9+v9r6k5VXXrCtVIZsW+F7JS7TlV1mbFfu
	 f4/bUiiAoJOGLFJISzHdLjFhO7uHF7WTGBL1PCHd15845vENxADZ6nK9SyEnqY+qd+
	 rFc5unDGBecf5nsvc3ANSVIJBrB2Y+eq4aFRH1YqllDyWbrwrMz0TWxWfJkVS/lWL4
	 UA965uYpRp9wQ==
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
Subject: [PATCH v2 21/25] gpu: nova-core: rename 'a lifetime to 'bound
Date: Wed,  6 May 2026 23:50:57 +0200
Message-ID: <20260506215113.851360-22-dakr@kernel.org>
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
X-Rspamd-Queue-Id: C69FF4E0F53
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com];
	TAGGED_FROM(0.00)[bounces-8815-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Rename the generic lifetime parameter from 'a to 'bound in nova-core.
This makes it explicit that the lifetime represents the device binding
scope, consistent with the convention established by the HRT series.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/nova-core/firmware/gsp.rs    |  8 ++++----
 drivers/gpu/nova-core/gpu.rs             |  8 ++++----
 drivers/gpu/nova-core/gsp/commands.rs    | 10 +++++-----
 drivers/gpu/nova-core/gsp/fw/commands.rs |  4 +++-
 4 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/nova-core/firmware/gsp.rs b/drivers/gpu/nova-core/firmware/gsp.rs
index 2fcc255c3bc8..9dbd88c55f7e 100644
--- a/drivers/gpu/nova-core/firmware/gsp.rs
+++ b/drivers/gpu/nova-core/firmware/gsp.rs
@@ -65,11 +65,11 @@ pub(crate) struct GspFirmware {
 impl GspFirmware {
     /// Loads the GSP firmware binaries, map them into `dev`'s address-space, and creates the page
     /// tables expected by the GSP bootloader to load it.
-    pub(crate) fn new<'a>(
-        dev: &'a device::Device<device::Bound>,
+    pub(crate) fn new<'bound>(
+        dev: &'bound device::Device<device::Bound>,
         chipset: Chipset,
-        ver: &'a str,
-    ) -> impl PinInit<Self, Error> + 'a {
+        ver: &'bound str,
+    ) -> impl PinInit<Self, Error> + 'bound {
         pin_init::pin_init_scope(move || {
             let firmware = super::request_firmware(dev, chipset, "gsp", ver)?;
 
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 0f6fe9a1b955..9288b30fe4c3 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -241,11 +241,11 @@ pub(crate) struct Gpu {
 }
 
 impl Gpu {
-    pub(crate) fn new<'a>(
-        pdev: &'a pci::Device<device::Bound>,
+    pub(crate) fn new<'bound>(
+        pdev: &'bound pci::Device<device::Bound>,
         devres_bar: Arc<Devres<Bar0>>,
-        bar: &'a Bar0,
-    ) -> impl PinInit<Self, Error> + 'a {
+        bar: &'bound Bar0,
+    ) -> impl PinInit<Self, Error> + 'bound {
         try_pin_init!(Self {
             spec: Spec::new(pdev.as_ref(), bar).inspect(|spec| {
                 dev_info!(pdev,"NVIDIA ({})\n", spec);
diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index c89c7b57a751..0da5b92f4b27 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -35,18 +35,18 @@
 };
 
 /// The `GspSetSystemInfo` command.
-pub(crate) struct SetSystemInfo<'a> {
-    pdev: &'a pci::Device<device::Bound>,
+pub(crate) struct SetSystemInfo<'bound> {
+    pdev: &'bound pci::Device<device::Bound>,
 }
 
-impl<'a> SetSystemInfo<'a> {
+impl<'bound> SetSystemInfo<'bound> {
     /// Creates a new `GspSetSystemInfo` command using the parameters of `pdev`.
-    pub(crate) fn new(pdev: &'a pci::Device<device::Bound>) -> Self {
+    pub(crate) fn new(pdev: &'bound pci::Device<device::Bound>) -> Self {
         Self { pdev }
     }
 }
 
-impl<'a> CommandToGsp for SetSystemInfo<'a> {
+impl<'bound> CommandToGsp for SetSystemInfo<'bound> {
     const FUNCTION: MsgFunction = MsgFunction::GspSetSystemInfo;
     type Command = GspSetSystemInfo;
     type Reply = NoReply;
diff --git a/drivers/gpu/nova-core/gsp/fw/commands.rs b/drivers/gpu/nova-core/gsp/fw/commands.rs
index db46276430be..d3ef7ecdd73e 100644
--- a/drivers/gpu/nova-core/gsp/fw/commands.rs
+++ b/drivers/gpu/nova-core/gsp/fw/commands.rs
@@ -24,7 +24,9 @@ pub(crate) struct GspSetSystemInfo {
 impl GspSetSystemInfo {
     /// Returns an in-place initializer for the `GspSetSystemInfo` command.
     #[allow(non_snake_case)]
-    pub(crate) fn init<'a>(dev: &'a pci::Device<device::Bound>) -> impl Init<Self, Error> + 'a {
+    pub(crate) fn init<'bound>(
+        dev: &'bound pci::Device<device::Bound>,
+    ) -> impl Init<Self, Error> + 'bound {
         type InnerGspSystemInfo = bindings::GspSystemInfo;
         let init_inner = try_init!(InnerGspSystemInfo {
             gpuPhysAddr: dev.resource_start(0)?,
-- 
2.54.0


