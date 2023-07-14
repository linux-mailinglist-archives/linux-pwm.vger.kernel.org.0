Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544CE754407
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Jul 2023 22:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236167AbjGNU4p (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 14 Jul 2023 16:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236023AbjGNU4p (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 14 Jul 2023 16:56:45 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659342690
        for <linux-pwm@vger.kernel.org>; Fri, 14 Jul 2023 13:56:44 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qKPq7-00086u-4g; Fri, 14 Jul 2023 22:56:35 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qKPq6-00EQSx-Ah; Fri, 14 Jul 2023 22:56:34 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qKPq5-004u4J-JR; Fri, 14 Jul 2023 22:56:33 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        kernel@pengutronix.de, linux-pwm@vger.kernel.org
Subject: [PATCH 10/10] staging: greybus: pwm: Consistenly name pwm_chip variables "chip"
Date:   Fri, 14 Jul 2023 22:56:23 +0200
Message-Id: <20230714205623.2496590-11-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230714205623.2496590-1-u.kleine-koenig@pengutronix.de>
References: <20230714205623.2496590-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1410; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=816WRzHuNgi7BIlniVAQ2x1zSBndq8zaqSwuIrNldh0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBksbZxSAHanlHxVT0WRtopjAS9TxHmeTVfCZVdh RPoraOlzAeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZLG2cQAKCRCPgPtYfRL+ TvpcB/0VR1dswEm8hTPk9XV7MZzq8oPaKXBgT1s0yooyP7rCGgGJt7drlThTU3J3D3HattQBUNb noOgVGxFVzhdl+4uqOvAw4NH3r4tH2q2hWjvMRqq1KuZa3XdZefxJeUu+qVssxxRvA9ph4Dj7FE Ei9HaXGWrH/qw+XLAQyFcMgjghg9g1zfjripniQzGFppLqwf6mnEJL/YO8RaeQ9iaHEBcVsr9zW Q5Q4GAmXXn87+sZpaqebrtRmcZlHN4q/3YMvZRTCaVSUWni8JP6T+FsV0uHHSMh8kwF9AH6FqXm UT6M0/jQSEX5Tqx8/k3sfrpOTGpxljQwM7wd1HLOd7YYtQKR
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

All function parameters of type pointer to struct pwm_chip in this
driver are called chip which is also the usual name of function
parameters and local variables in most other pwm drivers. For consistency
use the same name for the local variable of that type.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/staging/greybus/pwm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/greybus/pwm.c b/drivers/staging/greybus/pwm.c
index 88da1d796f13..c483e1f0738e 100644
--- a/drivers/staging/greybus/pwm.c
+++ b/drivers/staging/greybus/pwm.c
@@ -267,7 +267,7 @@ static int gb_pwm_probe(struct gbphy_device *gbphy_dev,
 {
 	struct gb_connection *connection;
 	struct gb_pwm_chip *pwmc;
-	struct pwm_chip *pwm;
+	struct pwm_chip *chip;
 	int ret;
 
 	pwmc = kzalloc(sizeof(*pwmc), GFP_KERNEL);
@@ -295,13 +295,13 @@ static int gb_pwm_probe(struct gbphy_device *gbphy_dev,
 	if (ret)
 		goto exit_connection_disable;
 
-	pwm = &pwmc->chip;
+	chip = &pwmc->chip;
 
-	pwm->dev = &gbphy_dev->dev;
-	pwm->ops = &gb_pwm_ops;
-	pwm->npwm = pwmc->pwm_max + 1;
+	chip->dev = &gbphy_dev->dev;
+	chip->ops = &gb_pwm_ops;
+	chip->npwm = pwmc->pwm_max + 1;
 
-	ret = pwmchip_add(pwm);
+	ret = pwmchip_add(chip);
 	if (ret) {
 		dev_err(&gbphy_dev->dev,
 			"failed to register PWM: %d\n", ret);
-- 
2.39.2

