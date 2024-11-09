Return-Path: <linux-pwm+bounces-4052-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E99FF9C2EDD
	for <lists+linux-pwm@lfdr.de>; Sat,  9 Nov 2024 18:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14EF51C20BDF
	for <lists+linux-pwm@lfdr.de>; Sat,  9 Nov 2024 17:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F4B19E836;
	Sat,  9 Nov 2024 17:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLi/DUS6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D4913BC35;
	Sat,  9 Nov 2024 17:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731174106; cv=none; b=U2oO3u1mhSM4PHB/rNyypHz6B5AJY4w/y7JhDw75bsPGWEKal/GHvUgD1PEe9nanxslgcpulwBOCHfWqRAOFSZb/GrJY12RnZNZbxQPvWkdn0nE6vauGn9DBg2/K7C826DEXtdptCWTVEImVAOdYH+YYMC0CvemAQKOdber4R0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731174106; c=relaxed/simple;
	bh=gx2AN6g8CBHOQhQWVvBpRtBLyzQubEgkJDNlqL08IzM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L6OTO0nbWTRvORHVE1qW3wCJ/39kP79OtrFXXNQE5yhn51ZyFhialan06XgWshF0zaKeR8mwqcH2Of8T7J9LzSIKNH2kNgpmNfz7Qr+rJFur7tiqORvSE/kNmg65o9FGMM7HJNAP9d6H3ZCS5HPYUoTYK9r0KOLv24+9I9QX2lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iLi/DUS6; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37d50fad249so2373985f8f.1;
        Sat, 09 Nov 2024 09:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731174103; x=1731778903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GkinVYGPyGwJ32i1kYAOsHhIvbGugGjjdqxMHgIEwAU=;
        b=iLi/DUS6GCJwNo0pF/iphnk2/uSdDUtW6AFJ+DopmwD28IxUQIzzzOK1klH2BJPbY4
         XW6LBhGJxgH4uhp4naxMAJBrC+NdIODO/TFLbfBMEr6FWV/9yTL1bnuAh1/83hcqEbLZ
         rO6isV5Ydp02Wk6me9uQzSTW+OpdT0J1vUPIGidFxqgn6oNaQ2F+fQWntuCzu5C6n0Ib
         HlMegCkjMrjrCqQUIcqhrgmr3Zqyp3IborULlSo7PuIbiKmri42x56CKAO3Wi6QimgRU
         oNmtOfBD7RmR27Y3yK0UjrowzODWiqXV+n1rfMLBeCBD+RMr4NZkxSodM5xISSb2A+Oe
         Vk3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731174103; x=1731778903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GkinVYGPyGwJ32i1kYAOsHhIvbGugGjjdqxMHgIEwAU=;
        b=vbaXw0isyxpmsK1uf0lQCI3yGkZNstX6q9Ll8fb1SRDLUQA6gLnPEeAeUR7WrQEKcR
         yYEpSpCO2XD7hwjJj/8rn0vciEDNCCvY61nKKet65NVOCrCStoW2SDx0Kqdorzm2womF
         ls4EVNmyza++uUko8oVWbYu8IwioWughBIUwCPyLS6YRNBKCMfz2SFfF+1NOONkSdzKe
         jvhbGhlCpL3wKdZlH8ig8DzMS3mo7L2uL3DeHq3T/AJ8eAUp0Vu4YBeCnS6iSgxOKxnD
         1j9xYmvzPi5LvGzT6py71DVAptbwi4yQpt0eR6aPuyjer2rDGL5RxPwR4k5cPCL4Vh+T
         U5ag==
X-Forwarded-Encrypted: i=1; AJvYcCUmkHzpuIfPJc+MyNjjW53ZuPsQKZM+MF63PdtvoK3oQNE/4LC5iWLSYyVRnNIcyI7P8MifZQilrId6o8xC@vger.kernel.org, AJvYcCWj7IdzIGVx5WB9YklS0xSjYt/qq+9Vq4XLMccmnPAdnaLOWyoPa3dB+k9+tt8U3+3AObT59qdd2DGC@vger.kernel.org, AJvYcCWnryzgvBhCoq2GqR9lt0a+nbKswbgK2GMlZPLpWvyVlougxaI8iR8Ni7N6aihE6+6WWWJtU/Z7Qk3P@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6EpST/7GIF3fYiuXz7p3Kh0GFVQebc62Ag0/vVQ3+SbDfibC6
	en5jN45PuQI2vetVk3K7Au+37GUMsA/sNIQmGrJXgnzFtstWJ5xF
