Return-Path: <linux-pwm+bounces-2965-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BAD9460BC
	for <lists+linux-pwm@lfdr.de>; Fri,  2 Aug 2024 17:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F705282FF6
	for <lists+linux-pwm@lfdr.de>; Fri,  2 Aug 2024 15:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C431537C5;
	Fri,  2 Aug 2024 15:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fT5tQvTj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85242175D5F;
	Fri,  2 Aug 2024 15:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722613467; cv=none; b=JdfQ2uwvSgerom8UKYkGaA97TH4J3uBF1vv1ex4FeyBgLCTfWlxNmwjPfGx6SVmVnqjueOmDsrOp0QhfMbDEr775n27blYsh1Qe0nJ1U3tjFXzl+1BZ1rmcADUrP0YAfwrDn2Fxp9NgmrAIDPqBu9meJBb3DG+aD1TQw26tfUWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722613467; c=relaxed/simple;
	bh=Ejib7DVCzSzbX+QF3fjfXko2Kw3qksIra1C/cnrr2Gw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C5CFeDdbdt+AIije6v6Retli2k7llCtzhgMrvuF1Knf9NWwvN+HJxpIxPLR+fGac8c7SsfzU+oqSIpOMP7BsrYzwZtogG5X2zm3sxDnLQjFN1358dR8hI8CTqmTFTkTYPWVto9uDj0dMtJRULoLRqaWNbHNIkRgNMytTc18eV/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fT5tQvTj; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a7a9a369055so915358166b.3;
        Fri, 02 Aug 2024 08:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722613464; x=1723218264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=atFWfThF4EZfOKlLZmq5Picnlz/FXs/dISteGkElhRA=;
        b=fT5tQvTjyauuzilHJDhPW+aKRGb1wMC3JkK8ikHAG89Am9ggfXXw/B5jbxtF5MGW99
         lPpLf4+RK8cM5xpCFkDlPX62JVtMVGY8h+lyIQEhq9hoPDKsmO9fGJzPDTIjCCB+wiO0
         bFSLbkehgz104t3/npfeHe+uCA/vbSsEsvY43VS66KBMy78PpYkkWmQyHnCuicNQiSid
         0Q2m1jkErECPG3CzMYYJlzLtzBGWtOQLkyAVKc03nVlyaSKJx109CC2SFp0FYIP4+6QN
         YIslSzM7px0mYd5bz0+FCq8AXgYwc7rQL31P+FplVkLE7i8Q3dRu1i0iXNIYf0U8NvX3
         sQQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722613464; x=1723218264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=atFWfThF4EZfOKlLZmq5Picnlz/FXs/dISteGkElhRA=;
        b=Nkcz6CTIneNMFNQ0+/C0YQXKEZIJ/bsP0rKduL+3KnmwXDWrOy2GoLihakTGv1iZIS
         a5HrpEV1dSijRdVPV4lqYA4noSSfQ2AEEhUDfPDMdAzutIfq0AA+ohQK6KAvXZsDi6IO
         f8QrQeNoGPcBpANXpaaIUzrGw5psxvqDHlpZT7GtaY8pwRUPUVMnlvWQSa+tIuxasFVB
         y0ybR+SOb9WuwK0twhcXwEHduB1MJIdbLvsNU63n9LDkDqQ813c+Zy0O/X6AMlDg22qT
         qJclCpGAWqJ4W/iEgFgo88m+6XulSs3JPb1d08/M8oDpwWDFjhT5U+0OEpVM2bSbsXAH
         Wlgg==
X-Forwarded-Encrypted: i=1; AJvYcCX7DQYFil/++LnIFbkzHwxKoGSW6BU053r1eg6IYSeSWMNyuYaboW/+NEZbNBsKVQcCVtzbzza7M0onA9h4hZBmQI196Kho/czfaFlVM81U0hKpqw9R1dQnhyiPu1+52U3xLJlKLgCAdIAYzStbbvdO1tkorzHvlPEIVM7Dm8FSxIiD0w==
X-Gm-Message-State: AOJu0YylygDxW1tGSMMGgnxK0B6VlGwsuhXaz9SIo5rQJ7UQuwdfFh/M
	a1Sp4ajvzWboAhQPiLO6OAyP+y9mhvpTgre4jut2sh+ufFEG/nAiru5VxQ==
X-Google-Smtp-Source: AGHT+IFMl2DKowv9kx3uec7b+YUQLltN29yhPB0egtMFPnNeY6H7lYROKVhVVEVSIIpGOSJYacT81Q==
X-Received: by 2002:a17:907:9687:b0:a7a:ac5f:bc01 with SMTP id a640c23a62f3a-a7dc4b0e32dmr281421866b.0.1722613463373;
        Fri, 02 Aug 2024 08:44:23 -0700 (PDT)
Received: from debian.fritz.box ([2a00:79c0:640:3a00:303:6c5b:4b07:6715])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9bc3d14sm112577566b.22.2024.08.02.08.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 08:44:23 -0700 (PDT)
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
Subject: [PATCH v5 1/2] dt-bindings: pwm: add support for MC33XS2410
Date: Fri,  2 Aug 2024 17:44:07 +0200
Message-Id: <20240802154408.135632-2-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240802154408.135632-1-dima.fedrau@gmail.com>
References: <20240802154408.135632-1-dima.fedrau@gmail.com>
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


