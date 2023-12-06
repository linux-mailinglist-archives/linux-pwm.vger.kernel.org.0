Return-Path: <linux-pwm+bounces-396-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91863806EC8
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B38BB20DD3
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13F1347C4;
	Wed,  6 Dec 2023 11:49:01 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFBD1A5
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:43 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOP-0007f7-38; Wed, 06 Dec 2023 12:48:41 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOM-00Dwxo-P0; Wed, 06 Dec 2023 12:48:38 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOM-00FR3G-GF; Wed, 06 Dec 2023 12:48:38 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	linux-pwm@vger.kernel.org
Subject: [PATCH v4 102/115] pwm: twl: Make use of devm_pwmchip_alloc() function
Date: Wed,  6 Dec 2023 12:44:56 +0100
Message-ID:  <06024f96bcfca72e583b74dda5252ce522534ec8.1701860672.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1858; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=NWYhr+UmvpOiLIzUoxSny6nc7hSqXndE5QHWmRTeC2I=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcF9BYPMGEtwR9iNVtKmrucWpL6wBaGtgPj4lK GhfqkQacw6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXBfQQAKCRCPgPtYfRL+ ToVXCAChqhV4jt+yOy3xPQdj95Z0KdwTwCGcJOx+eDScsKQrBHeTDJxRqaN9Jb5HrE7+/HzOXSq qg7e99LzmP7heatxmkR0i+bdyodYd8t6NV6YlS7cGiJ+R0HfSl3xno1vxbPl5jBH0uPaETjpXrY 5kWye7gdtimCRHznSk2wQiUuXEAcPY1bC5A/RnzE9kLaXvX9jD8HwgV5EUYCUa5ZKxe+lfAAtQ8 N30WXE9zB7mK3JP8EIJgCyYF/PB/do8AJ94QcU2OhX9dE+S6Hg/WECftum6tHFhwhTPYYpIVixS 74ICHhmxoBp8DLKccmRAXj1MhZdqYY1+67tjlzRpASNH77WX
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-twol driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-twl.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-twl.c b/drivers/pwm/pwm-twl.c
index 7233ae039bdb..8f981ffff4b4 100644
--- a/drivers/pwm/pwm-twl.c
+++ b/drivers/pwm/pwm-twl.c
@@ -46,7 +46,6 @@
 #define TWL6030_PWM_TOGGLE(pwm, x)	((x) << (pwm * 3))
 
 struct twl_pwm_chip {
-	struct pwm_chip chip;
 	struct mutex mutex;
 	u8 twl6030_toggle3;
 	u8 twl4030_pwm_mux;
@@ -54,7 +53,7 @@ struct twl_pwm_chip {
 
 static inline struct twl_pwm_chip *to_twl(struct pwm_chip *chip)
 {
-	return container_of(chip, struct twl_pwm_chip, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static int twl_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -341,23 +340,22 @@ static const struct pwm_ops twl6030_pwm_ops = {
 
 static int twl_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct twl_pwm_chip *twl;
 
-	twl = devm_kzalloc(&pdev->dev, sizeof(*twl), GFP_KERNEL);
-	if (!twl)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 2, sizeof(*twl));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	twl = to_twl(chip);
 
 	if (twl_class_is_4030())
-		twl->chip.ops = &twl4030_pwm_ops;
+		chip->ops = &twl4030_pwm_ops;
 	else
-		twl->chip.ops = &twl6030_pwm_ops;
-
-	twl->chip.dev = &pdev->dev;
-	twl->chip.npwm = 2;
+		chip->ops = &twl6030_pwm_ops;
 
 	mutex_init(&twl->mutex);
 
-	return devm_pwmchip_add(&pdev->dev, &twl->chip);
+	return devm_pwmchip_add(&pdev->dev, chip);
 }
 
 #ifdef CONFIG_OF
-- 
2.42.0


