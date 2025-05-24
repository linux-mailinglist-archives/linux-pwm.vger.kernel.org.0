Return-Path: <linux-pwm+bounces-6117-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EE7AC317C
	for <lists+linux-pwm@lfdr.de>; Sat, 24 May 2025 23:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B37F17B9D9
	for <lists+linux-pwm@lfdr.de>; Sat, 24 May 2025 21:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE9327F178;
	Sat, 24 May 2025 21:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="q1MW/LEl"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5E727F74B
	for <linux-pwm@vger.kernel.org>; Sat, 24 May 2025 21:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748121336; cv=none; b=H1zZc55vLWP2/qq0bE/FBfZK1wB+MUWGSOHzEy3XujPjCNPgdTViaRxefLsKPodMpsa5a7ACVAIwZDnxmeX2ICnWGTk08rJ87jjBQw0FY3yTD2GY6auQnM/bkVuEJVRQJNmqZUnU84keqIou7YBxfj2g4dWfBDiHttIroSi8rPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748121336; c=relaxed/simple;
	bh=f+Zvxh7RpZVeeAMm7ojE6sv3IpEluoCdeLo2/ixV3/o=;
	h=From:Date:Subject:MIME-Version:Message-Id:In-Reply-To:To:Cc:
	 Content-Type:References; b=SAKyiyd4ezZ9VltXjgxLcQcd017mWr3PbgGawPWUgznKyVhawVAP3Dt6+nsnfhsGlO3xOR3n6oKDjlwH7D7JgJkqnsrI4FHvFzfOjBdIEwbsE3XEJ05jPx2IE7vQLNqtxeXxAsUEfapaDH7asstOpLDrZad2qqwGxMsyCA9HKQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=q1MW/LEl; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250524211525euoutp010b52c54903f32ed615d609661cf4bbb3~CkxVteMei2399223992euoutp01l
	for <linux-pwm@vger.kernel.org>; Sat, 24 May 2025 21:15:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250524211525euoutp010b52c54903f32ed615d609661cf4bbb3~CkxVteMei2399223992euoutp01l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1748121325;
	bh=2NOPyMWTWiFmeUoJJtW57RkmSgf3zZf1wFf9qv0a94I=;
	h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
	b=q1MW/LElhRmQeLtjGtbKEgXxrXQ9cqR5o72ZBRLnZ0aV9e5yDaQd9B3PIKbYMjKfA
	 I24PyLQhNE9eq6ScylTZoS4v1+o5o/BAlQXFZAqLIRet6BjtxGCWUcArs7rDjZ+oFe
	 3uzeS70dYogYU37DKjUULCqflLeJos7r/Jt2KARE=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250524211524eucas1p27d56c24a9950a79086f8f4c7d5fa003f~CkxUTZEN02408724087eucas1p2q;
	Sat, 24 May 2025 21:15:24 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250524211522eusmtip2e428d2ec6420649127fc6ba7ffbeb63b~CkxTRe5te0676606766eusmtip2p;
	Sat, 24 May 2025 21:15:22 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Sat, 24 May 2025 23:14:58 +0200
Subject: [PATCH RFC 4/6] riscv: dts: thead: Add PWM controller node
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20250524-rust-next-pwm-working-fan-for-sending-v1-4-bdd2d5094ff7@samsung.com>
In-Reply-To: <20250524-rust-next-pwm-working-fan-for-sending-v1-0-bdd2d5094ff7@samsung.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,  Miguel Ojeda
	<ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,  Boqun Feng
	<boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,  Benno Lossin
	<benno.lossin@proton.me>,  Andreas Hindborg <a.hindborg@kernel.org>, Alice
	Ryhl <aliceryhl@google.com>,  Trevor Gross <tmgross@umich.edu>, Danilo
	Krummrich <dakr@kernel.org>,  Michal Wilczynski <m.wilczynski@samsung.com>,
	Drew Fustini <drew@pdp7.com>,  Guo Ren <guoren@kernel.org>, Fu Wei
	<wefu@redhat.com>,  Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,  Paul Walmsley
	<paul.walmsley@sifive.com>,  Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>,  Alexandre Ghiti <alex@ghiti.fr>,  Marek Szyprowski
	<m.szyprowski@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org
X-Mailer: b4 0.15-dev
X-CMS-MailID: 20250524211524eucas1p27d56c24a9950a79086f8f4c7d5fa003f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250524211524eucas1p27d56c24a9950a79086f8f4c7d5fa003f
X-EPHeader: CA
X-CMS-RootMailID: 20250524211524eucas1p27d56c24a9950a79086f8f4c7d5fa003f
References: <20250524-rust-next-pwm-working-fan-for-sending-v1-0-bdd2d5094ff7@samsung.com>
	<CGME20250524211524eucas1p27d56c24a9950a79086f8f4c7d5fa003f@eucas1p2.samsung.com>

Add the Device Tree node for the T-HEAD TH1520 SoC's PWM controller.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 arch/riscv/boot/dts/thead/th1520.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index 527336417765d8470426f2985e1bc22eeafb31aa..f24e12d7259fabcfbdc2dfa966d759db06684ab4 100644
--- a/arch/riscv/boot/dts/thead/th1520.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520.dtsi
@@ -482,6 +482,13 @@ uart2: serial@ffec010000 {
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


