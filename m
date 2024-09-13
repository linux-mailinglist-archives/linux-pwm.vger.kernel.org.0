Return-Path: <linux-pwm+bounces-3257-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F53978468
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Sep 2024 17:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3659B1C225EC
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Sep 2024 15:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7051BDAA2;
	Fri, 13 Sep 2024 15:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fg962xSf"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4E11B1D50;
	Fri, 13 Sep 2024 15:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726240165; cv=none; b=Joo1/oOIPTlwmSnNslkWtltSAKGUd7Yt8CqVX2Eta36endPg10F8eGDvva2jSccHeUYDxOjnrVQF3HMrNPNm8qaJgdXwLWQjFBcSNDi8JNERqQ9DBdvA0zOcOXcV08xfV9VWLNpf2mKELuvX2hRGsSxZ0JOCqcC04GB94mtcCdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726240165; c=relaxed/simple;
	bh=xfKPhhSb2zcxmRcgX3kYwVV6/9Weh+gAoxLXODpNqZE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P6IvMbwCqLug6I4bbZjkJaz31F2AD7uB1BE51pwaNizV9529r2jR7TlL83QM0oJGpSFmm3xm5kK1xNHRMTWb/f+L7uyI8paWRqRx1yIdeUXgLoj63s5hQuTCyrvnU2s4593Qp1Iy7JP+/z0QYk0tWxZV18mVqdN+Q+54ob8vb14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fg962xSf; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f75b13c2a8so27627591fa.3;
        Fri, 13 Sep 2024 08:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726240162; x=1726844962; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5paN3POim0M1V5oFYfgmQMIz7bvdUVefYvSK6m+fUeE=;
        b=fg962xSfNSZE0Qiw7gzVgIUxBUS3IxTEE7hOv35wt7vHvEFPeOu4sY4Z8ZAoHv5eFl
         pwC2hUKikZz1/aY2f4HSEdIIhgvpqUjHxVlxTGyrmMxITVF2xY7EwkStFS51DN1l3QHX
         QvvBXRk0ywJEmxku1hA7L0XdWYql6uZo5DKLYoRSlKpn7txhscdOQ0UtD16r7+ZCSO8/
         eNoa1wQ8+bco2aURBrgBTre2//LhZvCSpTbteszFFXiAGkSNA9W3OGxX7KXieVc+bkff
         5K80Yp5Jzx8vyoOgZNo8IsVIv08/iHdBHxFbXEJtdqFXyQvJFAsv/nAcFgQ/FpHWw2Ab
         e2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726240162; x=1726844962;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5paN3POim0M1V5oFYfgmQMIz7bvdUVefYvSK6m+fUeE=;
        b=X80ELLrIt2mHF8Dk1tn3pSzGZyMseOETqVI+l+DhBGZZzGwLa+pM31clnQI2Y4l1pA
         NCnpnwgfnW5I1CnKdYSASlvANd017f0D+PC5NKYRFYVELT/zL1dcuAYascKtfu1Opsuw
         3zBBHGjA4xzsEzquoQb7KIkDugPtjHw9j/KNPgrAg2lRhlk0SzIQWcT+6sPEMu+s8qCu
         04l0dh1O4B5PYPMpL9K9CJ++tzXcUt2+99l4dn+g/wEnus4/VY9JsekbOas6MRePlyYf
         VK9kkCOK0tCeq0jQV662BzxpgDdsHkE3uwX38/9ZujC1tlZ1kYDBpPy5xnkDgdbsNwaj
         NFUg==
