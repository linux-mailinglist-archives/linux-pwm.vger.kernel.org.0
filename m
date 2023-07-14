Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38144754465
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Jul 2023 23:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjGNVpe (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 14 Jul 2023 17:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjGNVpd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 14 Jul 2023 17:45:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D2335A6
        for <linux-pwm@vger.kernel.org>; Fri, 14 Jul 2023 14:45:31 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qKQbR-0004IW-Il; Fri, 14 Jul 2023 23:45:29 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qKQbP-00ER0X-JW; Fri, 14 Jul 2023 23:45:27 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qKQbO-004ugD-UR; Fri, 14 Jul 2023 23:45:26 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     linux-pwm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, kernel@pengutronix.de
Subject: [PATCH 1/2] pwm: stmpe: Handle errors when disabling the signal
Date:   Fri, 14 Jul 2023 23:45:18 +0200
Message-Id: <20230714214519.2503468-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2206; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=/NLXX93dNegW8/RPV4eZsWEDxqUOClEE95P3xGBbnoQ=; b=owGbwMvMwMXY3/A7olbonx/jabUkhpSNB9/qR6tP29mU8sfOXsF5tjCXtvrcM1xxU792d99c3 D6Nd6p0J6MxCwMjF4OsmCKLfeOaTKsqucjOtf8uwwxiZQKZwsDFKQATyT7M/lcuy1E8snLV60VP ky5NdlpRXXbm2LZ7+SVaxzxS9CaFfJss2pJ6feUJORs2tj/RHm4pf4S/K3S2TxI7LVi45s3nuXy dxZN8c/2i55VL64Xo9TFvlX7d6rg3rGnm3FkatR7tXvZx0hfDbf7r74wUepGY9oJ/oceLpzXJT3 jiJiq9P+tn+Z2fo+g1o7KZbbad5dp7Qe+bNv016Z2tt5Bjj7yYcp7Pput8UqXrpez1GsWd8+qV3 S58WH9p1xv9Q080HgZOiluc8GSuhOd6NfnN2epfF325bFaw5u3V5plZKwu1ttVU6t/584tLUHS6 o8uqpdPqTONCVX+dnOVwtuuj5dcU+Q1r7EzKa7Skoix8AQ==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Before the pwm framework implementedatomic updates (with the .apply()
callback) the .disable() callback returned void. This is still visible
in the stmpe driver which drops errors in the disable path.

Improve the driver to forward failures in stmpe_24xx_pwm_disable() to
the caller of pwm_apply_state().

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-stmpe.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-stmpe.c b/drivers/pwm/pwm-stmpe.c
index 5d4a4762ce0c..e205405c4828 100644
--- a/drivers/pwm/pwm-stmpe.c
+++ b/drivers/pwm/pwm-stmpe.c
@@ -61,8 +61,8 @@ static int stmpe_24xx_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	return 0;
 }
 
-static void stmpe_24xx_pwm_disable(struct pwm_chip *chip,
-				   struct pwm_device *pwm)
+static int stmpe_24xx_pwm_disable(struct pwm_chip *chip,
+				  struct pwm_device *pwm)
 {
 	struct stmpe_pwm *stmpe_pwm = to_stmpe_pwm(chip);
 	u8 value;
@@ -72,17 +72,16 @@ static void stmpe_24xx_pwm_disable(struct pwm_chip *chip,
 	if (ret < 0) {
 		dev_err(chip->dev, "error reading PWM#%u control\n",
 			pwm->hwpwm);
-		return;
+		return ret;
 	}
 
 	value = ret & ~BIT(pwm->hwpwm);
 
 	ret = stmpe_reg_write(stmpe_pwm->stmpe, STMPE24XX_PWMCS, value);
-	if (ret) {
+	if (ret)
 		dev_err(chip->dev, "error writing PWM#%u control\n",
 			pwm->hwpwm);
-		return;
-	}
+	return ret;
 }
 
 /* STMPE 24xx PWM instructions */
@@ -111,7 +110,9 @@ static int stmpe_24xx_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	/* Make sure we are disabled */
 	if (pwm_is_enabled(pwm)) {
-		stmpe_24xx_pwm_disable(chip, pwm);
+		ret = stmpe_24xx_pwm_disable(chip, pwm);
+		if (ret)
+			return ret;
 	} else {
 		/* Connect the PWM to the pin */
 		pin = pwm->hwpwm;
@@ -269,7 +270,7 @@ static int stmpe_24xx_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	if (!state->enabled) {
 		if (pwm->state.enabled)
-			stmpe_24xx_pwm_disable(chip, pwm);
+			return stmpe_24xx_pwm_disable(chip, pwm);
 
 		return 0;
 	}

base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
-- 
2.39.2

