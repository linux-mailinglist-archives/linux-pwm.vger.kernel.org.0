Return-Path: <linux-pwm+bounces-241-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 382307FD85B
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Nov 2023 14:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C5391C20EC3
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Nov 2023 13:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7D8208AB;
	Wed, 29 Nov 2023 13:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JhJFE5s9"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040E9F4
	for <linux-pwm@vger.kernel.org>; Wed, 29 Nov 2023 05:40:34 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c9b88cf626so18745481fa.3
        for <linux-pwm@vger.kernel.org>; Wed, 29 Nov 2023 05:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1701265232; x=1701870032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQRwxx9GEOBkFVTtu0HXXPOcGrMBOKITGaWl4mMUCHI=;
        b=JhJFE5s9qNJaFRQopr+cK1bLrEwuATVyZ4pBBTf3+Nx8RQ8Rdi6kvrufAEyjSac/b5
         flnqbFamH5PzLaGzE8QkgEwGWN2rTuAJcdVgsXGTnxpszd0euFL6l7MqmBJ+0fNhW/wq
         wO7TCpJBDu9vGy3k79HbyRuLAZ/GqTH8pS73Iq8FTU9V5kP1YCDVbD2lh570QZhBdZFq
         geMfimrX86N5hsfGe9MsJ7T3HPIRtiuzV/1jwOOUXD1ayvbJhu97sxqQoKDCS1pahgL3
         7/3fpVnp5cleisFgVzjlTL+02qD78Kfxq+lUs9Puaf0iWdeXnYNFIHrYSnoXLXILONLf
         xGmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701265232; x=1701870032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hQRwxx9GEOBkFVTtu0HXXPOcGrMBOKITGaWl4mMUCHI=;
        b=UdFH1Pia/jw4zPChU23S+WoK2INnQpoWkvUyPX8FIooIUyMGYTLVXljbKgzwrennzW
         Z8hkpb2v6ailhvup114hrnZTVR6dzgcPp+PCN6izg1dXuUQA+yhHEgs/T/QTn9HcC00H
         N4F5J2HMXUFt7e3ORwbYCOk0OxPZtIy0P6giztmBU4v5vCYVlifL5xuo8Jx7syeJpA7A
         keWbjPax/HyKd3KY+3Zh73eQdJW466dLyBMy3t5qjZ/3u1PPGPq+8m37YWVU+b3LMpJ0
         vsNX+GRcx+l3bbubyJ2O+/ZhSRTBPfucodrdIJ6m1WlmBAvYhxJOA8ZemW3Z4TvNPrJ1
         r2Vw==
X-Gm-Message-State: AOJu0Ywgg2Qb62GqW/m44a3I6Law/Nbm+ijkEvSMPJGzGX7/Sfl0A+OC
	r3UQbFeCleHPfkA5nB5LpzmaiA==
X-Google-Smtp-Source: AGHT+IE6EXkIS1MLDJ9G7G35/UHE0u8PoIQgoq4VqHWzasYKaYE0gqoMNy6M4o6VE2MrG4pH/0KbYg==
X-Received: by 2002:a2e:9646:0:b0:2c9:ba44:fd9d with SMTP id z6-20020a2e9646000000b002c9ba44fd9dmr2347821ljh.38.1701265232031;
        Wed, 29 Nov 2023 05:40:32 -0800 (PST)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:6101:5529:fe2d:d7eb])
        by smtp.googlemail.com with ESMTPSA id w17-20020a05600c475100b004080f0376a0sm2285860wmo.42.2023.11.29.05.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 05:40:31 -0800 (PST)
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
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v3 2/4] dt-bindings: pwm: amlogic: add new compatible for meson8 pwm type
Date: Wed, 29 Nov 2023 14:39:58 +0100
Message-ID: <20231129134004.3642121-3-jbrunet@baylibre.com>
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

Add a new compatible for the pwm found in the meson8 to sm1 Amlogic SoCs,
dealing with clocks differently. This does not enable new HW. It is meant
to fix a bad DT ABI for the currently supported HW.

