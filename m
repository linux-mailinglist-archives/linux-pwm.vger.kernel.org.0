Return-Path: <linux-pwm+bounces-3259-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7E297847E
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Sep 2024 17:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59E55B24E82
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Sep 2024 15:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D15B1C4612;
	Fri, 13 Sep 2024 15:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isRo4JYf"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF6D1C3F22;
	Fri, 13 Sep 2024 15:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726240173; cv=none; b=Q5SO4RSrA8rIJcs8O/ZF9e3Z3HjrkiHWkXYsViAHBbDUV8S5AO6fvOT0N/3I3Q+K+XuT3iTNw9OoYDbP5qtpyb/vrb3v+96h99V/keA8p2LBL/AyqkMu/0cHzdkNazu14nMVmfEMXhqlGnJv+2nC/e2soDfQwAh6aPmj9FFP3+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726240173; c=relaxed/simple;
	bh=FD1rljMeLn+151Vf5vciVGrZi3usPsZLEWnoi/tRPhI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V0FXiuJWIxtZzhoTRh+KDBWeNq+VGPFQMpCfsN0ACkg6YA9ALi2+1lLEJCSs6IcPfDwydX+EryBGdr4oaKuGT9VPBNZcZc1wuE6vPnMmSL4ge/s3ShPnQm65P4GSsEbWGyOdJ4+TF5qKowWz+DznMEJKtkgRvkUZsf/Tb4lx5pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=isRo4JYf; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f74e468aa8so25739691fa.1;
        Fri, 13 Sep 2024 08:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726240169; x=1726844969; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6fGinMsoxJHH1gDGhStsupCS0lT0j7DlavjBxipyt/0=;
        b=isRo4JYfkvVPMpm7R9RtjTzvFxvp65hC3x06NJAAuvKCv8BzWWqMMzYnc8icitUGTj
         KpebMqYwvjNzJhbfAMxeiS0UWN0aC8SCopah4S3nMAB8kotHWKXf2TBrz99Jz6oZVF6x
         cNAPx3Ru/vhDegUiNqvCfU0OYJ/go5Vshi2UDxsdxDnbexjFvlx/ZRkSXRxkiZsYbUP5
         fC4oJ2vX6s6qtCKTEnDWSYFa6Q8WJWebhIzq4eBifSbPPTKFlt/FzIPg1fuFb7uEedap
         ZFv6teza7YFvDG3OoSTylt8y52beq2G1dNhm5wAvmtkFLXBSnRRCMaGZXbpLIt4ZR4Bb
         6zqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726240169; x=1726844969;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6fGinMsoxJHH1gDGhStsupCS0lT0j7DlavjBxipyt/0=;
        b=dH3HjwpSi9w+6P4VbklghJV7rio7GxsF+itt47+mEBXT8gLhbBcG5q1GrOY612B7QY
         ceYruVRHT/wMa0aOAqgFNIRXpdVqfZ34WErOwpghMm59JNd2C93To6S1UnS66YQ+0IpL
         Z6LX9Ij+4H+fR0SxMzEbH1mNGgh0yRUDsJ9JTmc2RIGWXB8PdhrdWsL4Sem6L4qqyl1X
         EwKfdQqhA2+B1OqPsmLAws6JJhHPusDxLybASo2C1hg743vTG5tkUZacT4/BiXHtUply
         7wD3pdpIbY/ssb7KeI8uGbbc39xZrk/YCjhPkcJN3r5GEzzCZ4kMQm4lf7lI7rXLYFf3
         ifNw==
X-Forwarded-Encrypted: i=1; AJvYcCUoFT7/0XHYoewnfCphN1hjjC3OlN/wSlaIsYQAu0IEpE/OhgexXcIpfBNx98dDsllTCSohZ3QIuUnLefSqUg==@vger.kernel.org, AJvYcCUta9DiBumsJrt605wTpG2WZuKNT0mWQWgI0lHL4zUa6vlKJdqPtAd22V9SzsJEkNNb8HFDDnXiWl/JvwSdasSMClo=@vger.kernel.org, AJvYcCVGkHKnxxSkLoocxVxBM62KWlNgQeQ5vE6Cv01bof4Jh0jkXRAl+q5cmtnd+S03CDtGp0b7aRYzLuVIQA==@vger.kernel.org, AJvYcCVa+rl8eny9MvzX5nkpIEGinMEe6AJGFXp6uVth2pZy/+nsRLDkqYOeSpey1MhX3RppX25+s+4Gji8d@vger.kernel.org, AJvYcCW2LuE+L7rnloJejKhpItDn8xUfD9d3ovCCfAdqo6n9U+W0Lp5EMCqjxzJo3ZXfbQWLSAxq5q/2rKVw@vger.kernel.org, AJvYcCWVQzJxbfF9/Vp6+MUo2oXwg/XBRPwhz0czqCne+1RQuYo4DjrK/HQb59fXe6okalRW+slcIa0uur0EKjE=@vger.kernel.org, AJvYcCWZUgxYNFBLf3VBXBhS+eIiHM8URGcq/Gyuu1RK1BjB6faQ7lYaM00rFt8CO79HssbiELgO3RNjB65z@vger.kernel.org, AJvYcCWk0boblkX6LZM0UhQ4zlWOW/YCCj4DUJhxqyQjC49ON+l9WAWPb5g4jpnFTMVWX3gYwgakTipRzN3iM7wE@vger.kernel.org
X-Gm-Message-State: AOJu0YybpkdblEVpHNfVDwUWlZrs1QxFa5SEYHhk/eAWrYLf/O4Z61RH
	lS2Qa3RPYXvZ1PY7v9v7g1DKWm1CpxZDR3HYjbwXM9ngbx3xx4CRdqz/4A==
