Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 266B2747F08
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Jul 2023 10:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjGEIHN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 5 Jul 2023 04:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbjGEIHK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 5 Jul 2023 04:07:10 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7411717
        for <linux-pwm@vger.kernel.org>; Wed,  5 Jul 2023 01:07:06 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qGxXN-0003pE-5h; Wed, 05 Jul 2023 10:06:57 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qGxXM-00CDNF-6i; Wed, 05 Jul 2023 10:06:56 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qGxXL-002Ob0-8J; Wed, 05 Jul 2023 10:06:55 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        linux-mips@vger.kernel.org, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH v2 3/8] pwm: jz4740: Put per-channel clk into driver data
Date:   Wed,  5 Jul 2023 10:06:45 +0200
Message-Id: <20230705080650.2353391-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230705080650.2353391-1-u.kleine-koenig@pengutronix.de>
References: <20230705080650.2353391-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1884; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=X7RU3MBp/iCxYXwRbGqtkm5an8LKIPGwfp19wJYuFEg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkpSSQUrnMMqQB9sb9Wx7QwilFKhSmjx/wTwq1O rKT2JxBCDeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZKUkkAAKCRCPgPtYfRL+ Tl7eB/9Ew8rmwAGX2vfpOdayuDiKvPHdBVZH7kpFeJvCqpxYDCXe1aXSJNn9skjmLY3AiO1G6Rq qny893Hn05STsz1LLehDSn3vIGuCV9BpjT2ilzIPz8lNRmQOi+I2zfYn6o9SSSSPMta7zbKE74/ spj3+SNXXmTLADzhXj53kLgaxc8ODaPZTRyGGtXcTnK1i7cijvxCGHD4LL3Im/CLHnBv+hmOqfI xVWamugt86WVlG/ZFzKywd1lEs0kh064gg/jlVsyey7P1/oAzVtic5EvTkfBtI6Oe+qB5p52+kY Nmm5qMvf+lYcD92dp+k3M1fZFpyKO8ucz+R8qrrnbj/KFt5S
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Stop using chip_data which is about to go away. Instead track the
per-channel clk in struct jz4740_pwm_chip.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-jz4740.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index 3b7067f6cd0d..8b01819df67d 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -27,6 +27,7 @@ struct soc_info {
 struct jz4740_pwm_chip {
 	struct pwm_chip chip;
 	struct regmap *map;
+	struct clk *clk[];
 };
 
 static inline struct jz4740_pwm_chip *to_jz4740(struct pwm_chip *chip)
@@ -70,14 +71,15 @@ static int jz4740_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 		return err;
 	}
 
-	pwm_set_chip_data(pwm, clk);
+	jz->clk[pwm->hwpwm] = clk;
 
 	return 0;
 }
 
 static void jz4740_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	struct clk *clk = pwm_get_chip_data(pwm);
+	struct jz4740_pwm_chip *jz = to_jz4740(chip);
+	struct clk *clk = jz->clk[pwm->hwpwm];
 
 	clk_disable_unprepare(clk);
 	clk_put(clk);
@@ -123,7 +125,7 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 {
 	struct jz4740_pwm_chip *jz4740 = to_jz4740(pwm->chip);
 	unsigned long long tmp = 0xffffull * NSEC_PER_SEC;
-	struct clk *clk = pwm_get_chip_data(pwm);
+	struct clk *clk = jz4740->clk[pwm->hwpwm];
 	unsigned long period, duty;
 	long rate;
 	int err;
@@ -229,7 +231,8 @@ static int jz4740_pwm_probe(struct platform_device *pdev)
 	if (!info)
 		return -EINVAL;
 
-	jz4740 = devm_kzalloc(dev, sizeof(*jz4740), GFP_KERNEL);
+	jz4740 = devm_kzalloc(dev, struct_size(jz4740, clk, info->num_pwms),
+			      GFP_KERNEL);
 	if (!jz4740)
 		return -ENOMEM;
 
-- 
2.39.2

