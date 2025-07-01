Return-Path: <linux-pwm+bounces-6670-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A16F5AEFEFF
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 18:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B50021882A2D
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 16:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8EA27BF95;
	Tue,  1 Jul 2025 16:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="E4CZAKog"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271AC27FB01
	for <linux-pwm@vger.kernel.org>; Tue,  1 Jul 2025 16:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751385734; cv=none; b=Qqr02SyipM3WtXJLsdofSzHa7vD5XLYjjn1/tvIzuxSE02mkK2+Rjx/NcSEwkMfKBrFta5rKri3Y8BGrQ3ku/wn3VU1ga+fQs0Ls15JRpybm5U4Jq+TJBmYSLEThEWouNEDMqeVhnVm0W+Ykboj2EaD1EfNYNTfVT6VrFhlniKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751385734; c=relaxed/simple;
	bh=pQpdhYmfxqh3Yfxmei5sPv11PaCzGkgZVRufLVaDNj8=;
	h=From:Date:Subject:MIME-Version:Message-Id:In-Reply-To:To:Cc:
	 Content-Type:References; b=MtTbyWQZPdV83LTVa76zzfKW4xnmwdxQbnoeN+8AXmRAQre4SX1z9ZpnGEv+7cW9RENskM9s9w3OMzcHyl/MVvPMN5Xv3jLeeL/HXqHpnnxiA2Zp53kBt+Hmy+uqo24eu/OJVqehFNhvdfsiacRV6kCoVf9kQn7w+XXHc/VzJyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=E4CZAKog; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250701160208euoutp01df9d95ebb0b0ea97a0f19a40f2f6c7a8~OLAp-iznA1111611116euoutp01J
	for <linux-pwm@vger.kernel.org>; Tue,  1 Jul 2025 16:02:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250701160208euoutp01df9d95ebb0b0ea97a0f19a40f2f6c7a8~OLAp-iznA1111611116euoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1751385728;
	bh=Thc/4MnT4r5I8ag38cbivyQhpbuX345C1nEB0lzCSSU=;
	h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
	b=E4CZAKogyAvZo+4zp4YdTXwhS6UT3701qpYlrBkDWHg7t+enBnejRciSq8V2WvOqI
	 LVIWNffSp+f6RsG7Ydj0ZxFSY+cmVPUMR1Tq3K6JdNYBk3FeRzWPdkV6CmUgru2TCu
	 XQ6KQyxk8FijjwV7q4bJZV2EGWx6kRDPr5xIw+XM=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250701160208eucas1p2633ce5cd0b9ef013999b3d596be74cdd~OLApiaZG32521625216eucas1p2G;
	Tue,  1 Jul 2025 16:02:08 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250701160206eusmtip192999017bfbc2de977e7580df56a36a7~OLAoZ52AM3260032600eusmtip1D;
	Tue,  1 Jul 2025 16:02:06 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Tue, 01 Jul 2025 18:01:45 +0200
Subject: [PATCH v6 8/8] riscv: dts: thead: Add PWM fan and thermal control
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20250701-rust-next-pwm-working-fan-for-sending-v6-8-2710932f6f6b@samsung.com>
In-Reply-To: <20250701-rust-next-pwm-working-fan-for-sending-v6-0-2710932f6f6b@samsung.com>
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
	Turquette <mturquette@baylibre.com>,  Stephen Boyd <sboyd@kernel.org>, Benno
	Lossin <lossin@kernel.org>,  Drew Fustini <fustini@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org
X-Mailer: b4 0.15-dev
X-CMS-MailID: 20250701160208eucas1p2633ce5cd0b9ef013999b3d596be74cdd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250701160208eucas1p2633ce5cd0b9ef013999b3d596be74cdd
X-EPHeader: CA
X-CMS-RootMailID: 20250701160208eucas1p2633ce5cd0b9ef013999b3d596be74cdd
References: <20250701-rust-next-pwm-working-fan-for-sending-v6-0-2710932f6f6b@samsung.com>
	<CGME20250701160208eucas1p2633ce5cd0b9ef013999b3d596be74cdd@eucas1p2.samsung.com>

Add Device Tree nodes to enable a PWM controlled fan and it's associated
thermal management for the Lichee Pi 4A board.

This enables temperature-controlled active cooling for the Lichee Pi 4A
board based on SoC temperature.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts | 67 +++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts b/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
index 4020c727f09e8e2286fdc7fecd79dbd8eba69556..c58c2085ca92a3234f1350500cedae4157f0c35f 100644
--- a/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
+++ b/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
@@ -28,9 +28,76 @@ aliases {
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	thermal-zones {
+		cpu-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <1000>;
+			thermal-sensors = <&pvt 0>;
+
+			trips {
+				fan_config0: fan-trip0 {
+					temperature = <39000>;
+					hysteresis = <5000>;
+					type = "active";
+				};
+
+				fan_config1: fan-trip1 {
+					temperature = <50000>;
+					hysteresis = <5000>;
+					type = "active";
+				};
+
+				fan_config2: fan-trip2 {
+					temperature = <60000>;
+					hysteresis = <5000>;
+					type = "active";
+				};
+			};
+
+			cooling-maps {
+				map-active-0 {
+					cooling-device = <&fan 1 1>;
+					trip = <&fan_config0>;
+				};
+
+				map-active-1 {
+					cooling-device = <&fan 2 2>;
+					trip = <&fan_config1>;
+				};
+
+				map-active-2 {
+					cooling-device = <&fan 3 3>;
+					trip = <&fan_config2>;
+				};
+			};
+		};
+	};
+
+	fan: pwm-fan {
+		pinctrl-names = "default";
+		pinctrl-0 = <&fan_pins>;
+		compatible = "pwm-fan";
+		#cooling-cells = <2>;
+		pwms = <&pwm 1 10000000 0>;
+		cooling-levels = <0 66 196 255>;
+	};
+
 };
 
 &padctrl0_apsys {
+	fan_pins: fan-0 {
+		pwm1-pins {
+			pins = "GPIO3_3"; /* PWM1 */
+			function = "pwm";
+			bias-disable;
+			drive-strength = <25>;
+			input-disable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+	};
+
 	uart0_pins: uart0-0 {
 		tx-pins {
 			pins = "UART0_TXD";

-- 
2.34.1


