Return-Path: <linux-pwm+bounces-6432-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4D3ADEC9C
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Jun 2025 14:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BADAF189382A
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Jun 2025 12:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE652E54A3;
	Wed, 18 Jun 2025 12:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="R2riRSf6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198432E9EAF
	for <linux-pwm@vger.kernel.org>; Wed, 18 Jun 2025 12:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750249707; cv=none; b=giw+toYrEB3AtzdpPtiTh0BYNF9Xu65E4qgnxSvwaOhzgNEVACo2ltZlM+CoembLGENRL2cXPMBu6mPlqyBEE4KiFm64f//iHpAVx7sDprltqpzrCK1hLOlxvPD43qLfNXpji9eUx4/uXdCx7UrPpEu5onS9WP/7hkepTv9d0/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750249707; c=relaxed/simple;
	bh=pQpdhYmfxqh3Yfxmei5sPv11PaCzGkgZVRufLVaDNj8=;
	h=From:Date:Subject:MIME-Version:Message-Id:In-Reply-To:To:Cc:
	 Content-Type:References; b=HYCJLkHqC9gjdTSnaoY4iF6oLFYT2l6Q3H3NtXmY+t4rTZ6w/Z0zDxFsSRODCV7qeiBX8n0eolcud+xjd9aopE1ocX+Za+YhGmFlw4tiyNLAwi38tOqMgfMei2VZ2fYJvkItEvh9/ytLQEPpcATaodmcLQtO242b3loKajeJ0Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=R2riRSf6; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250618122814euoutp01c75e6698e8768aeef1251b144418f202~KItLVJI9S3084930849euoutp01S
	for <linux-pwm@vger.kernel.org>; Wed, 18 Jun 2025 12:28:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250618122814euoutp01c75e6698e8768aeef1251b144418f202~KItLVJI9S3084930849euoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1750249694;
	bh=Thc/4MnT4r5I8ag38cbivyQhpbuX345C1nEB0lzCSSU=;
	h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
	b=R2riRSf6p9yZyCjifLQI9mMAEOD4ZIqOji2fTItbvsSgxHLr9I8mwCkBbZ9LYYrUm
	 Za2lbBL9zDed2K8nxtYCyBITkCz4+COCd4WNW0XzPziUaPePsOpMePxBxXyhgw/orN
	 aVFdECsegyRTfSKTcMmSbsWDXFk7YlfuSEHylFkk=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250618122813eucas1p287bd4915937a1fa5d93343cd0665854c~KItK0t3i22282022820eucas1p2T;
	Wed, 18 Jun 2025 12:28:13 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250618122812eusmtip1af5b2366f46c13b22711fc88b192c9e4~KItJm6nkV2578325783eusmtip1Z;
	Wed, 18 Jun 2025 12:28:12 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Wed, 18 Jun 2025 14:27:42 +0200
Subject: [PATCH v4 9/9] riscv: dts: thead: Add PWM fan and thermal control
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-rust-next-pwm-working-fan-for-sending-v4-9-a6a28f2b6d8a@samsung.com>
In-Reply-To: <20250618-rust-next-pwm-working-fan-for-sending-v4-0-a6a28f2b6d8a@samsung.com>
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
	Stephen Boyd <sboyd@kernel.org>, Benno Lossin <lossin@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org
X-Mailer: b4 0.15-dev
X-CMS-MailID: 20250618122813eucas1p287bd4915937a1fa5d93343cd0665854c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250618122813eucas1p287bd4915937a1fa5d93343cd0665854c
X-EPHeader: CA
X-CMS-RootMailID: 20250618122813eucas1p287bd4915937a1fa5d93343cd0665854c
References: <20250618-rust-next-pwm-working-fan-for-sending-v4-0-a6a28f2b6d8a@samsung.com>
	<CGME20250618122813eucas1p287bd4915937a1fa5d93343cd0665854c@eucas1p2.samsung.com>

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


