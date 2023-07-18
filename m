Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C8F758469
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jul 2023 20:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjGRSTK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 18 Jul 2023 14:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjGRSTG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 18 Jul 2023 14:19:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE69139
        for <linux-pwm@vger.kernel.org>; Tue, 18 Jul 2023 11:18:59 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLpHl-0001oE-E2; Tue, 18 Jul 2023 20:18:57 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLpHk-000QmZ-Fb; Tue, 18 Jul 2023 20:18:56 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLpHj-005unW-FF; Tue, 18 Jul 2023 20:18:55 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 02/18] pwm: ab8500: Make use of devm_pwmchip_alloc() function
Date:   Tue, 18 Jul 2023 20:18:33 +0200
Message-Id: <20230718181849.3947851-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230718181849.3947851-1-u.kleine-koenig@pengutronix.de>
References: <20230718181849.3947851-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1989; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=j4uAwUurJypeSdxizIMiaQuiIwvUzhli2zbuKMiIcAQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkttbp70UsZH3uny2i7Tdro3pYU/wbI9RqUhijY eLvEiUhp+OJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZLbW6QAKCRCPgPtYfRL+ TsnIB/9cidRlbiXpBBzJTMp6XyQF1FtTIp9wduiQO72jtBasWoZo/ORe11hRLJbHEHlpFmKFffW dNFKGqNd1m8nfyurXrFcAG+fWVg66qqo6uZG+qXd9aKupFlVWNFMVM003eexUd63QvCXIGEOF/N w1yzOJfS+P/21LnULPO5uxZBNe4HPyLxndr6KynMndN0nzL3H4DviLXjl/SWf5srs6GxaV0lDII Eb0IDe/y6ZUvgAkJPZV9HpLPJ+rWG9v62ePz0ad0FSytQKrglAyKzF7J+bFZ8N3yXA8HPfEaPSy uZrEUCXmE7lMW1B6Rx2JwZRl6x+AArnG067jrqKssx1A8+Bg
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This prepares the pwm-ab8500 driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-ab8500.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-ab8500.c b/drivers/pwm/pwm-ab8500.c
index 583a7d69c741..7b4b4a5d1bfe 100644
--- a/drivers/pwm/pwm-ab8500.c
+++ b/drivers/pwm/pwm-ab8500.c
@@ -24,13 +24,12 @@
 #define AB8500_PWM_CLKRATE 9600000
 
 struct ab8500_pwm_chip {
-	struct pwm_chip chip;
 	unsigned int hwid;
 };
 
 static struct ab8500_pwm_chip *ab8500_pwm_from_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct ab8500_pwm_chip, chip);
+	return pwmchip_priv(chip);
 }
 
 static int ab8500_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -186,6 +185,7 @@ static const struct pwm_ops ab8500_pwm_ops = {
 
 static int ab8500_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct ab8500_pwm_chip *ab8500;
 	int err;
 
@@ -196,16 +196,17 @@ static int ab8500_pwm_probe(struct platform_device *pdev)
 	 * Nothing to be done in probe, this is required to get the
 	 * device which is required for ab8500 read and write
 	 */
-	ab8500 = devm_kzalloc(&pdev->dev, sizeof(*ab8500), GFP_KERNEL);
-	if (ab8500 == NULL)
+	chip = devm_pwmchip_alloc(&pdev->dev, sizeof(*ab8500));
+	if (chip == NULL)
 		return -ENOMEM;
 
-	ab8500->chip.dev = &pdev->dev;
-	ab8500->chip.ops = &ab8500_pwm_ops;
-	ab8500->chip.npwm = 1;
+	ab8500 = pwmchip_priv(chip);
+
+	chip->ops = &ab8500_pwm_ops;
+	chip->npwm = 1;
 	ab8500->hwid = pdev->id - 1;
 
-	err = devm_pwmchip_add(&pdev->dev, &ab8500->chip);
+	err = devm_pwmchip_add(&pdev->dev, chip);
 	if (err < 0)
 		return dev_err_probe(&pdev->dev, err, "Failed to add pwm chip\n");
 
-- 
2.39.2

