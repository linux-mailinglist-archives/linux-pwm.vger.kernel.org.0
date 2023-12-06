Return-Path: <linux-pwm+bounces-351-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD74806E9A
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2171B20DE1
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6C234CF4;
	Wed,  6 Dec 2023 11:48:48 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84094D72
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:34 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOD-0006ZN-Ng; Wed, 06 Dec 2023 12:48:29 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOC-00DwuR-QS; Wed, 06 Dec 2023 12:48:28 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOC-00FQzg-H5; Wed, 06 Dec 2023 12:48:28 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	linux-pwm@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 049/115] pwm: bcm2835: Make use of devm_pwmchip_alloc() function
Date: Wed,  6 Dec 2023 12:44:03 +0100
Message-ID:  <237e4923fbc4e78e30fb4103b584557ac43a2458.1701860672.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2030; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=3HJ0Pbjomc2qLgbU80jfmvd9E4mLKNQSk//ghXZNiWI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcF6aTJO42ldOoRbo7Qeurk5gIk5AyGFCqJ2lm Psn+nGMSXaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXBemgAKCRCPgPtYfRL+ ThZvB/4oB9tNHbpvjo3o7cnjwVrFsTwmTw1KPh5NzrI+LRFqgcH7RQc0I8egtDMqgideDjX7656 Zb+IkQk29py6rUBo71oWM6XvQPmlaFOa5leXnv/fN8+7r6ikQ5b2BeJRXlMa1HV4K6JwmEZZ3dq OrslI8+tluMDziyEmSClgKvlRQc2kwJyTslTH2qDma4YHV6PxEe7YQiGAUQAQZjZD6/10u6geWk BEKtM34ubXVyM+RKukyF707X5iIJLgNN3al1c9GINe0wHBQn9JKB81NmsCIyHh01V+YoSdCvygH rWd2dkYdOF3asc2DjHwcBTo3XXIlfZhk79TL8zdXwi7gIhjV
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-bcm2835 driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-bcm2835.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
index ab30667f4f95..826f0494dc5f 100644
--- a/drivers/pwm/pwm-bcm2835.c
+++ b/drivers/pwm/pwm-bcm2835.c
@@ -24,7 +24,6 @@
 #define PERIOD_MIN		0x2
 
 struct bcm2835_pwm {
-	struct pwm_chip chip;
 	struct device *dev;
 	void __iomem *base;
 	struct clk *clk;
@@ -32,7 +31,7 @@ struct bcm2835_pwm {
 
 static inline struct bcm2835_pwm *to_bcm2835_pwm(struct pwm_chip *chip)
 {
-	return container_of(chip, struct bcm2835_pwm, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static int bcm2835_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
@@ -133,12 +132,14 @@ static const struct pwm_ops bcm2835_pwm_ops = {
 
 static int bcm2835_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct bcm2835_pwm *pc;
 	int ret;
 
-	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
-	if (!pc)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 2, sizeof(*pc));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	pc = to_bcm2835_pwm(chip);
 
 	pc->dev = &pdev->dev;
 
@@ -151,13 +152,11 @@ static int bcm2835_pwm_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(pc->clk),
 				     "clock not found\n");
 
-	pc->chip.dev = &pdev->dev;
-	pc->chip.ops = &bcm2835_pwm_ops;
-	pc->chip.npwm = 2;
+	chip->ops = &bcm2835_pwm_ops;
 
 	platform_set_drvdata(pdev, pc);
 
-	ret = devm_pwmchip_add(&pdev->dev, &pc->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0)
 		return dev_err_probe(&pdev->dev, ret,
 				     "failed to add pwmchip\n");
-- 
2.42.0


