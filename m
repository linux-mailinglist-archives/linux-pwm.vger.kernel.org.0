Return-Path: <linux-pwm+bounces-2509-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E1390D44D
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jun 2024 16:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1A19B260A4
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jun 2024 14:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F3E15F40C;
	Tue, 18 Jun 2024 14:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpbcLNvO"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A77115F336;
	Tue, 18 Jun 2024 14:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719213; cv=none; b=JzsX2C0bCBqTcWxvOD37rnbeCv7Lp02/Twt5vUuwuzB/77QCSpt2ivBA12G3Rb1lgaWT/9pMhs9cllYACYyVzZgSm6PFYr8iHVWReTzKihSX5FAifIsNs7e69gjbEJRr1gMLCkjcCEOmkO0vGTMUdi6FZiRakD2wo77TX6d2nRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719213; c=relaxed/simple;
	bh=Y66wFEa+/wlFCoNMgoH3Eo5OCF3K3Yn5Lu+5vfjCL2I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QudtxTNmsvvWzeXgnVHMRXtpateNCVkJVMWkEBbkUNMxTCJFLgMZDg3thRw3Cf4i25QVYotHXcEVoWf+xrBjUiW7drduaDalxmhoO8uW0PMeIwTxfVTjrCraQRY2vnD85qfBCVPTKo03qGigHwGBXJeRHJ52ZNIrzT8IZt4/Nhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BpbcLNvO; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57a30dbdb7fso9710136a12.3;
        Tue, 18 Jun 2024 07:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718719210; x=1719324010; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VgQaqPAPGb+bVEVj1pLBF0jCvf+qjPwOAsG6IyI58go=;
        b=BpbcLNvOPB3FuXBQJdrjG7cWEXlOLvamb2MR2CUsPxfZuUEEOLQ8pilmHrzp4bH9Fb
         fnSLSrpR4LOxpZpbDKLmKKw6jEWKTEtUXOGNiwnGQAYzZSY0tzNBBNV2n68oQyOlPWE8
         kp0ws6kqAMeyIEzQKU3/SwL5UtbDg3VqEC37JuUyvotmlCC2ZaGa/tFQkJXoxe68vN9V
         DHk/O9KZk2Slf/TBeItPK1kIHPUFTgiFgz0BjGW3zV0VChv0QoK0u1kxxTyTDnRn0XXf
         JQevMFWvUbjqwhDvAVXjYPpdPk03wXTR/GpXBz7Fz3km2JSfZqBZ0llUFrggyPw/cSHz
         0J4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718719210; x=1719324010;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VgQaqPAPGb+bVEVj1pLBF0jCvf+qjPwOAsG6IyI58go=;
        b=dIT6q5XdHu5aNrO4py7as+l+ov3TshDnxq6hvi3C7OUJtruH9BYCXtSFa/M+6O6IQO
         I7gS1q2EzH/5kfUA5Tq0SBlJOWIaGF1oI1KiEEUtORIuJBYKjDSfTFF0fAZ6BVVb49WM
         zltfPDNNZM0bgNoYc0Ie61kwCq3ox1hXcNc6BrKiJ9kr1LUv22C6S+sCymonJmF05OQY
         7IO5tuwcxCiwSU6d/vqnxrZYxayHItSNBmcOZ/tWKtHlUcS2vtqdwlO8GrMWcPvrBDKR
         RVJu0lCEeQFYZnLZ5HlP6GJTJsu3m0pFj6JKQgKWvbtibknX1TrhpYivHesa4QugBV4P
         b4mA==
