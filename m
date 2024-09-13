Return-Path: <linux-pwm+bounces-3258-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DE8978471
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Sep 2024 17:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5953A1F26305
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Sep 2024 15:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22D81C2DD9;
	Fri, 13 Sep 2024 15:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNlM6Or6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DA61C2438;
	Fri, 13 Sep 2024 15:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726240168; cv=none; b=fXnPCfKogcU0gkJlbltxYqTv8CV5wAO72Hk98Y6nSuaHF0cepzQ0+Ed7m9dVwYKbe8SU8/zL9vNjwdB79GPtoC4t52qRVL0cm7jTf8qM4+wgEbAAWXOJyl23wLaCB78GaxtChK6cMaqRqgXqNhWKTXUIHUXTqaIwXNyA24ni9xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726240168; c=relaxed/simple;
	bh=cwfJ4ccvcYEzyYWYFd8BAOsLVSV2zpBW0R47/nwVpn8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bQLQmYTXX4eXS+zXA9u6AAMT5lU/8Eb2AaJm8eamEI8SghQ5SlGX+OnM/H4m4MXBuvL+ixXesFeaovmGNBqp1KyhPmpCdf3GnR8Jsiyh15TncLRr++LIKbXcd/eJlJIWzha7pJh5K+ivjt/bhwxUyErQLYb4b3InncubWT2q4OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dNlM6Or6; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c24ebaa427so5035868a12.1;
        Fri, 13 Sep 2024 08:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726240165; x=1726844965; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pPLYItCTXlABQSxSeSNTPkYPdrS7WYB5A+2uwS/A0o0=;
        b=dNlM6Or6IY2mA9YIyio3WbaCS0e9VeeodyHwPXUwOPFDiWl9AECw/MDoyUAIQZDhnt
         UQimDFqNXKm9yoqrLuyfnRKUJG18wXfPbssex6J+M6kco0S0AGXqbwfRLkgElgqcbcaO
         puLrEVpy3WKAVd/OaYPMpIF6fx3N952rju8jE2DEkQhCOzVwvMzyy2IebvEUbEOpUsHh
         t5IZRAEut/F/iGjE3dEfYEs91oFme97+FZ9GH1lSBxF5hp5XAKPuip+Xy5su8mQx7iHT
         4HW+2xPhBDnF0jnZuGk4+WRxYYDNTIhmiC/stFiyYIFzS8DC2NR+rNFkS3ikDEZFXJJa
         FsSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726240165; x=1726844965;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pPLYItCTXlABQSxSeSNTPkYPdrS7WYB5A+2uwS/A0o0=;
        b=ehRWqvkhQs73LioQAyJsJa2LKuGyM0AoL3wh5ax8EAH2ZMprc4DokLi+EEV6y6Q2i1
         7KYo2uplv861PXKmUQN31HGUqP2klEsgeFF3aABHNzGQdGT0ggeoq9GmwwlOmelopT4i
         SWLfxgQHAT+YmdgrEw3rrnSV+5q7AzMoLWZtUuZstjlZ33pfOqRZw4iTZNEGfXXl4+Zs
         hZlw6Ci5ZWVBLbySu1US9iUMZDyKFNJCnYoyPXAP5pBMNHBVR4nVZ8Z1RhSGvrFm66M7
         AFeFVs86BxlydNa1k39njOTrZNeNKqrqYwnyDKK8snzj2DqIcyQxyxNzhQg03Sl+Gj7T
         Oo2A==
X-Forwarded-Encrypted: i=1; AJvYcCUZSmXW1P23ErkfiRRSg0Hw22V5ofnSebtUnrVgwMWCMU2KoGjozYJBB4B9hFRU1PRKSDnpUKVHtauN@vger.kernel.org, AJvYcCUdXdVxo1XtuN/l5wic7rqMWQ/TEtzvztZQhGGCfRmraYEWsN+rDoWFqLOIWx7QH/OPHwm4A96N/E9/u+g=@vger.kernel.org, AJvYcCUmasMYiL2lAN11hh4mEueM/Xd4BKCaZ9z5uyi+m48eE8rXZpw4V6znEVxCjonIwPYwMYTT0j2NrfnMFw==@vger.kernel.org, AJvYcCUrnWrKIpFL/MJGPV2T1Tr6L/O85soWgwGQ97eoh4SlbHncY+3WGWPqtMluEq8wxCn8+LgghkOtZkbB@vger.kernel.org, AJvYcCV1w5AvkeEN3YWhHWpmP5xqlx79JBZPTvtudwjW43LArM5RnjyQgCkJmUiRwFVmZqo+tIJZ5JwT2lqM@vger.kernel.org, AJvYcCVniWytBWFqAgLtyfSmndjCRDQsSZ9xjuCbD5vB6MEUEWgPRVmWUnWW+J6YDsKXUkyJuDTCT4/M6E6opadAoQ==@vger.kernel.org, AJvYcCW5FkqwVMtrBVOhH0sitQaTWvlfMk5RrOVFHXpUYQ9EPUWYL1TkECLTEpelQeRKMHDGZXzYkEs/x/kPXTQt@vger.kernel.org, AJvYcCXY0JrCM+pLpusSA3Ya7lKNJPWkK+Z1bna3GwX+pNU5DZAUuu7MBOb0ydALwimmmUjN7ROo2FHfd8rlifAVnhyiO8c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1icpKRM5KPqQnRYFlJCNQWw18GHRL/afv0zQW4Qs1d5SWG46Z
	cWSDUaEDCJMsL6gy/0wVvJ9JSmueVks1+kV7msflGwax8b8f0rym26lMiQ==
