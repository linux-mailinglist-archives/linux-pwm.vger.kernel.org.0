Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5BD774412
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 20:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233986AbjHHSPA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 14:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234256AbjHHSOd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 14:14:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568771DD25
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:20:26 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNG-0007iW-89; Tue, 08 Aug 2023 19:20:02 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNF-0022A6-FH; Tue, 08 Aug 2023 19:20:01 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNE-00BTFz-IH; Tue, 08 Aug 2023 19:20:00 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 091/101] pwm: stm32: Store parent device in driver data
Date:   Tue,  8 Aug 2023 19:19:21 +0200
Message-Id: <20230808171931.944154-92-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1605; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=lLxAroJeVevmGcksfaS0q2koAXoDLsC4mKx3U1giMkI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0nkXvkNYd0TiNlwghk0L18IJ59CT1MFJ7Am4d VxKTEX6Z9yJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ5FwAKCRCPgPtYfRL+ Tu59B/0YLGOGwxHmIQ7lcQ9D91YwgkZ2YK39HnesfGwT4xb11MwhFZLd6jimDz+ixZ8u9oOXQv/ yB8FFtZK40kPalvFGkkXEXldEjNG+Zd/bwxnhXtM4bvcLavRMkTUMdIh+zQ9sUzMra7TltM2HP8 z5iOK0GV/bhN6fbUZdHg4QWKm4XpGT1uDoxxWtRkJeXFQC779f8E6kNaaMND9wC3C3ZsZ7IRlWn pbi+fmiKd92rFwIr4hV/hgC4JVxImcYGNk/tu0jbR7oVUbW9xEWZEdIrRCBEelOhgpiVkazohPg 6zXw+GOmoTTlBryeeKVFqhds9qwzI+GVlGu7GWNgLjcfvTBf
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
 drivers/pwm/pwm-stm32.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index 73fbd7a119ec..e07c43e38724 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -27,6 +27,7 @@ struct stm32_breakinput {
 };
 
 struct stm32_pwm {
+	struct device *parent;
 	struct mutex lock; /* protect pwm config/enable */
 	struct clk *clk;
 	struct regmap *regmap;
@@ -108,7 +109,7 @@ static int stm32_pwm_raw_capture(struct stm32_pwm *priv, struct pwm_device *pwm,
 				 unsigned long tmo_ms, u32 *raw_prd,
 				 u32 *raw_dty)
 {
-	struct device *parent = pwm->chip->dev->parent;
+	struct device *parent = priv->parent;
 	enum stm32_timers_dmas dma_id;
 	u32 ccen, ccr;
 	int ret;
@@ -184,7 +185,7 @@ static int stm32_pwm_capture(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	ret = clk_enable(priv->clk);
 	if (ret) {
-		dev_err(chip->dev, "failed to enable counter clock\n");
+		dev_err(priv->parent, "failed to enable counter clock\n");
 		goto unlock;
 	}
 
@@ -621,6 +622,7 @@ static int stm32_pwm_probe(struct platform_device *pdev)
 	priv = to_stm32_pwm_dev(chip);
 
 	mutex_init(&priv->lock);
+	priv->parent = &pdev->dev;
 	priv->regmap = ddata->regmap;
 	priv->clk = ddata->clk;
 	priv->max_arr = ddata->max_arr;
-- 
2.40.1

