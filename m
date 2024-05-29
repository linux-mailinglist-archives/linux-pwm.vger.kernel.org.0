Return-Path: <linux-pwm+bounces-2284-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 642D88D33E8
	for <lists+linux-pwm@lfdr.de>; Wed, 29 May 2024 12:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1444A1F22523
	for <lists+linux-pwm@lfdr.de>; Wed, 29 May 2024 10:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BD017B4F2;
	Wed, 29 May 2024 10:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sv3Jkq8O"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499FB17B43A;
	Wed, 29 May 2024 10:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716976878; cv=none; b=OqarpbaoQYArpYBerCVe395kpyBAcVL/lDXY39sDmvFzOu+AqjM12h6laWAkyV0Nv/lLfuwoFzhRN0GIKm+M+7U47LWdNiBJ+v69vG7B2c5qgfCwW0QiXnEDwM5Io+3zBBWHZWuf+xgwHVYpCfUUfcmnOtK+/8ERCosEGvz+A8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716976878; c=relaxed/simple;
	bh=DbSfj2AuXO8/xPseQuTpefTqS6ELr7H0u4EGEdY+1/0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZHPITukGfUVrUG641S+eUEm/51gc6X4xcdsEcQrtzR5udmc3VWZKvjd5d8nS5rD6UV/jb3JOdecWNL0V4tfXpdSJY2e4lU5hQlFXb6CPFHSW4x/LOexjMv0eMl8q2tWu1w8afnrs86L0E+4ZtGP5sxBlpvHBlVZQaOEtdHyUfDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sv3Jkq8O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C42C7C32789;
	Wed, 29 May 2024 10:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716976877;
	bh=DbSfj2AuXO8/xPseQuTpefTqS6ELr7H0u4EGEdY+1/0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=sv3Jkq8O00gyXz9uLFyWjk/Ffg/b41NgyiWZFrXywChhNFGqqqkYN8oBCagBMUcDZ
	 yjCpFIk5C9hqlHxQTwAdRRnoktZsuWx1GgzRiQ8yEC7LYeNO9viim7s3z7fJGvntFf
	 4OqfDM+tB+PUGaWkLpR1pKFQNAMJiZ+A+Jp8bduKhYbcRnxwNgkHhlz46viRqq3l9w
	 poKDgytGvIT9ngCOqLc8EAmZs+zVXw4YTlvNZvCY30CK6BadcjTA3ZD0SnFLdIPF/a
	 OhLW5virLbLvot/GynXj8YH+fSFXL4bpU7K8lCgy3/UGsWx8EhMTArgMjv13A/beie
	 +UcZe5Yq2+Atw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B071AC25B75;
	Wed, 29 May 2024 10:01:17 +0000 (UTC)
From: Kelvin Zhang via B4 Relay <devnull+kelvin.zhang.amlogic.com@kernel.org>
Date: Wed, 29 May 2024 18:00:57 +0800
Subject: [PATCH v6 2/2] arm64: dts: amlogic: Add Amlogic S4 PWM
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-s4-pwm-v6-2-270f63049f20@amlogic.com>
References: <20240529-s4-pwm-v6-0-270f63049f20@amlogic.com>
In-Reply-To: <20240529-s4-pwm-v6-0-270f63049f20@amlogic.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Kelvin Zhang <kelvin.zhang@amlogic.com>, 
 Junyi Zhao <junyi.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716976876; l=5081;
 i=kelvin.zhang@amlogic.com; s=20240329; h=from:subject:message-id;
 bh=RZgRRkkZrEuNbz37RVEud8NVXA4UvtxkJIzerJ/86lo=;
 b=xA9Jcfkz9OaK0o7FzoBlFuR9bh3RN4pR/Q7QCDMFd+LQG5R6Di11LrtXUIh6+alLiioBi3N5M
 u1/h7PU97Z/BJvN2un2gzkOJuTMbb+eEkOLl5G+UZEmMKJbqQYsUfOD
X-Developer-Key: i=kelvin.zhang@amlogic.com; a=ed25519;
 pk=pgnle7HTNvnNTcOoGejvtTC7BJT30HUNXfMHRRXSylI=
X-Endpoint-Received: by B4 Relay for kelvin.zhang@amlogic.com/20240329 with
 auth_id=148
X-Original-From: Kelvin Zhang <kelvin.zhang@amlogic.com>
Reply-To: kelvin.zhang@amlogic.com

From: Junyi Zhao <junyi.zhao@amlogic.com>

Add device nodes for PWM_AB, PWM_CD, PWM_EF, PWM_GH and PWM_IJ
along with GPIO PIN configs of each channel.

Signed-off-by: Junyi Zhao <junyi.zhao@amlogic.com>
Signed-off-by: Kelvin Zhang <kelvin.zhang@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/meson-s4.dtsi | 207 ++++++++++++++++++++++++++++++
 1 file changed, 207 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
index 10896f9df682..98f554577bae 100644
--- a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
@@ -312,6 +312,168 @@ mux {
 					};
 				};
 