X-Google-Smtp-Source: AGHT+IErbdJ28eJqWJNL5LSdaTaPINMhlHfcVt8rrpz5jT8XjpcKmpeCdv9t7/se8FEWso4bSJTP+A==
X-Received: by 2002:a05:6402:1d4b:b0:5c4:1360:55a with SMTP id 4fb4d7f45d1cf-5c413600563mr8595709a12.7.1726240165158;
        Fri, 13 Sep 2024 08:09:25 -0700 (PDT)
Received: from [127.0.1.1] ([178.127.153.210])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd523b4sm7774318a12.51.2024.09.13.08.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 08:09:23 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Fri, 13 Sep 2024 18:08:08 +0300
Subject: [PATCH v4 25/27] arm64: dts: qcom: starqltechn: add initial sound
 support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-starqltechn_integration_upstream-v4-25-2d2efd5c5877@gmail.com>
References: <20240913-starqltechn_integration_upstream-v4-0-2d2efd5c5877@gmail.com>
In-Reply-To: <20240913-starqltechn_integration_upstream-v4-0-2d2efd5c5877@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, 
 Simona Vetter <simona@ffwll.ch>, cros-qcom-dts-watchers@chromium.org, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Simona Vetter <simona.vetter@ffwll.ch>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
 linux-pwm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726240085; l=5097;
 i=dsankouski@gmail.com; s=20240618; h=from:subject:message-id;
 bh=cwfJ4ccvcYEzyYWYFd8BAOsLVSV2zpBW0R47/nwVpn8=;
 b=N7wpHZ0eUkaYh0uqAbHETEnp59jbrAkMDWPYI3nKUxfuBC99oB2/AeQtqyTHDOkfYo0Vp+4Pi
 L/9sGCOpfK4DqasNbqbLmh3bLRGqmTpZXdX288Zwn/AAAbTyQq4TGcQ
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=6pMMVVDDReSiRgPCbMOUauN5nS3ty4Sf5b7a2gi4x0M=

Add support for sound (headphones and mics only)
Also redefine slpi reserved memory, because adsp_mem overlaps with
slpi_mem inherited from sdm845.dtsi.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
 .../boot/dts/qcom/sdm845-samsung-starqltechn.dts   | 213 +++++++++++++++++++++
 1 file changed, 213 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
index 37433ef74502..c36ad043edf0 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
@@ -10,8 +10,15 @@
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+#include <dt-bindings/sound/qcom,q6afe.h>
+#include <dt-bindings/sound/qcom,q6asm.h>
+
 #include "sdm845.dtsi"
 #include "pm8998.dtsi"
+#include "sdm845-wcd9340.dtsi"
+
+/delete-node/ &adsp_mem;
+/delete-node/ &slpi_mem;
 
 / {
 	chassis-type = "handset";
@@ -83,6 +90,16 @@ memory@a1300000 {
 			ftrace-size = <0x40000>;
 			pmsg-size = <0x40000>;
 		};
+
+		slpi_mem: slpi@96700000 {
+			reg = <0 0x96700000 0 0xf00000>;
+			no-map;
+		};
+
+		adsp_mem: memory@97800000 {
+			reg = <0 0x97800000 0 0x2000000>;
+			no-map;
+		};
 	};
 
 	gpio_keys {
@@ -578,6 +595,202 @@ touchscreen@48 {
 	};
 };
 
