Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E695087DA
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Apr 2022 14:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352856AbiDTMPs (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 20 Apr 2022 08:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352925AbiDTMPn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 20 Apr 2022 08:15:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9838366B5
        for <linux-pwm@vger.kernel.org>; Wed, 20 Apr 2022 05:12:57 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nh9CT-00022G-QD; Wed, 20 Apr 2022 14:12:50 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nh9CT-0049d9-IV; Wed, 20 Apr 2022 14:12:48 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nh9CR-004TjP-Bh; Wed, 20 Apr 2022 14:12:47 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-renesas-soc@vger.kernel.org, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH v2 1/6] pwm: renesas-tpu: Make use of dev_err_probe()
Date:   Wed, 20 Apr 2022 14:12:35 +0200
Message-Id: <20220420121240.67781-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220420121240.67781-1-u.kleine-koenig@pengutronix.de>
References: <20220420121240.67781-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1513; h=from:subject; bh=JivNFMG/z4JeGqeX79lb9aRv8j7uIu1q/mvnNaxM3To=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBiX/ijrJRk1V/r/AZjlh9RbAxavLxrSjeh6hNH4jER ZdJXenWJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYl/4owAKCRDB/BR4rcrsCWVXB/ 90gac5gMe2eBImJ4fxE2FIFg1mOO4vpXSkG4scShZh8oSDGz+mHT/Sdrii5d20J+PLbiZZAUH8noNg Pz0rZDmV4Py+f9NdksaIDP7sTUoR0xY/A87oxVR88kzFjwFC4Yl+7CK/knApLVIwqW4vuawSaIn0/v MOuElSLas7yP8fOc6PNXN/WNbv7W/oUwUlxf87oWheu0Nf4IYz+58KleWUOyebOc7ZDF2MCf3iBNRo qzHpuNdrRTmpaBZ8cnixVwdzLhxG7mW3LRjfJEeH/VSo+5cGAz/NubVGB7BtrI/SXhjPMrmutDgdbm 47gv3dSXGw/d3LoT2ruETg8UpTFaNi
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The added benefit is that the error code is mentioned in the error message
and its usage is a bit more compact than open coding it. This also
improves behaviour in case devm_clk_get() returns -EPROBE_DEFER.

While touching this code, consistently start error messages with upper
case.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-renesas-tpu.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-renesas-tpu.c b/drivers/pwm/pwm-renesas-tpu.c
index 4381df90a527..c3ae78e37789 100644
--- a/drivers/pwm/pwm-renesas-tpu.c
+++ b/drivers/pwm/pwm-renesas-tpu.c
@@ -398,10 +398,8 @@ static int tpu_probe(struct platform_device *pdev)
 		return PTR_ERR(tpu->base);
 
 	tpu->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(tpu->clk)) {
-		dev_err(&pdev->dev, "cannot get clock\n");
-		return PTR_ERR(tpu->clk);
-	}
+	if (IS_ERR(tpu->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(tpu->clk), "Failed to get clock\n");
 
 	/* Initialize and register the device. */
 	platform_set_drvdata(pdev, tpu);
@@ -414,9 +412,8 @@ static int tpu_probe(struct platform_device *pdev)
 
 	ret = pwmchip_add(&tpu->chip);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to register PWM chip\n");
 		pm_runtime_disable(&pdev->dev);
-		return ret;
+		return dev_err_probe(&pdev->dev, ret, "Failed to register PWM chip\n");
 	}
 
 	return 0;
-- 
2.35.1

