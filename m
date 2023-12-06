Return-Path: <linux-pwm+bounces-353-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18295806E94
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 499551C20A59
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F9E35880;
	Wed,  6 Dec 2023 11:48:48 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9805D44
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:35 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOE-0006bz-Cx; Wed, 06 Dec 2023 12:48:30 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOD-00DwuZ-46; Wed, 06 Dec 2023 12:48:29 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOC-00FQzo-R3; Wed, 06 Dec 2023 12:48:28 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-pwm@vger.kernel.org
Subject: [PATCH v4 051/115] pwm: bcm-kona: Make use of devm_pwmchip_alloc() function
Date: Wed,  6 Dec 2023 12:44:05 +0100
Message-ID:  <cfb00ea7ffee8f8ce83de9681e3a63d60bc6c500.1701860672.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2122; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=hE+mDzU7I2OUm1id+pRQvMIHcjGYPzxgC/vxiTb6ois=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcF6cA28qwnVOBf+F+B9XoxsbE4+/p6ihpE2ql uhA6N4R2/aJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXBenAAKCRCPgPtYfRL+ ThpuCAC4+r9SOryGAxYZqBKtKyCxy2Ipka+GxdBK1xq+khWb85tS71AhIpQiOu4JpVKoalVQgMv fYm5c3N1ZIDkIuDtJeaYVz8tWoewZifFjHidz9k9/U3ZFsiHiQjODE0Ow9KpnCeNyrPWz1tFRcr 0jNcbXUBwJvlfPL6HagI/ROANRtvbLJcZJIevGnyqLU1R+Eu3NClWPRzIWpWmweo8+ofFEYha7c SCsXjcTkf15tk215cYiFOTBOlLW0N/04ydHosn9SS+QDe7juGWIug+x5U6vhJqAxiDTdTPnqmNN 90DP4lPeqX4+mHI+4skEXQ7bxULGnJUSLR9njfeLzXOs0A9O
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-bcm-kona driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-bcm-kona.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-bcm-kona.c b/drivers/pwm/pwm-bcm-kona.c
index 47acae8d7478..91eab525aedd 100644
--- a/drivers/pwm/pwm-bcm-kona.c
+++ b/drivers/pwm/pwm-bcm-kona.c
@@ -56,14 +56,13 @@
 #define DUTY_CYCLE_HIGH_MAX			0x00ffffff
 
 struct kona_pwmc {
-	struct pwm_chip chip;
 	void __iomem *base;
 	struct clk *clk;
 };
 
 static inline struct kona_pwmc *to_kona_pwmc(struct pwm_chip *chip)
 {
-	return container_of(chip, struct kona_pwmc, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 /*
@@ -273,18 +272,18 @@ static const struct pwm_ops kona_pwm_ops = {
 
 static int kona_pwmc_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct kona_pwmc *kp;
 	unsigned int chan;
 	unsigned int value = 0;
 	int ret = 0;
 
-	kp = devm_kzalloc(&pdev->dev, sizeof(*kp), GFP_KERNEL);
-	if (kp == NULL)
+	chip = devm_pwmchip_alloc(&pdev->dev, 6, sizeof(*kp));
+	if (chip == NULL)
 		return -ENOMEM;
+	kp = to_kona_pwmc(chip);
 
-	kp->chip.dev = &pdev->dev;
-	kp->chip.ops = &kona_pwm_ops;
-	kp->chip.npwm = 6;
+	chip->ops = &kona_pwm_ops;
 
 	kp->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(kp->base))
@@ -304,14 +303,14 @@ static int kona_pwmc_probe(struct platform_device *pdev)
 	}
 
 	/* Set push/pull for all channels */
-	for (chan = 0; chan < kp->chip.npwm; chan++)
+	for (chan = 0; chan < chip->npwm; chan++)
 		value |= (1 << PWM_CONTROL_TYPE_SHIFT(chan));
 
 	writel(value, kp->base + PWM_CONTROL_OFFSET);
 
 	clk_disable_unprepare(kp->clk);
 
-	ret = devm_pwmchip_add(&pdev->dev, &kp->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0)
 		dev_err(&pdev->dev, "failed to add PWM chip: %d\n", ret);
 
-- 
2.42.0


