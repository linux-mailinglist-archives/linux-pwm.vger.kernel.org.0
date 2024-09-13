Return-Path: <linux-pwm+bounces-3249-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 729E6978407
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Sep 2024 17:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFC541F21F56
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Sep 2024 15:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B05614F9D6;
	Fri, 13 Sep 2024 15:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwKb5S0s"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C25814AD19;
	Fri, 13 Sep 2024 15:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726240140; cv=none; b=EK0Jru3vu/6oe7z3mWgWxRt94VERLT4tXijtxyUgj5Enz4HmQQbxhaGpU/h0gSCgQvaT2YuBZV/mb2EAMCl85MTku/qrELCrFeuRG4Rf0UqaLS9GtRB1TWpiyqS2onS+2qYgB5hA4Sc5ZbU/PinQNsQCMI7ftz/1Us3P1zt2m9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726240140; c=relaxed/simple;
	bh=TWhbLRHfFDz9yA9edxLZxAOMPF84aLyauDMExbKBA/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dvEnScjPRju4jbfimP3Ifl7+KWG2rzNCXMptYYROAx2FKfpPSRAPjQGWHTEgBUEavAnqhqo9UpQ/IAZ93R72aSNGoTM3cu18oUG0Hykbz5VXvvOkGJ1d7nQiAq7rdO0UEcm9riLjva2ZJpRMINYP3kNR7HUt1uCBoBGB8J7p7cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VwKb5S0s; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c260b19f71so2564021a12.1;
        Fri, 13 Sep 2024 08:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726240136; x=1726844936; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xTfratRyuq67AZV4B16yqUQQ15TZWLuOZUKKSVeMFLU=;
        b=VwKb5S0sg8EPgw2IdY3AbDiNsIs1G7JRhM+jic0c7aMiTNDk426V16NQxsOnOALbb9
         P7vQXIgT8z0URbHxppx4OEKgD23872xncgQKsqj1DLekQJ2WdqB4zTlywxfU6qsAx8DP
         3qNG6LlzDTJL9HY5//Muhre3aWm9h5YIW43r/JsODQ8nBL6CX1eMrPtiG/XeEHnmFeLG
         x/Yj6ZclrChct1a4teW2lNAhxXHJ7OHrBt+aHlGWA/feOuHYwfyDF99Yqqmgp846Y63y
         WQnL/lJWKuPuvjdxcVZTkkP2LO4VYwDpnmpY+H7NwNc9793dKCoLjTZFmN1nO2LZfLzF
         PGJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726240136; x=1726844936;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xTfratRyuq67AZV4B16yqUQQ15TZWLuOZUKKSVeMFLU=;
        b=mKu9+FQvCGAF06ZUS+/VtdGG7Ujjk/i35BN7Id7vnO9/LCB7l6osPaUsnCEEFwJK2l
         aDjA++tP0zvtEAhOIX5CCvIIlfUL6Ye4dC1upD8Xq2RqH6YbgLBWo9oXBkFSIztQ/zJ2
         YnDl8N75WVdAE46YZZ5fq5lfsN/6uEFhP0cIj93IX++6hijGtrevETh8blaQJkBtjXq+
         oVVR9I/X6dbdc8ILQfgWhehRW9W4NSF9U0CHqDnVGK6ltLEqXig6ZocjKeodsPRqRUJF
         wxI7dh3WOy2l4AYagF+yCdmhvpZDYzzs9v/m2LirjFvkEjAawKtZMp4Wfmyjyy3eWmkR
         FV2w==
X-Forwarded-Encrypted: i=1; AJvYcCUNNtkyybN/K7yvJa6MNt24ldpdZhnbk+Ds/QNdmsELQa54zQY43JZQYVsK9p5DjnTYJbAs3Q4niWOY@vger.kernel.org, AJvYcCUpjOhNvBnzrlH4LRRU9n3n6zOXg6E/9RfhAaQeBw0KogpL64sPi0tF+/WiN5cDyEWUl4QenSGsPKmH@vger.kernel.org, AJvYcCUs57XXzB0+8bGOIHS8tHn1GfhEGy66XqHufRtI0iJ1P1CifP2BakY85q1zSNkhvKDOhaRNDBECRTAU0sMEcHr+nno=@vger.kernel.org, AJvYcCVIwzsiiOW8VXN4ZjRJzCMmy6Ha4I7JkRPVM2WOPGdrh8twZ3T+JZHGpYtbrP9hO8iUF+hYfzepRedYVdA=@vger.kernel.org, AJvYcCVQ5AQnqCv142+SKO3TR9ByFDUVeVzL10Pjbkgq/S1ZuOUnIBzLlNAmXK89Wmp3KZUVL8G8BHIj3CiAqA==@vger.kernel.org, AJvYcCVRlYnBB0dfo/WnPIJwulREYGydQtW+9B6nYZN2hAH8svfzIjgoTRvJUFG6pf54RC6Yj/AFlkX6dJbbtco7zQ==@vger.kernel.org, AJvYcCVmjGVFSzSfFbtiEy8KHmTo4OJRgP6LkwSmkFZmsR6tNt975ol+BVBkinkp0h+DSN6bjvtjAirdaai9@vger.kernel.org, AJvYcCXrHEaeCg6P9+rWcTlQniraVcPULyd9opNTAPKC1uQJ0JM5qdLX/VBotdRcBNoQsG1J5nDhsJ+mSNn/j+Ce@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc6Pjm57QZRD94ZTjp6J9bCYx3wo4f/TXxI2hdDi0I27waCJgR
	xROidBQ4Cp5R4ItMFmL4OsA6strLyRJMHV8z7Z16Uqiac3TCfbbZTRY6wg==
