Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76B9674EB1
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Jan 2023 08:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjATHxm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 20 Jan 2023 02:53:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjATHxm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 20 Jan 2023 02:53:42 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DC8360AD
        for <linux-pwm@vger.kernel.org>; Thu, 19 Jan 2023 23:53:41 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pImDS-0005yP-Uz; Fri, 20 Jan 2023 08:53:38 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pImDR-007K62-HQ; Fri, 20 Jan 2023 08:53:37 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pImDQ-00EKwo-Nj; Fri, 20 Jan 2023 08:53:36 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH] gpio: mvebu: Use IS_REACHABLE instead of IS_ENABLED for CONFIG_PWM
Date:   Fri, 20 Jan 2023 08:53:33 +0100
Message-Id: <20230120075333.142223-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1481; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=USu3DUBJDrfJf+3pujPCoB/v8LwNdQJnO9NlK868guA=; b=owGbwMvMwMV48I9IxdpTbzgZT6slMSSf8qi0O7dsq//nJ3mZP8+Grmy2V/1vpfvEw4q9lmPhVPtn ziEHOxmNWRgYuRhkxRRZ6oq0xCZIrPlvV7KEG2YQKxPIFAYuTgGYSME29v9195ynNavq5oWoBT1fMq MhqM/9yVMpJ8bVjXxmYTt77Xm1BYzVGfMTBVY3BbZZ5GjE3PRY2DJXQjnyWHuEYLeYZXvcwjlrkp/e kPsgm/jo+NPU3auKXHxLQ/ZfLTTaPq1wcfTk5fURv1oF39k8mWzVHibpNuWmb96JHYlcb+pUFjKl31 xwMfrwUZUL3Ak7qgs0YoPEFywwtPrTMm1LwyoVDwmBV4z29aLMKfeFMv4VcTaedg4Ot3OZ0Vh6KejJ rjiLC3cYeedtvak6oTG4Yda36LeeTn77oz6bnVpzUur3LM9vEiZmAcan3ef2cHfI+2kvCGUKm31C7d 0WmU8ZllWiQcumiAXqz9yccqAKAA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

To check if a certain function (here e.g. pwmchip_add()) can be called
IS_REACHABLE is the better check. The relevant difference to IS_ENABLED
is that IS_REACHABLE evaluates to 0 if the current code is builtin but the
checked symbol is =m and so must not be used.

Today there is no practical impact as CONFIG_PWM is a bool.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/gpio/gpio-mvebu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 91a4232ee58c..a68f682aec01 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -1002,7 +1002,7 @@ static int mvebu_gpio_suspend(struct platform_device *pdev, pm_message_t state)
 		BUG();
 	}
 
-	if (IS_ENABLED(CONFIG_PWM))
+	if (IS_REACHABLE(CONFIG_PWM))
 		mvebu_pwm_suspend(mvchip);
 
 	return 0;
@@ -1054,7 +1054,7 @@ static int mvebu_gpio_resume(struct platform_device *pdev)
 		BUG();
 	}
 
-	if (IS_ENABLED(CONFIG_PWM))
+	if (IS_REACHABLE(CONFIG_PWM))
 		mvebu_pwm_resume(mvchip);
 
 	return 0;
@@ -1228,7 +1228,7 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
 	devm_gpiochip_add_data(&pdev->dev, &mvchip->chip, mvchip);
 
 	/* Some MVEBU SoCs have simple PWM support for GPIO lines */
-	if (IS_ENABLED(CONFIG_PWM)) {
+	if (IS_REACHABLE(CONFIG_PWM)) {
 		err = mvebu_pwm_probe(pdev, mvchip, id);
 		if (err)
 			return err;
-- 
2.39.0

