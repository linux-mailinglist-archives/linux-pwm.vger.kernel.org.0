Return-Path: <linux-pwm+bounces-305-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5090806E4F
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91EC728199F
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B00E2DF65;
	Wed,  6 Dec 2023 11:48:27 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E5218D
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:23 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqO5-0005yQ-H3; Wed, 06 Dec 2023 12:48:21 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqO4-00DwrS-VU; Wed, 06 Dec 2023 12:48:20 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqO4-00FQwZ-M9; Wed, 06 Dec 2023 12:48:20 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	linux-pwm@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v4 002/115] pwm: crc: Use consistent variable naming for driver data
Date: Wed,  6 Dec 2023 12:43:16 +0100
Message-ID:  <628ab3ffd95306bb697c5f2ee0ff5abc1d987870.1701860672.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1762; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=IaLDIhayzDamEHQOnzIsO80oYzoddxnRmfJJqdexG/s=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcF5UhbTBnFVPIFeqMnnBWH1n6Awzwr0UTo+OI tvbzAd/t+aJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXBeVAAKCRCPgPtYfRL+ TrFFB/43kfIoi2Ldzrc6LdGI+N7qsdyb6ZH3C9quPSflvYhL0xIuYWVMbdjn2VoLV5/MuR+aLdf PVRs7kpMP9c/HwAAdfsuwhW9ZIMIErJnCv9KCOgCI/CdfALr9+N9EtbCbYy6/8d30RKex3fytDw eJbJB6XgqD7jbOxzNcBZ+R+HAnD6f4xPcU0wKQtnxU5HfH07L7ub1hota0OML5+epvD8fnPL3C8 gtgzbdXt25pnQ1GYiDdEa+rPtACd0lw8KV1ZhHu6eHGNbeVnMd4Rwq2QAWYxuxBACgLGclQXjg3 n9OScSPC9A90KD8yZ1DChBqVqkek1xewvPmmuIiDc7ebka0v
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

All but one local variable of type pointer to struct crystalcove_pwm are
called "crc_pwm", the one outlier is called "pwm" which is usually
reserved for variables of type pointer to struct pwm_device.

So rename that one "pwm" to "crc_pwm" for consistency.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Note this patch was already sent out individually, find it at
https://lore.kernel.org/linux-pwm/20231130074133.969806-1-u.kleine-koenig@pengutronix.de

 drivers/pwm/pwm-crc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-crc.c b/drivers/pwm/pwm-crc.c
index 2b0b659eee97..e09358901ab5 100644
--- a/drivers/pwm/pwm-crc.c
+++ b/drivers/pwm/pwm-crc.c
@@ -160,22 +160,22 @@ static const struct pwm_ops crc_pwm_ops = {
 
 static int crystalcove_pwm_probe(struct platform_device *pdev)
 {
-	struct crystalcove_pwm *pwm;
+	struct crystalcove_pwm *crc_pwm;
 	struct device *dev = pdev->dev.parent;
 	struct intel_soc_pmic *pmic = dev_get_drvdata(dev);
 
-	pwm = devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
-	if (!pwm)
+	crc_pwm = devm_kzalloc(&pdev->dev, sizeof(*crc_pwm), GFP_KERNEL);
+	if (!crc_pwm)
 		return -ENOMEM;
 
-	pwm->chip.dev = &pdev->dev;
-	pwm->chip.ops = &crc_pwm_ops;
-	pwm->chip.npwm = 1;
+	crc_pwm->chip.dev = &pdev->dev;
+	crc_pwm->chip.ops = &crc_pwm_ops;
+	crc_pwm->chip.npwm = 1;
 
 	/* get the PMIC regmap */
-	pwm->regmap = pmic->regmap;
+	crc_pwm->regmap = pmic->regmap;
 
-	return devm_pwmchip_add(&pdev->dev, &pwm->chip);
+	return devm_pwmchip_add(&pdev->dev, &crc_pwm->chip);
 }
 
 static struct platform_driver crystalcove_pwm_driver = {
-- 
2.42.0


