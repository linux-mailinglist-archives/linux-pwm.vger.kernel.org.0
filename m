Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79A8774405
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 20:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235361AbjHHSOp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 14:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235372AbjHHSOQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 14:14:16 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADDC1DD6D
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:20:18 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNB-0007RL-PG; Tue, 08 Aug 2023 19:19:57 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNA-002285-9a; Tue, 08 Aug 2023 19:19:56 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN9-00BTET-Gg; Tue, 08 Aug 2023 19:19:55 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 067/101] drm/bridge: ti-sn65dsi86: Make use of devm_pwmchip_alloc() function
Date:   Tue,  8 Aug 2023 19:18:57 +0200
Message-Id: <20230808171931.944154-68-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2447; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=OJBTltTN+wZJC9+Thju+57NUGpgGJb55yG5h5ViKOZw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0nj88VDaGhC03tc+DB+6i32/L0mShM5Tvmn0u WqqMwIHXQGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ4/AAKCRCPgPtYfRL+ TtA5B/44AZ2bSMw2aB1FJdpSqnXwuNVg9E85HKAOHg+wFkt0JsKsPcKZF+Gt/n5aPA6vCGQi+uS 4q9CJ/NwWvA+HEiLA62RZh9LkfUTw30NMyihwTPj5aqGSDBijK1eowMDfxRtF2mknTPscxh8ZGu UlMx+AlbZJv83HKGAmOYI2ni3/A643tuBncVWLZGgQCmKROxi7/2yBNAHSubST0nWlgpmh9xaR+ /uXbH1X8rI2r7eNSMatogd7NxD3C8hto8Xh2pbojexqpbxY+HD3wC8yJK/t88wg5BRyIRZ7ce5e wPWdI8mXKYocAR6uz4GCJm/QDGmZH2CMHLnL0/nj5ljG3fe0
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

This prepares the pwm driver of the ti-sn65dsi86 to further changes of
the pwm core outlined in the commit introducing devm_pwmchip_alloc().
There is no intended semantical change and the driver should behave as
before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 53d133d18c18..1469993acda9 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -197,7 +197,7 @@ struct ti_sn65dsi86 {
 	DECLARE_BITMAP(gchip_output, SN_NUM_GPIOS);
 #endif
 #if defined(CONFIG_PWM)
-	struct pwm_chip			pchip;
+	struct pwm_chip			*pchip;
 	bool				pwm_enabled;
 	atomic_t			pwm_pin_busy;
 #endif
@@ -1363,7 +1363,8 @@ static void ti_sn_pwm_pin_release(struct ti_sn65dsi86 *pdata)
 
 static struct ti_sn65dsi86 *pwm_chip_to_ti_sn_bridge(struct pwm_chip *chip)
 {
-	return container_of(chip, struct ti_sn65dsi86, pchip);
+	struct ti_sn65dsi86 **pdata = pwmchip_priv(chip);
+	return *pdata;
 }
 
 static int ti_sn_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
@@ -1576,22 +1577,28 @@ static const struct pwm_ops ti_sn_pwm_ops = {
 static int ti_sn_pwm_probe(struct auxiliary_device *adev,
 			   const struct auxiliary_device_id *id)
 {
+	struct pwm_chip *chip;
 	struct ti_sn65dsi86 *pdata = dev_get_drvdata(adev->dev.parent);
 
-	pdata->pchip.dev = pdata->dev;
-	pdata->pchip.ops = &ti_sn_pwm_ops;
-	pdata->pchip.npwm = 1;
-	pdata->pchip.of_xlate = of_pwm_single_xlate;
-	pdata->pchip.of_pwm_n_cells = 1;
+	/* XXX: should this better use adev->dev instead of pdata->dev? */
+	pdata->pchip = chip = devm_pwmchip_alloc(pdata->dev, 1, sizeof(&pdata));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
 
-	return pwmchip_add(&pdata->pchip);
+	*(struct ti_sn65dsi86 **)pwmchip_priv(chip) = pdata;
+
+	chip->ops = &ti_sn_pwm_ops;
+	chip->of_xlate = of_pwm_single_xlate;
+	chip->of_pwm_n_cells = 1;
+
+	return pwmchip_add(chip);
 }
 
 static void ti_sn_pwm_remove(struct auxiliary_device *adev)
 {
 	struct ti_sn65dsi86 *pdata = dev_get_drvdata(adev->dev.parent);
 
-	pwmchip_remove(&pdata->pchip);
+	pwmchip_remove(pdata->pchip);
 
 	if (pdata->pwm_enabled)
 		pm_runtime_put_sync(pdata->dev);
-- 
2.40.1

