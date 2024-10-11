Return-Path: <linux-pwm+bounces-3598-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA17A99A153
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Oct 2024 12:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04FA2B23493
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Oct 2024 10:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998D0212636;
	Fri, 11 Oct 2024 10:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ku6RY5pU"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C805C210C2C;
	Fri, 11 Oct 2024 10:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728642527; cv=none; b=doZypOtWRiqTsbMUnxdWsl4OJSYt/4Tt4PjsRpShiNduyJxyMJH3ULVsAtv9Ds2OBJCy1EetvJW8GTgoGUfeHJkDR4kfz3mvb918Jj+d5JV2ywRmmQkf0yqeYWK1uagNxswlVq1X/pIWuHbnR5Tnv6Q+AryXYNtuTv5lmOQLoi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728642527; c=relaxed/simple;
	bh=N+Zbm7Fm7DDc2Ynl23djjTgsVJ0SADNhJ3fgDS+rKOw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=frGrHtV3l9Jcc0iD/BYkHdcM/fjskOPXr+s87ITb0MKg71qGDZk1NkC3qg8Msgo7NM89OXlrkz2ZwEntGg1iIIwobmX7pr8rASakLI6GkPNdARNig90IAliKvvjNEnZD14wNavtekUWC5E/cj4SiUpzNIE8D5Y3TKdYg45fPuws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ku6RY5pU; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5398a26b64fso1885530e87.3;
        Fri, 11 Oct 2024 03:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728642521; x=1729247321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6DNNq24d7mxFNOs2ke3D1b/n+xhRg9qtLvnTihNfsp0=;
        b=ku6RY5pUjIip6oCl7m7N3K46IbK5qrDe3HlwbDyZOOxRwFOe4syT8NRGk4iVFcrpOb
         rrI5ztm1QrnlAQh26TtFhnmeZMuBEhWMwiy82a84aT1WurDcINhmbX8vRhugspJ17Ezz
         1cx68uJrzyQDitBPCOJ9JkExS6Q7ZLsEEXYDw7ba0pRiwxcy3t/w0Eo8tcz+in2l7vpZ
         ZZmEOffMZ+vR/ZL0ukOfiPycXKzamBFKq8YgZJuwOb5Gf7dj/ay6eaYqNoFqSl0FrgK1
         99a4trAjyYgFJO/WGH+OLJ0X0CI/c6pg3o6VMpHZ99tT/GvEE46NC3ntHInW8gRk73dv
         xdOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728642521; x=1729247321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6DNNq24d7mxFNOs2ke3D1b/n+xhRg9qtLvnTihNfsp0=;
        b=FieCwwR55sSVDuarm9fLcCIu6rG4kyBwSWdhsJ1hNE4DEJecAPFoO3ygs45WQ1VW7f
         E/G8loaRxnYdccw+Had+z8KPdEVKdb+KxZw4Fgj1392ydg+jzujQSQXEL54EKdCMqeHT
         1c+WBv+qFP3yDxthJdMphfdXoEREUyu9iMZe90wY7S126QQdkM46gItA7PXC/8DZUnHV
         sZxARYUm17pz7QrnQeT5o8J9d0WFdmAy7+FYRSyBszLuwvKoTa5XWLsPCJ5kyTJmMSZt
         RcjO5b2MdAn3g3lP2MzLQHNgm63JtkhGaiiQM8yYmGf0fD7Nx4E3HaOLvSpRPDiVPvHW
         iqlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiJbdXd08sxQACi502aS+2tgVkWtftGP19wMCDGLvPNGpr+Q8VgwmpEO4QflDwuo40sumz+9n70jvj@vger.kernel.org, AJvYcCXXNPoMPXVWozrFdrpfj1fZ1WwPMAz9h2k0G8oNLVDETxztLWVdHnwffVSY34gjfZskJfYM4hIm3ZnG@vger.kernel.org
X-Gm-Message-State: AOJu0YxytXFCEIdB4ZfxGFbmF0DIejyeNqJfvrj1lbJ2MDbtM2L1bcCq
	Ar1XRGqKa+RRGOd2qCjSS6czhn7uTLcf9/Nr9/dZ+j7UKMhInjpeCYeI8H3grWYx
