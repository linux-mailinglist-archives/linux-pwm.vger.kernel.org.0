Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDE86ED49E
	for <lists+linux-pwm@lfdr.de>; Sun,  3 Nov 2019 21:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbfKCUdw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 3 Nov 2019 15:33:52 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:33252 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728107AbfKCUdu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 3 Nov 2019 15:33:50 -0500
Received: by mail-wr1-f44.google.com with SMTP id s1so14828017wro.0;
        Sun, 03 Nov 2019 12:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9PTjPnnXrhQTEA6oIUuGKycZpquqSu0RexmpAAxMkKM=;
        b=ZlH456jue5FYNyvKFDvJTC8b7gFTI06byf1mM8aw5WgyBo4ojCRCowUP2DT2ubuHf9
         y1WSgeXVZ8i0ev5i0RHeS65Bs4NzxP7FsUMfFLWxxiRAmBRK8wD//UekcAhltgA3BDeY
         Zkj6Wu0wDplSVusktSj3bdjNPJtjfI8nyLQ8+bpApciJrbyR6w5uAnsmkX2axlFiDKoE
         uBoGUpsF7RhyR2hlLKHUtdarf8yBJB1zB7IwxpJelg19g7yn/8M7aZvWj73O7D2Wcd44
         3e8xSXzp0SQ+b1kt3DHGiOcoOaKUBwAlZ6Gt6hki/cMb8zeV9MFU46N5T3hVPtVFiy8G
         uE3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9PTjPnnXrhQTEA6oIUuGKycZpquqSu0RexmpAAxMkKM=;
        b=d+fpfdI011vE/2OIw3ji7y8LpUk3h3Et62xCHLVmpE31Va4GNl56nPpLCWeodhuw9N
         GZDzEzL/A6+3qH3OFTZYhYGTNjARS6bOKEUDo2HnS7LIpta8zYqBf5xoCYFhTK37gr1k
         tj1CIihfLF+Pkqs7nWR2iWvWrtrv7vv1cuT/8NexD/okibkt7eldQhK316Q/kfzwzK4V
         zEnM/nu5IXbNNNtLDsMrvWpeuetknYCXysDibSGIsscdtkRwD1ZPEsMOwFxIskS4Oy3J
         6qYpFCwHbw5rgZl0hiUDc79rEZV9WHJnrBR3ywVIMDyetLl5is1b2lbM89wovCj9BAV8
         bRww==
X-Gm-Message-State: APjAAAWFP7uvsEy2ezfhHEGtHStEfhlH6xXjNpquh0bbR/VBm/Q/rB5O
        Ot4Mw0bkN9FTtETJrm631NI=
X-Google-Smtp-Source: APXvYqzrRKRa1dghpnaaDA+/4SyPPw2ng/Eh6/Ef282232gLUIpPYC5TN1vN6QY3Fqw+LbKZqVFLfQ==
X-Received: by 2002:adf:ea11:: with SMTP id q17mr19979964wrm.83.1572813226641;
        Sun, 03 Nov 2019 12:33:46 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id x16sm13644026wrp.91.2019.11.03.12.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2019 12:33:45 -0800 (PST)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?=27Uwe=20Kleine-K=C3=B6nig=27?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 1/7] dt-bindings: pwm: allwinner: Add H6 PWM description
Date:   Sun,  3 Nov 2019 21:33:28 +0100
Message-Id: <20191103203334.10539-2-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191103203334.10539-1-peron.clem@gmail.com>
References: <20191103203334.10539-1-peron.clem@gmail.com>
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
 .../bindings/pwm/allwinner,sun4i-a10-pwm.yaml | 45 ++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
index 0ac52f83a58c..bf36ea509f31 100644
--- a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
@@ -30,13 +30,46 @@ properties:
       - items:
           - const: allwinner,sun50i-h5-pwm
           - const: allwinner,sun5i-a13-pwm
+      - const: allwinner,sun50i-h6-pwm
 
   reg:
     maxItems: 1
 
-  clocks:
+  # Even though it only applies to subschemas under the conditionals,
+  # not listing them here will trigger a warning because of the
+  # additionalsProperties set to false.
+  clocks: true
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
+        items:
+          - description: Module Clock
+          - description: Bus Clock
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
@@ -54,4 +87,14 @@ examples:
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

