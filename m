Return-Path: <linux-pwm+bounces-98-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 579CB7F2FB3
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88CF91C21171
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DB953806;
	Tue, 21 Nov 2023 13:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB9210C9
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:52:11 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAe-0006bo-7h; Tue, 21 Nov 2023 14:52:08 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAc-00Ab2l-Bk; Tue, 21 Nov 2023 14:52:06 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAc-004xhd-2a; Tue, 21 Nov 2023 14:52:06 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andy Shevchenko <andy@kernel.org>,
	linux-pwm@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v3 100/108] gpio: mvebu: Make use of devm_pwmchip_alloc() function
Date: Tue, 21 Nov 2023 14:50:42 +0100
Message-ID: <20231121134901.208535-101-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2210; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=ugjUR8exm8noRxmIpIoaJQsZ9p7zPq78hm2bvymO4xA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXLW6fLDlWZcoq4++4kBxRcR0Fk2zNt3nsKBUq iH0QDXmt3CJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVy1ugAKCRCPgPtYfRL+ TjdUCACoB7IEvn8W4YQaaiHm1pfoH1/wfFZTdRG1+tYZjFGRAJKsg2foaMGz1WdTuNoDBi/0qwa ZSJSKyYWtI2d8wNwLxNRCmm9FZn+BkEQZdC8yJwXjAkAJbPOZr6z2FyY2CaTz7PzEmwwxzYZGoU UFPJhutLPuOX+DE3tOtpp+yzFyjMBqzAx/jlSkmDXZ/BEtnF+yVHi8fvRkcbs9m9RCh3Hw1vajo ATWIrORAy88PWRNXTwjaRlhgHqmnd2W9iS+t2XcCU/xsKx62xatK10dpnXueMEu45CiVIAtbmBM lC8Kwi36U9RvXPh2lOC+z6TzXivkoVuphoQgzRjDpY5iAg5O
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
 drivers/gpio/gpio-mvebu.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index a13f3c18ccd4..02c8382b4dd2 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -99,7 +99,6 @@ struct mvebu_pwm {
 	u32			 offset;
 	unsigned long		 clk_rate;
 	struct gpio_desc	*gpiod;
-	struct pwm_chip		 chip;
 	spinlock_t		 lock;
 	struct mvebu_gpio_chip	*mvchip;
 
@@ -615,7 +614,7 @@ static const struct regmap_config mvebu_gpio_regmap_config = {
  */
 static struct mvebu_pwm *to_mvebu_pwm(struct pwm_chip *chip)
 {
-	return container_of(chip, struct mvebu_pwm, chip);
+	return pwmchip_priv(chip);
 }
 
 static int mvebu_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
@@ -789,6 +788,7 @@ static int mvebu_pwm_probe(struct platform_device *pdev,
 {
 	struct device *dev = &pdev->dev;
 	struct mvebu_pwm *mvpwm;
+	struct pwm_chip *chip;
 	void __iomem *base;
 	u32 offset;
 	u32 set;
@@ -813,9 +813,11 @@ static int mvebu_pwm_probe(struct platform_device *pdev,
 	if (IS_ERR(mvchip->clk))
 		return PTR_ERR(mvchip->clk);
 
-	mvpwm = devm_kzalloc(dev, sizeof(struct mvebu_pwm), GFP_KERNEL);
-	if (!mvpwm)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(dev, mvchip->chip.ngpio, sizeof(struct mvebu_pwm));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	mvpwm = pwmchip_priv(chip);
+
 	mvchip->mvpwm = mvpwm;
 	mvpwm->mvchip = mvchip;
 	mvpwm->offset = offset;
@@ -868,13 +870,11 @@ static int mvebu_pwm_probe(struct platform_device *pdev,
 		return -EINVAL;
 	}
 
-	mvpwm->chip.dev = dev;
-	mvpwm->chip.ops = &mvebu_pwm_ops;
-	mvpwm->chip.npwm = mvchip->chip.ngpio;
+	chip->ops = &mvebu_pwm_ops;
 
 	spin_lock_init(&mvpwm->lock);
 
-	return devm_pwmchip_add(dev, &mvpwm->chip);
+	return devm_pwmchip_add(dev, chip);
 }
 
 #ifdef CONFIG_DEBUG_FS
-- 
2.42.0


