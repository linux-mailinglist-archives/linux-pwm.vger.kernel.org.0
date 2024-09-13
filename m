Return-Path: <linux-pwm+bounces-3237-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 328A0978398
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Sep 2024 17:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1C5B1F215B0
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Sep 2024 15:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEA577F2F;
	Fri, 13 Sep 2024 15:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPNKMI/A"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E109B76F1B;
	Fri, 13 Sep 2024 15:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726240104; cv=none; b=bPcd8cK3mjejrykg8NL7nSRWCG0EBOOGrSEdQ3p84icuQoAkS1g/IWmHrMc9R8XO2jApmTj5TzAl4wP2O91TVFXpDpfApQZfUu1tA6OWODFU8t+OPnpLJ2E5Wbw/7+WfgM326ZoHIvhg3807B5+V5Zg+TSz3xCXM3w3pL9RIn3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726240104; c=relaxed/simple;
	bh=lHC11SnBOPQNkFZuoSqA2ydkUDzKzto52kps1UXs5lY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z9XKYQsa4s2a+JHweUoAPslUncQjV8HQlMcwSMiiPUfUHg0dpjAon0JI9GiGJvb59ZNUx0iTQV65AFTu+0+IjAxayVIj7bmXQGZ3v6d14HfWSdF8zLlh9nfX6wkr/2WvezWDgpqF4uaH11CtApuXsar4JmcSUiUCorfsyIszjO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPNKMI/A; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f74e468baeso14253591fa.2;
        Fri, 13 Sep 2024 08:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726240101; x=1726844901; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wMPOrMm8jMnc3632xlKhYJc7ApymMUVT8Ea4A90ExoA=;
        b=mPNKMI/AX72ILT1VJidtCr1G+G4zJ/susofBXCeXgmSccCjdCH3jSWiyfriyBKMCsa
         HU0OihLmfR91dwS5LYqofp0Js6Cui/7VjI6dHb/P7rVkO9EfesXAMb61OqgWVhtap2vj
         kLwhGQEWiXb6ysHVb2y1hCelxgR6DWHxOl8+PR8epEnLfDHgxryK6Hxlw8Jz25uHtahT
         UT+UCUdy+gnQq/8Jzc9PdBr04YrLkhBRIynyJxSi5QAcgFHV1IbhwjzicxYHQDn5O3tl
         B7feBu3wBMOqmuveRt6/0Q/sRe4RUIu6OhGkAxlUnkMgvjZ9EnISj3y241RusmufEg/X
         jJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726240101; x=1726844901;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wMPOrMm8jMnc3632xlKhYJc7ApymMUVT8Ea4A90ExoA=;
        b=CDo4CEzFNqGZfbsqlA5YelMxjHBm5qhUAGyFxN0T7FWcRz9adkaltfgu8yXMhm0a+4
         rA6WTWgvAhs0FPb+10AeY1cUqq4HKsU6mLulAtwWoTPkdOfw91LeTM9gAOf5w7yLhBFK
         HJrrLu6HLZKxSGqIUw5yNl7jHPOBHo2cmtLzqkzgYVEAhjxTBUuN7XgllzcMbRGp5uqZ
         J7WshFs6Mef86/2xbLzHK/XoX9Ef3BFiqIMn2jQzIGDeH20v2fEYvQ4LMPaHE5XG+SKh
         vzrSH3BdM5NdJMi3emiF0xxFqpi5OtOkScg9l254n8Y7JPH6iMKBssCuow6YQ+5SFdwt
         0T0g==
X-Forwarded-Encrypted: i=1; AJvYcCU56thdkn2oWCufgM/EmVqYsBLqd7yMcbBUj2dEnjrsdiifYIhN4KBXvag7A0NchVXG3/0be+oQlCglda7eTA==@vger.kernel.org, AJvYcCUOivfnDfdU+olV9Yd0czXSfFyVzhl8cQSm1pMFJ/By9GjDYY0xNOTtG1Mk/A4Egvb/yfQNPkt/fOOy@vger.kernel.org, AJvYcCUf8gqPf7cTYHc/l+f9zMC/gpJudB1J1QYa7e1FxLcXJ6ADvinJDT3JRVnWuKzs89hIziyGfxySgjRV@vger.kernel.org, AJvYcCUnzLgShR2X+413qJsLwcs2SWTz/NoeRlW1wXSZOdBY5f6MnaCK29qWVI0nAu04GxeOCGThs+AXm8GBAQ==@vger.kernel.org, AJvYcCUrXfso5IY2Sjy3ik4W4Qnv9Ax/wdkA0wVh4e2nkKRnh5hQFBiTRBbGrY5ZrMko5P2dix8AtCntUw9L3gs=@vger.kernel.org, AJvYcCVBaG8g09Qf5KJjDuI+HozFMgjmYS+PSY7cjSDUBxrJl2fny5g9ru8HhoDDDwfPAYj0p7cLmpz4E/w9@vger.kernel.org, AJvYcCVuRZj3pzRQNvix917qouZahPp7C5IlDGifqJlMG16tWs/9/mwcF6FKddqOoxt9q/QfaoCrSFsdWGSJsIEt@vger.kernel.org, AJvYcCWiZLD+nflOrruCh/dH0ipU94RCsFpNp1lAEN4LM5di9rLqhwbyG8IafH8MuGV9PsN8ssUjveDL7fVspBtph6q8+bw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSJ2iLE6rSO482SfcxAMr915OCUenG3r1+nU7ciNlX7CQFHxTL
	TMg4CJyclN2d2zYjDlV+DDa28aLq6+M+XILJnicG1H4Pov09+2KZWq9Dcw==
