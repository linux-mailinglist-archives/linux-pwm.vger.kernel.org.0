Return-Path: <linux-pwm+bounces-2440-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F457906C4E
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Jun 2024 13:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52EABB2414F
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Jun 2024 11:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A74145B3C;
	Thu, 13 Jun 2024 11:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tzs6jRQj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C57B145B28;
	Thu, 13 Jun 2024 11:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279234; cv=none; b=ilnisScwjM+MyJUxxTNqeDUhkyf3dhB6c+dHqBfoKkaavwSVjfUc8wuWs/fEqA6KM08I66CH1S0dm2ODVQuVS/iLY0/8+pZDrBDr9dp6/jkA+z53hcYEDxTvvi3VXFhdBjFPnucNKxXcoEgt61J7Ive44muLLqLMU07nCnudWZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279234; c=relaxed/simple;
	bh=xK1M1jTlasgZOXGsoXEJPmHROR4pPhqFZBWaOt1OlV0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ci1ryknqvanQFK+RnnhyxMyChXuIgb25M0B8R8/P1eSDYI6lCtBKfFjg8K9GHT1alnWDkwrID4Yk7L5G4/TgzIkg8bCe/5JKaKHuEP9rsbOMFbH43EBB0a77ogGOVDVaBK2nkVmWXRf61ejhgqLJVh830AsUKKLg/CtQqihFUko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tzs6jRQj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E0714C4AF1A;
	Thu, 13 Jun 2024 11:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718279233;
	bh=xK1M1jTlasgZOXGsoXEJPmHROR4pPhqFZBWaOt1OlV0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Tzs6jRQjCQbydN+DsNykK0D7cFp4l9qXvflkZsHZDYCpeyvHLos83bWj9Fph6oxou
	 TS26DFCGuAwhbgTAtu8YWIc2O1WueUnBwcyGGBQ24tprNOkbC+nGitYxDUbzfhgEPO
	 BAZDy1gZJvOyZfSRXOLJW7o+0AsufUBIAyMT+2SAt2nlsPnlTrM2WS5rj4Rfvg/unJ
	 I7lM9xIx2TBUJeYZZu5VX922mTOoMVR865aC15dqGH8rMFOah/DhsUpJRo9nUieP0p
	 cnEDTlRLEbXU5JSd4n7nn7VMMiBl+Hi2dlZa+jqwxraeZ2FjgWO+qzPCkAseip28hs
	 dHeJzkQ3gbmmw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD882C27C4F;
	Thu, 13 Jun 2024 11:47:13 +0000 (UTC)
From: Kelvin Zhang via B4 Relay <devnull+kelvin.zhang.amlogic.com@kernel.org>
Date: Thu, 13 Jun 2024 19:46:36 +0800
Subject: [PATCH v8 2/2] arm64: dts: amlogic: Add Amlogic S4 PWM
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240613-s4-pwm-v8-2-b5bd0a768282@amlogic.com>
References: <20240613-s4-pwm-v8-0-b5bd0a768282@amlogic.com>
In-Reply-To: <20240613-s4-pwm-v8-0-b5bd0a768282@amlogic.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Kelvin Zhang <kelvin.zhang@amlogic.com>, 
 Junyi Zhao <junyi.zhao@amlogic.com>, 
 George Stark <gnstark@salutedevices.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718279231; l=4973;
 i=kelvin.zhang@amlogic.com; s=20240329; h=from:subject:message-id;
 bh=b3/eIOiXNo7aAd/HfKlMYuC241hZLYqtACy0+y3gabc=;
 b=gh92REkQaj/xDfbMhQYjSAUBw4KOC3jBHi4G17K+WRN0ChJJS5RR9EKRZ2sUDwpRU1dfcood4
 N/6B9Vh34kECBI1x4LbrThfqbDeI94yO9HzRvk8C6X4JwkrTdMzdjss
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
Reviewed-by: George Stark <gnstark@salutedevices.com>
Signed-off-by: Kelvin Zhang <kelvin.zhang@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/meson-s4.dtsi | 199 ++++++++++++++++++++++++++++++
 1 file changed, 199 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
index 10896f9df682..b686eacb9662 100644
--- a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
@@ -312,6 +312,160 @@ mux {
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
+						function = "pwm_c_hiz";
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
@@ -399,6 +553,51 @@ spicc0: spi@50000 {
 				status = "disabled";
 			};
 
+			pwm_ab: pwm@58000 {
+				compatible = "amlogic,meson-s4-pwm";
+				reg = <0x0 0x58000 0x0 0x24>;
+				clocks = <&clkc_periphs CLKID_PWM_A>,
+					 <&clkc_periphs CLKID_PWM_B>;
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
+			pwm_cd: pwm@5a000 {
+				compatible = "amlogic,meson-s4-pwm";
+				reg = <0x0 0x5a000 0x0 0x24>;
+				clocks = <&clkc_periphs CLKID_PWM_C>,
+					 <&clkc_periphs CLKID_PWM_D>;
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
+			pwm_ef: pwm@5c000 {
+				compatible = "amlogic,meson-s4-pwm";
+				reg = <0x0 0x5c000 0x0 0x24>;
+				clocks = <&clkc_periphs CLKID_PWM_E>,
+					 <&clkc_periphs CLKID_PWM_F>;
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
+			pwm_gh: pwm@5e000 {
+				compatible = "amlogic,meson-s4-pwm";
+				reg = <0x0 0x5e000 0x0 0x24>;
+				clocks = <&clkc_periphs CLKID_PWM_G>,
+					 <&clkc_periphs CLKID_PWM_H>;
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
+			pwm_ij: pwm@60000 {
+				compatible = "amlogic,meson-s4-pwm";
+				reg = <0x0 0x60000 0x0 0x24>;
+				clocks = <&clkc_periphs CLKID_PWM_I>,
+					 <&clkc_periphs CLKID_PWM_J>;
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
 			i2c0: i2c@66000 {
 				compatible = "amlogic,meson-axg-i2c";
 				reg = <0x0 0x66000 0x0 0x20>;

-- 
2.37.1



