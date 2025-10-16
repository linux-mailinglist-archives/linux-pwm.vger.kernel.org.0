Return-Path: <linux-pwm+bounces-7456-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3437EBE3BCC
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Oct 2025 15:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3DE6188EAB7
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Oct 2025 13:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EF5339B41;
	Thu, 16 Oct 2025 13:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WxZjjjw6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99403339B2A
	for <linux-pwm@vger.kernel.org>; Thu, 16 Oct 2025 13:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760621900; cv=none; b=X9JBJEpFOmKRbFR/Nu2OqzNM+6bVoUkcFLTSMvLEXA1lDwcoyUydusKyYCKpXRlNhjTehh78r0+xwf5ETM3P84RbFOdXrgXIT5pWnc96VbE2+oL7AxuWZVn5zYMboxzss4XFqEHbpUWVuyDQqR5lu1ig2hvrgBEqDL6USx7R8lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760621900; c=relaxed/simple;
	bh=NvJA+OvvqqDPKJCmfst2MXsWRWksJWnIw69DgMYVtX8=;
	h=From:Date:Subject:MIME-Version:Message-Id:In-Reply-To:To:Cc:
	 Content-Type:References; b=VZ1v0Hn7SmKpm+ci+s9VRAZw77EcFZHXrrn8dn09K9D2Dhan98zk2Dv3xJYdTyJUQF4M3EOruCWycsJUXUp8EbvOpYF2Yb1VosHeivJ0B6I7QgqFANDauhI4BL9e6QPdQ7pFuL5xV2D4qSyjYMXcAZj9HVyA+aVgwVtn8asBV+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=WxZjjjw6; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20251016133817euoutp024aeb6b149d7860c4be968718ed22f06e~u-EmPfpv02421724217euoutp02C
	for <linux-pwm@vger.kernel.org>; Thu, 16 Oct 2025 13:38:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20251016133817euoutp024aeb6b149d7860c4be968718ed22f06e~u-EmPfpv02421724217euoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1760621897;
	bh=hzrq4YN2uxPOg/leJpiVtHnEWUk+dlsqQnLVVz66HuM=;
	h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
	b=WxZjjjw6sWUb4PnNgYlnHMrYxYhTnNbXCL6vcZIwAGnXqGqQxkisuEQavXsKTryzA
	 EBj5NsQ8Mueteh8zEKTCYC0UNFjdn0v6XkY6GONxbhCLt7COCdnV9rglhSQ7aktdEj
	 mDYB4vA6+SEMV/G7g9/Edm/A8y+Nl9dbObblKLbI=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20251016133816eucas1p1cf2b9498e4cedda601aaa73df353a03f~u-ElojZHD2477524775eucas1p1I;
	Thu, 16 Oct 2025 13:38:16 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20251016133814eusmtip2c78e6e9672676ae6818c90c58f0ec878~u-Ej1lwtn2342023420eusmtip2U;
	Thu, 16 Oct 2025 13:38:14 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Thu, 16 Oct 2025 15:38:01 +0200
Subject: [PATCH v16 1/7] pwm: Export `pwmchip_release` for external use
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-rust-next-pwm-working-fan-for-sending-v16-1-a5df2405d2bd@samsung.com>
In-Reply-To: <20251016-rust-next-pwm-working-fan-for-sending-v16-0-a5df2405d2bd@samsung.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,  Miguel Ojeda
	<ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,  Boqun Feng
	<boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,  Andreas
	Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,  Trevor
	Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,  Michal
	Wilczynski <m.wilczynski@samsung.com>, Guo Ren <guoren@kernel.org>,  Fu Wei
	<wefu@redhat.com>, Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski
	<krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,  Paul Walmsley
	<paul.walmsley@sifive.com>,  Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>,  Alexandre Ghiti <alex@ghiti.fr>,  Marek Szyprowski
	<m.szyprowski@samsung.com>,  Benno Lossin <lossin@kernel.org>,  Michael
	Turquette <mturquette@baylibre.com>,  Drew Fustini <fustini@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>,  Benno Lossin
	<lossin@kernel.org>, Drew Fustini <fustini@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, Elle Rhumsaa <elle@weathered-steel.dev>
X-Mailer: b4 0.15-dev
X-CMS-MailID: 20251016133816eucas1p1cf2b9498e4cedda601aaa73df353a03f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251016133816eucas1p1cf2b9498e4cedda601aaa73df353a03f
X-EPHeader: CA
X-CMS-RootMailID: 20251016133816eucas1p1cf2b9498e4cedda601aaa73df353a03f
References: <20251016-rust-next-pwm-working-fan-for-sending-v16-0-a5df2405d2bd@samsung.com>
	<CGME20251016133816eucas1p1cf2b9498e4cedda601aaa73df353a03f@eucas1p1.samsung.com>

The upcoming Rust abstraction layer for the PWM subsystem uses a custom
`dev->release` handler to safely manage the lifetime of its driver
data.

To prevent leaking the memory of the `struct pwm_chip` (allocated by
`pwmchip_alloc`), this custom handler must also call the original
`pwmchip_release` function to complete the cleanup.

Make `pwmchip_release` a global, exported function so that it can be
called from the Rust FFI bridge. This involves removing the `static`
keyword, adding a prototype to the public header, and exporting the
symbol.

Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>
Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 drivers/pwm/core.c  | 3 ++-
 include/linux/pwm.h | 6 ++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index ea2ccf42e81441d00a349f6d8641c92143d94797..47c9333baaf6c7d752a71c26bb1957ea2fd17a50 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -1608,12 +1608,13 @@ void pwmchip_put(struct pwm_chip *chip)
 }
 EXPORT_SYMBOL_GPL(pwmchip_put);
 
-static void pwmchip_release(struct device *pwmchip_dev)
+void pwmchip_release(struct device *pwmchip_dev)
 {
 	struct pwm_chip *chip = pwmchip_from_dev(pwmchip_dev);
 
 	kfree(chip);
 }
+EXPORT_SYMBOL_GPL(pwmchip_release);
 
 struct pwm_chip *pwmchip_alloc(struct device *parent, unsigned int npwm, size_t sizeof_priv)
 {
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 549ac4aaad59ba6d7ba58d818b46a58a8759e09c..148f056f336bbe17ffc3df22aa6b6bc3ad854e40 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -488,6 +488,12 @@ int __pwmchip_add(struct pwm_chip *chip, struct module *owner);
 #define pwmchip_add(chip) __pwmchip_add(chip, THIS_MODULE)
 void pwmchip_remove(struct pwm_chip *chip);
 
+/*
+ * For FFI wrapper use only:
+ * The Rust PWM abstraction needs this to properly free the pwm_chip.
+ */
+void pwmchip_release(struct device *dev);
+
 int __devm_pwmchip_add(struct device *dev, struct pwm_chip *chip, struct module *owner);
 #define devm_pwmchip_add(dev, chip) __devm_pwmchip_add(dev, chip, THIS_MODULE)
 

-- 
2.34.1


