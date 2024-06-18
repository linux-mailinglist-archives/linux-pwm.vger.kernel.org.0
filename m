Return-Path: <linux-pwm+bounces-2503-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A62590D3E3
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jun 2024 16:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BE4D28753E
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jun 2024 14:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A711915B561;
	Tue, 18 Jun 2024 13:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AewqKV2P"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AB215B152;
	Tue, 18 Jun 2024 13:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719199; cv=none; b=o3r0SUnuY5NFFHJqM5Bwpi8FlAtMEc4v8XgnBFzpjM9B8HiVvdcDDNSq8s9EWi/byfGp59/+dw37/sKV7alJeRF/hzMq8pgf5qKNePp12HcIrJUGkgvo2H34a4yJhv0mTrx8qtJOcIL7XIJPIzL7EBh7xL1OoVNkI1rA/s/cSrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719199; c=relaxed/simple;
	bh=MaUBYzY2WY/OtOBoG9JKcNCjTiDo6fotvBHEhgKFVL8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PDejvRhLfm/nlwaY1MfynmqeepRClh1Sux4zpla799NuofVos0Bw+jj5ZFYjdeefrpPpelzFGVmdXStlMXtETFg8Tj59vNZ8VL/39GinF8p5n1u14OdCro6LwMAXkbrAnYtKr3/Q5D7SmUKNEyiAZe3RaKIORGrFFOk7QX//ks8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AewqKV2P; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57c75464e77so6757767a12.0;
        Tue, 18 Jun 2024 06:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718719196; x=1719323996; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZQdkm8+F4B6bFBNQodaWJBcqC8R3HTo/EbqUkgw994Y=;
        b=AewqKV2PIpS/cVWFbSH+XU5qdBS5mCadumK6XVbAt2dHuAYSX3LEdjyd8DBcZoeZxf
         2t4eC/HUzOGuI+qNbP/Ey0SfM7izt0iHbYJH4GaZmg24DqQdDAQRsj9ewc14Hkf5afsl
         m36Bp0zkreR7/wx7ZTSHu41URAUDOWsjpaoj+drWgSd7ncdJIhjR/u4xE7UwCMGhburY
         5T2pbLTzKY7V7wFulgIaBsM/pJMVQexIjb4lr1tA0oXExABnl2hjQOcCul4hHNb0+rJt
         1QWL1zg0goHE2trUbCeLwkAf98ViDPT/I8+XdLLYaqWkN4Ahm/Ng8Q32UvIlmy8djSi+
         BTrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718719196; x=1719323996;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZQdkm8+F4B6bFBNQodaWJBcqC8R3HTo/EbqUkgw994Y=;
        b=ZJJVizBpogeB+9BI92wLLQgSYXJGhw2Ma8ZpVCN+i6dxQI03zwlVUSBj+n6Ry1YulM
         UkEX63Z7nzlxDx2thVEg1jND7ofADjbUGSWHpD5lJbX4M8jV5w1ZPAS3oOrZs8OnipB3
         lyhygwE6UGx5YrQyhcgQLzlHGDxbYTROOgHvk9qdLrxTyQbgHcgG6vshm6RrbOJFh87h
         glePn+HWXUZUIE3cV8CrhYSxMOPeDlSMTTfcKqnlx+LkpMKXxqI0w/eWskgRD0yOj5UI
         DZu98FNbI5aZhMdQb/n4qjzOEc2V/mrpxK6S6DIZdeX2GImShROXwgYVBvX3IEG1LRrJ
         g9xA==
X-Forwarded-Encrypted: i=1; AJvYcCUEZVMzE29cd2kCGBW7+DJTl5UuFr91Nnp+N6rlpBiOblULuvtigsenDkIQ8r3a+XlBAW7kQTEfEHVELN/N6uvZNbbBQwwAk/JGT5rF61iKfZzhUX8n/4YhuyjEeI5RylFx09ZfIrrEsTVGzG7RtMX7evUAVFnpjNEwlrd0FuXn1/DbihJoBoV0Xesxo6/C3A0o+7/0gKjxr8s/5KGCDOxrw6gM3ZQhwJxnwQ9KATj45XhHcOTIFKtmfEVOFAMl5mvQdZbOu4CNXxWsKgJRY/9DFAliylRiIUxdcrCDVPTOEyr3c4JJ/eHdVXhv/gIvFoAdDuj+aIKvtL1M96TPm1ANiowZHDepfMaugG810SKTpmDG3sKlry54zwpTjTA+yrIY+j2j1lUsRVu3Mk633QIgKlC/SxC+
X-Gm-Message-State: AOJu0Ywu+6JRYd1Pwt0+lksf9hAIQktxcm/MxcZDVTiNDKjcMek4P1Jy
	Vwf5mnXqO/iPfQP6cIaA7vIfeFh4iNrg6xmcWYkEtTIGIuP74WdAROqMxtYc
X-Google-Smtp-Source: AGHT+IF6kH0YtvSPT4MaBaZOV0LLPUManxnMgMPB/xjZSsumWnmHYW99B3fvD3yZot9inNzwJ3g4tA==
X-Received: by 2002:a05:6402:28cc:b0:57c:d237:4fd with SMTP id 4fb4d7f45d1cf-57cd237059bmr6070351a12.4.1718719195988;
        Tue, 18 Jun 2024 06:59:55 -0700 (PDT)
