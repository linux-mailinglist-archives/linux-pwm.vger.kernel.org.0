Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBFB7527BA
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Jul 2023 17:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235064AbjGMPvz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 13 Jul 2023 11:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235051AbjGMPvy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 13 Jul 2023 11:51:54 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396B72686
        for <linux-pwm@vger.kernel.org>; Thu, 13 Jul 2023 08:51:53 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qJybd-0004ik-9i; Thu, 13 Jul 2023 17:51:49 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qJybb-00E9K8-Ux; Thu, 13 Jul 2023 17:51:47 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qJybb-004abe-2w; Thu, 13 Jul 2023 17:51:47 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] pwm: stm32: Don't modify HW state in .remove() callback
Date:   Thu, 13 Jul 2023 17:51:41 +0200
Message-Id: <20230713155142.2454010-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230713155142.2454010-1-u.kleine-koenig@pengutronix.de>
References: <20230713155142.2454010-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=960; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=roYStbkk1k9kd6bMiRdxym5fMMZxiZG1Gx7zZMzyyms=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBksB2M89QNNqHnbV4EJeLcuzOQoURLQsl6THfDG XMMl7qJUeWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZLAdjAAKCRCPgPtYfRL+ TspWB/wPt8DYaolcgPPyUUlRb8s6zVDpmXGNGelyQv/6R5N+iQWowqI8lZ3w4tJY1xh0tpKCvmW 6wbVZfJoqHy/8QsE0+WA0hwiYM5JqCzlORhgJC0aVkCPyzsEEr4A4qkyGHVhg1HN3Jd6jjMfUww s6X1AcU9jfbs0lj3L73Rl2atzVSwZ2A/xXUDucdq+LT6PgNU6DVW5beiASLFqyRjCK7ZH9oiy3+ bRLXjgdCplak2iRaYCSYD5ttGMLdJhhVMMAr0Y6S/zdu/KNdBcEfGYx7NoyVFqUt39X8aggZ+DP a6Q1+A5xilV52E7GUYRLPoe6MJ6l5dUasTa5eNKCErzzc3ao
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

A consumer is expected to disable a PWM before calling pwm_put(). And if
they didn't there is hopefully a good reason (or the consumer needs
fixing). Also if disabling an enabled PWM was the right thing to do,
this should better be done in the framework instead of in each low level
driver.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-stm32.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index 62e397aeb9aa..687967d3265f 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -649,10 +649,6 @@ static int stm32_pwm_probe(struct platform_device *pdev)
 static void stm32_pwm_remove(struct platform_device *pdev)
 {
 	struct stm32_pwm *priv = platform_get_drvdata(pdev);
-	unsigned int i;
-
-	for (i = 0; i < priv->chip.npwm; i++)
-		pwm_disable(&priv->chip.pwms[i]);
 
 	pwmchip_remove(&priv->chip);
 }
-- 
2.39.2

