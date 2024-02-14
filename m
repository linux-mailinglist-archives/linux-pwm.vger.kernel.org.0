Return-Path: <linux-pwm+bounces-1328-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B32CC854588
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3C3C1C24390
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7089D182C3;
	Wed, 14 Feb 2024 09:34:27 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBA812E70
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903266; cv=none; b=ENxTh5ILypC89lU/EtUfMFME7H0YRT4jv8VM7ZyIPkv5MfPxg44X8pPsh50SKd4wJKsI9cNWMnQnckhXV/NqkQyB21OXz199MrAWfiVm9wlkUfX1VuGdfG7WKNC59PhS9h/i9XbZJ8IrWghvPVhtx7pkkLjL9vF0gC3VhPxKbvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903266; c=relaxed/simple;
	bh=TZC2i850mmZA7TRa+F19cdXeyXFOZTXIsdwaUd0XKe0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RlCdeCGQoOQjEewHOna0zJjf2P77MgROSDo/8SZU+ABEV75xUr5AQTxlAipgVA0Mcau4R0JX+VUKkHfmDgvoDHvZsNEZd9j31By1Dtueb/HfltViLOdSupUpP1Qf2/nGVrj4YP1Xc9ZEcusx40WEfpUggAabhHgtO9Uy3z48nqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBeo-0004X9-3I; Wed, 14 Feb 2024 10:34:22 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBen-000f9D-9i; Wed, 14 Feb 2024 10:34:21 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBen-004Y15-0j;
	Wed, 14 Feb 2024 10:34:21 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-pwm@vger.kernel.org
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v6 022/164] pwm: brcmstb: Make use of devm_pwmchip_alloc() function
Date: Wed, 14 Feb 2024 10:31:09 +0100
Message-ID:  <adf9cb04f5d84ae604e97d4dc0708ff3677d72d7.1707900770.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1707900770.git.u.kleine-koenig@pengutronix.de>
References: <cover.1707900770.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2069; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=TZC2i850mmZA7TRa+F19cdXeyXFOZTXIsdwaUd0XKe0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIhjDjuK1PCkOBbp78U6s5ncfexyDWoTig+kP azv5llnzEyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIYwAKCRCPgPtYfRL+ Tvk9B/9QuqdXnZYIXbPY5QyGEzKpv/yIQf8Fmo1Xe7pN9/J5ElhywFqhNhcllPZbhNbh+arQM4p XrWWvB+c/eY/1bIHdYR+qe007WvGWDyghR1UvCXW2tCmP0qTftJF81EC4PzKWlZ8mWKvDSM1qDd 82swaanWPhvIK94zSaL/O32aLLYftK3YyYCQ8CP/woJYXHyvl1+gQg8n1o4/qIvQSmVbKTF4icT dBLmykfHutIGuFXtOBtw5hDEHf9/lOEjCsyt4wJhR1Ehc0tdw7OdEy7v+HnwPSdN99p55G1zEri C/Wck1OKykQc1okg7VOl/I5icwNqc7dps7BZmnzzvwN/4tk9
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
2.43.0


