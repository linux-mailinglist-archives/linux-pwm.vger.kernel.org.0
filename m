Return-Path: <linux-pwm+bounces-1739-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A5E87762D
	for <lists+linux-pwm@lfdr.de>; Sun, 10 Mar 2024 12:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF88B1C2091B
	for <lists+linux-pwm@lfdr.de>; Sun, 10 Mar 2024 11:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDEC1EB42;
	Sun, 10 Mar 2024 11:01:15 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C2B1EB25
	for <linux-pwm@vger.kernel.org>; Sun, 10 Mar 2024 11:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710068475; cv=none; b=fzREvMZZ3w7XIxIw0dXLupiba46OiKcbUEfuwhKsQzXk5KMJlA4oSYxamKSHDDBuQ79vqHmr73qAgzEzrDElpscxtSnH3xrsvQ9b8vuqRhnZ6q4DSAC8yGh3sJvrAZsDtGMzkLc9DQAoNgMGLYI+VD8W+CkGPOmhKVlqfja36AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710068475; c=relaxed/simple;
	bh=U12TxxuxJqEjckyqNeX4UwQE3b6phAEgbq39nIVcwN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=do+D8q1JaaXE8ZbpgrcVq7FtT11wBfgLAX/9rIu6B/W7sR1OhgOtXL0QqjIsv4nIFbKvYEpk6ejb1h5rQXYWORA5jJmDGus6VZF9uDydciBl7MyGOWtxAytbyHePMJmnrMnKOfvaJuWpM60BWRnyqi92Yazqduoh4rKQLOrdPZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjGvW-0000pY-5E; Sun, 10 Mar 2024 12:01:10 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjGvV-005V0j-6e; Sun, 10 Mar 2024 12:01:09 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjGvV-003OFW-0P;
	Sun, 10 Mar 2024 12:01:09 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: Ajit Pal Singh <ajitpal.singh@st.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Lee Jones <lee@kernel.org>,
	kernel@pengutronix.de
Subject: [PATCH 1/6] pwm: sti: Simplify probe function using devm functions
Date: Sun, 10 Mar 2024 12:00:54 +0100
Message-ID:  <81f0e1d173652f435afda6719adaed1922fe059a.1710068192.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1710068192.git.u.kleine-koenig@pengutronix.de>
References: <cover.1710068192.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3107; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=U12TxxuxJqEjckyqNeX4UwQE3b6phAEgbq39nIVcwN0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl7ZLopf7o09LnfSVykjnf4eFWfeVI9uVdSr8EX tmD45u27dSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZe2S6AAKCRCPgPtYfRL+ TjOdCACh4ycgr8HplpXEMCusX8GeU7YFuvtQI4qYqEPrStgGJmdrZbRI3jiJsgXwUoIm3cFaHJ3 QIu17U2RCU5/uJLsUBJtiZyOrKQ6UoKAT57jhoiKpUwARR+sRG5B6Vk9/jHj43Rh1rLKH8UH1fk pth59sIpar/tuzulaHklcOXj2zrVfvfLHf5PjyBHYL4dV+X2BgwSphPLjaV+tBVsejVjEkmL/F1 RiVV8zSMk23TKeTiD3/7/2rG6TI58W0r0l4vLQA4ia/3QhMFGvrI5shzVjm5VrYlhz1leFS/ZWm 0DpIm8k/lF9F26G9yWIicbPm83rjyXHwj82d44X1Bo9f6ZK0
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

Instead of of_clk_get_by_name() use devm_clk_get_prepared() which has
several advantages:

 - Combines getting the clock and a call to clk_prepare(). The latter
   can be dropped from sti_pwm_probe() accordingly.
 - Cares for calling clk_put() which is missing in both probe's error
   path and the remove function.
 - Cares for calling clk_unprepare() which can be dropped from the error
   paths and the remove function. (Note that not all error path got this
   right.)

With additionally using devm_pwmchip_add() instead of pwmchip_add() the
remove callback can be dropped completely. With it the last user of
platform_get_drvdata() goes away and so platform_set_drvdata() can be
dropped from the probe function, too.

Fixes: 378fe115d19d ("pwm: sti: Add new driver for ST's PWM IP")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-sti.c | 39 +++------------------------------------
 1 file changed, 3 insertions(+), 36 deletions(-)

diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
index 39d80da0e14a..f07b1126e7a8 100644
--- a/drivers/pwm/pwm-sti.c
+++ b/drivers/pwm/pwm-sti.c
@@ -624,32 +624,20 @@ static int sti_pwm_probe(struct platform_device *pdev)
 		return ret;
 
 	if (cdata->pwm_num_devs) {
-		pc->pwm_clk = of_clk_get_by_name(dev->of_node, "pwm");
+		pc->pwm_clk = devm_clk_get_prepared(dev, "pwm");
 		if (IS_ERR(pc->pwm_clk)) {
 			dev_err(dev, "failed to get PWM clock\n");
 			return PTR_ERR(pc->pwm_clk);
 		}
-
-		ret = clk_prepare(pc->pwm_clk);
-		if (ret) {
-			dev_err(dev, "failed to prepare clock\n");
-			return ret;
-		}
 	}
 
 	if (cdata->cpt_num_devs) {
-		pc->cpt_clk = of_clk_get_by_name(dev->of_node, "capture");
+		pc->cpt_clk = devm_clk_get_prepared(dev, "capture");
 		if (IS_ERR(pc->cpt_clk)) {
 			dev_err(dev, "failed to get PWM capture clock\n");
 			return PTR_ERR(pc->cpt_clk);
 		}
 
-		ret = clk_prepare(pc->cpt_clk);
-		if (ret) {
-			dev_err(dev, "failed to prepare clock\n");
-			return ret;
-		}
-
 		cdata->ddata = devm_kzalloc(dev, cdata->cpt_num_devs * sizeof(*cdata->ddata), GFP_KERNEL);
 		if (!cdata->ddata)
 			return -ENOMEM;
@@ -664,27 +652,7 @@ static int sti_pwm_probe(struct platform_device *pdev)
 		mutex_init(&ddata->lock);
 	}
 
-	ret = pwmchip_add(chip);
-	if (ret < 0) {
-		clk_unprepare(pc->pwm_clk);
-		clk_unprepare(pc->cpt_clk);
-		return ret;
-	}
-
-	platform_set_drvdata(pdev, chip);
-
-	return 0;
-}
-
-static void sti_pwm_remove(struct platform_device *pdev)
-{
-	struct pwm_chip *chip = platform_get_drvdata(pdev);
-	struct sti_pwm_chip *pc = to_sti_pwmchip(chip);
-
-	pwmchip_remove(chip);
-
-	clk_unprepare(pc->pwm_clk);
-	clk_unprepare(pc->cpt_clk);
+	return devm_pwmchip_add(dev, chip);
 }
 
 static const struct of_device_id sti_pwm_of_match[] = {
@@ -699,7 +667,6 @@ static struct platform_driver sti_pwm_driver = {
 		.of_match_table = sti_pwm_of_match,
 	},
 	.probe = sti_pwm_probe,
-	.remove_new = sti_pwm_remove,
 };
 module_platform_driver(sti_pwm_driver);
 
-- 
2.43.0


