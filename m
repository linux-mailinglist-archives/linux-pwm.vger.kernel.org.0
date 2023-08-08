Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE52774694
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 20:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbjHHS6x (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 14:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233241AbjHHS6i (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 14:58:38 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E85E175DD4
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:19:51 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQMy-0006oS-O1; Tue, 08 Aug 2023 19:19:44 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQMy-00223M-2J; Tue, 08 Aug 2023 19:19:44 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQMw-00BTAb-Rn; Tue, 08 Aug 2023 19:19:42 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 007/101] pwm: bcm2835: Make use of devm_pwmchip_alloc() function
Date:   Tue,  8 Aug 2023 19:17:57 +0200
Message-Id: <20230808171931.944154-8-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1984; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=P9/SgVaICZVRP7mWU403jvLDVOPER/n/iYurFIQh4tk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0ni4CScZpH/5LK31aj4LkLt3wRm1Yx1a63N2V 9lpJwHt/5yJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ4uAAKCRCPgPtYfRL+ TggcB/92Y/yhmw6qToj/xPAs6o3fkGZSDG18Ep69oNIWR6daBp3Dc7T2g7faSqGyBCbhUwomlrk 5nFHGDe7IF9EQKO2puOPlWZ+L1qYVongQZJFzpKalSzNPcsAvwA47fqAPs9gZfIEPIBb6fynvTU hQkLt1Nh9aAzsW3vt15Ac6u6xDdmt85O2UHoU8iN+XtFPZqXIvgd0Fn/tTQPcdB13N+ajor/HMP nkglRRU+c/uDmnFofM1kU0mDpgfOE9Dwn/5mqfcSt+ABw1MuGQ1TzdJWZtsQzemD1T+x/VIWse3 OhZkzBB4hGPLUkAlWOtKt2snu1GtSoObjB/C+RTeCll8wur8
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

This prepares the pwm-bcm2835 driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-bcm2835.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
index 8c69ddfea2d0..15ba04090b31 100644
--- a/drivers/pwm/pwm-bcm2835.c
+++ b/drivers/pwm/pwm-bcm2835.c
@@ -24,7 +24,6 @@
 #define PERIOD_MIN		0x2
 
 struct bcm2835_pwm {
-	struct pwm_chip chip;
 	struct device *dev;
 	void __iomem *base;
 	struct clk *clk;
@@ -32,7 +31,7 @@ struct bcm2835_pwm {
 
 static inline struct bcm2835_pwm *to_bcm2835_pwm(struct pwm_chip *chip)
 {
-	return container_of(chip, struct bcm2835_pwm, chip);
+	return pwmchip_priv(chip);
 }
 
 static int bcm2835_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
@@ -133,12 +132,14 @@ static const struct pwm_ops bcm2835_pwm_ops = {
 
 static int bcm2835_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct bcm2835_pwm *pc;
 	int ret;
 
-	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
-	if (!pc)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 2, sizeof(*pc));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	pc = to_bcm2835_pwm(chip);
 
 	pc->dev = &pdev->dev;
 
@@ -151,11 +152,9 @@ static int bcm2835_pwm_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(pc->clk),
 				     "clock not found\n");
 
-	pc->chip.dev = &pdev->dev;
-	pc->chip.ops = &bcm2835_pwm_ops;
-	pc->chip.npwm = 2;
+	chip->ops = &bcm2835_pwm_ops;
 
-	ret = devm_pwmchip_add(&pdev->dev, &pc->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0)
 		return dev_err_probe(&pdev->dev, ret,
 				     "failed to add pwmchip\n");
-- 
2.40.1

