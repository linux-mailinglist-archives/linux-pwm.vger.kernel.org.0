Return-Path: <linux-pwm+bounces-3267-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A24978E17
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Sep 2024 07:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38B31B23C91
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Sep 2024 05:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C35047772;
	Sat, 14 Sep 2024 05:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5s7EMPz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13CD175A1;
	Sat, 14 Sep 2024 05:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726293026; cv=none; b=KlNi1fCQl5Tn1JNfyV0QdrYuWVhFtiRNoy6i9o+znmzrBIRl48ofNGCYHndQe0M9U0zBfGTNxTaQ0L1hcEx9BWu8ISJMeuRwdsJZbIbWIBq+gsoxXv4PDeTebQytqnpn5txH3ozWr9mqkd0G0ibLhLVuwtZ+4bpjW890fv5xfis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726293026; c=relaxed/simple;
	bh=gjxdgzOTbuK1t3oNsNGH+aVaLHi2i5JqWnGkD0BaPas=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kN0hHpsqS7ah27qTCQC2gmkAm/ebYx5YDbd9WmNZldAqy7+3LFZZ5dmO4E6hgft+P5f93Asf9wX9f/n0Stk6sso5pTB+IEMD4vUiwp6UK32rWhI5hQBzkn1ytuUxOeeXRuPLNWn2wGFQglhM3COhF3X99FHHWPd7RUZVvKjohIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5s7EMPz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7A9AFC4CECD;
	Sat, 14 Sep 2024 05:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726293025;
	bh=gjxdgzOTbuK1t3oNsNGH+aVaLHi2i5JqWnGkD0BaPas=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=C5s7EMPzyMWnm9HyjQzfs2guh3+smdYyF/iUn1tIbvz9dWaMfqrEdBDQhChJNZE/G
	 vxNRxcC3bp6hervarZaqFns99lkONQTWiJ2FjzwWexcZ+uvL1Ihad1rzlIK+HvSSgp
	 M5k4rjYhYKkq6D+20nfEUU1448oXKZrBoDMu9cLhY2avEAnQMbhJ9XWlSps9PzpxdJ
	 /hO7AMjRSsuWguJavFycCQD7U7Vr0u4KfzLhDgRZsGI5E3WKzczV1I2uDEaBC8PBau
	 C+VckMXnnHoHkI/4/XOXhpGkNsv9VVVZtD4NWVXwe13DWzLo7QBPTYRWylUrK0rKpc
	 o9eX1RZcJoNsw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFC5FC619A;
	Sat, 14 Sep 2024 05:50:25 +0000 (UTC)
From: Kelvin Zhang via B4 Relay <devnull+kelvin.zhang.amlogic.com@kernel.org>
Date: Sat, 14 Sep 2024 13:48:59 +0800
Subject: [PATCH v2 2/2] arm64: dts: amlogic: Add Amlogic C3 PWM
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240914-c3-pwm-v2-2-ac1f34c68ac2@amlogic.com>
References: <20240914-c3-pwm-v2-0-ac1f34c68ac2@amlogic.com>
In-Reply-To: <20240914-c3-pwm-v2-0-ac1f34c68ac2@amlogic.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, Kelvin Zhang <kelvin.zhang@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726293023; l=8236;
 i=kelvin.zhang@amlogic.com; s=20240329; h=from:subject:message-id;
 bh=zpCPu/y3GMnpSwM1eRSKg3vp+x4qEdbYa0rlZLB2lXQ=;
 b=kSRvb9Ilv4OsX1gfzgPhAyAJD3kPLD3z3CeHohnoZ8mYQUK9rTktKOiteONxWuFQ45C14eNEj
 8vjjf09TkjaCJv4JWpHFm5pRInBeDd9bZ0iZDfYieJWp88bAujoNh/g
X-Developer-Key: i=kelvin.zhang@amlogic.com; a=ed25519;
 pk=pgnle7HTNvnNTcOoGejvtTC7BJT30HUNXfMHRRXSylI=
X-Endpoint-Received: by B4 Relay for kelvin.zhang@amlogic.com/20240329 with
 auth_id=148
X-Original-From: Kelvin Zhang <kelvin.zhang@amlogic.com>
Reply-To: kelvin.zhang@amlogic.com

From: Kelvin Zhang <kelvin.zhang@amlogic.com>

Add device nodes for PWM_AB, PWM_CD, PWM_EF, PWM_GH, PWM_IJ, PWM_KL
and PWM_MN, along with the GPIO pin configurations for each channel.

Signed-off-by: Kelvin Zhang <kelvin.zhang@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi | 364 ++++++++++++++++++++++++++++
 1 file changed, 364 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
index d0cda759c25d..fd0e557eba06 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
@@ -410,6 +410,300 @@ mux {
 						drive-strength-microamp = <4000>;
 					};
 				};