+&adsp_pas {
+	firmware-name = "qcom/sdm845/starqltechn/adsp.mbn";
+	status = "okay";
+};
+
+&lpasscc {
+	status = "okay";
+};
+
+&wcd9340 {
+	reset-gpios = <&tlmm 64 GPIO_ACTIVE_HIGH>;
+	vdd-buck-supply = <&vreg_s4a_1p8>;
+	vdd-buck-sido-supply = <&vreg_s4a_1p8>;
+	vdd-tx-supply = <&vreg_s4a_1p8>;
+	vdd-rx-supply = <&vreg_s4a_1p8>;
+	vdd-io-supply = <&vreg_s4a_1p8>;
+	qcom,micbias1-microvolt = <1800000>;
+	qcom,micbias2-microvolt = <2700000>;
+	qcom,micbias3-microvolt = <1800000>;
+	qcom,micbias4-microvolt = <1800000>;
+};
+
+&sound {
+	compatible = "qcom,sdm845-sndcard";
+	model = "Samsung Galaxy S9";
+	pinctrl-0 = <&quat_mi2s_active &quat_mi2s_sd0_active &quat_mi2s_sd1_active>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	audio-routing =	"RX_BIAS", "MCLK",
+			"AMIC2", "MIC BIAS2", /* Headset Mic */
+			"AMIC3", "MIC BIAS2", /* FMLeft Tx */
+			"AMIC4", "MIC BIAS2", /* FMRight Tx */
+			"DMIC0", "MIC BIAS1", /* Digital Mic0 */
+			"DMIC5", "MIC BIAS4", /* Digital Mic1 */
+			"DMIC4", "MIC BIAS4", /* Digital Mic2 */
+			"DMIC3", "MIC BIAS3", /* Digital Mic3 */
+			"DMIC2", "MIC BIAS3", /* Digital Mic4 */
+			"DMIC1", "MIC BIAS1"; /* Digital Mic5 */
+
+	mm1-dai-link {
+		link-name = "MultiMedia1";
+		cpu {
+			sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA1>;
+		};
+	};
+
+	mm2-dai-link {
+		link-name = "MultiMedia2";
+		cpu {
+			sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA2>;
+		};
+	};
+
+	mm3-dai-link {
+		link-name = "MultiMedia3";
+		cpu {
+			sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA3>;
+		};
+	};
+
+	mm4-dai-link {
+		link-name = "MultiMedia4";
+		cpu {
+			sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA4>;
+		};
+	};
+
+	mm5-dai-link {
+		link-name = "MultiMedia5";
+		cpu {
+			sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA5>;
+		};
+	};
+
+	mm6-dai-link {
+		link-name = "MultiMedia6";
+		cpu {
+			sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA6>;
+		};
+	};
+
+	slim-dai-link {
+		link-name = "SLIM Playback 1";
+		cpu {
+			sound-dai = <&q6afedai SLIMBUS_0_RX>;
+		};
+
+		platform {
+			sound-dai = <&q6routing>;
+		};
+
+		codec {
+			sound-dai = <&wcd9340 0>;
+		};
+	};
+
+	slimcap-dai-link {
+		link-name = "SLIM Capture 1";
+		cpu {
+			sound-dai = <&q6afedai SLIMBUS_0_TX>;
+		};
+
+		platform {
+			sound-dai = <&q6routing>;
+		};
+
+		codec {
+			sound-dai = <&wcd9340 1>;
+		};
+	};
+
+	slim2-dai-link {
+		link-name = "SLIM Playback 2";
+		cpu {
+			sound-dai = <&q6afedai SLIMBUS_1_RX>;
+		};
+
+		platform {
+			sound-dai = <&q6routing>;
+		};
+
+		codec {
+			sound-dai = <&wcd9340 2>; /* AIF2_PB */
+		};
+	};
+
+	slimcap2-dai-link {
+		link-name = "SLIM Capture 2";
+		cpu {
+			sound-dai = <&q6afedai SLIMBUS_1_TX>;
+		};
+
+		platform {
+			sound-dai = <&q6routing>;
+		};
+
+		codec {
+			sound-dai = <&wcd9340 3>; /* AIF2_CAP */
+		};
+	};
+
+	slimcap3-dai-link {
+		link-name = "SLIM Capture 3";
+		cpu {
+			sound-dai = <&q6afedai SLIMBUS_2_TX>;
+		};
+
+		platform {
+			sound-dai = <&q6routing>;
+		};
+
+		codec {
+			sound-dai = <&wcd9340 5>; /* AIF3_CAP */
+		};
+	};
+};
+
+&q6afedai {
+	dai@22 {
+		reg = <22>;
+		qcom,sd-lines = <1>;
+	};
+
+	dai@23 {
+		reg = <23>;
+		qcom,sd-lines = <0>;
+	};
+};
+
+&q6asmdai {
+	dai@0 {
+		reg = <0>;
+	};
+
+	dai@1 {
+		reg = <1>;
+	};
+
+	dai@2 {
+		reg = <2>;
+	};
+
+	dai@3 {
+		reg = <3>;
+	};
+
+	dai@4 {
+		reg = <4>;
+	};
+
+	dai@5 {
+		reg = <5>;
+	};
+};
+
 &usb_1 {
 	status = "okay";
 };

-- 
2.39.2


