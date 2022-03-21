Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB564E2AD7
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Mar 2022 15:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344963AbiCUOeK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 21 Mar 2022 10:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350126AbiCUOeD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Mar 2022 10:34:03 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CBC5DA48
        for <linux-pwm@vger.kernel.org>; Mon, 21 Mar 2022 07:32:37 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id bi13-20020a05600c3d8d00b0038c2c33d8f3so7790010wmb.4
        for <linux-pwm@vger.kernel.org>; Mon, 21 Mar 2022 07:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XM3tuLIOLKuoFOGCnY9ldxq/B57btEuYeuN4M8XmqsQ=;
        b=k3TzaFkW2ITtzM+ipWQmPH7EIvZpjfq8tQXSnSYfYtORSg9E1JlqkSn52OEEY+PrGJ
         eJ51kHd9HhC8ydWL2YRSl6myblzxJc11I8wWFookSRr6345W6G4DRfORu+06YiMWO7x4
         q0tK2xPNaw9DlfxE1j10+xFxC8SHLabyQDjXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XM3tuLIOLKuoFOGCnY9ldxq/B57btEuYeuN4M8XmqsQ=;
        b=WWKkOskGlPV7LUmzwhVa5B4wzZujmXj5HmsDNfzrmtSRcwlv0qBcoID411MBhX7UCv
         tzJZ+J7pT/8V/IEnUO8FCnffsBIczQNU0cn7YLqwCes91a2ynp5xQkX61QbKcuDMky5b
         OCWoGDUfEcymCnhNaBlboMCB4BJIMmElzXpjd5CNxULfQ4FbqWMgLIb7RxzSBTcyPE8G
         PsOE5pcq9wiGZs4cnxspE05nuZqiP791k6HzmJQCMs/Wj5dt6MG23Fv2dcqH2W+pTf4W
         eb9UhwhapaNsWAStzRMlVxZu6oVi6+Jx4dowfYayxazt4r+nMCFnqPzmsUfUGND7BiTK
         ZoDw==
X-Gm-Message-State: AOAM532wGVJgItEh4/NorMoeN1AziZm0I9veN/0Sv9c4jepTa0m+IetE
        hNX7bYJaxeuqX2kQvzRFB8ujkQ==
X-Google-Smtp-Source: ABdhPJzW2HXM8hROOAKovH/CzhxqdjaB32lrjzpcegwTpr9JvugZ7L0ibXz6TMnHAH/T+i8p9t2LsA==
X-Received: by 2002:a05:600c:5029:b0:38c:9768:b4c with SMTP id n41-20020a05600c502900b0038c97680b4cmr9940150wmr.123.1647873156559;
        Mon, 21 Mar 2022 07:32:36 -0700 (PDT)
Received: from fabiobaltieri-linux.lan ([37.228.205.1])
        by smtp.gmail.com with ESMTPSA id u11-20020a05600c19cb00b00389efe9c512sm19092793wmq.23.2022.03.21.07.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 07:32:36 -0700 (PDT)
From:   Fabio Baltieri <fabiobaltieri@chromium.org>
To:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        chrome-platform@lists.linux.dev, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fabio Baltieri <fabiobaltieri@chromium.org>
Subject: [PATCH 3/4] dt-bindings: update google,cros-ec-pwm documentation
Date:   Mon, 21 Mar 2022 14:32:21 +0000
Message-Id: <20220321143222.2523373-4-fabiobaltieri@chromium.org>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
In-Reply-To: <20220321143222.2523373-1-fabiobaltieri@chromium.org>
References: <20220321143222.2523373-1-fabiobaltieri@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Update google,cros-ec-pwm node documentation to mention the
google,use_pwm_type property.

Signed-off-by: Fabio Baltieri <fabiobaltieri@chromium.org>
---
 .../devicetree/bindings/pwm/google,cros-ec-pwm.yaml         | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml b/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
index 4cfbffd8414a..2224e8e07029 100644
--- a/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
@@ -19,6 +19,12 @@ description: |
 properties:
   compatible:
     const: google,cros-ec-pwm
+
+  google,use_pwm_type:
+    description:
+      Use PWM types (CROS_EC_PWM_DT_<...>) instead of generic channels.
+    type: boolean
+
   "#pwm-cells":
     description: The cell specifies the PWM index.
     const: 1
-- 
2.35.1.894.gb6a874cedc-goog

