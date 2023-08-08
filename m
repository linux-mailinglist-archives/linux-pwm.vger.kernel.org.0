Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9BF774B10
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 22:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjHHUjv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 16:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjHHUjc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 16:39:32 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D8B1DD43
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:20:09 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN7-0007Jh-8v; Tue, 08 Aug 2023 19:19:53 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN5-00226E-Pj; Tue, 08 Aug 2023 19:19:51 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN5-00BTD6-2K; Tue, 08 Aug 2023 19:19:51 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 046/101] pwm: rz-mtu3: Make use of devm_pwmchip_alloc() function
Date:   Tue,  8 Aug 2023 19:18:36 +0200
Message-Id: <20230808171931.944154-47-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3385; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=M4Nwl0i59Bo3wiarwUSi/0EZodp8E0xpUdU8tWJZcbc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0njkrUdoHhZdp5VcxPvHaTIvup0IRqibHF0j1 Yc69jJitMmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ45AAKCRCPgPtYfRL+ TgjHCACUgeXw9NTGc8/xC+LxKdOrAm78kdsC4Uk0nkITqirAa3IyM0i6Nl0RYmb1unmCzJ0pB8R KvcOSo0kthFgl+i2Tb4B9HqiaO3gGJ69SwBntpTVy3MgVc9QrtD+ogmI5+dw30YqzcnjrzGS7Zv yHFJI9BDvAlUBStQMpRQsPY4F+e9d2dWvMXc5wBnIuKS6QJUjnZ3yqLEvecnRMhxtyvRcNxoMT+ ysS98fOQxgo9Y+1KM3gQ0z62Vv21BOa+DcEUOACKUL1uVhHStVMf5reXwsMIOOq97svS7zO9+Nd jTEOppc8ixLQj9nQ40R7jAxnmNLGBGOXDjjAMehfP8nI3hZr
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This prepares the pwm-rz-mtu3 driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-rz-mtu3.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/pwm/pwm-rz-mtu3.c b/drivers/pwm/pwm-rz-mtu3.c
index bdda315b3bd3..ff396e2de7ab 100644
--- a/drivers/pwm/pwm-rz-mtu3.c
+++ b/drivers/pwm/pwm-rz-mtu3.c
@@ -72,7 +72,7 @@ struct rz_mtu3_pwm_channel {
  */
 
 struct rz_mtu3_pwm_chip {
-	struct pwm_chip chip;
+	struct device *parent;
 	struct clk *clk;
 	struct mutex lock;
 	unsigned long rate;
@@ -92,7 +92,7 @@ static const struct rz_mtu3_channel_io_map channel_map[] = {
 
 static inline struct rz_mtu3_pwm_chip *to_rz_mtu3_pwm_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct rz_mtu3_pwm_chip, chip);
+	return pwmchip_priv(chip);
 }
 
 static void rz_mtu3_pwm_read_tgr_registers(struct rz_mtu3_pwm_channel *priv,
@@ -219,7 +219,7 @@ static int rz_mtu3_pwm_enable(struct rz_mtu3_pwm_chip *rz_mtu3_pwm,
 	u8 val;
 	int rc;
 
-	rc = pm_runtime_resume_and_get(rz_mtu3_pwm->chip.dev);
+	rc = pm_runtime_resume_and_get(rz_mtu3_pwm->parent);
 	if (rc)
 		return rc;
 
@@ -265,7 +265,7 @@ static void rz_mtu3_pwm_disable(struct rz_mtu3_pwm_chip *rz_mtu3_pwm,
 
 	mutex_unlock(&rz_mtu3_pwm->lock);
 
-	pm_runtime_put_sync(rz_mtu3_pwm->chip.dev);
+	pm_runtime_put_sync(rz_mtu3_pwm->parent);
 }
 
 static int rz_mtu3_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -465,21 +465,24 @@ static void rz_mtu3_pwm_pm_disable(void *data)
 	struct rz_mtu3_pwm_chip *rz_mtu3_pwm = data;
 
 	clk_rate_exclusive_put(rz_mtu3_pwm->clk);
-	pm_runtime_disable(rz_mtu3_pwm->chip.dev);
-	pm_runtime_set_suspended(rz_mtu3_pwm->chip.dev);
+	pm_runtime_disable(rz_mtu3_pwm->parent);
+	pm_runtime_set_suspended(rz_mtu3_pwm->parent);
 }
 
 static int rz_mtu3_pwm_probe(struct platform_device *pdev)
 {
 	struct rz_mtu3 *parent_ddata = dev_get_drvdata(pdev->dev.parent);
+	struct pwm_chip *chip;
 	struct rz_mtu3_pwm_chip *rz_mtu3_pwm;
 	struct device *dev = &pdev->dev;
 	unsigned int i, j = 0;
 	int ret;
 
-	rz_mtu3_pwm = devm_kzalloc(&pdev->dev, sizeof(*rz_mtu3_pwm), GFP_KERNEL);
-	if (!rz_mtu3_pwm)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, RZ_MTU3_MAX_PWM_CHANNELS, sizeof(*rz_mtu3_pwm));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	rz_mtu3_pwm = to_rz_mtu3_pwm_chip(chip);
+	rz_mtu3_pwm->parent = &pdev->dev;
 
 	rz_mtu3_pwm->clk = parent_ddata->clk;
 
@@ -514,15 +517,13 @@ static int rz_mtu3_pwm_probe(struct platform_device *pdev)
 
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
-	rz_mtu3_pwm->chip.dev = &pdev->dev;
 	ret = devm_add_action_or_reset(&pdev->dev, rz_mtu3_pwm_pm_disable,
 				       rz_mtu3_pwm);
 	if (ret < 0)
 		return ret;
 
-	rz_mtu3_pwm->chip.ops = &rz_mtu3_pwm_ops;
-	rz_mtu3_pwm->chip.npwm = RZ_MTU3_MAX_PWM_CHANNELS;
-	ret = devm_pwmchip_add(&pdev->dev, &rz_mtu3_pwm->chip);
+	chip->ops = &rz_mtu3_pwm_ops;
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
 
-- 
2.40.1

