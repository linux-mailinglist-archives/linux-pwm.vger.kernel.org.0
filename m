Return-Path: <linux-pwm+bounces-2508-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B33F90D40B
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jun 2024 16:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2DD9287293
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jun 2024 14:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F6F15EFA1;
	Tue, 18 Jun 2024 14:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVuYx68U"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1912815ECF9;
	Tue, 18 Jun 2024 14:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719210; cv=none; b=BJsnc0JU1vf5OOBmIUpddwsRGx322QMdy8fGItwp112rg+onYLoVErtqSx8TQPofqHI2Iu5NwksMQKzq2PFYBfQreXddGFlv5RfZHyhyyfUZVp7N08vKgKcFybbVzodjJ0C9iESzYVHZ4DdtyIAjUbMvWb3zw8tyzzAa95Bgm+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719210; c=relaxed/simple;
	bh=GeSjdBMrPx5/NgT7rDPKCihsvNHSXF0w4Z/AktYQJMg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZbakU9RhvT8plVKz/tF1MxBboj7uqqmWFLZQTNnqZ9+F0CoaNNzi81TuvtZZ8tJc2p7evceWtumGuD4yLVrdBSyU4lmGikw1/detSh0U0ktGIqForSSu5W53Op/Gba8tApDiTfN36jjXFBoEd5KqWjDYRQkt9kdFrnr2B7sHRU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HVuYx68U; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57c75464e77so6758003a12.0;
        Tue, 18 Jun 2024 07:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718719207; x=1719324007; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=evq88jlvU8RulgmUy64jbhNijl81dqHkwYkJ8InB99k=;
        b=HVuYx68UIYBqOvBHiK7st63eHkHDVCbdXNh5qVZiAO9qYbdiCzSJ3cUbQZJ3rUWP22
         AouRSei1OjHsvJlV7aRv254ROq1CpS7L/63TSRJcMhSN1RMop0oPUqbfIijpVFaw8kIa
         3iaxELgv0OM0jl0izVvua4mHi6/rI5ZDv24NlGfEQcfVXbV36VACBed/OaUhKOC2tzVd
         FotEtmX0R7r2Bwi+CPRogyjnjxThK4ktPIcivp6ql0UHXByszkxuvQEcVsTscbbCfoMm
         0C+PpCk2P92lcJsVirMwsSQSk7iQ8QPgZgZqGgKyD2CRvTROuHqpPHSPn/VsZo+qaJNV
         PHig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718719207; x=1719324007;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=evq88jlvU8RulgmUy64jbhNijl81dqHkwYkJ8InB99k=;
        b=SWP1zma0XJYCPFI5laLnYrb9WLMLJX1au4yF8B4ZapI7JWCy65IA0q91O83ENQgCzO
         3ZSMsRFWkcmHBv+fzqxemRWHXhv3mS+kgYk0RogCxh2/tCy9QCSA7SqqJNRqutMmyTgT
         ox8oUB0YEt5+CgE1LGb3Hi38zzGo4wQzcwvYqZYPjPoFh74HrKB/PaiFZRZYU9RuOzrB
         pWgAoJ+y7zEuR8bKwojkBWbVCinsysGRf0goElt/NB8rOyAZsTAkYS239MGlKl5/IIF+
         hLOvVrEjBaRbvhkGFpXiE/C3iNsbEX/ZDLTdmNU6WwpPdc2cKz77pNWOZqAHEak93EFr
         t6KQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+6pcXnNXnWNxAuEFRqjSylG/WSetk8RtaVnvrO+a24OB5cuP0MsICI7u1dGcLVpNnXWC+V1cCixKXSbqXXQ98vJs9fD9tFXExFsDB4jlOiDfHMDhqtaljITAhluWDAEmudu4nITY897rEBqg55NpyPPNembZyK1jLqf7ND7ZHeAWbgap18kDj7YG/TvsOk0ZC5ZllrncciNIOw0AbckhlHgyPhoKHsqklQAQG/0PvzdyadmzniQPPs62h8Khq25H4LcQtD7zqe3KRlZAaXhUWWEeXbqtTbueDbka/fqfpTAS87t2J4DFVSOOBIk96ko9XTOKTtVfmxL2Je2PStIxAtyqhcXy4kP+7tG7+dDhfoi/N65qgB0hZ8TU+N79pRUoSegJlAX99yY2mG5r5LF31vQZlrRDx
X-Gm-Message-State: AOJu0YxMHojX3xqlzG59AUj3Hi+oE+8AyTg1LHVhP0/wik2KqvATzHB7
	O8ThCJNlgyJvjkHOjcwvYBsu5BPGva1zCNnphNG5SStIEyyAuXNd
