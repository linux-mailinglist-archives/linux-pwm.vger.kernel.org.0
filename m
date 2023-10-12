Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371DF7C7310
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347334AbjJLQdA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379466AbjJLQc7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:32:59 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E295C0
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:32:56 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqycI-0000fv-M8; Thu, 12 Oct 2023 18:32:54 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqycI-001CC2-9O; Thu, 12 Oct 2023 18:32:54 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqycI-00F5VT-0D; Thu, 12 Oct 2023 18:32:54 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 102/109] drm/bridge: ti-sn65dsi86: Make use of devm_pwmchip_alloc() function
Date:   Thu, 12 Oct 2023 18:32:31 +0200
Message-ID: <20231012163227.1004288-15-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2447; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=ItBmtlaQHP7m7f8o58JUP5g0vUwTWVJUdPe+lGKGcPo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKB+fStx9nVPTprIBN8EbM/Zz1zPZT8uc/u8vB OW4FlamzaiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSgfnwAKCRCPgPtYfRL+ Tv7tCACjtg0dQkw+5l51ZZ+AyCfD1UxumbiWEGPoNJEVeT+FJqcviATHaK0XmR6ldb8XIbhikGl Jm1vO80OVnGJVlyD+Kzhz/pUSNVRluDhu1gGyYbDqfUik73KJQRlqFCP3bahXbjqHSCJ9fpR6Pe h8maLYBtRMQsbWKxP7xMMLCZr6aDkBlKSCoITZCoD/dYcn+xaYB+QzRDrHg5wtvh+6gIgmOtZCC 4Va5Q1+GFIbp/XQljw9TZszY5Edi4rn0PtZ8BQxwaQ/I9v+AY0S8iZv2AyasQMEebkMZRFOISAQ 0S+SLo7FFl/ypAVfsFvMMkEs9hIGtvcrNdxQ3hI4ZI63vxdC
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index 08e8c4f333e3..cb68c035bc2f 100644
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
@@ -1372,7 +1372,8 @@ static void ti_sn_pwm_pin_release(struct ti_sn65dsi86 *pdata)
 
 static struct ti_sn65dsi86 *pwm_chip_to_ti_sn_bridge(struct pwm_chip *chip)
 {
-	return container_of(chip, struct ti_sn65dsi86, pchip);
+	struct ti_sn65dsi86 **pdata = pwmchip_priv(chip);
+	return *pdata;
 }
 
 static int ti_sn_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
@@ -1585,22 +1586,28 @@ static const struct pwm_ops ti_sn_pwm_ops = {
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
2.42.0