X-Google-Smtp-Source: AGHT+IGnH2Qg/ZVH+t5yBK8/6cZxMgcc2yO30j7Z0MVpdCvW68EAVdYqOzZsoNLDjONJTNNxLjdrhA==
X-Received: by 2002:a05:6402:2750:b0:5c2:60ac:fdd8 with SMTP id 4fb4d7f45d1cf-5c413e12321mr4607671a12.13.1726240136234;
        Fri, 13 Sep 2024 08:08:56 -0700 (PDT)
Received: from [127.0.1.1] ([178.127.153.210])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd523b4sm7774318a12.51.2024.09.13.08.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 08:08:54 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Fri, 13 Sep 2024 18:07:59 +0300
Subject: [PATCH v4 16/27] arm64: dts: qcom: sdm845: enable gmu
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-starqltechn_integration_upstream-v4-16-2d2efd5c5877@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726240085; l=4473;
 i=dsankouski@gmail.com; s=20240618; h=from:subject:message-id;
 bh=TWhbLRHfFDz9yA9edxLZxAOMPF84aLyauDMExbKBA/I=;
 b=C8aX8Dj2cCP4OKpYbwpqDfK4kLs39w/QmL2hpGyOr0fraXfQ9aXJ94InXPuEDu9NQVEQ39bkD
 CPgTNAmlnHfDz8Bvo5lvW1khQtDQLpt6K0HMdk/rsv/kbU+YSvoYKZJ
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=6pMMVVDDReSiRgPCbMOUauN5nS3ty4Sf5b7a2gi4x0M=

Leave gmu enabled, because it's only probed when
GPU is.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi                   | 4 ----
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts                   | 4 ----
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts                      | 4 ----
 arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi          | 4 ----
 arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts            | 4 ----
 arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi        | 4 ----
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi | 4 ----
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts           | 4 ----
 arch/arm64/boot/dts/qcom/sdm845.dtsi                         | 2 --
 9 files changed, 34 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
index e8276db9eabb..a5149a384167 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
@@ -741,10 +741,6 @@ touchscreen@10 {
 	};
 };
 
-&gmu {
-	status = "okay";
-};
-
 &gpu {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index 9a6d3d0c0ee4..59cb6e6e434c 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -444,10 +444,6 @@ &gcc {
 			   <GCC_LPASS_SWAY_CLK>;
 };
 
-&gmu {
-	status = "okay";
-};
-
 &gpi_dma0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
index 2391f842c903..d31efad8a321 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
@@ -414,10 +414,6 @@ &gcc {
 			   <GCC_LPASS_SWAY_CLK>;
 };
 
-&gmu {
-	status = "okay";
-};
-
 &gpu {
 	status = "okay";
 
diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
index 46e25c53829a..8a0f154bffc3 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
@@ -345,10 +345,6 @@ &gcc {
 				<GCC_LPASS_SWAY_CLK>;
 };
 
-&gmu {
-	status = "okay";
-};
-
 &gpu {
 	status = "okay";
 
diff --git a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
index 486ce175e6bc..87fc4021e024 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
@@ -419,10 +419,6 @@ &gcc {
 			   <GCC_LPASS_SWAY_CLK>;
 };
 
-&gmu {
-	status = "okay";
-};
-
 &gpu {
 	status = "okay";
 
diff --git a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
index b02a1dc5fecd..a3a304e1ac87 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
@@ -415,10 +415,6 @@ &gcc {
 			<GCC_LPASS_SWAY_CLK>;
 };
 
-&gmu {
-	status = "okay";
-};
-
 &gpi_dma0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
index 617b17b2d7d9..f790eb73abdd 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
@@ -239,10 +239,6 @@ &gcc {
 			   <GCC_LPASS_SWAY_CLK>;
 };
 
-&gmu {
-	status = "okay";
-};
-
 &gpu {
 	status = "okay";
 
diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
index e386b504e978..501575c9beda 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
@@ -381,10 +381,6 @@ &gcc {
 				<GCC_LPASS_SWAY_CLK>;
 };
 
-&gmu {
-	status = "okay";
-};
-
 &gpi_dma0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 54077549b9da..fe154216f138 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -4948,8 +4948,6 @@ gmu: gmu@506a000 {
 
 			operating-points-v2 = <&gmu_opp_table>;
 
-			status = "disabled";
-
 			gmu_opp_table: opp-table {
 				compatible = "operating-points-v2";
 

-- 
2.39.2


