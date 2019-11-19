Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79DB2102B0C
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Nov 2019 18:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfKSRx1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 19 Nov 2019 12:53:27 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:40339 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbfKSRx1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 19 Nov 2019 12:53:27 -0500
Received: by mail-wr1-f48.google.com with SMTP id q15so12144089wrw.7;
        Tue, 19 Nov 2019 09:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KpxeRwM+qEoa4VAc9BPhZpNvjuA7mG+/4K8rmEaY6mQ=;
        b=bx22B9591gBTbNsaJPnRIhrdB/HobDRSuf8N/+RQ9vfgk//8OYwdPjFEWXeCbw2el7
         OtR8xn3BePNX7Aa1zV/8zUU2IU8jcimexfTHG1xPtdoHp4pTcd11hdJZbNeiKX23TKcI
         opTob0wiEguEjhHWaxkF8u7gvO7xeD+kMS6mSGyN4Ul//IuNFsWSM1b0ktJ9i6HcAA8L
         fQcG2ljYoL/j0baD5omgDh3BD4BKgLIVlOfuwDbqyP7Gyx7xSOlwlUDv/EVI0S85hoS/
         NvKqjMIxsZUU2mF4uszX1Y4515VQ+C/T4q7+pKYVBWXUM5YUXVhjbeKFoUOJ+DFMD3C3
         ZxFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KpxeRwM+qEoa4VAc9BPhZpNvjuA7mG+/4K8rmEaY6mQ=;
        b=R2BRyWluUEde9QItUF30/s+qX4j1eGAuFhwllQSOCl7J9cg8eDX8LemSuXlSYyiCLe
         bZ/HH7+3F+mbLRymZKkkeYCeiXgHZCZW9PSO77gnLlxK98l7E3PqjGB+q7KsijTjrVX4
         mHf1MtgvFbfrkc2p2qqMCho9LRs/3NZQ8uJdGKQnyRZU+U0fYJXF4nzjWzKMoGRl7izd
         x11mpMg41Pe57OGvNyBaK1+jR/F7MDC89K1baLoMMsNp8/VLcUIqMkpLZjJxL9MRbenD
         1Yz28vWjaZJrVHRc68imrEG0fDRRt3oSegzq4raeKHP1fS71GpczfIGvp9dggcEuuUH7
         EQXQ==
X-Gm-Message-State: APjAAAVFjq0CZ4KdgHm76MjwZV9vXzHCyCPrEwdpaf+7HsuaHE/1Hasl
        stANazjefI7gc17bOzfLeKM=
X-Google-Smtp-Source: APXvYqzRPud+LGIWs0JP7TgLZFqPoXTmaPDi4j3Bz5kBu2ryyj8/BvNdjOcJSRbKl1ehPz/aD1c7ng==
X-Received: by 2002:a5d:51c8:: with SMTP id n8mr38156093wrv.302.1574186005316;
        Tue, 19 Nov 2019 09:53:25 -0800 (PST)
Received: from clement-Latitude-7490.outsight.local (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id l13sm3772618wmh.12.2019.11.19.09.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 09:53:24 -0800 (PST)
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
Subject: [PATCH v7 1/8] dt-bindings: pwm: allwinner: Add H6 PWM description
Date:   Tue, 19 Nov 2019 18:53:12 +0100
Message-Id: <20191119175319.16561-2-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191119175319.16561-1-peron.clem@gmail.com>
References: <20191119175319.16561-1-peron.clem@gmail.com>
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
index 0ac52f83a58c..a7dc19fc347a 100644
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
 
+if:
+  properties:
+    compatible:
+      contains:
+        const: allwinner,sun50i-h6-pwm
+
+then:
+  properties:
+    clocks:
+      maxItems: 2
+
+    clock-names:
+      items:
+        - const: mod
+        - const: bus
+
+  required:
+    - clock-names
+    - resets
+
+else:
+  properties:
+    clocks:
+      maxItems: 1
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

