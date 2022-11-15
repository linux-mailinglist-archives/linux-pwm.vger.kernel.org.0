Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205466296F5
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Nov 2022 12:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237742AbiKOLP0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 15 Nov 2022 06:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiKOLO6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 15 Nov 2022 06:14:58 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF00A63A0
        for <linux-pwm@vger.kernel.org>; Tue, 15 Nov 2022 03:14:00 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1outt8-0006Wf-IW; Tue, 15 Nov 2022 12:13:58 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1outt6-004Qgb-Px; Tue, 15 Nov 2022 12:13:57 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1outt6-00GmRc-SM; Tue, 15 Nov 2022 12:13:56 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 2/5] pwm: img: Use regmap_clear_bits and regmap_set_bits where applicable
Date:   Tue, 15 Nov 2022 12:13:44 +0100
Message-Id: <20221115111347.3705732-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221115111347.3705732-1-u.kleine-koenig@pengutronix.de>
References: <20221115111347.3705732-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1734; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=9inmb3ps3i4GrYiuuooXggo9VrU0AP++NrgI4p9QfKs=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjc3Ra7eEJ/1v4O8TygpU+QoECyQJQyI8YRTFrVs/e ALPciwWJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY3N0WgAKCRDB/BR4rcrsCfm1B/ wPy8Cb+H87t0RQ0PO/iGGJ/xJVHAzFkQLorRm3X92EsmZ261WrwASzmEdBaBJzIaaiwQ0gFWM4w+7a XJp7268gxuQ9pbAC2JE05L1Y1RtDAqu7SckGnHQYkx0Oo15L95H3ZaIDzumpeVwilVc+NXHVb4JgN7 5WzQzj9sjzdMarCZg7qRPfPmmddZlF3J5mKJNMa5Pwcb04E5cU4GrmlMi+06ZfV46K6Jqmr7GY65fB Bx26fpLNwFo8gPcB4DkYbyQvhQuNmqoD/YQaGcy9g+6XsJKzIv9SCNcGabSlFdINbcMD0bInQ1TjKq eMKIgzpXebIG61LQHB3YcGlb0WBMr8
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

Found using coccinelle and the following semantic patch:

@@
expression map, reg, bits;
@@

- regmap_update_bits(map, reg, bits, bits)
+ regmap_set_bits(map, reg, bits)

@@
expression map, reg, bits;
@@

- regmap_update_bits(map, reg, bits, 0)
+ regmap_clear_bits(map, reg, bits)

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-img.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-img.c b/drivers/pwm/pwm-img.c
index 0fccf061ab95..89362afe3c91 100644
--- a/drivers/pwm/pwm-img.c
+++ b/drivers/pwm/pwm-img.c
@@ -161,9 +161,9 @@ static int img_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	val |= BIT(pwm->hwpwm);
 	img_pwm_writel(imgchip, PWM_CTRL_CFG, val);
 
-	regmap_update_bits(imgchip->periph_regs, PERIP_PWM_PDM_CONTROL,
-			   PERIP_PWM_PDM_CONTROL_CH_MASK <<
-			   PERIP_PWM_PDM_CONTROL_CH_SHIFT(pwm->hwpwm), 0);
+	regmap_clear_bits(imgchip->periph_regs, PERIP_PWM_PDM_CONTROL,
+			  PERIP_PWM_PDM_CONTROL_CH_MASK <<
+			  PERIP_PWM_PDM_CONTROL_CH_SHIFT(pwm->hwpwm));
 
 	return 0;
 }
@@ -397,11 +397,10 @@ static int img_pwm_resume(struct device *dev)
 
 	for (i = 0; i < imgchip->chip.npwm; i++)
 		if (imgchip->suspend_ctrl_cfg & BIT(i))
-			regmap_update_bits(imgchip->periph_regs,
-					   PERIP_PWM_PDM_CONTROL,
-					   PERIP_PWM_PDM_CONTROL_CH_MASK <<
-					   PERIP_PWM_PDM_CONTROL_CH_SHIFT(i),
-					   0);
+			regmap_clear_bits(imgchip->periph_regs,
+					  PERIP_PWM_PDM_CONTROL,
+					  PERIP_PWM_PDM_CONTROL_CH_MASK <<
+					  PERIP_PWM_PDM_CONTROL_CH_SHIFT(i));
 
 	if (pm_runtime_status_suspended(dev))
 		img_pwm_runtime_suspend(dev);
-- 
2.38.1

