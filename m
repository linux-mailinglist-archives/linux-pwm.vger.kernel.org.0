Return-Path: <linux-pwm+bounces-1353-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF86485459F
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E43A51C2640A
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DB918E29;
	Wed, 14 Feb 2024 09:34:30 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD07B171A3
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903270; cv=none; b=MdYIPkQ98dM0LH+mr9m2Bfc+19F40wn+Kg7CLjzTBr/fkvtp6giAts6XOSRHAWpXifLYNJcWwVS1whPxhlC2tEwG4LZFhsBi2sKuFP7XxXSfKxRq15d5GnvPRluQhhsGigFt6A6iLNQD0K/GvsW2K53gqxDGj/hwLlN3FvRkhdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903270; c=relaxed/simple;
	bh=fEmNtM/3/04R5LrWjqxrrLrYsSRfhiuJf7Od9rjIYPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UVnxuCDyV23z5vzm+FU+Omkb3qWG/UcUkSeJIj2hSVyxWFM8e/OgGk7vSPv8qz739EtPJTvyEWLpF5YbtwRQMlR9n8vS4cS0BGyucaKGsJwocPj3XVnPba5YwHFgszhpNgYN/QjaNUyov7MJCC0oznM+JUxp5twAz+sQKlnNHLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBeq-0004fs-OB; Wed, 14 Feb 2024 10:34:24 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBeq-000fBK-7o; Wed, 14 Feb 2024 10:34:24 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBeq-004Y2T-0W;
	Wed, 14 Feb 2024 10:34:24 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v6 041/164] pwm: hibvt: Consistently name driver data hi_pwm_chip
Date: Wed, 14 Feb 2024 10:31:28 +0100
Message-ID:  <66ff5a9b00889ff0c576afc783424478fbbb9853.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4962; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=fEmNtM/3/04R5LrWjqxrrLrYsSRfhiuJf7Od9rjIYPY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIh5gTxQ7LNzb+4zfbgEg1hnzcfn89lvkgQZ5 1DHJ6wWlQqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIeQAKCRCPgPtYfRL+ TitDCACMlhgd+YekLlEY7j4fnLB+IkZg2j3Au8f//ohoCpdEFOfob1Dar6BPfqrg4LFX7/GOOxi W1JPXv/4wu66twidnDut6/ob+fXuHe+napJc9Ukl1Oref48PCiggeA7llS8AJ3kQQG9bhfMCJ+6 dUe/8eG6IjlKNyh8m6SplsTFD7Amycx9zpc/lYhaMBz15X62NBQ6CO9BFNXNhgjmO2Xj03NLBH8 F5hKRZ+eEoc5AZ/7UlCHoAQFIfKx//FOC34uWHjGQF5ZFtd1NKDM8cQNnwFHIMzUBWqLwG/ShQW lBTevY8WezuXiAqBkICu02gia2LElTScbOv1Wcud2453EdQr
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

The driver uses two different names for variables of type
hibvt_pwm_chip:

	$ git grep 'struct hibvt_pwm_chip \*' v6.8-rc1 drivers/pwm/pwm-hibvt.c
	v6.8-rc1:drivers/pwm/pwm-hibvt.c:static inline struct hibvt_pwm_chip *to_hibvt_pwm_chip(struct pwm_chip *chip)
	v6.8-rc1:drivers/pwm/pwm-hibvt.c:       struct hibvt_pwm_chip *hi_pwm_chip = to_hibvt_pwm_chip(chip);
	v6.8-rc1:drivers/pwm/pwm-hibvt.c:       struct hibvt_pwm_chip *hi_pwm_chip = to_hibvt_pwm_chip(chip);
	v6.8-rc1:drivers/pwm/pwm-hibvt.c:       struct hibvt_pwm_chip *hi_pwm_chip = to_hibvt_pwm_chip(chip);
	v6.8-rc1:drivers/pwm/pwm-hibvt.c:       struct hibvt_pwm_chip *hi_pwm_chip = to_hibvt_pwm_chip(chip);
	v6.8-rc1:drivers/pwm/pwm-hibvt.c:       struct hibvt_pwm_chip *hi_pwm_chip = to_hibvt_pwm_chip(chip);
	v6.8-rc1:drivers/pwm/pwm-hibvt.c:       struct hibvt_pwm_chip *hi_pwm_chip = to_hibvt_pwm_chip(chip);
	v6.8-rc1:drivers/pwm/pwm-hibvt.c:       struct hibvt_pwm_chip *pwm_chip;
	v6.8-rc1:drivers/pwm/pwm-hibvt.c:       struct hibvt_pwm_chip *pwm_chip;

