Return-Path: <linux-pwm+bounces-360-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA02806E9C
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77694281C0C
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA37E358A2;
	Wed,  6 Dec 2023 11:48:50 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B74AD53
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:38 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOI-0006z1-9k; Wed, 06 Dec 2023 12:48:34 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOG-00Dwvk-4E; Wed, 06 Dec 2023 12:48:32 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOF-00FR17-Rl; Wed, 06 Dec 2023 12:48:31 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	linux-pwm@vger.kernel.org
Subject: [PATCH v4 070/115] pwm: lp3943: Make use of devm_pwmchip_alloc() function
Date: Wed,  6 Dec 2023 12:44:24 +0100
Message-ID:  <92d92bb544bdf2a93ce964ff71a1f363eafaa20d.1701860672.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2077; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=Uhm+q68KuOmZ0Q6LiiifEQoR1kT+iZ95DWMdX4Hv+Bo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcF7aXap206FVIt7GlK3qKcGpqGTIoFNX2z7GU u1Nm4/TBNSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXBe2gAKCRCPgPtYfRL+ TpvgB/0cOEpYBUUvXRss+HJSfGXTkadd3rncFi/gmH653DiY9wC/wRXN9OSTAZaEZmL7dpOT8ui 3hRLTgIoZXHQoU1XZHEwoIpardI1GZwUkCU4FmjL/eBI1xq/7tbDoggBEE6UKgr9r7ioKVpxVHo F1DoXyJ1kMtAS2nLFcPnWudw5VJ2t/OWvxYiv0vkWn82OAlkWlcN4ZRcKMFK/yW2n8l7EUda8VG iyvM5fZnmkeBnr4yisR5s65Jztqd8tiDeS6OFHt3Vzlea0YtxDLGOoJtJqSUNu7NyARoktCpmom /4wFbHu2MdrJDiIsRhWolf9mQm3lh5/fBJHKwzV2tHgfJjW6
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-lp3943 driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-lp3943.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-lp3943.c b/drivers/pwm/pwm-lp3943.c
index 32350a357278..61189cea1046 100644
--- a/drivers/pwm/pwm-lp3943.c
+++ b/drivers/pwm/pwm-lp3943.c
@@ -20,7 +20,6 @@
 #define LP3943_MAX_PERIOD		1600000
 
 struct lp3943_pwm {
-	struct pwm_chip chip;
 	struct lp3943 *lp3943;
 	struct lp3943_platform_data *pdata;
 	struct lp3943_pwm_map pwm_map[LP3943_NUM_PWMS];
@@ -28,7 +27,7 @@ struct lp3943_pwm {
 
 static inline struct lp3943_pwm *to_lp3943_pwm(struct pwm_chip *chip)
 {
-	return container_of(chip, struct lp3943_pwm, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static struct lp3943_pwm_map *
@@ -273,12 +272,14 @@ static int lp3943_pwm_parse_dt(struct device *dev,
 static int lp3943_pwm_probe(struct platform_device *pdev)
 {
 	struct lp3943 *lp3943 = dev_get_drvdata(pdev->dev.parent);
+	struct pwm_chip *chip;
 	struct lp3943_pwm *lp3943_pwm;
 	int ret;
 
-	lp3943_pwm = devm_kzalloc(&pdev->dev, sizeof(*lp3943_pwm), GFP_KERNEL);
-	if (!lp3943_pwm)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, LP3943_NUM_PWMS, sizeof(*lp3943_pwm));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	lp3943_pwm = to_lp3943_pwm(chip);
 
 	lp3943_pwm->pdata = lp3943->pdata;
 	if (!lp3943_pwm->pdata) {
@@ -292,11 +293,9 @@ static int lp3943_pwm_probe(struct platform_device *pdev)
 	}
 
 	lp3943_pwm->lp3943 = lp3943;
-	lp3943_pwm->chip.dev = &pdev->dev;
-	lp3943_pwm->chip.ops = &lp3943_pwm_ops;
-	lp3943_pwm->chip.npwm = LP3943_NUM_PWMS;
+	chip->ops = &lp3943_pwm_ops;
 
-	return devm_pwmchip_add(&pdev->dev, &lp3943_pwm->chip);
+	return devm_pwmchip_add(&pdev->dev, chip);
 }
 
 #ifdef CONFIG_OF
-- 
2.42.0


