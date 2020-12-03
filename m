Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 446412CD189
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Dec 2020 09:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388442AbgLCImo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 3 Dec 2020 03:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388449AbgLCImm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 3 Dec 2020 03:42:42 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53618C061A4E
        for <linux-pwm@vger.kernel.org>; Thu,  3 Dec 2020 00:42:02 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kkkBc-0002CH-CR; Thu, 03 Dec 2020 09:42:00 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kkkBb-0000Cz-MI; Thu, 03 Dec 2020 09:41:59 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, kernel@pengutronix.de,
        Michael Walle <michael@walle.cc>
Subject: [PATCH RESEND for 5.10] pwm: sl28cpld: fix getting driver data in pwm callbacks
Date:   Thu,  3 Dec 2020 09:41:42 +0100
Message-Id: <20201203084142.3810204-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
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
Tested-by: Michael Walle <michael@walle.cc>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello Linus,

Thierry (who usually sends PWM patches to you) didn't react to this
patch sent to the pwm Mailinglist last week
(https://lore.kernel.org/r/20201124212432.3117322-1-u.kleine-koenig@pengutronix.de)
yet.

Given v5.10 isn't far away any more and I don't know when Thierry will
take a look and act, I'm sending this directly to you. The affected
driver was new in 5.10-rc1 and at least once the unpatched driver
created an oops:

	https://lavalab.kontron.com/scheduler/job/108#L950

Michael Walle who tested this patch is the original author of the
driver. IMHO it would be good to have this fixed before 5.10.

If you prefer a pull request, I can setup something (but I don't have
access to Thierry's tree, so it will be for a repository that's new to
you).

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