Most functions use "hi_pwm_chip" as name. Make use of this in the
remaining two functions (that used "pwm_chip" before, which isn't
optimal as this is a type name, too).

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-hibvt.c | 64 ++++++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/pwm/pwm-hibvt.c b/drivers/pwm/pwm-hibvt.c
index c435776e2f78..f1039be0f4e4 100644
--- a/drivers/pwm/pwm-hibvt.c
+++ b/drivers/pwm/pwm-hibvt.c
@@ -191,72 +191,72 @@ static int hibvt_pwm_probe(struct platform_device *pdev)
 {
 	const struct hibvt_pwm_soc *soc =
 				of_device_get_match_data(&pdev->dev);
-	struct hibvt_pwm_chip *pwm_chip;
+	struct hibvt_pwm_chip *hi_pwm_chip;
 	int ret, i;
 
-	pwm_chip = devm_kzalloc(&pdev->dev, sizeof(*pwm_chip), GFP_KERNEL);
-	if (pwm_chip == NULL)
+	hi_pwm_chip = devm_kzalloc(&pdev->dev, sizeof(*hi_pwm_chip), GFP_KERNEL);
+	if (hi_pwm_chip == NULL)
 		return -ENOMEM;
 
-	pwm_chip->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(pwm_chip->clk)) {
+	hi_pwm_chip->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(hi_pwm_chip->clk)) {
 		dev_err(&pdev->dev, "getting clock failed with %ld\n",
-				PTR_ERR(pwm_chip->clk));
-		return PTR_ERR(pwm_chip->clk);
+				PTR_ERR(hi_pwm_chip->clk));
+		return PTR_ERR(hi_pwm_chip->clk);
 	}
 
-	pwm_chip->chip.ops = &hibvt_pwm_ops;
-	pwm_chip->chip.dev = &pdev->dev;
-	pwm_chip->chip.npwm = soc->num_pwms;
-	pwm_chip->soc = soc;
+	hi_pwm_chip->chip.ops = &hibvt_pwm_ops;
+	hi_pwm_chip->chip.dev = &pdev->dev;
+	hi_pwm_chip->chip.npwm = soc->num_pwms;
+	hi_pwm_chip->soc = soc;
 
-	pwm_chip->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(pwm_chip->base))
-		return PTR_ERR(pwm_chip->base);
+	hi_pwm_chip->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(hi_pwm_chip->base))
+		return PTR_ERR(hi_pwm_chip->base);
 
-	ret = clk_prepare_enable(pwm_chip->clk);
+	ret = clk_prepare_enable(hi_pwm_chip->clk);
 	if (ret < 0)
 		return ret;
 
-	pwm_chip->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
-	if (IS_ERR(pwm_chip->rstc)) {
-		clk_disable_unprepare(pwm_chip->clk);
-		return PTR_ERR(pwm_chip->rstc);
+	hi_pwm_chip->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
+	if (IS_ERR(hi_pwm_chip->rstc)) {
+		clk_disable_unprepare(hi_pwm_chip->clk);
+		return PTR_ERR(hi_pwm_chip->rstc);
 	}
 
-	reset_control_assert(pwm_chip->rstc);
+	reset_control_assert(hi_pwm_chip->rstc);
 	msleep(30);
-	reset_control_deassert(pwm_chip->rstc);
+	reset_control_deassert(hi_pwm_chip->rstc);
 
-	ret = pwmchip_add(&pwm_chip->chip);
+	ret = pwmchip_add(&hi_pwm_chip->chip);
 	if (ret < 0) {
-		clk_disable_unprepare(pwm_chip->clk);
+		clk_disable_unprepare(hi_pwm_chip->clk);
 		return ret;
 	}
 
-	for (i = 0; i < pwm_chip->chip.npwm; i++) {
-		hibvt_pwm_set_bits(pwm_chip->base, PWM_CTRL_ADDR(i),
+	for (i = 0; i < hi_pwm_chip->chip.npwm; i++) {
+		hibvt_pwm_set_bits(hi_pwm_chip->base, PWM_CTRL_ADDR(i),
 				PWM_KEEP_MASK, (0x1 << PWM_KEEP_SHIFT));
 	}
 
-	platform_set_drvdata(pdev, pwm_chip);
+	platform_set_drvdata(pdev, hi_pwm_chip);
 
 	return 0;
 }
 
 static void hibvt_pwm_remove(struct platform_device *pdev)
 {
-	struct hibvt_pwm_chip *pwm_chip;
+	struct hibvt_pwm_chip *hi_pwm_chip;
 
-	pwm_chip = platform_get_drvdata(pdev);
+	hi_pwm_chip = platform_get_drvdata(pdev);
 
-	pwmchip_remove(&pwm_chip->chip);
+	pwmchip_remove(&hi_pwm_chip->chip);
 
-	reset_control_assert(pwm_chip->rstc);
+	reset_control_assert(hi_pwm_chip->rstc);
 	msleep(30);
-	reset_control_deassert(pwm_chip->rstc);
+	reset_control_deassert(hi_pwm_chip->rstc);
 
-	clk_disable_unprepare(pwm_chip->clk);
+	clk_disable_unprepare(hi_pwm_chip->clk);
 }
 
 static const struct of_device_id hibvt_pwm_of_match[] = {
-- 
2.43.0


