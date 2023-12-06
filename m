Return-Path: <linux-pwm+bounces-343-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F76806E86
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AE0AB20E66
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D45347AD;
	Wed,  6 Dec 2023 11:48:45 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965EFD4E
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:33 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOD-0006an-W4; Wed, 06 Dec 2023 12:48:30 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOC-00DwuW-VD; Wed, 06 Dec 2023 12:48:28 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOC-00FQzk-M6; Wed, 06 Dec 2023 12:48:28 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 050/115] pwm: bcm-iproc: Make use of devm_pwmchip_alloc() function
Date: Wed,  6 Dec 2023 12:44:04 +0100
Message-ID:  <e15c08ae19c3cf1d95768449283dcfc87894b61f.1701860672.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2342; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=uap70kVyur3xYK64MlPXrRzr1pXX7b/SOLPcx1i72Pc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcF6b7CvF+Lbxg6UPutx7hjnlk/L7lqI0SjKob 0Y+cysTKb+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXBemwAKCRCPgPtYfRL+ TpnGB/4qyhr2/Kefy0a5PkEqmoHsElv0fpVJL4yOgSHbtVkXs75osTe/ElG3tsfiNaY5mH14SPK xYW5EMiGrJqIhfbppRALX57ZDQNQm6zSmG0q/W1uEglL+0y7HcCOEsukfMG5YLLOxiBk5d1ju7k EV25LrdF6JxTJ9FxceZFu+bzZTpQcvVvBbUPWQaEg36b/fd2vtu8rumVuJW/18WJ5YFfcYBReWh 4KTUGsfuH7xcpCn8OrBHN1WBr8g7h1LqYavXluERWra2ZuKSUfDZ74UAjHOef8Ry6Q2jphyxfL2 IR7U+XF3/imzc1FrYErv0hEtScN5N9wJw6aukLBikLzsf+dD
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-bcm-iproc driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-bcm-iproc.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-bcm-iproc.c b/drivers/pwm/pwm-bcm-iproc.c
index 758254025683..f4c9f10e490e 100644
--- a/drivers/pwm/pwm-bcm-iproc.c
+++ b/drivers/pwm/pwm-bcm-iproc.c
@@ -34,14 +34,13 @@
 #define IPROC_PWM_PRESCALE_MAX			0x3f
 
 struct iproc_pwmc {
-	struct pwm_chip chip;
 	void __iomem *base;
 	struct clk *clk;
 };
 
 static inline struct iproc_pwmc *to_iproc_pwmc(struct pwm_chip *chip)
 {
-	return container_of(chip, struct iproc_pwmc, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static void iproc_pwmc_enable(struct iproc_pwmc *ip, unsigned int channel)
@@ -187,20 +186,20 @@ static const struct pwm_ops iproc_pwm_ops = {
 
 static int iproc_pwmc_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct iproc_pwmc *ip;
 	unsigned int i;
 	u32 value;
 	int ret;
 
-	ip = devm_kzalloc(&pdev->dev, sizeof(*ip), GFP_KERNEL);
-	if (!ip)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 4, sizeof(*ip));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	ip = to_iproc_pwmc(chip);
 
 	platform_set_drvdata(pdev, ip);
 
-	ip->chip.dev = &pdev->dev;
-	ip->chip.ops = &iproc_pwm_ops;
-	ip->chip.npwm = 4;
+	chip->ops = &iproc_pwm_ops;
 
 	ip->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(ip->base))
@@ -214,14 +213,14 @@ static int iproc_pwmc_probe(struct platform_device *pdev)
 	/* Set full drive and normal polarity for all channels */
 	value = readl(ip->base + IPROC_PWM_CTRL_OFFSET);
 
-	for (i = 0; i < ip->chip.npwm; i++) {
+	for (i = 0; i < chip->npwm; i++) {
 		value &= ~(1 << IPROC_PWM_CTRL_TYPE_SHIFT(i));
 		value |= 1 << IPROC_PWM_CTRL_POLARITY_SHIFT(i);
 	}
 
 	writel(value, ip->base + IPROC_PWM_CTRL_OFFSET);
 
-	ret = devm_pwmchip_add(&pdev->dev, &ip->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0)
 		return dev_err_probe(&pdev->dev, ret,
 				     "failed to add PWM chip\n");
-- 
2.42.0


