Return-Path: <linux-pwm+bounces-1023-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7650C83C202
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C4161F20F9B
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B33C376E1;
	Thu, 25 Jan 2024 12:11:02 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC6B3A1B6
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184662; cv=none; b=XqgYGogjTrzqttdbFJr/fF+dE9Hj17/xDcDx9cmJNU6lFYbe67teMOYopEH/f7vPYFgOJNduASrJQrHHr9ZOypsOTztw2lWajoFnJlCLWBfG9yZQITEkTAeYs5UEqKsWV0jRG7ugb6EDLgwF77oQmkXdoKkTcKKLWiSk6I/oiXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184662; c=relaxed/simple;
	bh=AqCy7Z2oVcAAzlatiEtHnhmNKcs9T74A/W5aS85/uq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lNKF/W5Z1kJaLpV0Xu4deAf8PA+A+5wGesQm33qnI6S1O/z6z/CYQsq5Y7lYKfL5DpuYRip2ndVeT1Ain3VDdpcIvwmAPL4n159vp4xdI+tn9jEPakBB2ZmlDVrM6adYBPxxixtVlvO5KJnCEj7DkdZtT9KRWjql1HTMgK39s+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZN-0004VJ-PQ; Thu, 25 Jan 2024 13:10:57 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZM-002HU0-3f; Thu, 25 Jan 2024 13:10:56 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZM-007n3c-07;
	Thu, 25 Jan 2024 13:10:56 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v5 082/111] pwm: renesas-tpu: Make use of devm_pwmchip_alloc() function
Date: Thu, 25 Jan 2024 13:09:44 +0100
Message-ID:  <8ca07b1b06b653ea296ce8a6e65a35762d33f0bf.1706182805.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706182805.git.u.kleine-koenig@pengutronix.de>
References: <cover.1706182805.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2237; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=AqCy7Z2oVcAAzlatiEtHnhmNKcs9T74A/W5aS85/uq8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk+ayzKrhMadaGLmuZrFQ9GFa2S5ppX5lpiAO MPexUSRj4CJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPmgAKCRCPgPtYfRL+ TpIMB/9U79nw1V4L6UymabxtIzDtlZI+O5mWwA+bjaR76ShW9PUvcC51svzn5oaRrXfUUHFE39c UXuDScTbpEdRVljcRitZ4qksbk0DlC1jvRUIIaJoqFyPCMEsW7uy6V6RH5E4KUEsfx9WRNacAFT BMNzy0ctCN7indysMgkcC0NJZWoxUyS5uS4LqIYeXJlkcswfeiJXiFBzIoFTEQDihjPhsCa2g4B iBoi4SzetsEwYe3XcWYdbr0vkz/o1t0l4USaOx1as5nZGAURsXhesJ1Ew5rk1FRghDxxBHGai85 d4K70oVIBHUfk/kMnVM40aGPFpn97ILObrJ9kb0GjvV+/FjB
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-renesas-tpu driver to further changes of the pwm
core outlined in the commit introducing devm_pwmchip_alloc(). There is
no intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-renesas-tpu.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-renesas-tpu.c b/drivers/pwm/pwm-renesas-tpu.c
index 28265fdfc92a..eeddda460636 100644
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
+	chip = devm_pwmchip_alloc(&pdev->dev, TPU_CHANNEL_MAX, sizeof(*tpu));
+	if (chip == NULL)
 		return -ENOMEM;
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


