Return-Path: <linux-pwm+bounces-3255-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD27978446
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Sep 2024 17:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28AF31C20917
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Sep 2024 15:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A51192586;
	Fri, 13 Sep 2024 15:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFudbJvi"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE2118FDD7;
	Fri, 13 Sep 2024 15:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726240159; cv=none; b=TopdIk43mDDAavsB+Ksu3pKGzKHUMX9xtBfgyyfc08V7G1UUaVqh2VcFzhxQ4DO4Zj/c6xprt3YuM7ImAG4Ff/xUw1t/HSrRx+xcCc1UrRyIHqPK59z1ncTzwYzvnZ0cPUemjTHofQ/7eglYbhv/aMNJFrtD5HNmZAWC2rp1KwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726240159; c=relaxed/simple;
	bh=p7eZaA4h3yztijkM8JFf5ob4Unk9CxIwdqtw+LwA+HA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NOLP4bqrGYp4tUx2MniUAJ20MVa+A2Z3Teh+XI67w0AuRb6hh1B6krt2jdOiKFFu6r9Uu4zEXXkkHsI+wFHDctWjuakz7NFxlkMMdBIzgKjufEn+WSRlVk6LXq8/9EDvJLl1m+Rm5N1EOXAoDCKJa9BrNz5jz6T2RIjydF3+UUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iFudbJvi; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a8a7903cb7dso60337466b.3;
        Fri, 13 Sep 2024 08:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726240155; x=1726844955; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WJ726FEj57/R1QW6ACfpQvWc4FsY/5U5BsMP7VDxoEk=;
        b=iFudbJviorM31+Bk04l2XOTV7W4Hpi1H2DUM1Jm1GWA1qXUEW7B3EIqMtqILANH/6J
         w2MkPe3FQisSNbqJyE9tptHHM5rA7wsd3wyE3KqDGkaWp4XgUEmexG9J57NecAOSPxHI
         zmo0bnmJba/PAPdqiOOhYrUYmoLbhlhuEDFoCeYwb7tD4S3CTAbpwagHJbgPD8dK8yR+
         NnKHHRqwdZPnkvms7DDrc0S8UZQOQXfL3Fup8Lsezx1dZ3nWJyilJAb80kFXhpZ6l7ub
         YJfwnoSb34IMFqll09VHxJbtetTTaLwTMqV3vA1Womkl0MI2AJt2F3SkOENzRW/aD4Eg
         DrbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726240155; x=1726844955;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WJ726FEj57/R1QW6ACfpQvWc4FsY/5U5BsMP7VDxoEk=;
        b=qRYnnSc0RPM7W4jZEf7AnEzNbQfpWNDX15ckapu+wFo1fWNYu0zK2yFD94km4Uy0df
         phcgJfSR/HYKeL3JBCv62Bzv7Wgfk5IVLKMHr6E6awYtt98U4yKochcA1LdzTWknSzOt
         9XR/jlFyfqhuxfPmmYcIa7nVW3ELsxqMZCkt0VGD1ObrfCUyd+BoC8yZEamUDhh04mxr
         v9F4qyzxvNCdaZ9JtusJkH1Q6UnbYUb+j47Ae+9WZ91XGxZfxpz4exS1i+llE9xrZqGe
         Mk+oWjR0bL/bH0S/nzqt1+hk5jPHLYBWGVS7TkLPkMXrhME4k+hCWcldeBMsIGm/OZdj
         57/Q==
X-Forwarded-Encrypted: i=1; AJvYcCU/zBDpQQ317kTYaW7s9apjiCTIS4DOzJtNgQDLwL+RTRpWONZ6j5Gp9hU5uP1cECj1R11BsH8PUjV3@vger.kernel.org, AJvYcCU2+vW785AlqvMZPYaR9tq7aGIz5Y8nT2KELYE9CF4UeyrplBp544k3DYw4IrkysRsLMYSafHPg7Hj+@vger.kernel.org, AJvYcCUMFCOxSFpha8xbFhFWimi+pmdVWNGRQ9hPOEx9b1w9IJzmMSap7MopJmcgip08Afj8j4AKtWs41p0Fbw==@vger.kernel.org, AJvYcCUvSPC1L/Azi0NbU3yBcBh3oh1qOEqU8ULgmrunA3Tnb8HR7dJ7ejw+mEFJ1lLLFR9e9/K59pUV51jpiBExSg==@vger.kernel.org, AJvYcCVH4hZWmNaj8gG/wP67V7LVxteUAkmJXjb0RpkVgxJm564upoP5Z+UHuQlhGd1Crrdi3eTugMMTd8rf@vger.kernel.org, AJvYcCVKa1dU5/66Zw3t2FOKWX1eWiAz0SPTvL7qgNkeJEgqt7qqf7BrOZitfubJlfcSOtAEGQImdRXFhTAdg54=@vger.kernel.org, AJvYcCVmcqX4D3Y3gCn52PERtWWAkdYrG30HMuoA18VgtXmSA1/gI8/j+Mwk0raP3jEbZd2et510CXFmPyVM1mIhT9dmllE=@vger.kernel.org, AJvYcCWPWA7223pqWLkrDIS/2eni5uxGNgAJzuEZftnlr1EKJi3kGqPLDQikk3t0/tuLebP1FfQLCdTA0IaKYZ9W@vger.kernel.org
X-Gm-Message-State: AOJu0YzHKSw0qHK6JOQtNXjKEcooKcl3aELpOMQ1M0YuRNV6ep2qvh/U
	GN3SZg3tCKHvb35HvfzCnz5qmy/69jGtRYx9d/bTRPeJ8BKfvfReQ+DPuQ==
