Return-Path: <linux-pwm+bounces-289-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D15804DAA
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Dec 2023 10:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68FC9B20DF1
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Dec 2023 09:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2813E493;
	Tue,  5 Dec 2023 09:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zn3Iyeem"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75ED7196
	for <linux-pwm@vger.kernel.org>; Tue,  5 Dec 2023 01:22:48 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40c09b021daso25530195e9.0
        for <linux-pwm@vger.kernel.org>; Tue, 05 Dec 2023 01:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701768167; x=1702372967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDQvRMNMCDsySKsLvfWU4d3cyjxohNNvIIg/FZa633s=;
        b=Zn3IyeemD7sk0z64sIoJskAbnJSUM9NbCbfz/OOqIJN8Ff9wG2B+jrmvXDlySLsnJK
         NBDXbE073M4bybSdjtR9VR6t4aRhOjgPbOAGe/kyMxYOhTzRYsQ7kaDz0tfGJ5M7mknY
         /HsjVwYYQxTsfAANvZZ+GwyCWWDKVxlv76soGzBCG3M6SahyHDq1Eb3ru1LhCdN9KYhy
         14bKJl9Z98nNAZXCkctMFDm+zANgrGvtSx1lB+5JFcIL1lgRtOau9HhZ7ginREHq5NUK
         mu27Wo4MPpOED8BDYBDey0jbbloVnnb689jZv29WFZjE/mKcCB/Su1/+1/AWGqsDcVY+
         2NwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701768167; x=1702372967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KDQvRMNMCDsySKsLvfWU4d3cyjxohNNvIIg/FZa633s=;
        b=V+RlthGF9GcJGIhOrZ1AvdNhB2hfXGSN7Hm9gnNs5092FXicqLvnECVTA/m/g2dHIu
         OyX3oJ/aRKG0ATtDVoK72aeqcS08VkzDBK0ZimRXLqRoDFhFSV7lVRTZPjPrLVWA1GXT
         bALj2xox2JxQKVPeJBxxt0ci1irCodFZHivjfTabyE9oGgby1C3OZZe6ZnTEgTQZyT2b
         RAmEss0oSn1CCaf6AERbc2MFzMeu+Y/XtUg3+KtIDZ0RPMXMrZV0SQicxyrfDOH8K4jU
         laMr9UDJ5GrL4DcvC3xKOj3CNVzPsu5MPXbYC+ghC8pOfA6qSdSh3V+VivaaFNBhCspr
         GWNA==
X-Gm-Message-State: AOJu0Yy9r8OULyvLXwB5Sywi5uO8JeSQAa6dP7e68A3fEANtH3w/HDzT
	8QIJcC1NSUiW2V1qz70/BNvJLA==
X-Google-Smtp-Source: AGHT+IEzeGcT+5e2hM4rC9GBzraQmLLysONbGyiPU8Nzz9RHij9fek/9MzPiwPnfnBz/PliCUqdVmg==
X-Received: by 2002:a05:600c:21ce:b0:40b:acfb:5d04 with SMTP id x14-20020a05600c21ce00b0040bacfb5d04mr247995wmj.222.1701768167020;
        Tue, 05 Dec 2023 01:22:47 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id g10-20020a05600c4eca00b0040596352951sm21692287wmq.5.2023.12.05.01.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 01:22:46 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-fsd@tesla.com,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 5/6] dt-bindings: watchdog: samsung: add specific compatible for Tesla FSD
Date: Tue,  5 Dec 2023 10:22:28 +0100
Message-Id: <20231205092229.19135-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205092229.19135-1-krzysztof.kozlowski@linaro.org>
References: <20231205092229.19135-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tesla FSD is a derivative of Samsung Exynos SoC, thus just like the
others it reuses several devices from older designs.  Historically we
kept the old (block's) compatible only.  This works fine and there is no
bug here, however guidelines expressed in
Documentation/devicetree/bindings/writing-bindings.rst state that:
1. Compatibles should be specific.
2. We should add new compatibles in case of bugs or features.

Add Tesla FSD compatible specific to be used with an existing fallback.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

I propose to take the patch through Samsung SoC (me). See cover letter
for explanation.
---
 .../bindings/watchdog/samsung-wdt.yaml        | 21 ++++++++++++-------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml b/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml
index 8fb6656ba0c2..ea2d206b05ab 100644
--- a/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml
@@ -16,14 +16,19 @@ description: |+
 
 properties:
   compatible:
-    enum:
-      - samsung,s3c2410-wdt                   # for S3C2410
-      - samsung,s3c6410-wdt                   # for S3C6410, S5PV210 and Exynos4
-      - samsung,exynos5250-wdt                # for Exynos5250
-      - samsung,exynos5420-wdt                # for Exynos5420
-      - samsung,exynos7-wdt                   # for Exynos7
-      - samsung,exynos850-wdt                 # for Exynos850
-      - samsung,exynosautov9-wdt              # for Exynosautov9
+    oneOf:
+      - enum:
+          - samsung,s3c2410-wdt                   # for S3C2410
+          - samsung,s3c6410-wdt                   # for S3C6410, S5PV210 and Exynos4
+          - samsung,exynos5250-wdt                # for Exynos5250
+          - samsung,exynos5420-wdt                # for Exynos5420
+          - samsung,exynos7-wdt                   # for Exynos7
+          - samsung,exynos850-wdt                 # for Exynos850
+          - samsung,exynosautov9-wdt              # for Exynosautov9
+      - items:
+          - enum:
+              - tesla,fsd-wdt
+          - const: samsung,exynos7-wdt
 
   reg:
     maxItems: 1
-- 
2.34.1


