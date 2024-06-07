Return-Path: <linux-pwm+bounces-2376-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DE190034A
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Jun 2024 14:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CC322888B4
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Jun 2024 12:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEEF193078;
	Fri,  7 Jun 2024 12:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzK6qCSu"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5A615B0F8;
	Fri,  7 Jun 2024 12:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717762701; cv=none; b=eXA/OjK5SPJZ2Ud+fPuwru8Ag136PFdTRii0k+kJYoWLVmbzl3JCyLX3k45me/dwb30mkeTrtJbDFZw0PTMPldZdsJ6ayyYRfxr7ektgXFdPQygR7Qg/rDkCxcF9Bb0R+kTGoobPx7ytD+Y2vXfiszeA0JTtAYYR7rLj4hQVaCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717762701; c=relaxed/simple;
	bh=Ejib7DVCzSzbX+QF3fjfXko2Kw3qksIra1C/cnrr2Gw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X8glhOFg6Q2qXeBU8+OflgZyqw+WtrW5iqZao7yEggIjNwxOUEn77pVJPS2pMvXKF06avd0zCswuZjUGEGH8EuycBHOwHR/uv/U2kyD53arB4m1lrIboP/1dz84Xm0ODr9t/tAKUfz8uqiirZyKx0qRLo8x7b5SwLf55GhPbRoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LzK6qCSu; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a6c7ae658d0so279478466b.0;
        Fri, 07 Jun 2024 05:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717762698; x=1718367498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=atFWfThF4EZfOKlLZmq5Picnlz/FXs/dISteGkElhRA=;
        b=LzK6qCSuLoXXq2LCJlepyc2eKotxoW8VwZjou4bg4wbXRWJ9RcN9cCi5g0mlEXAWl1
         2up9lpWMVxwf/rRSgfYI163yQorcJqxbEgWn60Oe6eKd63syOOgmd2b8Aw9E+k8bn8FC
         m1PSf9qtkUDSILRtI0moadqm1KlI4OMqGBOKEvWP+4I9F01DLHxsfaQsnSQ++y3Znn00
         3eAuJi24xfdn5YrzruAUUYgzcrIYglcrOlYDitx9Jb5wbLN7MmBKkiwIKPs0xiKxTGVU
         xhkg/CB67qAaua0cCGvWeWd2IAjCh2heXMyE+t7X5wjkHNej53kUcGrpneywP7Dtv5XB
         bL1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717762698; x=1718367498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=atFWfThF4EZfOKlLZmq5Picnlz/FXs/dISteGkElhRA=;
        b=nsPG3zQshDELdTu9/DaOYqGNApQIfoYCIHyIvk9zrbEahBjJM574fGkwoA1zQAt+CV
         K7uItHVWGlYm1Dh2VQ3aDkCCLMeXugPg/pvJAw2ZM+v18mRL2uTVtPaiueESRS3J7DIC
         +QZEZWMi7FzuezMHItibeKPZlKp8nznFnWpTcrbsMDloz2e7l6+8ClVDUBAmuL+G3+ow
         /H8tz5BkwMweI9fzYemUFRgRCIjCJF4J6qHNg/nT/NB8Gty45gRsIk/QL2tg4Z6Z3Voz
         VITC11vNNMEzmTY23YTI3nLtZ9/eV5WbPkihmkQ+YGpVdFUUz8ZIubUAbxn6W7InEcFJ
         tfqg==
X-Forwarded-Encrypted: i=1; AJvYcCXT3AKmknIHcHmg1b56+XBNRsOxCrjtUjlsOUmTTn76hi76me1V7KOEMqsc+LmcqaDgAmSfE2qNHYXp8tnF73UddNUb3owxy0/K8yGk/o8VsO0CnXAh+2Z2CC4WZVI9qXJeM2qAYy4ZxASVqnJTLStVoSgp4IQ3SYJkpCX8LJhfRoa8oA==
X-Gm-Message-State: AOJu0Yz82BH2IciNX75U+Yoz3PAoKwD6itrNxa/fCbzl8UjVftDE/dmH
	l/B25sKDZt+biTYkiA0m3vmFBuTp1tUcKdzwYpfd6SvOxSyN5f3G
X-Google-Smtp-Source: AGHT+IEB2qMcul0hphJEdigZCvj3g20UDnG5cHi9AblFvCeNa6Wj26TeG6EAsJcEDZ2vdF7lv+EC4g==
X-Received: by 2002:a17:906:af8c:b0:a5a:81b0:a6a9 with SMTP id a640c23a62f3a-a6cdaa079a5mr194201066b.53.1717762698005;
        Fri, 07 Jun 2024 05:18:18 -0700 (PDT)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c806eaa4dsm237785066b.110.2024.06.07.05.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 05:18:17 -0700 (PDT)
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
Subject: [PATCH v4 1/2] dt-bindings: pwm: add support for MC33XS2410
Date: Fri,  7 Jun 2024 14:18:09 +0200
Message-Id: <20240607121810.460154-2-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240607121810.460154-1-dima.fedrau@gmail.com>
References: <20240607121810.460154-1-dima.fedrau@gmail.com>
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
2.39.2


