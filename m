Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168684B5CAF
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Feb 2022 22:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbiBNVWw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 14 Feb 2022 16:22:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbiBNVWo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 14 Feb 2022 16:22:44 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94EC13D564
        for <linux-pwm@vger.kernel.org>; Mon, 14 Feb 2022 13:22:25 -0800 (PST)
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 60A2540340
        for <linux-pwm@vger.kernel.org>; Mon, 14 Feb 2022 21:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644873744;
        bh=rXTrjGyqcJ3i7iMn5DJq5QR/kPtoX00uoKdkO1EvWnA=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Zqz7MgTVbdVyNvbnsoHSas4wE7LTxrPVTViPN3I/zc7QTZgQnG9v4sUc99M5ySEWZ
         ty+Vtmt0MdCZdFHgxW8TOswMj7j7pd+iNgAwRjcAwpJKUEvW4kvQD/2D45Zv1uxd8s
         HMEG5aDaS4NpYmY0ai83+ZGhZ4Cx3idQ8g3DNn/pZOe3giVge3XOtv2notWPL+yAvD
         CIqurwcLO4qU5sU9atPEszqydUdzpL5eP1aU+9rK8dkxQSRwgqVs5a5Vkf6QkEdFdD
         yCxH8IlCRV1lxXon+6cC0mWeymap/OWtHXAnftVGGmI31VI5rm8NlnPtZKTCre+dpN
         WDLNmV5FtXWxg==
Received: by mail-lj1-f197.google.com with SMTP id v1-20020a2e9601000000b002446a7310a1so6244247ljh.3
        for <linux-pwm@vger.kernel.org>; Mon, 14 Feb 2022 13:22:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rXTrjGyqcJ3i7iMn5DJq5QR/kPtoX00uoKdkO1EvWnA=;
        b=KIstM/nskWTYq9yQlwG36E2RQogvhFgL6qh4w/fNLqbdN8YmUGziMH/gq6uWaiELA9
         lH47wPlLeli7KzmEqYfFDpguzW2c1pGhr86ljWVQ8kmkzmBYNv4tPZiJ5qGZo739siZt
         uKuSHnQ5NQjjCN98XZ2cbgSPe4w6VhD8wn7RunNoHLyoXBfualy5ZjH/ZWWH9QDCz2YB
         dpObgR8h1ttw8Bn4gpQGMvhEoUxHzdMMZwNXoSOw7qDs4nMvlmzMNaPw3eOBnZMu+3Dy
         r6f7hhEon+igO3RMhg1QW0TPq+roixS9EihZ/osJSCb9bsi/y40THt1zcmAEWBRS6M6Z
         9AbQ==
X-Gm-Message-State: AOAM530h6O+sCIF0Qsawjk0pEQVOI++q51O5Ygy0sR9YJFobKwnRYmmP
        3Fryt7qJT7H9208FAiZwZQUriq+5IJgUJipbYK2Aonb0+JBZSVP1mF7zz8CpUUw74Z3+4o6zCHw
        SLubDIQ0dr4+cTz9Dej2ZlEZtLQbv6GJ9KwneLQ==
X-Received: by 2002:a05:6402:34c7:: with SMTP id w7mr750385edc.397.1644873733097;
        Mon, 14 Feb 2022 13:22:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxhpmbRreV1af3l7NRnMOVACbyZVoBFnimePwQQgpSt+JN3lhtVVBwqSExQGXUXAJA1H+Jnfw==
X-Received: by 2002:a05:6402:34c7:: with SMTP id w7mr750338edc.397.1644873732938;
        Mon, 14 Feb 2022 13:22:12 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id v24sm2327203ejf.7.2022.02.14.13.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 13:22:12 -0800 (PST)
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
Subject: [PATCH v2 08/15] dt-bindings: pwm: renesas,pwm: Include generic pwm schema
Date:   Mon, 14 Feb 2022 22:21:47 +0100
Message-Id: <20220214212154.8853-9-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220214212154.8853-1-krzysztof.kozlowski@canonical.com>
References: <20220214212154.8853-1-krzysztof.kozlowski@canonical.com>
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
 .../bindings/pwm/renesas,pwm-rcar.yaml        | 26 ++++++++++---------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml
index 7ea1070b4b3a..1c94acbc2b4a 100644
--- a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml
+++ b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml
@@ -59,21 +59,23 @@ properties:
 required:
   - compatible
   - reg
-  - '#pwm-cells'
   - clocks
   - power-domains
 
-if:
-  not:
-    properties:
-      compatible:
-        contains:
-          enum:
-            - renesas,pwm-r8a7778
-            - renesas,pwm-r8a7779
-then:
-  required:
-    - resets
+allOf:
+  - $ref: pwm.yaml#
+
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - renesas,pwm-r8a7778
+                - renesas,pwm-r8a7779
+    then:
+      required:
+        - resets
 
 additionalProperties: false
 
-- 
2.32.0

