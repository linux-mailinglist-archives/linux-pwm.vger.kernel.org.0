Return-Path: <linux-pwm+bounces-2502-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 872E790D3DA
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jun 2024 16:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C0DD1C23566
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jun 2024 14:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEA715B132;
	Tue, 18 Jun 2024 13:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrwJ/pwR"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11BA13BC3F;
	Tue, 18 Jun 2024 13:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719197; cv=none; b=EjOrotgHX8j5LewE0hfg3Qe5bkI1kxRtaIhFRF3SppgCosPNQ3xHSNqa81I0hoDiyqAPuD5hzYs0ET6Vea8UXK0zNA+tsh7QiTK+mxIOCtkk0++ixVhZxIncnmgqxmnv7Ar46rdJKwFCnw68gPJc5TjGtx1R+yJSDKN0QRqOJSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719197; c=relaxed/simple;
	bh=u/o9BG9AqKYLWAUPHxzLUOD2JYdWbpPwReHpmt6QtHE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A50dHY1/5+UT9zPrBN7FP4x1hB5lQ1ZKRDTqTc0RKi6Y892o43S4QFnSOuyBuldTLHosJfsEpTNchZo4XB1ZUA0l5gdrR48nDfbTIUwa7KJewz4n8mBzxN3jrEuj4GfkQe1dCk6YW8/mKAHndOr64f2o/XgcuobGqWGol1FKTQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KrwJ/pwR; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a6f51660223so328313766b.0;
        Tue, 18 Jun 2024 06:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718719194; x=1719323994; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hjTOnao2jgs0TbPexQcL6nA3LicQJeUCbeGc7Ge6OXc=;
        b=KrwJ/pwR8Vtomprnh32p4KwSpFYbigm6FUoffQN2anSjXsOHco+oSCqeGqepD9wTkA
         /eXn3TiCLOy1hl3+l7ibrSS+sZaIMb9TVOOpgDA38w+WAbvdBDXCo9859zgn2KnIF98A
         G83bq9PlUEli0ND1fmSfeGBruRzq3YWzzgvGZPDSblAqW2PWpSA9hmuAw2u/SPg8li9U
         BRwczZB9+c6eE3KO/I833dQZcv+448yDo7iVeDFdCvZqpUWa1bqtNcX1XccPRn/Vbt4M
         l2io48PhY3Q/DJ4KxdaFr7mXxYbjhPiX1XTyfn+BTdxfXR/RVcL4LWpfbbMk1s0mluAg
         iwlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718719194; x=1719323994;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hjTOnao2jgs0TbPexQcL6nA3LicQJeUCbeGc7Ge6OXc=;
        b=usqN8PvhlgP8w6uX2MAfPgD4qRVTbOyb4eWG44qAbhs01VWNZ6LrnPa147ecbj/Fhb
         pDYNpwM4iRyAKO+nEETjvBdfJUwwVXuNULCSt7wekxH7QR55hyS83MaBDv92jiz7zfQN
         zdfQRssAC9uqUixOdqvmBXate2rAKTunfp1tdL7emZk6XQ2rEdVCOUrbVvNjqk359ir2
         nNoTg9X/6E4MlfUhht34vftD3X4YkDaQJNjRsQfYr2a0B4Y7srP+ImXYL920TZbCrjq+
         AIcmcU6+MTemyHtiUhA0KPhZcCIHK8OlxpJqB+5EXWTaR034Oc2pmwvporOl/W9Yvlkm
         4Saw==
