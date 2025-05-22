Return-Path: <linux-pwm+bounces-6092-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C151BAC0EC3
	for <lists+linux-pwm@lfdr.de>; Thu, 22 May 2025 16:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E37F1C00678
	for <lists+linux-pwm@lfdr.de>; Thu, 22 May 2025 14:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AB828DB70;
	Thu, 22 May 2025 14:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZYbMvnLo"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B46F28DB63
	for <linux-pwm@vger.kernel.org>; Thu, 22 May 2025 14:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747925420; cv=none; b=udi1jx2ngC+6PtCyOXzUnk0LMBSK2Syv7x/2LZ1q2IyN7OrxSdCdm6U3YySUI2arFya3mokzOgJDx7wgPascEIUHQRZ1GHql/nM0WdEkHvnt/0tPQvUikCoHZOb6I2zm9icWzcHfT64N5SmJtqNB5wEbZOb7U7mH84z9W+ODsf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747925420; c=relaxed/simple;
	bh=YwtMVRRf8kJ22avchfvJG+KxJpfzNSQSnpIwmkk1p0g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HLu8N3HkSc6sGVzN1Tec2dDzpjoLfboADHsgwQUOmCiAQ450LPpbmBOANbkWT/PAgScTZT4J/uJLpufYJQmbY8Kcagbt6DrxmI6fOonNcegHa+9kM848Ont5Qdx3mnJKACEWQPdkR+QMoJlAFA4bW+QDbHM72otoHijqKHUSAew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ZYbMvnLo; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3f6eaa017d0so6882252b6e.0
        for <linux-pwm@vger.kernel.org>; Thu, 22 May 2025 07:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1747925418; x=1748530218; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kIM5NpqKSxCNfb1OJCfsBv7sQidggBRQu0Cr/nYznV0=;
        b=ZYbMvnLoGRJvujVeDt41XYMAnhMs0yoFsyfpoz6iHGSkYkDMnnIYhBqMt+Ml+tHU2/
         wm4s38RXivY2T8fTtBUPbbn1+DzYNtOko436Uh/ODtGC3CfEaYuo+U/Le5n3WLJiyWq4
         4tBt0IlrE+nlcQpy4cc+EkNp1CEdS3SgTbLx204bwayLHFZWccKLTLHPi2o1XBYBc9sg
         f03ukE5xcOQaBvBFe/MT3bSD95LRaKHGvrqAXtOMpBNAbyO8cVN9NOCA8eR8e36q2zX3
         RNG8smXuG1AUMPTZTeHDbYQrSlCu0YD247RJ4++7mmT3TQZNo94c4YCCoGfo9UatgUs5
         DQow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747925418; x=1748530218;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kIM5NpqKSxCNfb1OJCfsBv7sQidggBRQu0Cr/nYznV0=;
        b=v1gg4k5CandnYI61mFnxmfv9l5xReDOSnl+1oxeWvpDHYkbn/HA1kYQsl9ZY2iVeIW
         4zTYnAmtdOCg0JRxFty0W3S+YqGcJ/2W9RQWh+bEM0TNR88end6ADzPb4LA1KdZueRCq
         XO1w6OST1sUetb1i941kwGAbD/A0D+Z1FQw/T/z5vqKVyB3NEVOy1DjPsyLitfO6BFFw
         EDqBusLu9f9lIoQHfxqRXl3k4V1qf8k27O647/C26Wyg9yivPnJMusnbgQ1/WE+oKIha
         G/GbhXNezgpiErHu3Nxw+5vagV9Bw3t8mwqsLHl8D/3rIr5c+La8huEf1RO1GsgrE0jM
         BfoQ==
X-Gm-Message-State: AOJu0YyoNILWVVDIWlBGdoaDH76JLpHZORYkPfsWuTYp8YV1eUPYAGFi
	1a5pQOxkRhC09v8IZGsIzsprPm20xpU1P8daRLTPNnfLriPZoq9Ge6O2dU4URoRA95c=
