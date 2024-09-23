Return-Path: <linux-pwm+bounces-3347-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1DB97EF22
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Sep 2024 18:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F8D31F221B1
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Sep 2024 16:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7127819F11B;
	Mon, 23 Sep 2024 16:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyEjisNG"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CE114A8B;
	Mon, 23 Sep 2024 16:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727108574; cv=none; b=g1IoJhagLHAIHDWVsIszM/qyG92LbInmYxNy3CMYgr182nC4GjpRJ5fHQYziF8swMSmEFUnqqvt6o4ifYPDyxd9eYTEY0klIZWjmcj8MN/6V57Vt2pQoptCL1eeZiDxqLIrwbnB+HEcF2Y0drNIn9Gk871LttlU5aiYtn098g0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727108574; c=relaxed/simple;
	bh=ATWjVFRLnSAGMkjhwfJQWOO/tfzmabf7vU0TjFmd0gY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AlXS235TvjAhR32qcaKm2bESvxPWV3tuWWAzfUSf70QVr3DLCCFwLKiPZpqp163TJSR0H8nwRoUy6jS6MTgooap86ch2/8KJUwO6faBPBbJn85deoeKkPlZSqaAe5mc14ck0ZGCWLJHKO1VFMXnFKsbu9mrkguRIdAD8sS9jGr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FyEjisNG; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7a99a46af10so491392885a.0;
        Mon, 23 Sep 2024 09:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727108571; x=1727713371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WK7eqKzfxTCXYjY4yBuvM5uGMWIrx3TALuq0TWoNpjA=;
        b=FyEjisNGBg2X6DSYVartx2sg2lKWjJFQJ6N2sZpz2p9nGLTiA2N2G95c4XeD7LNYkB
         KTiJouFoHjGM96tx9yGwH9ha/E4FbtiIZiPZqu6k1jrzEZ6rONgKqtA3TZ63Ucctafbe
         1eVWMnmfo0AuAYlnxVJzp2OPdkHt9qdKJuZOlRdBSS0TH8Bu93A6Mi8xYrBj+g0KrBTc
         +UUWbNl7OhCjClCghLhNsM523gA4PZ6IPceGgok47bHFqC6pVPBy4ccrUDxhSBD0ZfbT
         haXgdOfiHwBDYKyr1PVtWvO3v1NEq9FOLPdh98S1wxnHJV0xojstW7e0Ny+nI+t4rd82
         sy2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727108571; x=1727713371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WK7eqKzfxTCXYjY4yBuvM5uGMWIrx3TALuq0TWoNpjA=;
        b=hopJsowLj9GDFAC1A8xsZQQE9UMtHfpxqvQu2PAqvlCIPSQGJu/PhpQ/WgdXyvyLTj
         rzRLZM+iyqmFb7zLsXG2AUuBhuAS77kxbHIGeaebVcxlse59jP6N+6yrHd8AqyaVD3iE
         mPE8QrLkAB4TQusXRYZksL9VT6HCozK4Mx194rG5PXJlewqVfJLJ1w856blJtPu3D/o2
         PmuSLhRt2M34Yl4oat5NHa0WseAGLgynKTwSZCw7DwvzXsXeaKoPW6ZkhE3/Rf2cm8v3
         3Hb25azayYY7eBpsmXPG3V96JcoKh8SFlNI81F/dWdkxdaCkktj4CEgy+jBNAruxOuYV
         CCGA==
X-Forwarded-Encrypted: i=1; AJvYcCUAlPWuWJ4NeX70YzIBSfPWn3jrLEyNbxC+8HURCmP0n2bYJ5lBqzMzjtTOZDBdWyidf87Jg42roel8@vger.kernel.org, AJvYcCUTei61luQHUhWGhkuUFkTj2qzfRySVzWhQTEtF44IcgePioBLimhTlGoXX4pofNrwNY9LYMy2SDGOeSwKP@vger.kernel.org, AJvYcCWjXk6vSXYladPHo/QFNFUY3455SKTN0SQh4joLb+efTX2T7LLd9G0TQlObcWenhYLzlfLJK3DGpIvO@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/DB5/03bgQ8VcvgCEV2HN3OtpNvevKCirv6yQAfDOF1sbIefI
	DBDJXM3IuFFIO7TOLcoK5YjzumdFtRahXR/phjMkcXHmcUJZu6tB
