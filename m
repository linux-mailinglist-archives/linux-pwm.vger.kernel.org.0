Return-Path: <linux-pwm+bounces-3425-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E413498CB96
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Oct 2024 05:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7403E285E71
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Oct 2024 03:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31886125D6;
	Wed,  2 Oct 2024 03:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4SLCVyw"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8439D286A3;
	Wed,  2 Oct 2024 03:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727840326; cv=none; b=Lh+W7gLETPJsp2gtk6Q7TPeROiq2tiEuRmCFAMqNb8n97V1TT4sMSn5vW710FlzcoZTeWoLd1zm2vYj95OC9YN39rpRfc9MbmmKjNiMrItGGeEcFT6enT2p3w6l5PgIasA6CkhtYfmbkz0t006N0P7JImsQKiLMjo7TQThP60h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727840326; c=relaxed/simple;
	bh=7v8EkhMDv+Jx4uOPQGK7HMrlgEz0giZggGqCi8QC6H0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G4r8pNVyw+UpwfmmBsxsK32LVGSJwM+Di9ClQv1BJ1p56yBO0y5dxcul3BsLavBECsJzZZ/dnSsSEzumg3zU02bt2DEHlIgfUfDlHttQT6NU/+S0fwXuTHR2N5xV9SBoddht7ejfzNlx9uCX7pSUxCEtZiQemiwKlfrqSJCt3Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4SLCVyw; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6cb4f1137a8so24912596d6.2;
        Tue, 01 Oct 2024 20:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727840323; x=1728445123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j3ksh4XUKkffbY/duSvAxp7lxaY240eNih1Cc+96aTE=;
        b=D4SLCVywDqC4nyLdpxO5O8XCay7VYMUkcM376S3+R+fmmKZkPlgv2+a9XmCnzLQATJ
         kebk3DdSQWJ+Ra4K7b0OelPKiiqVXPgU2IKkHSJbWippThKM0akQ6bZgRwsOOSdtafRz
         Y7RKun+GLD2bUCchp94PMllP3a3+XHDH2e35EZ+out39sqYqFyAmQP/VXQQCeS0wKGe2
         S5hpbF50W7HK8jRATOzbZMU4BAidy47RqpDJh0sZooqJtVZORyoRGnYMDBOV97IDh2my
         IAYdfNN/H8i54L6X+BDG5Wwh3gvb46D4CRBYSyodY3iUy3p/mGNJEf3qXOz5LUWevLb0
         gCcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727840323; x=1728445123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j3ksh4XUKkffbY/duSvAxp7lxaY240eNih1Cc+96aTE=;
        b=mnovBFXWBOvWuNKkhqtqVPdUZZPDH5nfpkZ9Y2LUv3fnwSDLnmVimaitSzLDO+goNF
         WsRhsOHM395NOgUYgatweVtQizT+kUwADXVm9ACnK4UarZzbfSGNzkU7VHaubKdOEsib
         kB8dBsUiUdsP+fupBh/ngyAOnUAHeOY4FaJ7hvmtZGzUZO9KVd8y/PgEwPZccpfH8pGQ
         GWvzxpdpz0yurTsQ+RdCmfXdvC/h3a9l3hsZVSotbt5ZvrJuthqVKQI48zQdDQepUYNs
         vVEkXzSNSUFpcSiNZbKILmdowffgc8SbvMvM9uIZWZyuKn5ElUvjH0lXvAIOdASOx5Mh
         4o8g==
X-Forwarded-Encrypted: i=1; AJvYcCUVXyt7AMZUtWC8HP7tJr9CAIW4po6PkwPht7qa0uWYEc8kCZrH4YbjKgxvORadAi67A0xlw3Sl4KPx@vger.kernel.org, AJvYcCVNJMrLJUn7qr+C4nUPPr0RtAGHnIrR/xMCmJCoqkiSGZamfyFX062KLh01RgbTIQKoI79KdDQrBXWw/7G2@vger.kernel.org, AJvYcCW31/WKue49YtnEtTvqyk1x7tl7eIzBxRwqBW2K1dzwIzrPbwrsHDtb04L9bAwjScRvG1gOORfY0VmU@vger.kernel.org
X-Gm-Message-State: AOJu0YyUeA/d+fJybf4IIDYsFAGe5IL8jJoyiOu4nW+gPqFX5+eUBTEi
	dUyfPWREI6tyTjZwcOQyms3PtVWcvHg7kfRwnv3xqxkXmuVIzkObkl5Qk//C
X-Google-Smtp-Source: AGHT+IF9Jfkt6rq+pRhtFzL8UUBhqRdqj7GBTlabdTV3sqq4yIKtW2BH05YRhH+pw0+XjCs4mPcgDw==
X-Received: by 2002:a05:6214:5547:b0:6cb:2a26:af89 with SMTP id 6a1803df08f44-6cb81a64ffemr26531116d6.34.1727840323315;
        Tue, 01 Oct 2024 20:38:43 -0700 (PDT)
Received: from localhost.localdomain (ool-1826d901.dyn.optonline.net. [24.38.217.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b62d9e6sm55640446d6.69.2024.10.01.20.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 20:38:42 -0700 (PDT)
From: Alex Lanzano <lanzano.alex@gmail.com>
To: u.kleine-koenig@baylibre.com,
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
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Mehdi Djait <mehdi.djait@bootlin.com>
Cc: skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: [PATCH v8 1/2] dt-bindings: display: Add Sharp Memory LCD bindings
Date: Tue,  1 Oct 2024 23:37:36 -0400
Message-ID: <20241002033807.682177-2-lanzano.alex@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002033807.682177-1-lanzano.alex@gmail.com>
References: <20241002033807.682177-1-lanzano.alex@gmail.com>
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