X-Forwarded-Encrypted: i=1; AJvYcCVhFYIBHPRknQ18jitSaj6a2ye1A2gkaI0zStoYQQCoA6VmZWh18dROFA+KI4/0+mmlWoSujYVvDdsS92k6wOEOqdCGquS2pvWQbFw8DjRz0NuJM+DZQiKBsGRE+jwr4LBNatevIbXmQemLFeWrWKEQ8cqKJQJNsg1OSUsqvTuya9WP0gHphQKndS3kkFPJJFZ4drJ9JBFYEx/mvoT/qPRbNjhezr+tuBMReaKeebToEMQJ0TNBE7DquHReS7w5LjhOzyb8A8CvTp5+ZInIFbWT2Nkv4TH7h8p5v3W7mKBrUKnrVY7eCa89Io8KMJGM3fYcWD9L8i5TzNJhmX9X3DPDtRTA8njT3vf/mhEWuQU6DPVeaooPvjMgePPOS1TCejAJ0LpVrwLQlpCYwUiblVZ6/9dMxAZz
X-Gm-Message-State: AOJu0YwTsbCA0jzqPrQ1/4UDwSOggcncPNmD+uMJjjp72Q2xXQYvQmc1
	+CGK/9hNFdq7Dh1ZKH6r5elU5YQqCqtkDoYGwV/nJUwwqNJYnpNk
X-Google-Smtp-Source: AGHT+IFsZidUuDC83rllt43NgpoJnd8N6/Hume+DefHGadiO2zxz9M/+d8rv7TFSqTnMWzBCuPFhMQ==
X-Received: by 2002:a50:bb23:0:b0:57a:858d:20ca with SMTP id 4fb4d7f45d1cf-57cbd69c599mr8823023a12.28.1718719210215;
        Tue, 18 Jun 2024 07:00:10 -0700 (PDT)
Received: from [127.0.1.1] (mm-167-232-122-178.mgts.dynamic.pppoe.byfly.by. [178.122.232.167])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72da156sm7731278a12.22.2024.06.18.07.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 07:00:09 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Tue, 18 Jun 2024 16:59:44 +0300
Subject: [PATCH v3 10/23] dt-bindings: regulator: add samsung,s2dos05
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240618-starqltechn_integration_upstream-v3-10-e3f6662017ac@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718719184; l=2160;
 i=dsankouski@gmail.com; s=20240618; h=from:subject:message-id;
 bh=Y66wFEa+/wlFCoNMgoH3Eo5OCF3K3Yn5Lu+5vfjCL2I=;
 b=MmAiVvvAM9kzhQvdhIh8BbDA1BIDVVPqgbidWXVZE2dtgE/cQvJDFpkqRG+X9UEIjnWkq+0i0
 EOqftdFX7nDAxqiKqhazJW3wsRUQmc2W+ttaYnbp0zIj8+YQVSN8guB
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=6pMMVVDDReSiRgPCbMOUauN5nS3ty4Sf5b7a2gi4x0M=

add samsung,s2dos05 regulator binding part

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
 .../bindings/regulator/samsung,s2dos05.yaml        | 36 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 37 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/samsung,s2dos05.yaml b/Documentation/devicetree/bindings/regulator/samsung,s2dos05.yaml
new file mode 100644
index 000000000000..4b8e4389329c
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/samsung,s2dos05.yaml
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/samsung,s2dos05.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung S2DOS05 Power Management IC Regulators
+
+maintainers:
+  - Dzmitry Sankouski <dsankouski@gmail.com>
+
+description:
+  This is a part of device tree bindings for S2M and S5M family of Power
+  Management IC (PMIC).
+
+  Has 4 LDO and 1 BUCK regulators, provides ELVDD, ELVSS, AVDD lines.
+
+  See also Documentation/devicetree/bindings/mfd/samsung,s2dos05.yaml for
+  additional information and example.
+
+properties:
+  compatible:
+    const: samsung,s2dos05-regulator
+
+patternProperties:
+  "^buck1|ldo[1-4]$":
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+
+    required:
+      - regulator-name
+
+additionalProperties: false
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 3ab41e53c9fc..92a5d0a56353 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19900,6 +19900,7 @@ F:	Documentation/devicetree/bindings/clock/samsung,s2mps11.yaml
 F:	Documentation/devicetree/bindings/mfd/samsung,s2dos*.yaml
 F:	Documentation/devicetree/bindings/mfd/samsung,s2m*.yaml
 F:	Documentation/devicetree/bindings/mfd/samsung,s5m*.yaml
+F:	Documentation/devicetree/bindings/regulator/samsung,s2dos*.yaml
 F:	Documentation/devicetree/bindings/regulator/samsung,s2m*.yaml
 F:	Documentation/devicetree/bindings/regulator/samsung,s5m*.yaml
 F:	drivers/clk/clk-s2mps11.c

-- 
2.39.2