X-Google-Smtp-Source: AGHT+IEh4J97FEYorYsztkOFKAsNtA+wdT1GmST8Y5PJSkDl/MlMVznGOlav5qUxAOIj7LrJEClF1g==
X-Received: by 2002:a5d:59a6:0:b0:37d:4d3f:51e6 with SMTP id ffacd0b85a97d-381f186bf72mr6098216f8f.14.1731174102612;
        Sat, 09 Nov 2024 09:41:42 -0800 (PST)
Received: from debian.fritz.box ([2a00:79c0:605:8200:303:6c5b:4b07:6715])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b05c202asm117582285e9.30.2024.11.09.09.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 09:41:42 -0800 (PST)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Dimitri Fedrau <dima.fedrau@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v7 1/2] dt-bindings: pwm: add support for MC33XS2410
Date: Sat,  9 Nov 2024 18:41:34 +0100
Message-Id: <20241109174135.26292-2-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241109174135.26292-1-dima.fedrau@gmail.com>
References: <20241109174135.26292-1-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding documentation for NXPs MC33XS2410 high side switch.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 .../bindings/pwm/nxp,mc33xs2410.yaml          | 118 ++++++++++++++++++
 1 file changed, 118 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/nxp,mc33xs2410.yaml

diff --git a/Documentation/devicetree/bindings/pwm/nxp,mc33xs2410.yaml b/Documentation/devicetree/bindings/pwm/nxp,mc33xs2410.yaml
new file mode 100644
index 000000000000..1729fe5c3dfb
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/nxp,mc33xs2410.yaml
@@ -0,0 +1,118 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/nxp,mc33xs2410.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: High-side switch MC33XS2410
+
+maintainers:
+  - Dimitri Fedrau <dima.fedrau@gmail.com>
+
+allOf:
+  - $ref: pwm.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    const: nxp,mc33xs2410
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 10000000
+
+  spi-cpha: true
+
+  spi-cs-setup-delay-ns:
+    minimum: 100
+    default: 100
+
+  spi-cs-hold-delay-ns:
+    minimum: 10
+    default: 10
+
+  spi-cs-inactive-delay-ns:
+    minimum: 300
+    default: 300
+
+  reset-gpios:
+    description:
+      GPIO connected to the active low reset pin.
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 3
+
+  pwm-names:
+    items:
+      - const: di0
+      - const: di1
+      - const: di2
+      - const: di3
+
+  pwms:
+    description:
+      Direct inputs(di0-3) are used to directly turn-on or turn-off the
+      outputs.
+    maxItems: 4
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    description:
+      The external clock can be used if the internal clock doesn't meet
+      timing requirements over temperature and voltage operating range.
+    maxItems: 1
+
+  vdd-supply:
+    description:
+      Logic supply voltage
+
+  vspi-supply:
+    description:
+      Supply voltage for SPI
+
+  vpwr-supply:
+    description:
+      Power switch supply
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+       pwm@0 {
+           compatible = "nxp,mc33xs2410";
+           reg = <0x0>;
+           spi-max-frequency = <4000000>;
+           spi-cpha;
+           spi-cs-setup-delay-ns = <100>;
+           spi-cs-hold-delay-ns = <10>;
+           spi-cs-inactive-delay-ns = <300>;
+           reset-gpios = <&gpio3 22 GPIO_ACTIVE_LOW>;
+           #pwm-cells = <3>;
+           pwm-names = "di0", "di1", "di2", "di3";
+           pwms = <&pwm0 0 1000000>,
+                  <&pwm1 0 1000000>,
+                  <&pwm2 0 1000000>,
+                  <&pwm3 0 1000000>;
+           interrupt-parent = <&gpio0>;
+           interrupts = <31 IRQ_TYPE_LEVEL_LOW>;
+           clocks = <&clk_ext_fixed>;
+           vdd-supply = <&reg_3v3>;
+           vspi-supply = <&reg_3v3>;
+           vpwr-supply = <&reg_24v0>;
+       };
+    };
-- 
2.39.5


