Return-Path: <linux-pwm+bounces-1357-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BEC8545A9
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AF501C26A15
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE69414ABA;
	Wed, 14 Feb 2024 09:34:31 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6825F1759F
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903271; cv=none; b=MIcKxy7pUWRgS2uBzMVqDNqIDGrQwZk+bd592M+ig5icVDx52rP3y2rrEMuYYc2KTACSsKwbBCRcnvgi+RSJZ74lzfRtNH+8hZTcJVbZada4MqvmM9Hlh0YapWyAo/UWCmgnrHYbal1WI5cBKN7fsfwoR5fL1PaldhH7n9EMrfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903271; c=relaxed/simple;
	bh=qUAkWxCWd5V2MTy+Y7Jya0Z+cg8R6N3dLC4/bxiolCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WqW008/swsHJRHQ07SDtGXrymq/6oPL9stqfS6M3sbTt0Yzy//txILtVBcSiD2Aq1JwNgNb6myLZU0nlRXTqb/pGEYZyf/630RO1EeuXuKtblYusq6ZtTfdLiXsPDAh/lUytGVjMYSgIar+jCQrP6FxG+n+wogLXiQkRzA5tQVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBeq-0004gI-Sd; Wed, 14 Feb 2024 10:34:24 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBeq-000fBO-Ch; Wed, 14 Feb 2024 10:34:24 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBeq-004Y2X-11;
	Wed, 14 Feb 2024 10:34:24 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v6 042/164] pwm: hibvt: Make use of devm_pwmchip_alloc() function
Date: Wed, 14 Feb 2024 10:31:29 +0100
Message-ID:  <7b12504b4128969bdc783bf2bff1ecc63b7c7bd4.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3117; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=qUAkWxCWd5V2MTy+Y7Jya0Z+cg8R6N3dLC4/bxiolCU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIh6NLIitgdw1dDANBA/wSyrtS5NiSgZ3ypdh 2od/j/H+buJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIegAKCRCPgPtYfRL+ TsH3B/0U7T1MTigeoYexOFY22u1Bd6m9DdE45vvWjMMuCWzOt98zcJinpDmxQU3MTnPzF3w/Ddg kiWzdKWb9ldH85hCKcad2fIxxebB+Jl6WwHi1ocszsPEGOsHeFISR7JGuC8LX/5qWSgySg42hTs xMkYwP/zlNOLNhlBtj5Ip4nfaJQM2J6nuuk7VvqvuwaUDz7uPngaXvZe03JBNHqlwruaLgjoYqR EeK388dwpn82HQlzJoDxgS2Vq7WznI5wOi4GcCvwF9lZQbYcGVn59ZBuRya72R7E62fx1d4KFBM TWPgDJJjlFDZjETTYQdTN0cimWlg7SuV8uKqOLpkRf1xLy2q
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-hibvt driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-hibvt.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/pwm/pwm-hibvt.c b/drivers/pwm/pwm-hibvt.c
index f1039be0f4e4..2eb0b13d4e10 100644
--- a/drivers/pwm/pwm-hibvt.c
+++ b/drivers/pwm/pwm-hibvt.c
@@ -33,7 +33,6 @@
 #define PWM_DUTY_MASK       GENMASK(31, 0)
 
 struct hibvt_pwm_chip {
-	struct pwm_chip	chip;
 	struct clk *clk;
 	void __iomem *base;
 	struct reset_control *rstc;
@@ -65,7 +64,7 @@ static const struct hibvt_pwm_soc hi3559v100_soc_info = {
 
 static inline struct hibvt_pwm_chip *to_hibvt_pwm_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct hibvt_pwm_chip, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static void hibvt_pwm_set_bits(void __iomem *base, u32 offset,
@@ -191,12 +190,14 @@ static int hibvt_pwm_probe(struct platform_device *pdev)
 {
 	const struct hibvt_pwm_soc *soc =
 				of_device_get_match_data(&pdev->dev);
+	struct pwm_chip *chip;
 	struct hibvt_pwm_chip *hi_pwm_chip;
 	int ret, i;
 
-	hi_pwm_chip = devm_kzalloc(&pdev->dev, sizeof(*hi_pwm_chip), GFP_KERNEL);
-	if (hi_pwm_chip == NULL)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, soc->num_pwms, sizeof(*hi_pwm_chip));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	hi_pwm_chip = to_hibvt_pwm_chip(chip);
 
 	hi_pwm_chip->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(hi_pwm_chip->clk)) {
@@ -205,9 +206,7 @@ static int hibvt_pwm_probe(struct platform_device *pdev)
 		return PTR_ERR(hi_pwm_chip->clk);
 	}
 
-	hi_pwm_chip->chip.ops = &hibvt_pwm_ops;
-	hi_pwm_chip->chip.dev = &pdev->dev;
-	hi_pwm_chip->chip.npwm = soc->num_pwms;
+	chip->ops = &hibvt_pwm_ops;
 	hi_pwm_chip->soc = soc;
 
 	hi_pwm_chip->base = devm_platform_ioremap_resource(pdev, 0);
@@ -228,29 +227,28 @@ static int hibvt_pwm_probe(struct platform_device *pdev)
 	msleep(30);
 	reset_control_deassert(hi_pwm_chip->rstc);
 
-	ret = pwmchip_add(&hi_pwm_chip->chip);
+	ret = pwmchip_add(chip);
 	if (ret < 0) {
 		clk_disable_unprepare(hi_pwm_chip->clk);
 		return ret;
 	}
 
-	for (i = 0; i < hi_pwm_chip->chip.npwm; i++) {
+	for (i = 0; i < chip->npwm; i++) {
 		hibvt_pwm_set_bits(hi_pwm_chip->base, PWM_CTRL_ADDR(i),
 				PWM_KEEP_MASK, (0x1 << PWM_KEEP_SHIFT));
 	}
 
-	platform_set_drvdata(pdev, hi_pwm_chip);
+	platform_set_drvdata(pdev, chip);
 
 	return 0;
 }
 
 static void hibvt_pwm_remove(struct platform_device *pdev)
 {
-	struct hibvt_pwm_chip *hi_pwm_chip;
+	struct pwm_chip *chip = platform_get_drvdata(pdev);
+	struct hibvt_pwm_chip *hi_pwm_chip = to_hibvt_pwm_chip(chip);
 
-	hi_pwm_chip = platform_get_drvdata(pdev);
-
-	pwmchip_remove(&hi_pwm_chip->chip);
+	pwmchip_remove(chip);
 
 	reset_control_assert(hi_pwm_chip->rstc);
 	msleep(30);
-- 
2.43.0


