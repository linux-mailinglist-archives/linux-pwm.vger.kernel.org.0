Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37FEE100163
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Nov 2019 10:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfKRJhr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 18 Nov 2019 04:37:47 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35831 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbfKRJhq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 18 Nov 2019 04:37:46 -0500
Received: by mail-wr1-f67.google.com with SMTP id s5so18575397wrw.2;
        Mon, 18 Nov 2019 01:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/r/rbSHnQ681j6w5Fd1xT+tCG0CKj+LRyHPCBVvmrlM=;
        b=P8pFwrxqnL/iAlT+wWn4oq38pZqZta2yNEuAHyDIb1ZjDOQxlMQy8X/ezmV554mXtA
         7qPCzxvNVf63u+CueuV8DHvfhXqfNHSXywFqjdaI02d5OWMyXLZBmMI7ioIbkNSqfKiA
         jl4L7QVsnzzQYak2nL9YfSwksJm31ddlGXeUXnzCfibnyTcIbfvXPu0kI7UuO+GTDb6Z
         80LAMvSPP0J/6PVpJ6B6+jjuuVjVwK1q03/AnGi0S5d0sDPaqjUGsT28CXb5KKsH1Cya
         x52cOGS8VUBM65zquq9U8OOYBY13eZj6J8b/IKk7JdUy3oC06ksEDFc74Fgb8QPklqWa
         ZLQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/r/rbSHnQ681j6w5Fd1xT+tCG0CKj+LRyHPCBVvmrlM=;
        b=LHkdzBHaZGYkfHuJm6NGjSSP2P1GqKff39ru7F6krJKLnzIxUXWhL6lNED0jzXKwlo
         2Tx12ZBjQrjyff1fNWnTPgvkbKguDuFyw+LREl3skW8nRd+gdHCkDSZ5ozSi28sspTF1
         6rBEk8Nn96cCe4h+Uup0Cyaq8YeiY/4yFxAB4/b53Jd4ES6UCd5eHAjr3RrqJmNYUVjn
         lM66lv8YmNbVPsTBa5OArwGDD/6S0yP74rMZ2gHoP0XkT1+vuj7DMwSnlKDmfgSVqKjW
         6O2wZ+GsdtnsAsl539F1kFmL774FIrU7WBxYcnmWmJW0uGhSU2zyxpDd+GGvNiwESI2Q
         K07A==
X-Gm-Message-State: APjAAAWIfqSKrxMuzFzArr9mqGH/JkGe9o5QIxdQqfDL7oxZ3Im/uslQ
        9f0pFc56piYerLtX3AUVB00=
X-Google-Smtp-Source: APXvYqzrptzyinv4zHsSKlk4uBZG+NdIuGybLeML+SvcHF0FPHiczOcqXhndK5SV0r9Z2ybhkDjMLw==
X-Received: by 2002:a5d:68c3:: with SMTP id p3mr31067514wrw.82.1574069862972;
        Mon, 18 Nov 2019 01:37:42 -0800 (PST)
Received: from clement-Latitude-7490.outsight.local (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id w10sm19006687wmd.26.2019.11.18.01.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 01:37:42 -0800 (PST)
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
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v5 1/8] dt-bindings: pwm: allwinner: Add H6 PWM description
Date:   Mon, 18 Nov 2019 10:37:20 +0100
Message-Id: <20191118093727.21899-2-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191118093727.21899-1-peron.clem@gmail.com>
References: <20191118093727.21899-1-peron.clem@gmail.com>
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
Reviewed-by: Rob Herring <robh@kernel.org>
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

