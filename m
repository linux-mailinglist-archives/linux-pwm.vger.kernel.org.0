Return-Path: <linux-pwm+bounces-1448-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C77585460F
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C5DF1F2E09D
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95AD014AA2;
	Wed, 14 Feb 2024 09:34:51 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED09A1AAD2
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903291; cv=none; b=XHwrX6UNai6RO7yQwe6caEzyqQ5GFg2K50xLUSbgxo4YbNY3yB/M4+wwL+7e/ut6eTOfjJh9vnkpy37/3Mgo9i90snY6/FuPsHmfJcNh5g8wPXQ5awyGEMG2Jk2mRvovfqCZdvD5cWJ3rZqaUw8Di5pv3fIUzHatMaX99QfDfnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903291; c=relaxed/simple;
	bh=1Qgr/NzRzqcCiFdlZZR2O2J75mlDqEJrmbF2tT3ET0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NxcW8fWx/9i3tQdaReTaMNQMaWmNoZj5gnGrw6YkFNNzT8r5iNrSXBh/DgaqX7opFncOhBkPoKk7pG7eOXFHUWRDfZTAVm1H7Ka0sOdp1nyHQVKdBe/TJFrsmhm51wdEP0MmEwI2KP6hYmyj3vwg8We289lfUlCWE/yEsdvJ0WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf8-00068V-P9; Wed, 14 Feb 2024 10:34:42 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf6-000fHl-38; Wed, 14 Feb 2024 10:34:40 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf6-004Y9f-04;
	Wed, 14 Feb 2024 10:34:40 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v6 145/164] pwm: vt8500: Change prototype of a helper to prepare further changes
