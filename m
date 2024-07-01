Return-Path: <linux-pwm+bounces-2646-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC71291E682
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Jul 2024 19:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B1451C21574
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Jul 2024 17:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30EE16EB6A;
	Mon,  1 Jul 2024 17:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="Nl3lWf3U"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740C816EB5D;
	Mon,  1 Jul 2024 17:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719854436; cv=none; b=AkzSAB86TIW781XWGb1OazG+Cm+NLplU+BAbynsS5GBKrnTvR3q5iH44hN8dOlaJvxNfmigbXiGLum4NLRp1zXyYU5kxtZpawr4VkKfM5Mx1xfsjpxBVG4Px/eWVIufvV/GmNpRcFxE8cn1SbJJa6jtTqQtK8KqfRTwJP8tXnVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719854436; c=relaxed/simple;
	bh=SUIaTV81srnXVIJNxC+R4Sh2XmDPYaahO1P68G9vz40=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SUasGIJhJCkNlZ2bey5Pb/+Qoy46Pczz6bfQye3Pp9X6OMxaJNqmrBpFgIF2OfhI1RuXDyAxMGvKNfSBzHMGeZQXKnv4o9v+mSfsZ5RfF1GKpacjLmLzmSHPyWXewq/m1Nb+f/xqjk81ej1wuGVug8IOylYLNdX7pUNCYioL9kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=Nl3lWf3U; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 175ED12000F;
	Mon,  1 Jul 2024 20:20:25 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 175ED12000F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1719854425;
	bh=WDvsjnCOMqIp/cCpUuumCAjvp9d7iYIJ13Aq9BVxTOE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=Nl3lWf3URNXfrljicSut3aHE6IlnH+5pXpY4O6sg31jkbyjmpYDqS1QqKRPigfLVk
	 Wod853phv7VxvAPdTDDCDGZontnXuq2vVh31pmCepS9w+HAY1gMEUGaUFb5zrdeWx8
	 P/4OztoXndUOS4HubOJ2PkC9ch+Oqp9/3PxC1oZRCDQnckRiMjPvyCkIeYAtQTId1m
	 Yla8QupFNGciEMuhDgWKy5Wy6jkLwI7/Y3wzi/0r2R/Q7zokUYcqfvpKaHDQ7PHgwS
	 XW6wfcbwiGoNhRzTk8psUHNXMK9nGGluOwwQW00LfLqQwgglVuT4DlJF4+qOnCtkoY
	 QqsHNAkeZh6Vw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon,  1 Jul 2024 20:20:24 +0300 (MSK)
Received: from work.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 1 Jul 2024 20:20:24 +0300
From: George Stark <gnstark@salutedevices.com>
To: <ukleinek@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <neil.armstrong@linaro.org>, <khilman@baylibre.com>,
	<jbrunet@baylibre.com>, <martin.blumenstingl@googlemail.com>,
	<hkallweit1@gmail.com>
CC: <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-amlogic@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <kernel@salutedevices.com>, George Stark
	<GNStark@sberdevices.ru>, Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: [PATCH v2 3/3] arm64: dts: meson: a1: add definitions for meson PWM
Date: Mon, 1 Jul 2024 20:20:16 +0300
Message-ID: <20240701172016.523402-4-gnstark@salutedevices.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240701172016.523402-1-gnstark@salutedevices.com>
References: <20240701172016.523402-1-gnstark@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 186247 [Jul 01 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 21 0.3.21 ebee5449fc125b2da45f1a6a6bc2c5c0c3ad0e05, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;100.64.160.123:7.1.2;smtp.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/07/01 15:14:00 #25789329
X-KSMG-AntiVirus-Status: Clean, skipped

From: George Stark <GNStark@sberdevices.ru>

The chip has 3 dual-channel PWM modules PWM_AB, PWM_CD, PWM_EF those
can be connected to various digital I/O pins.

Each of 6 PWM is driven by individually selected clock parent and
8-bit divider. The PWM signal is generated using two 16-bit counters.

Signed-off-by: George Stark <GNStark@sberdevices.ru>
Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi | 215 ++++++++++++++++++++++
 1 file changed, 215 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
index 2a69e1e41bdc..d93b10bd156b 100644
--- a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
@@ -307,6 +307,188 @@ mux {
 					};
 				};
 
