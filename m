Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB78F747F01
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Jul 2023 10:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbjGEIHK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 5 Jul 2023 04:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbjGEIHJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 5 Jul 2023 04:07:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBA6133
        for <linux-pwm@vger.kernel.org>; Wed,  5 Jul 2023 01:07:04 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qGxXO-0003pv-3a; Wed, 05 Jul 2023 10:06:58 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qGxXN-00CDNa-En; Wed, 05 Jul 2023 10:06:57 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qGxXM-002ObI-Cj; Wed, 05 Jul 2023 10:06:56 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 8/8] pwm: Drop pwm_[sg]et_chip_data()
Date:   Wed,  5 Jul 2023 10:06:50 +0200
Message-Id: <20230705080650.2353391-9-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230705080650.2353391-1-u.kleine-koenig@pengutronix.de>
References: <20230705080650.2353391-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3229; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=jCj64Dr962MGXIB2t6e7AE+GZySDaxkJIOR2UbZO9wk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkpSSVJ78RjF9RXDcOUnib3mP9wVpsKXVxcZ1u7 EyqnVaZue2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZKUklQAKCRCPgPtYfRL+ TsHuCACj6NxmbtpY9xFUrTSgTw6v20Ubg8ACjOCKdurENZZ27GGgCxerB5DS+cgJ0jtlI88QtfS dprYgB18TtjpU+Ez8rLgkJy+lOE7Gop+u0rIWvdv0S1LxCwsdIWQ4GBtPFUCeae9F1hIRpIv6lK 0IdKWe7UI8iN4XhWjZ3SlO8bJh9Z+cOm8gXj01wgSS6hw0UHZNQIzYj2uBirgxjbYJQ5YVGkQ62 9APHZ6MuXAdKqHstYEnNIuGeZL7Bb5E7oApvkV6POROPq3EMBnxpNJQ05kDWQKo2hk9+sOBxgpT ZKJTLF3Vnq1aoJ668T+iNT10xCQ186jqxsS7Tlh52U+6YD4C
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

The semantic of chip_data is a bit surprising as it's cleared when
pwm_put() is called. Also there is a big overlap with the standard driver
data.

All drivers were adapted to not make use of chip_data any more, so it can
go away.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/core.c  | 31 -------------------------------
 include/linux/pwm.h | 14 --------------
 2 files changed, 45 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 3dacceaef4a9..2a786f3b6780 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -208,36 +208,6 @@ static void of_pwmchip_remove(struct pwm_chip *chip)
 		of_node_put(chip->dev->of_node);
 }
 
-/**
- * pwm_set_chip_data() - set private chip data for a PWM
- * @pwm: PWM device
- * @data: pointer to chip-specific data
- *
- * Returns: 0 on success or a negative error code on failure.
- */
-int pwm_set_chip_data(struct pwm_device *pwm, void *data)
-{
-	if (!pwm)
-		return -EINVAL;
-
-	pwm->chip_data = data;
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(pwm_set_chip_data);
-
-/**
- * pwm_get_chip_data() - get private chip data for a PWM
- * @pwm: PWM device
- *
- * Returns: A pointer to the chip-private data for the PWM device.
- */
-void *pwm_get_chip_data(struct pwm_device *pwm)
-{
-	return pwm ? pwm->chip_data : NULL;
-}
-EXPORT_SYMBOL_GPL(pwm_get_chip_data);
-
 static bool pwm_ops_check(const struct pwm_chip *chip)
 {
 	const struct pwm_ops *ops = chip->ops;
@@ -979,7 +949,6 @@ void pwm_put(struct pwm_device *pwm)
 	if (pwm->chip->ops->free)
 		pwm->chip->ops->free(pwm->chip, pwm);
 
-	pwm_set_chip_data(pwm, NULL);
 	pwm->label = NULL;
 
 	module_put(pwm->chip->ops->owner);
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 04ae1d9073a7..e0cc42aafb1c 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -71,7 +71,6 @@ struct pwm_state {
  * @hwpwm: per-chip relative index of the PWM device
  * @pwm: global index of the PWM device
  * @chip: PWM chip providing this PWM device
- * @chip_data: chip-private data associated with the PWM device
  * @args: PWM arguments
  * @state: last applied state
  * @last: last implemented state (for PWM_DEBUG)
@@ -82,7 +81,6 @@ struct pwm_device {
 	unsigned int hwpwm;
 	unsigned int pwm;
 	struct pwm_chip *chip;
-	void *chip_data;
 
 	struct pwm_args args;
 	struct pwm_state state;
@@ -383,8 +381,6 @@ static inline void pwm_disable(struct pwm_device *pwm)
 /* PWM provider APIs */
 int pwm_capture(struct pwm_device *pwm, struct pwm_capture *result,
 		unsigned long timeout);
-int pwm_set_chip_data(struct pwm_device *pwm, void *data);
-void *pwm_get_chip_data(struct pwm_device *pwm);
 
 int pwmchip_add(struct pwm_chip *chip);
 void pwmchip_remove(struct pwm_chip *chip);
@@ -445,16 +441,6 @@ static inline int pwm_capture(struct pwm_device *pwm,
 	return -EINVAL;
 }
 
-static inline int pwm_set_chip_data(struct pwm_device *pwm, void *data)
-{
-	return -EINVAL;
-}
-
-static inline void *pwm_get_chip_data(struct pwm_device *pwm)
-{
-	return NULL;
-}
-
 static inline int pwmchip_add(struct pwm_chip *chip)
 {
 	return -EINVAL;
-- 
2.39.2

