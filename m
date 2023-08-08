Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C39774407
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 20:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235481AbjHHSOr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 14:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235395AbjHHSOR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 14:14:17 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D421DD75
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:20:18 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQND-0007TH-0L; Tue, 08 Aug 2023 19:19:59 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNB-00228a-K8; Tue, 08 Aug 2023 19:19:57 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNA-00BTEn-HW; Tue, 08 Aug 2023 19:19:56 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 072/101] pwm: atmel: Stop using struct pwm_chip::dev
Date:   Tue,  8 Aug 2023 19:19:02 +0200
Message-Id: <20230808171931.944154-73-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1709; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Tlkt5QtYQzuW6CJsfqvs2K26N/B4hUB1/jYH9m079V0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0nkB3jz0wFWik2b5WH+yXP5sxx1eRgR4KCu9m 8rnCDye3p+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ5AQAKCRCPgPtYfRL+ TuJFB/9eYx464s3BRNZLKL4Da+k9qQSgDeqtBjeykahQTNf9DkSAL/0kNCJws5PCo65Zld6Kl0F xLrTx3yHK/wmbIqQELiiVGHeO6NE3bjYtseXGTv5vTySqZg9nmerEoH2jsGkG0F/s81hjU9VRfK KhTgD2Ds9csNBX6qbgPXMc5jQ8df7rlXhIc5jsq93Qn4o4bhzbJNj3pYtrX+uyJg6Kbgf5o0IHT wAm1VcXWs1RTDoi85pXF+TOsEvHWP+X/xCB/dqBlrHnGo/IqQeemv+ukdtHzMqNnSk69JdTKego 1XqulN0JQSaFFNapzE1eyNxnHZgAu2dZ2TI+gFUA54beU8t0
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

struct pwm_chip::dev is about to change. To not have to touch this
driver in the same commit as struct pwm_chip::dev, pass the parent
device pointer to atmel_pwm_enable_clk_if_on().

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-atmel.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index 48b79b8488a4..0f6a53a14dd0 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -455,7 +455,7 @@ static const struct of_device_id atmel_pwm_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, atmel_pwm_dt_ids);
 
-static int atmel_pwm_enable_clk_if_on(struct pwm_chip *chip, bool on)
+static int atmel_pwm_enable_clk_if_on(struct device *dev, struct pwm_chip *chip, bool on)
 {
 	struct atmel_pwm_chip *atmel_pwm = to_atmel_pwm_chip(chip);
 	unsigned int i, cnt = 0;
@@ -474,7 +474,7 @@ static int atmel_pwm_enable_clk_if_on(struct pwm_chip *chip, bool on)
 	for (i = 0; i < cnt; i++) {
 		ret = clk_enable(atmel_pwm->clk);
 		if (ret) {
-			dev_err_probe(chip->dev, ret,
+			dev_err_probe(dev, ret,
 				"failed to enable clock for pwm\n");
 
 			cnt = i;
@@ -518,7 +518,7 @@ static int atmel_pwm_probe(struct platform_device *pdev)
 
 	chip->ops = &atmel_pwm_ops;
 
-	ret = atmel_pwm_enable_clk_if_on(chip, true);
+	ret = atmel_pwm_enable_clk_if_on(&pdev->dev, chip, true);
 	if (ret < 0)
 		return ret;
 
@@ -531,7 +531,7 @@ static int atmel_pwm_probe(struct platform_device *pdev)
 	return 0;
 
 disable_clk:
-	atmel_pwm_enable_clk_if_on(chip, false);
+	atmel_pwm_enable_clk_if_on(&pdev->dev, chip, false);
 
 	return ret;
 }
-- 
2.40.1

