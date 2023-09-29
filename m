Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458767B37BA
	for <lists+linux-pwm@lfdr.de>; Fri, 29 Sep 2023 18:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232878AbjI2QTb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 29 Sep 2023 12:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233362AbjI2QT3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 29 Sep 2023 12:19:29 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA461B0
        for <linux-pwm@vger.kernel.org>; Fri, 29 Sep 2023 09:19:27 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmGD6-0007q4-RF; Fri, 29 Sep 2023 18:19:24 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmGD6-009r61-Dt; Fri, 29 Sep 2023 18:19:24 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmGD6-00616T-4g; Fri, 29 Sep 2023 18:19:24 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>, linux-pwm@vger.kernel.org,
        chrome-platform@lists.linux.dev, kernel@pengutronix.de
Subject: [PATCH 11/11] pwm: cros-ec: Simplify using devm_pwmchip_add() and dev_err_probe()
Date:   Fri, 29 Sep 2023 18:19:18 +0200
Message-Id: <20230929161918.2410424-12-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230929161918.2410424-1-u.kleine-koenig@pengutronix.de>
References: <20230929161918.2410424-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2276; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=lvV87uXW3xEjQrKArZx5bIlDe5j6UzwJosC7twW0qwo=; b=owGbwMvMwMXY3/A7olbonx/jabUkhlSxnwyJ+beYkxa8fvtwktM3ZZNy4+oPh7pyHd7lVjHvE 7zsuHJFJ6MxCwMjF4OsmCKLfeOaTKsqucjOtf8uwwxiZQKZwsDFKQATKSll/6fi7hx56/fkHKWT /L3L9ht7L++weC2fu9PHS27i/92L2MQKLpcv469clxH8aHa+wKvgjMKi2ys/c9vY+6137KxrutO nu7+W+YNOSXPkjtln7qgGJ+Qb3frFE9adtcDLov30l3g26cKL2VrsEkKuFonbOTWf5nB8sFnL1q Sa6J66QiVkUu3Ze7s9Nz989fCmhvE/gya1qtOqcicm6z+/qPLG0G3RLCaH1qSfGo2B+4zP9Ii1v 5FepTnpypEwXkZp3vXi3TNPxx10msxc62+eapZ/VWbtiZsVEfLcR4MeTTqed939sF11hWGim7Rc XebDr2Kuhh4Mx2xc3px4kdzWtnj+0tVrwr70bJ64zigEAA==
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

Using devm_pwmchip_add() allows to drop pwmchip_remove() from the remove
function which makes this function empty. Then there is no user of
drvdata left and platform_set_drvdata() can be dropped, too.

Further simplify and improve error returning using dev_err_probe().

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-cros-ec.c | 33 ++++++++-------------------------
 1 file changed, 8 insertions(+), 25 deletions(-)

diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
index baaac0c33aa0..f048150fffc7 100644
--- a/drivers/pwm/pwm-cros-ec.c
+++ b/drivers/pwm/pwm-cros-ec.c
@@ -286,10 +286,8 @@ static int cros_ec_pwm_probe(struct platform_device *pdev)
 	struct pwm_chip *chip;
 	int ret;
 
-	if (!ec) {
-		dev_err(dev, "no parent EC device\n");
-		return -EINVAL;
-	}
+	if (!ec)
+		return dev_err_probe(dev, -EINVAL, "no parent EC device\n");
 
 	ec_pwm = devm_kzalloc(dev, sizeof(*ec_pwm), GFP_KERNEL);
 	if (!ec_pwm)
@@ -310,32 +308,18 @@ static int cros_ec_pwm_probe(struct platform_device *pdev)
 		chip->npwm = CROS_EC_PWM_DT_COUNT;
 	} else {
 		ret = cros_ec_num_pwms(ec_pwm);
-		if (ret < 0) {
-			dev_err(dev, "Couldn't find PWMs: %d\n", ret);
-			return ret;
-		}
+		if (ret < 0)
+			return dev_err_probe(dev, ret, "Couldn't find PWMs\n");
 		chip->npwm = ret;
 	}
 
 	dev_dbg(dev, "Probed %u PWMs\n", chip->npwm);
 
-	ret = pwmchip_add(chip);
-	if (ret < 0) {
-		dev_err(dev, "cannot register PWM: %d\n", ret);
-		return ret;
-	}
+	ret = devm_pwmchip_add(dev, chip);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "cannot register PWM\n");
 
-	platform_set_drvdata(pdev, ec_pwm);
-
-	return ret;
-}
-
-static void cros_ec_pwm_remove(struct platform_device *dev)
-{
-	struct cros_ec_pwm_device *ec_pwm = platform_get_drvdata(dev);
-	struct pwm_chip *chip = &ec_pwm->chip;
-
-	pwmchip_remove(chip);
+	return 0;
 }
 
 #ifdef CONFIG_OF
@@ -349,7 +333,6 @@ MODULE_DEVICE_TABLE(of, cros_ec_pwm_of_match);
 
 static struct platform_driver cros_ec_pwm_driver = {
 	.probe = cros_ec_pwm_probe,
-	.remove_new = cros_ec_pwm_remove,
 	.driver = {
 		.name = "cros-ec-pwm",
 		.of_match_table = of_match_ptr(cros_ec_pwm_of_match),
-- 
2.40.1