X-Google-Smtp-Source: AGHT+IEsMkvGt7hLQi684Ay30ID1FMFVFevU1MTlJ0EnA8fvjeecyqBnmmmCk6jlChOFsa541LWk0g==
X-Received: by 2002:a2e:859:0:b0:2f3:abca:8b0f with SMTP id 38308e7fff4ca-2f787ee1f49mr29803711fa.27.1726240169009;
        Fri, 13 Sep 2024 08:09:29 -0700 (PDT)
Received: from [127.0.1.1] ([178.127.153.210])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd523b4sm7774318a12.51.2024.09.13.08.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 08:09:28 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Fri, 13 Sep 2024 18:08:09 +0300
Subject: [PATCH v4 26/27] arm64: dts: qcom: starqltechn: add graphics
 support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-starqltechn_integration_upstream-v4-26-2d2efd5c5877@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726240085; l=2196;
 i=dsankouski@gmail.com; s=20240618; h=from:subject:message-id;
 bh=FD1rljMeLn+151Vf5vciVGrZi3usPsZLEWnoi/tRPhI=;
 b=6C6CK/OA4qFYIxjuSjl3Jh3cGdMnGDl0PerNpUvETcvNDy9pXgL6GQGnrjeslJjmw0qV9V0Pz
 Phboy8dYDhEAvBqR7ufbk5QySAlCyzNfS4+gxeOVOYJOt+qRz7QJwzA
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=6pMMVVDDReSiRgPCbMOUauN5nS3ty4Sf5b7a2gi4x0M=

Add support for gpu and panel.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
 .../boot/dts/qcom/sdm845-samsung-starqltechn.dts   | 67 ++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
index c36ad043edf0..2710386a89e1 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
@@ -203,6 +203,52 @@ vib_pwm: pwm {
 	};
 };
 
+&gpu {
+	status = "okay";
+
+	zap-shader {
+		memory-region = <&gpu_mem>;
+		firmware-name = "qcom/sdm845/starqltechn/a630_zap.mbn";
+	};
+};
+
+&mdss {
+	status = "okay";
+};
+
+&mdss_dsi0 {
+	vdda-supply = <&vreg_l26a_1p2>;
+	status = "okay";
+
+	panel@0 {
+		compatible = "samsung,s6e3ha8";
+		reg = <0>;
+		vci-supply = <&s2dos05_ldo4>;
+		vddr-supply = <&s2dos05_buck1>;
+		vdd3-supply = <&s2dos05_ldo1>;
+		te-gpios = <&tlmm 10 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&tlmm 6 GPIO_ACTIVE_HIGH>;
+		pinctrl-0 = <&sde_dsi_default &sde_te>;
+		pinctrl-1 = <&sde_dsi_suspend &sde_te>;
+		pinctrl-names = "default", "suspend";
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&mdss_dsi0_out>;
+			};
+		};
+	};
+};
+
+&mdss_dsi0_out {
+	data-lanes = <0 1 2 3>;
+	remote-endpoint = <&panel_in>;
+};
+
+&mdss_dsi0_phy {
+	vdds-supply = <&vdda_mipi_dsi0_pll>;
+	status = "okay";
+};
 
 &apps_rsc {
 	regulators-0 {
@@ -837,6 +883,27 @@ &tlmm {
 	gpio-reserved-ranges = <27 4>, /* SPI (eSE - embedded Secure Element) */
 			       <85 4>; /* SPI (fingerprint reader) */
 
+	sde_dsi_default: sde-dsi-default-state {
+		pins = "gpio6";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-disable;
+	};
+
+	sde_dsi_suspend: sde-dsi-suspend-state {
+		pins = "gpio6";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	sde_te: sde-te-state {
+		pins = "gpio10";
+		function = "mdp_vsync";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
 	sdc2_clk_state: sdc2-clk-state {
 		pins = "sdc2_clk";
 		bias-disable;

-- 
2.39.2


