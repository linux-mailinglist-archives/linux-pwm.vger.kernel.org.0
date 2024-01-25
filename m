Return-Path: <linux-pwm+bounces-980-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A258D83C1CE
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4AE01C2261F
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DA63D97F;
	Thu, 25 Jan 2024 12:10:53 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B26041742
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184653; cv=none; b=nuZMd8LkqiFVE11oUIYjVKqZJLpCzgvpzLph4NPSYeUuSZ8UcCydmHpuldyWvMO0jov0bHzwiRIfN4fMbHbzB8keWlZAnf8spMHe+ppxwhWYSzWz8BHU6MM74ZoaSNrqCoRH1pCpoWPVN4kHGKI+iGKMRTlPPNWUnY11GOMKmuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184653; c=relaxed/simple;
	bh=p+aAC78UNyRUwHwUsSPfi3rt5IvRRtbIKuH958+lNnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MZ9VfeajE3l1sY1bm80HjlkVIXgy1qVsTMniJaclMdVTukRwreQCZ5gwc9CfQyIYy1M+EwDjQkI0FU8N4qc0IGqPwtAY9dkPgOA01Ib2cm9Iq1ymHw1EQmh9xTiAglbI0EaBx93IN7o4Ytow2YiSPPo3ABsi6BxyJrqY9WVDfqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZG-0004G4-AA; Thu, 25 Jan 2024 13:10:50 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZF-002HRm-Ji; Thu, 25 Jan 2024 13:10:49 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZF-007n1L-1i;
	Thu, 25 Jan 2024 13:10:49 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	linux-pwm@vger.kernel.org
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	kernel@pengutronix.de
Subject: [PATCH v5 048/111] pwm: bcm-kona: Make use of devm_pwmchip_alloc() function
Date: Thu, 25 Jan 2024 13:09:10 +0100
Message-ID:  <33ae6686c922d94f59d971d7eded95717ad1cece.1706182805.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2122; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=p+aAC78UNyRUwHwUsSPfi3rt5IvRRtbIKuH958+lNnk=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtRN/kXrd89ccCD/TcttxXaDbZPc494YrBKQ32Gxh2tlf iZblIJRJ6MxCwMjF4OsmCKLfeOaTKsqucjOtf8uwwxiZQKZwsDFKQAT6elh/2ezI3KesSX7+9uT thZdv+2Ua8sYrvt5pRrDEhmR6HPb7NhV5D89iH3OF1nwomuy97Qyq0zZ1j9njikqenPwrGJYkDv BpOCKg3hKaL5EVFzEkbfLjjaYz86VT+Yx1r2UP6dZ/h+byskbjd5d2lxSH6r1LWpCvArMZ/vIlK qxrc6w3x82P3jlSg+ri1PLV3zPPsZgPPPgJw3evgY/o8gMq52HJm0urt/cvUjsXpVRv0z/X3m1w 8F5it4XrV7+2uL7WC+1+TDL0nmSy/wfv2msOiBkWbFNtPTc/D95Rtr/nMpc+1UUtGevcdMQea2l eGcb6zwWmTrB22n5Zedett55/6ZE3qfZ2+9Qrdal4iMA
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-bcm-kona driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-bcm-kona.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-bcm-kona.c b/drivers/pwm/pwm-bcm-kona.c
index 47acae8d7478..91eab525aedd 100644
--- a/drivers/pwm/pwm-bcm-kona.c
+++ b/drivers/pwm/pwm-bcm-kona.c
@@ -56,14 +56,13 @@
 #define DUTY_CYCLE_HIGH_MAX			0x00ffffff
 
 struct kona_pwmc {
-	struct pwm_chip chip;
 	void __iomem *base;
 	struct clk *clk;
 };
 
 static inline struct kona_pwmc *to_kona_pwmc(struct pwm_chip *chip)
 {
-	return container_of(chip, struct kona_pwmc, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 /*
@@ -273,18 +272,18 @@ static const struct pwm_ops kona_pwm_ops = {
 
 static int kona_pwmc_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct kona_pwmc *kp;
 	unsigned int chan;
 	unsigned int value = 0;
 	int ret = 0;
 
-	kp = devm_kzalloc(&pdev->dev, sizeof(*kp), GFP_KERNEL);
-	if (kp == NULL)
+	chip = devm_pwmchip_alloc(&pdev->dev, 6, sizeof(*kp));
+	if (chip == NULL)
 		return -ENOMEM;
+	kp = to_kona_pwmc(chip);
 
-	kp->chip.dev = &pdev->dev;
-	kp->chip.ops = &kona_pwm_ops;
-	kp->chip.npwm = 6;
+	chip->ops = &kona_pwm_ops;
 
 	kp->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(kp->base))
@@ -304,14 +303,14 @@ static int kona_pwmc_probe(struct platform_device *pdev)
 	}
 
 	/* Set push/pull for all channels */
-	for (chan = 0; chan < kp->chip.npwm; chan++)
+	for (chan = 0; chan < chip->npwm; chan++)
 		value |= (1 << PWM_CONTROL_TYPE_SHIFT(chan));
 
 	writel(value, kp->base + PWM_CONTROL_OFFSET);
 
 	clk_disable_unprepare(kp->clk);
 
-	ret = devm_pwmchip_add(&pdev->dev, &kp->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0)
 		dev_err(&pdev->dev, "failed to add PWM chip: %d\n", ret);
 
-- 
2.43.0


