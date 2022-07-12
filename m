Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B60572088
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Jul 2022 18:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234303AbiGLQPd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 12 Jul 2022 12:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233821AbiGLQPd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 12 Jul 2022 12:15:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D867CA6D2
        for <linux-pwm@vger.kernel.org>; Tue, 12 Jul 2022 09:15:32 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oBIXp-0003lx-A9; Tue, 12 Jul 2022 18:15:29 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oBIXn-000Xqc-BZ; Tue, 12 Jul 2022 18:15:27 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oBIXm-004lKC-Oy; Tue, 12 Jul 2022 18:15:26 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Vladimir Zapolskiy <vz@mleia.com>,
        Ariel D'Alessandro <ariel@vanguardiasur.com.ar>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
Subject: [PATCH 1/2] pwm: lpc18xx: Convert to use dev_err_probe()
Date:   Tue, 12 Jul 2022 18:15:18 +0200
Message-Id: <20220712161519.44010-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1981; h=from:subject; bh=XTdYQGNYHBg/yfhYrF5ihnVxsNAWuFyJDuFug36m8/w=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBizZ4Qn5OUR+231DyhluYJgc8lQLXIgw1ls1MenYg6 0FRvyaiJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYs2eEAAKCRDB/BR4rcrsCUR5CA CfPxr+2sBRAcsPLWjQ/OVAq7Q589KpP5lJ9j3ZXoLY45RIYw2PKQDDejmZn6JmwvwPTrQOoQTp6baW VrcGimYOTNREbzCsQb9nWLev+h7aB+J7ORpemEcmK2QZre6WCgd5QWP0KSiRDJEdR62u/QHAr3BMKp 8iCp/JCN/qkYIzTth1xhOSm1hNyu5UjNPp6RvIYunSfibAEEIvnHHVl+hxhdP8I5HOhIXLkxyUUEhJ s4WuwE7UXzXWtwyumXqVM9R9B/Q4QL8hFZX9WGmcZPG0rq/mBUmkH3EaFo74bvgjaCsqiGa1q+bKNz wuzN56PaOgJbko2Jg13JBXOJ+ShamE
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This has various upsides:
 - It emits the symbolic name of the error code
 - It is silent in the EPROBE_DEFER case and properly sets the defer reason
 - It reduces the number of code lines slightly

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-lpc18xx-sct.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-lpc18xx-sct.c b/drivers/pwm/pwm-lpc18xx-sct.c
index 272e0b5d01b8..9bb2693cece3 100644
--- a/drivers/pwm/pwm-lpc18xx-sct.c
+++ b/drivers/pwm/pwm-lpc18xx-sct.c
@@ -359,21 +359,19 @@ static int lpc18xx_pwm_probe(struct platform_device *pdev)
 		return PTR_ERR(lpc18xx_pwm->base);
 
 	lpc18xx_pwm->pwm_clk = devm_clk_get(&pdev->dev, "pwm");
-	if (IS_ERR(lpc18xx_pwm->pwm_clk)) {
-		dev_err(&pdev->dev, "failed to get pwm clock\n");
-		return PTR_ERR(lpc18xx_pwm->pwm_clk);
-	}
+	if (IS_ERR(lpc18xx_pwm->pwm_clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(lpc18xx_pwm->pwm_clk),
+				     "failed to get pwm clock\n");
 
 	ret = clk_prepare_enable(lpc18xx_pwm->pwm_clk);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "could not prepare or enable pwm clock\n");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret,
+				     "could not prepare or enable pwm clock\n");
 
 	lpc18xx_pwm->clk_rate = clk_get_rate(lpc18xx_pwm->pwm_clk);
 	if (!lpc18xx_pwm->clk_rate) {
-		dev_err(&pdev->dev, "pwm clock has no frequency\n");
-		ret = -EINVAL;
+		ret = dev_err_probe(&pdev->dev,
+				    -EINVAL, "pwm clock has no frequency\n");
 		goto disable_pwmclk;
 	}
 
@@ -423,7 +421,7 @@ static int lpc18xx_pwm_probe(struct platform_device *pdev)
 
 	ret = pwmchip_add(&lpc18xx_pwm->chip);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "pwmchip_add failed: %d\n", ret);
+		dev_err_probe(&pdev->dev, ret, "pwmchip_add failed\n");
 		goto disable_pwmclk;
 	}
 

base-commit: 394b517585da9fbb2eea2f2103ff47d37321e976
-- 
2.36.1

