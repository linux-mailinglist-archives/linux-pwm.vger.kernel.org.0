Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A5A7C72DA
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379620AbjJLQb3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379515AbjJLQbK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:31:10 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB1DD7
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:31:07 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaW-0005Lo-58; Thu, 12 Oct 2023 18:31:04 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaT-001C8e-Ou; Thu, 12 Oct 2023 18:31:01 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaT-00F5Pk-Fv; Thu, 12 Oct 2023 18:31:01 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 054/109] pwm: ep93xx: Make use of devm_pwmchip_alloc() function
Date:   Thu, 12 Oct 2023 18:29:22 +0200
Message-ID: <20231012162827.1002444-165-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1948; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=bPuoVwCfQPZF1EwR3vZXcL/NqvWx+0mBgRtjFgXYIo4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKB7szXrvYHfNHLpMMM//n/HGPYL9MpQtu22lq fnWj0IpI9OJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSge7AAKCRCPgPtYfRL+ TrAACACpCYGznhp3I7BDtN9gzNCHFSXOAfslMBqAdmmH1t0UIKpexHD6Y44U/RRdHzyoHblkfFS 65uigdkUESf4d5VyExuxw5BB19iziaTazZjaca2L1MV00lDWmM95E6+lamhxU8m/+SVb9mDOumF 48I+tClq75QnUouZw7K0cZsAmaNeK+p0Q/zZhkgymcvrj5XYDkm9OG5Dp0JcvflkE0z4sq+Bzse 8dn9IZrdxbnSFI7+Q1diLZxqo0VZ2PzJJ1HN1HKnM38NzhgqUaWHtaYWkD7T+aiKD1ri5VEdYjt /fshpu2CVWBUz3osOl8h1QJC88Q4r2r3074b6ZtJchgI2EPG
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

This prepares the pwm-ep93xx driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-ep93xx.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-ep93xx.c b/drivers/pwm/pwm-ep93xx.c
index e4c3546a61c8..5df541645d54 100644
--- a/drivers/pwm/pwm-ep93xx.c
+++ b/drivers/pwm/pwm-ep93xx.c
@@ -36,12 +36,11 @@
 struct ep93xx_pwm {
 	void __iomem *base;
 	struct clk *clk;
-	struct pwm_chip chip;
 };
 
 static inline struct ep93xx_pwm *to_ep93xx_pwm(struct pwm_chip *chip)
 {
-	return container_of(chip, struct ep93xx_pwm, chip);
+	return pwmchip_priv(chip);
 }
 
 static int ep93xx_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
@@ -163,12 +162,14 @@ static const struct pwm_ops ep93xx_pwm_ops = {
 
 static int ep93xx_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct ep93xx_pwm *ep93xx_pwm;
 	int ret;
 
-	ep93xx_pwm = devm_kzalloc(&pdev->dev, sizeof(*ep93xx_pwm), GFP_KERNEL);
-	if (!ep93xx_pwm)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*ep93xx_pwm));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	ep93xx_pwm = to_ep93xx_pwm(chip);
 
 	ep93xx_pwm->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(ep93xx_pwm->base))
@@ -178,11 +179,9 @@ static int ep93xx_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(ep93xx_pwm->clk))
 		return PTR_ERR(ep93xx_pwm->clk);
 
-	ep93xx_pwm->chip.dev = &pdev->dev;
-	ep93xx_pwm->chip.ops = &ep93xx_pwm_ops;
-	ep93xx_pwm->chip.npwm = 1;
+	chip->ops = &ep93xx_pwm_ops;
 
-	ret = devm_pwmchip_add(&pdev->dev, &ep93xx_pwm->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0)
 		return ret;
 
-- 
2.42.0

