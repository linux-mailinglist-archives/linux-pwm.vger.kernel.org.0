Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56674F4268
	for <lists+linux-pwm@lfdr.de>; Fri,  8 Nov 2019 09:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730632AbfKHIpb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 8 Nov 2019 03:45:31 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46177 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfKHIpa (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 8 Nov 2019 03:45:30 -0500
Received: by mail-wr1-f66.google.com with SMTP id b3so5994238wrs.13;
        Fri, 08 Nov 2019 00:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lXctZT9szOude0/tzOobu9MVmKEaCphOc5TWHI1R/+o=;
        b=WdY6nR0/Jp+x7ZOowmnVHfztGLVygNvroENA6yBkFeG6Y8J6MdNWkU5wlp+hZFdGLE
         JGz2/0cgugAvqCRFUlxMF40CNgPH0eOMT4XkfrObYacIn3gXmDD4p/aMz1PTm7fpW3ha
         r80j+ukVgX1HPOMbZ1Ss+smvyms6gB94q3id8WN/f4wdRgpnJoQRomnSGLtmbE9RtQna
         h9bklZ9VcEXBTCv1lGEkNbk34tPD8tpDwvUJAgm5QImq5gklZenXpk2ss5cmVyJFsnCy
         PXYbFfziTLWXsrOfjpeSz2QMyZ2wumiEo/KTYw5054vX82a/EEuMWkeu8Nrb1Kn3/mOh
         qC+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lXctZT9szOude0/tzOobu9MVmKEaCphOc5TWHI1R/+o=;
        b=PyvcUaeZNVkVom08Rik6MHqMwP7hlUSWlAI7kLLRuEt412jl8p1jtXCanmkrMPvUyt
         Rh/wCbxSBZK3CxCqTQJdIvy6AahAZcV1wHsaYGgvF5UpuoS+ydXHblmKHNLjGTE3V7Zp
         Zr6TSe+f7kNne2kkt1oR1C2SPdbpiH19s+u7caKB/YIyy/hcTTtG6wvCe8HILuTUljx7
         1UtPMD2ChnWghLpCm7LAUpk+BraIfujodLatuFzLR2EA27Kh3AZ2eS2S3RPiIKyTZTol
         E5qc/tqhJpPonzoKXa/iu7P6NQHS4Da4OL24OlXArZmqtY43QliLtvlWN8x3nB3B6ymA
         a8AA==
X-Gm-Message-State: APjAAAXn4CipsfUEr0SBWYsaFruZ+vd3029gXe6wu7mIYQX+OusbcNh6
        frBsqi7cp/sVVMAK8JS/KMU=
X-Google-Smtp-Source: APXvYqwP1PQg+Qz0CsAYeKQRWcWxaJuimaCkAjha6SKIoYhOxnoyF8fMyOe15V7v2E8HDLzWw/GVZg==
X-Received: by 2002:adf:f685:: with SMTP id v5mr7586956wrp.246.1573202727559;
        Fri, 08 Nov 2019 00:45:27 -0800 (PST)
Received: from clement-Latitude-7490.outsight.local (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id q25sm6662665wra.3.2019.11.08.00.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 00:45:27 -0800 (PST)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <pza@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v4 1/7] dt-bindings: pwm: allwinner: Add H6 PWM description
Date:   Fri,  8 Nov 2019 09:45:11 +0100
Message-Id: <20191108084517.21617-2-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108084517.21617-1-peron.clem@gmail.com>
References: <20191108084517.21617-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Jernej Skrabec <jernej.skrabec@siol.net>

H6 PWM block is basically the same as A20 PWM, except that it also has
bus clock and reset line which needs to be handled accordingly.

Expand Allwinner PWM binding with H6 PWM specifics.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 .../bindings/pwm/allwinner,sun4i-a10-pwm.yaml | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
index 0ac52f83a58c..1bae446febbb 100644
--- a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
@@ -30,13 +30,51 @@ properties:
       - items:
           - const: allwinner,sun50i-h5-pwm
           - const: allwinner,sun5i-a13-pwm
+      - const: allwinner,sun50i-h6-pwm
 
   reg:
     maxItems: 1
 
   clocks:
+    minItems: 1
+    maxItems: 2
+    items:
+      - description: Module Clock
+      - description: Bus Clock
+
+  # Even though it only applies to subschemas under the conditionals,
+  # not listing them here will trigger a warning because of the
+  # additionalsProperties set to false.
+  clock-names: true
+
+  resets:
     maxItems: 1
 
+  if:
+    properties:
+      compatible:
+        contains:
+          const: allwinner,sun50i-h6-pwm
+
+  then:
+    properties:
+      clocks:
+        maxItems: 2
+
+      clock-names:
+        items:
+          - const: mod
+          - const: bus
+
+    required:
+      - clock-names
+      - resets
+
+  else:
+    properties:
+      clocks:
+        maxItems: 1
+
 required:
   - "#pwm-cells"
   - compatible
@@ -54,4 +92,14 @@ examples:
         #pwm-cells = <3>;
     };
 
+  - |
+    pwm@300a000 {
+      compatible = "allwinner,sun50i-h6-pwm";
+      reg = <0x0300a000 0x400>;
+      clocks = <&osc24M>, <&ccu CLK_BUS_PWM>;
+      clock-names = "mod", "bus";
+      resets = <&ccu RST_BUS_PWM>;
+      #pwm-cells = <3>;
+    };
+
 ...
-- 
2.20.1

