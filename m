Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8C52C32A7
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Nov 2020 22:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731469AbgKXVYk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 24 Nov 2020 16:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727966AbgKXVYk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 24 Nov 2020 16:24:40 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6C0C0613D6
        for <linux-pwm@vger.kernel.org>; Tue, 24 Nov 2020 13:24:40 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1khfnh-00036M-Lh; Tue, 24 Nov 2020 22:24:37 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1khfnf-0000UK-RE; Tue, 24 Nov 2020 22:24:35 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Lee Jones <lee.jones@linaro.org>, Michael Walle <michael@walle.cc>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] pwm: sl28cpld: fix getting driver data in pwm callbacks
Date:   Tue, 24 Nov 2020 22:24:32 +0100
Message-Id: <20201124212432.3117322-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Currently .get_state() and .apply() use dev_get_drvdata() on the struct
device related to the pwm chip. This only works after .probe() called
platform_set_drvdata() which in this driver happens only after
pwmchip_add() and so comes possibly too late.

Instead of setting the driver data earlier use the traditional
container_of approach as this way the driver data is conceptually and
computational nearer.

Fixes: 9db33d221efc ("pwm: Add support for sl28cpld PWM controller")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

in v4 of the driver Michael still used container_of and then changed to
use dev_get_drvdata() as Lee suggested. I didn't notice this suggestion,
otherwise I would have expressed my variance about this already earlier.

I noticed this problem because Michael contacted me via irc and showed
me the resulting oops, so I think applying this before 5.10 would be
good. It's not entirely clear to me why .get_state() is called that
early in his case, but the theory is clear: The callbacks can be called
as soon as pwmchip_add() is called.

Best regards
Uwe

 drivers/pwm/pwm-sl28cpld.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-sl28cpld.c b/drivers/pwm/pwm-sl28cpld.c
index 5046b6b7fd35..b4c651fc749c 100644
--- a/drivers/pwm/pwm-sl28cpld.c
+++ b/drivers/pwm/pwm-sl28cpld.c
@@ -84,12 +84,14 @@ struct sl28cpld_pwm {
 	struct regmap *regmap;
 	u32 offset;
 };
+#define sl28cpld_pwm_from_chip(_chip) \
+	container_of(_chip, struct sl28cpld_pwm, pwm_chip)
 
 static void sl28cpld_pwm_get_state(struct pwm_chip *chip,
 				   struct pwm_device *pwm,
 				   struct pwm_state *state)
 {
-	struct sl28cpld_pwm *priv = dev_get_drvdata(chip->dev);
+	struct sl28cpld_pwm *priv = sl28cpld_pwm_from_chip(chip);
 	unsigned int reg;
 	int prescaler;
 
@@ -118,7 +120,7 @@ static void sl28cpld_pwm_get_state(struct pwm_chip *chip,
 static int sl28cpld_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			      const struct pwm_state *state)
 {
-	struct sl28cpld_pwm *priv = dev_get_drvdata(chip->dev);
+	struct sl28cpld_pwm *priv = sl28cpld_pwm_from_chip(chip);
 	unsigned int cycle, prescaler;
 	bool write_duty_cycle_first;
 	int ret;
-- 
2.29.2