Date: Wed, 14 Feb 2024 10:33:12 +0100
Message-ID:  <fb384c550b359e7707219f87872bcf36482875ff.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3462; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=1Qgr/NzRzqcCiFdlZZR2O2J75mlDqEJrmbF2tT3ET0s=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIjxUgcU+qSMYlFq4YJ/hbepOuW6L4PO0vo5M 2f5XcOiJg2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyI8QAKCRCPgPtYfRL+ TsfxB/9aIwQ0hN7g5dbFuO0TtCnEGaE5DEh8kVjpcTADbHTb8mOCMuFbSdDt9jbelS65P9VhSag hTKQB5lrEL+2tn65hUEX7mGbkCnj4kZST+P8Eb6W9IwsEoGjO9HwaSCBfnQaIYQdAmhY0hGvRBq 01qLbZsxNwG9J9Y9buTYN4pWh74V2G4/pwuiD2TkQioEksY3Xg352LE5R7aN5mROwkx6mpn6TUG s79nyDhSiHSqp4yMNaYhiqBYaRp6CjuMr7PRvLwp3rxBdZfm+4bWcxRhSHdWu15Uoh1wmkU6XZE 8sHirgyajST+MUbz8FmSn+X8ZqX1TfB+0zEG3nDNkYtwcqmK
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the driver for further changes that will make it harder to
determine the pwm_chip from a given vt8500_chip. To just not have to do
that, rework vt8500_pwm_busy_wait() to take a pwm_chip.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-vt8500.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-vt8500.c b/drivers/pwm/pwm-vt8500.c
index 7bfeacee05d0..3646bd45b101 100644
--- a/drivers/pwm/pwm-vt8500.c
+++ b/drivers/pwm/pwm-vt8500.c
@@ -53,8 +53,9 @@ struct vt8500_chip {
 #define to_vt8500_chip(chip)	container_of(chip, struct vt8500_chip, chip)
 
 #define msecs_to_loops(t) (loops_per_jiffy / 1000 * HZ * t)
-static inline void vt8500_pwm_busy_wait(struct vt8500_chip *vt8500, int nr, u8 bitmask)
+static inline void vt8500_pwm_busy_wait(struct pwm_chip *chip, int nr, u8 bitmask)
 {
+	struct vt8500_chip *vt8500 = to_vt8500_chip(chip);
 	int loops = msecs_to_loops(10);
 	u32 mask = bitmask << (nr << 8);
 
@@ -62,7 +63,7 @@ static inline void vt8500_pwm_busy_wait(struct vt8500_chip *vt8500, int nr, u8 b
 		cpu_relax();
 
 	if (unlikely(!loops))
-		dev_warn(vt8500->chip.dev, "Waiting for status bits 0x%x to clear timed out\n",
+		dev_warn(chip->dev, "Waiting for status bits 0x%x to clear timed out\n",
 			 mask);
 }
 
@@ -103,18 +104,18 @@ static int vt8500_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	dc = div64_u64(c, period_ns);
 
 	writel(prescale, vt8500->base + REG_SCALAR(pwm->hwpwm));
-	vt8500_pwm_busy_wait(vt8500, pwm->hwpwm, STATUS_SCALAR_UPDATE);
+	vt8500_pwm_busy_wait(chip, pwm->hwpwm, STATUS_SCALAR_UPDATE);
 
 	writel(pv, vt8500->base + REG_PERIOD(pwm->hwpwm));
-	vt8500_pwm_busy_wait(vt8500, pwm->hwpwm, STATUS_PERIOD_UPDATE);
+	vt8500_pwm_busy_wait(chip, pwm->hwpwm, STATUS_PERIOD_UPDATE);
 
 	writel(dc, vt8500->base + REG_DUTY(pwm->hwpwm));
-	vt8500_pwm_busy_wait(vt8500, pwm->hwpwm, STATUS_DUTY_UPDATE);
+	vt8500_pwm_busy_wait(chip, pwm->hwpwm, STATUS_DUTY_UPDATE);
 
 	val = readl(vt8500->base + REG_CTRL(pwm->hwpwm));
 	val |= CTRL_AUTOLOAD;
 	writel(val, vt8500->base + REG_CTRL(pwm->hwpwm));
-	vt8500_pwm_busy_wait(vt8500, pwm->hwpwm, STATUS_CTRL_UPDATE);
+	vt8500_pwm_busy_wait(chip, pwm->hwpwm, STATUS_CTRL_UPDATE);
 
 	clk_disable(vt8500->clk);
 	return 0;
@@ -135,7 +136,7 @@ static int vt8500_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	val = readl(vt8500->base + REG_CTRL(pwm->hwpwm));
 	val |= CTRL_ENABLE;
 	writel(val, vt8500->base + REG_CTRL(pwm->hwpwm));
-	vt8500_pwm_busy_wait(vt8500, pwm->hwpwm, STATUS_CTRL_UPDATE);
+	vt8500_pwm_busy_wait(chip, pwm->hwpwm, STATUS_CTRL_UPDATE);
 
 	return 0;
 }
@@ -148,7 +149,7 @@ static void vt8500_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	val = readl(vt8500->base + REG_CTRL(pwm->hwpwm));
 	val &= ~CTRL_ENABLE;
 	writel(val, vt8500->base + REG_CTRL(pwm->hwpwm));
-	vt8500_pwm_busy_wait(vt8500, pwm->hwpwm, STATUS_CTRL_UPDATE);
+	vt8500_pwm_busy_wait(chip, pwm->hwpwm, STATUS_CTRL_UPDATE);
 
 	clk_disable(vt8500->clk);
 }
@@ -168,7 +169,7 @@ static int vt8500_pwm_set_polarity(struct pwm_chip *chip,
 		val &= ~CTRL_INVERT;
 
 	writel(val, vt8500->base + REG_CTRL(pwm->hwpwm));
-	vt8500_pwm_busy_wait(vt8500, pwm->hwpwm, STATUS_CTRL_UPDATE);
+	vt8500_pwm_busy_wait(chip, pwm->hwpwm, STATUS_CTRL_UPDATE);
 
 	return 0;
 }
-- 
2.43.0


