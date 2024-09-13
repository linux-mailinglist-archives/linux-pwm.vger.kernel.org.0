Return-Path: <linux-pwm+bounces-3239-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F149783AD
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Sep 2024 17:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77AEB281320
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Sep 2024 15:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4EC82D66;
	Fri, 13 Sep 2024 15:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qa/Utu9q"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7432E8121F;
	Fri, 13 Sep 2024 15:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726240109; cv=none; b=ivxNY584J6iVS94LK0quhliayUwH0RlaaLCO3rCbyGy3jvNV60YeQuDankNM5pWMs/pm9BPG6oJvmtGV7D60aWX+TPONHcteY0O5qnhncGO/J04mwgFSLdlJW7SjkfeOcGcsgWmOO3/Hplm/Tnyet5SGW3mJTf0xflIbxeTLZaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726240109; c=relaxed/simple;
	bh=o6dr1Wo9Wqt+cqjXIx9vp714Hl+GKINdhrfYqTXSHMA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IcWMYy1PPgk+LKGVaUEqEGTkJqVSkpz5DYmoW2r53h8/HZ5abXsDqoI9EmdXqbM/h6aeyOD1Dh7c9K+k9kv7TGhz/wauhuXfLOcWINEZdO5OP9zidYDfbONMu1r+C9zLvQdS8UkAAebpB9s6Ujc8V0kJ8vYoiUqSz2ObB54X6VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qa/Utu9q; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f75de9a503so25909711fa.0;
        Fri, 13 Sep 2024 08:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726240105; x=1726844905; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+edNV2wnMqv6Fg14CUmntzU2d84+FrbyEUaBI7DKpMo=;
        b=Qa/Utu9qDGPfbzzQLPyLS1GzrZZd/eH+fp820xgciQURlbAsynZ0cSvLFDo5+BhleI
         lLvn2HYa3ksTy9liJf7HjIb86GNAqfIMI4MIiHGGTXiSyG/XCd4SSNnaPKQWVRpDSG1r
         BjHszLXuKS5En/4ygNObEaXORkfbyzPXzJK52bJnY1zS0GKwIqPR+MflqOZLqf22vRpx
         z2YYSAGY27TxSDPRL3lQCFHaeEzPDGbDktKlINj1XygLutsj2p+8UwLmCcbkeBUqItZ6
         MUSDFOsW3lJ7YDc2buPS03g4/VK1pHMkBxyLRi0OmA8VKi+14YWQag5/goew4hpOSPpF
         HP7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726240105; x=1726844905;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+edNV2wnMqv6Fg14CUmntzU2d84+FrbyEUaBI7DKpMo=;
        b=TlMElOkEtCGmaCS7z3GRuT0WvvDbNDM3SKWdlg6LItvUlCKzd3mazxGEfTQDNhRn3z
         Of1ARtjoBbEQIf/698Xeu1HXq6cD9z6j5Rl1GVoyYUDghOHb5x9ZbABFqn2xfILq+BYV
         bAgiGYXqGG3ajqcQcRYgtoO80LcR5cbNObJ0xTvNZpiyVHaKhgLmLTuwgPMxpkQMi2Zh
         AFyLTTh1t1RMLiKwRlUsnDzmPXZC4uLTgtpzv+IEG0/ttbStbqU0Qo4Cdlj/pRxMD1FR
         RLPyCbhUCkA7tg0ktl56Qa+P6pzlo2CWwYjzG6e8vgg5Nzt5LLXp3rzWUtyxJSzmDro5
         cPjg==
X-Forwarded-Encrypted: i=1; AJvYcCU9NE4kYNuH7BEAAuFhv/C1bgHs8edaQ9CC808dboGTbRV8c2EHB2bUatkpKBl7AkgbYTHlP4LVh5NqIedv@vger.kernel.org, AJvYcCUlTg87nUxRC22MxxpzamVZbAk6svACN3Q80acZM17jr5nCh/5eVtJ0z1gKGp6iYfJS06JYRAVmxrE2QMQ=@vger.kernel.org, AJvYcCVIndEIVxtxtFUGdRH+Ikb7so7rCjLSAWGVxzMRzOSKKQEAYcdg3Fon+v8reEkxEy8rR9+KJNN5dLejiA==@vger.kernel.org, AJvYcCW5YIzqbf8UGgLe9dqThyZ2jYq7WreVTAoB/glQ2PhBt2yL0Wg0kIIIgAewbXD8EN1zCu+HDdi/A+NJ6YZC8sqMoPg=@vger.kernel.org, AJvYcCWQq5iGExCdI3XdmJKi4OGc12+OMQsRIwtvyVgx3uOQDo2yqo67yS678NcUSXOnhAgSHjOE/MaLsGUd@vger.kernel.org, AJvYcCWzJDg/kHBKo7gwmwa9+s/UsbJr7zMueEKdaryyX19P449rQDBC8/mY/OKIniDPLVocQIpLIbEv9Thw@vger.kernel.org, AJvYcCXTqylcSPT+frQ59VM4nrWvpbH1puBtkpSspep+JTcgWbjlqOsapTsC+uj9zpFX5+Ntj6RE4VFDe6Mv@vger.kernel.org, AJvYcCXiPiIJqjwVo5ZrkHFlRr42OwMuf0H6v4UtolADdHileXsRLU7hnVmjdUcGgdgS/xkXQDzE8KKKipyJiYjrsQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzwJrukqCUDuyhOSvmQweAaBOPHtbuzQkreFG4ib5V0uWudX4qQ
	oAAO0py8woCYIr/XO4gf4eDjQvxtt4G4GDpwxewtr5UV8gjoi5MfPlPRDw==
