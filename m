Return-Path: <linux-pwm+bounces-4567-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E50A08915
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Jan 2025 08:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D57B8188B0AC
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Jan 2025 07:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D17207DED;
	Fri, 10 Jan 2025 07:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKRGcYGu"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA31207A1F;
	Fri, 10 Jan 2025 07:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736494684; cv=none; b=B2UhzXmtK5bG6InFbgKu4YM1eltzQo+XlWm4wvozCBmLYt34AhQaJpx1y3W/1dfshEoIQKgUm/hUgl6RURzcrocg2fGMAdctI33SvZ3oomCS+y7//pODSHQI+fA128SJfPFcFfRDS41d7b7lkqSpJf6VnmRS+K/G6MkXR0S6x5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736494684; c=relaxed/simple;
	bh=gx2AN6g8CBHOQhQWVvBpRtBLyzQubEgkJDNlqL08IzM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XOrQ1Q8hU4ccK82x7FmNShLSpjHmqS4WC86AHedcHBXKefn5lyCgcy4HXjUENAjnW9hGHMhnpv5mfyp1o4ZxzyunHjPItVda1R4J0ptrNrm2S9D+Vq+AL+NoJWIKruPfsorhiGv2RQnmWg7AaFK6yOVOW0rgQLJNAhU6wsNWjKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mKRGcYGu; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-385eed29d17so918120f8f.0;
        Thu, 09 Jan 2025 23:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736494681; x=1737099481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GkinVYGPyGwJ32i1kYAOsHhIvbGugGjjdqxMHgIEwAU=;
        b=mKRGcYGuTR8EyCaq7w8QkmgnqEK2i7savU2NwwhE7dOJ1Auj4bsWckfv4qojg01v9z
         0aeg7+s2/jFa8qJGTdYc2OX8t+H/B+Z6uOt4rVtI2Iadnu6JUhwfweSrgkcYBgj9ySSl
         MX09KdE/4sDpuQDNbnY449dcq23eCHsos6U3q8ALVWDcK6LDqidP6+70vrCgeVQvlYbX
         rW/LsB0AegQUCc6fp2tI7NeP7NvZXq88FPCoeKi7qnMcG1y7OgdyUYV18ZnSTaBt4Ji6
         As5QjD3MsVf4gwkoVu6fJBb9th2Qu94wjXpejW5na9gQngD55X8ENyFdMve9o7zm1Blp
         fyAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736494681; x=1737099481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GkinVYGPyGwJ32i1kYAOsHhIvbGugGjjdqxMHgIEwAU=;
        b=AadLuK6O4hNIB+PyKSzN6P5ZciuOnI/WOx+BP5gJyoTFYyKGcDzt2qNyUjN9kwGOZ3
         q31BzYcctThk4Aq06I4clli2+PV3IzaIeL/1NTwZd8Xx0v6DpdcBItc01RPeaKLbzDXF
         j/IiadbMfmFLOOA+LsgPWMyI9KDY7xGIqSwkK2AHVphdlVpI5+rcv9frGM68gZuxMVli
         BwdOswyAMphVdAn81fAxFTHqvBKIcTQsrkkB+qQMAMgdLF4AschtLR01gEivvA7V/kd3
         UTsRQmLQP/+tggh/BXWrRxI2tF/HwoRa4e1nx0nV4m8VtqHTj1kWk6bjKGx0nbBvDq+b
         kTVw==
X-Forwarded-Encrypted: i=1; AJvYcCVSkBdlvzAdoDY5Td1M7njzT/5xDqNMXmNbkOpMR16NYo9/ijfDDdhZ1vXERD1+xgCusAnH6Kfgoi06@vger.kernel.org, AJvYcCWq2Gpx3h2pX4NuYA+XfRc0MZs/cSa/AwVAZWYfIYhZwLmc+32sK8rfv4M8B0oxO5lCFC0TayaHsPP0@vger.kernel.org, AJvYcCXb3GUoAt0vqltBy5XSB/CPOHZRrp77WIV9i8Xfo4djkbdleMwvYMVH6qf6QheN4jKAnteLninnLuJSqYgS@vger.kernel.org
X-Gm-Message-State: AOJu0YxFS/+Z9OwR1+SFkmqLBWZffB3oBB9ZOIxefo+2Td4l+tQjZ/EA
	O8bqQcG7vMr+MT2NFIt9/sgXKrMJvDTWrbQtSG2YP702OhOS61Te
X-Gm-Gg: ASbGncuun9+5eUdvZtX/BedbUpzpU+1HLkLf9AdjM9njnJXwg7zWd+QHz7qyJ4zLver
	dd5BzLpi123dMVn9LOpwD5GqhxwIXGa6ayjSb9TQx+zgh1a0j5G+wWshieh380C+I8Zqbwyu+WD
	J7W+qWT4hlQhI+EQQu0Nhht5cqCOBkkGhIedGIxr+1Bu1u2Uy2qqKpYb/VU9UC8x3vHcOWHeT9H
	Dy7ZAM2inxo5A4Hd3zExyCTlhC1EmmUcCiaconjANLnSEVaztdRzxC6H0wsQXO0fQ==
X-Google-Smtp-Source: AGHT+IETWtGNfyy1NpolS7mtHOyAF8SFDjdrcq/kA/SfqQiQ09tzR+K3E+7J8uxJgDm724NEMlTcgA==
X-Received: by 2002:a05:6000:1446:b0:385:fc97:9c76 with SMTP id ffacd0b85a97d-38a872f7fd9mr8679069f8f.3.1736494680788;
        Thu, 09 Jan 2025 23:38:00 -0800 (PST)
Received: from debian.fritz.box ([2a00:79c0:6a1:e700:303:6c5b:4b07:6715])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e38397csm3726478f8f.24.2025.01.09.23.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 23:38:00 -0800 (PST)
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
Subject: [PATCH v8 1/2] dt-bindings: pwm: add support for MC33XS2410
Date: Fri, 10 Jan 2025 08:37:54 +0100
Message-Id: <20250110073755.29541-2-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250110073755.29541-1-dima.fedrau@gmail.com>
References: <20250110073755.29541-1-dima.fedrau@gmail.com>
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


