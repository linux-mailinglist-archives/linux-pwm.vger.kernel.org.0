Return-Path: <linux-pwm+bounces-4548-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A63BAA04013
	for <lists+linux-pwm@lfdr.de>; Tue,  7 Jan 2025 13:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 225F41888B9B
	for <lists+linux-pwm@lfdr.de>; Tue,  7 Jan 2025 12:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0751EE036;
	Tue,  7 Jan 2025 12:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K+2rgvDw"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818F11EE7AA
	for <linux-pwm@vger.kernel.org>; Tue,  7 Jan 2025 12:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736254719; cv=none; b=I4kFh4fnFuMXkWamPUANQ5kkG7sTGJvDGQ5oeVibC7l6w2l/w7/Mw4qfTg7g9OlSrC3hRHtRSgXtad3Ab72F/MXO1Glrz1CdXAV1bpt9Ei4fs7ArZ0OkRKP/JlkohoDYU52k1t872zaxmwd5O7pYKKhB4+b59Rv6PSYoKY1DW/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736254719; c=relaxed/simple;
	bh=OFxtIq84pjYYuzu4hf2cp7nadzLvsWbywncZgksHCVc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I541OZVsskoSgPgLHr3HABj/uMU2MniNcPmZ4jhyeoeBlrTahDO2lu8S0ySWHqa6hW3R4qMNs7FHXjybiQpDG/KNkhtunldBzsKfF9GTEH7w0bHr++aTia6EmwSxHWpFaoaZPmpYjkyL+UoODhjJdgKGcqopmIbBBa1Kcmwz7wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K+2rgvDw; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-385e44a1a2dso1789752f8f.3
        for <linux-pwm@vger.kernel.org>; Tue, 07 Jan 2025 04:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736254714; x=1736859514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iVaSFtlZM3/VWeZtMCCVy8JYGseLcw26+eMrw9jztfQ=;
        b=K+2rgvDwaqTHMtpEBVR3OyFqqK3Z1i9/WqrXSyNPto7n3OZtLI9cnFy2lK/agLOW+H
         EuDCg983NkRPI1t5Tx/1CAEgzlKV4VH2HSb3a2qM0BLgoYvCBGOQVDWOCDlw5ceddmcK
         nGUxJSf1PJ6wWlCy/lva9tKKgGxrqUubBpCvW3OCodEys8rc0EKvXqBlW85QrSXVrUKw
         jhjr7nSpjW90qpnXrH4bG0+Hlfpl4++xAgF8dvUFwBhHC7LTh3xBkNhj41FQnzHmh5Ip
         yGHZNkmg+as9EXvPZfiLydMuk/O51Kj8MeGZJpnsJ7e69gQeoFWQrqw8+Pzje1q0yT7S
         JHjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736254714; x=1736859514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iVaSFtlZM3/VWeZtMCCVy8JYGseLcw26+eMrw9jztfQ=;
        b=IxigZiPnnCc/0cqYu5MWHpkOfnTSm2cnWX8nIwApGiI7DcNohRctJwRCbc/8pOAOXX
         898kDJonlSEpR3dAjkGm54YW7aMh+Awz88RwU5IqW73D9mIB9HB39437HXBkcuKLtdKO
         ieJOS/46jld7Xmgzz8vqklUyNfVT48EuwENgzfsv/Adc8kF9SAT/bkCTUKZhIXl7AQrG
         qH3HHOv3zLVnf2RDOXT0a88QKNPxBVXltcCzljh5zmRbuakEK2ytnng54AY0Sbj9YJR3
         l2RRF23027kz4/9xcRaXkWmLlcVFV0Fw0fu0+0Kt+T81im7BAlGctUupX8jfZpQirTM0
         jw4w==
X-Forwarded-Encrypted: i=1; AJvYcCUoXWciBvVEk2hV4cxVlCBCsdS3u6ZqQzGkg7Tr0d5SGP3R+dSXgCgY+P3pQXLflwXsghp4xIhj66Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYdvKR8rI6bM123CsGZJ+EGvNR9hIggrYqMmzopgLFLUL7q//A
	7ly59ey+vcyANnEXpMR6wwcJuKY8an6GJQfaBU4VVoON8Wfxx2O4oGYX78dwmFj7LAnwss8GdzG
	m