+				pwm_a_pins1: pwm-a-pins1 {
+					mux {
+						groups = "pwm_a_d";
+						function = "pwm_a";
+					};
+				};
+
+				pwm_a_pins2: pwm-a-pins2 {
+					mux {
+						groups = "pwm_a_x";
+						function = "pwm_a";
+					};
+				};
+
+				pwm_a_pins: pwm-a-pins {
+					mux {
+						groups = "pwm_a_d";
+						function = "pwm_a";
+					};
+				};
+
+				pwm_b_pins1: pwm-b-pins1 {
+					mux {
+						groups = "pwm_b_d";
+						function = "pwm_b";
+					};
+				};
+
+				pwm_b_pins2: pwm-b-pins2 {
+					mux {
+						groups = "pwm_b_x";
+						function = "pwm_b";
+					};
+				};
+
+				pwm_c_pins1: pwm-c-pins1 {
+					mux {
+						groups = "pwm_c_d";
+						function = "pwm_c";
+					};
+				};
+
+				pwm_c_pins2: pwm-c-pins2 {
+					mux {
+						groups = "pwm_c_x";
+						function = "pwm_c";
+					};
+				};
+
+				pwm_d_pins1: pwm-d-pins1 {
+					mux {
+						groups = "pwm_d_d";
+						function = "pwm_d";
+					};
+				};
+
+				pwm_d_pins2: pwm-d-pins2 {
+					mux {
+						groups = "pwm_d_h";
+						function = "pwm_d";
+					};
+				};
+
+				pwm_e_pins1: pwm-e-pins1 {
+					mux {
+						groups = "pwm_e_x";
+						function = "pwm_e";
+						drive-strength-microamp = <500>;
+					};
+				};
+
+				pwm_e_pins2: pwm-e-pins2 {
+					mux {
+						groups = "pwm_e_z";
+						function = "pwm_e";
+					};
+				};
+
+				pwm_f_pins1: pwm-f-pins1 {
+					mux {
+						groups = "pwm_f_x";
+						function = "pwm_f";
+					};
+				};
+
+				pwm_f_pins2: pwm-f-pins2 {
+					mux {
+						groups = "pwm_f_z";
+						function = "pwm_f";
+					};
+				};
+
+				pwm_g_pins1: pwm-g-pins1 {
+					mux {
+						groups = "pwm_g_d";
+						function = "pwm_g";
+					};
+				};
+
+				pwm_g_pins2: pwm-g-pins2 {
+					mux {
+						groups = "pwm_g_z";
+						function = "pwm_g";
+					};
+				};
+
+				pwm_h_pins: pwm-h-pins {
+					mux {
+						groups = "pwm_h";
+						function = "pwm_h";
+					};
+				};
+
+				pwm_i_pins1: pwm-i-pins1 {
+					mux {
+						groups = "pwm_i_d";
+						function = "pwm_i";
+					};
+				};
+
+				pwm_i_pins2: pwm-i-pins2 {
+					mux {
+						groups = "pwm_i_h";
+						function = "pwm_i";
+					};
+				};
+
+				pwm_j_pins: pwm-j-pins {
+					mux {
+						groups = "pwm_j";
+						function = "pwm_j";
+					};
+				};
+
+				pwm_a_hiz_pins: pwm-a-hiz-pins {
+					mux {
+						groups = "pwm_a_hiz";
+						function = "pwm_a_hiz";
+					};
+				};
+
+				pwm_b_hiz_pins: pwm-b-hiz-pins {
+					mux {
+						groups = "pwm_b_hiz";
+						function = "pwm_b_hiz";
+					};
+				};
+
+				pwm_c_hiz_pins: pwm-c-hiz-pins {
+					mux {
+						groups = "pwm_c_hiz";
+						function = "pwm_b_hiz";
+					};
+				};
+
+				pwm_g_hiz_pins: pwm-g-hiz-pins {
+					mux {
+						groups = "pwm_g_hiz";
+						function = "pwm_g_hiz";
+					};
+				};
+
 				spicc0_pins_x: spicc0-pins_x {
 					mux {
 						groups = "spi_a_mosi_x",
@@ -399,6 +561,51 @@ spicc0: spi@50000 {
 				status = "disabled";
 			};
 
+			pwm_ab: pwm@58000 {
+				compatible = "amlogic,meson-s4-pwm";
+				reg = <0x0 0x58000 0x0 0x24>;
+				clocks = <&clkc_periphs CLKID_PWM_A>,
+						<&clkc_periphs CLKID_PWM_B>;
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
+			pwm_cd: pwm@5a000 {
+				compatible = "amlogic,meson-s4-pwm";
+				reg = <0x0 0x5a000 0x0 0x24>;
+				clocks = <&clkc_periphs CLKID_PWM_C>,
+						<&clkc_periphs CLKID_PWM_D>;
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
+			pwm_ef: pwm@5c000 {
+				compatible = "amlogic,meson-s4-pwm";
+				reg = <0x0 0x5c000 0x0 0x24>;
+				clocks = <&clkc_periphs CLKID_PWM_E>,
+						<&clkc_periphs CLKID_PWM_F>;
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
+			pwm_gh: pwm@5e000 {
+				compatible = "amlogic,meson-s4-pwm";
+				reg = <0x0 0x5e000 0x0 0x24>;
+				clocks = <&clkc_periphs CLKID_PWM_G>,
+						<&clkc_periphs CLKID_PWM_H>;
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
+			pwm_ij: pwm@60000 {
+				compatible = "amlogic,meson-s4-pwm";
+				reg = <0x0 0x60000 0x0 0x24>;
+				clocks = <&clkc_periphs CLKID_PWM_I>,
+						<&clkc_periphs CLKID_PWM_J>;
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
 			i2c0: i2c@66000 {
 				compatible = "amlogic,meson-axg-i2c";
 				reg = <0x0 0x66000 0x0 0x20>;

-- 
2.37.1