X-Google-Smtp-Source: AGHT+IHJOpfVbc6BYoC9nxodPjUjSuvVPJgxKnP5qJAz/k4ls2c3ki4U+1IXN1TI74WxFMntTOIIqg==
X-Received: by 2002:a05:651c:199e:b0:2ef:20ae:d113 with SMTP id 38308e7fff4ca-2f787f576a1mr45655381fa.40.1726240105287;
        Fri, 13 Sep 2024 08:08:25 -0700 (PDT)
Received: from [127.0.1.1] ([178.127.153.210])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd523b4sm7774318a12.51.2024.09.13.08.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 08:08:25 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Fri, 13 Sep 2024 18:07:49 +0300
Subject: [PATCH v4 06/27] dt-bindings: mfd: add samsung,s2dos05
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-starqltechn_integration_upstream-v4-6-2d2efd5c5877@gmail.com>
References: <20240913-starqltechn_integration_upstream-v4-0-2d2efd5c5877@gmail.com>
In-Reply-To: <20240913-starqltechn_integration_upstream-v4-0-2d2efd5c5877@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, 
 Simona Vetter <simona@ffwll.ch>, cros-qcom-dts-watchers@chromium.org, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Simona Vetter <simona.vetter@ffwll.ch>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
 linux-pwm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726240085; l=4210;
 i=dsankouski@gmail.com; s=20240618; h=from:subject:message-id;
 bh=o6dr1Wo9Wqt+cqjXIx9vp714Hl+GKINdhrfYqTXSHMA=;
 b=ESIv0Ef7vJug1EWhzW4zYha8Jn3CIRqEafH3ehASUYvcOs4iTAniGnkuPXv4sfkLu+26qeFO9
 Gf09Xk2+ldLCch9wTgtTHevbF4LCFvNWhakoDZ1ika/3N66fQKyru5F
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=6pMMVVDDReSiRgPCbMOUauN5nS3ty4Sf5b7a2gi4x0M=

Add samsung,s2dos05 MFD module binding.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>

---
Changes in v4:
- split long(>80) lines
- fix indentation
- merge with regulators binding
- drop pmic suffix
- drop unused labels in example
- correct description
---
 .../devicetree/bindings/mfd/samsung,s2dos05.yaml   | 99 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 100 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/samsung,s2dos05.yaml b/Documentation/devicetree/bindings/mfd/samsung,s2dos05.yaml
new file mode 100644
index 000000000000..534434002045
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/samsung,s2dos05.yaml
@@ -0,0 +1,99 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/samsung,s2dos05.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung S2DOS05 Power Management IC
+
+maintainers:
+  - Dzmitry Sankouski <dsankouski@gmail.com>
+
+description:
+  This is a device tree bindings for S2DOS family of Power Management IC (PMIC).
+
+  The S2DOS05 is a companion power management IC for the panel and touchscreen
+  in smart phones. Provides voltage regulators and
+  ADC for power/current measurements.
+
+  Regulator section has 4 LDO and 1 BUCK regulators and also
+  provides ELVDD, ELVSS, AVDD lines.
+
+properties:
+  compatible:
+    const: samsung,s2dos05
+
+  reg:
+    maxItems: 1
+
+  regulators:
+    patternProperties:
+      "^buck1|ldo[1-4]$":
+        type: object
+        $ref: /schemas/regulator/regulator.yaml#
+        unevaluatedProperties: false
+
+        required:
+          - regulator-name
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - regulators
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      pmic@60 {
+        compatible = "samsung,s2dos05";
+        reg = <0x60>;
+
+            regulators {
+                ldo1 {
+                    regulator-name = "s2dos05-ldo1";
+                    regulator-min-microvolt = <1500000>;
+                    regulator-max-microvolt = <2000000>;
+                    regulator-active-discharge = <0x1>;
+                };
+
+                ldo2 {
+                    regulator-name = "s2dos05-ldo2";
+                    regulator-min-microvolt = <1800000>;
+                    regulator-max-microvolt = <1800000>;
+                    regulator-active-discharge = <0x1>;
+                    regulator-boot-on;
+                };
+
+                ldo3 {
+                    regulator-name = "s2dos05-ldo3";
+                    regulator-min-microvolt = <3000000>;
+                    regulator-max-microvolt = <3000000>;
+                    regulator-active-discharge = <0x1>;
+                    regulator-boot-on;
+                };
+
+                ldo4 {
+                    regulator-name = "s2dos05-ldo4";
+                    regulator-min-microvolt = <2700000>;
+                    regulator-max-microvolt = <3775000>;
+                    regulator-active-discharge = <0x1>;
+                };
+
+                buck1 {
+                    regulator-name = "s2dos05-buck1";
+                    regulator-min-microvolt = <850000>;
+                    regulator-max-microvolt = <2100000>;
+                    regulator-active-discharge = <0x1>;
+                };
+            };
+        };
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 59d027591e34..92135252264a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20465,6 +20465,7 @@ L:	linux-samsung-soc@vger.kernel.org
 S:	Maintained
 B:	mailto:linux-samsung-soc@vger.kernel.org
 F:	Documentation/devicetree/bindings/clock/samsung,s2mps11.yaml
+F:	Documentation/devicetree/bindings/mfd/samsung,s2dos*.yaml
 F:	Documentation/devicetree/bindings/mfd/samsung,s2m*.yaml
 F:	Documentation/devicetree/bindings/mfd/samsung,s5m*.yaml
 F:	Documentation/devicetree/bindings/regulator/samsung,s2m*.yaml

-- 
2.39.2


