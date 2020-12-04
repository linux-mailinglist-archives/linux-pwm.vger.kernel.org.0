Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 203532CEE63
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Dec 2020 13:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbgLDMxG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 4 Dec 2020 07:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbgLDMxG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 4 Dec 2020 07:53:06 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA27C0613D1
        for <linux-pwm@vger.kernel.org>; Fri,  4 Dec 2020 04:52:19 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id d17so8489842ejy.9
        for <linux-pwm@vger.kernel.org>; Fri, 04 Dec 2020 04:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Oylrc0uqpT7rXT0yMKZnwvKFGY3fe2zGWD5fRYQnkx0=;
        b=Ljfx/2118E/eUylhoO0m8f50LM1MY3BmbUwP1bLGtlGrKWNvxFbut+172iPtL0FYGn
         p8LYQlGmI8TF7E3NGS+XXW3ocKwSiK2niCW23XO5+EEGhbNM7DgonjLkYUCzUEhUwGU8
         GYE8wMYOVOMd6Gkt2Tthq3WUqeZg9SIND4aBdXwwXrqRbkfnXMwTvjGM7mvpPkMhVHZf
         evKtMjeX71xyiWiCUQrkJCmmOgcPFQHPXZ+5i8c/M0y789J/RLdreQughpjIhHI6Tc1L
         4saQ0A16dXmJ0vEuNKrJVf4jakWyTH83lYJiYR208/Duvy3NUCRYhDCXBpqSyyWeGevM
         Jmcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Oylrc0uqpT7rXT0yMKZnwvKFGY3fe2zGWD5fRYQnkx0=;
        b=jrWo7DS9kHPjwuOrD7WEXtlgXAofIrHOk0g1Pa8hpZoKbZkOFm4tH1msWrMFk7OrmM
         QoGDD0ib92ByT7Te/XomKoYn2FShptxxUEr9I5Opve3nRHg1SVDKg0fWlvucvwo5+T0J
         m8Gri7XmoJNB4cFmCErD4U5IbPMGY8FMFxzD6y5dTvPjCJttAvUwRI5a7kjNp/ZzZA/L
         Y/XkXKcCDA+0YlARGaWbInzYGheJVjxawUNARYMUgrClCqpPXvJutWw3EHoutBVco5ht
         e9l6kt79LP1Y8XCdDuwE991qwmVfT9rhoDn1hdMuVyZmQ9A+ZWRbtSX0Nn/NK91y0gr4
         hoUA==
X-Gm-Message-State: AOAM530+PRmMDj3T7P/79kpnHFOqGuVWMaWDvYsCNh2thxuDM0yS6LEv
        L/mXTUqLCz/vI+w7s1FywyI=
X-Google-Smtp-Source: ABdhPJySa462TDd9QUnsEm3zaRA58N+DWk56jOVDb/ojkxrA+Pze0RxnTWE/bWkOp5GgnWpGLliTZA==
X-Received: by 2002:a17:906:b7d6:: with SMTP id fy22mr6960867ejb.219.1607086338532;
        Fri, 04 Dec 2020 04:52:18 -0800 (PST)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id u1sm3406497edf.65.2020.12.04.04.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 04:52:17 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-pwm@vger.kernel.org, Michael Walle <michael@walle.cc>
Subject: [PATCH] pwm: sl28cpld: Set driver data before registering the PWM chip
Date:   Fri,  4 Dec 2020 13:52:13 +0100
Message-Id: <20201204125213.3426567-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The PWM core code can call back into the PWM chip's implementation at
any time after the chip has been registered. Since the driver uses
driver data to store contextual information, registration must happen
after the driver data has been set.

Reported-by: Michael Walle <michael@walle.cc>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
---
 drivers/pwm/pwm-sl28cpld.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-sl28cpld.c b/drivers/pwm/pwm-sl28cpld.c
index 5046b6b7fd35..c5866a2b47b5 100644
--- a/drivers/pwm/pwm-sl28cpld.c
+++ b/drivers/pwm/pwm-sl28cpld.c
@@ -230,6 +230,8 @@ static int sl28cpld_pwm_probe(struct platform_device *pdev)
 	chip->base = -1;
 	chip->npwm = 1;
 
+	platform_set_drvdata(pdev, priv);
+
 	ret = pwmchip_add(&priv->pwm_chip);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to add PWM chip (%pe)",
@@ -237,8 +239,6 @@ static int sl28cpld_pwm_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	platform_set_drvdata(pdev, priv);
-
 	return 0;
 }
 
-- 
2.29.2

