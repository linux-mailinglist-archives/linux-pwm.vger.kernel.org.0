Return-Path: <linux-pwm+bounces-51-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC517F2F83
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0702F1F243E0
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D2C53801;
	Tue, 21 Nov 2023 13:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332EBD6D
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:52:02 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAV-0005dC-06; Tue, 21 Nov 2023 14:51:59 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAR-00Aazq-Qh; Tue, 21 Nov 2023 14:51:55 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAR-004xeO-Hs; Tue, 21 Nov 2023 14:51:55 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v3 055/108] pwm: hibvt: Make use of devm_pwmchip_alloc() function
Date: Tue, 21 Nov 2023 14:49:57 +0100
Message-ID: <20231121134901.208535-56-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2992; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=H8zUpd6JrWoh58k1PJzTBVEr8mAeOolpVMPZzRPQkW4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXLWJYb4h8jwQJCnspKFkQEMn6J4OChghJ5tAV Qu9Cixb8BGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVy1iQAKCRCPgPtYfRL+ TmuHB/96R7lYiqeMDZ5jIEYcqFhjo9nnpLM1zXMyr7umY5NjYOztcE0spieQB4eRtzOuEs7lHex TkOnXdqB+p2JdxJrBG2AFsZSwsU8t4Enj7sEuaBZDo5XmQRiOqKHph706ixDxEa79euJ/wpWgrS +QY9tgxCurhDOoirbL4FNG4SGcMYHkGSmFu8aWZfVILXwhZyQFyubpTm8jcfvvPVvkugAcvhW/k 36izWmTZqOXX99glHGhMzw7goPp/St1hgy5UnBTHgOpEzU6S0xfwx/9211uWtaHgAele4KvTu/v yDDUf3aBY6gQlc1Gl8xW1xe+KnD12L2nCvthlbvOYZ5gBjfI
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-hibvt driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-hibvt.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/pwm/pwm-hibvt.c b/drivers/pwm/pwm-hibvt.c
index c435776e2f78..60be59ce4320 100644
--- a/drivers/pwm/pwm-hibvt.c
+++ b/drivers/pwm/pwm-hibvt.c
@@ -33,7 +33,6 @@
 #define PWM_DUTY_MASK       GENMASK(31, 0)
 
 struct hibvt_pwm_chip {
-	struct pwm_chip	chip;
 	struct clk *clk;
 	void __iomem *base;
 	struct reset_control *rstc;
@@ -65,7 +64,7 @@ static const struct hibvt_pwm_soc hi3559v100_soc_info = {
 
 static inline struct hibvt_pwm_chip *to_hibvt_pwm_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct hibvt_pwm_chip, chip);
+	return pwmchip_priv(chip);
 }
 
 static void hibvt_pwm_set_bits(void __iomem *base, u32 offset,
@@ -191,12 +190,14 @@ static int hibvt_pwm_probe(struct platform_device *pdev)
 {
 	const struct hibvt_pwm_soc *soc =
 				of_device_get_match_data(&pdev->dev);
+	struct pwm_chip	*chip;
 	struct hibvt_pwm_chip *pwm_chip;
 	int ret, i;
 
-	pwm_chip = devm_kzalloc(&pdev->dev, sizeof(*pwm_chip), GFP_KERNEL);
-	if (pwm_chip == NULL)
+	chip = devm_pwmchip_alloc(&pdev->dev, soc->num_pwms, sizeof(*pwm_chip));
+	if (chip == NULL)
 		return -ENOMEM;
+	pwm_chip = to_hibvt_pwm_chip(chip);
 
 	pwm_chip->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(pwm_chip->clk)) {
@@ -205,9 +206,7 @@ static int hibvt_pwm_probe(struct platform_device *pdev)
 		return PTR_ERR(pwm_chip->clk);
 	}
 
-	pwm_chip->chip.ops = &hibvt_pwm_ops;
-	pwm_chip->chip.dev = &pdev->dev;
-	pwm_chip->chip.npwm = soc->num_pwms;
+	chip->ops = &hibvt_pwm_ops;
 	pwm_chip->soc = soc;
 
 	pwm_chip->base = devm_platform_ioremap_resource(pdev, 0);
@@ -228,29 +227,31 @@ static int hibvt_pwm_probe(struct platform_device *pdev)
 	msleep(30);
 	reset_control_deassert(pwm_chip->rstc);
 
-	ret = pwmchip_add(&pwm_chip->chip);
+	ret = pwmchip_add(chip);
 	if (ret < 0) {
 		clk_disable_unprepare(pwm_chip->clk);
 		return ret;
 	}
 
-	for (i = 0; i < pwm_chip->chip.npwm; i++) {
+	for (i = 0; i < chip->npwm; i++) {
 		hibvt_pwm_set_bits(pwm_chip->base, PWM_CTRL_ADDR(i),
 				PWM_KEEP_MASK, (0x1 << PWM_KEEP_SHIFT));
 	}
 
-	platform_set_drvdata(pdev, pwm_chip);
+	platform_set_drvdata(pdev, chip);
 
 	return 0;
 }
 
 static void hibvt_pwm_remove(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct hibvt_pwm_chip *pwm_chip;
 
-	pwm_chip = platform_get_drvdata(pdev);
+	chip = platform_get_drvdata(pdev);
+	pwm_chip = to_hibvt_pwm_chip(chip);
 
-	pwmchip_remove(&pwm_chip->chip);
+	pwmchip_remove(chip);
 
 	reset_control_assert(pwm_chip->rstc);
 	msleep(30);
-- 
2.42.0


