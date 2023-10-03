Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86FD57B6C28
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Oct 2023 16:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240231AbjJCOvj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 3 Oct 2023 10:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240210AbjJCOvi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 3 Oct 2023 10:51:38 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394DDAD
        for <linux-pwm@vger.kernel.org>; Tue,  3 Oct 2023 07:51:31 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-405497850dbso10118335e9.0
        for <linux-pwm@vger.kernel.org>; Tue, 03 Oct 2023 07:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696344689; x=1696949489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OPe8AHR8wi1voZ8KVZNMBYnfWuXXWrqVYf9QOeCgRow=;
        b=Rxs9TAGJdbi2gKUKE0Ia70WFSl84rtSF5PPgjoUU46x6sPf+ErBKZ/VWWnG3ePBxJ8
         ATfREpXhj5hsKgAPiuK3usk1Ujp8xBvxqdRv1nKWSSG/ixFOUgHcZ67GvbOVAF9XZ2gx
         KZPNxTnnDQ+Xm1Etk9SE8bCH4hGeTOimyNMqVxJZEbL+sGu9CZym48+oTE+9eJEmuH60
         A2OOmpbaDQlLRHhdpb56Yrd+NZAeGP9v3Ppll4YoY9+WAdjyE9PZBT3N0vduCSZRpQLh
         ytudJKuxrZG3DxNfDgBvP/cLIDc1HINKyOHowV0XpQCAMSxdxQG/BwtJ1lc8vDzPY3l1
         czEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696344689; x=1696949489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OPe8AHR8wi1voZ8KVZNMBYnfWuXXWrqVYf9QOeCgRow=;
        b=ofAenn2OFbTInDMXWLm30i3lPo7SiFWsP6PusqgZPElolsX/ANKQwF4nZWBRMG0xpK
         V30HG/505Th8dROjOrGu97A5AdL0Dgr9KeOwHtdvDsYsogMC2rknHyUjNDaN7XDQpWNr
         Fh+HFtzwY9l0Qvz1qitUkgMji+rcFOIZeWH4TT6SU20I1KWRBWAtPaM0ulFHlj88p2Hk
         3ENca9er9PE1pzTEmCsQJxtz0EpnMDFnyPyjmwoB/7NREDLRZs4WqAKPJbdBSuKfJb9R
         O2oJUKfdzDt5XYgbfSH9OYB/a4EmHomyaDbYDIUVKYxr3aheCWhGn85wWdEZnApQY4V8
         xjmA==
X-Gm-Message-State: AOJu0YxH4YCalLpi3iOrRDyV+VI73s6HBWlFusK9LO4RJEfjT5z+3KKw
        RMg2SV0IW1zdJIO+3edSgEeWiw==
X-Google-Smtp-Source: AGHT+IE7WkAhpO4uOd0mSjQYrlfWjfBqmbsmbHR1es665edFUjbmy7dIdzgSyEHgJJYKi7QK9qaTsQ==
X-Received: by 2002:a05:600c:2948:b0:405:3f06:c07e with SMTP id n8-20020a05600c294800b004053f06c07emr12250543wmd.15.1696344689690;
        Tue, 03 Oct 2023 07:51:29 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:1f2d:3479:a5de:fa35])
        by smtp.gmail.com with ESMTPSA id c15-20020a05600c0acf00b003fe29f6b61bsm1462773wmr.46.2023.10.03.07.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 07:51:29 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org
Subject: [PATCH 09/36] gpio: mvebu: use new pinctrl GPIO helpers
Date:   Tue,  3 Oct 2023 16:50:47 +0200
Message-Id: <20231003145114.21637-10-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231003145114.21637-1-brgl@bgdev.pl>
References: <20231003145114.21637-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Replace the pinctrl helpers taking the global GPIO number as argument
with the improved variants that instead take a pointer to the GPIO chip
and the controller-relative offset.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-mvebu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 67497116ce27..8fada9cd258a 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -345,7 +345,7 @@ static int mvebu_gpio_direction_input(struct gpio_chip *chip, unsigned int pin)
 	 * Check with the pinctrl driver whether this pin is usable as
 	 * an input GPIO
 	 */
-	ret = pinctrl_gpio_direction_input(chip->base + pin);
+	ret = pinctrl_gpio_direction_input_new(chip, pin);
 	if (ret)
 		return ret;
 
@@ -365,7 +365,7 @@ static int mvebu_gpio_direction_output(struct gpio_chip *chip, unsigned int pin,
 	 * Check with the pinctrl driver whether this pin is usable as
 	 * an output GPIO
 	 */
-	ret = pinctrl_gpio_direction_output(chip->base + pin);
+	ret = pinctrl_gpio_direction_output_new(chip, pin);
 	if (ret)
 		return ret;
 
-- 
2.39.2