+
+				pwm_a_pins1: pwm-a-pins1 {
+					mux {
+						groups = "pwm_a";
+						function = "pwm_a";
+					};
+				};
+
+				pwm_b_pins1: pwm-b-pins1 {
+					mux {
+						groups = "pwm_b";
+						function = "pwm_b";
+					};
+				};
+
+				pwm_c_pins1: pwm-c-pins1 {
+					mux {
+						groups = "pwm_c";
+						function = "pwm_c";
+					};
+				};
+
+				pwm_d_pins1: pwm-d-pins1 {
+					mux {
+						groups = "pwm_d";
+						function = "pwm_d";
+					};
+				};
+
+				pwm_e_pins1: pwm-e-pins1 {
+					mux {
+						groups = "pwm_e";
+						function = "pwm_e";
+					};
+				};
+
+				pwm_f_pins1: pwm-f-pins1 {
+					mux {
+						groups = "pwm_f";
+						function = "pwm_f";
+					};
+				};
+
+				pwm_g_pins1: pwm-g-pins1 {
+					mux {
+						groups = "pwm_g_b";
+						function = "pwm_g";
+					};
+				};
+
+				pwm_g_pins2: pwm-g-pins2 {
+					mux {
+						groups = "pwm_g_c";
+						function = "pwm_g";
+					};
+				};
+
+				pwm_g_pins3: pwm-g-pins3 {
+					mux {
+						groups = "pwm_g_d";
+						function = "pwm_g";
+					};
+				};
+
+				pwm_g_pins4: pwm-g-pins4 {
+					mux {
+						groups = "pwm_g_x0";
+						function = "pwm_g";
+					};
+				};
+
+				pwm_g_pins5: pwm-g-pins5 {
+					mux {
+						groups = "pwm_g_x8";
+						function = "pwm_g";
+					};
+				};
+
+				pwm_h_pins1: pwm-h-pins1 {
+					mux {
+						groups = "pwm_h_b";
+						function = "pwm_h";
+					};
+				};
+
+				pwm_h_pins2: pwm-h-pins2 {
+					mux {
+						groups = "pwm_h_c";
+						function = "pwm_h";
+					};
+				};
+
+				pwm_h_pins3: pwm-h-pins3 {
+					mux {
+						groups = "pwm_h_d";
+						function = "pwm_h";
+					};
+				};
+
+				pwm_h_pins4: pwm-h-pins4 {
+					mux {
+						groups = "pwm_h_x1";
+						function = "pwm_h";
+					};
+				};
+
+				pwm_h_pins5: pwm-h-pins5 {
+					mux {
+						groups = "pwm_h_x9";
+						function = "pwm_h";
+					};
+				};
+
+				pwm_i_pins1: pwm-i-pins1 {
+					mux {
+						groups = "pwm_i_b";
+						function = "pwm_i";
+					};
+				};
+
+				pwm_i_pins2: pwm-i-pins2 {
+					mux {
+						groups = "pwm_i_c";
+						function = "pwm_i";
+					};
+				};
+
+				pwm_i_pins3: pwm-i-pins3 {
+					mux {
+						groups = "pwm_i_d";
+						function = "pwm_i";
+					};
+				};
+
+				pwm_i_pins4: pwm-i-pins4 {
+					mux {
+						groups = "pwm_i_x2";
+						function = "pwm_i";
+					};
+				};
+
+				pwm_i_pins5: pwm-i-pins5 {
+					mux {
+						groups = "pwm_i_x10";
+						function = "pwm_i";
+					};
+				};
+
+				pwm_j_pins1: pwm-j-pins1 {
+					mux {
+						groups = "pwm_j_c";
+						function = "pwm_j";
+					};
+				};
+
+				pwm_j_pins2: pwm-j-pins2 {
+					mux {
+						groups = "pwm_j_d";
+						function = "pwm_j";
+					};
+				};
+
+				pwm_j_pins3: pwm-j-pins3 {
+					mux {
+						groups = "pwm_j_b";
+						function = "pwm_j";
+					};
+				};
+
+				pwm_j_pins4: pwm-j-pins4 {
+					mux {
+						groups = "pwm_j_x3";
+						function = "pwm_j";
+					};
+				};
+
+				pwm_j_pins5: pwm-j-pins5 {
+					mux {
+						groups = "pwm_j_x12";
+						function = "pwm_j";
+					};
+				};
+
+				pwm_k_pins1: pwm-k-pins1 {
+					mux {
+						groups = "pwm_k_c";
+						function = "pwm_k";
+					};
+				};
+
+				pwm_k_pins2: pwm-k-pins2 {
+					mux {
+						groups = "pwm_k_d";
+						function = "pwm_k";
+					};
+				};
+
+				pwm_k_pins3: pwm-k-pins3 {
+					mux {
+						groups = "pwm_k_b";
+						function = "pwm_k";
+					};
+				};
+
+				pwm_k_pins4: pwm-k-pins4 {
+					mux {
+						groups = "pwm_k_x4";
+						function = "pwm_k";
+					};
+				};
+
+				pwm_k_pins5: pwm-k-pins5 {
+					mux {
+						groups = "pwm_k_x13";
+						function = "pwm_k";
+					};
+				};
+
+				pwm_l_pins1: pwm-l-pins1 {
+					mux {
+						groups = "pwm_l_c";
+						function = "pwm_l";
+					};
+				};
+
+				pwm_l_pins2: pwm-l-pins2 {
+					mux {
+						groups = "pwm_l_x";
+						function = "pwm_l";
+					};
+				};
+
+				pwm_l_pins3: pwm-l-pins3 {
+					mux {
+						groups = "pwm_l_b";
+						function = "pwm_l";
+					};
+				};
+
+				pwm_l_pins4: pwm-l-pins4 {
+					mux {
+						groups = "pwm_l_a";
+						function = "pwm_l";
+					};
+				};
+
+				pwm_m_pins1: pwm-m-pins1 {
+					mux {
+						groups = "pwm_m_c";
+						function = "pwm_m";
+					};
+				};
+
+				pwm_m_pins2: pwm-m-pins2 {
+					mux {
+						groups = "pwm_m_x";
+						function = "pwm_m";
+					};
+				};
+
+				pwm_m_pins3: pwm-m-pins3 {
+					mux {
+						groups = "pwm_m_a";
+						function = "pwm_m";
+					};
+				};
+
+				pwm_m_pins4: pwm-m-pins4 {
+					mux {
+						groups = "pwm_m_b";
+						function = "pwm_m";
+					};
+				};
+
+				pwm_n_pins1: pwm-n-pins1 {
+					mux {
+						groups = "pwm_n_x";
+						function = "pwm_n";
+					};
+				};
+
+				pwm_n_pins2: pwm-n-pins2 {
+					mux {
+						groups = "pwm_n_a";
+						function = "pwm_n";
+					};
+				};
+
+				pwm_n_pins3: pwm-n-pins3 {
+					mux {
+						groups = "pwm_n_b";
+						function = "pwm_n";
+					};
+				};
 			};
 
 			gpio_intc: interrupt-controller@4080 {
@@ -490,6 +784,16 @@ spicc1: spi@52000 {
 				status = "disabled";
 			};
 
+			pwm_mn: pwm@54000 {
+				compatible = "amlogic,c3-pwm",
+					     "amlogic,meson-s4-pwm";
+				reg = <0x0 54000 0x0 0x24>;
+				clocks = <&clkc_periphs CLKID_PWM_M>,
+					 <&clkc_periphs CLKID_PWM_N>;
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
 			spifc: spi@56000 {
 				compatible = "amlogic,a1-spifc";
 				reg = <0x0 0x56000 0x0 0x290>;
@@ -499,6 +803,66 @@ spifc: spi@56000 {
 				status = "disabled";
 			};
 
+			pwm_ab: pwm@58000 {
+				compatible = "amlogic,c3-pwm",
+					     "amlogic,meson-s4-pwm";
+				reg = <0x0 0x58000 0x0 0x24>;
+				clocks = <&clkc_periphs CLKID_PWM_A>,
+					 <&clkc_periphs CLKID_PWM_B>;
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
+			pwm_cd: pwm@5a000 {
+				compatible = "amlogic,c3-pwm",
+					     "amlogic,meson-s4-pwm";
+				reg = <0x0 0x5a000 0x0 0x24>;
+				clocks = <&clkc_periphs CLKID_PWM_C>,
+					 <&clkc_periphs CLKID_PWM_D>;
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
+			pwm_ef: pwm@5c000 {
+				compatible = "amlogic,c3-pwm",
+					     "amlogic,meson-s4-pwm";
+				reg = <0x0 0x5c000 0x0 0x24>;
+				clocks = <&clkc_periphs CLKID_PWM_E>,
+					 <&clkc_periphs CLKID_PWM_F>;
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
+			pwm_gh: pwm@5e000 {
+				compatible = "amlogic,c3-pwm",
+					     "amlogic,meson-s4-pwm";
+				reg = <0x0 0x5e000 0x0 0x24>;
+				clocks = <&clkc_periphs CLKID_PWM_G>,
+					 <&clkc_periphs CLKID_PWM_H>;
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
+			pwm_ij: pwm@60000 {
+				compatible = "amlogic,c3-pwm",
+					     "amlogic,meson-s4-pwm";
+				reg = <0x0 0x60000 0x0 0x24>;
+				clocks = <&clkc_periphs CLKID_PWM_I>,
+					 <&clkc_periphs CLKID_PWM_J>;
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
+			pwm_kl: pwm@62000 {
+				compatible = "amlogic,c3-pwm",
+					     "amlogic,meson-s4-pwm";
+				reg = <0x0 0x62000 0x0 0x24>;
+				clocks = <&clkc_periphs CLKID_PWM_K>,
+					 <&clkc_periphs CLKID_PWM_L>;
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
 			i2c0: i2c@66000 {
 				compatible = "amlogic,meson-axg-i2c";
 				reg = <0x0 0x66000 0x0 0x24>;

-- 
2.37.1



