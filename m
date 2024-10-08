Return-Path: <linux-pwm+bounces-3527-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB589993D4F
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Oct 2024 05:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF6F21C22E0C
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Oct 2024 03:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3474043172;
	Tue,  8 Oct 2024 03:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKF7egr8"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A89E57333;
	Tue,  8 Oct 2024 03:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728356703; cv=none; b=gwyvE/kV33F1q4kyaOQl6iccKyozb0C4znqIMKnFOwaPMgJoFdbNsdLljo1Zy39hMuPI24iBeuxQQZhw0MJd71kzYoFIipAFN9dJCbLgmNAel1u5OTL23lDuzXKOrQeN91emuvozR/yLDt+1VAsPg2ZOysZ7BnO+sHFlHnc0n4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728356703; c=relaxed/simple;
	bh=7v8EkhMDv+Jx4uOPQGK7HMrlgEz0giZggGqCi8QC6H0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cowqpc+9bawmZwRr4O50NwipoOP5AxRbZPbldJHheF/8itAgwiiAXqQMDJVWnxQf1PEd8uWwnDTptKK3bWcAqEJnqvhZfAnMwezR1ilep2vx3cMZZ2s33cS0LYRQiRgaB422Ghd1/Y/VMIl3eN9iTQzoFZiUHMNOpFoElWj6tzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OKF7egr8; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7afca849947so664985a.2;
        Mon, 07 Oct 2024 20:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728356700; x=1728961500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j3ksh4XUKkffbY/duSvAxp7lxaY240eNih1Cc+96aTE=;
        b=OKF7egr87iZ3juL4iYlQcL0oe09DKHFJHEmywYSkBLubIFbYawiJYxVugkDHQQK+kR
         dR6I3gRk0wc24v741cP6uXqPljMMoFa8YS3P/46zfzpYc1doMs1tPh4PwPMYl0QAtT3r
         mm2LdUpi6hipx32Mi/4lp9+MqVXrvOywlD8sadn9TPJRopXdbaQZytqNo6oFsO8X+Ggb
         deb86qb3FLdnRNoM/QpzGo/poNWNdE8JLJvHQaI5DANxIMPCHxhulC0a+8P/2V9s6Z5V
         ZSJyZlCJiblmp/X7EFa7zMIEiRa7io6QoMZ1dYwpncUYjq+g03hnZRP3EewnxAys3I6N
         gDwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728356700; x=1728961500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j3ksh4XUKkffbY/duSvAxp7lxaY240eNih1Cc+96aTE=;
        b=NwBlBKZA+fAsZMMdqBzR3jKHKsKzFAUY/2AC+Lk5WsKIocZLYeMBFXlMr9U62lgXVk
         GmGEGFlI/xmFsrP/nFgx1d1v/tMsQk9bqFpWSTS4EXOrIOhbG9jrL+lZQxg6y4mt6GdY
         PBFYY/wffInIHVIN0kOc15cc8nDlldo99UvQv46I2tS0jYC0K6EkaBkbn49XgozdHUNe
         AP5obCXsnnS7T9CV+Jw+48IVD2WkNpR+ho83uCDzpHaO73eTZO3u5JTStqmBz/nzUmqE
         +vFowV7hzT7j/hlZZ3C+lvL/g1JDGz8BCrYvavkB0HAOBbxN9+FSYhNPDwZ5B2lax4/E
         qJyQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0MCFQXSXHJVPu+U13HIItyXVfSjYqDovD7jmvulEQPXvDNbS/nWxwTWJybhbbXGYjAmtSspISOWasOTxp@vger.kernel.org, AJvYcCVB0mfd6/s0XI9CRDjJh+l2htqVSmXlrKM8N43aRZmpAbbQ4FP3CQ09V0DBHB39b/Ftu3IdPDn/BNKD@vger.kernel.org, AJvYcCXGmPmsAqXg5J7KXKWcXu4WAiZhhTmhl3WmrD/G25AMOorF2DcUWhyenLhY3sMyr2bg6gIRota+wfxm@vger.kernel.org
X-Gm-Message-State: AOJu0YyldRM6E77ci0SeeZc29ZIzou2Fn2/UHkSTQpsw7HTRGk/x0mBh
	sh6g8p+Ij8GUBKhO22l05GjI2NXhY+lcNm/jog61c80APjenepdH
X-Google-Smtp-Source: AGHT+IEyM9oRaeOdZt+2OiZHhPytRrOmaj83NBfEXAPMZk7TN3qW/GnckGmOeBjLGGYr2QMEJTPabw==
X-Received: by 2002:a05:6214:5912:b0:6cb:938d:be2b with SMTP id 6a1803df08f44-6cb9a4600bamr191619706d6.35.1728356700366;
        Mon, 07 Oct 2024 20:05:00 -0700 (PDT)
Received: from localhost.localdomain (ool-1826d901.dyn.optonline.net. [24.38.217.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cba46f1912sm31107156d6.61.2024.10.07.20.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 20:04:59 -0700 (PDT)
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
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: [PATCH v10 1/2] dt-bindings: display: Add Sharp Memory LCD bindings
Date: Mon,  7 Oct 2024 23:03:10 -0400
Message-ID: <20241008030341.329241-2-lanzano.alex@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008030341.329241-1-lanzano.alex@gmail.com>
References: <20241008030341.329241-1-lanzano.alex@gmail.com>
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


