Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039387B37B6
	for <lists+linux-pwm@lfdr.de>; Fri, 29 Sep 2023 18:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbjI2QTa (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 29 Sep 2023 12:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232878AbjI2QT2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 29 Sep 2023 12:19:28 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E3A1AC
        for <linux-pwm@vger.kernel.org>; Fri, 29 Sep 2023 09:19:25 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmGD4-0007mp-TU; Fri, 29 Sep 2023 18:19:22 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmGD4-009r5M-8Z; Fri, 29 Sep 2023 18:19:22 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmGD3-00615p-VY; Fri, 29 Sep 2023 18:19:21 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: [PATCH 01/11] pwm: bcm-iproc: Simplify using devm functions
Date:   Fri, 29 Sep 2023 18:19:08 +0200
Message-Id: <20230929161918.2410424-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230929161918.2410424-1-u.kleine-koenig@pengutronix.de>
References: <20230929161918.2410424-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2437; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=ERyhciCA04TfeX25jegLMhASLw0ApQxkpNXNpIiU3tM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlFvj1P4aDlXwggTIrFyXeFdwCfrtz5dlmBli3P hvrmJk1c1eJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRb49QAKCRCPgPtYfRL+ TpmuB/9qLE5kip8zbKmex6zWVo7dnGaN83Rw04bpB+yzv8SAa62gcpkUcrJdHFN7hZhEtOI/BeY za2LKRsstcDCtm3UR3WLxFtk5Kgl7YvH/MT2WO4zobmLqRHWuurQRvvFl72opv5fqA1oNj+Fq2q T5ID+eAerMN2K/doMD0oN/BfrpDjwyWo9X1cmCsRPUeTyZnZOsNZhL6wsPhuVqdqLdk0IVR9O4u YKJO5GBAfsfnAxMZhIbM5mST30Te7jGa55dtHMdUMzjJrOzmQMhcjZDaOCQLI1UU5d2wdnc4Hco ZrwENkrt9QX2C/q+rPWfgEAfhj+aYpfdpWovqlRztqmQYUTZ
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

With devm_clk_get_enabled() the call to clk_disable_unprepare() can be
dropped from the error path and the remove callback. With
devm_pwmchip_add() pwmchip_remove() can be dropped. Then the remove
callback is empty and can go away, too.

Also use dev_err_probe() for simplified (and improved) error reporting.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-bcm-iproc.c | 37 +++++++++----------------------------
 1 file changed, 9 insertions(+), 28 deletions(-)

diff --git a/drivers/pwm/pwm-bcm-iproc.c b/drivers/pwm/pwm-bcm-iproc.c
index 7d70b6f186a6..39f93f76a310 100644
--- a/drivers/pwm/pwm-bcm-iproc.c
+++ b/drivers/pwm/pwm-bcm-iproc.c
@@ -207,18 +207,10 @@ static int iproc_pwmc_probe(struct platform_device *pdev)
 	if (IS_ERR(ip->base))
 		return PTR_ERR(ip->base);
 
-	ip->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(ip->clk)) {
-		dev_err(&pdev->dev, "failed to get clock: %ld\n",
-			PTR_ERR(ip->clk));
-		return PTR_ERR(ip->clk);
-	}
-
-	ret = clk_prepare_enable(ip->clk);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to enable clock: %d\n", ret);
-		return ret;
-	}
+	ip->clk = devm_clk_get_enabled(&pdev->dev, NULL);
+	if (IS_ERR(ip->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(ip->clk),
+				     "failed to get clock\n");
 
 	/* Set full drive and normal polarity for all channels */
 	value = readl(ip->base + IPROC_PWM_CTRL_OFFSET);
@@ -230,22 +222,12 @@ static int iproc_pwmc_probe(struct platform_device *pdev)
 
 	writel(value, ip->base + IPROC_PWM_CTRL_OFFSET);
 
-	ret = pwmchip_add(&ip->chip);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to add PWM chip: %d\n", ret);
-		clk_disable_unprepare(ip->clk);
-	}
+	ret = devm_pwmchip_add(&pdev->dev, &ip->chip);
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to add PWM chip\n");
 
-	return ret;
-}
-
-static void iproc_pwmc_remove(struct platform_device *pdev)
-{
-	struct iproc_pwmc *ip = platform_get_drvdata(pdev);
-
-	pwmchip_remove(&ip->chip);
-
-	clk_disable_unprepare(ip->clk);
+	return 0;
 }
 
 static const struct of_device_id bcm_iproc_pwmc_dt[] = {
@@ -260,7 +242,6 @@ static struct platform_driver iproc_pwmc_driver = {
 		.of_match_table = bcm_iproc_pwmc_dt,
 	},
 	.probe = iproc_pwmc_probe,
-	.remove_new = iproc_pwmc_remove,
 };
 module_platform_driver(iproc_pwmc_driver);
 
-- 
2.40.1

