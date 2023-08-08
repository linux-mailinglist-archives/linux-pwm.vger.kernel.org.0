Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C88774AED
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 22:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235273AbjHHUie (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 16:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjHHUiX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 16:38:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416021DD5C
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:20:14 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN9-0007OW-Ns; Tue, 08 Aug 2023 19:19:55 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN8-00227A-2A; Tue, 08 Aug 2023 19:19:54 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN7-00BTDn-Bv; Tue, 08 Aug 2023 19:19:53 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 057/101] pwm: sunplus: Make use of devm_pwmchip_alloc() function
Date:   Tue,  8 Aug 2023 19:18:47 +0200
Message-Id: <20230808171931.944154-58-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1953; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=xvVmBGOOE5ysKj5Pph/3tWsRyTXe5h22ctkB1syLM3o=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0njxhrpIrKVDTlmGCRlTFOEkOUpx8gM0dzN6S 6yCb4Cm7z6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ48QAKCRCPgPtYfRL+ TkIDB/4nl/ywomXUexGtfAlJ4+Tl/Yp97i0sTUkDl6VDHqzpHPwVF9/Qe089iwgPmgw2Vj2ay+b co8LJpzcv1H1DK7jw4Yc+31aWx21PZESayhf+x5L/JmZ+N4XFaIsSnNXUA/Hbi7cCAzEzt7WE60 BNU0G/2HDZeuG8iSlNSywKMRjim3k2mHRxAUnPTIeI7ggxcGiUrK57wcHbyyogeleVPHSKu5a5T P1LjMTxHf99WOwdqIGP0jM4YOzR6TgJ2g0sZ6ji7VUrVNKjwsop4jbuxC32znmGyliUpr6OP1RX 5b2Zg4K+0zxi+OmEqW9hUjxMFGc6+MnXmhmw94Iwo11ipW3Q
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

This prepares the pwm-sunplus driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-sunplus.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-sunplus.c b/drivers/pwm/pwm-sunplus.c
index 773e2f80526e..46181b9149b0 100644
--- a/drivers/pwm/pwm-sunplus.c
+++ b/drivers/pwm/pwm-sunplus.c
@@ -43,14 +43,13 @@
 #define SP7021_PWM_NUM			4
 
 struct sunplus_pwm {
-	struct pwm_chip chip;
 	void __iomem *base;
 	struct clk *clk;
 };
 
 static inline struct sunplus_pwm *to_sunplus_pwm(struct pwm_chip *chip)
 {
-	return container_of(chip, struct sunplus_pwm, chip);
+	return pwmchip_priv(chip);
 }
 
 static int sunplus_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -175,12 +174,14 @@ static void sunplus_pwm_clk_release(void *data)
 static int sunplus_pwm_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct pwm_chip *chip;
 	struct sunplus_pwm *priv;
 	int ret;
 
-	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(dev, SP7021_PWM_NUM, sizeof(*priv));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	priv = to_sunplus_pwm(chip);
 
 	priv->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->base))
@@ -203,11 +204,9 @@ static int sunplus_pwm_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	priv->chip.dev = dev;
-	priv->chip.ops = &sunplus_pwm_ops;
-	priv->chip.npwm = SP7021_PWM_NUM;
+	chip->ops = &sunplus_pwm_ops;
 
-	ret = devm_pwmchip_add(dev, &priv->chip);
+	ret = devm_pwmchip_add(dev, chip);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Cannot register sunplus PWM\n");
 
-- 
2.40.1

