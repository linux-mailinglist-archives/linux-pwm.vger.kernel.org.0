Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 417B6341A00
	for <lists+linux-pwm@lfdr.de>; Fri, 19 Mar 2021 11:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbhCSK31 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 19 Mar 2021 06:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbhCSK3D (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 19 Mar 2021 06:29:03 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6817C061763
        for <linux-pwm@vger.kernel.org>; Fri, 19 Mar 2021 03:29:02 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lNCNI-0003iF-Rr; Fri, 19 Mar 2021 11:29:00 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lNCNI-0001gX-I3; Fri, 19 Mar 2021 11:29:00 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Subject: [PATCH 04/14] pwm: Drop function pwmchip_add_with_polarity()
Date:   Fri, 19 Mar 2021 11:28:42 +0100
Message-Id: <20210319102852.101209-5-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210319102852.101209-1-u.kleine-koenig@pengutronix.de>
References: <20210319102852.101209-1-u.kleine-koenig@pengutronix.de>
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

From: Uwe Kleine-König <uwe@kleine-koenig.org>

pwmchip_add() only calls pwmchip_add_with_polarity() and nothing else. All
other users of pwmchip_add_with_polarity() are gone. So drop
pwmchip_add_with_polarity() and move the code instead to pwmchip_add().

The initial assignment to pwm->state.polarity is dropped. In every correct
usage of the PWM API this value is overwritten later anyhow.

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
Link: https://lore.kernel.org/r/20201207134556.25217-4-uwe@kleine-koenig.org
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/core.c  | 25 +++----------------------
 include/linux/pwm.h |  2 --
 2 files changed, 3 insertions(+), 24 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index a8eff4b3ee36..e7a2d9095669 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -260,18 +260,15 @@ static bool pwm_ops_check(const struct pwm_chip *chip)
 }
 
 /**
- * pwmchip_add_with_polarity() - register a new PWM chip
+ * pwmchip_add() - register a new PWM chip
  * @chip: the PWM chip to add
- * @polarity: initial polarity of PWM channels
  *
  * Register a new PWM chip. If chip->base < 0 then a dynamically assigned base
- * will be used. The initial polarity for all channels is specified by the
- * @polarity parameter.
+ * will be used.
  *
  * Returns: 0 on success or a negative error code on failure.
  */
-int pwmchip_add_with_polarity(struct pwm_chip *chip,
-			      enum pwm_polarity polarity)
+int pwmchip_add(struct pwm_chip *chip)
 {
 	struct pwm_device *pwm;
 	unsigned int i;
@@ -303,7 +300,6 @@ int pwmchip_add_with_polarity(struct pwm_chip *chip,
 		pwm->chip = chip;
 		pwm->pwm = chip->base + i;
 		pwm->hwpwm = i;
-		pwm->state.polarity = polarity;
 
 		radix_tree_insert(&pwm_tree, pwm->pwm, pwm);
 	}
@@ -326,21 +322,6 @@ int pwmchip_add_with_polarity(struct pwm_chip *chip,
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(pwmchip_add_with_polarity);
-
-/**
- * pwmchip_add() - register a new PWM chip
- * @chip: the PWM chip to add
- *
- * Register a new PWM chip. If chip->base < 0 then a dynamically assigned base
- * will be used. The initial polarity for all channels is normal.
- *
- * Returns: 0 on success or a negative error code on failure.
- */
-int pwmchip_add(struct pwm_chip *chip)
-{
-	return pwmchip_add_with_polarity(chip, PWM_POLARITY_NORMAL);
-}
 EXPORT_SYMBOL_GPL(pwmchip_add);
 
 /**
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index e4d84d4db293..8f4eefd129aa 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -392,8 +392,6 @@ int pwm_capture(struct pwm_device *pwm, struct pwm_capture *result,
 int pwm_set_chip_data(struct pwm_device *pwm, void *data);
 void *pwm_get_chip_data(struct pwm_device *pwm);
 
-int pwmchip_add_with_polarity(struct pwm_chip *chip,
-			      enum pwm_polarity polarity);
 int pwmchip_add(struct pwm_chip *chip);
 int pwmchip_remove(struct pwm_chip *chip);
 struct pwm_device *pwm_request_from_chip(struct pwm_chip *chip,
-- 
2.30.1

