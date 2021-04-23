Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2B88369785
	for <lists+linux-pwm@lfdr.de>; Fri, 23 Apr 2021 18:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbhDWQ7v (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 23 Apr 2021 12:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbhDWQ7v (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 23 Apr 2021 12:59:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9E4C061574
        for <linux-pwm@vger.kernel.org>; Fri, 23 Apr 2021 09:59:14 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lZz94-0000OI-PA; Fri, 23 Apr 2021 18:59:10 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lZz94-00077o-0O; Fri, 23 Apr 2021 18:59:10 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-pwm@vger.kernel.org
Subject: [PATCH v2] pwm: Drop irrelevant error path from pwmchip_remove()
Date:   Fri, 23 Apr 2021 18:59:02 +0200
Message-Id: <20210423165902.2439564-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
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

Since the pwm core uses device links (commit b2c200e3f2fd ("pwm: Add
consumer device link")) each consumer driver that requested the PWMs is
already gone. If they called pwm_put() (as they should) the
PWMF_REQUESTED bit is not set. If they failed (which is a bug) the
PWMF_REQUESTED bit might still be set, but the driver that cared is
gone, so nothing bad happens if the pwmchip goes away even if the
PWMF_REQUESTED is still present.

So the check can be dropped.

With this change pwmchip_remove() returns always 0, so lowlevel drivers
don't need to check the return code any more. Once all drivers dropped
this check this function can be changed to return void.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/core.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index c4d5c0667137..2ff0cc8c3f01 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -324,22 +324,10 @@ EXPORT_SYMBOL_GPL(pwmchip_add);
  */
 int pwmchip_remove(struct pwm_chip *chip)
 {
-	unsigned int i;
-	int ret = 0;
-
 	pwmchip_sysfs_unexport(chip);
 
 	mutex_lock(&pwm_lock);
 
-	for (i = 0; i < chip->npwm; i++) {
-		struct pwm_device *pwm = &chip->pwms[i];
-
-		if (test_bit(PWMF_REQUESTED, &pwm->flags)) {
-			ret = -EBUSY;
-			goto out;
-		}
-	}
-
 	list_del_init(&chip->list);
 
 	if (IS_ENABLED(CONFIG_OF))
@@ -347,9 +335,9 @@ int pwmchip_remove(struct pwm_chip *chip)
 
 	free_pwms(chip);
 
-out:
 	mutex_unlock(&pwm_lock);
-	return ret;
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(pwmchip_remove);
 

base-commit: 64d7d074acd52e1bdff621f2cb86c0aae9bcef80
-- 
2.30.2

