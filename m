Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB572774696
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 20:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233601AbjHHS6y (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 14:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233303AbjHHS6i (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 14:58:38 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F227F634B6
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:20:05 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN6-0007Fi-2T; Tue, 08 Aug 2023 19:19:52 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN4-00225h-8L; Tue, 08 Aug 2023 19:19:50 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN3-00BTCT-2p; Tue, 08 Aug 2023 19:19:49 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 037/101] pwm: mxs: Make use of devm_pwmchip_alloc() function
Date:   Tue,  8 Aug 2023 19:18:27 +0200
Message-Id: <20230808171931.944154-38-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2580; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=9tbxQ0d+54miY1LJ0I1Ghwup/fMRapmy2txUKQgi0Zo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0njaeOBqml2KcSB9ERFwATFYf+2tFbDsMZYXh Bn0+xeqQACJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ42gAKCRCPgPtYfRL+ Th1fB/93TsLm7RYpQLlwahW3FC6xYFxJYBL7Ydbjpqp5wNC/Ja7fBibgGj9Ctegqf3Ubzo67in7 17F28n7DwK4XPGnpp8M8l1/wldSQ+5sQppCH97Xo5K26NvMBFYGje5r1ssoXM4yPT0lhUOJF2am rRmUssB3VaSR6NqxptHu7SdhHPK4Cg6p3TQyYr63tynOIdoc7j+doa0cscAekApgFOr+92hKNNu DYcXFFEPnOUzPzmF006L7nZu6PvuDOPUTHmneRR3YMtL+KE0rikf4ipFzZbloCFgzpaG7fN3XHa 7EzZcZGGs+Kzj9q3FQHas3xL+fB+8a93q27JXgEOWhVo87Ra
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

This prepares the pwm-mxs driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-mxs.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/pwm/pwm-mxs.c b/drivers/pwm/pwm-mxs.c
index 1b5e787d78f1..7c05b22bc7c9 100644
--- a/drivers/pwm/pwm-mxs.c
+++ b/drivers/pwm/pwm-mxs.c
@@ -37,12 +37,14 @@ static const u8 cdiv_shift[PERIOD_CDIV_MAX] = {
 };
 
 struct mxs_pwm_chip {
-	struct pwm_chip chip;
 	struct clk *clk;
 	void __iomem *base;
 };
 
-#define to_mxs_pwm_chip(_chip) container_of(_chip, struct mxs_pwm_chip, chip)
+static inline struct mxs_pwm_chip *to_mxs_pwm_chip(struct pwm_chip *chip)
+{
+	return pwmchip_priv(chip);
+}
 
 static int mxs_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			 const struct pwm_state *state)
@@ -120,12 +122,21 @@ static const struct pwm_ops mxs_pwm_ops = {
 static int mxs_pwm_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
+	struct pwm_chip *chip;
 	struct mxs_pwm_chip *mxs;
+	u32 npwm;
 	int ret;
 
-	mxs = devm_kzalloc(&pdev->dev, sizeof(*mxs), GFP_KERNEL);
-	if (!mxs)
-		return -ENOMEM;
+	ret = of_property_read_u32(np, "fsl,pwm-number", &npwm);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to get pwm number: %d\n", ret);
+		return ret;
+	}
+
+	chip = devm_pwmchip_alloc(&pdev->dev, npwm, sizeof(*mxs));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	mxs = to_mxs_pwm_chip(chip);
 
 	mxs->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(mxs->base))
@@ -135,21 +146,14 @@ static int mxs_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(mxs->clk))
 		return PTR_ERR(mxs->clk);
 
-	mxs->chip.dev = &pdev->dev;
-	mxs->chip.ops = &mxs_pwm_ops;
-
-	ret = of_property_read_u32(np, "fsl,pwm-number", &mxs->chip.npwm);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to get pwm number: %d\n", ret);
-		return ret;
-	}
+	chip->ops = &mxs_pwm_ops;
 
 	/* FIXME: Only do this if the PWM isn't already running */
 	ret = stmp_reset_block(mxs->base);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret, "failed to reset PWM\n");
 
-	ret = devm_pwmchip_add(&pdev->dev, &mxs->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to add pwm chip %d\n", ret);
 		return ret;
-- 
2.40.1

