Return-Path: <linux-pwm+bounces-1742-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B18AB87772F
	for <lists+linux-pwm@lfdr.de>; Sun, 10 Mar 2024 14:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3B251C20900
	for <lists+linux-pwm@lfdr.de>; Sun, 10 Mar 2024 13:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683A91E504;
	Sun, 10 Mar 2024 13:47:39 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD5F1EB23
	for <linux-pwm@vger.kernel.org>; Sun, 10 Mar 2024 13:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710078459; cv=none; b=m5FojdSwXntXncGyk9YOx7uVmri1ir+27p3WHeVXJ603+nZdmkKK9LNIplCFhl3qqzYVspoflzD8bqzl78usz/kxSHu6zM3MAZc9IyOI/zVzL1emjDqXJR4PNeMrO14/iRhiew8qLvO9rWq8lsMg2AsmlJl+yR8EhPLjpE/yGDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710078459; c=relaxed/simple;
	bh=mmw8koG/ZtiJc4H8TwSRcAGvWLX/ZD4CZUW4WDksnuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qj0Jtq1DH4fN1h7wCY5rXudgAov0bsNryei8EmaJLWU1a9WHuiv0raA7Cfv4ngOkZTAlVPXeAlrE6MOVz5WTA4AaMMkltAWrn9r/5avC7CM/QIrrEVVu8cQULUJ5s3l2C7LoAITex70YJRGk/COwpr28YW1BiSZu0SPjgPqKQYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjJWX-0000xB-7v; Sun, 10 Mar 2024 14:47:33 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjJWW-005WrI-RJ; Sun, 10 Mar 2024 14:47:32 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjJWW-003SK3-2Q;
	Sun, 10 Mar 2024 14:47:32 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-pwm@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH 1/2] pwm: bcm2835: Introduce a local variable for &pdev->dev
Date: Sun, 10 Mar 2024 14:47:19 +0100
Message-ID:  <3f302472e30e21c7ef5624a1d0a2890d9fdf3c7f.1710078146.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1710078146.git.u.kleine-koenig@pengutronix.de>
References: <cover.1710078146.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2289; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=mmw8koG/ZtiJc4H8TwSRcAGvWLX/ZD4CZUW4WDksnuA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl7bnqwhgoFRD6Z6wGsqlOWltW+ttEgVDMRpBnV xnm0jypV36JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZe256gAKCRCPgPtYfRL+ Tvm7CACibulWA51FwQr+TDupOZs7Xnpd1uqBTeEOXabfpYjQr3tfR3+ggOB4x4FsFskNC7sYnSh jhw0TsXEjQ+T/qVop8wX9STJ1r7OvxjqGqHruhlo/9PmR8sudjfB5QzAb2Xb9/HU/HcXTD9PhrQ QojDywcrYqo/98ZhfPruxvMBivRZg4/vfnUx0IHOLsRXexlfAjlQAcXFp+iA9RLcRUzkMsUcOmD imYdyJE39hkwXqkdHeXtm0mq2p0sXmyFaPahmrRd2KYUNNGvnbo62tqogZ25mXCpkFAU4tdvaxf 1566prKYGUK6Uxsvc7n+ySFtfTbroC6FxKUZu3VBGFMxyvwb
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

&pdev->dev is used several times in bcm2835_pwm_probe(). Introduce a
local variable to simplify all usages.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-bcm2835.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
index aa35acbb0cbc..3d0c089c9ef0 100644
--- a/drivers/pwm/pwm-bcm2835.c
+++ b/drivers/pwm/pwm-bcm2835.c
@@ -133,11 +133,12 @@ static void devm_clk_rate_exclusive_put(void *data)
 
 static int bcm2835_pwm_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct pwm_chip *chip;
 	struct bcm2835_pwm *pc;
 	int ret;
 
-	chip = devm_pwmchip_alloc(&pdev->dev, 2, sizeof(*pc));
+	chip = devm_pwmchip_alloc(dev, 2, sizeof(*pc));
 	if (IS_ERR(chip))
 		return PTR_ERR(chip);
 	pc = to_bcm2835_pwm(chip);
@@ -146,24 +147,24 @@ static int bcm2835_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(pc->base))
 		return PTR_ERR(pc->base);
 
-	pc->clk = devm_clk_get_enabled(&pdev->dev, NULL);
+	pc->clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(pc->clk))
-		return dev_err_probe(&pdev->dev, PTR_ERR(pc->clk),
+		return dev_err_probe(dev, PTR_ERR(pc->clk),
 				     "clock not found\n");
 
 	ret = clk_rate_exclusive_get(pc->clk);
 	if (ret)
-		return dev_err_probe(&pdev->dev, ret,
+		return dev_err_probe(dev, ret,
 				     "fail to get exclusive rate\n");
 
-	ret = devm_add_action_or_reset(&pdev->dev, devm_clk_rate_exclusive_put,
+	ret = devm_add_action_or_reset(dev, devm_clk_rate_exclusive_put,
 				       pc->clk);
 	if (ret)
 		return ret;
 
 	pc->rate = clk_get_rate(pc->clk);
 	if (!pc->rate)
-		return dev_err_probe(&pdev->dev, -EINVAL,
+		return dev_err_probe(dev, -EINVAL,
 				     "failed to get clock rate\n");
 
 	chip->ops = &bcm2835_pwm_ops;
@@ -171,10 +172,9 @@ static int bcm2835_pwm_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pc);
 
-	ret = devm_pwmchip_add(&pdev->dev, chip);
+	ret = devm_pwmchip_add(dev, chip);
 	if (ret < 0)
-		return dev_err_probe(&pdev->dev, ret,
-				     "failed to add pwmchip\n");
+		return dev_err_probe(dev, ret, "failed to add pwmchip\n");
 
 	return 0;
 }
-- 
2.43.0


