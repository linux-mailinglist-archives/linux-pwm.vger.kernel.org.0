Return-Path: <linux-pwm+bounces-9127-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kH1zAZ6xFGrRPQcAu9opvQ
	(envelope-from <linux-pwm+bounces-9127-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 22:31:26 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6265E5CE76F
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 22:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5073301E3C9
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 20:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71076395AC6;
	Mon, 25 May 2026 20:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSgKPNc+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3343955E6;
	Mon, 25 May 2026 20:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779740979; cv=none; b=N8kfUvcr/WsIaWH9yXapJ3nLLDcGhE9z47zLxYeWME1ReglL0/qPAT5e5njw8N60QqjIv2U/wy1I+0WWquyY7xhdD3Y+z7E2xqs/mBKZJ2rS0r2BHHqUyCs/2lLX7S8wway3JH+FLSZEW73QeVjYx/0AarZQ9XzhssUo5MT8RBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779740979; c=relaxed/simple;
	bh=rAFNx8RypDYKG+dpWgDHjGVQ/4vHb+Tv98qyCpRhLTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OtApthCnN2jF7iIs58cVVjRQmcfIzIUhBKcyj0tiZXZ34uStzvQUSc7Y/Daeujy7HPQ+JnWdBme9qE1hTRB+VLLiGiHI71l2xeCFQHOG8GsHoZ31R534uGIUBxV6BxVbcunmTyQYXPzSaagnN4PVGTA0KI2GkKgIzN67vQFNaWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QSgKPNc+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD7E81F00A3A;
	Mon, 25 May 2026 20:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779740978;
	bh=f29QOiLOmTtepPqGTyUIO0rU++hJKbjbxryGjGLUDYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QSgKPNc+JoRjxcpaHyht4zv1jP+wZg3OUncC/d7JZRePkLU6NHmtZSEMDQb/QPWct
	 GC9fW/BK9+kX9xOJtJ8M5dqXJYz9pte2/JD4eyCF16z9U3H13hkrsyqNN5dwmuG1f8
	 TmSVS0dtRu1Hzt2fUn6Ibro2kAlCFH4xfrxqSTmnRwkHxL2qvzJmEl4oLgc3/CGBwA
	 DxDk4mTWDwYVGItXOj8QDkK6pN+snuv1e9ECsoWqGa8SXd5mTfBXhBO3xMV+kcHwdD
	 PLwi7aMRYda8UA46SspnWMp2Z9WMz2eLc+2BHNjOcsNmA4vj6p6j6qfaH1V44+RmQn
	 VvuK2ddEc9WhQ==
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
	Danilo Krummrich <dakr@kernel.org>,
	stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v5 01/24] rust: pci: use 'static lifetime for PCI BAR resource names
Date: Mon, 25 May 2026 22:20:48 +0200
Message-ID: <20260525202921.124698-2-dakr@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-9127-lists,linux-pwm=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6265E5CE76F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

pci_request_region() stores the name pointer directly in struct
resource; use &'static CStr to ensure the pointer remains valid even if
the Bar is leaked.

Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260522004943.CDA7C1F000E9@smtp.kernel.org/
Fixes: 3c2e31d717ac ("rust: pci: move I/O infrastructure to separate file")
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/pci/io.rs | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index ae78676c927f..3ce21482b079 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -153,7 +153,7 @@ pub struct Bar<const SIZE: usize = 0> {
 }
 
 impl<const SIZE: usize> Bar<SIZE> {
-    pub(super) fn new(pdev: &Device, num: u32, name: &CStr) -> Result<Self> {
+    pub(super) fn new(pdev: &Device, num: u32, name: &'static CStr) -> Result<Self> {
         let len = pdev.resource_len(num)?;
         if len == 0 {
             return Err(ENOMEM);
@@ -252,7 +252,7 @@ impl Device<device::Bound> {
     pub fn iomap_region_sized<'a, const SIZE: usize>(
         &'a self,
         bar: u32,
-        name: &'a CStr,
+        name: &'static CStr,
     ) -> impl PinInit<Devres<Bar<SIZE>>, Error> + 'a {
         Devres::new(self.as_ref(), Bar::<SIZE>::new(self, bar, name))
     }
@@ -261,7 +261,7 @@ pub fn iomap_region_sized<'a, const SIZE: usize>(
     pub fn iomap_region<'a>(
         &'a self,
         bar: u32,
-        name: &'a CStr,
+        name: &'static CStr,
     ) -> impl PinInit<Devres<Bar>, Error> + 'a {
         self.iomap_region_sized::<0>(bar, name)
     }
-- 
2.54.0


