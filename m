Return-Path: <linux-pwm+bounces-286-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1279804D95
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Dec 2023 10:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 975C91F21368
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Dec 2023 09:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235803F8F1;
	Tue,  5 Dec 2023 09:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g0HxNWHl"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147F818E
	for <linux-pwm@vger.kernel.org>; Tue,  5 Dec 2023 01:22:42 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-33349b3f99aso1516763f8f.0
        for <linux-pwm@vger.kernel.org>; Tue, 05 Dec 2023 01:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701768160; x=1702372960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XqatM4kM7wKwmicGW+gEqjAkzatGSFvjDGMOBx55ZZQ=;
        b=g0HxNWHllGCPgVSvlHjmBBOVKuOhGsi3mnEC2ux9hWSPzA1cGSifernzpJz46lrinF
         YCAEPXnhEDFpJnfuLlXD/ErOCVViixO2Hya/f2NbReLz+L5nDoo0jywHTMdhSjFi9EV5
         /ZLGrlW7c8i1YoG3mwQGayfp+0hiOrzzNNrEkoWWj3nerZBbZHWBdpw3oCCHdqbEh2ew
         XBL5B4ayRSzS1tP3Iz/D9dD/S2fZMOHLA9jTG71Z5y8gFtkzt1b4ytR7/d4DsST7vZ06
         uQF/vERrbsP3BroOUr+1h9vjg7QT+iCdauZunoecXciLbQk2uuw1Xa6Lj4fNyd+QiqYy
         GxHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701768160; x=1702372960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XqatM4kM7wKwmicGW+gEqjAkzatGSFvjDGMOBx55ZZQ=;
        b=Gke8ypkFgsV1CyXG7fpsVjjpYEqbmBkCCIpD62OjG6GUvj56AB9KYKUf+006yXHAk6
         tzk7wQOs/GKa7SP7kvuwWhAnvd370pYSkFAS3yd7gD7ytL31cvOGIDq/gNFHZTdpTn9X
         88FI4/ucrS/gYeCAjiHoK/4l96FzC4tkpag8TfgZATg3G9foZ7LgoIMZSPqk76y7lyCB
         NDvqOjSdxz0eYUAHX4OYRMSFj3ryunhJvEDi9a2aILsNQp3kkg5hPjD6K6TBen442+3m
         ahHAJ7SvzWfIVmlc/CJp8tB9vZreODb+/LWDouXLsOTJKt8FGKpqQUq0RFEmbDq0WssR
         Byiw==
X-Gm-Message-State: AOJu0Yzk6QOVX0WeMTnFmK7sqU+bWcARwQBlH6oJb95PQUvi+v2zQysH
	6Ao3YTjr6HDSPZ95IQqLZbP33g==
X-Google-Smtp-Source: AGHT+IHqyN8tJW4uNXwX8E44R4xlrs75N7Gnw2ZbdArJtH83tIrCDBScW+hJB9uRKBPtLaYT5LHlCw==
X-Received: by 2002:a05:600c:4508:b0:40b:47f0:66b5 with SMTP id t8-20020a05600c450800b0040b47f066b5mr294797wmo.26.1701768160649;
        Tue, 05 Dec 2023 01:22:40 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id g10-20020a05600c4eca00b0040596352951sm21692287wmq.5.2023.12.05.01.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 01:22:40 -0800 (PST)
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
Subject: [PATCH 2/6] dt-bindings: pwm: samsung: add specific compatible for Tesla FSD
Date: Tue,  5 Dec 2023 10:22:25 +0100
Message-Id: <20231205092229.19135-3-krzysztof.kozlowski@linaro.org>
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
 Documentation/devicetree/bindings/pwm/pwm-samsung.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml b/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml
index 16de6434693b..17a2b927af33 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml
+++ b/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml
@@ -33,6 +33,7 @@ properties:
               - samsung,exynos7-pwm
               - samsung,exynosautov9-pwm
               - samsung,exynosautov920-pwm
+              - tesla,fsd-pwm
           - const: samsung,exynos4210-pwm
 
   reg:
-- 
2.34.1


