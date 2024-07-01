Return-Path: <linux-pwm+bounces-2643-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1981A91E020
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Jul 2024 15:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B3251F23680
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Jul 2024 13:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A828815DBAF;
	Mon,  1 Jul 2024 13:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="DybD95eX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F641591E3;
	Mon,  1 Jul 2024 13:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719838894; cv=none; b=ECIqWV1q25R+/E9nO2PgxUBhiITgdNI/8qut/zujtc5NQgLo8NaYHNo8YnyzIoPZU4G7ki2np4Cgayhxkz2jpTPKKi0y1bTMUEEU1b6TfZrPBsGJW8RBRjENdgagH7Mki2w7z1R0dHjUus3pFYm/rjngszbXS5LsbN6bBYANuXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719838894; c=relaxed/simple;
	bh=SUIaTV81srnXVIJNxC+R4Sh2XmDPYaahO1P68G9vz40=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hni+8Hl0CtF8vEvsdwsyg1b8CkAo77yVYNbIwxoQHK5ayox8Ju0Z+nYqnpYGMKbRZBo81QS3G9OUF1UF9Ca+8kYHbfhzg4qL291GcxogvASyqrvEA1MGRi27K1x/aUskBUhXcAeH44RF634kw6KZGYptbLooWPPJwurEAypF23A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=DybD95eX; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 6EFEC100023;
	Mon,  1 Jul 2024 16:01:23 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 6EFEC100023
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1719838883;
	bh=WDvsjnCOMqIp/cCpUuumCAjvp9d7iYIJ13Aq9BVxTOE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=DybD95eXYe/ryPCzwCPZ3puFOhiZSEkLul5NUUmvIu4W+tGO+eq3Vg9CiOaDBeNt/
	 1d6O2Mq21FPUbluKFok2kQASYYqZKRjPkyXw+T/okpefYaIxpi9e6iROmkxk5MiA2Z
	 goFuOLEHhCbABzurreNBjz/pVfsdik7B4ByOmEo+qXbtKeH6lzVKRgGvTr/hXhvMCn
	 pcGhGBQVGQx+TAmigkwpal8y0puLYTr/dOPKvPP7ABZYeQUmJCmn4coDUnY97g6iyk
	 Alb9AWfHIZb5DIoWkplGurexPVS0VRvmVHjWU7RSAgGnG+3RC+m09wvGkZUu6R7hyU
	 9Ppv/qwRHf2bQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon,  1 Jul 2024 16:01:23 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 1 Jul 2024 16:01:22 +0300
From: George Stark <gnstark@salutedevices.com>
To: <ukleinek@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <neil.armstrong@linaro.org>, <khilman@baylibre.com>,
	<jbrunet@baylibre.com>, <martin.blumenstingl@googlemail.com>,
	<hkallweit1@gmail.com>
CC: <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-amlogic@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <kernel@salutedevices.com>, George Stark
	<GNStark@sberdevices.ru>, Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: [PATCH 2/2] arm64: dts: meson: a1: add definitions for meson pwm
Date: Mon, 1 Jul 2024 16:01:13 +0300
Message-ID: <20240701130113.433169-3-gnstark@salutedevices.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240701130113.433169-1-gnstark@salutedevices.com>
References: <20240701130113.433169-1-gnstark@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 186241 [Jul 01 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 21 0.3.21 ebee5449fc125b2da45f1a6a6bc2c5c0c3ad0e05, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;smtp.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/07/01 11:44:00 #25786379
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


