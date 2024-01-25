Return-Path: <linux-pwm+bounces-976-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9FE83C1CD
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F9CB1C22A90
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE078376E1;
	Thu, 25 Jan 2024 12:10:52 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957F345030
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184652; cv=none; b=fc9oHrbdlP6WMDglqn7t62XbHkEn34zTNGGXr2RNv6lWgn4gSIP/06Ag+3XMQut1r8cyorUhHXSMVlTAZe4+LUUzm5ZV4Fvj0xpmDOrFYVcNza6aVa5C4clXgAz421EMyW8ob5NSKyg8fLekcT6CSZPmuRSQeIMQSkjUo6uAQBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184652; c=relaxed/simple;
	bh=6N+OroGyfr8Zv9hj4gyioNXSGQtISRkgGmItwvdinxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GxBN/APqMYpWgChWky9/s/kMf42mz+2SwnjDXzB2St8zKOFDI942B48KtRXltogluxRfsC88rZBVgTWQXzDioBgAJFX7NGxkzLlc4yDpa7gxSyghJMZF0f8OjDbhJS+K7tdI2HNywdcY97L3ro5dVwBZHiuwEBIW8syn4q7/ioU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZE-00043y-59; Thu, 25 Jan 2024 13:10:48 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZD-002HQx-3B; Thu, 25 Jan 2024 13:10:47 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZD-007n0Y-05;
	Thu, 25 Jan 2024 13:10:47 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v5 036/111] pwm: vt8500: Make use of pwmchip_parent() macro
Date: Thu, 25 Jan 2024 13:08:58 +0100
Message-ID:  <fd4fc1503a00838679d05b5d1eb249e2bc50ed35.1706182805.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3929; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=6N+OroGyfr8Zv9hj4gyioNXSGQtISRkgGmItwvdinxg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk9j/mLFlyrsxTGO2eCSVCFlG6ZLpf+YL32wz bb53hfgDkuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPYwAKCRCPgPtYfRL+ TtR7CAC4qdbDwKFYVfHl7bjXxXjZ0IpOEkbbINYFcsKJStB5zCgCUS7Ye+h8SqVh7heSBrAcADD kHQRfEeFK3eMsRtddqOEYFseKqx9AElNZL5e414ne0dbfYNcaiLopllhHZQ4YBnRO8xMeqgUgCf ms6Ou7+jV/2OVHj49gJlHSx/CbWFgPlIXjevUlqEnNzayW3CuEn9MiqpU6bxuKBmEr3UO7NfWvE kVyQVTfMM/wMnK8ZUrtnTO6V06lYQJvLHtFMfme/LrTyPna1yWS2ualr8EKrTPbKdJro7TTvP/o RS30qWYBqzmqfBO1zuKKkjuBl/aN6qsPQ0VouEZ1RS14PHvF
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

struct pwm_chip::dev is about to change. To not have to touch this
driver in the same commit as struct pwm_chip::dev, use the macro
provided for exactly this purpose.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-vt8500.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-vt8500.c b/drivers/pwm/pwm-vt8500.c
index 7bfeacee05d0..def48dbef808 100644
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
+		dev_warn(pwmchip_parent(chip), "Waiting for status bits 0x%x to clear timed out\n",
 			 mask);
 }
 
@@ -77,7 +78,7 @@ static int vt8500_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	err = clk_enable(vt8500->clk);
 	if (err < 0) {
-		dev_err(chip->dev, "failed to enable clock\n");
+		dev_err(pwmchip_parent(chip), "failed to enable clock\n");
 		return err;
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
@@ -128,14 +129,14 @@ static int vt8500_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	err = clk_enable(vt8500->clk);
 	if (err < 0) {
-		dev_err(chip->dev, "failed to enable clock\n");
+		dev_err(pwmchip_parent(chip), "failed to enable clock\n");
 		return err;
 	}
 
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


