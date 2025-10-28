Return-Path: <linux-pwm+bounces-7512-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C36E7C149DE
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Oct 2025 13:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7183E1AA5573
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Oct 2025 12:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2C032D421;
	Tue, 28 Oct 2025 12:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BnIeIH5j"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00BA32E6A7
	for <linux-pwm@vger.kernel.org>; Tue, 28 Oct 2025 12:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761654204; cv=none; b=oF45BNyCs2JTB5CvMdzuOk+S4hObktkrUZtD3T0I1lH5Bht9PqfmOFSmucFvr59xC5qHSbNLMZ4wjcz5ve57fgUq/y1zpYBKvw3iSYGbJH/GbGCtJ+YNsbta9CbB8MZQn1xU0vISmQ1+zY5Ley/QT3IdfxWyESnqFluINOxY3VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761654204; c=relaxed/simple;
	bh=yhgJHAx9fPc8H/lCyHycOlGU2mO1WZaQYsqIZeybbiw=;
	h=From:Date:Subject:MIME-Version:Message-Id:In-Reply-To:To:Cc:
	 Content-Type:References; b=XS0mhuK43XseJJD+hzNvzPIr4tGwjpNN/hxOZDWPdmbdHLmBuKQTf9D523iNtKhjJjzG2LtJlFlg5xuQ2NZ8slFeYT7yi8Yuindqncv1X1oYGu4tyNtLPtx5qjx2/9mWkCS+JQqM47xWmNmTxYsjtoc7wg3QGA9yYwBzYNCItHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=BnIeIH5j; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20251028122319euoutp010aaa107eaa0e52974cab01cf27bb1eaf~ypyk7l7kw0995109951euoutp01J
	for <linux-pwm@vger.kernel.org>; Tue, 28 Oct 2025 12:23:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20251028122319euoutp010aaa107eaa0e52974cab01cf27bb1eaf~ypyk7l7kw0995109951euoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1761654199;
	bh=Lm82DRGUZZTV1/beTKsFXySMTVqtnJxLBKgmXs1gVko=;
	h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
	b=BnIeIH5jEm0VOKgBrzpMbb1uakOkoeayhb74hp0j9RjEqIYQ9EVWNhalDlmIwitFP
	 jS/H83dsM39aXBHimHfxdD23J7JTzy4buroRirlXUeUAUlf6q/vqiqP1EPc/KOWpaR
	 NpGDcXgj3sSnsomxoIMhIeOy5C8FJPrNfZFHVpd0=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20251028122318eucas1p1863a8b44efe27c28a1bcf427d2855c00~ypykGd4I41056510565eucas1p1H;
	Tue, 28 Oct 2025 12:23:18 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20251028122318eusmtip2cb42586905d3b5fd524bea75b0831884~ypyjWQEit0671406714eusmtip20;
	Tue, 28 Oct 2025 12:23:18 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Tue, 28 Oct 2025 13:22:35 +0100
Subject: [PATCH 4/4] pwm: th1520: Fix clippy warning for redundant struct
 field init
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-pwm_fixes-v1-4-25a532d31998@samsung.com>
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
X-CMS-MailID: 20251028122318eucas1p1863a8b44efe27c28a1bcf427d2855c00
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251028122318eucas1p1863a8b44efe27c28a1bcf427d2855c00
X-EPHeader: CA
X-CMS-RootMailID: 20251028122318eucas1p1863a8b44efe27c28a1bcf427d2855c00
References: <20251028-pwm_fixes-v1-0-25a532d31998@samsung.com>
	<CGME20251028122318eucas1p1863a8b44efe27c28a1bcf427d2855c00@eucas1p1.samsung.com>

Clippy warns about redundant struct field initialization when the field
name and the variable name are the same (e.g., `status: status`).

No functional change.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 drivers/pwm/pwm_th1520.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
index 5fb123f5e9c6dc3a8ee9a7a47fa778c23213e957..95a809af48eb16fe13125d4d9f4ee5de20555e77 100644
--- a/drivers/pwm/pwm_th1520.rs
+++ b/drivers/pwm/pwm_th1520.rs
@@ -185,7 +185,7 @@ fn round_waveform_tohw(
         );
 
         Ok(pwm::RoundedWaveform {
-            status: status,
+            status,
             hardware_waveform: wfhw,
         })
     }

-- 
2.34.1