+				pwm_a_pins1: pwm-a-pins1 {
+					mux {
+						groups = "pwm_a_x6";
+						function = "pwm_a";
+					};
+				};
+
+				pwm_a_pins2: pwm-a-pins2 {
+					mux {
+						groups = "pwm_a_x7";
+						function = "pwm_a";
+					};
+				};
+
+				pwm_a_pins3: pwm-a-pins3 {
+					mux {
+						groups = "pwm_a_f10";
+						function = "pwm_a";
+					};
+				};
+
+				pwm_a_pins4: pwm-a-pins4 {
+					mux {
+						groups = "pwm_a_f6";
+						function = "pwm_a";
+					};
+				};
+
+				pwm_a_pins5: pwm-a-pins5 {
+					mux {
+						groups = "pwm_a_a";
+						function = "pwm_a";
+					};
+				};
+
+				pwm_b_pins1: pwm-b-pins1 {
+					mux {
+						groups = "pwm_b_x";
+						function = "pwm_b";
+					};
+				};
+
+				pwm_b_pins2: pwm-b-pins2 {
+					mux {
+						groups = "pwm_b_f";
+						function = "pwm_b";
+					};
+				};
+
+				pwm_b_pins3: pwm-b-pins3 {
+					mux {
+						groups = "pwm_b_a";
+						function = "pwm_b";
+					};
+				};
+
+				pwm_c_pins1: pwm-c-pins1 {
+					mux {
+						groups = "pwm_c_x";
+						function = "pwm_c";
+					};
+				};
+
+				pwm_c_pins2: pwm-c-pins2 {
+					mux {
+						groups = "pwm_c_f3";
+						function = "pwm_c";
+					};
+				};
+
+				pwm_c_pins3: pwm-c-pins3 {
+					mux {
+						groups = "pwm_c_f8";
+						function = "pwm_c";
+					};
+				};
+
+				pwm_c_pins4: pwm-c-pins4 {
+					mux {
+						groups = "pwm_c_a";
+						function = "pwm_c";
+					};
+				};
+
+				pwm_d_pins1: pwm-d-pins1 {
+					mux {
+						groups = "pwm_d_x15";
+						function = "pwm_d";
+					};
+				};
+
+				pwm_d_pins2: pwm-d-pins2 {
+					mux {
+						groups = "pwm_d_x13";
+						function = "pwm_d";
+					};
+				};
+
+				pwm_d_pins3: pwm-d-pins3 {
+					mux {
+						groups = "pwm_d_x10";
+						function = "pwm_d";
+					};
+				};
+
+				pwm_d_pins4: pwm-d-pins4 {
+					mux {
+						groups = "pwm_d_f";
+						function = "pwm_d";
+					};
+				};
+
+				pwm_e_pins1: pwm-e-pins1 {
+					mux {
+						groups = "pwm_e_p";
+						function = "pwm_e";
+					};
+				};
+
+				pwm_e_pins2: pwm-e-pins2 {
+					mux {
+						groups = "pwm_e_x16";
+						function = "pwm_e";
+					};
+				};
+
+				pwm_e_pins3: pwm-e-pins3 {
+					mux {
+						groups = "pwm_e_x14";
+						function = "pwm_e";
+					};
+				};
+
+				pwm_e_pins4: pwm-e-pins4 {
+					mux {
+						groups = "pwm_e_x2";
+						function = "pwm_e";
+					};
+				};
+
+				pwm_e_pins5: pwm-e-pins5 {
+					mux {
+						groups = "pwm_e_f";
+						function = "pwm_e";
+					};
+				};
+
+				pwm_e_pins6: pwm-e-pins6 {
+					mux {
+						groups = "pwm_e_a";
+						function = "pwm_e";
+					};
+				};
+
+				pwm_f_pins1: pwm-f-pins1 {
+					mux {
+						groups = "pwm_f_b";
+						function = "pwm_f";
+					};
+				};
+
+				pwm_f_pins2: pwm-f-pins2 {
+					mux {
+						groups = "pwm_f_x";
+						function = "pwm_f";
+					};
+				};
+
+				pwm_f_pins3: pwm-f-pins3 {
+					mux {
+						groups = "pwm_f_f4";
+						function = "pwm_f";
+					};
+				};
+
+				pwm_f_pins4: pwm-f-pins4 {
+					mux {
+						groups = "pwm_f_f12";
+						function = "pwm_f";
+					};
+				};
+
 				sdio_pins: sdio {
 					mux0 {
 						groups = "sdcard_d0_x",
@@ -648,6 +830,28 @@ uart_AO_B: serial@2000 {
 				status = "disabled";
 			};
 
+			pwm_ab: pwm@2400 {
+				compatible = "amlogic,meson-a1-pwm",
+					     "amlogic,meson-s4-pwm";
+				reg = <0x0 0x2400 0x0 0x24>;
+				#pwm-cells = <3>;
+				clocks = <&clkc_periphs CLKID_PWM_A>,
+					 <&clkc_periphs CLKID_PWM_B>;
+				power-domains = <&pwrc PWRC_I2C_ID>;
+				status = "disabled";
+			};
+
+			pwm_cd: pwm@2800 {
+				compatible = "amlogic,meson-a1-pwm",
+					     "amlogic,meson-s4-pwm";
+				reg = <0x0 0x2800 0x0 0x24>;
+				#pwm-cells = <3>;
+				clocks = <&clkc_periphs CLKID_PWM_C>,
+					 <&clkc_periphs CLKID_PWM_D>;
+				power-domains = <&pwrc PWRC_I2C_ID>;
+				status = "disabled";
+			};
+
 			saradc: adc@2c00 {
 				compatible = "amlogic,meson-g12a-saradc",
 					"amlogic,meson-saradc";
@@ -731,6 +935,17 @@ sec_AO: ao-secure@5a20 {
 				amlogic,has-chip-id;
 			};
 
+			pwm_ef: pwm@5400 {
+				compatible = "amlogic,meson-a1-pwm",
+					     "amlogic,meson-s4-pwm";
+				reg = <0x0 0x5400 0x0 0x24>;
+				#pwm-cells = <3>;
+				clocks = <&clkc_periphs CLKID_PWM_E>,
+					 <&clkc_periphs CLKID_PWM_F>;
+				power-domains = <&pwrc PWRC_I2C_ID>;
+				status = "disabled";
+			};
+
 			clkc_pll: pll-clock-controller@7c80 {
 				compatible = "amlogic,a1-pll-clkc";
 				reg = <0 0x7c80 0 0x18c>;
-- 
2.25.1


