Return-Path: <linux-pwm+bounces-3256-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A9C978453
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Sep 2024 17:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BE04280D9D
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Sep 2024 15:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3C4199E8B;
	Fri, 13 Sep 2024 15:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8i3J0Tj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EB1192B78;
	Fri, 13 Sep 2024 15:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726240161; cv=none; b=r66W4Q/AlOFK2k4KV2oesVlT2U6q6f+aC8NI5yy5Tpe6tokDzD5kcGDqldfzzWcnQpZyflkl69ODNsa4/ZdEsMj2ld0Y4Xkfl7SGq/YTFNye3cejoDFGU8EA017BGUmT0/hUAtxgGLRLPuXMIztLoYCSEIoJ9SDAo/X8kBVDZ24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726240161; c=relaxed/simple;
	bh=B0sd1Gx57GIbQM0BZaCzYGyV/pp35NQhF6ldvlao3X0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NDewVFEiZNSYO9v85svxIaNIFII16KWq/lEvRUVd3k8c+6ZbgVIUd5YAqg9+CTf3ukPVICiCNlVH8IHru9S8bYmqUqdhUHsdZYzya1+lSCd9pZeytpb5IMXedTkbHkEQN9b+Axa5rhKs4yFB6TyAVAA3ru4j2a20HeijohA2QAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8i3J0Tj; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c4226a5af8so888196a12.1;
        Fri, 13 Sep 2024 08:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726240157; x=1726844957; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CfgwI6EyZw2/O0lD30k5AoCMwqQKhtZSyo8NYOTmFvs=;
        b=l8i3J0Tj2mRFGeAbQdOVGQd0I+aX7AwmTcI7PH4ZOk4uJcBq8YscoRyvJeEskHEx3g
         zRU7EB8hwjH2Swzpsv7IqjNQT7FBbxh4AI1dVJviNsfjVsakrhdAtvm/+Ty71khUgfEW
         VMKIFd7TlPeLHG9fCqagBQvj5UQUcV6A2l3NlbZb+1njyBTUY8heOUtggimqpJLIuqtQ
         5k4o0jGiWdljeoTCX9xifXuq0QuMM2mCc+lrteidcZTw/vZox+OZCq+EDVEjcVfhmIRo
         z8n6mWB9BkQZMO/KBu/r38vyZC1qZ7dJ5wWfR9MbtvLEvGgDUVPVPqynxYLNB7ZGk5qY
         D15w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726240157; x=1726844957;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CfgwI6EyZw2/O0lD30k5AoCMwqQKhtZSyo8NYOTmFvs=;
        b=Y0gmxals0ds08YWSrknjIN+8mQOJ1EhXeSKF6tJ6+QuAfuHbKiWRt/0+DbXIXZvOvV
         9NF2QHWTYyVMQ8vYYSVU4YZBmcpBy933mmcBfgIE84K8OeiGCXFYuqmS9R2lgh/7qnFI
         VMpwjrZYDim8T9QGvyy7t792MU1l1G270YJJda2UKQbu0COhtYKscWHb47CtlobFHLcM
         K8GSXXlyS2skT+KjxOM0GWoHmUCBHLYaaPSTyyuE5iLyh3nfr4T5IndgRowItDFq1Fj3
         EJuirRsnz1kL8/gBl+WiU45Y2wXMUXTs/Qjk5ZeZ/Xd5Q3JlB2j8x4vRsetGagJBKPhF
         Vy6w==
X-Forwarded-Encrypted: i=1; AJvYcCU8coZ40Od70F3SYxH6qGwFbQsENc6fh+ME7P/C7ffsESmkOQVHhGuP3x2t2ELE8azn62b22wcgh3Xk@vger.kernel.org, AJvYcCUwyZSs4a0GZLy1XfxbhcPYUPPb1WgEpCGODZosRe3rZwDtW9UJ83dQby6kszl/nsZOWq4bx7r0i7A5@vger.kernel.org, AJvYcCVSTrkDhdCGAwLjv7iVM1tvpXLduY8rdMsju40PvUISRD9V9x9d83Ddfko/hBuR6d02yfyr06rI5dtc+A==@vger.kernel.org, AJvYcCWZ6sY22x43GDTZ9R67zibcZFRPYOsK0dtNnlUepwdWkhaDlQWK6ZM1Uxz8DfldkxuKDbx+/iA8ogruFNLpYg==@vger.kernel.org, AJvYcCX/Mrb9PfOQCsdlVerd4fJP+sN7VTe6RxhnzOQ42KaeIN8jzbr8jz0JdMrk9GW4GH1HicI+hHuFOAbMnv6V@vger.kernel.org, AJvYcCXEGnFaHdndfGsJqMZbad78VaQTUMZvMoYlcqLCcAFolL1AaO3k+Kjr7iFm56ZpUbgp6qkRptjIZEFWxko17r4gvSw=@vger.kernel.org, AJvYcCXMMy5r0QDmBcwxf+Ce6cNSqdtKyYE9LGokIMlGUtpdlx6Nqz0xvsdyJGzlG1Wy6EbHPKq5Hj4HiwGB@vger.kernel.org, AJvYcCXMbiycKNqL/cNQQhvvPHFnRWoHHCViise6ir2wmf1x+YDEI07OK/FtdjHbPmP520k+eTG+fUiYkS87RKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS8Bz4nO53aD5eBLPpDTVLO3m6xfQJmmWMdkWXalQalYOMEx/H
	uXdgBpHQ+VdqofisuwAmdgGCIP+vfGy/fgAVFzXFCEzSaM+2lMk3AVPGRw==
