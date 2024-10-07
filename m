Return-Path: <linux-pwm+bounces-3507-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E34E799229D
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Oct 2024 03:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE4801C21290
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Oct 2024 01:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13653FC0C;
	Mon,  7 Oct 2024 01:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/Zf9t1i"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECA1849C;
	Mon,  7 Oct 2024 01:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728264680; cv=none; b=ckj4Jm/fKu8LqIChL53kFw5H5v8v/5zW25WTDjFakyANmW7PNxnJmPpuR+xH129sJBzBLbdZ5GDZTkCH/vu38gMUKgubPXVNPhT1TmAoNYT+OuVGPN4s3foZqlgnsvC+7yqCMEpAi6GNfmZ0MA3aRmaRINv+ofME/M37+1GQaog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728264680; c=relaxed/simple;
	bh=7v8EkhMDv+Jx4uOPQGK7HMrlgEz0giZggGqCi8QC6H0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tWUCcWuWkKrUvM3o0aQm872LWIUtaBxRKzuHt8urak9zRh0CZdx5r8iPXnQGadujcdoxtC3wbIVnvF1VVrukMNlEfowryw4uPxxElEE4aCn8zhbOTTnPOIgiweRcAzsXIiVRb+YBmczWDUJg9LL16SvYfsNyisOoYgonXRgXU2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/Zf9t1i; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7ae3d9a93c0so415933185a.3;
        Sun, 06 Oct 2024 18:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728264678; x=1728869478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j3ksh4XUKkffbY/duSvAxp7lxaY240eNih1Cc+96aTE=;
        b=K/Zf9t1iMLOKWH790Tapxl2gs3Uk7yHFHCt+EfH/uAR4rdVFTw4Os4FDGlEZ2n4sMB
         +rW3V7nqz/8jSi6GNy7B08aHNe5V/MPa7LSj4qgBqcpb5J9i0ExR+d7XeP9kdLdMC/fN
         fAp13M7wbJGP14fKj/TCSSxZBtSYeHK7lTjJI13Iu/5RKKNdKb+ep8PcRxM8bo/nmzoS
         a9oSewL2psZC5mLg4gb1gw04wPAiNdkt8pf4BaDkXcTl5+SLD8TfMY6GJXlWIWv6Y8Hv
         M+THXVK5LDh6z3sDLYB0KhTxrxYA2Uffw9VW/Ynrm68mlPNeiJWh6GDWTo/bzm7eoYAS
         +Mbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728264678; x=1728869478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j3ksh4XUKkffbY/duSvAxp7lxaY240eNih1Cc+96aTE=;
        b=DFK55UYSyImx5RXPtv7AI0HAVeOriWvJbBFNXJbsarRR3R7ls4S8is/B2VTfLz++bK
         IuLghmn792DyBi3oKr4N2qYGDZkrrWGHhc7IXzYm3o3R6flOd7on+TvG2Ynhl8k6VMIa
         Fpt46I3Z1e3XjpUN5w/7iOWrQVxmSmYZts8YiKGUGUKKulSK9rfCbUjH5FfA4QTR6U1l
         3ERhw2eA0d0Uuul7OixPVGNj6fy0nOIkaBW6RERQBH/SdPyiGpDsiE9BrBz6B+GQ4Q1O
         VPSkyBseNpG6mK/iIuCRv3rMT0A2Qt2MYSvoel9pGLXL1RzGLREEGLOxFUAV5kq4mz0L
         QOGg==
X-Forwarded-Encrypted: i=1; AJvYcCU7ZPm0B3iyr3nSUo4ub+d9DigAzD0PNBPAhdWUNLaz37xQcnbymfTM4fc0Fwir3fn4Df6evw1YHqgUMu8v@vger.kernel.org, AJvYcCV9bMa36pDZh9MhsvNruppErzBP+GMGpDfOAL3pJRUdJwcv8+dYsmf+y5AMFG3r1I6w4otsVhtAnNKx@vger.kernel.org, AJvYcCWmkQ4+DybdmApn740pF0CuzIiUIwCTuK1oXsDQue1/oy0DhvBZqQI7enG7vUB5boZ83OLaAP2yL4gb@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4Gz9urSk5oAoM2S5bKAXSh8/i2XNLXB05unPH4Vdpm/6fUagW
	nQbx3n4NrixbZ7FsHMTgUQV30UR+hswELU2PMsIeRf8SsbmN11LG
X-Google-Smtp-Source: AGHT+IHfkg0cGT4jshIHtr7s47CTUFILrvkTDKQ6NMGzBzbAdTlKcS6WdQJISVBiQ/o7R1qiaHbtgQ==
X-Received: by 2002:a05:620a:2413:b0:7a9:b605:f823 with SMTP id af79cd13be357-7ae6f4547b9mr1781299685a.37.1728264678271;
        Sun, 06 Oct 2024 18:31:18 -0700 (PDT)
Received: from localhost.localdomain (ool-1826d901.dyn.optonline.net. [24.38.217.1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae757627fdsm207326985a.100.2024.10.06.18.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 18:31:17 -0700 (PDT)
From: Alex Lanzano <lanzano.alex@gmail.com>
To: u.kleine-koenig@baylibre.com,
	Alex Lanzano <lanzano.alex@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Mehdi Djait <mehdi.djait@bootlin.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: [PATCH v9 1/2] dt-bindings: display: Add Sharp Memory LCD bindings
Date: Sun,  6 Oct 2024 21:30:05 -0400
Message-ID: <20241007013036.3104877-2-lanzano.alex@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241007013036.3104877-1-lanzano.alex@gmail.com>
References: <20241007013036.3104877-1-lanzano.alex@gmail.com>
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
2.46.2


