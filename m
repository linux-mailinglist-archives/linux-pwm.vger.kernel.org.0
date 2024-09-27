Return-Path: <linux-pwm+bounces-3381-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E4F9885D9
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Sep 2024 14:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B60211C208B5
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Sep 2024 12:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7706918DF71;
	Fri, 27 Sep 2024 12:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmMy0WRs"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5ABF18C93F;
	Fri, 27 Sep 2024 12:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727441874; cv=none; b=qnyHNMJ1Zvzava/17QFuoYd6MODdqk58yqpLbBzbfNmH/HVijd2UAhNAWneA3jG8d3FlVALAms1q25misPfWFfFn1o3cfLHTrmxhv6QAEa5DeZywKpZ2OIJPnKNEQqKccr7DRf0cR5vPIh8uS9MCENJjG/5X30E0bd1is5fzvkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727441874; c=relaxed/simple;
	bh=gx2AN6g8CBHOQhQWVvBpRtBLyzQubEgkJDNlqL08IzM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TQem98eVnz8SFizuxxuqqEZWv+TDP/nh8NR2uTtqJMv4Kcmn15lIq0k9EaxotJeEQi+9cThIzULHDfF0tVxFykF9W6wJXVtzI0hkJhXgRooVMik2h0HqwBbgPULOy/0fHhpURWOpDB7+tOPf9CSlCO4F9HN18paZM8lXJskevcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HmMy0WRs; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42cb58d810eso19936435e9.0;
        Fri, 27 Sep 2024 05:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727441871; x=1728046671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GkinVYGPyGwJ32i1kYAOsHhIvbGugGjjdqxMHgIEwAU=;
        b=HmMy0WRskuyEpVCJ609g/mIwMX88CCeB9BtolcEEV/7FrUZzEWIsVJ0wys3HimsEoE
         GH/b3PYF2AFTZHXyKzoRZoXUVvOWC2T74WCP7vpvsff6LJzqE2ntw1OUJktb7P7U+6pW
         cvRZEf7qFq/hcNv74WaoaB/f2L7woM9Hg8n/v3Pd5Ecz8YXA04W6/McwOoFHFpJa2PVk
         fkbD53ACGwV10I4FLi3QJwxO/F5ZM/AxIEVvPSH1PR1lQzUFghS4yC/qIBCyT025WSnb
         6xP6tf9Pf6tJVeKht5wuP7mG3B9jg8kPQUxdQt7LTn8HZzfI3dNu6S+3GKCnPPXkxueO
         kmng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727441871; x=1728046671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GkinVYGPyGwJ32i1kYAOsHhIvbGugGjjdqxMHgIEwAU=;
        b=oHbFb1a4gWY1Agr31HyX06UckndRkdDuh9ojlv5MGlzGriVnxpTdKXJafZpSwA56QW
         Af0wg2rE4k/YOaYg7SDsO+NIGNy8CDRJ7itqOOZxsyxGxTlggjVF2gz7s2xJ9ttjVzAW
         TzffX5c/7rXDtR9xvmSnW8LVZ2cTdBeX7FglIOHIvg3J3W1wAWEXc/qb71DFb0FRdcyL
         Vqt4P0/u+cG6MkaVyT/65KmiheQc1dbMGagu0R4eBWFZt6SvF+ONqqZHf/NK3al+RgRV
         eGFmcn/whTrTQPFZ1dVeYNViAdw1CFZu3dG5d1kLOGR0kfIotsYshuj9ndx13QMvP98W
         FALQ==
X-Forwarded-Encrypted: i=1; AJvYcCUF8F2VXj7MpJj3+t1qiuxh/OcCvG41LSVMuzx6i5pdpnmGoirbeILX0V1woJDe+fyswKvNJYXeyf6G@vger.kernel.org, AJvYcCVrkeAvr0eUZn6MASllnCgaQh9RnxU6yUFLDYPMEGtqdixb8yRif7ywxsddG0QE5LBchP1xL7hdAl3i@vger.kernel.org, AJvYcCWUOAzzHXD+3iycTQxzJL/kcVYid/dMW0YyiVFdPiZliPPFkFZe4hOXXQYBSoycsGRtUCJ1gm/P1pcJ91cB@vger.kernel.org
X-Gm-Message-State: AOJu0YzAsu/aY7ZypoSZaacsZNSqz1uAn4eAV6LApLrTNkKyHAoL0cMc
	PZpZsueYt9TSpJLjqkdWF0llT/G8Ha7tUG6yJr/Q8Pltu/0FXYrn
X-Google-Smtp-Source: AGHT+IHZM2N019AsM2bnF7unQ4hkd4Nozrw+aEvAA75aqfCNeBXvtBcEvRO+Mg4S4VFBtFH/LYy8Qg==
X-Received: by 2002:a05:600c:1c1c:b0:42c:b54c:a6d7 with SMTP id 5b1f17b1804b1-42f52200c3dmr40652905e9.14.1727441870659;
        Fri, 27 Sep 2024 05:57:50 -0700 (PDT)
Received: from debian.fritz.box ([2a00:79c0:666:ff00:303:6c5b:4b07:6715])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e969ddad1sm73814575e9.9.2024.09.27.05.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 05:57:50 -0700 (PDT)
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
Subject: [PATCH v6 1/2] dt-bindings: pwm: add support for MC33XS2410
Date: Fri, 27 Sep 2024 14:57:44 +0200
Message-Id: <20240927125745.38367-2-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240927125745.38367-1-dima.fedrau@gmail.com>
References: <20240927125745.38367-1-dima.fedrau@gmail.com>
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


