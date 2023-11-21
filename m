Return-Path: <linux-pwm+bounces-83-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0CA7F2FA9
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BD7C1C218DC
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F385153805;
	Tue, 21 Nov 2023 13:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994701700
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:52:08 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAc-0006Xb-KF; Tue, 21 Nov 2023 14:52:06 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAb-00Ab2T-8q; Tue, 21 Nov 2023 14:52:05 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAa-004xhN-W8; Tue, 21 Nov 2023 14:52:05 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v3 096/108] pwm: twl: Make use of devm_pwmchip_alloc() function
Date: Tue, 21 Nov 2023 14:50:38 +0100
Message-ID: <20231121134901.208535-97-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1851; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=mV+FFikCiI0EGP6Lsp4dGIMRO80FE3i6GifvqG2Vx7I=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXLW2s2KJ9YJQ19Q5ZduRoZZkAgWDUG6JCY8eV FkZKpWub4eJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVy1tgAKCRCPgPtYfRL+ TnKJCACcVipYvWz33BnzM9vqgtYZpFnskdXacguibzzW46QL4Ft0P5oGVt9yz/lQSS8y17KsMgv Z/JJbDMa57WQRGNaw3lX0FeDcxrxU4mSzUHPDL2AdzUk4CdsFkSYeNdv5WOrUdJkJfJDeD3Yppx A8baaJqc8VH1/BjkxlzHSXbH1kfyJxDgcfvwHMoQR+s7l4d8JMhTgHNF8pEv2mExgbpBfQwJO0c SHl5xdtOiiG6J6ohefv9X/j0VcshkbhhEIxIKDfck9kLYxmhdtSB8hyfO7b3UstMxD0xjVgvci+ BvGv2H6QaGl3Tf1KsvWOAN0EA1/Y5g/PGzP1aoFNkgMnP/gl
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
index 073c107964f6..7f9d79a7372d 100644
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
+	return pwmchip_priv(chip);
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


