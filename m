Return-Path: <linux-pwm+bounces-14-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 020C77F2F55
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2891281B5D
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E96153810;
	Tue, 21 Nov 2023 13:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E3210D3
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:51:51 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAK-00056v-TZ; Tue, 21 Nov 2023 14:51:48 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAK-00AaxO-2K; Tue, 21 Nov 2023 14:51:48 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAJ-004xbj-PZ; Tue, 21 Nov 2023 14:51:47 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v3 016/108] pwm: lpss: Make use of pwmchip_parent() macro
Date: Tue, 21 Nov 2023 14:49:18 +0100
Message-ID: <20231121134901.208535-17-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
References: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2474; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=r2bF3wrio8JPyyCXdxG5IDSji86EqujFlp0yknuZbGE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXLVeFSsC3XYn+exzJuigV2Z67dDq4RHZJ57+5 l4Honh/00uJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVy1XgAKCRCPgPtYfRL+ ThEVB/478OAWD7D4IG7LW6Ddk2fcogUXapoIJmMXZzLeZXFxhekK+LfScLbcraa+oGnmyYKzZLs jSgeDN95fliduxgh9k0hUDORToNHVSBSyAeB7ignd/JVG5smpG710PV1Xz9hjCW9IFL52+ex9Ra bZfFL4/yJxjQKFW/T6tPbguEpA5ITjEtaKQQORRvdJwfe+/0T9MSVqrEgdJEJnJqzmCcaNJeOHY 0Eo6fJ7ejZz25t0ZUZilvPICdBFUmHkvcUEcXCuLMkgNKFvh6s/pjVZrax19DOogvulU4p5Gwy6 xVgaNmeuq/gRpTSKTHqPLBouRSgUBLicCWtkM9Y+3fXk/zrx
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


