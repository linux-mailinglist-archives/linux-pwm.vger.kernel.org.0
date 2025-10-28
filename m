Return-Path: <linux-pwm+bounces-7511-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D8DC1499F
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Oct 2025 13:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 86D7E4F2711
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Oct 2025 12:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2335232E14D;
	Tue, 28 Oct 2025 12:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LkN5orKn"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0E832D0F0
	for <linux-pwm@vger.kernel.org>; Tue, 28 Oct 2025 12:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761654202; cv=none; b=Cwwg/UesEkoJW0l5Bpk4yHg1U5q+w/NyKnpTt9Pi07ejl633hEypHy9uAv8dmmH+Nz3aLyqBpGFh99fTwlVkO+NvCXTSQexLWpmIJx6W6RUC4x2HN5SHcUiaYPdV9tkCYL8b6fSCa7P3YvvLz+tAxWXbiruYW3NmJLh+mp50mMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761654202; c=relaxed/simple;
	bh=CcfjXkudmcRMkM5k4FnFQVn2Pj1DpNZz1VwIHs0i84c=;
	h=From:Date:Subject:MIME-Version:Message-Id:In-Reply-To:To:Cc:
	 Content-Type:References; b=gAzCn/ne1NGfozmDjdgG8zyOjT4n6d4MQAlEHG0oscHIA/6lAL7x3Ie1NWyXQFVMzwAym+sj3mk62QRv+0tlmW5jy7RkyIYWhbTWR32bWfEC5AMqg54EFDN5RNgRkVTZ2x4cujxLDJwUUhjzLZTxAxKXq2dP41suOt/shcpgb0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=LkN5orKn; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20251028122318euoutp014cbf407bb5df249482ffc1ca88f2aacf~ypyj0uj520907609076euoutp01U
	for <linux-pwm@vger.kernel.org>; Tue, 28 Oct 2025 12:23:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20251028122318euoutp014cbf407bb5df249482ffc1ca88f2aacf~ypyj0uj520907609076euoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1761654198;
	bh=uWMsqhhcsDbSWAzMcyI6QgsDz6D9C7w2POWICu7CupQ=;
	h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
	b=LkN5orKn9XHXubVcNTl/1nuQvVq/uHBE3gmWBWr+njVfDGe1qwKGccWy7Qxfxhm73
	 49AfQbivz9L/BefYPWUM7iENdKJsXJn+iYMhWgpqv5OdVk9PjyvmIJ89YOoRJsA+UY
	 s/oYE8G8ywiXZMSqRTFvuNEigb0hGQsnDHVhhI6c=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20251028122318eucas1p17161f0e1f2281c868688e8a4cc3d8f68~ypyjVyJo80564105641eucas1p1P;
	Tue, 28 Oct 2025 12:23:18 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20251028122317eusmtip2563abe71fe7499c4e71a7162653a7e76~ypyih3a7n2998829988eusmtip2H;
	Tue, 28 Oct 2025 12:23:17 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Tue, 28 Oct 2025 13:22:34 +0100
Subject: [PATCH 3/4] pwm: th1520: Use module_pwm_platform_driver! macro
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-pwm_fixes-v1-3-25a532d31998@samsung.com>
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
X-CMS-MailID: 20251028122318eucas1p17161f0e1f2281c868688e8a4cc3d8f68
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251028122318eucas1p17161f0e1f2281c868688e8a4cc3d8f68
X-EPHeader: CA
X-CMS-RootMailID: 20251028122318eucas1p17161f0e1f2281c868688e8a4cc3d8f68
References: <20251028-pwm_fixes-v1-0-25a532d31998@samsung.com>
	<CGME20251028122318eucas1p17161f0e1f2281c868688e8a4cc3d8f68@eucas1p1.samsung.com>

The `pwm_th1520` Rust driver calls C functions from the `PWM` namespace,
triggering `modpost` warnings due to missing namespace import
declarations in its `.modinfo` section.

Fix these warnings and simplify the module declaration by switching from
the generic `kernel::module_platform_driver!` macro to the newly
introduced PWM-specific `kernel::module_pwm_platform_driver!` macro.
The new macro automatically handles the required `imports_ns: ["PWM"]`
declaration.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 drivers/pwm/pwm_th1520.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
index 0ad38b78be854ab3c10268fb20763d9962f59c0f..5fb123f5e9c6dc3a8ee9a7a47fa778c23213e957 100644
--- a/drivers/pwm/pwm_th1520.rs
+++ b/drivers/pwm/pwm_th1520.rs
@@ -369,7 +369,7 @@ fn probe(
     }
 }
 
-kernel::module_platform_driver! {
+kernel::module_pwm_platform_driver! {
     type: Th1520PwmPlatformDriver,
     name: "pwm-th1520",
     authors: ["Michal Wilczynski <m.wilczynski@samsung.com>"],

-- 
2.34.1


