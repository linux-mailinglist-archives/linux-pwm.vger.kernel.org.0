Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC795087D3
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Apr 2022 14:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352951AbiDTMPn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 20 Apr 2022 08:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352795AbiDTMPl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 20 Apr 2022 08:15:41 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C018403F2
        for <linux-pwm@vger.kernel.org>; Wed, 20 Apr 2022 05:12:55 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nh9CT-00022H-QD; Wed, 20 Apr 2022 14:12:49 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nh9CT-0049dD-NZ; Wed, 20 Apr 2022 14:12:48 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nh9CR-004TjS-HB; Wed, 20 Apr 2022 14:12:47 +0200
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
Subject: [PATCH v2 2/6] pwm: renesas-tpu: Make use of devm functions
Date:   Wed, 20 Apr 2022 14:12:36 +0200
Message-Id: <20220420121240.67781-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220420121240.67781-1-u.kleine-koenig@pengutronix.de>
References: <20220420121240.67781-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1580; h=from:subject; bh=RizOx7NVXQuWK1Haoa7Gvw6F5E+q4jAUSM2k+H7UdsA=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBiX/imRIR1HDv8SwoJh5CjqhfSU/DW5wYAShAy+b2U r/FqClCJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYl/4pgAKCRDB/BR4rcrsCSfLB/ 9LhtqGRm2esY8qqYYMUcfk/Ba7rct5DwuI/InJTwldfw0JYLT0MM0lE+NdBlsGcQlAckUA2gEgYhSV OlNgOhl2/KHRnwmj0mtVpj0gRp8AJ5aEA4cPFhXde1UohEuQ+2SRPdR7xwmkCwEOoRlrnsDek+dZfp R1RgrEov6pEQal39rscgkvwZxgf7FaI0zdrxDHOKeDSzaEZNuXL3aYzduCu1D056zTIyH4o/DdeVpu 6dxp7HNJx5PgwON2ccpIwwJqyTQFST/9ZrUYYfZb0UXmcVuVz3q7ctvtqJWTkVapcRTBnyWBTURnQf MYIPa3fCeMJ/JgWpw1OCjkPNt5DU/h
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

This simplifies an error path in .probe() and allows to drop the .remove()
function.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-renesas-tpu.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/pwm/pwm-renesas-tpu.c b/drivers/pwm/pwm-renesas-tpu.c
index c3ae78e37789..12376988c70e 100644
--- a/drivers/pwm/pwm-renesas-tpu.c
+++ b/drivers/pwm/pwm-renesas-tpu.c
@@ -408,24 +408,13 @@ static int tpu_probe(struct platform_device *pdev)
 	tpu->chip.ops = &tpu_pwm_ops;
 	tpu->chip.npwm = TPU_CHANNEL_MAX;
 
-	pm_runtime_enable(&pdev->dev);
+	ret = devm_pm_runtime_enable(&pdev->dev);
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret, "Failed to enable runtime PM\n");
 
-	ret = pwmchip_add(&tpu->chip);
-	if (ret < 0) {
-		pm_runtime_disable(&pdev->dev);
+	ret = devm_pwmchip_add(&pdev->dev, &tpu->chip);
+	if (ret < 0)
 		return dev_err_probe(&pdev->dev, ret, "Failed to register PWM chip\n");
-	}
-
-	return 0;
-}
-
-static int tpu_remove(struct platform_device *pdev)
-{
-	struct tpu_device *tpu = platform_get_drvdata(pdev);
-
-	pwmchip_remove(&tpu->chip);
-
-	pm_runtime_disable(&pdev->dev);
 
 	return 0;
 }
@@ -444,7 +433,6 @@ MODULE_DEVICE_TABLE(of, tpu_of_table);
 
 static struct platform_driver tpu_driver = {
 	.probe		= tpu_probe,
-	.remove		= tpu_remove,
 	.driver		= {
 		.name	= "renesas-tpu-pwm",
 		.of_match_table = of_match_ptr(tpu_of_table),
-- 
2.35.1

