Return-Path: <linux-pwm+bounces-348-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8E7806E92
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 966B31F21673
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BDF34CEA;
	Wed,  6 Dec 2023 11:48:47 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50032D7F
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:34 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOE-0006e6-RH; Wed, 06 Dec 2023 12:48:30 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOD-00Dwug-Dq; Wed, 06 Dec 2023 12:48:29 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOD-00FQzw-4e; Wed, 06 Dec 2023 12:48:29 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 053/115] pwm: brcmstb: Make use of devm_pwmchip_alloc() function
Date: Wed,  6 Dec 2023 12:44:07 +0100
Message-ID:  <806f32f9b50445908879b335e61a95f5403f34b1.1701860672.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2069; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=qPR3E77Q2c4nuHJu1gAGeuoFBuL9XUIda5fxAVW1rf8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcF6eR1ew7fFHaNtsEod2ldmotFVFIpEWRZGQw 3H/gh+U/NeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXBengAKCRCPgPtYfRL+ Tv1WB/90ZORXayCTY6G2if/RuLxXEDMkf9ciIq/8WIOiemgRzyqQAbHBjeFFigINNlMDKGhs3iy qIne1kN9aD/3qAkTvFlCjW/eNsbvF3p+0Aovd/MTWYCfbHskJy0+GsVmrqnzMaGfXmJapjOfr8M a3h+SC0Y0PUqNt2QgCIj//RATYA/6gPP2G3Qbvw1Z/xodVQQmhH/K6D0yx4DqkdsP+kwEOIzpyP 80gnSOiUCo4KXfR1l9bWqmb5bX9VxjKxGPQ+hWLwJWz2LU3K82qQsIDWDJZS7A/TgCljIk9qS6U FaeHc2bpPwXX/caUZK889gh8Nfw1F8asNxAIS/9MzryWjD/X
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-brcmstb driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-brcmstb.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-brcmstb.c b/drivers/pwm/pwm-brcmstb.c
index 0fdeb0b2dbf3..82d27d07ba91 100644
--- a/drivers/pwm/pwm-brcmstb.c
+++ b/drivers/pwm/pwm-brcmstb.c
@@ -54,7 +54,6 @@
 struct brcmstb_pwm {
 	void __iomem *base;
 	struct clk *clk;
-	struct pwm_chip chip;
 };
 
 static inline u32 brcmstb_pwm_readl(struct brcmstb_pwm *p,
@@ -77,7 +76,7 @@ static inline void brcmstb_pwm_writel(struct brcmstb_pwm *p, u32 value,
 
 static inline struct brcmstb_pwm *to_brcmstb_pwm(struct pwm_chip *chip)
 {
-	return container_of(chip, struct brcmstb_pwm, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 /*
@@ -230,12 +229,14 @@ MODULE_DEVICE_TABLE(of, brcmstb_pwm_of_match);
 
 static int brcmstb_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct brcmstb_pwm *p;
 	int ret;
 
-	p = devm_kzalloc(&pdev->dev, sizeof(*p), GFP_KERNEL);
-	if (!p)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 2, sizeof(*p));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	p = to_brcmstb_pwm(chip);
 
 	p->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(p->clk))
@@ -244,15 +245,13 @@ static int brcmstb_pwm_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, p);
 
-	p->chip.dev = &pdev->dev;
-	p->chip.ops = &brcmstb_pwm_ops;
-	p->chip.npwm = 2;
+	chip->ops = &brcmstb_pwm_ops;
 
 	p->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(p->base))
 		return PTR_ERR(p->base);
 
-	ret = devm_pwmchip_add(&pdev->dev, &p->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
 
-- 
2.42.0


