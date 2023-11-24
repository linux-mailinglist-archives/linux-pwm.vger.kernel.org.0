Return-Path: <linux-pwm+bounces-200-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 551FC7F85A5
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Nov 2023 22:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 103ED28395F
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Nov 2023 21:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D573BB52;
	Fri, 24 Nov 2023 21:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BE51987
	for <linux-pwm@vger.kernel.org>; Fri, 24 Nov 2023 13:52:22 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r6e5y-0002d3-UJ; Fri, 24 Nov 2023 22:52:18 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r6e5y-00BLvw-Hp; Fri, 24 Nov 2023 22:52:18 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r6e5y-007hOe-8d; Fri, 24 Nov 2023 22:52:18 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-pwm@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 2/3] leds: qcom-lpg: Introduce a wrapper for getting driver data from a pwm chip
Date: Fri, 24 Nov 2023 22:52:11 +0100
Message-ID: <20231124215208.616551-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231124215208.616551-1-u.kleine-koenig@pengutronix.de>
References: <20231124215208.616551-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1742; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=qPzUWecsiserdu7G8DCwOVYR4CTVjBLWRlj8uXxUTu0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlYRsLtE8H/NrZKfprz/SpJVx/QLUXCyoZ06/Ug hnxim1yNM2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZWEbCwAKCRCPgPtYfRL+ Tk4TCAC301DqDq8AXZ+WLOK4//pAAnRt/yqTPg1RzoS4v2hRvmnHECCJefx2jOTmBeKiZm5tJfG Flq3+6L8z3eA8cLbDs0S3PTpD6jeFk0qdcl8bkMgOPMWI87vJODDQPRkgEB9icPtccGzV7FBR6w +gCPpcAmZs5mCqb+27XvZoVDrEpWXRojGZMMrFAROPOXKLnp0fXy1rJ9/hBD8KsvX/RD2ffSN/w kZxkQ3dFhUcdvLNsclyLuZYp96VwUs8pNaRzK8/lX2Y8DT9LBirh46BFk4Q84Zld4/eQu+UgwHY s33ip5dOZMjk1MFsJbJmeq6qdPU7YHhTJWUl6Z09Yc9mzzNY
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/leds/rgb/leds-qcom-lpg.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
index 68d82a682bf6..c523f3c0cdb1 100644
--- a/drivers/leds/rgb/leds-qcom-lpg.c
+++ b/drivers/leds/rgb/leds-qcom-lpg.c
@@ -977,9 +977,14 @@ static int lpg_pattern_mc_clear(struct led_classdev *cdev)
 	return lpg_pattern_clear(led);
 }
 
+static inline struct lpg *lpg_pwm_from_chip(struct pwm_chip *chip)
+{
+	return container_of(chip, struct lpg, pwm);
+}
+
 static int lpg_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	struct lpg *lpg = container_of(chip, struct lpg, pwm);
+	struct lpg *lpg = lpg_pwm_from_chip(chip);
 	struct lpg_channel *chan = &lpg->channels[pwm->hwpwm];
 
 	return chan->in_use ? -EBUSY : 0;
@@ -995,7 +1000,7 @@ static int lpg_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 static int lpg_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			 const struct pwm_state *state)
 {
-	struct lpg *lpg = container_of(chip, struct lpg, pwm);
+	struct lpg *lpg = lpg_pwm_from_chip(chip);
 	struct lpg_channel *chan = &lpg->channels[pwm->hwpwm];
 	int ret = 0;
 
@@ -1026,7 +1031,7 @@ static int lpg_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 static int lpg_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 			     struct pwm_state *state)
 {
-	struct lpg *lpg = container_of(chip, struct lpg, pwm);
+	struct lpg *lpg = lpg_pwm_from_chip(chip);
 	struct lpg_channel *chan = &lpg->channels[pwm->hwpwm];
 	unsigned int resolution;
 	unsigned int pre_div;
-- 
2.42.0


