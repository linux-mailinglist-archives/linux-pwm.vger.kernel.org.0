Return-Path: <linux-pwm+bounces-240-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3AE7FD85A
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Nov 2023 14:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AFD21C20F22
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Nov 2023 13:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE65F20B14;
	Wed, 29 Nov 2023 13:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PR3NUmXg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE98EDE
	for <linux-pwm@vger.kernel.org>; Wed, 29 Nov 2023 05:40:32 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c9c18e7990so5721671fa.2
        for <linux-pwm@vger.kernel.org>; Wed, 29 Nov 2023 05:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1701265231; x=1701870031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dNV0r1tk7i0wstK5L78tpqt0TYtEG6tPq8iOAeVFOuU=;
        b=PR3NUmXggT3VAc2Q9lPcRj3wE/QB8VSIu04RTsr7v8NVdOQyXdHmj3XKr+BCKDXH7O
         ZypBSTkOq6toplifydqrYTstPKQRuSY8XTxRCWQVmEpDHXJOB/WagnXap7Qyk/ahrW5m
         vek7mm4Uzttnu1TH6ULjdVLKmrsgwIgrcOiHVg/3SilJkKvJD/kLrP7Abm0i7NWJ5SAZ
         vMUpq8av6xu9geJzHgd752LCtqIX1kHysqPa0X6a/HHPH1c4UIGDQRIc38yOVN/Kce94
         x/31TOoGWUOW/s/WApBpbAHRmIwnhdNcN751ynhinSP+2OS5U2+CH4YugB/RYnrz7grv
         qchg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701265231; x=1701870031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dNV0r1tk7i0wstK5L78tpqt0TYtEG6tPq8iOAeVFOuU=;
        b=RQulCTTEBEp+PRh9/9CmHJRWgK+BbX75zeF2w3yFolKU4fn6VVFQ6iHk3Wm2l/kEit
         oUDdx84yZ4GJqRCNIMR+HP4X5xoEEDDtEU7Qce5qlLKh9/f9ERo2auR8dlr6kgPuYhhN
         XcCfwW5TchxebN8lfAXJv1zQ9V6mnHKR4fikCrHNsrOZ8Rn72iKf1hvodDRzDgZQpfD/
         UYvlSrHoR3mApYkllF1tKpBOPGywAg7uTs2PtfuhD/AYycH0rrresviquaLekm/f+QOx
         jtmjTN+AEV/HQULtHq0RyCowo1HGLEIll80iWbs/67k+Kimm5JpTNlvlPngcgw9OOd6g
         2sJw==
X-Gm-Message-State: AOJu0YzeRJJe6s7tPhIj6plJKU83q0IzXrhhbCuUdDD7ac2QlYVnTIdt
	8yXuxYNbUCA0KW80rY/6CkNC1Q==
X-Google-Smtp-Source: AGHT+IG9Ttru1ruXIsW674i0vE1QI20t43Hug+5XJhyzfmCgdCqgGynOwZI682I9zwA4RbLZ0btt3A==
X-Received: by 2002:a05:651c:c85:b0:2c9:9376:1ae7 with SMTP id bz5-20020a05651c0c8500b002c993761ae7mr11736281ljb.28.1701265231148;
        Wed, 29 Nov 2023 05:40:31 -0800 (PST)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:6101:5529:fe2d:d7eb])
        by smtp.googlemail.com with ESMTPSA id w17-20020a05600c475100b004080f0376a0sm2285860wmo.42.2023.11.29.05.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 05:40:30 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Thierry Reding <thierry.reding@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-pwm@vger.kernel.org,
	JunYi Zhao <junyi.zhao@amlogic.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/4] dt-bindings: pwm: amlogic: fix s4 bindings
Date: Wed, 29 Nov 2023 14:39:57 +0100
Message-ID: <20231129134004.3642121-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231129134004.3642121-1-jbrunet@baylibre.com>
References: <20231129134004.3642121-1-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

s4 has been added to the compatible list while converting the Amlogic PWM
binding documentation from txt to yaml.

However, on the s4, the clock bindings have different meaning compared to
the previous SoCs.

On the previous SoCs the clock bindings used to describe which input the
PWM channel multiplexer should pick among its possible parents.

This is very much tied to the driver implementation, instead of describing
the HW for what it is. When support for the Amlogic PWM was first added,
how to deal with clocks through DT was not as clear as it nowadays.
The Linux driver now ignores this DT setting, but still relies on the
hard-coded list of clock sources.

On the s4, the input multiplexer is gone. The clock bindings actually
describe the clock as it exists, not a setting. The property has a
different meaning, even if it is still 2 clocks and it would pass the check
when support is actually added.

Also the s4 cannot work if the clocks are not provided, so the property no
longer optional.

Finally, for once it makes sense to see the input as being numbered
somehow. No need to bother with clock-names on the s4 type of PWM.

Fixes: 43a1c4ff3977 ("dt-bindings: pwm: Convert Amlogic Meson PWM binding")
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../devicetree/bindings/pwm/pwm-amlogic.yaml  | 69 ++++++++++++++++---
 1 file changed, 60 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
index 527864a4d855..387976ed36d5 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
+++ b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
@@ -9,9 +9,6 @@ title: Amlogic PWM
 maintainers:
   - Heiner Kallweit <hkallweit1@gmail.com>
 
-allOf:
-  - $ref: pwm.yaml#
-
 properties:
   compatible:
     oneOf:
@@ -43,12 +40,8 @@ properties:
     maxItems: 2
 
   clock-names:
-    oneOf:
-      - items:
-          - enum: [clkin0, clkin1]
-      - items:
-          - const: clkin0
-          - const: clkin1
+    minItems: 1
+    maxItems: 2
 
   "#pwm-cells":
     const: 3
@@ -57,6 +50,57 @@ required:
   - compatible
   - reg
 
+allOf:
+  - $ref: pwm.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - amlogic,meson8-pwm
+              - amlogic,meson8b-pwm
+              - amlogic,meson-gxbb-pwm
+              - amlogic,meson-gxbb-ao-pwm
+              - amlogic,meson-axg-ee-pwm
+              - amlogic,meson-axg-ao-pwm
+              - amlogic,meson-g12a-ee-pwm
+              - amlogic,meson-g12a-ao-pwm-ab
+              - amlogic,meson-g12a-ao-pwm-cd
+              - amlogic,meson-gx-pwm
+              - amlogic,meson-gx-ao-pwm
+    then:
+      # Historic bindings tied to the driver implementation
+      # The clocks provided here are meant to be matched with the input
+      # known (hard-coded) in the driver and used to select pwm clock
+      # source. Currently, the linux driver ignores this.
+      properties:
+        clock-names:
+          oneOf:
+            - items:
+                - enum: [clkin0, clkin1]
+            - items:
+                - const: clkin0
+                - const: clkin1
+
+  # Newer IP block take a single input per channel, instead of 4 inputs
+  # for both channels
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - amlogic,meson-s4-pwm
+    then:
+      properties:
+        clocks:
+          items:
+            - description: input clock of PWM channel A
+            - description: input clock of PWM channel B
+        clock-names: false
+      required:
+        - clocks
+
 additionalProperties: false
 
 examples:
@@ -68,3 +112,10 @@ examples:
       clock-names = "clkin0", "clkin1";
       #pwm-cells = <3>;
     };
+  - |
+    pwm@1000 {
+      compatible = "amlogic,meson-s4-pwm";
+      reg = <0x1000 0x10>;
+      clocks = <&pwm_src_a>, <&pwm_src_b>;
+      #pwm-cells = <3>;
+    };
-- 
2.42.0


