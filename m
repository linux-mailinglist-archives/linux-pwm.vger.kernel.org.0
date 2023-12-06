Return-Path: <linux-pwm+bounces-315-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 353BD806E5C
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E39EC281BBA
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C59F34561;
	Wed,  6 Dec 2023 11:48:32 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADA9D47
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:26 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqO8-0006Dg-O4; Wed, 06 Dec 2023 12:48:24 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqO8-00Dwse-3y; Wed, 06 Dec 2023 12:48:24 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqO7-00FQxn-RX; Wed, 06 Dec 2023 12:48:23 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	linux-pwm@vger.kernel.org
Subject: [PATCH v4 021/115] pwm: lpss: Make use of pwmchip_parent() macro
Date: Wed,  6 Dec 2023 12:43:35 +0100
Message-ID:  <0e128e4da1f19017af73445cf321daaa5c152dea.1701860672.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1701860672.git.u.kleine-koenig@pengutronix.de>
References: <cover.1701860672.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2474; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=r2bF3wrio8JPyyCXdxG5IDSji86EqujFlp0yknuZbGE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcF508vWCtusNxyjMmOKbq4Bc4k75gC2rBF/B6 GrAX7w9/vaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXBedAAKCRCPgPtYfRL+ TishB/9ytCSAYy3a9OcJDWCV8IpvGCZFyxMYllI9+9dTC8EAfFWlVn6uIXxX/Nqf6zE2gaBG8SU 3Y6NK2IeKzWWSZJ+66W61WJB3hs5ZxrEIqIQYPKK2g+FqUHps4qAjNaWqYLp1YTutFIekOo/Y6r xogR/SGtfmKEbyT8c8qV1nc1h+ELS3aLwIG/D+l0zy5EwLXVRmXo/bUmRao1VAXw9Ska+BzuMDw u/EUbmvhWoajeCcxlIlC6FoFzzHmPmVXPVNTJOzeGghOGgswjSsSJuZFSDNuQI4c0JeQxpiawiw n0DHSKa+xhZ2NFYj8NxLzFUi+tp55k83Y2ASpclMByimQ9Fy
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

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


