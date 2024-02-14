Return-Path: <linux-pwm+bounces-1405-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B098545E0
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5CB21F2E0FB
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9362018E1A;
	Wed, 14 Feb 2024 09:34:42 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364ADBE5B
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903282; cv=none; b=uzl/hMGbV2CIJPv9LzAJwqbQGHjAyFOBC2fahmkCffUxFKOdE6jh8GdUj0v4O4fvno1tMGINrUiVa6Y4ZtC7V48AFUcQaqClDpSJjV5bETMG5AImSu3psaXjH2eLaPLSz6UQjABrIOV7BFJfy7TvDdncA8YL7VpsoYI4fXkpLOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903282; c=relaxed/simple;
	bh=ViTqmKWt5YJyzdBvkVYG+ax97Q2r0ilyHWpgHz56pgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d6Sv25I5IVVSMgvW+tiVvKRNDsmlmxsK44y2cTDeUcJz1y6ECN10Kab7idyP97y31NHSVv1ywfj8cjNOck7vGTrRk335sQsgWJG62kxZjIX/UJ5jS6RX74qeYnBSELF9lPS0UHEamnmOg3L9iz7EBsDa9q1yhkDchuOUJgqPgPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf0-0005Md-3Z; Wed, 14 Feb 2024 10:34:34 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBex-000fEI-OI; Wed, 14 Feb 2024 10:34:31 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBex-004Y5m-2B;
	Wed, 14 Feb 2024 10:34:31 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v6 090/164] pwm: renesas-tpu: Make use of devm_pwmchip_alloc() function
Date: Wed, 14 Feb 2024 10:32:17 +0100
Message-ID:  <aac4a9546b0f474d991144aa925c83cfa7abe2c0.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2359; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=ViTqmKWt5YJyzdBvkVYG+ax97Q2r0ilyHWpgHz56pgA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIiygkwgt829TgdcS7KheuhOA7LECDdMAgYEr u463mYTOfaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIsgAKCRCPgPtYfRL+ TiioB/9MrwDJ6Sfim1BbQSJVZnG9psXDyoUmI9dQ4wu2SBLteQC9Lo3NjsEFvHgxluBMJc9eRwd 2B47c7UELd3D8VgiUEij0POhqUwzZkZa7Se020/iZNAeDqmZBtK3T6dy6NUN8Mjp5aorIqfg3Yn Vlo4P4abg8vkfhx66niBUmo2Tq07iVyR+DcxezmY4TAvuRkqbennII92Dy+GeGSk9sWfRVTci3w +tY/qgHJb87OE68ss/L8CTyx6T32o2qYHj9QkKivdqlPa+n/rhjKK24+ye6cDsasUjsABp411gg /nVhJbIumNL6P/YbfRJ2AHdq6YvDksluXnC3xExOK/i5Q2N2
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-renesas-tpu driver to further changes of the pwm
core outlined in the commit introducing devm_pwmchip_alloc(). There is
no intended semantical change and the driver should behave as before.

Also convert the to_tpu_device() helper macro to a static inline to get
some type safety.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-renesas-tpu.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-renesas-tpu.c b/drivers/pwm/pwm-renesas-tpu.c
index 28265fdfc92a..2196080b4177 100644
--- a/drivers/pwm/pwm-renesas-tpu.c
+++ b/drivers/pwm/pwm-renesas-tpu.c
@@ -79,7 +79,6 @@ struct tpu_pwm_device {
 
 struct tpu_device {
 	struct platform_device *pdev;
-	struct pwm_chip chip;
 	spinlock_t lock;
 
 	void __iomem *base;
@@ -87,7 +86,10 @@ struct tpu_device {
 	struct tpu_pwm_device tpd[TPU_CHANNEL_MAX];
 };
 
-#define to_tpu_device(c)	container_of(c, struct tpu_device, chip)
+static inline struct tpu_device *to_tpu_device(struct pwm_chip *chip)
+{
+	return pwmchip_get_drvdata(chip);
+}
 
 static void tpu_pwm_write(struct tpu_pwm_device *tpd, int reg_nr, u16 value)
 {
@@ -438,12 +440,14 @@ static const struct pwm_ops tpu_pwm_ops = {
 
 static int tpu_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct tpu_device *tpu;
 	int ret;
 
-	tpu = devm_kzalloc(&pdev->dev, sizeof(*tpu), GFP_KERNEL);
-	if (tpu == NULL)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, TPU_CHANNEL_MAX, sizeof(*tpu));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	tpu = to_tpu_device(chip);
 
 	spin_lock_init(&tpu->lock);
 	tpu->pdev = pdev;
@@ -460,15 +464,13 @@ static int tpu_probe(struct platform_device *pdev)
 	/* Initialize and register the device. */
 	platform_set_drvdata(pdev, tpu);
 
-	tpu->chip.dev = &pdev->dev;
-	tpu->chip.ops = &tpu_pwm_ops;
-	tpu->chip.npwm = TPU_CHANNEL_MAX;
+	chip->ops = &tpu_pwm_ops;
 
 	ret = devm_pm_runtime_enable(&pdev->dev);
 	if (ret < 0)
 		return dev_err_probe(&pdev->dev, ret, "Failed to enable runtime PM\n");
 
-	ret = devm_pwmchip_add(&pdev->dev, &tpu->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0)
 		return dev_err_probe(&pdev->dev, ret, "Failed to register PWM chip\n");
 
-- 
2.43.0


