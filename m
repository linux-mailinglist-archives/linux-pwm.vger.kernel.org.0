Return-Path: <linux-pwm+bounces-1331-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 100A285459B
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70725B22553
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EBB182DF;
	Wed, 14 Feb 2024 09:34:28 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDB212E76
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903267; cv=none; b=edzdDRoGg7NDaHImq5FiFjRHf31TVdkvIkTm4yN0vMwOWOKPtZiYuXUYek+GPgEm5t3pXLzmjwi9K+ox1+1ZiLTtyu/T3FL7Tc/kTkx+SYoO3MI8e6Jqu9DA491r3NdR1Fm13NobQBuoHAE3BBXGMq9VWyI+lFS3Od3rNBO6puk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903267; c=relaxed/simple;
	bh=w0fOAQp3R0GQVFqZnHiwkbH0Zz24GfimeMsMW9SakZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HthDhwFvthDwkatT52XS10n36fwu2TpeU8pS9dPf9IOHKLwDKbZXo+EJQ0B8h69/W4qvbDNAhI0f3ie7PL1G1PvuTLSs0wg0kDAihRDmbZ53uOZTC1q6A+fhIjtUlQFkpCJYvNjUyueIBZJTSkh2o9QaIfm3AoboLm150jLyxhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBen-0004WU-VI; Wed, 14 Feb 2024 10:34:21 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBen-000f95-4E; Wed, 14 Feb 2024 10:34:21 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBen-004Y11-0C;
	Wed, 14 Feb 2024 10:34:21 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v6 021/164] pwm: berlin: Make use of devm_pwmchip_alloc() function
Date: Wed, 14 Feb 2024 10:31:08 +0100
Message-ID:  <52866502c96a80d1c30be003dc1f5a89a4d230cc.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1860; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=w0fOAQp3R0GQVFqZnHiwkbH0Zz24GfimeMsMW9SakZ4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIhirfJr5XpwFdtJyRml+NKzahi1ixXrlIHm3 UVaX2K56qOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIYgAKCRCPgPtYfRL+ Tk+bB/9mbFLy9EZ5kPG5Hd4y+NDfivAgsZ90nCJl18fPme7HMCnG7/DHDTI3UTliDzK6ZE9o488 +0QgoSpX8vumEAWLpOKECCTfaGYgVZAuMGU60Rhhcd7jYgaXdbWrqf9MPJqVR/nzHzH5gaQczT3 46ZVo4b2ZlxrbZrxIDBqba3bEKiGbvHEE7bUzcP9rm3HL1kABnzDeVv/Hh2NB+EygRy7zzwrcLC QNow42Ysh44odiLa6ZNBDPeSjppV+Ppven1krvNHk118zL70TYWD/uN8SiV/exFGyEK+1nFLeSq pV7l2HupkLOJu91Jvj/1bE7e/gT6hjG/RTzFWTd0s7H0Dnnj
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
 drivers/pwm/pwm-berlin.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-berlin.c b/drivers/pwm/pwm-berlin.c
index d910017b5feb..831aed228caf 100644
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
@@ -202,9 +201,10 @@ static int berlin_pwm_probe(struct platform_device *pdev)
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
@@ -214,10 +214,7 @@ static int berlin_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(bpc->clk))
 		return PTR_ERR(bpc->clk);
 
-	chip = &bpc->chip;
-	chip->dev = &pdev->dev;
 	chip->ops = &berlin_pwm_ops;
-	chip->npwm = BERLIN_PWM_NUMPWMS;
 
 	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0)
-- 
2.43.0


