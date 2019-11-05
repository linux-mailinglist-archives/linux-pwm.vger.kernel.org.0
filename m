Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 400AFEFE19
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Nov 2019 14:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389044AbfKENPF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 5 Nov 2019 08:15:05 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56297 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388711AbfKENPE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 5 Nov 2019 08:15:04 -0500
Received: by mail-wm1-f67.google.com with SMTP id m17so11588612wmi.5;
        Tue, 05 Nov 2019 05:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GcH9L4v6hLjTb03WVEbtc4W0wjAfbHPhhP9UPT/iBJg=;
        b=mkazB2Pdvg74n1/2dtJ33b6WxUCwe3pb6cl8egWK2Fb8IbtMhU1cuF8jUjvQP8lZu3
         yY7SPxRbayA9XWOkRweEjKT9BO2dyBqR+cZNDafVBQFcoHH9MLpS1XeiN6xFbJ4PGtM3
         cr2gI7khpQQnPxCeUSA2YgjcW2gIr0h8H4laylTS6z5488b69YQ+eUG9QCvnFQq2hl/N
         k8wJoFpVRdFQu/hoj11/yxhvJCves7Ls71xjQoxN6KKOHWaCDACgiJWUtMnuCyiP4zPT
         zqWIo+EDoJr3t7pW8fkkYhXZbSz54+IPmXYM1QT4B5dFumns64p2/R2fGRjF2xdoOtFP
         Hq5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GcH9L4v6hLjTb03WVEbtc4W0wjAfbHPhhP9UPT/iBJg=;
        b=Gl0QJiVAVN/j+XBZrOs3tNh5o0f4bvgtMlgL2gwixoNKDgRhQdUl2qA0HtiB9/gEhS
         YF8g9yFiJ4bYfjuM6UVZAIPBOd4wxXX6tlUGSmXQcMc4fLSHwI6zg82G+rj31LcyTXZf
         DA9hirF34DPMlOM5WJf9pjEeN21rh8wdG3BE347Le/ttsV5o8OMcGEXbbWmKMr7mcQ/Y
         mhENOPusT+A0Cl1aE8Zgy9ufk3SIBLv1wBn4hkORN4MYJrcXGzjnCHYRU7DHD8wjo7vI
         CdsjYlgX7muMP1gYTlfeBkoJ2A5pDnA74zgLDUuSiDy9painTTxqIL4fA2QCLN/OSs+T
         kDNA==
X-Gm-Message-State: APjAAAXzOzMVCXv8mngnmLWvVTd4O51Odq+R00tDhHNS/CnJJJgpoINe
        WnkKEtmoMsTe+IFFlE1nE1U=
X-Google-Smtp-Source: APXvYqwZaocVvRMmSfJBgecb0AwHpmFVmxqomctE7z4EdhbBlsnv7DVhdCkYdM3JjAQLpKZcglC+Dw==
X-Received: by 2002:a1c:3c42:: with SMTP id j63mr4273646wma.90.1572959701957;
        Tue, 05 Nov 2019 05:15:01 -0800 (PST)
Received: from clement-Latitude-7490.outsight.local (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id a6sm13549920wmj.1.2019.11.05.05.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 05:15:01 -0800 (PST)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?=27Uwe=20Kleine-K=C3=B6nig=27?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <pza@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v3 1/7] dt-bindings: pwm: allwinner: Add H6 PWM description
Date:   Tue,  5 Nov 2019 14:14:50 +0100
Message-Id: <20191105131456.32400-2-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191105131456.32400-1-peron.clem@gmail.com>
References: <20191105131456.32400-1-peron.clem@gmail.com>
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
 .../bindings/pwm/allwinner,sun4i-a10-pwm.yaml | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
index 0ac52f83a58c..9fc32c1d94b4 100644
--- a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
@@ -30,13 +30,50 @@ properties:
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
+      - description: Bus Clock
+      - description: Module Clock
+
+  # Even though it only applies to subschemas under the conditionals,
+  # not listing them here will trigger a warning because of the
+  # additionalsProperties set to false.
+  clock-names: true
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
+        minItems: 2
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
@@ -54,4 +91,14 @@ examples:
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