X-Google-Smtp-Source: AGHT+IF0OxyUbB6FJHD8McDF5ty7a7zew0Jhoux110abjXEGOrNTZK7ycGjZ7jao9Xga6RTaqep0tQ==
X-Received: by 2002:a05:6402:2550:b0:5c2:4cbe:ac1c with SMTP id 4fb4d7f45d1cf-5c413e08a4emr5599000a12.4.1726240157337;
        Fri, 13 Sep 2024 08:09:17 -0700 (PDT)
Received: from [127.0.1.1] ([178.127.153.210])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd523b4sm7774318a12.51.2024.09.13.08.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 08:09:16 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Fri, 13 Sep 2024 18:08:06 +0300
Subject: [PATCH v4 23/27] arm64: dts: qcom: starqltechn: add display PMIC
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-starqltechn_integration_upstream-v4-23-2d2efd5c5877@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726240085; l=3073;
 i=dsankouski@gmail.com; s=20240618; h=from:subject:message-id;
 bh=B0sd1Gx57GIbQM0BZaCzYGyV/pp35NQhF6ldvlao3X0=;
 b=Afsvb9SybbZRXgS6pDW1Msrxj27/iqXUOQG+exL3XbRxXnVQd9hzOq6RbxjDrDtamcCt/cUDO
 cRXRD3I/PhVDmHOUmC0zcsYIToSuyUPXJIhU8yCC40fmyCw1aPWByVY
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=6pMMVVDDReSiRgPCbMOUauN5nS3ty4Sf5b7a2gi4x0M=

Add support for s2dos05 display / touchscreen PMIC

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
 .../boot/dts/qcom/sdm845-samsung-starqltechn.dts   | 77 ++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
index 865253d8f0c7..5e5684f84ffb 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
@@ -39,6 +39,9 @@ framebuffer: framebuffer@9d400000 {
 			height = <2960>;
 			stride = <(1440 * 4)>;
 			format = "a8r8g8b8";
+			vci-supply = <&s2dos05_ldo4>;
+			vddr-supply = <&s2dos05_buck1>;
+			vdd3-supply = <&s2dos05_ldo1>;
 		};
 	};
 
@@ -101,6 +104,66 @@ key-wink {
 		};
 	};
 
+	i2c21 {
+		compatible = "i2c-gpio";
+		sda-gpios = <&tlmm 127 GPIO_ACTIVE_HIGH>;
+		scl-gpios = <&tlmm 128 GPIO_ACTIVE_HIGH>;
+		i2c-gpio,delay-us = <2>;
+		pinctrl-0 = <&i2c21_sda_state &i2c21_scl_state>;
+		pinctrl-names = "default";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pmic@60 {
+			compatible = "samsung,s2dos05";
+			reg = <0x60>;
+
+			regulators {
+				s2dos05_ldo1: ldo1 {
+					regulator-active-discharge = <1>;
+					regulator-enable-ramp-delay = <12000>;
+					regulator-min-microvolt = <1500000>;
+					regulator-max-microvolt = <2000000>;
+					regulator-name = "s2dos05-ldo1";
+				};
+
+				s2dos05_ldo2: ldo2 {
+					regulator-active-discharge = <1>;
+					regulator-boot-on;
+					regulator-enable-ramp-delay = <12000>;
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-name = "s2dos05-ldo2";
+				};
+
+				s2dos05_ldo3: ldo3 {
+					regulator-active-discharge = <1>;
+					regulator-boot-on;
+					regulator-enable-ramp-delay = <12000>;
+					regulator-min-microvolt = <3000000>;
+					regulator-max-microvolt = <3000000>;
+					regulator-name = "s2dos05-ldo3";
+				};
+
+				s2dos05_ldo4: ldo4 {
+					regulator-active-discharge = <1>;
+					regulator-enable-ramp-delay = <12000>;
+					regulator-min-microvolt = <2700000>;
+					regulator-max-microvolt = <3775000>;
+					regulator-name = "s2dos05-ldo4";
+				};
+
+				s2dos05_buck1: buck1 {
+					regulator-active-discharge = <1>;
+					regulator-enable-ramp-delay = <12000>;
+					regulator-min-microvolt = <850000>;
+					regulator-max-microvolt = <2100000>;
+					regulator-name = "s2dos05-buck1";
+				};
+			};
+		};
+	};
+
 	vib_regulator: gpio-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "haptic";
@@ -588,4 +651,18 @@ motor_pwm_suspend_state: motor-pwm-suspend-state {
 		bias-disable;
 		output-low;
 	};
+
+	i2c21_sda_state: i2c21-sda-state {
+		pins = "gpio127";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	i2c21_scl_state: i2c21-scl-state {
+		pins = "gpio128";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
 };

-- 
2.39.2


