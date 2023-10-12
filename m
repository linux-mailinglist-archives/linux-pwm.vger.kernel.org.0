Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6821C7C72FF
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379637AbjJLQbs (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347335AbjJLQbS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:31:18 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F82DA
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:31:15 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaf-0005rr-7A; Thu, 12 Oct 2023 18:31:13 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyad-001CBR-BJ; Thu, 12 Oct 2023 18:31:11 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyad-00F5Sk-2C; Thu, 12 Oct 2023 18:31:11 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 098/109] pwm: visconti: Make use of devm_pwmchip_alloc() function
Date:   Thu, 12 Oct 2023 18:30:06 +0200
Message-ID: <20231012162827.1002444-209-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1930; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=YbptV1JFV8xUG4G16TBZlHSfQeEQVB34tNfnk2eyW6c=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKB8gxEKrTYNV12HogHpc6RU6tb5vWV9M5hR/t vScqIZR516JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSgfIAAKCRCPgPtYfRL+ TnZEB/wPC/D96CfVIzuGeE441TWpFK/4RdRAJyDu8k2bCGErnDkbzOOUIcD86LLrRIzKSxy4MMi pwkv6TU5TfMLMwUwsA193qAzQ5KrV6MnU+fyE38CdKgI4HtJcinLVtuxjXI513RC2o1h2UKD/Yx 2d9S3OtEbqcr9cqydngXjK5GPgPd7s3MNyui+kh/9h1c55oBohFJsZWZj5BZXJswWId19IBMnSy q2viav9QRbzKIjI91+aJjKz4Ridrs23MMBDDoIW2+UtfNdjhT2faHRl62qq1Y5/vRHSmhhPDxQm Hhy+E5r0EWXQ9Hw0yd7FvOyRyRHFK48VhMW2Nw8ZYgmJFNho
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

This prepares the pwm-visconti driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-visconti.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-visconti.c b/drivers/pwm/pwm-visconti.c
index 8d736d558122..64ca4059a5a0 100644
--- a/drivers/pwm/pwm-visconti.c
+++ b/drivers/pwm/pwm-visconti.c
@@ -34,13 +34,12 @@
 #define PIPGM_PWMC_POLARITY_MASK	GENMASK(5, 5)
 
 struct visconti_pwm_chip {
-	struct pwm_chip chip;
 	void __iomem *base;
 };
 
 static inline struct visconti_pwm_chip *visconti_pwm_from_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct visconti_pwm_chip, chip);
+	return pwmchip_priv(chip);
 }
 
 static int visconti_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -134,22 +133,22 @@ static const struct pwm_ops visconti_pwm_ops = {
 static int visconti_pwm_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct pwm_chip *chip;
 	struct visconti_pwm_chip *priv;
 	int ret;
 
-	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(dev, 4, sizeof(*priv));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	priv = visconti_pwm_from_chip(chip);
 
 	priv->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
-	priv->chip.dev = dev;
-	priv->chip.ops = &visconti_pwm_ops;
-	priv->chip.npwm = 4;
+	chip->ops = &visconti_pwm_ops;
 
-	ret = devm_pwmchip_add(&pdev->dev, &priv->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0)
 		return dev_err_probe(&pdev->dev, ret, "Cannot register visconti PWM\n");
 
-- 
2.42.0

