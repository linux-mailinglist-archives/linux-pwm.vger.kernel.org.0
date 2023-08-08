Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECBF077440D
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 20:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235445AbjHHSOw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 14:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235447AbjHHSOY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 14:14:24 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB571DD19
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:20:24 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNF-0007eF-3x; Tue, 08 Aug 2023 19:20:01 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNE-00229X-9D; Tue, 08 Aug 2023 19:20:00 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQND-00BTFg-Hp; Tue, 08 Aug 2023 19:19:59 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 086/101] pwm: raspberrypi-poe: Store parent device in driver data
Date:   Tue,  8 Aug 2023 19:19:16 +0200
Message-Id: <20230808171931.944154-87-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1382; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=uh0rgrmQPHrfr16s2cVas2GYzM8IjDcbhCijKb/nltU=; b=owGbwMvMwMXY3/A7olbonx/jabUkhpRLlYLLmM8V5efZbdM5e9Jpi0dXZ8uepe8S1zROZTxUJ rRpjZNTJ6MxCwMjF4OsmCKLfeOaTKsqucjOtf8uwwxiZQKZwsDFKQATafrK/j/kUg+rRk4aw/rk tbpzsvxd322fuo+75ZZClJTSac77T08/Wi794+0dfiv70t4fKxZP3JtoGLblvqVR9OzbMnLG6i+ tec9Yn3x1UMPFRsA7Nrul98GcF0zuS/gmsimbRR57H6qaJrqH8+8sOyWp29N07cr23fktHrRuR6 JGSIp+6u3TwSc/Ct3JjH55WW4Cj7f26mWOtbKr5YsUu0PvpXoLySnd6rG6F2fJfqR+4ikp73VfX Ws2e+XNdSt5lCQQVu+a8dmy6XyIr+W3o4JScRNufUrZvsWXq3d1xLG1KxXjp+s61V1qYypZ1ma+ +8whsyiD23ubE11K3aYE8imYebo+uuT40qXF631i6/syAA==
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
 drivers/pwm/pwm-raspberrypi-poe.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-raspberrypi-poe.c b/drivers/pwm/pwm-raspberrypi-poe.c
index 4b2711d59e7c..b6d1326a3741 100644
--- a/drivers/pwm/pwm-raspberrypi-poe.c
+++ b/drivers/pwm/pwm-raspberrypi-poe.c
@@ -26,6 +26,7 @@
 #define RPI_PWM_CUR_DUTY_REG		0x0
 
 struct raspberrypi_pwm {
+	struct device *parent;
 	struct rpi_firmware *firmware;
 	unsigned int duty_cycle;
 };
@@ -121,7 +122,7 @@ static int raspberrypi_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	ret = raspberrypi_pwm_set_property(rpipwm->firmware, RPI_PWM_CUR_DUTY_REG,
 					   duty_cycle);
 	if (ret) {
-		dev_err(chip->dev, "Failed to set duty cycle: %pe\n",
+		dev_err(rpipwm->parent, "Failed to set duty cycle: %pe\n",
 			ERR_PTR(ret));
 		return ret;
 	}
@@ -163,6 +164,7 @@ static int raspberrypi_pwm_probe(struct platform_device *pdev)
 		return PTR_ERR(chip);
 	rpipwm = raspberrypi_pwm_from_chip(chip);
 
+	rpipwm->parent = &pdev->dev;
 	rpipwm->firmware = firmware;
 	chip->ops = &raspberrypi_pwm_ops;
 
-- 
2.40.1

