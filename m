Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E977164FC
	for <lists+linux-pwm@lfdr.de>; Tue, 30 May 2023 16:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbjE3Otm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 30 May 2023 10:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232956AbjE3Ot3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 30 May 2023 10:49:29 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD3C18D
        for <linux-pwm@vger.kernel.org>; Tue, 30 May 2023 07:49:18 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2af1a7d2f6aso49860781fa.1
        for <linux-pwm@vger.kernel.org>; Tue, 30 May 2023 07:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685458156; x=1688050156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=07SVfkqZ0qgipCgWqf2WUuDolS+hCGhbSje3XLty2Ao=;
        b=aPeYmCNt05cObjx95ndQCrOdKmC01qE9rKbj1E0y9u+++2RIcqlsWtlkGyGI2n1xbU
         AghcT3BWhigFLgjE4GPxSIys40q1Sl8bw+sC08K6jVCsHQe1FDuz+txGGgs4K7+tN9lv
         D+4p4yaduPEphpO5OXOqcpkPAhLrj3akuiJimPh+rPajTiJxAjHzij7o/Rb5N41Szij0
         Vfjo2jfGnHworYtyq2Bgw0ZYnG2uSy5rKuQvaYzL13g1eDccob4no3SUelsX3xA+WyXc
         Qeq3VqRPuVvPCLgdqEFa3pTldVfXGj5yH9H+3Chlgzhm00nwJTyVe701en4WhppjApJz
         aTzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685458156; x=1688050156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=07SVfkqZ0qgipCgWqf2WUuDolS+hCGhbSje3XLty2Ao=;
        b=fjXzrCtroehjVPkePsZZ0e2hOALk1h9xydvEhNcQBqq50a2ZFjMdcTR6dt3WsJ5SU9
         QZRgIyekFz2y/oy8ru531Jw1nEf7nZ9WENGff2/oimuiDEbnWPbARGwoDTVKyeqKMG4s
         OPxvvgT2/5YwV12N2NgcGFn0XlqLfc2oaRgD2O9/+QKx1dXGa1zhaAWWbl+0ySOMRFiF
         +REISYcPk1d14puQdP9HfSSHt7MFW9iTHmXrbhcxygDQy30RdDYtIslK9Fm/S8izXXfu
         O6OQhlbTd8HX1GtpoNw9IVncdFzMVeHX5AwSk02pwyzK9WYWjDRgS0m+2OKgycigiCsb
         R9Fg==
X-Gm-Message-State: AC+VfDyLc1UgWQg24k/MHJeogS3Cnorscwie46nRbSvFeD/S8SnUUv3+
        D53KBqDe54mxuHPX0g6LBGec3w==
X-Google-Smtp-Source: ACHHUZ4eIHTpavdLEXQppq1HffGyODpAFKw+HJwL/rxKmW3KOl/YjNnJCyJOlMEXir4uXif/y/NFgw==
X-Received: by 2002:a2e:c42:0:b0:2ac:67f7:25a2 with SMTP id o2-20020a2e0c42000000b002ac67f725a2mr897767ljd.50.1685458156521;
        Tue, 30 May 2023 07:49:16 -0700 (PDT)
Received: from krzk-bin.. ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id q21-20020aa7cc15000000b00514b2717ec6sm631283edt.28.2023.05.30.07.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 07:49:16 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Dipen Patel <dipenp@nvidia.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dilip Kota <eswara.kota@linux.intel.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-rtc@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-spi@vger.kernel.org, timestamp@lists.linux.dev,
        linux-watchdog@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH 7/7] dt-bindings: watchdog: restrict node name suffixes
Date:   Tue, 30 May 2023 16:48:51 +0200
Message-Id: <20230530144851.92059-8-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530144851.92059-1-krzysztof.kozlowski@linaro.org>
References: <20230530144851.92059-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Make the pattern matching node names a bit stricter to improve DTS
consistency.  The pattern is restricted to -N suffixes to decimal
numbers.

Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: Tony Lindgren <tony@atomide.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>
---
 Documentation/devicetree/bindings/watchdog/watchdog.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/watchdog.yaml b/Documentation/devicetree/bindings/watchdog/watchdog.yaml
index 519b48889eb1..f0a584af1223 100644
--- a/Documentation/devicetree/bindings/watchdog/watchdog.yaml
+++ b/Documentation/devicetree/bindings/watchdog/watchdog.yaml
@@ -17,11 +17,11 @@ description: |
 select:
   properties:
     $nodename:
-      pattern: "^watchdog(@.*|-[0-9a-f])?$"
+      pattern: "^watchdog(@.*|-([0-9]|[1-9][0-9]+))?$"
 
 properties:
   $nodename:
-    pattern: "^(timer|watchdog)(@.*|-[0-9a-f])?$"
+    pattern: "^(timer|watchdog)(@.*|-([0-9]|[1-9][0-9]+))?$"
 
   timeout-sec:
     description:
-- 
2.34.1

