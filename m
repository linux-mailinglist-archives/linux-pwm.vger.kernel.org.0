Return-Path: <linux-pwm+bounces-7510-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DB2C149AB
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Oct 2025 13:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7256046484A
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Oct 2025 12:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BB132D7DA;
	Tue, 28 Oct 2025 12:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="O4TEa0ov"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF7032D0DE
	for <linux-pwm@vger.kernel.org>; Tue, 28 Oct 2025 12:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761654201; cv=none; b=mQ/piGI+I/Uu+SqUaseZ8GCRz7yOXCQo3oBn47HYg2Qi5dovdBquxs226FUozHJETtstUbfcr1FT1G9FXxhcafpUWmX5d6nYb5eT4EWlglol6S6O3KW1bNEmdJldSU10Sbgqq458CeCwcqZsbxrdXpRlg1COtyPpWgN80dFo/B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761654201; c=relaxed/simple;
	bh=IEvI35ov+XAqEtHcG8sOgZroRPI+evTW3+Prd+Jl19E=;
	h=From:Date:Subject:MIME-Version:Message-Id:In-Reply-To:To:Cc:
	 Content-Type:References; b=BEon2C66zAsgbCpzoxg5zh5iCZOFb8fntCBtwOqupltkVbeyj9WqjtyDuFiHZcNdgXmsXKqGprb1sBZRpxA6HK51WBc90YBvqdHm8SD6Ro7ELCifPWHkmXKjrkO1WpWGBt7SscvkQ2sXe0NHb8A2bKV6Os/R5JgBl0LngOhTexA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=O4TEa0ov; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20251028122318euoutp02c4b61c394be696fcb87c8829c0772eb2~ypyjdo3O80283102831euoutp02X
	for <linux-pwm@vger.kernel.org>; Tue, 28 Oct 2025 12:23:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20251028122318euoutp02c4b61c394be696fcb87c8829c0772eb2~ypyjdo3O80283102831euoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1761654198;
	bh=jGjkU3U0JLre9e/0ro7TQvedWMp8tpNdUoBxZXg3c10=;
	h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
	b=O4TEa0ovaGQfOSHEhlZb7p626KKV02YzVfksnIiEeGHcvJ6l4dpa+TCS8NYK2BXhe
	 5vEx6KyJ/dzsgLbX6C6dDUvcFj0JA2osFsYgPWoT5CLbxbUKvtsiTVkW2TzgG/ccZ1
	 bl6rc2jiMWdvb2ot7Hc4vriSkKbJOkmnDgB3R4JU=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20251028122317eucas1p1e7c925502a83dd3324478c0209de08c3~ypyidlIXm1056510565eucas1p1E;
	Tue, 28 Oct 2025 12:23:17 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20251028122316eusmtip2a58bac4a211ef65df4d1d0fd332e1469~ypyhsC2tI3027130271eusmtip2Y;
	Tue, 28 Oct 2025 12:23:16 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Tue, 28 Oct 2025 13:22:33 +0100
Subject: [PATCH 2/4] rust: pwm: Add module_pwm_platform_driver! macro
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-pwm_fixes-v1-2-25a532d31998@samsung.com>
In-Reply-To: <20251028-pwm_fixes-v1-0-25a532d31998@samsung.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,  Benno Lossin
	<lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,  Alice Ryhl
	<aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,  Danilo Krummrich
	<dakr@kernel.org>,  Michal Wilczynski <m.wilczynski@samsung.com>,  Drew
	Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>,  Fu Wei
	<wefu@redhat.com>,  =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-riscv@lists.infradead.org
X-Mailer: b4 0.15-dev
X-CMS-MailID: 20251028122317eucas1p1e7c925502a83dd3324478c0209de08c3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251028122317eucas1p1e7c925502a83dd3324478c0209de08c3
X-EPHeader: CA
X-CMS-RootMailID: 20251028122317eucas1p1e7c925502a83dd3324478c0209de08c3
References: <20251028-pwm_fixes-v1-0-25a532d31998@samsung.com>
	<CGME20251028122317eucas1p1e7c925502a83dd3324478c0209de08c3@eucas1p1.samsung.com>

Rust PWM drivers using the abstractions in `kernel/pwm.rs` typically
call C functions (like `pwmchip_alloc`, `__pwmchip_add`, etc.) that are
exported to the `PWM` C symbol namespace.

With the introduction of `imports_ns` support in the `module!` macro,
every PWM driver would need to manually include `imports_ns: ["PWM"]` in
its module declaration.

To simplify this for driver authors and ensure consistency, introduce a
new helper macro `module_pwm_platform_driver!` in `pwm.rs`. This macro
wraps the standard `module_platform_driver!`, forwards all user provided
arguments using the `($($user_args:tt)*)` pattern, and automatically
injects the `imports_ns: ["PWM"]` declaration.

This follows the pattern used in other subsystems (e.g.,
`module_pci_driver!`) to provide specialized module registration
helpers. It makes writing PWM drivers slightly simpler and less error
prone regarding namespace imports.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 rust/kernel/pwm.rs | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/rust/kernel/pwm.rs b/rust/kernel/pwm.rs
index 79fbb13cd47f75681283648ddc4fffb7889be930..6f2f78c687d5b924739f59052e9b3393c922540d 100644
--- a/rust/kernel/pwm.rs
+++ b/rust/kernel/pwm.rs
@@ -760,3 +760,26 @@ fn drop(&mut self) {
         unsafe { bindings::pwmchip_remove(chip_raw); }
     }
 }
+
+/// Declares a kernel module that exposes a single PWM driver.
+///
+/// # Examples
+///
+///```ignore
+/// kernel::module_pwm_platform_driver! {
+///     type: MyDriver,
+///     name: "Module name",
+///     authors: ["Author name"],
+///     description: "Description",
+///     license: "GPL v2",
+/// }
+///```
+#[macro_export]
+macro_rules! module_pwm_platform_driver {
+    ($($user_args:tt)*) => {
+        $crate::module_platform_driver! {
+            $($user_args)*
+            imports_ns: ["PWM"],
+        }
+    };
+}

-- 
2.34.1


