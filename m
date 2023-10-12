Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1047C72E7
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379623AbjJLQbf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379602AbjJLQbO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:31:14 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49F9D7
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:31:10 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaZ-0005dG-UX; Thu, 12 Oct 2023 18:31:07 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaX-001C9g-El; Thu, 12 Oct 2023 18:31:05 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaX-00F5Qv-5n; Thu, 12 Oct 2023 18:31:05 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 071/109] pwm: microchip-core: Make use of devm_pwmchip_alloc() function
Date:   Thu, 12 Oct 2023 18:29:39 +0200
Message-ID: <20231012162827.1002444-182-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2613; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=m4GyQiFXFJaqNI6WOpp3CmU9hg+F8DEVlbs8fT7JIU0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKB8ASTYln9e9/w1RE6dBuatGQK2RNYSXM6EYF CszlHEPUGeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSgfAAAKCRCPgPtYfRL+ Toy+CACLwNW42KOsDds/EOwZe3u9Jtfk90yAWlmAHLMCJubo7aUccudFrfgJQlA4hbuXGADatoB TLqHpP08aV8i9JEwkRpqx+o4DOfZXXXFsdJwrm9Gfjn6LjGu4smGS3qR+TK6l9CZDKuQQ2wWbdj AxOlWBm+KW44jkqk6A/GMt+uWW9vijEkBhxN1esK0VazTXX/hhrecTXQW+tAqLKpJYuxQjtvquA 3hdlBctqSm9X/t1PFEHewIohD8TIuMApFMwU9FrYiRbS0Ra6r7JT58JonA/CAMz44WxyAaU2f9A L5QvLJcS6gG5/hZsz41jYivoZxcInbjnAO5ysrYnwwcghx0z
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

This prepares the pwm-microchip-core driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-microchip-core.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-microchip-core.c b/drivers/pwm/pwm-microchip-core.c
index c0c53968f3e9..6e0c2cbfc120 100644
--- a/drivers/pwm/pwm-microchip-core.c
+++ b/drivers/pwm/pwm-microchip-core.c
@@ -54,7 +54,6 @@
 #define MCHPCOREPWM_TIMEOUT_MS	100u
 
 struct mchp_core_pwm_chip {
-	struct pwm_chip chip;
 	struct clk *clk;
 	void __iomem *base;
 	struct mutex lock; /* protects the shared period */
@@ -65,7 +64,7 @@ struct mchp_core_pwm_chip {
 
 static inline struct mchp_core_pwm_chip *to_mchp_core_pwm(struct pwm_chip *chip)
 {
-	return container_of(chip, struct mchp_core_pwm_chip, chip);
+	return pwmchip_priv(chip);
 }
 
 static void mchp_core_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -447,13 +446,15 @@ MODULE_DEVICE_TABLE(of, mchp_core_of_match);
 
 static int mchp_core_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct mchp_core_pwm_chip *mchp_core_pwm;
 	struct resource *regs;
 	int ret;
 
-	mchp_core_pwm = devm_kzalloc(&pdev->dev, sizeof(*mchp_core_pwm), GFP_KERNEL);
-	if (!mchp_core_pwm)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 16, sizeof(*mchp_core_pwm));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	mchp_core_pwm = to_mchp_core_pwm(chip);
 
 	mchp_core_pwm->base = devm_platform_get_and_ioremap_resource(pdev, 0, &regs);
 	if (IS_ERR(mchp_core_pwm->base))
@@ -470,9 +471,7 @@ static int mchp_core_pwm_probe(struct platform_device *pdev)
 
 	mutex_init(&mchp_core_pwm->lock);
 
-	mchp_core_pwm->chip.dev = &pdev->dev;
-	mchp_core_pwm->chip.ops = &mchp_core_pwm_ops;
-	mchp_core_pwm->chip.npwm = 16;
+	chip->ops = &mchp_core_pwm_ops;
 
 	mchp_core_pwm->channel_enabled = readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_EN(0));
 	mchp_core_pwm->channel_enabled |=
@@ -485,7 +484,7 @@ static int mchp_core_pwm_probe(struct platform_device *pdev)
 	writel_relaxed(1U, mchp_core_pwm->base + MCHPCOREPWM_SYNC_UPD);
 	mchp_core_pwm->update_timestamp = ktime_get();
 
-	ret = devm_pwmchip_add(&pdev->dev, &mchp_core_pwm->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret, "Failed to add pwmchip\n");
 
-- 
2.42.0

