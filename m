Return-Path: <linux-pwm+bounces-1320-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD37854580
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EA801C22419
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C82171A6;
	Wed, 14 Feb 2024 09:34:25 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500C117589
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903265; cv=none; b=mmq/x6rzfL/9F6NnD95Sgw38mihMBsobv6iuiRrwLGOXCVn0urDJEehjB++5eyHDCPKIaQo3HKPgUcYG3X79C2jIltfTtqSu37shSwdE4L9ZT8iC4K7AUqCL9D1wao2ynkjBiCV96RLXQkPn5cDYoGkzglh5TsXkYffBaUQNsyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903265; c=relaxed/simple;
	bh=UJ7kZSxcKk3H/k/fOQ/8AhXATk/5yZZHRmPO2TCmzGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WCwm38ldylilkOwK1B7WFhFXAei+Ni8+YPSrUqk60bdfYnbL2FWmSVAwED3sPxJ4kRmSsm1A/It31cYIbmuTkSWbQoLpYZ7IISYZP25+JTsmg4IwTiX4VpWx+2rYPFfCdrtjJCJmz/+4c4L3zB1SaGDBSPjwiz+bo7zeS3Da5Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBen-0004UC-4A; Wed, 14 Feb 2024 10:34:21 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBem-000f8V-AY; Wed, 14 Feb 2024 10:34:20 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBem-004Y0h-0n;
	Wed, 14 Feb 2024 10:34:20 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	linux-pwm@vger.kernel.org
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v6 016/164] pwm: bcm2835: Make use of devm_pwmchip_alloc() function
Date: Wed, 14 Feb 2024 10:31:03 +0100
Message-ID:  <441489772bdfbb2cd206fd534b36c63e8c50843a.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2140; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=UJ7kZSxcKk3H/k/fOQ/8AhXATk/5yZZHRmPO2TCmzGo=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtQzHbE63mqvXs9kTrscyyYYzbPQsDwszW37fXdLgWbrs 3IL5+Z0MhqzMDByMciKKbLYN67JtKqSi+xc++8yzCBWJpApDFycAjCRDG/2/67ZjluTHjPpee9O m8rlGHCOd4JshFT6avcfot5igtWmne8qAi8esVW8IHVsMsOCIvlPf5s0HQ+weF5MM34XnGA1J0E ux9rSUuPNlnmSStMiLkdlXH3NesnUSG36NK9Fp7+efVg3fRXzpend2/Z36v4yeu4T7D53gjovU9 yZV4nb/x5O856qGaDoU/1oQnpk4tWQNLcty4QO+9b+tCyfyGffUs+2eG1qj4U2Q9eCH68Xhz3f5 JvNe7e0+GqA5Q9laQneDe+LI7KfBzlkN/bu3h65NNtl9a2via8Ofs4Q0+va/uba5ENn+tTajF9n /GqNWn7/KjNbTNMVCz7Lc5mn5W5XCB5K8A/ii/12dXofAA==
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
 drivers/pwm/pwm-bcm2835.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
index 711c174bbe23..aa35acbb0cbc 100644
--- a/drivers/pwm/pwm-bcm2835.c
+++ b/drivers/pwm/pwm-bcm2835.c
@@ -24,7 +24,6 @@
 #define PERIOD_MIN		0x2
 
 struct bcm2835_pwm {
-	struct pwm_chip chip;
 	void __iomem *base;
 	struct clk *clk;
 	unsigned long rate;
@@ -32,7 +31,7 @@ struct bcm2835_pwm {
 
 static inline struct bcm2835_pwm *to_bcm2835_pwm(struct pwm_chip *chip)
 {
-	return container_of(chip, struct bcm2835_pwm, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static int bcm2835_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
@@ -134,12 +133,14 @@ static void devm_clk_rate_exclusive_put(void *data)
 
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
 
 	pc->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pc->base))
@@ -165,14 +166,12 @@ static int bcm2835_pwm_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, -EINVAL,
 				     "failed to get clock rate\n");
 
-	pc->chip.dev = &pdev->dev;
-	pc->chip.ops = &bcm2835_pwm_ops;
-	pc->chip.atomic = true;
-	pc->chip.npwm = 2;
+	chip->ops = &bcm2835_pwm_ops;
+	chip->atomic = true;
 
 	platform_set_drvdata(pdev, pc);
 
-	ret = devm_pwmchip_add(&pdev->dev, &pc->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0)
 		return dev_err_probe(&pdev->dev, ret,
 				     "failed to add pwmchip\n");
-- 
2.43.0


