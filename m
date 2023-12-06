Return-Path: <linux-pwm+bounces-354-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE200806E98
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68BE61F2166A
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8FE35883;
	Wed,  6 Dec 2023 11:48:48 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23053D4F
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:34 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOF-0006cx-CV; Wed, 06 Dec 2023 12:48:31 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOD-00Dwud-8c; Wed, 06 Dec 2023 12:48:29 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOC-00FQzs-W1; Wed, 06 Dec 2023 12:48:29 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	linux-pwm@vger.kernel.org
Subject: [PATCH v4 052/115] pwm: berlin: Make use of devm_pwmchip_alloc() function
Date: Wed,  6 Dec 2023 12:44:06 +0100
Message-ID:  <a560efafeb15e93e631fe35a56f01a1f67e313de.1701860672.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3286; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=ja+mYQMxmJ5DUZzostM9uvXhyP/PwqvijiPNdH0Cqp4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcF6dCnLozdL4imzmZcqWoa7seKxcRuAUAz+BA qvb4PU0GSmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXBenQAKCRCPgPtYfRL+ TqfzB/9zVf97dZOQlLZg80Mxvm6BbTymLOxopQmHpXneLklMmp3FCPfWYyvY3coebSJheIMhL60 gwIkBvGmrj/VZzTuYAVBJusiAo+YbJJ0TlF+mz9pRHupjew27B6lFC9WZjhb04KeNLjfBGofmCQ 2MqEGVTb/7D67miKwu4PxB75fRoELj4q2U7qb/bQNAEEBy4IOmGxxH7m2TPVe+7JvXgpsT5pCRO SyVv0kq6jr7FJkhVt6qKXre0t4q4dU++xkuWbjTSnRG0iZ5h5imK9gK1mD33A3xwRnVfK1TmSst 23hXxQKzcwYyq+TdymWXpkdIUNZv4gE1VMpBYbGOdIAlSodZ
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-berlin driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-berlin.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/pwm/pwm-berlin.c b/drivers/pwm/pwm-berlin.c
index 442913232dc0..831aed228caf 100644
--- a/drivers/pwm/pwm-berlin.c
+++ b/drivers/pwm/pwm-berlin.c
@@ -49,7 +49,6 @@ struct berlin_pwm_channel {
 };
 
 struct berlin_pwm_chip {
-	struct pwm_chip chip;
 	struct clk *clk;
 	void __iomem *base;
 	struct berlin_pwm_channel channel[BERLIN_PWM_NUMPWMS];
@@ -57,7 +56,7 @@ struct berlin_pwm_chip {
 
 static inline struct berlin_pwm_chip *to_berlin_pwm_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct berlin_pwm_chip, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static inline u32 berlin_pwm_readl(struct berlin_pwm_chip *bpc,
@@ -198,12 +197,14 @@ MODULE_DEVICE_TABLE(of, berlin_pwm_match);
 
 static int berlin_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct berlin_pwm_chip *bpc;
 	int ret;
 
-	bpc = devm_kzalloc(&pdev->dev, sizeof(*bpc), GFP_KERNEL);
-	if (!bpc)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, BERLIN_PWM_NUMPWMS, sizeof(*bpc));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	bpc = to_berlin_pwm_chip(chip);
 
 	bpc->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(bpc->base))
@@ -213,25 +214,24 @@ static int berlin_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(bpc->clk))
 		return PTR_ERR(bpc->clk);
 
-	bpc->chip.dev = &pdev->dev;
-	bpc->chip.ops = &berlin_pwm_ops;
-	bpc->chip.npwm = BERLIN_PWM_NUMPWMS;
+	chip->ops = &berlin_pwm_ops;
 
-	ret = devm_pwmchip_add(&pdev->dev, &bpc->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0)
 		return dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
 
-	platform_set_drvdata(pdev, bpc);
+	platform_set_drvdata(pdev, chip);
 
 	return 0;
 }
 
 static int berlin_pwm_suspend(struct device *dev)
 {
-	struct berlin_pwm_chip *bpc = dev_get_drvdata(dev);
+	struct pwm_chip *chip = dev_get_drvdata(dev);
+	struct berlin_pwm_chip *bpc = to_berlin_pwm_chip(chip);
 	unsigned int i;
 
-	for (i = 0; i < bpc->chip.npwm; i++) {
+	for (i = 0; i < chip->npwm; i++) {
 		struct berlin_pwm_channel *channel = &bpc->channel[i];
 
 		channel->enable = berlin_pwm_readl(bpc, i, BERLIN_PWM_ENABLE);
@@ -247,7 +247,8 @@ static int berlin_pwm_suspend(struct device *dev)
 
 static int berlin_pwm_resume(struct device *dev)
 {
-	struct berlin_pwm_chip *bpc = dev_get_drvdata(dev);
+	struct pwm_chip *chip = dev_get_drvdata(dev);
+	struct berlin_pwm_chip *bpc = to_berlin_pwm_chip(chip);
 	unsigned int i;
 	int ret;
 
@@ -255,7 +256,7 @@ static int berlin_pwm_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	for (i = 0; i < bpc->chip.npwm; i++) {
+	for (i = 0; i < chip->npwm; i++) {
 		struct berlin_pwm_channel *channel = &bpc->channel[i];
 
 		berlin_pwm_writel(bpc, i, channel->ctrl, BERLIN_PWM_CONTROL);
-- 
2.42.0


