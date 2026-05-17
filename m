Return-Path: <linux-pwm+bounces-8922-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NkAD+gGCWouFgQAu9opvQ
	(envelope-from <linux-pwm+bounces-8922-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 02:08:08 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6D355E92C
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 02:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2AF8B306C4C7
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 00:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D44C1EB1AA;
	Sun, 17 May 2026 00:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tWAQTXre"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4590D405F7;
	Sun, 17 May 2026 00:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778976281; cv=none; b=TYjDNiIz00qxO2QOe39kehQYlpT4BM08TpiS2xKPpFmUUQJPfEbX44T4bEzsIcIwkakP0+CPS6MikYCeeas4otH5ScyCqkrKwGul22NCDmPBsh06ydtQnEC+792YtycfDZpwA+WSnD4qJLY01BCYQSGORxjJtIQVgC8dbqP1WCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778976281; c=relaxed/simple;
	bh=rJ9Zf42krWnw6GFHxY+YcEyrmhC+ZgJmklrrd85+jss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qpY4qzviLH0nYroUfvBNIK91lMalI65JFpaZHpB3IMSlXz3cGD8h/iTZJ7PyYX52RFygCTQPzQyPtNuJw9NQMHazRHUImiSnNhj9H+QKZsbZhans2gP98Lwsmlnw9LB3UB0s2Mb/poNNiAYOx94/lRWv28DkzSQ/HKGsQkmrDWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tWAQTXre; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C710EC2BCC7;
	Sun, 17 May 2026 00:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778976281;
	bh=rJ9Zf42krWnw6GFHxY+YcEyrmhC+ZgJmklrrd85+jss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tWAQTXreNrT3sTiNeC5mlLs5oVKJdEHYos4o7ou+u0R5pKnc2F5Lv6UNooFPq5D4o
	 Du1SZ/+CZ1vHAo6IAkKY9t7dV0xKvnV2QQVKgva7CpVxCTnJWm4nP4S30nxOHvnNAm
	 Y7yOc1FCSsnXkp7T5FHMYjz6dZuuCi+nX/FXZ4zJKgkSgmYjgIwYlh4M0QxG6VUtUS
	 OmX9auaax/8hdAk2ehehF5hxFZ50EJfwBjKc6keA1TUq5clH/AgME35e7VBXZEgw4Y
	 DfDPPsgMZzGobzLlZlQkz3O4NhcqV+9A76HMxhizG7hskO/4NMYTN84KczSRT8z4rE
	 oB4RF47wbDJ2A==
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
Subject: [PATCH REF v3 23/27] gpu: nova-core: rename 'a lifetime to 'bound
Date: Sun, 17 May 2026 02:01:11 +0200
Message-ID: <20260517000149.3226762-24-dakr@kernel.org>
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
X-Rspamd-Queue-Id: BD6D355E92C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-8922-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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


