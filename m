Return-Path: <linux-pwm+bounces-3663-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF45099FC0D
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Oct 2024 01:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D3371F26D5C
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Oct 2024 23:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB16E1B0F15;
	Tue, 15 Oct 2024 23:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRrhuoEx"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D3B21E3C3;
	Tue, 15 Oct 2024 23:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729033606; cv=none; b=TfVmTPnQS6V1rqTTppDZxjF0Ip+JCmgpkDby+Y4blW40HDLuZdMjlz9EqFJ7B8XpxHEHo9nSZyO8HKwFnKm80tXGuCBxQE5lcniLDnSvTQsrxrbU1Hp0AFZpAFkXkNqDW3Be624rgqF4oBK+9OIEQUAq4SbDQSJ31GBTpb8lI88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729033606; c=relaxed/simple;
	bh=k1Wh/DVJkFET1lbYA0HKKydmloYp/JWSBsDNgirb8kk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QPGuyEYA0/aSW+vfjznQWenSBEsSyAvPvwO1+H3Vmk2k6vNT6ayyWpyTGdLOaHUsc374vHv7icTqRqgRcF1ss9JgyHqDcci9dYMeBI8KYr7CURgi/Ta/z9vh+KvbLJ/AmefzomvQXEqiSbq8Ft70lW+P95LgBb/WTr+1Aq31uAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRrhuoEx; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-460407b421bso45613561cf.3;
        Tue, 15 Oct 2024 16:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729033604; x=1729638404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jTpekSolQ0QOAMmLRMno5XrkJiMfliV9lomxb+U4KBw=;
        b=NRrhuoExOtacV0mUtYsuKUf7AwiKQJvHKZf1VPURCrXVsCWj85UA5iix7BvcN5bBxJ
         UrPJclKiPyn0Oe1iAUW4pwIlvMQG3Q2hhdP++WbGjSw3poeJmGZO7iu/HIi0xtojioK+
         YY1PQVaJFh0dLewyth8O68/XPIRAc9HhIlUbRS+/Jbhl+u+mT61RbCgcKjWz4abUuKpg
         L9S0sXgk8JWtyXw+pGLe9Lr1e3O9UeuNFAbvTceCATT2UOQsuqMuBGEr3e3VO4WrtTy+
         wEq/9wkEQwIwv18D1tovhmcQ9oUBxsQqHMN0HNvZDeE5iK3iN7VX3DnPWjiqwNGIg7SX
         7+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729033604; x=1729638404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jTpekSolQ0QOAMmLRMno5XrkJiMfliV9lomxb+U4KBw=;
        b=C6ctxyPHNo81GjuBPpl3ozLackRb+OGTQz3Td68YAh0p7oXJUvgm+c+NY0PHMps3dO
         9Ko3ZOS9LLL7Cq//KY9G08BLcy7WaVh0yZzLs3uyvlL/oiNUc06syjSixbfWPSaC4DXm
         wi3qb2wZG6cW5GppLc3+Mg6Eq5WZ0ZiRUQqMa8JMJeOp0tEJxrClL+owr3IT8nmQegM1
         mhwq+pn+SVglfN2G7GVPbWub7kjxnYLiKrDbroQIKJObxnSylvwEEULNXb59OwfdpUfw
         mhgizB79SCub+j1b1uxuvAxah1DBBsVyZLyaEbUfrm/HMCkemwXdrhI8Lmd75DXSPTDe
         if3A==
X-Forwarded-Encrypted: i=1; AJvYcCU4dHYf+cPYXSiuD/N2w19Qk4srQDhG7HBzAcWD9EjZspUpnKafl8Qyq1MZ6UU6wXRb/T21mJOdDpVhoaBb@vger.kernel.org, AJvYcCU98TkslsZBaZgrzXOwpQ8qvW29pCJ4aiNaJgowb9hXal6uyiuS9aGyZIC7aNvps848N3V7zgDFVikB@vger.kernel.org, AJvYcCUcYu4wOokMQgdgtWRfoC7L/S3pavkie0NWhu5mN4o00vOnr6OjnUgeLx2JM7pmwcIcK97U/T7jlLJc@vger.kernel.org
X-Gm-Message-State: AOJu0YzsJl/ffT7PEUBcS1D2KqSnzUMHI6Utg0Adz+lpYpxb8jHrD6ih
	vN5NCu2yTixJIbDtmUnCJ0E6KUKdsLYSx8Q5suOJp5c3N16A/POu
X-Google-Smtp-Source: AGHT+IHPzYqu5XwFBi/nu3ChGqeZPQygQizItBlhpnbbYQNvBTfKgOhOL+OuWmTFzGpiU6LMHw68uw==
X-Received: by 2002:ac8:7d06:0:b0:45e:ff4c:6387 with SMTP id d75a77b69052e-4604bb94e9dmr204722401cf.12.1729033603675;
        Tue, 15 Oct 2024 16:06:43 -0700 (PDT)
Received: from localhost.localdomain (ool-1826d901.dyn.optonline.net. [24.38.217.1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4607b0e407esm11224641cf.27.2024.10.15.16.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 16:06:42 -0700 (PDT)
From: Alex Lanzano <lanzano.alex@gmail.com>
To: u.kleine-koenig@baylibre.com,
	Alex Lanzano <lanzano.alex@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
	David Lechner <david@lechnology.com>,
	=?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Mehdi Djait <mehdi.djait@bootlin.com>
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: [PATCH v11 1/2] dt-bindings: display: Add Sharp Memory LCD bindings
Date: Tue, 15 Oct 2024 19:05:43 -0400
Message-ID: <20241015230617.3020230-2-lanzano.alex@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015230617.3020230-1-lanzano.alex@gmail.com>
References: <20241015230617.3020230-1-lanzano.alex@gmail.com>
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
2.47.0