X-Gm-Gg: ASbGncvLzgDsb3g86h1WkOUbZ228+KkejdVpQU9pNHc72Jd351oNqPK1z8Kjv1G53xV
	RNvWa2Gg9lpOI3VuwzBnUn1wqPVpN/i5Zc9ajWba8MjCzRPjhsXtEo858MMVRNmSnNHw4s3pgLG
	22EP/+jHCUEezab506EdjdDXQV4s33IOIQUZXDd6nlthnLPIkXcniAH/gfsiGfptBFHJkm3S+Or
	BJcAY7Lesc4TLm3huQ88UKjIq54eQpv2Hg+nMSJQ96p5Flt8Y1KUAzhQzLbg7NOz2zFZL0=
X-Google-Smtp-Source: AGHT+IFPBeJaMEFcgs9P5ku/eO7a9THMpLvlhXfK01aXSRTSwOvnAsWvnf3VluFuAxi1Ku/w/nWpEA==
X-Received: by 2002:a5d:5e09:0:b0:385:f479:ef46 with SMTP id ffacd0b85a97d-38a223fedbemr21216203f8f.13.1736254713733;
        Tue, 07 Jan 2025 04:58:33 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8474c2sm49738610f8f.55.2025.01.07.04.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 04:58:33 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Michael Hennerich <michael.hennerich@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: pwm: Correct indentation and style in DTS example
Date: Tue,  7 Jan 2025 13:58:30 +0100
Message-ID: <20250107125831.225068-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DTS example in the bindings should be indented with 2- or 4-spaces and
aligned with opening '- |', so correct any differences like 3-spaces or
mixtures 2- and 4-spaces in one binding.

No functional changes here, but saves some comments during reviews of
new patches built on existing code.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml | 8 ++++----
 .../devicetree/bindings/pwm/brcm,bcm7038-pwm.yaml         | 8 ++++----
 Documentation/devicetree/bindings/pwm/brcm,kona-pwm.yaml  | 8 ++++----
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml b/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
index aa35209f74cf..45e112d0efb4 100644
--- a/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
+++ b/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
@@ -41,8 +41,8 @@ unevaluatedProperties: false
 examples:
   - |
     pwm@44b00000 {
-       compatible = "adi,axi-pwmgen-2.00.a";
-       reg = <0x44b00000 0x1000>;
-       clocks = <&spi_clk>;
-       #pwm-cells = <3>;
+        compatible = "adi,axi-pwmgen-2.00.a";
+        reg = <0x44b00000 0x1000>;
+        clocks = <&spi_clk>;
+        #pwm-cells = <3>;
     };
diff --git a/Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.yaml b/Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.yaml
index 119de3d7f9dd..44548a9da158 100644
--- a/Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.yaml
@@ -35,8 +35,8 @@ additionalProperties: false
 examples:
   - |
     pwm: pwm@f0408000 {
-       compatible = "brcm,bcm7038-pwm";
-       reg = <0xf0408000 0x28>;
-       #pwm-cells = <2>;
-       clocks = <&upg_fixed>;
+        compatible = "brcm,bcm7038-pwm";
+        reg = <0xf0408000 0x28>;
+        #pwm-cells = <2>;
+        clocks = <&upg_fixed>;
     };
diff --git a/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.yaml b/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.yaml
index e86c8053b366..fd785da5d3d7 100644
--- a/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.yaml
@@ -43,9 +43,9 @@ examples:
     #include <dt-bindings/clock/bcm281xx.h>
 
     pwm@3e01a000 {
-       compatible = "brcm,bcm11351-pwm", "brcm,kona-pwm";
-       reg = <0x3e01a000 0xcc>;
-       clocks = <&slave_ccu BCM281XX_SLAVE_CCU_PWM>;
-       #pwm-cells = <3>;
+        compatible = "brcm,bcm11351-pwm", "brcm,kona-pwm";
+        reg = <0x3e01a000 0xcc>;
+        clocks = <&slave_ccu BCM281XX_SLAVE_CCU_PWM>;
+        #pwm-cells = <3>;
     };
 ...
-- 
2.43.0


