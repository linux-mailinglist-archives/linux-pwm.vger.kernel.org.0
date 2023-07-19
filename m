Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9906475947B
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Jul 2023 13:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjGSLl1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 19 Jul 2023 07:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjGSLl0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 19 Jul 2023 07:41:26 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1103A1BFD
        for <linux-pwm@vger.kernel.org>; Wed, 19 Jul 2023 04:41:11 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fc0aecf15bso67907625e9.1
        for <linux-pwm@vger.kernel.org>; Wed, 19 Jul 2023 04:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1689766869; x=1690371669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=omclyAfkGRQWS2BiKQCx7pDx212Hyui8qaS7KiVV4jA=;
        b=asvioqTlybWzOybciqN1ksH9D2IA4G3XyJNfKHI6nskJTHwCNROLCkZIv6WQMghL9d
         F/UumjmxH8VAADIo11xP6AFf7qgsbZqunQA6bzET8dmqqL4IdflaAbHMIxy5ZGR+ZFZt
         81SGf3Fv6zhzOH9/ijWOwxmkAyvP+ov8dIoq/RbiHcORZfKlGc66mrGJyAYTLVDV9eML
         7+wmoaQaKrBOeWdfBBzAJeRdmlltzIIB8wgEbKcMVpjXbth6hTgn0oXCpNiRDSmRrex+
         wZnQT1z7EgtJtThH8crfTbBehz8pgAzYk5CERU/uHQkvthyrWInzdJQhyfi6Oc14te0m
         ZXOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689766869; x=1690371669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=omclyAfkGRQWS2BiKQCx7pDx212Hyui8qaS7KiVV4jA=;
        b=bkbmtc//nsGz+Xb8cOon3Q+T7QSWb6ELPwN7e6GGCvy5l0NS6O6vQWAoFa2d2kw8bN
         5Hd9mApO4MdU7awZGrFG7TIjWJbgIE9Eq0OVeFNRJ+Lxx7+Eic2oLbHOPRK4G1sfYjSS
         NT6VwdM1bNkGEYWYknWDRxUSFM9pX+lv0mdSGhMumZoF2fJkSn4nPbNi9uhz7ifLiSrK
         Z38mn0dI8pgSGp5gEPyvukHXfPfQz7vkxZ2z31YU2VGAMX2xcRdnbmOfblBERMdiFfF8
         mRSL1iUpYdD1nL4EYPTFJPXm+HjFL5/GTHuOQt2u1HKH87GTVmnlIzoNGIgAvgKizPM9
         LOxg==
X-Gm-Message-State: ABy/qLZkYaLCw1u/yuu9XEt7s3HvgTWsO6P8qeQZizxXv3x4A5DZS87e
        kFl3t4d+rDeRNYu1b5jjgJEQ3cV1ip95pZIjzos=
X-Google-Smtp-Source: APBJJlEhQJz3wV0yQP9Hu5jxBZIFMZNrna3knuUJntAfNSU7Rc9Nko0UhR7OKF14/DD3JJO7/HJ80w==
X-Received: by 2002:a7b:ce16:0:b0:3fa:9e61:19ed with SMTP id m22-20020a7bce16000000b003fa9e6119edmr1874710wmc.23.1689766869358;
        Wed, 19 Jul 2023 04:41:09 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:f884:f48d:2867:5c1d])
        by smtp.gmail.com with ESMTPSA id o10-20020a1c750a000000b003fbb346279dsm1485644wmc.38.2023.07.19.04.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 04:41:08 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>
Cc:     linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] gpio: mvebu: fix irq domain leak
Date:   Wed, 19 Jul 2023 13:41:01 +0200
Message-Id: <20230719114101.55051-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Uwe Kleine-König pointed out we still have one resource leak in the mvebu
driver triggered on driver detach. Let's address it with a custom devm
action.

Fixes: 812d47889a8e ("gpio/mvebu: Use irq_domain_add_linear")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-mvebu.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index a35958e7adf6..67497116ce27 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -1112,6 +1112,13 @@ static int mvebu_gpio_probe_syscon(struct platform_device *pdev,
 	return 0;
 }
 
+static void mvebu_gpio_remove_irq_domain(void *data)
+{
+	struct irq_domain *domain = data;
+
+	irq_domain_remove(domain);
+}
+
 static int mvebu_gpio_probe(struct platform_device *pdev)
 {
 	struct mvebu_gpio_chip *mvchip;
@@ -1246,13 +1253,18 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	err = devm_add_action_or_reset(&pdev->dev, mvebu_gpio_remove_irq_domain,
+				       mvchip->domain);
+	if (err)
+		return err;
+
 	err = irq_alloc_domain_generic_chips(
 	    mvchip->domain, ngpios, 2, np->name, handle_level_irq,
 	    IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_LEVEL, 0, 0);
 	if (err) {
 		dev_err(&pdev->dev, "couldn't allocate irq chips %s (DT).\n",
 			mvchip->chip.label);
-		goto err_domain;
+		return err;
 	}
 
 	/*
@@ -1292,10 +1304,6 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
 	}
 
 	return 0;
-
-err_domain:
-	irq_domain_remove(mvchip->domain);
-	return err;
 }
 
 static struct platform_driver mvebu_gpio_driver = {
-- 
2.39.2

