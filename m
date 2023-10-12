Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F6F7C72B0
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379616AbjJLQbF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379548AbjJLQa6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:30:58 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34751C6
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:30:56 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaM-0004nY-EH; Thu, 12 Oct 2023 18:30:54 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaL-001C6B-Ns; Thu, 12 Oct 2023 18:30:53 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaL-00F5N3-Eh; Thu, 12 Oct 2023 18:30:53 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 015/109] pwm: jz4740: Make use of pwmchip_parent() macro
Date:   Thu, 12 Oct 2023 18:28:43 +0200
Message-ID: <20231012162827.1002444-126-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2438; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=SY78ZErirpqrYsXy5WWPhf+wNX5650KPTU/hx+JGTok=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKB69Ld+XVFPdU0eTOBMqx/x0/yVzGbps1AzE9 Dcm0ZbpRnyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSgevQAKCRCPgPtYfRL+ TnRlB/0Q3+yDZ4cxkz9SvJyLYnWyDIZl8EiUBAf5Tv1Xi7g5XaNnMVGqXlU1+W6ce60O4TX7Zxl SR9w1BAsqSSVM1jf9UTkR4MNoBatpmrW/mruSFymGwjGsbhu4YeBdxptQAaYt0wHJL0nX+28dYS bEpik02I7vwwdhooxdSOHdvXlRsKaY9HuIwV269rtOqRbeKHRqVTFGb4e2raeVtA4mJ2RnVWmR+ gvypj0+Ntdzft0oK3FNo2jiMad8Z5MgTlnWdaj+y2LGxSjvDfohpa4Wt5CXEvetX3dELRO2bEmJ RE6pEwHrkfw2/xzT5+Nf2E9XZkbT8bowfOjXjB2GPULKGrMz
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
 drivers/pwm/pwm-jz4740.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index e9375de60ad6..555c2db3968d 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -35,13 +35,12 @@ static inline struct jz4740_pwm_chip *to_jz4740(struct pwm_chip *chip)
 	return container_of(chip, struct jz4740_pwm_chip, chip);
 }
 
-static bool jz4740_pwm_can_use_chn(struct jz4740_pwm_chip *jz,
-				   unsigned int channel)
+static bool jz4740_pwm_can_use_chn(struct pwm_chip *chip, unsigned int channel)
 {
 	/* Enable all TCU channels for PWM use by default except channels 0/1 */
-	u32 pwm_channels_mask = GENMASK(jz->chip.npwm - 1, 2);
+	u32 pwm_channels_mask = GENMASK(chip->npwm - 1, 2);
 
-	device_property_read_u32(jz->chip.dev->parent,
+	device_property_read_u32(pwmchip_parent(chip)->parent,
 				 "ingenic,pwm-channels-mask",
 				 &pwm_channels_mask);
 
@@ -55,14 +54,14 @@ static int jz4740_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 	char name[16];
 	int err;
 
-	if (!jz4740_pwm_can_use_chn(jz, pwm->hwpwm))
+	if (!jz4740_pwm_can_use_chn(chip, pwm->hwpwm))
 		return -EBUSY;
 
 	snprintf(name, sizeof(name), "timer%u", pwm->hwpwm);
 
-	clk = clk_get(chip->dev, name);
+	clk = clk_get(pwmchip_parent(chip), name);
 	if (IS_ERR(clk))
-		return dev_err_probe(chip->dev, PTR_ERR(clk),
+		return dev_err_probe(pwmchip_parent(chip), PTR_ERR(clk),
 				     "Failed to get clock\n");
 
 	err = clk_prepare_enable(clk);
@@ -149,7 +148,7 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	 */
 	rate = clk_round_rate(clk, tmp);
 	if (rate < 0) {
-		dev_err(chip->dev, "Unable to round rate: %ld", rate);
+		dev_err(pwmchip_parent(chip), "Unable to round rate: %ld", rate);
 		return rate;
 	}
 
@@ -170,7 +169,7 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	err = clk_set_rate(clk, rate);
 	if (err) {
-		dev_err(chip->dev, "Unable to set rate: %d", err);
+		dev_err(pwmchip_parent(chip), "Unable to set rate: %d", err);
 		return err;
 	}
 
-- 
2.42.0

