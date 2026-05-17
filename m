Return-Path: <linux-pwm+bounces-8906-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPvHLsgFCWq6FQQAu9opvQ
	(envelope-from <linux-pwm+bounces-8906-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 02:03:20 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC3055E692
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 02:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1C759301C968
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 00:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2D5757EA;
	Sun, 17 May 2026 00:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Au3buofe"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75034A02;
	Sun, 17 May 2026 00:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778976172; cv=none; b=A9ft8d8iI/Wzfk+mcTJDlOTaMLjmROa9sl6avGAk6ZPP7K/j4h/ThHxmVoV6J8HQgngYhCG4yhYtWA97+JzRzpCspxuD3e9fTqCd9AFhke4Bg/LzeYQhVLahdlsZTR/Fj4U/U17KEMYcy4rLy0XxHZVuZ1gcBXtv6LJ/BKSasFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778976172; c=relaxed/simple;
	bh=5pQ1tWMQH08VgI8Ev98ZvIYPGeiOmGtobQJ2EGkR7h0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d3MzjRD7BWGMwcMgnmFY+vdw0wR3rT/de32k0ly+QSnKNOj9WEHgUZ0TKvcN9OWIi9/Y7oEjRWwkCj8KogSXYSzWkDFL+3m3CNGKpAN6bboEig9isGs8iDA06wj+ixfS6yT74b02v5v1D20+TbmYpK7/8H7swMfv0RZMkoOjwJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Au3buofe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0478AC2BCB7;
	Sun, 17 May 2026 00:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778976172;
	bh=5pQ1tWMQH08VgI8Ev98ZvIYPGeiOmGtobQJ2EGkR7h0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Au3buofeMl57efN+wcKAKe0KFI41dHCYL1GTQvvPLTWAgWYnfUQk8xeOSapAM+DBX
	 UitlsIicgHB93AswxdrJHS2ZXrLo/ixUf0jJfer5IPYCZUWbI1Xfmj1Y2XzvhG5EWt
	 QPv/uFi9pS8ZhLpdrN/bWR1t9SP29uEdW6/IqlwyfVkg1P2FeiCnwbTGDSDJEW2FVG
	 synC9FKVQH2vERZx2RHmZhPWJhfvqoN6W1h7UV8xhZ6sKmxz2X9Th/SbHmMGKP8ou5
	 IWKNWDNEA2wx0USL/LGrblgvTgV8JVW536hMPfo9j2UnIrhbibPsSI7nNl3NSiJ6B4
	 xHUqMuhFVBZ0Q==
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
Subject: [PATCH v3 07/27] rust: auxiliary: implement Sync for Device<Bound>
Date: Sun, 17 May 2026 02:00:55 +0200
Message-ID: <20260517000149.3226762-8-dakr@kernel.org>
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
X-Rspamd-Queue-Id: 3EC3055E692
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8906-lists,linux-pwm=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Implement Sync for Device<Bound> in addition to Device<Normal>.

Device<Bound> uses the same underlying struct auxiliary_device as
Device<Normal>; Bound is a zero-sized type-state marker that does not
affect thread safety.

This is needed for drivers to store &'bound auxiliary::Device<Bound> in
their private data while remaining Send.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/auxiliary.rs | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index 1b6ff3817a4d..c6d97c95c3e7 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -369,6 +369,10 @@ unsafe impl Send for Device {}
 // (i.e. `Device<Normal>) are thread safe.
 unsafe impl Sync for Device {}
 
+// SAFETY: Same as `Device<Normal>` -- the underlying `struct auxiliary_device` is the same;
+// `Bound` is a zero-sized type-state marker that does not affect thread safety.
+unsafe impl Sync for Device<device::Bound> {}
+
 /// Wrapper that stores a [`TypeId`] alongside the registration data for runtime type checking.
 #[repr(C)]
 #[pin_data]
-- 
2.54.0


