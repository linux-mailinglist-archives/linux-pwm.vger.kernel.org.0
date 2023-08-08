Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63BD774820
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 21:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbjHHT0k (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 15:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235509AbjHHT0N (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 15:26:13 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351881DD7D
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:20:20 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQND-0007Uz-KH; Tue, 08 Aug 2023 19:19:59 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNC-00228x-HJ; Tue, 08 Aug 2023 19:19:58 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNB-00BTFB-Rk; Tue, 08 Aug 2023 19:19:57 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 078/101] pwm: jz4740: Store parent device in driver data
Date:   Tue,  8 Aug 2023 19:19:08 +0200
Message-Id: <20230808171931.944154-79-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2953; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=MxA2P6LwRfz0mRrNucFS+2hI/XJ61/8SechfYLYnasg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0nkI89DUAqv5BC4heC3KHzctTm1qzg5lvS1sr 1n/HLm2hmyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ5CAAKCRCPgPtYfRL+ Ti3SCACy6tZxqNPz+XNx1gXK2uwKt0XRHOaZMjlvF7W8c4L2DKcoa9IT7ji8UrV8tFk8XWztUN0 /HONINkWvTUmjFOmnRIsoKMD7yrxCEmKwi2Xdl7EDKB9QCpJ1eoSmQ11WlheVLB7BxR1BTCxRwG qGFc1EP5hwImqBUrnvR5V2kCvnZozjl2qe9FLxLK+c5ZJkuKtNDBdgta2DNDZllmGI7kSNFrAXm SbQ9mF42lMjByI1rp9D8zKdVQwyoVR8bgAjr5r40nzZC0Mx/37RVKFBbXd4V0RgMPmP3I+AYH9l ZmMmiX5ychapobhoHstyvUjH2c7VhorkLfvHDhBiAK2zlumw
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

struct pwm_chip::dev is about to change. To not have to touch this
driver in the same commit as struct pwm_chip::dev, store a pointer to
the parent device in driver data.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-jz4740.c | 14 +++++++++-----
 include/linux/pwm.h      |  2 +-
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index f06010590504..ae25b70c4955 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -25,6 +25,7 @@ struct soc_info {
 };
 
 struct jz4740_pwm_chip {
+	struct device *parent;
 	struct regmap *map;
 	struct clk *clk[];
 };
@@ -37,10 +38,11 @@ static inline struct jz4740_pwm_chip *to_jz4740(struct pwm_chip *chip)
 static bool jz4740_pwm_can_use_chn(struct pwm_chip *chip,
 				   unsigned int channel)
 {
+	struct jz4740_pwm_chip *jz = to_jz4740(chip);
 	/* Enable all TCU channels for PWM use by default except channels 0/1 */
 	u32 pwm_channels_mask = GENMASK(chip->npwm - 1, 2);
 
-	device_property_read_u32(chip->dev->parent,
+	device_property_read_u32(jz->parent->parent,
 				 "ingenic,pwm-channels-mask",
 				 &pwm_channels_mask);
 
@@ -59,9 +61,9 @@ static int jz4740_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	snprintf(name, sizeof(name), "timer%u", pwm->hwpwm);
 
-	clk = clk_get(chip->dev, name);
+	clk = clk_get(jz->parent, name);
 	if (IS_ERR(clk))
-		return dev_err_probe(chip->dev, PTR_ERR(clk),
+		return dev_err_probe(jz->parent, PTR_ERR(clk),
 				     "Failed to get clock\n");
 
 	err = clk_prepare_enable(clk);
@@ -148,7 +150,7 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	 */
 	rate = clk_round_rate(clk, tmp);
 	if (rate < 0) {
-		dev_err(chip->dev, "Unable to round rate: %ld", rate);
+		dev_err(jz->parent, "Unable to round rate: %ld", rate);
 		return rate;
 	}
 
@@ -169,7 +171,7 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	err = clk_set_rate(clk, rate);
 	if (err) {
-		dev_err(chip->dev, "Unable to set rate: %d", err);
+		dev_err(jz->parent, "Unable to set rate: %d", err);
 		return err;
 	}
 
@@ -235,6 +237,8 @@ static int jz4740_pwm_probe(struct platform_device *pdev)
 		return PTR_ERR(chip);
 	jz = to_jz4740(chip);
 
+	jz->parent = &pdev->dev;
+
 	jz->map = device_node_to_regmap(dev->parent->of_node);
 	if (IS_ERR(jz->map)) {
 		dev_err(dev, "regmap not found: %ld\n", PTR_ERR(jz->map));
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index fbcba204de44..74f095afffa4 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -290,7 +290,7 @@ struct pwm_ops {
  * @pwms: array of PWM devices allocated by the framework
  */
 struct pwm_chip {
-	struct device *dev;
+	struct device dev;
 	const struct pwm_ops *ops;
 	struct module *owner;
 	int id;
-- 
2.40.1