Received: from [127.0.1.1] (mm-167-232-122-178.mgts.dynamic.pppoe.byfly.by. [178.122.232.167])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72da156sm7731278a12.22.2024.06.18.06.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 06:59:55 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Tue, 18 Jun 2024 16:59:38 +0300
Subject: [PATCH v3 04/23] dt-bindings: mfd: add maxim,max77705
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240618-starqltechn_integration_upstream-v3-4-e3f6662017ac@gmail.com>
References: <20240618-starqltechn_integration_upstream-v3-0-e3f6662017ac@gmail.com>
In-Reply-To: <20240618-starqltechn_integration_upstream-v3-0-e3f6662017ac@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>, phone-devel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
 linux-pwm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718719184; l=3812;
 i=dsankouski@gmail.com; s=20240618; h=from:subject:message-id;
 bh=MaUBYzY2WY/OtOBoG9JKcNCjTiDo6fotvBHEhgKFVL8=;
 b=kBr0hfj63DNZCcoJMRp3NdqL4vLs5OVhqtP9nRhL8IZsExqfYiNg80mksKZ6ciNZZYi+7gDBQ
 aTZ8nXPx505AJOdyQUWKd9jlnAdtRzTSiAiIVOCd6RVGxncdwXI0/M5
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=6pMMVVDDReSiRgPCbMOUauN5nS3ty4Sf5b7a2gi4x0M=

maxim,max77705 is MAX77705 pmic binding part

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
 .../devicetree/bindings/mfd/maxim,max77705.yaml    | 112 +++++++++++++++++++++
 MAINTAINERS                                        |   1 +
 2 files changed, 113 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/maxim,max77705.yaml b/Documentation/devicetree/bindings/mfd/maxim,max77705.yaml
new file mode 100644
index 000000000000..b54408e3d792
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/maxim,max77705.yaml
@@ -0,0 +1,112 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/maxim,max77705.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX77705 Companion Power Management IC and USB Type-C interface IC
+
+maintainers:
+  - Dzmitry Sankouski <dsankouski@gmail.com>
+
+description: |
+  This is a part of device tree bindings for Maxim MAX77705 multi functional device.
+
+  The Maxim MAX77705 is a Companion Power Management and Type-C interface IC which
+  includes charger, fuelgauge, LED, haptic motor driver and Type-C management IC.
+
+properties:
+  compatible:
+    const: maxim,max77705
+
+  reg:
+    description:
+      I2C device address.
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    description:
+      MAX77705 shared irq.
+    items:
+      - const: max77705_irq
+
+  charger:
+    $ref: /schemas/power/supply/maxim,max77705-charger.yaml
+
+  fuelgauge:
+    $ref: /schemas/power/supply/maxim,max77705-fg.yaml
+
+  haptic:
+    $ref: /schemas/input/maxim,max77705.yaml
+
+  leds:
+    $ref: /schemas/leds/maxim,max77705.yaml
+
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/leds/common.h>
+
+    i2c14 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+    	pmic@66 {
+    		compatible = "maxim,max77705";
+    		reg = <0x66>;
+    		interrupt-parent = <&pm8998_gpios>;
+    		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+    		interrupt-names = "max77705_irq";
+    		pinctrl-0 = <&chg_int_default>;
+    		pinctrl-names = "default";
+
+    		leds {
+    			compatible = "maxim,max77705-led";
+    			#address-cells = <1>;
+    			#size-cells = <0>;
+
+    			led@1 {
+    				reg = <1>;
+    				label = "red:usr1";
+    			};
+
+    			led@2 {
+    				reg = <2>;
+    				label = "green:usr2";
+    			};
+
+    			led@3 {
+    				reg = <3>;
+    				label = "blue:usr3";
+    			};
+    		};
+
+    		max77705_charger: charger {
+    			compatible = "maxim,max77705-charger";
+    			monitored-battery = <&battery>;
+    		};
+
+    		fuelgauge {
+    			compatible = "maxim,max77705-fg";
+    			monitored-battery = <&battery>;
+    			power-supplies = <&max77705_charger>;
+    			rsense = <5>;
+    		};
+
+
+    		haptic {
+    			compatible = "maxim,max77705-haptic";
+    			haptic-supply = <&vib_regulator>;
+    			pwms = <&vib_pwm 0 50000>;
+    		};
+    	};
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index fddbd50f7685..f008429033c9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13682,6 +13682,7 @@ B:	mailto:linux-samsung-soc@vger.kernel.org
 F:	Documentation/devicetree/bindings/*/maxim,max14577.yaml
 F:	Documentation/devicetree/bindings/*/maxim,max77686.yaml
 F:	Documentation/devicetree/bindings/*/maxim,max77693.yaml
+F:	Documentation/devicetree/bindings/*/maxim,max77705*.yaml
 F:	Documentation/devicetree/bindings/*/maxim,max77843.yaml
 F:	Documentation/devicetree/bindings/clock/maxim,max77686.txt
 F:	drivers/*/*max77843.c

-- 
2.39.2