X-Google-Smtp-Source: AGHT+IFMNNoCDYF8m8Ghh38lXDuoCreUYDVAlm+aLxYvwQYlU6YMgn3EwdgcqNDHaUz7gFkp3wfTew==
X-Received: by 2002:a05:6512:1109:b0:532:c197:393e with SMTP id 2adb3069b0e04-539da3b2351mr1172966e87.11.1728642520999;
        Fri, 11 Oct 2024 03:28:40 -0700 (PDT)
Received: from localhost.localdomain ([188.162.200.45])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539cb8f1003sm552534e87.233.2024.10.11.03.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 03:28:40 -0700 (PDT)
From: Aleksandr Shubin <privatesub2@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Aleksandr Shubin <privatesub2@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Cheo Fusi <fusibrandon13@gmail.com>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-riscv@lists.infradead.org
Subject: [PATCH v10 1/3] dt-bindings: pwm: Add binding for Allwinner D1/T113-S3/R329 PWM controller
Date: Fri, 11 Oct 2024 13:27:32 +0300
Message-Id: <20241011102751.153248-2-privatesub2@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241011102751.153248-1-privatesub2@gmail.com>
References: <20241011102751.153248-1-privatesub2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allwinner's D1, T113-S3 and R329 SoCs have a new pwm
controller witch is different from the previous pwm-sun4i.

The D1 and T113 are identical in terms of peripherals,
they differ only in the architecture of the CPU core, and
even share the majority of their DT. Because of that,
using the same compatible makes sense.
The R329 is a different SoC though, and should have
a different compatible string added, especially as there
is a difference in the number of channels.

D1 and T113s SoCs have one PWM controller with 8 channels.
R329 SoC has two PWM controllers in both power domains, one of
them has 9 channels (CPUX one) and the other has 6 (CPUS one).

Add a device tree binding for them.

Signed-off-by: Aleksandr Shubin <privatesub2@gmail.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/pwm/allwinner,sun20i-pwm.yaml    | 84 +++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml b/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
new file mode 100644
index 000000000000..89cebf7841a6
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
@@ -0,0 +1,84 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/allwinner,sun20i-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner D1, T113-S3 and R329 PWM
+
+maintainers:
+  - Aleksandr Shubin <privatesub2@gmail.com>
+  - Brandon Cheo Fusi <fusibrandon13@gmail.com>
+
+properties:
+  compatible:
+    oneOf:
+      - const: allwinner,sun20i-d1-pwm
+      - items:
+          - const: allwinner,sun50i-r329-pwm
+          - const: allwinner,sun20i-d1-pwm
+
+  reg:
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 3
+
+  clocks:
+    items:
+      - description: Bus clock
+      - description: 24 MHz oscillator
+      - description: APB clock
+
+  clock-names:
+    items:
+      - const: bus
+      - const: hosc
+      - const: apb
+
+  resets:
+    maxItems: 1
+
+  allwinner,pwm-channels:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: The number of PWM channels configured for this instance
+    enum: [6, 9]
+
+allOf:
+  - $ref: pwm.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: allwinner,sun50i-r329-pwm
+
+    then:
+      required:
+        - allwinner,pwm-channels
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - "#pwm-cells"
+  - clocks
+  - clock-names
+  - resets
+
+examples:
+  - |
+    #include <dt-bindings/clock/sun20i-d1-ccu.h>
+    #include <dt-bindings/reset/sun20i-d1-ccu.h>
+
+    pwm: pwm@2000c00 {
+      compatible = "allwinner,sun20i-d1-pwm";
+      reg = <0x02000c00 0x400>;
+      clocks = <&ccu CLK_BUS_PWM>, <&dcxo>, <&ccu CLK_APB0>;
+      clock-names = "bus", "hosc", "apb";
+      resets = <&ccu RST_BUS_PWM>;
+      #pwm-cells = <0x3>;
+    };
+
+...
-- 
2.25.1


