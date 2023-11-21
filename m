Return-Path: <linux-pwm+bounces-99-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E80EC7F2FB7
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D64C1F24464
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028F953810;
	Tue, 21 Nov 2023 13:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2421704
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:52:09 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAc-0006RC-9q; Tue, 21 Nov 2023 14:52:06 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAa-00Ab29-6e; Tue, 21 Nov 2023 14:52:04 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAZ-004xh7-Tx; Tue, 21 Nov 2023 14:52:03 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Hammer Hsieh <hammerh0314@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v3 092/108] pwm: sunplus: Make use of devm_pwmchip_alloc() function
Date: Tue, 21 Nov 2023 14:50:34 +0100
Message-ID: <20231121134901.208535-93-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1953; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=bs9mFTxGeJpLT/z8UrAL+8cfArkIwcPmeyWmFstIrUY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXLWxFVRCLx8FGervCfWy5pFe3t0j6iw+9cIl/ SyBWdMKIKyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVy1sQAKCRCPgPtYfRL+ Tk0bB/9zyjfsFjVLse8gNoYpBycrzf6bxP2slw7QZ1l0sZQs8WQ9S3SE0z7S7kxyv6qi2SstjEZ WUULvZtQ412AY/7aKiHrNx9OS4qW3FFG57OXOx+jXrBA9xihWNUCB/KkhGvJuLe0SD1/2FX0SzB GQCiIxmBQETz3JZJBLymOpdgUh7pYXyEh5JnogKDzeQFXg2kEzki34mT1Jz1SSSdkgLTAvrMvq8 SKqNV8i6V58ZrwanJWc3JRADWdlYfM7jGwOinDDDGoosD5NFbkjlGCfboeEclbcVp45ZzRu3FWU aqKMKona8K6UXTJLJM8UYmuGrb8m6nmudcfdeHptKLhuti/R
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-sunplus driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-sunplus.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-sunplus.c b/drivers/pwm/pwm-sunplus.c
index 773e2f80526e..46181b9149b0 100644
--- a/drivers/pwm/pwm-sunplus.c
+++ b/drivers/pwm/pwm-sunplus.c
@@ -43,14 +43,13 @@
 #define SP7021_PWM_NUM			4
 
 struct sunplus_pwm {
-	struct pwm_chip chip;
 	void __iomem *base;
 	struct clk *clk;
 };
 
 static inline struct sunplus_pwm *to_sunplus_pwm(struct pwm_chip *chip)
 {
-	return container_of(chip, struct sunplus_pwm, chip);
+	return pwmchip_priv(chip);
 }
 
 static int sunplus_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -175,12 +174,14 @@ static void sunplus_pwm_clk_release(void *data)
 static int sunplus_pwm_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct pwm_chip *chip;
 	struct sunplus_pwm *priv;
 	int ret;
 
-	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(dev, SP7021_PWM_NUM, sizeof(*priv));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	priv = to_sunplus_pwm(chip);
 
 	priv->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->base))
@@ -203,11 +204,9 @@ static int sunplus_pwm_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	priv->chip.dev = dev;
-	priv->chip.ops = &sunplus_pwm_ops;
-	priv->chip.npwm = SP7021_PWM_NUM;
+	chip->ops = &sunplus_pwm_ops;
 
-	ret = devm_pwmchip_add(dev, &priv->chip);
+	ret = devm_pwmchip_add(dev, chip);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Cannot register sunplus PWM\n");
 
-- 
2.42.0