X-Google-Smtp-Source: AGHT+IGbWJlyYcTF+ffZxNKKAxILQEsgpMR15i+Fbqpth5IfaRpW0PZ4FN23j11Gq0H5O8f6BLvrqQ==
X-Received: by 2002:a05:6402:1eca:b0:5c3:cb56:e67b with SMTP id 4fb4d7f45d1cf-5c41e2af60dmr2838183a12.35.1726240154887;
        Fri, 13 Sep 2024 08:09:14 -0700 (PDT)
Received: from [127.0.1.1] ([178.127.153.210])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd523b4sm7774318a12.51.2024.09.13.08.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 08:09:13 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Fri, 13 Sep 2024 18:08:05 +0300
Subject: [PATCH v4 22/27] arm64: dts: qcom: starqltechn: add max77705 PMIC
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-starqltechn_integration_upstream-v4-22-2d2efd5c5877@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726240085; l=3533;
 i=dsankouski@gmail.com; s=20240618; h=from:subject:message-id;
 bh=p7eZaA4h3yztijkM8JFf5ob4Unk9CxIwdqtw+LwA+HA=;
 b=sdmst4ZjHx4WBMFwaH5sYpxzuUlyQwoYFynueV8VOADBU6Zor6CgrUGWRItdc5ujNdlCYmr7X
 +kp8+qPKBdtCSdNIMrP9DZgeC0rtTreg0KpBQi5EMFj6+FzaKsokgP1
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=6pMMVVDDReSiRgPCbMOUauN5nS3ty4Sf5b7a2gi4x0M=

Add support for max77705 MFD device. Supported sub-devices:
 charger, fuelgauge, haptic, led

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
 .../boot/dts/qcom/sdm845-samsung-starqltechn.dts   | 103 +++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
index a3bd5231569d..865253d8f0c7 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
@@ -18,6 +18,16 @@ / {
 	model = "Samsung Galaxy S9 SM-G9600";
 	compatible = "samsung,starqltechn", "qcom,sdm845";
 
+	battery: battery {
+		compatible = "simple-battery";
+		constant-charge-current-max-microamp = <2150000>;
+		charge-full-design-microamp-hours = <3000000>;
+
+		over-voltage-threshold-microvolt = <4500000>;
+		voltage-min-design-microvolt = <3400000>;
+		voltage-max-design-microvolt = <4350000>;
+	};
+
 	chosen {
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -90,6 +100,27 @@ key-wink {
 			debounce-interval = <15>;
 		};
 	};
+
+	vib_regulator: gpio-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "haptic";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-boot-on;
+		enable-active-high;
+		gpio = <&pm8998_gpios 18 GPIO_ACTIVE_HIGH>;
+	};
+
+	vib_pwm: pwm {
+		#pwm-cells = <2>;
+		compatible = "clk-pwm";
+		clocks = <&gcc GCC_GP1_CLK>;
+		assigned-clock-parents = <&rpmhcc RPMH_CXO_CLK>;
+		assigned-clocks = <&gcc GCC_GP1_CLK_SRC>;
+		pinctrl-0 = <&motor_pwm_default_state>;
+		pinctrl-1 = <&motor_pwm_suspend_state>;
+		pinctrl-names = "default", "suspend";
+	};
 };
 
 
@@ -385,10 +416,66 @@ &qupv3_id_1 {
 	status = "okay";
 };
 
+&gpi_dma1 {
+	status = "okay";
+};
+
 &uart9 {
 	status = "okay";
 };
 
+&i2c14 {
+	status = "okay";
+
+	pmic@66 {
+		compatible = "maxim,max77705";
+		reg = <0x66>;
+		interrupt-parent = <&pm8998_gpios>;
+		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-0 = <&chg_int_default>;
+		pinctrl-names = "default";
+
+		leds {
+			compatible = "maxim,max77705-led";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			led@1 {
+				reg = <1>;
+				label = "red:usr1";
+			};
+
+			led@2 {
+				reg = <2>;
+				label = "green:usr2";
+			};
+
+			led@3 {
+				reg = <3>;
+				label = "blue:usr3";
+			};
+		};
+
+		max77705_charger: charger {
+			compatible = "maxim,max77705-charger";
+			monitored-battery = <&battery>;
+		};
+
+		fuel_gauge {
+			compatible = "maxim,max77705-fuel-gauge";
+			monitored-battery = <&battery>;
+			power-supplies = <&max77705_charger>;
+			shunt-resistor-micro-ohms = <5000>;
+		};
+
+		haptic {
+			compatible = "maxim,max77705-haptic";
+			haptic-supply = <&vib_regulator>;
+			pwms = <&vib_pwm 0 100000>;
+		};
+	};
+};
+
 &ufs_mem_hc {
 	reset-gpios = <&tlmm 150 GPIO_ACTIVE_LOW>;
 	vcc-supply = <&vreg_l20a_2p95>;
@@ -485,4 +572,20 @@ sd_card_det_n_state: sd-card-det-n-state {
 		function = "gpio";
 		bias-pull-up;
 	};
+
+	motor_pwm_default_state: motor-pwm-active-state {
+		pins = "gpio57";
+		function = "gcc_gp1";
+		drive-strength = <2>;
+		bias-disable;
+		output-high;
+	};
+
+	motor_pwm_suspend_state: motor-pwm-suspend-state {
+		pins = "gpio57";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+		output-low;
+	};
 };

-- 
2.39.2


