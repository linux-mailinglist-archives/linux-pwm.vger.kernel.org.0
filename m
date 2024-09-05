Return-Path: <linux-pwm+bounces-3101-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F7496D93A
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Sep 2024 14:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E3DA1F23A16
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Sep 2024 12:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECA119CC02;
	Thu,  5 Sep 2024 12:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+UI5jNO"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A927B19B5BB;
	Thu,  5 Sep 2024 12:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725540330; cv=none; b=P3RAkxXhRZKUbcf6K1lErYkhEUSDhRcEUjx1TwV2+hT8ncR7t93rY/hpmdPIZm0agZEnJHC4eEay3xgQ+xuZSmeH7Cejl/HwyDbKchHsM/tkRR9PFEOMzTT9jUe6Ia9GHAs6Gj2UybDer00BiUEK+kt1gsLZbUvgexk/BbavR/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725540330; c=relaxed/simple;
	bh=TnKuaJA0E98xgHfGYMLSIGr3uKPRpaoffR6eqN4Q18A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zn7mWZIgPiFQUceq9/4GHmvaz7dNPaRHfcLJOJoNnahH9xDbzd2nQIHbotkTxwIZYTlpSlUafmWCPGLCsvI6N+OBiBDjHS8/HUnuwi4L2uj8mQ82eekbcreWnzP9kHMbb/6wpoag84YCB0gQYdKhnzsBwNotU6QYkb+vKZjjAGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+UI5jNO; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6c35334dfb1so3835936d6.0;
        Thu, 05 Sep 2024 05:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725540327; x=1726145127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPNkiN4FpNjoh42kLB4DXZ+z+KT8DuqJ8pFx6jwc9To=;
        b=F+UI5jNOI4i9e3up7MfiuXhqMUDvsv4r5OBeXahXruqtpnz8KhP76iUYhmC4BEMXS4
         h6quxTjvonJD76Ol2CHYtnhqYhAqn4TflhBRpyGaGvSc1rXA5gvykGJHAqeodkzjovN1
         63PRB+XN0HvzCN9nVrVDnN9oFtNJUxJM/JeMvxEuij+eBVHYZa+w4ZM1yRCNQITY5N9o
         qjuuYljdoE+g1j2Wc/rwE4e43706jzEW3YnH6ocpBbyPp+t00NSAq9JpmidEjRoo8nvu
         JZ2JYsaLQ15xu9fdHvECDksVaFWLdz8rPfIg7XuhOMP8CtsmJm5E3bdIDmee8CCWhIGB
         ElaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725540327; x=1726145127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cPNkiN4FpNjoh42kLB4DXZ+z+KT8DuqJ8pFx6jwc9To=;
        b=pzZKY5uVS8ZF7rofnhY1Pbi0EjgmVD2mHiRK71qGue58Yo73BzZWSFAAnRkAFyxFsw
         lBSSguC752flqiaeQGIEdMgacyVO0qgbh4PzmypXP8uCy2XzaApB8PV5hMnQTAjEhcEA
         1qJbHgjEYl68CCIXkaBk/SvAIwq3uGrcdh6eNmFFimQfuDFWnP/YTYOQOuScrDuDGFBj
         CqCUwF2aKnopWPEZ8gdBMWcVcz27xLWlpnfZ/6DZUStRoe8qam8ntxGpfWGJcSRdrNQO
         ApAU9w/PMtxPg6hM+VhFq8p49dp2ODJuY24gacpIjaOAfmEprwFNzB13O/JA5ydeLfrF
         ljxw==
X-Forwarded-Encrypted: i=1; AJvYcCVwiZs/8j0rmeFbdbZ9dFZen124F6U+BN0kiOL4WfvmzbWXB+3EXTmtIOanu/EzFuIU8ynuSyJGziUinLXS@vger.kernel.org, AJvYcCX65YwOpNWRzJZwTixdlYr+k1ZHJdf4DFUadR52tEKqWB7Z1LGbx+5bS4Qt3rDf833Mf8QVm8sZyhQu@vger.kernel.org, AJvYcCXmrVc3vmFiV2WHmIk9yW+qEnoWAk98i840MOc7L+weaUQfzUNPFcF4qlaK7o+2IuRBbEwbuZLzP31+@vger.kernel.org
X-Gm-Message-State: AOJu0YwvUE1BdixOLfYeJ9sb0nPe7TJjg9Bo4TRry3cdHXwbPpIu658z
	7cPEI146+HILEkVeafg2WijuW/3GQSuSGW86MW37rnzhI+jJ4Sem
X-Google-Smtp-Source: AGHT+IEQA78sKnpfuRxvphOLDPFKxwqXZrovyMeyXee1uehOaZt5laT2XubMglcD76YOy63hICNK9A==
X-Received: by 2002:a05:6214:3902:b0:6c3:7026:203 with SMTP id 6a1803df08f44-6c370260427mr105065926d6.11.1725540327410;
        Thu, 05 Sep 2024 05:45:27 -0700 (PDT)
Received: from localhost.localdomain (140.sub-174-193-1.myvzw.com. [174.193.1.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c52041a00csm7161116d6.114.2024.09.05.05.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 05:45:26 -0700 (PDT)
From: Alex Lanzano <lanzano.alex@gmail.com>
To: Alex Lanzano <lanzano.alex@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Mehdi Djait <mehdi.djait@bootlin.com>
Cc: christophe.jaillet@wanadoo.fr,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: [PATCH v6 1/2] dt-bindings: display: Add Sharp Memory LCD bindings
Date: Thu,  5 Sep 2024 08:43:59 -0400
Message-ID: <20240905124432.834831-2-lanzano.alex@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905124432.834831-1-lanzano.alex@gmail.com>
References: <20240905124432.834831-1-lanzano.alex@gmail.com>
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


