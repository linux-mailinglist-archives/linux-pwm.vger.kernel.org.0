Return-Path: <linux-pwm+bounces-1399-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB0A8545D7
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C06721C27076
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51391863F;
	Wed, 14 Feb 2024 09:34:41 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D507B15AE0
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903281; cv=none; b=k7ORYE6lKyD8FsTanKF88zzEKzqn5hlrjltMPmQn4R1RI4ktgWeZlsNciW+2im3DAhlem6ATIXYlsZ18VOTzDNx35YporiWOyO9vl8aEjB1P7cGX46QhYvDavSkaBNH/kT+JcMPk1Z36ltl2+aX6m84cBTkF02PaGUcZCMIVZss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903281; c=relaxed/simple;
	bh=MaLv9HpNc3gSSboEx4AXhzrUji0bPoNdjQWHXjg6D1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hjauG8Xvg+XSjkvqTfVvQTnyRaDjGCyxTYncs/qn6LoOmrxlw58nqPHqDo4LANe7nVlPuJw4jYfMptydZk4KW5ImtS6r5dkxiDBkAmhu4stO/8wbfhI/MmUF/Qll+AippmLBKqfJ2U0A6HeBNmls5Y8dLXiqGL26Bpl3GhrxVnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf1-0005O6-EN; Wed, 14 Feb 2024 10:34:35 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBey-000fEQ-19; Wed, 14 Feb 2024 10:34:32 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBex-004Y5v-35;
	Wed, 14 Feb 2024 10:34:31 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Heiko Stuebner <heiko@sntech.de>,
	linux-pwm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v6 092/164] pwm: rockchip: Make use of devm_pwmchip_alloc() function
Date: Wed, 14 Feb 2024 10:32:19 +0100
Message-ID:  <61a3f48710e3e795beb2e496c8c673bbc0f6c932.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1883; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=MaLv9HpNc3gSSboEx4AXhzrUji0bPoNdjQWHXjg6D1M=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIi0Q6jh5jQS1v0LelA5uwPTo5/sscfBg/Ssl 7WKx/rIVaWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyItAAKCRCPgPtYfRL+ TpfkB/9Xwu5KMbDTzywn8HbUynu522uvpHjJwdLBAp2qurcNabbuhZh1rPBJ6Ns71N+B78IwtKl J0cs1MpD7vpS4oEeQEvE7W1nXAk+1TptdgjBVYeP3JCJgPuuQHtH8Q6oF/P/gdP5s2KX2l5F6xD jdYkisWyowUXdUBL26ZNg1lyqKe1Hpd6rbdHaXWoa/ZfQD63zX7oT1nXLhu+984N1ISGYQhVliz gKvbA60uzAvTo+8XH/PfVohRpTOgDqcAs+I5xQb9HLYU/j7A3Mc0LEKgodN/JZ1xDaWNZIHW+va ymq4dIJRczio3WRyasU1g6W6WgLiL0HHKxETKa4aul0UvAW4
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-rockchip driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-rockchip.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index c001eb6b17ae..0fa7575dbb54 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -30,7 +30,6 @@
 #define PWM_LP_DISABLE		(0 << 8)
 
 struct rockchip_pwm_chip {
-	struct pwm_chip chip;
 	struct clk *clk;
 	struct clk *pclk;
 	const struct rockchip_pwm_data *data;
@@ -54,7 +53,7 @@ struct rockchip_pwm_data {
 
 static inline struct rockchip_pwm_chip *to_rockchip_pwm_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct rockchip_pwm_chip, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static int rockchip_pwm_get_state(struct pwm_chip *chip,
@@ -302,10 +301,10 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 	bool enabled;
 	int ret, count;
 
-	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
-	if (!pc)
-		return -ENOMEM;
-	chip = &pc->chip;
+	chip = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*pc));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	pc = to_rockchip_pwm_chip(chip);
 
 	pc->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pc->base))
@@ -342,9 +341,7 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, chip);
 
 	pc->data = device_get_match_data(&pdev->dev);
-	chip->dev = &pdev->dev;
 	chip->ops = &rockchip_pwm_ops;
-	chip->npwm = 1;
 
 	enable_conf = pc->data->enable_conf;
 	ctrl = readl_relaxed(pc->base + pc->data->regs.ctrl);
-- 
2.43.0


