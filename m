Return-Path: <linux-pwm+bounces-1740-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AF887762E
	for <lists+linux-pwm@lfdr.de>; Sun, 10 Mar 2024 12:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D87011C209C0
	for <lists+linux-pwm@lfdr.de>; Sun, 10 Mar 2024 11:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C01F1EB45;
	Sun, 10 Mar 2024 11:01:15 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C061EB23
	for <linux-pwm@vger.kernel.org>; Sun, 10 Mar 2024 11:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710068475; cv=none; b=h4woYY+W5Hd6MxVEpSRBu0KnC+kJkiC2InPRvY8OoTW6DpgloA18WxXQ1Xu3HkPRg7vM7J80LjlVHfa8A+ldI74gPfpNQl1YFZfFdF5bb8AofquMeF0AJGdRPvdZA/2M5b6c+vAhp4kOW/dIi1uaxwmgFyVaBlS97cccihaCugs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710068475; c=relaxed/simple;
	bh=K6s4g7hFlPRpCbfh35M0ggjn3g/8fiWrXaCMnX6pBEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fjwzmwTmJ/3cYMSpm9yBIQ4ehphan4sZW+xEIi1BAutKAbjagqArvk5s8VJiVX3PDkMkYDxsrwO0zomgtm2kGKSHgVuwynwRNxOxuTShyVa3zZpe0zg701lSLo7oYwmp/PbuuWd9I+6S9PpNpZyhmrzWNUARgx+GtFFGaP5TUi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjGvW-0000pn-5E; Sun, 10 Mar 2024 12:01:10 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjGvV-005V0m-E7; Sun, 10 Mar 2024 12:01:09 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjGvV-003OFa-19;
	Sun, 10 Mar 2024 12:01:09 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: Ajit Pal Singh <ajitpal.singh@st.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Lee Jones <lee@kernel.org>,
	kernel@pengutronix.de
Subject: [PATCH 2/6] pwm: sti: Improve error reporting using dev_err_probe()
Date: Sun, 10 Mar 2024 12:00:55 +0100
Message-ID:  <8e540733ab882f2b8873712faf85c4f0cb48133a.1710068192.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3664; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=K6s4g7hFlPRpCbfh35M0ggjn3g/8fiWrXaCMnX6pBEo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl7ZLqDfn1zKM3K7mh3jOq3lQuiBd/20fIc6Iks 9ajdUgjBC+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZe2S6gAKCRCPgPtYfRL+ TtT0B/9z8FFu91miucc976kQ5UJXzQeWQQIpalQi+cgA9G9024grUjCC9tQV5AWKdpVaRCX/4OD fUjFj2VTeoS45ShNq8QFGRnZ1atUiqO4pARBFjPfoZalswhpyR4YGBBm3/PtYQqpV1meRGKLQ+m YZzEtGtpYQrh9KEr9wBhQfu2vA+vny2SCTs9mYrFR1YbJRI9/2bXomNN22M+aec4DgqTJhnh5qp dFZwzn4m3HqTMUgFSbiH1sJ7tuvy/mksnM4lp4JklZGpHzFYziseTamkm1MyK3I0Ke+gfqcHGmJ sZ+kg1OMm8R3Zkh4Pfiz/hUaQkojNPHSt9OFSYHTM+A1nVoC
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This has the advantage of handling EPROBE_DEFER correctly and being more
compact.

This change also introduces an error message for a few error paths that
lacked an error indicator before. Also sti_pwm_probe_dt() is renamed to
sti_pwm_probe_regmap() to better fit what it actually does.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-sti.c | 41 ++++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
index f07b1126e7a8..919d25023e5a 100644
--- a/drivers/pwm/pwm-sti.c
+++ b/drivers/pwm/pwm-sti.c
@@ -502,7 +502,7 @@ static irqreturn_t sti_pwm_interrupt(int irq, void *data)
 	return ret;
 }
 
