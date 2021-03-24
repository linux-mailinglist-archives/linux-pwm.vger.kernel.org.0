Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98582347C69
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Mar 2021 16:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236624AbhCXPVP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 24 Mar 2021 11:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236620AbhCXPVG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 24 Mar 2021 11:21:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6A6C0613DE
        for <linux-pwm@vger.kernel.org>; Wed, 24 Mar 2021 08:21:06 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lP5Je-00028l-JD; Wed, 24 Mar 2021 16:21:02 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lP5Jd-0003eg-0Z; Wed, 24 Mar 2021 16:21:01 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pwm@vger.kernel.org
Subject: [PATCH 1/2] pwm: Drop unused error path from pwmchip_remove()
Date:   Wed, 24 Mar 2021 16:20:57 +0100
Message-Id: <20210324152058.69022-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210324152058.69022-1-u.kleine-koenig@pengutronix.de>
References: <20210324152058.69022-1-u.kleine-koenig@pengutronix.de>
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
consumer device link")) it cannot happen any more that there is still a
consumer when a pwmchip goes away. So drop this check.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/core.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 7d0266bc5fcb..57b90469a7ad 100644
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
 
-- 
2.30.2

