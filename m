Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F49729C3D
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Jun 2023 16:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240127AbjFIOHb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 9 Jun 2023 10:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240576AbjFIOHU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 9 Jun 2023 10:07:20 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2750035A9
        for <linux-pwm@vger.kernel.org>; Fri,  9 Jun 2023 07:07:14 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f655293a38so1912897e87.0
        for <linux-pwm@vger.kernel.org>; Fri, 09 Jun 2023 07:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686319632; x=1688911632;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jCeEbW1U8X5tsZ4C4X/AN2VQz3Te0cG/Jf+u2WdiQhA=;
        b=Ts+urxZPApGt0XBPTXgusp3g46WRrEeespxkpm2YhTx4scmVZLcCBxFk3uP6DxV+uf
         WN6eG0NJwH7RZ1E6L9AHyqbNzdaDRdX4zD0cYnfK3tO4HXMNlwfhaiEw3TIgCkP9qiNQ
         9iNsDNhvICxqOwA1dbgfgYbpGtGTgQHjRdXMijsThBI4U9yu42yTNgT5e2M5mQAf9oAd
         a+Gvb6QBZgaFFtTz4Ct59nJ+QsDL71nuScd4frj824CaOzpeIej0+cEL5+nx+G+d7clP
         7qam1XfhLs+cKTZ+Rr0JT5q6tU746JDLC7A6XQRoIf3/pYf5OtfddbncqVOTSYazp1xA
         18jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686319632; x=1688911632;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jCeEbW1U8X5tsZ4C4X/AN2VQz3Te0cG/Jf+u2WdiQhA=;
        b=kCYOb51iM8iJHsP9xrcCrjQPhaHGc7GGexR5IGi+6XaWXJGKPbMXUpuC/gBwkWX7V5
         yQ7Tbs/9XwlDSsXdRZRLkLiBPs6fFRH7uz3/iBkZPUYzrUr1GCW0j4l7cwXevDMFI2Cu
         KJKGevEOfJhFf+PNemtwKLcT0vytdFhZgA60DKvpVU38/1QrWmPBY/3hY8qtnd9+LLv3
         UuuI5j0uV8rKG9uQh4XrJMal3BFpVt78+eqUYKXEIPpLk7FZ0PcPCaM5u40TCTQRXWGH
         RgcYSeRigFfabzXzHPgy2ewqFj3jl6+/2V8rKYeZBoWMDTm7FrJIUtSUlFMV9bb76EgG
         vMhQ==
X-Gm-Message-State: AC+VfDyCUEROdqO81bbtc6IVyFLSWIHViPcf7h+uT5E8O0hXw3NoWdej
        vqFsa6fp29+8sK1wvbF2wruXnw==
X-Google-Smtp-Source: ACHHUZ6hAzhcinWv3jhYYd7EDXnoILzhszPHvrOnNXmIrY+BsxwZzC+2GchphS4lR8xtpjG8FhaLwQ==
X-Received: by 2002:a2e:9656:0:b0:2ad:95dd:8802 with SMTP id z22-20020a2e9656000000b002ad95dd8802mr1292972ljh.38.1686319632281;
        Fri, 09 Jun 2023 07:07:12 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id kg6-20020a17090776e600b009661484e84esm1319651ejc.191.2023.06.09.07.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 07:07:11 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: pwm: drop unneeded quotes
Date:   Fri,  9 Jun 2023 16:07:09 +0200
Message-Id: <20230609140709.64655-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Cleanup bindings dropping unneeded quotes. Once all these are fixed,
checking for this can be enabled in yamllint.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/pwm/atmel,at91sam-pwm.yaml | 2 +-
 Documentation/devicetree/bindings/pwm/mxs-pwm.yaml           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/atmel,at91sam-pwm.yaml b/Documentation/devicetree/bindings/pwm/atmel,at91sam-pwm.yaml
index ab45df80345d..d84268b59784 100644
--- a/Documentation/devicetree/bindings/pwm/atmel,at91sam-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/atmel,at91sam-pwm.yaml
@@ -11,7 +11,7 @@ maintainers:
   - Claudiu Beznea <claudiu.beznea@microchip.com>
 
 allOf:
-  - $ref: "pwm.yaml#"
+  - $ref: pwm.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/pwm/mxs-pwm.yaml b/Documentation/devicetree/bindings/pwm/mxs-pwm.yaml
index a34cbc13f691..6ffbed204c25 100644
--- a/Documentation/devicetree/bindings/pwm/mxs-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/mxs-pwm.yaml
@@ -25,7 +25,7 @@ properties:
     const: 3
 
   fsl,pwm-number:
-    $ref: '/schemas/types.yaml#/definitions/uint32'
+    $ref: /schemas/types.yaml#/definitions/uint32
     description: u32 value representing the number of PWM devices
 
 required:
-- 
2.34.1