-static int sti_pwm_probe_dt(struct sti_pwm_chip *pc)
+static int sti_pwm_probe_regmap(struct sti_pwm_chip *pc)
 {
 	struct device *dev = pc->dev;
 	const struct reg_field *reg_fields;
@@ -570,10 +570,8 @@ static int sti_pwm_probe(struct platform_device *pdev)
 	if (!ret)
 		cpt_num_devs = num_devs;
 
-	if (!pwm_num_devs && !cpt_num_devs) {
-		dev_err(dev, "No channels configured\n");
-		return -EINVAL;
-	}
+	if (!pwm_num_devs && !cpt_num_devs)
+		return dev_err_probe(dev, -EINVAL, "No channels configured\n");
 
 	chip = devm_pwmchip_alloc(dev, max(pwm_num_devs, cpt_num_devs), sizeof(*pc));
 	if (IS_ERR(chip))
@@ -591,7 +589,8 @@ static int sti_pwm_probe(struct platform_device *pdev)
 	pc->regmap = devm_regmap_init_mmio(dev, pc->mmio,
 					   &sti_pwm_regmap_config);
 	if (IS_ERR(pc->regmap))
-		return PTR_ERR(pc->regmap);
+		return dev_err_probe(dev, PTR_ERR(pc->regmap),
+				     "Failed to initialize regmap\n");
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
@@ -599,10 +598,8 @@ static int sti_pwm_probe(struct platform_device *pdev)
 
 	ret = devm_request_irq(&pdev->dev, irq, sti_pwm_interrupt, 0,
 			       pdev->name, pc);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to request IRQ\n");
-		return ret;
-	}
+	if (ret < 0)
+		dev_err_probe(&pdev->dev, ret, "Failed to request IRQ\n");
 
 	/*
 	 * Setup PWM data with default values: some values could be replaced
@@ -619,24 +616,22 @@ static int sti_pwm_probe(struct platform_device *pdev)
 	pc->en_count = 0;
 	mutex_init(&pc->sti_pwm_lock);
 
-	ret = sti_pwm_probe_dt(pc);
+	ret = sti_pwm_probe_regmap(pc);
 	if (ret)
-		return ret;
+		return dev_err_probe(dev, ret, "Failed to initialize regmap fields\n");
 
 	if (cdata->pwm_num_devs) {
 		pc->pwm_clk = devm_clk_get_prepared(dev, "pwm");
-		if (IS_ERR(pc->pwm_clk)) {
-			dev_err(dev, "failed to get PWM clock\n");
-			return PTR_ERR(pc->pwm_clk);
-		}
+		if (IS_ERR(pc->pwm_clk))
+			return dev_err_probe(dev, PTR_ERR(pc->pwm_clk),
+					     "failed to get PWM clock\n");
 	}
 
 	if (cdata->cpt_num_devs) {
 		pc->cpt_clk = devm_clk_get_prepared(dev, "capture");
-		if (IS_ERR(pc->cpt_clk)) {
-			dev_err(dev, "failed to get PWM capture clock\n");
-			return PTR_ERR(pc->cpt_clk);
-		}
+		if (IS_ERR(pc->cpt_clk))
+			return dev_err_probe(dev, PTR_ERR(pc->cpt_clk),
+					     "failed to get PWM capture clock\n");
 
 		cdata->ddata = devm_kzalloc(dev, cdata->cpt_num_devs * sizeof(*cdata->ddata), GFP_KERNEL);
 		if (!cdata->ddata)
@@ -652,7 +647,11 @@ static int sti_pwm_probe(struct platform_device *pdev)
 		mutex_init(&ddata->lock);
 	}
 
-	return devm_pwmchip_add(dev, chip);
+	ret = devm_pwmchip_add(dev, chip);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to register pwm chip\n");
+
+	return 0;
 }
 
 static const struct of_device_id sti_pwm_of_match[] = {
-- 
2.43.0


