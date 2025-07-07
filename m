Return-Path: <linux-pwm+bounces-6756-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D0BAFB03C
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Jul 2025 11:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 443D21898D6C
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Jul 2025 09:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83082951BD;
	Mon,  7 Jul 2025 09:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="C2/hVxWs"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8CF293C6C
	for <linux-pwm@vger.kernel.org>; Mon,  7 Jul 2025 09:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751881777; cv=none; b=FQ9FdFM+EtISCm6CuCFs0xERA93RpgEBeTTxyo5EQdVlMU32gtnDFPJABzjlWdvY9ec/bK1YV6azHOLIR7PorAzIbl6LxmQSJ7A6hA3p7oaOP/aJ5+S4f7ZFdin9rPJ0gSIvaVNHDpDjElBOfCxF1goe0vt0jOykqVGdamCm5so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751881777; c=relaxed/simple;
	bh=X2KTQj3sYrBODlaBUh5907GvBSYo7zkOz4ctatRTbww=;
	h=From:Date:Subject:MIME-Version:Message-Id:In-Reply-To:To:Cc:
	 Content-Type:References; b=higDO5wlrjbQs3UNhO4m3FjlHigY+OCSP3SW8KhNBoU6dsJL0cVMOuFZ3n+G9hFpxKd3FU1SnaMazPrGaAaGS/Q3AtkuNmjQMs7+6Xl9g9jHYsQFrvsPIzxHL/zFWlBB2ksQPKHZvClpOhiUcRcmuZfyVNeWaC+OVOohmYVHDT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=C2/hVxWs; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250707094928euoutp0106b3a02c77c7bd3856dab4cab15a8dc8~P7y-BvHc-2468924689euoutp01G
	for <linux-pwm@vger.kernel.org>; Mon,  7 Jul 2025 09:49:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250707094928euoutp0106b3a02c77c7bd3856dab4cab15a8dc8~P7y-BvHc-2468924689euoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1751881768;
	bh=v184H/+hjF+g7LMn8OCQL3GzK+GQt5a9rJlf+wIu6Rs=;
	h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
	b=C2/hVxWstxbxgta80C5Ph98Wnyw6+Oxm+ufwF584REQNd5gtjD1vleKcGwgiKTSeu
	 8BpIUMKmFDtBRIshTnTFGWm9Qk/oA0ud8HewRF5X5nJr37k0XlYmvJz/e8ITw9v33k
	 tlI8ObBlv7E7B6lTBTYN6PK0+QawZVbdx5yIyWt0=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250707094927eucas1p2be0302112d89f0ea39e4eeb21c771234~P7y_UFxDO1730317303eucas1p2t;
	Mon,  7 Jul 2025 09:49:27 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250707094926eusmtip1f0ccbebd2086190de86602af194461dc~P7y9MVE5l0369203692eusmtip1X;
	Mon,  7 Jul 2025 09:49:26 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Mon, 07 Jul 2025 11:48:29 +0200
Subject: [PATCH v10 1/7] pwm: Export `pwmchip_release` for external use
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20250707-rust-next-pwm-working-fan-for-sending-v10-1-d0c5cf342004@samsung.com>
In-Reply-To: <20250707-rust-next-pwm-working-fan-for-sending-v10-0-d0c5cf342004@samsung.com>
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
	Benno Lossin <lossin@kernel.org>,  Drew Fustini <fustini@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org
X-Mailer: b4 0.15-dev
X-CMS-MailID: 20250707094927eucas1p2be0302112d89f0ea39e4eeb21c771234
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250707094927eucas1p2be0302112d89f0ea39e4eeb21c771234
X-EPHeader: CA
X-CMS-RootMailID: 20250707094927eucas1p2be0302112d89f0ea39e4eeb21c771234
References: <20250707-rust-next-pwm-working-fan-for-sending-v10-0-d0c5cf342004@samsung.com>
	<CGME20250707094927eucas1p2be0302112d89f0ea39e4eeb21c771234@eucas1p2.samsung.com>

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

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 drivers/pwm/core.c  | 2 +-
 include/linux/pwm.h | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index c1e8ab1a0945889d92dada003060b8b109f2a138..1d33438cd2cf0b5ca53dd22786ed5b5a9f5def8d 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -1600,7 +1600,7 @@ void pwmchip_put(struct pwm_chip *chip)
 }
 EXPORT_SYMBOL_GPL(pwmchip_put);
 
-static void pwmchip_release(struct device *pwmchip_dev)
+void pwmchip_release(struct device *pwmchip_dev)
 {
 	struct pwm_chip *chip = pwmchip_from_dev(pwmchip_dev);
 
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 8cafc483db53addf95591d1ac74287532c0fa0ee..8f0698c09e62b893d63fc258da3c34781183056f 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -478,6 +478,7 @@ static inline bool pwm_might_sleep(struct pwm_device *pwm)
 
 /* PWM provider APIs */
 void pwmchip_put(struct pwm_chip *chip);
+void pwmchip_release(struct device *dev);
 struct pwm_chip *pwmchip_alloc(struct device *parent, unsigned int npwm, size_t sizeof_priv);
 struct pwm_chip *devm_pwmchip_alloc(struct device *parent, unsigned int npwm, size_t sizeof_priv);
 
@@ -551,6 +552,10 @@ static inline void pwmchip_put(struct pwm_chip *chip)
 {
 }
 
+static inline void pwmchip_release(struct device *dev)
+{
+}
+
 static inline struct pwm_chip *pwmchip_alloc(struct device *parent,
 					     unsigned int npwm,
 					     size_t sizeof_priv)

-- 
2.34.1


