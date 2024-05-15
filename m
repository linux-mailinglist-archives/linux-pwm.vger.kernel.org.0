Return-Path: <linux-pwm+bounces-2174-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 124198C656E
	for <lists+linux-pwm@lfdr.de>; Wed, 15 May 2024 13:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3634E1C21D93
	for <lists+linux-pwm@lfdr.de>; Wed, 15 May 2024 11:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33C76EB76;
	Wed, 15 May 2024 11:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDplixMA"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0C05FDB3;
	Wed, 15 May 2024 11:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715772044; cv=none; b=r1pMdUDDuzptKBQ9oFJtm09SgynIbZQTpmNBm1A6r0CQYa8m1OmCta6c8v6amzr7NAtzUcXUbbjOX972GzMv/ejwQOoYzWOdd6VUDLkM8pzwtafVbPn+0yPLnErPmdwfExDAjqFY3OgKzxYMp5JOzsQ7v9jKPpy8zi0Adu5z5so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715772044; c=relaxed/simple;
	bh=Ejib7DVCzSzbX+QF3fjfXko2Kw3qksIra1C/cnrr2Gw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jU2uYa+8Mcy0IvsucTqDKdcpUqpFEUc3yCssJqz6XvargQ335237/CTa3sURitzb/oBfOUZyi89YncKQ19scOl9Totjejdk/0L1RVKM9TdID7Vv9BCoI+XslDCu4YMqj/3ngI/D4Et6X0/KMIFhJ9hSJUIOdtqUYhOCV7cGmyHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mDplixMA; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56e6a1edecfso2130180a12.1;
        Wed, 15 May 2024 04:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715772041; x=1716376841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=atFWfThF4EZfOKlLZmq5Picnlz/FXs/dISteGkElhRA=;
        b=mDplixMAyM0YmCnpLXkflHNFlkaScyX9iWjdwnr50kc6VjozF8/3XKC55/2yCswucu
         CZq708d8e2A34GZc4TDtTQ3JI3MNAQtdGSfX1714MU7EO90kZD5e5IEibHtWOxPDy+4l
         lQUrJmJRGPoVJQKqex74Xj1Ku9dbsyUvlHSIdMcsfZ6o7fudQ6gZBtRzIoq4cq4phW62
         IomnGkZRUkhVc7I3VlSWSqOFsa+LP0V2rsQCsZ8h+AN9hfXY5WYfZ1InMqMkV4SxKlp3
         rQuY4j40iJ+ByKuHxFW0CEojgDMFBy8Nvg7mnvAkaGYYKZpXn55SNuLoD0wIr8GubMok
         2DMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715772041; x=1716376841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=atFWfThF4EZfOKlLZmq5Picnlz/FXs/dISteGkElhRA=;
        b=gxfaeI9wZ186Oy5AUnQ6pk9COubO3HpDgRTpi5AMEzLm7ro7jjo8ZXJdvhf2pEjHLA
         aRVsTuB50WNd6h0fRfuuuDWB+hrKRd8qGHbePgSBY9dlocbo9K2vtLw3bmTySNcItc7a
         PkjYcebYVkr2wenEZ4jOi6pkbbaM3teMqNayKDBIo5liPeYeVd2myAPseb2c591LLmvh
         c7OM99bg9OPSLT5zWkITh/Jg2b0HnMnIuxZ1eAY+ISHcboDxTtgGGPOaxVljc5tMK7XB
         qTfqSGLHIOnB64HwmboH9oMdWNAGJVOm+uqwyBHwg94l+1HqPsyuwBDZUHLT6ueimlpS
         Uvww==
X-Forwarded-Encrypted: i=1; AJvYcCWBidTrbmc2kHsSsXPC3yREqgfxEBLM/A8bG7tqjyQZaZud6ROgQbtyZmQ8Gys9YT7ZAc0MDsZ8Yy8nEo9rTypMP8Cmo8gDvqsmBSbFVlFP+djNd5yNWF32OQgLMe27W6sR+ec6kuwRgRWtwwTgKc8LAQBOoWJ67Kl6stG38xMZF12HKQ==
X-Gm-Message-State: AOJu0Yy6mY9X5ZgWMKJvSB5ILYhnCLnboPcAVqa9W/CFeMIdDwkoOFDk
	T6QpoumpTg0Giwygdu4ZLXhdI6IIXv3LUT58MuIXB/x4UiAEXhqsBBsx6Q==
X-Google-Smtp-Source: AGHT+IExQGjeFchTwGEdu+8g4BzVxZ49k6zJziWuhkJnqLCo1RB9ig9MPgKGNZOYAWV0hrjobT4teQ==
X-Received: by 2002:a50:8757:0:b0:568:9d96:b2d1 with SMTP id 4fb4d7f45d1cf-5734d67e8b9mr10215074a12.32.1715772041290;
        Wed, 15 May 2024 04:20:41 -0700 (PDT)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733c2cb331sm8847633a12.67.2024.05.15.04.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 04:20:40 -0700 (PDT)
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
Subject: [PATCH v3 1/2] dt-bindings: pwm: add support for MC33XS2410
Date: Wed, 15 May 2024 13:20:33 +0200
Message-Id: <20240515112034.298116-2-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240515112034.298116-1-dima.fedrau@gmail.com>
References: <20240515112034.298116-1-dima.fedrau@gmail.com>
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


