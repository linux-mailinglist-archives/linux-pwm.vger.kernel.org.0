Return-Path: <linux-pwm+bounces-7360-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FD1BACD42
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Sep 2025 14:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E9911888BEB
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Sep 2025 12:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCF22FBE03;
	Tue, 30 Sep 2025 12:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rRkb2Vrm"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCACE2FAC0A
	for <linux-pwm@vger.kernel.org>; Tue, 30 Sep 2025 12:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759235261; cv=none; b=puIoZWvXSk12I0jB/YGApfZWpJumZWkqiEyVJUykCRVjECL8qCPtFK/rKcrbXgQZqDsyJ+wmA3k9f7WSs0gOTEVh5ndlU3TLKgBFCfdbfEMq2nj+2Hsq+SNtddboLLtq4oBF1Jz+knWWSbeSS8d+FKMKnA1lt0nF6YQ/pRAeFtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759235261; c=relaxed/simple;
	bh=gcsLL+OYdYVlUpralYTdFw0jI8A+oCehXo1j38hYJLY=;
	h=From:Date:Subject:MIME-Version:Message-Id:In-Reply-To:To:Cc:
	 Content-Type:References; b=Ab071Hcbx7gFWXyFn/vaQf6Pl6eY/DscnQfeAGtu7GI6n6X+eRsllpLVESV1gf5SfBASUgTY2a5KyHl1BDkVqJrb+nd+q5/3WjWIRxX8+Tn/WHq7ptou2JlZP9s6m6DWHOpGGf0D9YxMlgu/Gy2fam7WyYA9s6qXkMldD2XaCxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=rRkb2Vrm; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250930122738euoutp0285b3baa5b8c0edcd335373cdc963c40f~qDyV65dlq2357023570euoutp02L
	for <linux-pwm@vger.kernel.org>; Tue, 30 Sep 2025 12:27:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250930122738euoutp0285b3baa5b8c0edcd335373cdc963c40f~qDyV65dlq2357023570euoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1759235258;
	bh=GGb78YSEZMSjoaa+oC6oCUglv6Dc1sWOZiypzXGHKbw=;
	h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
	b=rRkb2Vrmk2kkzh8vw1qA/Cyhw3KUWKIxeUw5axeodZ+c5CQryVxBOk18BSwD5D5dZ
	 XlU7SAs0TFhujsAErliP8WxnR2SlcYmdklnbeqxVdy7gDzPzGVOIe1wfSOsTqd3JcV
	 t4WBj/9dZfgRrCGCjb/Oe9doWBJn16wl+jyMCy6M=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250930122737eucas1p1b3b1afe746a30463c9bdd159ef801543~qDyVD1vjA2573025730eucas1p1s;
	Tue, 30 Sep 2025 12:27:37 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250930122736eusmtip2699b60bfd1c7abd20bc6c44973a47378~qDyT_rWbk1846318463eusmtip2a;
	Tue, 30 Sep 2025 12:27:35 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Tue, 30 Sep 2025 14:20:37 +0200
Subject: [PATCH v15 6/7] riscv: dts: thead: Add PWM controller node
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-rust-next-pwm-working-fan-for-sending-v15-6-5661c3090877@samsung.com>
In-Reply-To: <20250930-rust-next-pwm-working-fan-for-sending-v15-0-5661c3090877@samsung.com>
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
X-CMS-MailID: 20250930122737eucas1p1b3b1afe746a30463c9bdd159ef801543
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250930122737eucas1p1b3b1afe746a30463c9bdd159ef801543
X-EPHeader: CA
X-CMS-RootMailID: 20250930122737eucas1p1b3b1afe746a30463c9bdd159ef801543
References: <20250930-rust-next-pwm-working-fan-for-sending-v15-0-5661c3090877@samsung.com>
	<CGME20250930122737eucas1p1b3b1afe746a30463c9bdd159ef801543@eucas1p1.samsung.com>

Add the Device Tree node for the T-HEAD TH1520 SoC's PWM controller.

Reviewed-by: Drew Fustini <fustini@kernel.org>
Tested-by: Drew Fustini <fustini@kernel.org>
Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>
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