X-Google-Smtp-Source: AGHT+IHtGW8BGgq7f+idZ01ePUM9n4dRpEXgM/5sCn84zGPQtG+DUDSYbLOgEjG4fiqKSLk7e8vKlw==
X-Received: by 2002:a05:622a:3c6:b0:45b:1d3:d9a8 with SMTP id d75a77b69052e-45b20508707mr193558461cf.27.1727108571506;
        Mon, 23 Sep 2024 09:22:51 -0700 (PDT)
Received: from VM-Arch.gst.l3harris.com ([208.127.73.102])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45b17867fb0sm48587901cf.1.2024.09.23.09.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 09:22:49 -0700 (PDT)
From: Alex Lanzano <lanzano.alex@gmail.com>
To: dmitry.baryshkov@linaro.org,
	Alex Lanzano <lanzano.alex@gmail.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Mehdi Djait <mehdi.djait@bootlin.com>
Cc: skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	christophe.jaillet@wanadoo.fr,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: [PATCH v7 1/2] dt-bindings: display: Add Sharp Memory LCD bindings
Date: Mon, 23 Sep 2024 12:21:34 -0400
Message-ID: <20240923162205.55658-2-lanzano.alex@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240923162205.55658-1-lanzano.alex@gmail.com>
References: <20240923162205.55658-1-lanzano.alex@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree bindings for the monochrome Sharp Memory LCD

Co-developed-by: Mehdi Djait <mehdi.djait@bootlin.com>
Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
Signed-off-by: Alex Lanzano <lanzano.alex@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/display/sharp,ls010b7dh04.yaml   | 92 +++++++++++++++++++
 1 file changed, 92 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/sharp,ls010b7dh04.yaml

diff --git a/Documentation/devicetree/bindings/display/sharp,ls010b7dh04.yaml b/Documentation/devicetree/bindings/display/sharp,ls010b7dh04.yaml
new file mode 100644
index 000000000000..8097f091c2a5
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/sharp,ls010b7dh04.yaml
@@ -0,0 +1,92 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/sharp,ls010b7dh04.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sharp Memory LCD panels
+
+maintainers:
+  - Alex Lanzano <lanzano.alex@gmail.com>
+
+description:
+  Sharp Memory LCDs are a series of monochrome displays that operate over
+  a SPI bus. The displays require a signal (VCOM) to be generated to prevent
+  DC bias build up resulting in pixels being unable to change. Three modes
+  can be used to provide the VCOM signal ("software", "external", "pwm").
+
+properties:
+  compatible:
+    enum:
+      - sharp,ls010b7dh04
+      - sharp,ls011b7dh03
+      - sharp,ls012b7dd01
+      - sharp,ls013b7dh03
+      - sharp,ls013b7dh05
+      - sharp,ls018b7dh02
+      - sharp,ls027b7dh01
+      - sharp,ls027b7dh01a
+      - sharp,ls032b7dd02
+      - sharp,ls044q7dh01
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 2000000
+
+  sharp,vcom-mode:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: |
+      software - This mode relies on a software operation to send a
+      "maintain display" message to the display, toggling the vcom
+      bit on and off with each message
+
+      external - This mode relies on an external clock to generate
+      the signal on the EXTCOMM pin
+
+      pwm - This mode relies on a pwm device to generate the signal
+      on the EXTCOMM pin
+
+    enum: [software, external, pwm]
+
+  enable-gpios: true
+
+  pwms:
+    maxItems: 1
+    description: External VCOM signal
+
+required:
+  - compatible
+  - reg
+  - sharp,vcom-mode
+
+allOf:
+  - $ref: panel/panel-common.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+  - if:
+      properties:
+        sharp,vcom-mode:
+          const: pwm
+    then:
+      required:
+        - pwms
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        display@0 {
+            compatible = "sharp,ls013b7dh03";
+            reg = <0>;
+            spi-cs-high;
+            spi-max-frequency = <1000000>;
+            sharp,vcom-mode = "software";
+        };
+    };
+...
-- 
2.46.0