X-Google-Smtp-Source: AGHT+IFilio5qKRl+cSnK8IQn5IAVmutaHGtgF17QZrcOlUnZe/40B0j5GGoC7IbWTgHhNsL8k7V6w==
X-Received: by 2002:a50:c19a:0:b0:57c:5f8a:26f8 with SMTP id 4fb4d7f45d1cf-57cbd6c6de0mr9000377a12.27.1718719207284;
        Tue, 18 Jun 2024 07:00:07 -0700 (PDT)
Received: from [127.0.1.1] (mm-167-232-122-178.mgts.dynamic.pppoe.byfly.by. [178.122.232.167])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72da156sm7731278a12.22.2024.06.18.07.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 07:00:07 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Tue, 18 Jun 2024 16:59:43 +0300
Subject: [PATCH v3 09/23] dt-bindings: mfd: add samsung,s2dos05
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240618-starqltechn_integration_upstream-v3-9-e3f6662017ac@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718719184; l=3596;
 i=dsankouski@gmail.com; s=20240618; h=from:subject:message-id;
 bh=GeSjdBMrPx5/NgT7rDPKCihsvNHSXF0w4Z/AktYQJMg=;
 b=SVRUeOlS2AnrVfvyQsE3+BYBfIEGACx1n7IrRdkctMOEdEgjj8rJD4eKceXUvtg1WRJSqgDNd
 jDU4o7csfmMCaF/woZolPqcOjzIaWS6mIu9Mc9Zuqq3a6UrHbBnN4LU
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=6pMMVVDDReSiRgPCbMOUauN5nS3ty4Sf5b7a2gi4x0M=

add samsung,s2dos05 core MFD module binding

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
 .../devicetree/bindings/mfd/samsung,s2dos05.yaml   | 89 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 90 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/samsung,s2dos05.yaml b/Documentation/devicetree/bindings/mfd/samsung,s2dos05.yaml
new file mode 100644
index 000000000000..f2ef5171cc40
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/samsung,s2dos05.yaml
@@ -0,0 +1,89 @@
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
+  This is a part of device tree bindings for S2M and S5M family of Power
+  Management IC (PMIC).
+
+  The S2DOS05 is a companion power management IC for the panel and touchscreen
+  in smart phones. Provides voltage and current regulators and adc for power/current
+  measurements.
+
+properties:
+  compatible:
+    const: samsung,s2dos05-pmic
+
+  reg:
+    maxItems: 1
+
+  regulators:
+    $ref: /schemas/regulator/samsung,s2dos05.yaml
+    description: List of regulators and its properties
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
+      	compatible = "samsung,s2dos05";
+      	reg = <0x60>;
+
+      	regulators {
+      		s2dos05_ldo1: s2dos05-ldo1 {
+      			regulator-name = "s2dos05-ldo1";
+      			regulator-min-microvolt = <1500000>;
+      			regulator-max-microvolt = <2000000>;
+      			regulator-active-discharge = <0x1>;
+      		};
+
+      		s2dos05_ldo2: s2dos05-ldo2 {
+      			regulator-name = "s2dos05-ldo2";
+      			regulator-min-microvolt = <1800000>;
+      			regulator-max-microvolt = <1800000>;
+      			regulator-active-discharge = <0x1>;
+      			regulator-boot-on;
+      		};
+
+      		s2dos05_ldo3: s2dos05-ldo3 {
+      			regulator-name = "s2dos05-ldo3";
+      			regulator-min-microvolt = <3000000>;
+      			regulator-max-microvolt = <3000000>;
+      			regulator-active-discharge = <0x1>;
+      			regulator-boot-on;
+      		};
+
+      		s2dos05_ldo4: s2dos05-ldo4 {
+      			regulator-name = "s2dos05-ldo4";
+      			regulator-min-microvolt = <2700000>;
+      			regulator-max-microvolt = <3775000>;
+      			regulator-active-discharge = <0x1>;
+      		};
+
+      		s2dos05_buck1: s2dos05-buck1 {
+      			regulator-name = "s2dos05-buck1";
+      			regulator-min-microvolt = <850000>;
+      			regulator-max-microvolt = <2100000>;
+      			regulator-active-discharge = <0x1>;
+      		};
+      	};
+      };
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index f008429033c9..3ab41e53c9fc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19897,6 +19897,7 @@ L:	linux-samsung-soc@vger.kernel.org
 S:	Maintained
 B:	mailto:linux-samsung-soc@vger.kernel.org
 F:	Documentation/devicetree/bindings/clock/samsung,s2mps11.yaml
+F:	Documentation/devicetree/bindings/mfd/samsung,s2dos*.yaml
 F:	Documentation/devicetree/bindings/mfd/samsung,s2m*.yaml
 F:	Documentation/devicetree/bindings/mfd/samsung,s5m*.yaml
 F:	Documentation/devicetree/bindings/regulator/samsung,s2m*.yaml

-- 
2.39.2


