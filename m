Return-Path: <linux-pwm+bounces-199-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 301327F85A7
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Nov 2023 22:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C79BBB211E0
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Nov 2023 21:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FAD3BB20;
	Fri, 24 Nov 2023 21:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DDC199A
	for <linux-pwm@vger.kernel.org>; Fri, 24 Nov 2023 13:52:22 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r6e5z-0002dQ-6L; Fri, 24 Nov 2023 22:52:19 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r6e5y-00BLvz-PL; Fri, 24 Nov 2023 22:52:18 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r6e5y-007hOj-GD; Fri, 24 Nov 2023 22:52:18 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-pwm@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 3/3] leds: qcom-lpg: Make use of devm_pwmchip_alloc() function
Date: Fri, 24 Nov 2023 22:52:12 +0100
Message-ID: <20231124215208.616551-4-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1915; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=woA0AJPcUq0UVfEIvVWJezHMyKdMpUGoPgZWt4kfjy8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlYRsMm04ZFKioox2xibCUsNikDujcI2KTqiZIr lrrgSej91mJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZWEbDAAKCRCPgPtYfRL+ ThVYB/9I+6tlmeoiTe3088RznCg1f1EFO8OvhVRnJgYvL3NJfrHBOcbs0tgBP4j2LDajJhvO4o4 3BjRZ7JspJoYpK0SIBMnhFu+HW5a5//vv4RKcjxZz1mQDCh7/QXNygQ6jGt05hNrye7aVjg4jvN fEdZKqim0xwLLi5SOVoex1esx3xZiTwlARTTPeis+gdkiZOSkY8KAWg1CQgASikRKGgN8iSOLc1 pJf8f7Kvm/YH2Fft+JwLzT5CXMQuFsunfqIug/CCs4bLw+ZgTPSAdPq/26SaBfbvmmJo7M8ZwvQ FjDJ23vdMKQEZyeyL3S2ZmHYgLsWYm+i1EMqKBIYrjxOlU01
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm sub-driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/leds/rgb/leds-qcom-lpg.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
index c523f3c0cdb1..81ebc23fd2f4 100644
--- a/drivers/leds/rgb/leds-qcom-lpg.c
+++ b/drivers/leds/rgb/leds-qcom-lpg.c
@@ -77,7 +77,7 @@ struct lpg {
 
 	struct mutex lock;
 
-	struct pwm_chip pwm;
+	struct pwm_chip *pwm;
 
 	const struct lpg_data *data;
 
@@ -979,7 +979,7 @@ static int lpg_pattern_mc_clear(struct led_classdev *cdev)
 
 static inline struct lpg *lpg_pwm_from_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct lpg, pwm);
+	return pwmchip_get_drvdata(chip);
 }
 
 static int lpg_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
@@ -1094,13 +1094,17 @@ static const struct pwm_ops lpg_pwm_ops = {
 
 static int lpg_add_pwm(struct lpg *lpg)
 {
+	struct pwm_chip *chip;
 	int ret;
 
-	lpg->pwm.dev = lpg->dev;
-	lpg->pwm.npwm = lpg->num_channels;
-	lpg->pwm.ops = &lpg_pwm_ops;
+	lpg->pwm = chip = devm_pwmchip_alloc(lpg->dev, lpg->num_channels, 0);
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
 
-	ret = pwmchip_add(&lpg->pwm);
+	chip->ops = &lpg_pwm_ops;
+	pwmchip_set_drvdata(chip, lpg);
+
+	ret = pwmchip_add(chip);
 	if (ret)
 		dev_err(lpg->dev, "failed to add PWM chip: ret %d\n", ret);
 
@@ -1372,7 +1376,7 @@ static void lpg_remove(struct platform_device *pdev)
 {
 	struct lpg *lpg = platform_get_drvdata(pdev);
 
-	pwmchip_remove(&lpg->pwm);
+	pwmchip_remove(lpg->pwm);
 }
 
 static const struct lpg_data pm8916_pwm_data = {
-- 
2.42.0