The original clock bindings describe which input the PWM channel
multiplexer should pick among its possible parents, which are
hard-coded in the driver. As such, it is a setting tied to the driver
implementation and does not describe the HW.

The new bindings introduce here describe the clocks input of the PWM block
as they exist.

The old compatible is deprecated but kept to maintain ABI compatibility.

The SoC specific compatibles introduced match the SoC families supported
by the original bindings.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../devicetree/bindings/pwm/pwm-amlogic.yaml  | 52 ++++++++++++++++---
 1 file changed, 46 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
index 387976ed36d5..eece390114a3 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
+++ b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
@@ -21,23 +21,35 @@ properties:
           - amlogic,meson-g12a-ee-pwm
           - amlogic,meson-g12a-ao-pwm-ab
           - amlogic,meson-g12a-ao-pwm-cd
-          - amlogic,meson-s4-pwm
+        deprecated: true
       - items:
           - const: amlogic,meson-gx-pwm
           - const: amlogic,meson-gxbb-pwm
+        deprecated: true
       - items:
           - const: amlogic,meson-gx-ao-pwm
           - const: amlogic,meson-gxbb-ao-pwm
+        deprecated: true
       - items:
           - const: amlogic,meson8-pwm
           - const: amlogic,meson8b-pwm
+        deprecated: true
+      - const: amlogic,meson8-pwm-v2
+      - items:
+          - enum:
+              - amlogic,meson8b-pwm-v2
+              - amlogic,meson-gxbb-pwm-v2
+              - amlogic,meson-axg-pwm-v2
+              - amlogic,meson-g12-pwm-v2
+          - const: amlogic,meson8-pwm-v2
+      - const: amlogic,meson-s4-pwm
 
   reg:
     maxItems: 1
 
   clocks:
     minItems: 1
-    maxItems: 2
+    maxItems: 4
 
   clock-names:
     minItems: 1
@@ -58,7 +70,6 @@ allOf:
         compatible:
           contains:
             enum:
-              - amlogic,meson8-pwm
               - amlogic,meson8b-pwm
               - amlogic,meson-gxbb-pwm
               - amlogic,meson-gxbb-ao-pwm
@@ -67,14 +78,15 @@ allOf:
               - amlogic,meson-g12a-ee-pwm
               - amlogic,meson-g12a-ao-pwm-ab
               - amlogic,meson-g12a-ao-pwm-cd
-              - amlogic,meson-gx-pwm
-              - amlogic,meson-gx-ao-pwm
     then:
-      # Historic bindings tied to the driver implementation
+      # Obsolete historic bindings tied to the driver implementation
       # The clocks provided here are meant to be matched with the input
       # known (hard-coded) in the driver and used to select pwm clock
       # source. Currently, the linux driver ignores this.
+      # This is kept to maintain ABI backward compatibility.
       properties:
+        clocks:
+          maxItems: 2
         clock-names:
           oneOf:
             - items:
@@ -83,6 +95,27 @@ allOf:
                 - const: clkin0
                 - const: clkin1
 
+  # Newer binding where clock describe the actual clock inputs of the pwm
+  # block. These are necessary but some inputs may be grounded.
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - amlogic,meson8-pwm-v2
+    then:
+      properties:
+        clocks:
+          minItems: 1
+          items:
+            - description: input clock 0 of the pwm block
+            - description: input clock 1 of the pwm block
+            - description: input clock 2 of the pwm block
+            - description: input clock 3 of the pwm block
+        clock-names: false
+      required:
+        - clocks
+
   # Newer IP block take a single input per channel, instead of 4 inputs
   # for both channels
   - if:
@@ -112,6 +145,13 @@ examples:
       clock-names = "clkin0", "clkin1";
       #pwm-cells = <3>;
     };
+  - |
+    pwm@2000 {
+      compatible = "amlogic,meson8-pwm-v2";
+      reg = <0x1000 0x10>;
+      clocks = <&xtal>, <0>, <&fdiv4>, <&fdiv5>;
+      #pwm-cells = <3>;
+    };
   - |
     pwm@1000 {
       compatible = "amlogic,meson-s4-pwm";
-- 
2.42.0


