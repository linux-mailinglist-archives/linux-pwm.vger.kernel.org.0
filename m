Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7508A4B43B2
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Feb 2022 09:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241800AbiBNIRM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 14 Feb 2022 03:17:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241767AbiBNIRI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 14 Feb 2022 03:17:08 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7378B4EA14
        for <linux-pwm@vger.kernel.org>; Mon, 14 Feb 2022 00:17:01 -0800 (PST)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 422BF407C2
        for <linux-pwm@vger.kernel.org>; Mon, 14 Feb 2022 08:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644826620;
        bh=RUrvha3jd75o7xb7qinVq9MRNe4Hz0+UgFNjZM5U/KA=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=EbPGgT4nIi4oxCdfXrlb8FX6kXWF5nP2y0OwC8UTabgebpo+b7vPaNptWGGPullR3
         yIFl7m3WGYx1Nu/4FsxHVlJrr+vJKrbBQnYfawKvHPkZsQ0xGmu9VSocf9+m5ljXxt
         0OM0+PHSy0gx6CJBVNiwAQDUF4KSAG6dfzzkBA49sQf3dxKsz4UOXXtzMH9SMdC3Z4
         7ZItfYgoWbq9HlQUfX4rbO2JOM8LbelKPR8cuL2yMhb38Z5NlMtiNNvT+IkRrno2SQ
         Wummmbb20McJbyafbuSuXEssFlSzdXsSwtaP4jYnELwivlU36uxTpYM4Ole9jy0co+
         NqgijGr0wSFFA==
Received: by mail-ej1-f71.google.com with SMTP id v2-20020a170906292200b006a94a27f903so5508660ejd.8
        for <linux-pwm@vger.kernel.org>; Mon, 14 Feb 2022 00:17:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RUrvha3jd75o7xb7qinVq9MRNe4Hz0+UgFNjZM5U/KA=;
        b=wxJQVlWZGcwHyC2H71RFuYUjSL0jC1/JXpsZ6BYT17bJBphlX6E7Zt0Ld7bNMjLVe3
         D5le1NTZZUzjZNe1wWiH/Si3MzhYz0CsXGjK/9at+DiJKp+wJODxOpDImFDjuAHaQoEc
         LdCtrUOZvetxoiPd9b5gad4wZGQaGGJ1l4JW6XapK1KBgQFNfoBMKVd4aZJJ5MREQHSH
         5f0ViOaUCyXw+MToqvh0HNYbMU7f5LOqJbChqMYsSbMZ39RCkp8IA47upKvb6vPNgoT9
         BpCCMK3+1VQGZC5XoeR6PkT+VCh6d55DKdIpHseFA/dPaQjJdiDC0zvYdwdGPjqe7rfk
         eCAA==
X-Gm-Message-State: AOAM532L3uv81slg1IW1Bk016IzphkdT6tzdzHGrjgJG9MYih6kuOcyz
        6VO8QZRn/v5L7QjtZhlcRTtVoxbd7yVK7uYugdaoF8I22Hbdj7BuU2EeehiKhVrQn5EWnlq0LQX
        Wp0NrlxqmKAUdlBBQl9jPkkY8ZwKL/u1OXhN28g==
X-Received: by 2002:a05:6402:2683:: with SMTP id w3mr14323046edd.405.1644826609100;
        Mon, 14 Feb 2022 00:16:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyzkuxNo1QP+7t12yVjZD9t3Y/Itl5ApNf4frcHdZJDQgI3MTIUIYVP/fV2AVsdZ2EHF8ILcQ==
X-Received: by 2002:a05:6402:2683:: with SMTP id w3mr14323005edd.405.1644826608899;
        Mon, 14 Feb 2022 00:16:48 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id t21sm3363642edd.74.2022.02.14.00.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 00:16:48 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>,
        Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>,
        Rahul Tanwar <rtanwar@maxlinear.com>,
        Jeff LaBundy <jeff@labundy.com>,
        Yash Shah <yash.shah@sifive.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Vignesh R <vigneshr@ti.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH 06/15] dt-bindings: pwm: rockchip: include generic pwm schema
Date:   Mon, 14 Feb 2022 09:15:56 +0100
Message-Id: <20220214081605.161394-6-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220214081605.161394-1-krzysztof.kozlowski@canonical.com>
References: <20220214081605.161394-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Include generic pwm.yaml schema, which enforces PWM node naming and
brings pwm-cells requirement.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../devicetree/bindings/pwm/pwm-rockchip.yaml | 74 ++++++++++---------
 1 file changed, 38 insertions(+), 36 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml b/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml
index 81a54a4e8e3e..a336ff9364a9 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml
+++ b/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml
@@ -51,42 +51,44 @@ properties:
 required:
   - compatible
   - reg
-  - "#pwm-cells"
-
-if:
-  properties:
-    compatible:
-      contains:
-        enum:
-          - rockchip,rk3328-pwm
-          - rockchip,rv1108-pwm
-
-then:
-  properties:
-    clocks:
-      items:
-        - description: Used to derive the functional clock for the device.
-        - description: Used as the APB bus clock.
-
-    clock-names:
-      items:
-        - const: pwm
-        - const: pclk
-
-  required:
-    - clocks
-    - clock-names
-
-else:
-  properties:
-    clocks:
-      maxItems: 1
-      description:
-        Used both to derive the functional clock
-        for the device and as the bus clock.
-
-  required:
-    - clocks
+
+allOf:
+  - $ref: pwm.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - rockchip,rk3328-pwm
+              - rockchip,rv1108-pwm
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: Used to derive the functional clock for the device.
+            - description: Used as the APB bus clock.
+
+        clock-names:
+          items:
+            - const: pwm
+            - const: pclk
+
+      required:
+        - clocks
+        - clock-names
+
+    else:
+      properties:
+        clocks:
+          maxItems: 1
+          description:
+            Used both to derive the functional clock
+            for the device and as the bus clock.
+
+      required:
+        - clocks
 
 additionalProperties: false
 
-- 
2.32.0

