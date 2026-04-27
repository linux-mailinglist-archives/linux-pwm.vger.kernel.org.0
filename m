Return-Path: <linux-pwm+bounces-8713-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILW2BaHf72kiHQEAu9opvQ
	(envelope-from <linux-pwm+bounces-8713-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Apr 2026 00:13:53 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 174B447B374
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Apr 2026 00:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2F3F23010776
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Apr 2026 22:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B663E3ACEF0;
	Mon, 27 Apr 2026 22:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tpxe20+p"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEEB3A9D92;
	Mon, 27 Apr 2026 22:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777327991; cv=none; b=tgpjHCQW8JG0zIVBC3V1bLcZPGL0r5pfNazvqoOLty1IN44cAkHgAh9nXVMiKCASIB6K+tLd7oKg/c9cXw/4eNJoTe6YW2CbYCOw6VsgasFQHOIaPpeItPDByi0Sl3L392eH/e9ReLDuA7bmgSnwRPv4DDKRVh+Yzr6OF10JS2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777327991; c=relaxed/simple;
	bh=auHxUUsQH6YXhhsoPM2i0zRThcG3GjhIs2ycbNDnDEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fcpzTJjc0vllHVnD3vfbHO05mJZY+R4wAOa238REEcYA5ZhHJiLaTqFcG7lD+xaGWOC7j+ac6ExAZ2huSpMW6MsK7Wzby+3dBFinT+7yguaqDkjkv0AaqG/C/bKmHvDvCE2KRYvuBR9Ikx9wHZNOnodUvl2YFLzdpONfWxqIuYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tpxe20+p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 620F6C2BCB5;
	Mon, 27 Apr 2026 22:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777327991;
	bh=auHxUUsQH6YXhhsoPM2i0zRThcG3GjhIs2ycbNDnDEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tpxe20+pywFn3Tok0SQvaoZWh+7phDXK2kLMxayygbnAbIGpo4k5r99nyg4ok/TJ/
	 SBrRKriatJkTg+0/rNlGho/QEAN0URtpVftUITiFgz2PeDEoV+PZVNxNFH1xG+PPeM
	 2l938aLVge8Y5kYhVxsdNslPc7pfluaqm1oARKGxJQluXP7FWJVv8KXlEF6MARCVK0
	 R03bksZMeUO14VT8jFy1rBybwQBp4DWLGX+z2POqWWcfj3J6li5f2ak6K9SenC1p3N
	 7DnNU0RItI+Fs6iuvcc1ndUxyHPK59ARQzj2B906M/KbqDQOr7YNNJf236NiaDcESF
	 hqZrZA6jz778g==
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
Subject: [PATCH 10/24] rust: device: implement Sync for Device<Bound>
Date: Tue, 28 Apr 2026 00:11:08 +0200
Message-ID: <20260427221155.2144848-11-dakr@kernel.org>
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
X-Rspamd-Queue-Id: 174B447B374
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8713-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

The underlying `struct device` is the same for all device contexts;
`Bound` is a zero-sized type-state marker that does not affect thread
safety. Implement `Sync` for `Device<Bound>` with the same safety
argument as the existing `Device<Normal>` implementation.

This is needed for types that hold `&'a Device<Bound>`, such as
`io::mem::IoMem`, to be `Send`.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/device.rs | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 09cbe8a438a9..b330b87178d3 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -503,6 +503,10 @@ unsafe impl Send for Device {}
 // synchronization in `struct device`.
 unsafe impl Sync for Device {}
 
+// SAFETY: Same as `Device<Normal>` -- the underlying `struct device` is the same; `Bound` is a
+// zero-sized type-state marker that does not affect thread safety.
+unsafe impl Sync for Device<Bound> {}
+
 /// Marker trait for the context or scope of a bus specific device.
 ///
 /// [`DeviceContext`] is a marker trait for types representing the context of a bus specific
-- 
2.54.0


