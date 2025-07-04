Return-Path: <linux-pwm+bounces-6726-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D694EAF9221
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Jul 2025 14:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 471C77BD70B
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Jul 2025 12:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855712DCF43;
	Fri,  4 Jul 2025 12:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lhZksBrH"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34632D8DB1
	for <linux-pwm@vger.kernel.org>; Fri,  4 Jul 2025 12:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751630548; cv=none; b=VCPOeWbtFbHShNFi82ZV5oWHrgFfQ9eI4jlp4mXWaUmfTKoP2txV80X4XZPpyoJrsybGU0K5CpdVMdhjaWzvv1K6n+s+wQrbs1Nmq3Zd03Jo2WxMhROyT8V7TiGAV7npD7Dt2XOhWJZQuuJHuu2i6HuWOJd8HRZTHMfvwUymhqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751630548; c=relaxed/simple;
	bh=8oTAUzxmjJYIKw5Joa+cRWJz7tviXwysA9SB/6sHSyo=;
	h=From:Date:Subject:MIME-Version:Message-Id:In-Reply-To:To:Cc:
	 Content-Type:References; b=egS46l64pgzUxZKSknJ6c1ak5JD07jpBi1HhH8uwhHihKNn8/KgX/941IxWaEyKMT9CEws6qgA/Zh+vahT6JYVDDNOhFVVmo1CJ8bw6UB8XJdxjWs5XUSfdekfkprHAAbjFKNQbk+xKNz0v1/364jtgcFGYFRdddhhOD8yCgPDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=lhZksBrH; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250704120219euoutp01e1c3574adc77277c1b3e09bd26e170b7~PCrHbvjOa2448024480euoutp01P
	for <linux-pwm@vger.kernel.org>; Fri,  4 Jul 2025 12:02:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250704120219euoutp01e1c3574adc77277c1b3e09bd26e170b7~PCrHbvjOa2448024480euoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1751630539;
	bh=i2ffb5TRdqcFNdp9wQmKYm6oC/yh6BrYkPG8pSNij+4=;
	h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
	b=lhZksBrHIyia7CGgzSxl4tNDYl95wtGLV0dH6HJz3cYCdYG2KCagVaAjS1cjlXXJe
	 988D2/ZoJtpiMUfpc91F/jx1oF97NQsA/dgU6TgVPyDQaYs8KVGgaIBZLPhYoXBdBR
	 zxv2uwIUenCZCzlCB2jgzq5G3pg+Ulul+991ZJGQ=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250704120218eucas1p10edf3e2049824904f36c01272f1e0a51~PCrG72SNg3265532655eucas1p1f;
	Fri,  4 Jul 2025 12:02:18 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250704120217eusmtip1e5b2d5868a9fc5e64c772592a0d861b2~PCrFfr_hN2950229502eusmtip1Z;
	Fri,  4 Jul 2025 12:02:16 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Fri, 04 Jul 2025 14:01:16 +0200
Subject: [PATCH v8 6/7] riscv: dts: thead: Add PWM controller node
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20250704-rust-next-pwm-working-fan-for-sending-v8-6-951e5482c9fd@samsung.com>
In-Reply-To: <20250704-rust-next-pwm-working-fan-for-sending-v8-0-951e5482c9fd@samsung.com>
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
X-CMS-MailID: 20250704120218eucas1p10edf3e2049824904f36c01272f1e0a51
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250704120218eucas1p10edf3e2049824904f36c01272f1e0a51
X-EPHeader: CA
X-CMS-RootMailID: 20250704120218eucas1p10edf3e2049824904f36c01272f1e0a51
References: <20250704-rust-next-pwm-working-fan-for-sending-v8-0-951e5482c9fd@samsung.com>
	<CGME20250704120218eucas1p10edf3e2049824904f36c01272f1e0a51@eucas1p1.samsung.com>

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


