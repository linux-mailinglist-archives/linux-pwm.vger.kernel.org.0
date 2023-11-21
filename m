Return-Path: <linux-pwm+bounces-55-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E78FF7F2F8F
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8876AB20F31
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9DC53814;
	Tue, 21 Nov 2023 13:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397E6D6E
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:52:00 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAT-0005az-9C; Tue, 21 Nov 2023 14:51:57 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAR-00Aazk-Fx; Tue, 21 Nov 2023 14:51:55 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAR-004xeG-6s; Tue, 21 Nov 2023 14:51:55 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v3 053/108] pwm: ep93xx: Make use of devm_pwmchip_alloc() function
Date: Tue, 21 Nov 2023 14:49:55 +0100
Message-ID: <20231121134901.208535-54-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1948; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=bPuoVwCfQPZF1EwR3vZXcL/NqvWx+0mBgRtjFgXYIo4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXLWGzXrvYHfNHLpMMM//n/HGPYL9MpQtu22lq fnWj0IpI9OJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVy1hgAKCRCPgPtYfRL+ TrRFB/403Cyh/BnPsUuppqnJEH4Ub9L+YVDgJxJ55CxCLi304tn6kVYGjpEqzvqI7djDZhpQrWh 7O6OrUJIUA4bJhh7FodTiKhhemm7b+7D/YnJciUsSO42EHkQ6QUpCoZNkHXQE1Um4rBzesvVX2+ 0j/zgq1tLHM5ZQINIK19LzRf3vyPly8GD1Hkt4JteMswi45TkTriod59RGMQO42bopQffIpy0O3 WDAwcqdFQnLbVkBWBjvKe5WbIBO8UWMpdcAjTOtpN5uX0+FImoLLLV7fu7oq474Digt3YWWPQrm YwpN/FGL8aQxCdgVQAFHuGB/0s6ELrNYwq14+fPVg97AdK4Y
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-ep93xx driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-ep93xx.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-ep93xx.c b/drivers/pwm/pwm-ep93xx.c
index e4c3546a61c8..5df541645d54 100644
--- a/drivers/pwm/pwm-ep93xx.c
+++ b/drivers/pwm/pwm-ep93xx.c
@@ -36,12 +36,11 @@
 struct ep93xx_pwm {
 	void __iomem *base;
 	struct clk *clk;
-	struct pwm_chip chip;
 };
 
 static inline struct ep93xx_pwm *to_ep93xx_pwm(struct pwm_chip *chip)
 {
-	return container_of(chip, struct ep93xx_pwm, chip);
+	return pwmchip_priv(chip);
 }
 
 static int ep93xx_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
@@ -163,12 +162,14 @@ static const struct pwm_ops ep93xx_pwm_ops = {
 
 static int ep93xx_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct ep93xx_pwm *ep93xx_pwm;
 	int ret;
 
-	ep93xx_pwm = devm_kzalloc(&pdev->dev, sizeof(*ep93xx_pwm), GFP_KERNEL);
-	if (!ep93xx_pwm)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*ep93xx_pwm));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	ep93xx_pwm = to_ep93xx_pwm(chip);
 
 	ep93xx_pwm->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(ep93xx_pwm->base))
@@ -178,11 +179,9 @@ static int ep93xx_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(ep93xx_pwm->clk))
 		return PTR_ERR(ep93xx_pwm->clk);
 
-	ep93xx_pwm->chip.dev = &pdev->dev;
-	ep93xx_pwm->chip.ops = &ep93xx_pwm_ops;
-	ep93xx_pwm->chip.npwm = 1;
+	chip->ops = &ep93xx_pwm_ops;
 
-	ret = devm_pwmchip_add(&pdev->dev, &ep93xx_pwm->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0)
 		return ret;
 
-- 
2.42.0


