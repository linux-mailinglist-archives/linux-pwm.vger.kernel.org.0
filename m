Return-Path: <linux-pwm+bounces-6819-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B15B00BB2
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Jul 2025 20:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAC644E7BCB
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Jul 2025 18:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6292FD599;
	Thu, 10 Jul 2025 18:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OpxLArPp"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976092264D7
	for <linux-pwm@vger.kernel.org>; Thu, 10 Jul 2025 18:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752173684; cv=none; b=L7KXltTXUfr/C7O+VOPAb3a0ufU+4sLdDivOh7ENcJ/yr/34pnuZ5WEWArO/0krLKUwCBoisG0vCPmrMxKuxliGtvIdpM+ndzsOxSqms4FK/m5uwmySYnhdManWsosZsBoTsGyxPp3z8NJw2hMT1Rx4yikXfRsVRU3LVTQay/qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752173684; c=relaxed/simple;
	bh=AGGmT24Nunew/PohljvJD1wQhaHaZ4zibDfYifRvxb8=;
	h=From:Date:Subject:MIME-Version:Message-Id:In-Reply-To:To:Cc:
	 Content-Type:References; b=prA8y5VyBsK46Iwr8AUYpYWZsVCpRF2p9n+HJqrcW+MKVzlDq0dkU1hyXa3boTX/6h6jBl4Fk7d3PJ0GgXQA3F5J6zZC6LoWyA2tsZ3gm/45ZaC9ZAxMccw132o0VH7Z5et+dN5OLJm4Kz+b/7b4bW9GMaLhBMHzA9upYe1f4G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=OpxLArPp; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250710185440euoutp01de9e5feb2fc5562f341d51a0addb4351~Q_K26eLSa1557715577euoutp01N
	for <linux-pwm@vger.kernel.org>; Thu, 10 Jul 2025 18:54:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250710185440euoutp01de9e5feb2fc5562f341d51a0addb4351~Q_K26eLSa1557715577euoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1752173680;
	bh=2kNfWch7LzrMRqHXiR7iyaKomd7SGOhEOBbXDTwnav0=;
	h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
	b=OpxLArPpyibRoBlq+IiiyF1zBAgD5mJMdZnErrv2tO0iT7ydJbGjjNOQ0ncVQCdZC
	 nB6QzugQCyf+fwRFBdMVhVATN17OOFko41AngPBK5YSHo0UsFR8HTOZOHw1UgQaJYu
	 e1yUpwEEMxGqpsgana7t6L6ZvLhQBO1lN/vaQsmE=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250710185439eucas1p2684255d83d807dfd6f8b9b3caea65df6~Q_K2N1woY3125331253eucas1p2c;
	Thu, 10 Jul 2025 18:54:39 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250710185438eusmtip1c9d1a6749dfe98fbcdeeec80da5206a3~Q_K1ELu9C1987919879eusmtip1c;
	Thu, 10 Jul 2025 18:54:38 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Thu, 10 Jul 2025 20:54:28 +0200
Subject: [PATCH v11 1/3] pwm: Export `pwmchip_release` for external use
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-rust-next-pwm-working-fan-for-sending-v11-1-93824a16f9ec@samsung.com>
In-Reply-To: <20250710-rust-next-pwm-working-fan-for-sending-v11-0-93824a16f9ec@samsung.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,  Miguel Ojeda
	<ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,  Boqun Feng
	<boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,  Andreas
	Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,  Trevor
	Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,  Michal
	Wilczynski <m.wilczynski@samsung.com>, Drew Fustini <drew@pdp7.com>,  Guo
	Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,  Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor Dooley
	<conor+dt@kernel.org>,  Paul Walmsley <paul.walmsley@sifive.com>,  Palmer
	Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,  Alexandre
	Ghiti <alex@ghiti.fr>,  Marek Szyprowski <m.szyprowski@samsung.com>,  Benno
	Lossin <lossin@kernel.org>,  Michael Turquette <mturquette@baylibre.com>, 
	Drew Fustini <fustini@kernel.org>, Benno Lossin <lossin@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org
X-Mailer: b4 0.15-dev
X-CMS-MailID: 20250710185439eucas1p2684255d83d807dfd6f8b9b3caea65df6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250710185439eucas1p2684255d83d807dfd6f8b9b3caea65df6
X-EPHeader: CA
X-CMS-RootMailID: 20250710185439eucas1p2684255d83d807dfd6f8b9b3caea65df6
References: <20250710-rust-next-pwm-working-fan-for-sending-v11-0-93824a16f9ec@samsung.com>
	<CGME20250710185439eucas1p2684255d83d807dfd6f8b9b3caea65df6@eucas1p2.samsung.com>

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
 drivers/pwm/core.c  | 3 ++-
 include/linux/pwm.h | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 0d66376a83ec350e0c3718959f4d794efd71595a..a33da3dff608fdff91251e5fd07b0dbd295be022 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -1600,12 +1600,13 @@ void pwmchip_put(struct pwm_chip *chip)
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


