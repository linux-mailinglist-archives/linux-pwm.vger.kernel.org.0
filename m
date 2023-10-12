Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFEA37C72AB
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379561AbjJLQbD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379576AbjJLQa6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:30:58 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69EDAC0
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:30:56 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaM-0004op-NU; Thu, 12 Oct 2023 18:30:54 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaM-001C6I-2z; Thu, 12 Oct 2023 18:30:54 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaL-00F5NB-QD; Thu, 12 Oct 2023 18:30:53 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 017/109] pwm: lpss: Make use of pwmchip_parent() macro
Date:   Thu, 12 Oct 2023 18:28:45 +0200
Message-ID: <20231012162827.1002444-128-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2474; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=r2bF3wrio8JPyyCXdxG5IDSji86EqujFlp0yknuZbGE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKB7AFSsC3XYn+exzJuigV2Z67dDq4RHZJ57+5 l4Honh/00uJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSgewAAKCRCPgPtYfRL+ TpkECACNAwgecr5dI0NToc1QWDp1dSyaeG9NLjN6jvOPj85iDfxzXHxPiTjtHvNesGben1qf5ro yKLJxD/1hA8IgVRa8Mj7P1NHm6jyfLeoD+51/GIkXD8TatKWOuIbfIPpuZMwz8Wab2F5jR3FVlI pK9ybV9byvFEVZM5jhfZdcLgVRv8sTPX+iWjCgWZ28jPQDlH+Ap0cIyzp7ystvh0fj8ctfzOsBB fUk4NVT1AgDvk1Q6Yvm6EBVx9WLD62pJ9GU2xQkIJK97/3xPV26cYXkLvz3V+Nk/vRhRDZD0RVr DIdOjLoz7uNA/179fWZKqdWESUU91NSUSWicCXACaIZskjN6
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

struct pwm_chip::dev is about to change. To not have to touch this
driver in the same commit as struct pwm_chip::dev, use the macro
provided for exactly this purpose.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-lpss.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index a6ea3ce7e019..394c768f5a5f 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -106,7 +106,7 @@ static int pwm_lpss_wait_for_update(struct pwm_device *pwm)
 	 */
 	err = readl_poll_timeout(addr, val, !(val & PWM_SW_UPDATE), 40, ms);
 	if (err)
-		dev_err(pwm->chip->dev, "PWM_SW_UPDATE was not cleared\n");
+		dev_err(pwmchip_parent(pwm->chip), "PWM_SW_UPDATE was not cleared\n");
 
 	return err;
 }
@@ -114,7 +114,7 @@ static int pwm_lpss_wait_for_update(struct pwm_device *pwm)
 static inline int pwm_lpss_is_updating(struct pwm_device *pwm)
 {
 	if (pwm_lpss_read(pwm) & PWM_SW_UPDATE) {
-		dev_err(pwm->chip->dev, "PWM_SW_UPDATE is still set, skipping update\n");
+		dev_err(pwmchip_parent(pwm->chip), "PWM_SW_UPDATE is still set, skipping update\n");
 		return -EBUSY;
 	}
 
@@ -190,16 +190,16 @@ static int pwm_lpss_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	if (state->enabled) {
 		if (!pwm_is_enabled(pwm)) {
-			pm_runtime_get_sync(chip->dev);
+			pm_runtime_get_sync(pwmchip_parent(chip));
 			ret = pwm_lpss_prepare_enable(lpwm, pwm, state);
 			if (ret)
-				pm_runtime_put(chip->dev);
+				pm_runtime_put(pwmchip_parent(chip));
 		} else {
 			ret = pwm_lpss_prepare_enable(lpwm, pwm, state);
 		}
 	} else if (pwm_is_enabled(pwm)) {
 		pwm_lpss_write(pwm, pwm_lpss_read(pwm) & ~PWM_ENABLE);
-		pm_runtime_put(chip->dev);
+		pm_runtime_put(pwmchip_parent(chip));
 	}
 
 	return ret;
@@ -213,7 +213,7 @@ static int pwm_lpss_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	unsigned long long base_unit, freq, on_time_div;
 	u32 ctrl;
 
-	pm_runtime_get_sync(chip->dev);
+	pm_runtime_get_sync(pwmchip_parent(chip));
 
 	base_unit_range = BIT(lpwm->info->base_unit_bits);
 
@@ -235,7 +235,7 @@ static int pwm_lpss_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	state->polarity = PWM_POLARITY_NORMAL;
 	state->enabled = !!(ctrl & PWM_ENABLE);
 
-	pm_runtime_put(chip->dev);
+	pm_runtime_put(pwmchip_parent(chip));
 
 	return 0;
 }
-- 
2.42.0