X-Google-Smtp-Source: AGHT+IHOq0ajhiiX6/2VDkjD7OIJvbRCL5YZQQ8Umg2mhAbHCC7u57QfKrIJ12XBt8uKlJFFSVh4Dw==
X-Received: by 2002:a2e:742:0:b0:2f7:58bc:f4a9 with SMTP id 38308e7fff4ca-2f791a0240dmr14340641fa.22.1726240100649;
        Fri, 13 Sep 2024 08:08:20 -0700 (PDT)
Received: from [127.0.1.1] ([178.127.153.210])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd523b4sm7774318a12.51.2024.09.13.08.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 08:08:20 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Fri, 13 Sep 2024 18:07:47 +0300
Subject: [PATCH v4 04/27] dt-bindings: panel: add Samsung s6e3ha8
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-starqltechn_integration_upstream-v4-4-2d2efd5c5877@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726240085; l=3064;
 i=dsankouski@gmail.com; s=20240618; h=from:subject:message-id;
 bh=lHC11SnBOPQNkFZuoSqA2ydkUDzKzto52kps1UXs5lY=;
 b=jrZn354suum7/Hl3EqQfo4nUjsVOjlJpUtGAs4oA02Z5jNsaEdnyp9+LALkOuEXzg4g+kRD6F
 bQbl+GqoobHDb+a4BWfUNyHCkRBfDKaSiwpo1UEHKMmNnNi444+otJO
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=6pMMVVDDReSiRgPCbMOUauN5nS3ty4Sf5b7a2gi4x0M=

Add binding for the Samsung s6e3ha8 panel found in the Samsung S9.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>

---
Changes in v4:
- change dts example intendation from tabs
 to spaces
- remove reset-gpios description
---
 .../bindings/display/panel/samsung,s6e3ha8.yaml    | 75 ++++++++++++++++++++++
 MAINTAINERS                                        |  5 ++
 2 files changed, 80 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6e3ha8.yaml b/Documentation/devicetree/bindings/display/panel/samsung,s6e3ha8.yaml
new file mode 100644
index 000000000000..94c812e07571
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/samsung,s6e3ha8.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/samsung,s6e3ha8.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung s6e3ha8 AMOLED DSI panel
+
+description: The s6e3ha8 is a 1440x2960 DPI display panel from Samsung Mobile
+  Displays (SMD).
+
+maintainers:
+  - Dzmitry Sankouski <dsankouski@gmail.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: samsung,s6e3ha8
+
+  reg:
+    maxItems: 1
+
+  reset-gpios: true
+
+  port: true
+
+  vdd3-supply:
+    description: VDD regulator
+
+  vci-supply:
+    description: VCI regulator
+
+  vddr-supply:
+    description: VDDR regulator
+
+required:
+  - compatible
+  - reset-gpios
+  - vdd3-supply
+  - vddr-supply
+  - vci-supply
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    dsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@0 {
+            compatible = "samsung,s6e3ha8";
+            reg = <0>;
+            vci-supply = <&s2dos05_ldo4>;
+            vddr-supply = <&s2dos05_buck1>;
+            vdd3-supply = <&s2dos05_ldo1>;
+            te-gpios = <&tlmm 10 GPIO_ACTIVE_HIGH>;
+            reset-gpios = <&tlmm 6 GPIO_ACTIVE_HIGH>;
+            pinctrl-0 = <&sde_dsi_active &sde_te_active_sleep>;
+            pinctrl-1 = <&sde_dsi_suspend &sde_te_active_sleep>;
+            pinctrl-names = "default", "sleep";
+
+            port {
+                panel_in: endpoint {
+                    remote-endpoint = <&mdss_dsi0_out>;
+                };
+            };
+      };
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 52b72d212c18..b65cfa1d322d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7381,6 +7381,11 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/display/panel/samsung,s6d7aa0.yaml
 F:	drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c
 
+DRM DRIVER FOR SAMSUNG S6E3HA8 PANELS
+M:	Dzmitry Sankouski <dsankouski@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/display/panel/samsung,s6e3ha8.yaml
+
 DRM DRIVER FOR SITRONIX ST7586 PANELS
 M:	David Lechner <david@lechnology.com>
 S:	Maintained

-- 
2.39.2


