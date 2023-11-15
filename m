Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9F37E5416
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Nov 2023 11:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344673AbjKHKpt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 8 Nov 2023 05:45:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344613AbjKHKpI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 8 Nov 2023 05:45:08 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D360D25A1
        for <linux-pwm@vger.kernel.org>; Wed,  8 Nov 2023 02:44:30 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4094301d505so49863915e9.2
        for <linux-pwm@vger.kernel.org>; Wed, 08 Nov 2023 02:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699440269; x=1700045069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KctpUSdWE/54mxPRyNTPmujVIdTxIZHiWXcrFdF3THY=;
        b=ccDWKSsepNdzxAZzpSRff3RpSbOw2z7uL893OeJIi7hJ1ZtgFqkPD1eMgHxVpIxjm4
         Noy93WRG3BA7xhDgXSwydj/LTBimwrM9Z5KdMzfKde2gJm+f/8N12qUzUyzoqwxYoTjw
         1u3LISa3YXeAvdfRzCwXljWUz5vFttcCMBvWb3db1lx3gIxkS6TDDeEd8W5ycCPxzbRs
         DmdnHiUd936F1RArK0GGITNyj5tlFLQtEXSf4KWn4mnbJRAFnW3dUfFTs0vz+A0ktqsv
         h0u69rLe1JhcFsMcgJJVmLZq8aS6j+0Opvf+dkgwFGiIvLPEn9CIePWpZ3+0IHaocrSa
         6yog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699440269; x=1700045069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KctpUSdWE/54mxPRyNTPmujVIdTxIZHiWXcrFdF3THY=;
        b=KLhi+xNNBD1iWlsbIHqNRF0WlLGoRJoGeLeLjKmzniEFbv4QvJ9LyxBLYfEIxXH1dn
         t+wQYSK6WFelog0kwL2+/JhXbsKd0uGWojDsc1nmoO03/4ebASYT6v2s+VpTIuQM5uxX
         OOg1EvK+qAg0pwk3GTIUEHaqdHu3/amNZ2mb7NCTuFZpVGDSWIZfDKFDOqwzP5zaW/9T
         Yc4ynpCZjWLwUXptIIJ/w5jwPEVR++Sf1WK0TGayrXAcvd2QEGpadeOJbKvLI8iQ1lJk
         J7ZRD2TGLIVoxA1qEPVkq34Li0QgUTznnCS6f+NO4y4U9+WVg9irnDzExISHLWq8J1BA
         Z/cA==
X-Gm-Message-State: AOJu0YztpZUNDtRKEB9BvPOdyFkqsLHNfDKJFvVsWt8tEemf/K1M0K5j
        L1sYm2LtY1ns9kliFvwIdBNQyA==
X-Google-Smtp-Source: AGHT+IHzwZ3ZbfxwsqY/KR9bhuCoW2rtwV2Pv+17xFR8bqeY33bUZ7438zeD8MQhwfV4phLl2aoutg==
X-Received: by 2002:a05:600c:1c82:b0:406:53aa:7a5f with SMTP id k2-20020a05600c1c8200b0040653aa7a5fmr1423336wms.10.1699440269098;
        Wed, 08 Nov 2023 02:44:29 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id fj12-20020a05600c0c8c00b004094c5d92bdsm19377377wmb.31.2023.11.08.02.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 02:44:28 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Lee Jones <lee@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 09/17] dt-bindings: gpu: arm,mali-midgard: add specific compatibles for existing Exynos SoC
Date:   Wed,  8 Nov 2023 11:43:35 +0100
Message-Id: <20231108104343.24192-10-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231108104343.24192-1-krzysztof.kozlowski@linaro.org>
References: <20231108104343.24192-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Samsung Exynos SoC reuses several devices from older designs, thus
historically we kept the old (block's) compatible only.  This works fine
and there is no bug here, however guidelines expressed in
Documentation/devicetree/bindings/writing-bindings.rst state that:
1. Compatibles should be specific.
2. We should add new compatibles in case of bugs or features.

Add compatibles specific to each SoC in front of all old-SoC-like
compatibles.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

I propose to take the patch through Samsung SoC (me). See cover letter
for explanation.
---
 Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
index ca02baba5526..0801da33a385 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
@@ -40,6 +40,11 @@ properties:
               - rockchip,rk3288-mali
               - samsung,exynos5433-mali
           - const: arm,mali-t760
+      - items:
+          - enum:
+              - samsung,exynos7-mali
+          - const: samsung,exynos5433-mali
+          - const: arm,mali-t760
       - items:
           - enum:
               - rockchip,rk3399-mali
-- 
2.34.1

