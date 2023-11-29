Return-Path: <linux-pwm+bounces-227-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BAD7FD1DE
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Nov 2023 10:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 622941C20EE9
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Nov 2023 09:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E467134B3;
	Wed, 29 Nov 2023 09:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="IFiTmvyg";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="HZqr3Bk0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F7B19BF;
	Wed, 29 Nov 2023 01:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1701249247; bh=GDt/QGFqEdFRkVDZgETPHCj6Jv9POqOqoTfpWoZLvRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IFiTmvygiy0uzNbZVDFBQ+6YkB4Xw8LjiUtZdUXgHEvQAqNhQ6nXcUDTuacv9OEoM
	 wSZAXPSkX4KeTFdv1eY5eLMfY5fCgz9kpbk4mrne8HWGqYdtEjBhQuXSR+kmEL8JbL
	 OYTY2yT/ZcHpwSFpuylcaI3xSU9puvE16RMiEcPLOg2NZM/7C2XHypCniIcQKZulda
	 a4Q1rlrXCekCFN1q5RVfPbVkEcCk5kqYr85CnPGQSxJIjEhWs7yzGx3/oRIOfqAoWi
	 nIiwEeaBobENupOsD8kSyerYHWNj6XNxVrtNJAqqC3g/gzEr3YzAJ7yfH/JshpQHjV
	 Lk4UY1PfxJBjQ==
Received: by gofer.mess.org (Postfix, from userid 501)
	id 3EC8F10029D; Wed, 29 Nov 2023 09:14:07 +0000 (GMT)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1701249229; bh=GDt/QGFqEdFRkVDZgETPHCj6Jv9POqOqoTfpWoZLvRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HZqr3Bk07ZBh1TRRzsBJ3LgIh08ANfvAMRdGG3FuykyEvfE4w7BXktSqJKsP7UMLD
	 kjfzaH7uM0BlNWPQuBXRLKAKfc+Cbzgdj0ywskPQsajoOu6SD0eTaEQe7wnunRxXqw
	 brvA3SUE0eXFRXNBUjt+plaCy+58GmBy0Q9IH8aVNiveAilEtBnAVSoiAkDCxR4s3Q
	 BR75PFAIDjXVMvLnvop57oIlOl7A4780cJeg71BPXSq34BDM2hIzgW3DbhTHcl8Ifk
	 hq2HkyeLxjrpUXeoBc7DtaS31j+iZmJZ8XVLxSz3OxnEOvNivOg2hmp+rebjAfduD9
	 9KfTRtDJw8cGg==
Received: from localhost.localdomain (bigcore-99.local [IPv6:2a02:8011:d000:212:ca7f:54ff:fe51:14d6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gofer.mess.org (Postfix) with ESMTPSA id 49223100101;
	Wed, 29 Nov 2023 09:13:49 +0000 (GMT)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>
Cc: Sean Young <sean@mess.org>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/4] pwm: bcm2835: allow pwm driver to be used in atomic context
Date: Wed, 29 Nov 2023 09:13:36 +0000
Message-ID: <179dc1ce85702a8b64b43c0e0df656b0c5e3ce30.1701248996.git.sean@mess.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1701248996.git.sean@mess.org>
References: <cover.1701248996.git.sean@mess.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

clk_get_rate() may do a mutex lock. Fetch the clock rate once, and prevent
rate changes using clk_rate_exclusive_get().

Signed-off-by: Sean Young <sean@mess.org>
---
 drivers/pwm/pwm-bcm2835.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
index 9777babd5b95..52748194a3da 100644
--- a/drivers/pwm/pwm-bcm2835.c
+++ b/drivers/pwm/pwm-bcm2835.c
@@ -28,6 +28,7 @@ struct bcm2835_pwm {
 	struct device *dev;
 	void __iomem *base;
 	struct clk *clk;
+	unsigned long rate;
 };
 
 static inline struct bcm2835_pwm *to_bcm2835_pwm(struct pwm_chip *chip)
@@ -63,17 +64,11 @@ static int bcm2835_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 {
 
 	struct bcm2835_pwm *pc = to_bcm2835_pwm(chip);
-	unsigned long rate = clk_get_rate(pc->clk);
 	unsigned long long period_cycles;
 	u64 max_period;
 
 	u32 val;
 
-	if (!rate) {
-		dev_err(pc->dev, "failed to get clock rate\n");
-		return -EINVAL;
-	}
-
 	/*
 	 * period_cycles must be a 32 bit value, so period * rate / NSEC_PER_SEC
 	 * must be <= U32_MAX. As U32_MAX * NSEC_PER_SEC < U64_MAX the
@@ -88,13 +83,13 @@ static int bcm2835_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * <=> period < ((U32_MAX * NSEC_PER_SEC + NSEC_PER_SEC/2) / rate
 	 * <=> period <= ceil((U32_MAX * NSEC_PER_SEC + NSEC_PER_SEC/2) / rate) - 1
 	 */
-	max_period = DIV_ROUND_UP_ULL((u64)U32_MAX * NSEC_PER_SEC + NSEC_PER_SEC / 2, rate) - 1;
+	max_period = DIV_ROUND_UP_ULL((u64)U32_MAX * NSEC_PER_SEC + NSEC_PER_SEC / 2, pc->rate) - 1;
 
 	if (state->period > max_period)
 		return -EINVAL;
 
 	/* set period */
-	period_cycles = DIV_ROUND_CLOSEST_ULL(state->period * rate, NSEC_PER_SEC);
+	period_cycles = DIV_ROUND_CLOSEST_ULL(state->period * pc->rate, NSEC_PER_SEC);
 
 	/* don't accept a period that is too small */
 	if (period_cycles < PERIOD_MIN)
@@ -103,7 +98,7 @@ static int bcm2835_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	writel(period_cycles, pc->base + PERIOD(pwm->hwpwm));
 
 	/* set duty cycle */
-	val = DIV_ROUND_CLOSEST_ULL(state->duty_cycle * rate, NSEC_PER_SEC);
+	val = DIV_ROUND_CLOSEST_ULL(state->duty_cycle * pc->rate, NSEC_PER_SEC);
 	writel(val, pc->base + DUTY(pwm->hwpwm));
 
 	/* set polarity */
@@ -151,14 +146,29 @@ static int bcm2835_pwm_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(pc->clk),
 				     "clock not found\n");
 
+	ret = clk_rate_exclusive_get(pc->clk);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "fail to get exclusive rate\n");
+
+	pc->rate = clk_get_rate(pc->clk);
+	if (!pc->rate) {
+		clk_rate_exclusive_put(pc->clk);
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "failed to get clock rate\n");
+	}
+
 	pc->chip.dev = &pdev->dev;
 	pc->chip.ops = &bcm2835_pwm_ops;
+	pc->chip.atomic = true;
 	pc->chip.npwm = 2;
 
 	ret = devm_pwmchip_add(&pdev->dev, &pc->chip);
-	if (ret < 0)
+	if (ret < 0) {
+		clk_rate_exclusive_put(pc->clk);
 		return dev_err_probe(&pdev->dev, ret,
 				     "failed to add pwmchip\n");
+	}
 
 	return 0;
 }
@@ -167,6 +177,7 @@ static int bcm2835_pwm_suspend(struct device *dev)
 {
 	struct bcm2835_pwm *pc = dev_get_drvdata(dev);
 
+	clk_rate_exclusive_put(pc->clk);
 	clk_disable_unprepare(pc->clk);
 
 	return 0;
-- 
2.43.0


