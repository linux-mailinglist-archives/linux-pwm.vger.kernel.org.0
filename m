Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481F57748C0
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 21:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236506AbjHHTiN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 15:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236503AbjHHThw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 15:37:52 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E7E1DD27
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:20:27 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNG-0007kb-Um; Tue, 08 Aug 2023 19:20:02 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNG-0022AP-97; Tue, 08 Aug 2023 19:20:02 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNF-00BTGD-6X; Tue, 08 Aug 2023 19:20:01 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 094/101] pwm: tiecap: Store parent device in driver data
Date:   Tue,  8 Aug 2023 19:19:24 +0200
Message-Id: <20230808171931.944154-95-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3117; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=tmnBzXbIfjaIl6BF4DChJ+sqJ/C5Ccq+7BqLP66Wiv4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0nkazyHNXCqM7pl1LSFaHK2BM3PgvK/Ev63dK 2PVi7eUefSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ5GgAKCRCPgPtYfRL+ Tr3ZB/sGYiplo87MBUYhCJZ6iPO9Jc0GtZfeVhVCVkBl31eky3ZtdKXkvIP8OhxJnBGybf6LCBh q+lG+ATV2Qlb7pXQ/RSEspAbAvbOmLyUNdgChMlQ1x0QocZV25gx0nkGHBTP3V46hHYwI2RKfxs Zml+A5qfLHv1VR3Cn+Iaozsd7vlLdfoZNUhTsvRM107LDlgMyrMZheqpD2F3q36Ef5z2at8zbKp +524YReqjR0S01CWQPI2HsHXvwSZAFZgPCpTsUYeQs8J6kGlaN0sQ5SVS3rrlALQKOUe5bC30a4 MDAnq9ROpQ3wL4jD9IaoFG4l2WrLQOmzTPsRV65qN221jF8y
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
driver in the same commit as struct pwm_chip::dev, store a pointer to
the parent device in driver data.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-tiecap.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-tiecap.c b/drivers/pwm/pwm-tiecap.c
index 9ff9a6de8be2..dfdec2a19b15 100644
--- a/drivers/pwm/pwm-tiecap.c
+++ b/drivers/pwm/pwm-tiecap.c
@@ -32,6 +32,7 @@ struct ecap_context {
 };
 
 struct ecap_pwm_chip {
+	struct device *parent;
 	unsigned int clk_rate;
 	void __iomem *mmio_base;
 	struct ecap_context ctx;
@@ -69,7 +70,7 @@ static int ecap_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		duty_cycles = (u32)c;
 	}
 
-	pm_runtime_get_sync(chip->dev);
+	pm_runtime_get_sync(pc->parent);
 
 	value = readw(pc->mmio_base + ECCTL2);
 
@@ -99,7 +100,7 @@ static int ecap_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		writew(value, pc->mmio_base + ECCTL2);
 	}
 
-	pm_runtime_put_sync(chip->dev);
+	pm_runtime_put_sync(pc->parent);
 
 	return 0;
 }
@@ -110,7 +111,7 @@ static int ecap_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct ecap_pwm_chip *pc = to_ecap_pwm_chip(chip);
 	u16 value;
 
-	pm_runtime_get_sync(chip->dev);
+	pm_runtime_get_sync(pc->parent);
 
 	value = readw(pc->mmio_base + ECCTL2);
 
@@ -123,7 +124,7 @@ static int ecap_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	writew(value, pc->mmio_base + ECCTL2);
 
-	pm_runtime_put_sync(chip->dev);
+	pm_runtime_put_sync(pc->parent);
 
 	return 0;
 }
@@ -134,7 +135,7 @@ static int ecap_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	u16 value;
 
 	/* Leave clock enabled on enabling PWM */
-	pm_runtime_get_sync(chip->dev);
+	pm_runtime_get_sync(pc->parent);
 
 	/*
 	 * Enable 'Free run Time stamp counter mode' to start counter
@@ -161,7 +162,7 @@ static void ecap_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	writew(value, pc->mmio_base + ECCTL2);
 
 	/* Disable clock on PWM disable */
-	pm_runtime_put_sync(chip->dev);
+	pm_runtime_put_sync(pc->parent);
 }
 
 static int ecap_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -239,6 +240,7 @@ static int ecap_pwm_probe(struct platform_device *pdev)
 		return PTR_ERR(clk);
 	}
 
+	pc->parent = &pdev->dev;
 	pc->clk_rate = clk_get_rate(clk);
 	if (!pc->clk_rate) {
 		dev_err(&pdev->dev, "failed to get clock rate\n");
@@ -273,11 +275,11 @@ static void ecap_pwm_save_context(struct pwm_chip *chip)
 {
 	struct ecap_pwm_chip *pc = to_ecap_pwm_chip(chip);
 
-	pm_runtime_get_sync(chip->dev);
+	pm_runtime_get_sync(pc->parent);
 	pc->ctx.ecctl2 = readw(pc->mmio_base + ECCTL2);
 	pc->ctx.cap4 = readl(pc->mmio_base + CAP4);
 	pc->ctx.cap3 = readl(pc->mmio_base + CAP3);
-	pm_runtime_put_sync(chip->dev);
+	pm_runtime_put_sync(pc->parent);
 }
 
 static void ecap_pwm_restore_context(struct pwm_chip *chip)
-- 
2.40.1

