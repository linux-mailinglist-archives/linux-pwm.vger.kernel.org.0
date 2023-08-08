Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853A477469E
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 20:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjHHS65 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 14:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbjHHS6k (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 14:58:40 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5463D75862
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:20:08 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN6-0007IA-MB; Tue, 08 Aug 2023 19:19:52 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN4-00225w-UI; Tue, 08 Aug 2023 19:19:50 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN4-00BTCo-6V; Tue, 08 Aug 2023 19:19:50 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 042/101] pwm: raspberrypi-poe: Make use of devm_pwmchip_alloc() function
Date:   Tue,  8 Aug 2023 19:18:32 +0200
Message-Id: <20230808171931.944154-43-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2401; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=S8YkCajYs5Gp32c278BN0emrLRBA5PLVMTrrcscfNTQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0njgXL9qEAsUIBJv4orbk2Jaosa0zzddbTQsL wf1kmgOJjqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ44AAKCRCPgPtYfRL+ ToCcCACFjNnog7xh1XxTsoX8TjBEKu5dFBFR+nzq0hpRdmPMpcsHis6HrKXmFCZlQsynZxjH+LJ TmeJV5EUEHCdxdxggBjPv+2SrAIjLfjXkWFX4X3g0M7cvkfIfK7L1QqhVDmjZ/mH53Y4QJFPn01 aLSn3AU+9sAvxLqtp1uQ9k4bDsaF5/1lhd0ZpjphR6IwzMUasMrfGaNpY1IAu4ln6Iq3+WC/Lhn O98Kj7ZUY2jZgcGlLPi9vhxleUo3lSrCdsFtUPiUKfHvlAHyqLDbD22kDV1AxtCqExp+mRbGl6j vyXvqN3N0PkoSMnzZsL969gTOMQPQWJn/+kib6n3w0xV1EXR
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

This prepares the pwm-raspberrypi-poe driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-raspberrypi-poe.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-raspberrypi-poe.c b/drivers/pwm/pwm-raspberrypi-poe.c
index 1ad814fdec6b..4b2711d59e7c 100644
--- a/drivers/pwm/pwm-raspberrypi-poe.c
+++ b/drivers/pwm/pwm-raspberrypi-poe.c
@@ -27,7 +27,6 @@
 
 struct raspberrypi_pwm {
 	struct rpi_firmware *firmware;
-	struct pwm_chip chip;
 	unsigned int duty_cycle;
 };
 
@@ -40,7 +39,7 @@ struct raspberrypi_pwm_prop {
 static inline
 struct raspberrypi_pwm *raspberrypi_pwm_from_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct raspberrypi_pwm, chip);
+	return pwmchip_priv(chip);
 }
 
 static int raspberrypi_pwm_set_property(struct rpi_firmware *firmware,
@@ -142,6 +141,7 @@ static int raspberrypi_pwm_probe(struct platform_device *pdev)
 	struct device_node *firmware_node;
 	struct device *dev = &pdev->dev;
 	struct rpi_firmware *firmware;
+	struct pwm_chip *chip;
 	struct raspberrypi_pwm *rpipwm;
 	int ret;
 
@@ -157,14 +157,14 @@ static int raspberrypi_pwm_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, -EPROBE_DEFER,
 				     "Failed to get firmware handle\n");
 
-	rpipwm = devm_kzalloc(&pdev->dev, sizeof(*rpipwm), GFP_KERNEL);
-	if (!rpipwm)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, RASPBERRYPI_FIRMWARE_PWM_NUM,
+				  sizeof(*rpipwm));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	rpipwm = raspberrypi_pwm_from_chip(chip);
 
 	rpipwm->firmware = firmware;
-	rpipwm->chip.dev = dev;
-	rpipwm->chip.ops = &raspberrypi_pwm_ops;
-	rpipwm->chip.npwm = RASPBERRYPI_FIRMWARE_PWM_NUM;
+	chip->ops = &raspberrypi_pwm_ops;
 
 	ret = raspberrypi_pwm_get_property(rpipwm->firmware, RPI_PWM_CUR_DUTY_REG,
 					   &rpipwm->duty_cycle);
@@ -173,7 +173,7 @@ static int raspberrypi_pwm_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	return devm_pwmchip_add(dev, &rpipwm->chip);
+	return devm_pwmchip_add(dev, chip);
 }
 
 static const struct of_device_id raspberrypi_pwm_of_match[] = {
-- 
2.40.1