X-Forwarded-Encrypted: i=1; AJvYcCU0fbQtoxK99HpmwKAoHbLbpEifi/0PJZXUSlYbwPP60o0pyUmB7Hs9XdJFUOmxr41V8sCj4ZqfG4Dec3E=@vger.kernel.org, AJvYcCUOWh42+pbfGnNo2t/9nnyHsbBHH+7UF/gXhN612HEt/iFb0cBNWSBmkVppAuzzUpJCew3R4L4pwoeIWS1SIZC0XGg=@vger.kernel.org, AJvYcCUdFWa5gkjdVq8AsPj7lD1jId6YUm2G2yLx4pMnDqgtQUuaPjOeJaqcopbgUiFX81kdsuT+rZIaUpTu@vger.kernel.org, AJvYcCUmvjNBDJa6LBiz0Ywe3f6lQULmC4gyUUHYaQrnR30KDU38nuCaTlKCfegLE1FrmNKLs8ybEgB04gy3@vger.kernel.org, AJvYcCVKW2Oakw5+LopAiPTrOUbkr6Ns9gqiAVOZatuUpBEiYTYQeUL6oac3drPNcS6i3EMcHRE2Co3exYU0@vger.kernel.org, AJvYcCVeSHo9N96vXRyIh3IyWZnS94fc/W4WNmrpNXdnd4S693qAI5HYmqbMefNURXtgKFsptCFLI5ZVM+OqLfvWPA==@vger.kernel.org, AJvYcCW9pyfOfvwsZRq9xIQjj1vkWOk0ur8FR4QAVf9OVqVVU3hn9fLlRPOpDXjJZZ2PObzHTctby6ToAgSRU8B8@vger.kernel.org, AJvYcCWL602P9TcOl6F+E842LD6vLNJ/xP7OxfMFMdW35nJLX2Id87Iyjz/1zKGrqp4SBhvpY6BBGU1Dh0l/Uw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6MKz+2p16q+DqkaQTpLPXwz036LqznAKHWUqSzLCAUOgmzHs9
	sHZDzvbRItZGMGBB/Q2fwWzRyFVZ8cvhFjwzHP95Qz2GodMihF+3ZlOAag==
X-Google-Smtp-Source: AGHT+IGOa3rG2/U+LVdvy0rfhL8MzbuMFEt4AJuYsIVlKUh9YYYMrgSmSQIgbFNhJgxCiHNrBCkT4Q==
X-Received: by 2002:a2e:809:0:b0:2f7:4d86:5dcf with SMTP id 38308e7fff4ca-2f787f1db54mr34021521fa.35.1726240161793;
        Fri, 13 Sep 2024 08:09:21 -0700 (PDT)
Received: from [127.0.1.1] ([178.127.153.210])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd523b4sm7774318a12.51.2024.09.13.08.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 08:09:20 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Fri, 13 Sep 2024 18:08:07 +0300
Subject: [PATCH v4 24/27] arm64: dts: qcom: starqltechn: add touchscreen
 support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-starqltechn_integration_upstream-v4-24-2d2efd5c5877@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726240085; l=1297;
 i=dsankouski@gmail.com; s=20240618; h=from:subject:message-id;
 bh=xfKPhhSb2zcxmRcgX3kYwVV6/9Weh+gAoxLXODpNqZE=;
 b=H2ABvb3Og7GioCBEnHoqR/zTsCMYCQ09poncV3dRTaltzSUC0uKIPjDC3H7LVXWeM8uWAM2bD
 0/ZP2Q0zlJTASO7xLc4jt1qAZKXbOeEDf61wB1fLvdGeXfm2757FbeD
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=6pMMVVDDReSiRgPCbMOUauN5nS3ty4Sf5b7a2gi4x0M=

Add support for samsung,s6sy761 touchscreen.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
 .../boot/dts/qcom/sdm845-samsung-starqltechn.dts   | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
index 5e5684f84ffb..37433ef74502 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
@@ -561,6 +561,23 @@ &sdhc_2 {
 	status = "okay";
 };
 
+&i2c11 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	touchscreen@48 {
+		compatible = "samsung,s6sy761";
+		reg = <0x48>;
+		interrupt-parent = <&tlmm>;
+		interrupts = <120 IRQ_TYPE_LEVEL_HIGH>;
+		vdd-supply = <&s2dos05_ldo2>;
+		avdd-supply = <&s2dos05_ldo3>;
+
+		pinctrl-0 = <&touch_irq_state>;
+		pinctrl-names = "default";
+	};
+};
+
 &usb_1 {
 	status = "okay";
 };
@@ -665,4 +682,15 @@ i2c21_scl_state: i2c21-scl-state {
 		drive-strength = <2>;
 		bias-disable;
 	};
+
+	touch_irq_state: touch-irq-state {
+		pins = "gpio120";
+		function = "gpio";
+		bias-disable;
+	};
+};
+
+&qup_i2c11_default {
+	drive-strength = <2>;
+	bias-disable;
 };

-- 
2.39.2