X-Gm-Gg: ASbGncsJOV687XxacspxLYFrpmaWqN9aDK6ggdbOu9vNgEdAFgBO1gJtyeZDlWY/JaB
	xZP6ISXUxKJFuSDNvNKoCP2UqBxvD/mFC9mR8PSkdivbJkMddUl3ts5qca+MU6MdlDXqgxAgzt2
	FBgZPyh62FPlQlnJJI7D8xRxDiF6symQzdQbi23u4bZwjiSv3vuVupf7VxWdpcETzNfUy3o/jpu
	HQLKoBB9NHBEsM1BdeQy7ocPckHCq5YKg+bl+uSh4CBO5yNhBS1OJ+TXRsVtAzetGtUPqmVTnMv
	RsuxSDtpcaIxKy8PYv54vF87Ly0l0bqlvSRILU/N8npHMCvqYH5jd39G9fIpecj7R1vp
X-Google-Smtp-Source: AGHT+IEbvoqk7gJskuQpvUR7QPX/lNdeeNBLSgIuD9wBT+/ZZsxHmlbQkeu0Re4A25CoUWD1p6efEQ==
X-Received: by 2002:a05:6808:83c8:b0:3fe:ab15:5ed6 with SMTP id 5614622812f47-404d86d8c97mr11952293b6e.12.1747925418083;
        Thu, 22 May 2025 07:50:18 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:3407:53d5:68cd:400d])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-404e303ffcasm2228234b6e.4.2025.05.22.07.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 07:50:16 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 22 May 2025 09:49:40 -0500
Subject: [PATCH v2 2/3] dt-bindings: pwm: adi,axi-pwmgen: fix clocks
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250522-pwm-axi-pwmgen-add-external-clock-v2-2-086ea9e6ecf0@baylibre.com>
References: <20250522-pwm-axi-pwmgen-add-external-clock-v2-0-086ea9e6ecf0@baylibre.com>
In-Reply-To: <20250522-pwm-axi-pwmgen-add-external-clock-v2-0-086ea9e6ecf0@baylibre.com>
To: Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Trevor Gamblin <tgamblin@baylibre.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1883; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=YwtMVRRf8kJ22avchfvJG+KxJpfzNSQSnpIwmkk1p0g=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoLzmTqUb9mqfNnT61fY09rAc1PxMF6lBQxA+kH
 p4Fj56HLPyJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaC85kwAKCRDCzCAB/wGP
 wDf4B/9JaAIz5MAT5pRx8xZXPYOs+PS3M+7aiZkLW/+RHoq7LJzMFkrItZfC2ZM/lxF+lyAYFh7
 DU/RaWpha8k258skVDF4khovXUftuUzWmWcyQniitsRl1bHaUEYQknZBTRlnwPTNhZcCdbhEJuy
 Xkm/qR9Cyj7UDxyaOJumoRFTkoZB87K8bLYzswQuMPhSzsJ4u+z/QxdYCdl6XaR7mkFEFYclfWq
 /+90/4iSQ94DYD6gD6Xf3n507tqmU9GyO5eaTYPFUkeuf3aXQ9+oupM71vF3jnYjzZbp4GvkART
 lmJZYmDxIfrj+GRPF7bE/keYCx2xtEVZ3mVq2Xk4djAXBEHQ
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Fix a shortcoming in the bindings that doesn't allow for a separate
external clock.

The AXI PWMGEN IP block has a compile option ASYNC_CLK_EN that allows
the use of an external clock for the PWM output separate from the AXI
clock that runs the peripheral.

This was missed in the original bindings and so users were writing dts
files where the one and only clock specified would be the external
clock, if there was one, incorrectly missing the separate AXI clock.

The correct bindings are that the AXI clock is always required and the
external clock is optional (must be given only when HDL compile option
ASYNC_CLK_EN=1).

Fixes: 1edf2c2a2841 ("dt-bindings: pwm: Add AXI PWM generator")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml b/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
index bc44381692054f647a160a6573dae4cff2ee3f31..887185ba89daf6eb18ffa2cba164ba546bfbcf2c 100644
--- a/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
+++ b/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
@@ -30,11 +30,20 @@ properties:
     const: 3
 
   clocks:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    enum:
+      - const: axi
+      - items:
+        - const: axi
+        - const: ext
 
 required:
   - reg
   - clocks
+  - clock-names
 
 unevaluatedProperties: false
 
@@ -43,6 +52,7 @@ examples:
     pwm@44b00000 {
         compatible = "adi,axi-pwmgen-2.00.a";
         reg = <0x44b00000 0x1000>;
-        clocks = <&spi_clk>;
+        clocks = <&fpga_clk>, <&spi_clk>;
+        clock-names = "axi", "ext";
         #pwm-cells = <3>;
     };

-- 
2.43.0


