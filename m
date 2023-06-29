Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B14742375
	for <lists+linux-pwm@lfdr.de>; Thu, 29 Jun 2023 11:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbjF2JtE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 29 Jun 2023 05:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjF2Js6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 29 Jun 2023 05:48:58 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBA32D4E
        for <linux-pwm@vger.kernel.org>; Thu, 29 Jun 2023 02:48:54 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qEoGi-0006V0-47; Thu, 29 Jun 2023 11:48:52 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qEoGg-00AroM-V8; Thu, 29 Jun 2023 11:48:50 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qEoGg-000kx3-3C; Thu, 29 Jun 2023 11:48:50 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Benson Leung <bleung@chromium.org>
Cc:     Guenter Roeck <groeck@chromium.org>, linux-pwm@vger.kernel.org,
        chrome-platform@lists.linux.dev, kernel@pengutronix.de
Subject: [PATCH 7/8] pwm: cros-ec: Put per channel data into driver data
Date:   Thu, 29 Jun 2023 11:48:38 +0200
Message-Id: <20230629094839.757092-8-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230629094839.757092-1-u.kleine-koenig@pengutronix.de>
References: <20230629094839.757092-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3422; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=4lBTwKH/8/IB1tB3q5vQggkuxb6HShk1GsVvr8cNbEk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBknVNrZb+Zh6i7f9Gwq/njLMmSsJk4NfUnDR6l7 agnFjyT6XiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZJ1TawAKCRCPgPtYfRL+ TmzqB/42R1WHpMtZH9j+Is77YXbSkYVThRaz8lR7Cv8rSresfENLE836YynN+V553CgXoxH6eb5 fZ3l+fdJLvV/YoFGpFDXI5t1u4V74yfVZH0rm43RMcgJXozOLzIqsBMMvCw4RsIBQQz8l6+ZxkN sg0VNPVwOMm+vYAuuMV+PRNeZvkNQUY2431Y6xfYyfGwSJ8VuwYFpcAlDV9Vn6OJw9g4BB9GHcv nJ9CSmQZeQ+oG5MoEuRI9mEtxcTMK787segjzY0fGw3YDNlbyqDzgCXNtpp2ZJxwTDb6KBhNpGW EzGH3sOBXnsp2iVWbR7S1cBgYlEmu9HHtGkf/p2Tn0vmjWDg
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Instead of an allocation of a single u16 per channel, allocate them all
in a single chunk which greatly reduces memory fragmentation and also
the overhead to track the allocated memory. Also put the channel data in
driver data where it's cheaper to determine the address (no function
call involved, just a trivial pointer addition).

This also allows to get rid of the request and free callbacks.

The only cost is that the channel data is allocated early, and even for
unused channels.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
If we'd know the number of channels already when memory is allocated for
struct cros_ec_pwm_device *ec_pwm in cros_ec_pwm_probe, the per channel
data could live directly in struct cros_ec_pwm_device which would
further reduce the memory allocation overhead and fragmentation.

 drivers/pwm/pwm-cros-ec.c | 31 +++++++------------------------
 1 file changed, 7 insertions(+), 24 deletions(-)

diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
index 74e863aa1d8d..2998153a5e92 100644
--- a/drivers/pwm/pwm-cros-ec.c
+++ b/drivers/pwm/pwm-cros-ec.c
@@ -27,6 +27,7 @@ struct cros_ec_pwm_device {
 	struct cros_ec_device *ec;
 	struct pwm_chip chip;
 	bool use_pwm_type;
+	struct cros_ec_pwm *channel;
 };
 
 /**
@@ -42,26 +43,6 @@ static inline struct cros_ec_pwm_device *pwm_to_cros_ec_pwm(struct pwm_chip *c)
 	return container_of(c, struct cros_ec_pwm_device, chip);
 }
 
-static int cros_ec_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct cros_ec_pwm *channel;
-
-	channel = kzalloc(sizeof(*channel), GFP_KERNEL);
-	if (!channel)
-		return -ENOMEM;
-
-	pwm_set_chip_data(pwm, channel);
-
-	return 0;
-}
-
-static void cros_ec_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct cros_ec_pwm *channel = pwm_get_chip_data(pwm);
-
-	kfree(channel);
-}
-
 static int cros_ec_dt_type_to_pwm_type(u8 dt_index, u8 *pwm_type)
 {
 	switch (dt_index) {
@@ -157,7 +138,7 @@ static int cros_ec_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			     const struct pwm_state *state)
 {
 	struct cros_ec_pwm_device *ec_pwm = pwm_to_cros_ec_pwm(chip);
-	struct cros_ec_pwm *channel = pwm_get_chip_data(pwm);
+	struct cros_ec_pwm *channel = &ec_pwm->channel[pwm->hwpwm];
 	u16 duty_cycle;
 	int ret;
 
@@ -187,7 +168,7 @@ static int cros_ec_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 				 struct pwm_state *state)
 {
 	struct cros_ec_pwm_device *ec_pwm = pwm_to_cros_ec_pwm(chip);
-	struct cros_ec_pwm *channel = pwm_get_chip_data(pwm);
+	struct cros_ec_pwm *channel = &ec_pwm->channel[pwm->hwpwm];
 	int ret;
 
 	ret = cros_ec_pwm_get_duty(ec_pwm, pwm->hwpwm);
@@ -236,8 +217,6 @@ cros_ec_pwm_xlate(struct pwm_chip *pc, const struct of_phandle_args *args)
 }
 
 static const struct pwm_ops cros_ec_pwm_ops = {
-	.request = cros_ec_pwm_request,
-	.free = cros_ec_pwm_free,
 	.get_state	= cros_ec_pwm_get_state,
 	.apply		= cros_ec_pwm_apply,
 	.owner		= THIS_MODULE,
@@ -316,6 +295,10 @@ static int cros_ec_pwm_probe(struct platform_device *pdev)
 		chip->npwm = ret;
 	}
 
+	ec_pwm->channel = devm_kzalloc(dev, chip->npwm * sizeof(*ec_pwm->channel), GFP_KERNEL);
+	if (!ec_pwm->channel)
+		return -ENOMEM;
+
 	dev_dbg(dev, "Probed %u PWMs\n", chip->npwm);
 
 	ret = pwmchip_add(chip);
-- 
2.39.2

