Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87A657D252
	for <lists+linux-pwm@lfdr.de>; Thu, 21 Jul 2022 19:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiGURV1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 21 Jul 2022 13:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiGURV0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 21 Jul 2022 13:21:26 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF32A2CC95
        for <linux-pwm@vger.kernel.org>; Thu, 21 Jul 2022 10:21:24 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id f24-20020a1cc918000000b003a30178c022so3741097wmb.3
        for <linux-pwm@vger.kernel.org>; Thu, 21 Jul 2022 10:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XkkKPN3JJIki5/fJ0m2iMmrfk4IJDQ0Iyb2jgEwcMfA=;
        b=MPZoE7gQwOxPubrMsSNTRL2lSMXyd7GdLpsv87PPzdomrz6yEU381zHGLjU0kmnqeQ
         WtGx7JqzCm8T0cLSIzMZ5v5SrIr3ldYAkBNphbsgO6sAXriMu5lefm+3TPJzBs1yp2o4
         UNIRU3SS8Z0voBJ6/nUisMbU0iz1vkak5zWJDLUK7ntavyNgeaAkrGT8Nxxa/1sXLAen
         vY4eDgkECXnqYcPEX2Ckqn/xr5bFqLiUZFlYFin4gcB3e8pCsy49RWJEjvTMubhJT/3k
         UdnH6aq/fqdfp+5TUF5OB38JDpy3yExgYHEVNT1hfYXYmPktMJbQGROk7dqSLV+CTlDl
         xa5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XkkKPN3JJIki5/fJ0m2iMmrfk4IJDQ0Iyb2jgEwcMfA=;
        b=Z/FN9m8A5s+6DYulMktWalwmSSG8IRYaC1RzT0iJUr3rV55TOJ/bmtejfzUhrGs0Fv
         rLPq8zw1b8o0LIrbG4ZuQepYrQuT0DrMkHpQoHsNkqsWk2ts7l2gh3pR8HtvzwPVcTNv
         gt6nWHHNdA9PJkAdF/6htMFSqz/6AMEcFJyu9i7FAYxFJXd0SbetUsrq3hF32mp6W9rR
         NPxg1Tjg7RAYa5GXMBcCkPYWU5g6pXi/GNq3FWd8WK+aMS5oTYOM7ghs5UaNt9w3CBmM
         sByuBgKFR6B+zdq4Nxf/Ek7zUaaUm9hIzTpYXE7ea3Ji4dl0fZveYnbxcvh5ukd1rRBk
         U31w==
X-Gm-Message-State: AJIora/aQfW/60S9NGO6bTA0E6EIYGF06kyX1wFs8U4B/EwdJGKFFiJg
        DdRL7JswzvwonsMrJWV6AGqhIw==
X-Google-Smtp-Source: AGRyM1uhhSObQMZkAZrCHl/IohFymT6ZizEWGdATrGEa0Aj1iPY95PQHYw/2A70KC/Ux7C4ZW05kEg==
X-Received: by 2002:a1c:f314:0:b0:3a2:fee4:91d4 with SMTP id q20-20020a1cf314000000b003a2fee491d4mr8835647wmq.108.1658424083196;
        Thu, 21 Jul 2022 10:21:23 -0700 (PDT)
Received: from henark71.. ([109.76.125.251])
        by smtp.gmail.com with ESMTPSA id e24-20020a05600c219800b003a2cf1535aasm2455697wme.17.2022.07.21.10.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 10:21:22 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     u.kleine-koenig@pengutronix.de
Cc:     conor.dooley@microchip.com, daire.mcnamara@microchip.com,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org,
        robh+dt@kernel.org, thierry.reding@gmail.com,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v7 1/4] dt-bindings: pwm: fix microchip corePWM's pwm-cells
Date:   Thu, 21 Jul 2022 18:21:07 +0100
Message-Id: <20220721172109.941900-2-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220721172109.941900-1-mail@conchuod.ie>
References: <20220721172109.941900-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

corePWM is capable of inverted operation but the binding requires
\#pwm-cells of 2. Expand the binding to support setting the polarity.

Fixes: df77f7735786 ("dt-bindings: pwm: add microchip corepwm binding")
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/pwm/microchip,corepwm.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/microchip,corepwm.yaml b/Documentation/devicetree/bindings/pwm/microchip,corepwm.yaml
index a7fae1772a81..cd8e9a8907f8 100644
--- a/Documentation/devicetree/bindings/pwm/microchip,corepwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/microchip,corepwm.yaml
@@ -30,7 +30,9 @@ properties:
     maxItems: 1
 
   "#pwm-cells":
-    const: 2
+    enum: [2, 3]
+    description:
+      The only flag supported by the controller is PWM_POLARITY_INVERTED.
 
   microchip,sync-update-mask:
     description: |
-- 
2.37.1

