Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA767C72A3
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379589AbjJLQa6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379515AbjJLQa5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:30:57 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E52CC
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:30:53 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaK-0004g5-3n; Thu, 12 Oct 2023 18:30:52 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaJ-001C5Q-NL; Thu, 12 Oct 2023 18:30:51 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaJ-00F5MH-EK; Thu, 12 Oct 2023 18:30:51 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 003/109] pwm: ab8500: Make use of pwmchip_parent() macro
Date:   Thu, 12 Oct 2023 18:28:31 +0200
Message-ID: <20231012162827.1002444-114-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3155; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=r5Kmv/tDk34cc+a8oE6K7rQUuOVXGh3943H4Og8rEXo=; b=owGbwMvMwMXY3/A7olbonx/jabUkhlQNufWhNY+vn5/FMG3O7gjvrudydxknapaH7on54O6k1 rx0T7dEJ6MxCwMjF4OsmCKLfeOaTKsqucjOtf8uwwxiZQKZwsDFKQATOazOwdASEph7v06gV8om 3+VJmM3t50dERbTyV/OxiE9e+Mz8V0CkhcyE9RwnlYUMN68pyro8XXf2JMYZgrf6akTFuPQ/1Rv pbU7fn7VDwGrt6V2ah1VSFjzLrA2MXfE5Q7cgyqxM0PpVpvxTzm0/Jr+r1ikQrpi8Vn5FQrYRww 7Gab6PXq+xvRDg5vXw29uW6WrnUx5J3V0wRyFx4f4JxmKz2XPc4mfwejsYh1c+fZ+2Yn11lgyHe EN10Zkz02rZln1w13jNYlEkkpr325P5+o5X71UrgvaUSU6+yN64P17gtkrpGX5LGVYGpp7zejsj 0+7Peew6Tb6mW2t99v7m7SncLmfFgj9dvrjIn13p4ZwVAA==
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

struct pwm_chip::dev is about to change. To not have to touch this
driver in the same commit as struct pwm_chip::dev, use the macro
provided for exactly this purpose.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-ab8500.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-ab8500.c b/drivers/pwm/pwm-ab8500.c
index 670d33daea84..719e4ccf1800 100644
--- a/drivers/pwm/pwm-ab8500.c
+++ b/drivers/pwm/pwm-ab8500.c
@@ -92,12 +92,12 @@ static int ab8500_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * when disabled.
 	 */
 	if (!state->enabled || duty_steps == 0) {
-		ret = abx500_mask_and_set_register_interruptible(chip->dev,
+		ret = abx500_mask_and_set_register_interruptible(pwmchip_parent(chip),
 					AB8500_MISC, AB8500_PWM_OUT_CTRL7_REG,
 					1 << ab8500->hwid, 0);
 
 		if (ret < 0)
-			dev_err(chip->dev, "%s: Failed to disable PWM, Error %d\n",
+			dev_err(pwmchip_parent(chip), "%s: Failed to disable PWM, Error %d\n",
 								pwm->label, ret);
 		return ret;
 	}
@@ -115,22 +115,22 @@ static int ab8500_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	reg = AB8500_PWM_OUT_CTRL1_REG + (ab8500->hwid * 2);
 
-	ret = abx500_set_register_interruptible(chip->dev, AB8500_MISC,
+	ret = abx500_set_register_interruptible(pwmchip_parent(chip), AB8500_MISC,
 			reg, lower_val);
 	if (ret < 0)
 		return ret;
 
-	ret = abx500_set_register_interruptible(chip->dev, AB8500_MISC,
+	ret = abx500_set_register_interruptible(pwmchip_parent(chip), AB8500_MISC,
 			(reg + 1), higher_val);
 	if (ret < 0)
 		return ret;
 
 	/* enable */
-	ret = abx500_mask_and_set_register_interruptible(chip->dev,
+	ret = abx500_mask_and_set_register_interruptible(pwmchip_parent(chip),
 				AB8500_MISC, AB8500_PWM_OUT_CTRL7_REG,
 				1 << ab8500->hwid, 1 << ab8500->hwid);
 	if (ret < 0)
-		dev_err(chip->dev, "%s: Failed to enable PWM, Error %d\n",
+		dev_err(pwmchip_parent(chip), "%s: Failed to enable PWM, Error %d\n",
 							pwm->label, ret);
 
 	return ret;
@@ -144,7 +144,7 @@ static int ab8500_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct ab8500_pwm_chip *ab8500 = ab8500_pwm_from_chip(chip);
 	unsigned int div, duty_steps;
 
-	ret = abx500_get_register_interruptible(chip->dev, AB8500_MISC,
+	ret = abx500_get_register_interruptible(pwmchip_parent(chip), AB8500_MISC,
 						AB8500_PWM_OUT_CTRL7_REG,
 						&ctrl7);
 	if (ret)
@@ -157,13 +157,13 @@ static int ab8500_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 		return 0;
 	}
 
-	ret = abx500_get_register_interruptible(chip->dev, AB8500_MISC,
+	ret = abx500_get_register_interruptible(pwmchip_parent(chip), AB8500_MISC,
 						AB8500_PWM_OUT_CTRL1_REG + (ab8500->hwid * 2),
 						&lower_val);
 	if (ret)
 		return ret;
 
-	ret = abx500_get_register_interruptible(chip->dev, AB8500_MISC,
+	ret = abx500_get_register_interruptible(pwmchip_parent(chip), AB8500_MISC,
 						AB8500_PWM_OUT_CTRL2_REG + (ab8500->hwid * 2),
 						&higher_val);
 	if (ret)
-- 
2.42.0

