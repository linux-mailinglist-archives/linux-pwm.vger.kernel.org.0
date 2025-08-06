Return-Path: <linux-pwm+bounces-6969-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E802B1C184
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Aug 2025 09:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A31DC18C0D2C
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Aug 2025 07:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E0D22577E;
	Wed,  6 Aug 2025 07:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pONKi1y0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D4F22422D
	for <linux-pwm@vger.kernel.org>; Wed,  6 Aug 2025 07:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754466186; cv=none; b=CRIFLKrEdNMmnaCSiVLhpjeYzqWC3fPTTxNsLg6EzqyDjOc0bT4V7nJFsmEXk1CSQjp89s0cohN8d81tZznVapv/4YsvtnCLQILrajPWU36aDZCzNAWjtNyrsHEveOxrdofrYC07V6Q0S6jLqGXkGa8+92PQXjgYnpkA81AMK7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754466186; c=relaxed/simple;
	bh=8oTAUzxmjJYIKw5Joa+cRWJz7tviXwysA9SB/6sHSyo=;
	h=From:Date:Subject:MIME-Version:Message-Id:In-Reply-To:To:Cc:
	 Content-Type:References; b=XPLOTJefreVBWtStEiouJGCMC9PDI+r8Krtyv0eXiY9Lac9W3vuD2+CbmXg2M59PFiHAkuAKA91F/DJuCMmQdCS9AAOlxiqRy5HKdXiCSz6PHiSBFZRA9ro1rFRx29AHxycWMc2qBPkAzrB6zlS4FXCAb2CPvnM/iaRPLW6ydXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=pONKi1y0; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250806074300euoutp01b883dbf1d98ddb3ca5ca44161b805e8b~ZHbIYZBza2813028130euoutp01Y
	for <linux-pwm@vger.kernel.org>; Wed,  6 Aug 2025 07:43:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250806074300euoutp01b883dbf1d98ddb3ca5ca44161b805e8b~ZHbIYZBza2813028130euoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1754466180;
	bh=i2ffb5TRdqcFNdp9wQmKYm6oC/yh6BrYkPG8pSNij+4=;
	h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
	b=pONKi1y0q2d5P8Ijpjqvpp5a16L5zMXfxwzq8WaFgEko66tXBFHMSwuoxQO6cx98m
	 YXaeq1GhleerbuRIXcQvpq+0jdaiLPtuFrpEBCOdTugcYgsxuNZchMlFWhuda2MoCB
	 TocJNDzSRZl9MqkCm9BcoBZm1KoFjIjLocug9cAM=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250806074300eucas1p13e8773275da587232ef72dcb1f7706a3~ZHbH2BBTr0085500855eucas1p1o;
	Wed,  6 Aug 2025 07:43:00 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250806074258eusmtip2bd98effedb80b6f7c0cb0acd9a7fcd7a~ZHbGx7nZN1336513365eusmtip2E;
	Wed,  6 Aug 2025 07:42:58 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Wed, 06 Aug 2025 09:42:51 +0200
Subject: [PATCH v13 6/7] riscv: dts: thead: Add PWM controller node
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20250806-rust-next-pwm-working-fan-for-sending-v13-6-690b669295b6@samsung.com>
In-Reply-To: <20250806-rust-next-pwm-working-fan-for-sending-v13-0-690b669295b6@samsung.com>
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
X-CMS-MailID: 20250806074300eucas1p13e8773275da587232ef72dcb1f7706a3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250806074300eucas1p13e8773275da587232ef72dcb1f7706a3
X-EPHeader: CA
X-CMS-RootMailID: 20250806074300eucas1p13e8773275da587232ef72dcb1f7706a3
References: <20250806-rust-next-pwm-working-fan-for-sending-v13-0-690b669295b6@samsung.com>
	<CGME20250806074300eucas1p13e8773275da587232ef72dcb1f7706a3@eucas1p1.samsung.com>

Add the Device Tree node for the T-HEAD TH1520 SoC's PWM controller.

Reviewed-by: Drew Fustini <fustini@kernel.org>
Tested-by: Drew Fustini <fustini@kernel.org>
Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 arch/riscv/boot/dts/thead/th1520.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index 42724bf7e90e08fac326c464d0f080e3bd2cd59b..513dc6977b2633503515ad260913156fbe57d92f 100644
--- a/arch/riscv/boot/dts/thead/th1520.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520.dtsi
@@ -493,6 +493,13 @@ uart2: serial@ffec010000 {
 			status = "disabled";
 		};
 
+		pwm: pwm@ffec01c000 {
+			compatible = "thead,th1520-pwm";
+			reg = <0xff 0xec01c000 0x0 0x4000>;
+			clocks = <&clk CLK_PWM>;
+			#pwm-cells = <3>;
+		};
+
 		clk: clock-controller@ffef010000 {
 			compatible = "thead,th1520-clk-ap";
 			reg = <0xff 0xef010000 0x0 0x1000>;

-- 
2.34.1


