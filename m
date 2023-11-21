Return-Path: <linux-pwm+bounces-58-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D61C97F2F92
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A63DB20CEA
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99A353801;
	Tue, 21 Nov 2023 13:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35AA010CF
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:52:03 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAV-0005ls-W4; Tue, 21 Nov 2023 14:52:00 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAT-00Ab09-2s; Tue, 21 Nov 2023 14:51:57 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAS-004xet-Q6; Tue, 21 Nov 2023 14:51:56 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v3 060/108] pwm: intel-lgm: Make use of devm_pwmchip_alloc() function
Date: Tue, 21 Nov 2023 14:50:02 +0100
Message-ID: <20231121134901.208535-61-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2022; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=IlzO9q5gGaNbUx8/J+aDP10e/8Rhqg+jg/m99dCsS+A=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXLWOpRMXvN4RFEofDwTzgnPcCd3HTEsSUPhsz 3xI05kyywyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVy1jgAKCRCPgPtYfRL+ Tr71B/9w22Mq3ZxdkJxZsw0QDaFpChtGJMb5NkK+N5LjDgFZD/t5a4REwb6p5f4fMvO17+PuZTz eorWWFBn5jYkCypmKSJi++p3A6J4XalLENTCLD9iHnt0jn3e+KmQ1fSuQRMIyuSkhYwjuH57NrV cV8uswQP/FJz+/wiLs/LX3asuYCiYgA7P5iGZQwaBGTCHzfNjZqDov6M2KbLfRAJqdgVs8rHK8k mGgD7keJS4weMUFQ8wcPFVu7eNWBgjnPvanSE7S+fVxpK3+bAWwFJwId7U/+THIOa82l0JJo48S GYVyG4iydho/qgrAmQ0t2goIo3uVHmwgxND+S5+q8URwOQMK
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-intel-lgm driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-intel-lgm.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-intel-lgm.c b/drivers/pwm/pwm-intel-lgm.c
index 54ecae7f937e..9abd8859f869 100644
--- a/drivers/pwm/pwm-intel-lgm.c
+++ b/drivers/pwm/pwm-intel-lgm.c
@@ -42,14 +42,13 @@
 #define LGM_PWM_PERIOD_2WIRE_NS		(40 * NSEC_PER_MSEC)
 
 struct lgm_pwm_chip {
-	struct pwm_chip chip;
 	struct regmap *regmap;
 	u32 period;
 };
 
 static inline struct lgm_pwm_chip *to_lgm_pwm_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct lgm_pwm_chip, chip);
+	return pwmchip_priv(chip);
 }
 
 static int lgm_pwm_enable(struct pwm_chip *chip, bool enable)
@@ -168,14 +167,16 @@ static int lgm_pwm_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct reset_control *rst;
+	struct pwm_chip *chip;
 	struct lgm_pwm_chip *pc;
 	void __iomem *io_base;
 	struct clk *clk;
 	int ret;
 
-	pc = devm_kzalloc(dev, sizeof(*pc), GFP_KERNEL);
-	if (!pc)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(dev, 1, sizeof(*pc));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	pc = to_lgm_pwm_chip(chip);
 
 	io_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(io_base))
@@ -203,13 +204,11 @@ static int lgm_pwm_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "cannot deassert reset control\n");
 
-	pc->chip.dev = dev;
-	pc->chip.ops = &lgm_pwm_ops;
-	pc->chip.npwm = 1;
+	chip->ops = &lgm_pwm_ops;
 
 	lgm_pwm_init(pc);
 
-	ret = devm_pwmchip_add(dev, &pc->chip);
+	ret = devm_pwmchip_add(dev, chip);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "failed to add PWM chip\n");
 
-- 
2.42.0


