Return-Path: <linux-pwm+bounces-1330-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D476085458A
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 120EF1C24A5E
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7262D182D4;
	Wed, 14 Feb 2024 09:34:27 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C8017BA9
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903266; cv=none; b=FEN9y2vvhX5yWV3NeMecvhb4uwyVukBi9B0aBEOQdP7o75Vw2tBS/GTeGcXIc06kuEQ1gU5aJOHjtwJO7M+pQdraLk24oABstvjN6PMyQkwACVVhK8Frpz6d78smkcDVVXf3LgFdLh1Zdz9NYlYHsu2iVSm5KkKK0WrsVCGyulY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903266; c=relaxed/simple;
	bh=htoxrxIlwaLwjopQ63rpcgTQhJzSwxqxqj++4pG3I1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DFAmZ83mhatIg76nv6A9Y7VHDYTBa0OqnY1Rw3l8ANd4UzhHwTl/aEANPfaD1PvVL4+DzUNzD8yWD6oxgd1Eu9xiexxnz2dgzOWyWEVfTlGy5CYqNd7WOzh5kbfcwyChcvR7LB0DbSuD8M5hfceYI5QIXfCJvm/L+geR/PDkq38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBem-0004SP-Jt; Wed, 14 Feb 2024 10:34:20 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBem-000f8C-12; Wed, 14 Feb 2024 10:34:20 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBel-004Y0Z-35;
	Wed, 14 Feb 2024 10:34:19 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-pwm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v6 014/164] pwm: atmel-tcb: Prepare removing pwm_chip from driver data
Date: Wed, 14 Feb 2024 10:31:01 +0100
Message-ID:  <6a90083e9d1ab1c34422161593d6d7a669143217.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2965; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=htoxrxIlwaLwjopQ63rpcgTQhJzSwxqxqj++4pG3I1o=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIhaYM8JRw/Z25vhHWsv0oehVYnQlrBF+AYGC LAxoH1LFeuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIWgAKCRCPgPtYfRL+ Tvv0B/0UXxoSjXFNxVv/oVSW5xaB3nNgJr09ya84Gy/mT/OeeN9tjbzp4XSc+YRpBAaGq672U0H CpkC2ytUTEMywuN0nYw2VZQ0hmpHr5HKkIoQUSdwCbkO8xbhwvKU+KLBHrI8Bw1urTP+WON9BeI jyMNyUDitPVhieCS50LYZbb5UMizBJCFVKL35zZlLx3kVslpSEqBB8AIz81s3oAWe8Kx++W/JS0 jCpv1NqYbX6SZoeFsQQHaat+X1Lg5Dwg4ZWyjOEo7M+gWJv/yZJ2y0Tf7KY3QA4ec2jU3l3ukUB Eg/e6b3vspTuptCQJ8ZbX0hoOUytaaKCtSiYF6EICx6G5ewW
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the driver for further changes that will drop struct
pwm_chip chip from struct atmel_tcb_pwm_chip. Use the pwm_chip as driver
data instead of the atmel_tcb_pwm_chip to get access to the pwm_chip in
the .suspend() and .resume() callbacks and atmel_tcb_pwm_remove()
without using tcbpwm->chip.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-atmel-tcb.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
index 80121ab81a01..9d928e26b403 100644
--- a/drivers/pwm/pwm-atmel-tcb.c
+++ b/drivers/pwm/pwm-atmel-tcb.c
@@ -388,6 +388,7 @@ static const struct of_device_id atmel_tcb_of_match[] = {
 
 static int atmel_tcb_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	const struct of_device_id *match;
 	struct atmel_tcb_pwm_chip *tcbpwm;
 	const struct atmel_tcb_config *config;
@@ -436,9 +437,10 @@ static int atmel_tcb_pwm_probe(struct platform_device *pdev)
 		}
 	}
 
-	tcbpwm->chip.dev = &pdev->dev;
-	tcbpwm->chip.ops = &atmel_tcb_pwm_ops;
-	tcbpwm->chip.npwm = NPWM;
+	chip = &tcbpwm->chip;
+	chip->dev = &pdev->dev;
+	chip->ops = &atmel_tcb_pwm_ops;
+	chip->npwm = NPWM;
 	tcbpwm->channel = channel;
 	tcbpwm->width = config->counter_width;
 
@@ -448,11 +450,11 @@ static int atmel_tcb_pwm_probe(struct platform_device *pdev)
 
 	spin_lock_init(&tcbpwm->lock);
 
-	err = pwmchip_add(&tcbpwm->chip);
+	err = pwmchip_add(chip);
 	if (err < 0)
 		goto err_disable_clk;
 
-	platform_set_drvdata(pdev, tcbpwm);
+	platform_set_drvdata(pdev, chip);
 
 	return 0;
 
@@ -473,9 +475,10 @@ static int atmel_tcb_pwm_probe(struct platform_device *pdev)
 
 static void atmel_tcb_pwm_remove(struct platform_device *pdev)
 {
-	struct atmel_tcb_pwm_chip *tcbpwm = platform_get_drvdata(pdev);
+	struct pwm_chip *chip = platform_get_drvdata(pdev);
+	struct atmel_tcb_pwm_chip *tcbpwm = to_tcb_chip(chip);
 
-	pwmchip_remove(&tcbpwm->chip);
+	pwmchip_remove(chip);
 
 	clk_disable_unprepare(tcbpwm->slow_clk);
 	clk_put(tcbpwm->gclk);
@@ -491,7 +494,8 @@ MODULE_DEVICE_TABLE(of, atmel_tcb_pwm_dt_ids);
 
 static int atmel_tcb_pwm_suspend(struct device *dev)
 {
-	struct atmel_tcb_pwm_chip *tcbpwm = dev_get_drvdata(dev);
+	struct pwm_chip *chip = dev_get_drvdata(dev);
+	struct atmel_tcb_pwm_chip *tcbpwm = to_tcb_chip(chip);
 	struct atmel_tcb_channel *chan = &tcbpwm->bkup;
 	unsigned int channel = tcbpwm->channel;
 
@@ -505,7 +509,8 @@ static int atmel_tcb_pwm_suspend(struct device *dev)
 
 static int atmel_tcb_pwm_resume(struct device *dev)
 {
-	struct atmel_tcb_pwm_chip *tcbpwm = dev_get_drvdata(dev);
+	struct pwm_chip *chip = dev_get_drvdata(dev);
+	struct atmel_tcb_pwm_chip *tcbpwm = to_tcb_chip(chip);
 	struct atmel_tcb_channel *chan = &tcbpwm->bkup;
 	unsigned int channel = tcbpwm->channel;
 
-- 
2.43.0