X-Forwarded-Encrypted: i=1; AJvYcCVlAk6KyzeWGHlwaD5JDW3ndzKJEg17Tp8XcF9sJc13QLezaZ8F1UnJ466wBMh19enVGQrESU/M99DD/sj6eVZhZW08eurZtc7+w/LWudwmBfM0ckDvabkT4MbsW7dFATH3f4xvGty5KYbj9bhh40rvYlR8MF2RE3/0LZ1PJWrwkP8OqQ4lOospO6WUty/5rT9z8iMs0EPAeepOW0eouDAeuIvt1THPJuM2CBHiLmTtv+dLkcbNPxD0CiHKu7+M/qtnOhaLhpi4MSC2fYpzgeL/34jkD7uT0Uc/3LP8ejYRgrlZ0IgvrKUop116xl8iOQT0utD+AIpNNsJ85l0g20eEewV7cFqhejtV08rzIkoFwdExVcbCyoJqt/A91YP3M4Mh6YCt2GXZ1Pntw+nj2A5CtHJXBp3u
X-Gm-Message-State: AOJu0Yw9YAllEd5Z0eHnFsOtlNML5jhvNb44D0dyV818Dvv1Oe7mlF0l
	snG+CJA37hCe3IOYngKnlQ3TJISyxar7L5tA6a37W/2Y3RSlq9wz
X-Google-Smtp-Source: AGHT+IFEcN8FjKFZhcaPR3K37rXFvtBAVhD0dgg++WL+CT9QX+9G7TKsgbcNessmzcPjrqqULcHuug==
X-Received: by 2002:a50:96cf:0:b0:57c:6861:d731 with SMTP id 4fb4d7f45d1cf-57cbd6c7457mr9478897a12.28.1718719193759;
        Tue, 18 Jun 2024 06:59:53 -0700 (PDT)
Received: from [127.0.1.1] (mm-167-232-122-178.mgts.dynamic.pppoe.byfly.by. [178.122.232.167])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72da156sm7731278a12.22.2024.06.18.06.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 06:59:53 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Tue, 18 Jun 2024 16:59:37 +0300
Subject: [PATCH v3 03/23] dt-bindings: panel: add Samsung s6e3ha8
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240618-starqltechn_integration_upstream-v3-3-e3f6662017ac@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718719184; l=2883;
 i=dsankouski@gmail.com; s=20240618; h=from:subject:message-id;
 bh=u/o9BG9AqKYLWAUPHxzLUOD2JYdWbpPwReHpmt6QtHE=;
 b=g50eS59XNhy8Hz/rQYUxaUeykF5WKEEvQYvtP+VPrwrvnuKg4KD3zx6UKrGwX1D8tekXKo86t
 ocpTGcK5tVDAVNDxhWjwlgaYobX1nnwFwmG4bfa4toG4sAnckh+ziPk
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=6pMMVVDDReSiRgPCbMOUauN5nS3ty4Sf5b7a2gi4x0M=

Add binding for the Samsung s6e3ha8 panel found in the Samsung S9.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
 .../bindings/display/panel/samsung,s6e3ha8.yaml    | 76 ++++++++++++++++++++++
 MAINTAINERS                                        |  5 ++
 2 files changed, 81 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6e3ha8.yaml b/Documentation/devicetree/bindings/display/panel/samsung,s6e3ha8.yaml
new file mode 100644
index 000000000000..9d7d747264dd
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/samsung,s6e3ha8.yaml
@@ -0,0 +1,76 @@
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
+  reset-gpios:
+    description: reset gpio
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
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      panel@0 {
+      	compatible = "samsung,s6e3ha8";
+      	reg = <0>;
+      	vci-supply = <&s2dos05_ldo4>;
+      	vddr-supply = <&s2dos05_buck1>;
+      	vdd3-supply = <&s2dos05_ldo1>;
+      	te-gpios = <&tlmm 10 GPIO_ACTIVE_HIGH>;
+      	reset-gpios = <&tlmm 6 GPIO_ACTIVE_HIGH>;
+      	pinctrl-0 = <&sde_dsi_active &sde_te_active_sleep>;
+      	pinctrl-1 = <&sde_dsi_suspend &sde_te_active_sleep>;
+      	pinctrl-names = "default", "sleep";
+
+      	port {
+      		panel_in: endpoint {
+      			remote-endpoint = <&mdss_dsi0_out>;
+      		};
+      	};
+      };
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index a2f416e4a7c6..fddbd50f7685 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7150,6 +7150,11 @@ S:	Maintained
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


