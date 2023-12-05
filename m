Return-Path: <linux-pwm+bounces-293-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A14BA804F94
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Dec 2023 10:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 588B828168A
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Dec 2023 09:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11413FE41;
	Tue,  5 Dec 2023 09:56:27 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A811700
	for <linux-pwm@vger.kernel.org>; Tue,  5 Dec 2023 01:56:23 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rASAA-0005fd-Et; Tue, 05 Dec 2023 10:56:22 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rASA9-00DiFw-SB; Tue, 05 Dec 2023 10:56:21 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rASA9-00EdYm-J8; Tue, 05 Dec 2023 10:56:21 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH] pwm: omap-dmtimer: Drop locking
Date: Tue,  5 Dec 2023 10:56:17 +0100
Message-ID: <20231205095617.1412865-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3213; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=SvTqLgXKrx5oPfpqmjNbfLX06Awsg/89k2QIwIBuKoc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlbvPBOiXgJV84pLFvSYm85t0EYwSZAy6frLn9b NGSOeCnPHWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZW7zwQAKCRCPgPtYfRL+ TlfWB/9i8zsPRhhvytMQ55H0jYY/8/URKAm9gMzn2d9DQ91hbP0tALiCPw7ExyAv/Km+Hz80bHI hQD/1rg8ZWvewVbwIu5bzFQL73dzq7BBeEybux+9HBtnrZhDO72AxYyJ2HtA3QRHnq7Batu9+J7 IvSDw5maQhKUXwZQbbQggI31N2SvDuLTjXvv70nC0uay7SX3eBPPORPWPShuc0WAWQ8KdrgxF9V P6rf46fqi0wt6U1sv3x27A9c6xgr5rdCsFfi9c5ZWqmvAb11Lfrd34N+nNuGhhW9b1kVj5BQGB8 FQe2WK1RglRwV6GtBOINdhrk1Y75HM0xjn6UTg394Optimq9
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

The pwm driver only provides a single PWM line, so there are no concurrent
calls of the callbacks from different consumers. A single consumer is
expected not to do concurrent calls into the pwm framework. So there is
nothing to serialize and the lock can go away.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-omap-dmtimer.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index 13161e08dd6e..496bd73d29fe 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -37,7 +37,6 @@
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <clocksource/timer-ti-dm.h>
@@ -55,7 +54,6 @@
  * struct pwm_omap_dmtimer_chip - Structure representing a pwm chip
  *				  corresponding to omap dmtimer.
  * @chip:		PWM chip structure representing PWM controller
- * @mutex:		Mutex to protect pwm apply state
  * @dm_timer:		Pointer to omap dm timer.
  * @pdata:		Pointer to omap dm timer ops.
  * @dm_timer_pdev:	Pointer to omap dm timer platform device
@@ -63,7 +61,6 @@
 struct pwm_omap_dmtimer_chip {
 	struct pwm_chip chip;
 	/* Mutex to protect pwm apply state */
-	struct mutex mutex;
 	struct omap_dm_timer *dm_timer;
 	const struct omap_dm_timer_ops *pdata;
 	struct platform_device *dm_timer_pdev;
@@ -277,13 +274,11 @@ static int pwm_omap_dmtimer_apply(struct pwm_chip *chip,
 				  const struct pwm_state *state)
 {
 	struct pwm_omap_dmtimer_chip *omap = to_pwm_omap_dmtimer_chip(chip);
-	int ret = 0;
-
-	mutex_lock(&omap->mutex);
+	int ret;
 
 	if (pwm_omap_dmtimer_is_enabled(omap) && !state->enabled) {
 		omap->pdata->stop(omap->dm_timer);
-		goto unlock_mutex;
+		return 0;
 	}
 
 	if (pwm_omap_dmtimer_polarity(omap) != state->polarity)
@@ -292,7 +287,7 @@ static int pwm_omap_dmtimer_apply(struct pwm_chip *chip,
 	ret = pwm_omap_dmtimer_config(chip, pwm, state->duty_cycle,
 				      state->period);
 	if (ret)
-		goto unlock_mutex;
+		return ret;
 
 	if (!pwm_omap_dmtimer_is_enabled(omap) && state->enabled) {
 		omap->pdata->set_pwm(omap->dm_timer,
@@ -303,10 +298,7 @@ static int pwm_omap_dmtimer_apply(struct pwm_chip *chip,
 		pwm_omap_dmtimer_start(omap);
 	}
 
-unlock_mutex:
-	mutex_unlock(&omap->mutex);
-
-	return ret;
+	return 0;
 }
 
 static const struct pwm_ops pwm_omap_dmtimer_ops = {
@@ -404,8 +396,6 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
 	omap->chip.ops = &pwm_omap_dmtimer_ops;
 	omap->chip.npwm = 1;
 
-	mutex_init(&omap->mutex);
-
 	ret = pwmchip_add(&omap->chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to register PWM\n");
@@ -452,8 +442,6 @@ static void pwm_omap_dmtimer_remove(struct platform_device *pdev)
 	omap->pdata->free(omap->dm_timer);
 
 	put_device(&omap->dm_timer_pdev->dev);
-
-	mutex_destroy(&omap->mutex);
 }
 
 static const struct of_device_id pwm_omap_dmtimer_of_match[] = {

base-commit: aaa69b9d49de73bd5f17b29cb6ce423afc83bcc9
-- 
2.42.0


