Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 853DD3BEC2F
	for <lists+linux-pwm@lfdr.de>; Wed,  7 Jul 2021 18:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhGGQbi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 7 Jul 2021 12:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhGGQbi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 7 Jul 2021 12:31:38 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46E5C061574
        for <linux-pwm@vger.kernel.org>; Wed,  7 Jul 2021 09:28:57 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1APv-0004Sb-IM; Wed, 07 Jul 2021 18:28:55 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1APu-0002d7-Tk; Wed, 07 Jul 2021 18:28:54 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1APn-0006KF-R2; Wed, 07 Jul 2021 18:28:47 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 47/47] pwm: Make pwmchip_remove() return void
Date:   Wed,  7 Jul 2021 18:28:35 +0200
Message-Id: <20210707162835.1772882-48-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210707162835.1772882-1-u.kleine-koenig@pengutronix.de>
References: <20210707162835.1772882-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Since some time pwmchip_remove() always returns 0 so the return value
isn't usefull. Now that all callers are converted to ignore its value
the function can be changed to return void.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/core.c  | 4 +---
 include/linux/pwm.h | 2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index a28c8639af5b..cb08ebb39051 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -304,7 +304,7 @@ EXPORT_SYMBOL_GPL(pwmchip_add);
  *
  * Returns: 0 on success or a negative error code on failure.
  */
-int pwmchip_remove(struct pwm_chip *chip)
+void pwmchip_remove(struct pwm_chip *chip)
 {
 	pwmchip_sysfs_unexport(chip);
 
@@ -318,8 +318,6 @@ int pwmchip_remove(struct pwm_chip *chip)
 	free_pwms(chip);
 
 	mutex_unlock(&pwm_lock);
-
-	return 0;
 }
 EXPORT_SYMBOL_GPL(pwmchip_remove);
 
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index a0b7e43049d5..725c9b784e60 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -404,7 +404,7 @@ int pwm_set_chip_data(struct pwm_device *pwm, void *data);
 void *pwm_get_chip_data(struct pwm_device *pwm);
 
 int pwmchip_add(struct pwm_chip *chip);
-int pwmchip_remove(struct pwm_chip *chip);
+void pwmchip_remove(struct pwm_chip *chip);
 
 int devm_pwmchip_add(struct device *dev, struct pwm_chip *chip);
 
-- 
2.30.2

