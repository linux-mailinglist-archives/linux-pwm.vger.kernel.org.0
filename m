Return-Path: <linux-pwm+bounces-1327-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED73D85458B
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A6081F2E107
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1107D1757A;
	Wed, 14 Feb 2024 09:34:27 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA0217591
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903266; cv=none; b=sJmQ/Yk73k0lnvo7n4F1gWgool9MyQqwskmaM+wQQLZrdftkS/O7qJwiUCBclw6RHJw9k4Xlum5qZpRY+lDuVqsY75Hkns8Xt76d79J5ewLhvGP7iBw89fuSPJoPiGFGyS/Nsu18i/F9uuzEiReA01Rq+42bzJlJy+Z7/9QPHKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903266; c=relaxed/simple;
	bh=Rp6ms6WkZNK491Y5s2TXYi7yhvxwpC5Fds/QTE2oV90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TaTB5PN3M02HrGmApmYaUlp2+zW4VmgfwDwgMr46nAYhpORYA9q9Vd0xcF2tKlZiWrlKRURfS5KZlLV7ToNoN1pBz8/cqSg0G3RJdv+By514U7Sm85nHAFwCOAGvRzxyPdw7JujTNpGzRIHWAV3GThggdbJ8ScFZO+Vmf4JhnDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBen-0004Vc-F6; Wed, 14 Feb 2024 10:34:21 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBem-000f8u-Qr; Wed, 14 Feb 2024 10:34:20 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBem-004Y0t-2Q;
	Wed, 14 Feb 2024 10:34:20 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	linux-pwm@vger.kernel.org
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	kernel@pengutronix.de
Subject: [PATCH v6 019/164] pwm: bcm-kona: Make use of devm_pwmchip_alloc() function
Date: Wed, 14 Feb 2024 10:31:06 +0100
Message-ID:  <b50fe94dc72af602e7061839b24f48af6e005ef8.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2151; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=Rp6ms6WkZNK491Y5s2TXYi7yhvxwpC5Fds/QTE2oV90=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtQzHQkTPV+5S7p9+Ji87pymrUh6RQqDhtS1/8Gb5XTqk j0uvXLqZDRiYWDkYpAVU2Sxb1yTaVUlF9m59t9lmEGsTCBTGLg4BWAidg/Zf/Snbnlie/OVq/yG 1wts915427jMsShL1nNWXVR+fJO59XvB5VvedYuoCZRP+r31hLnZ2qXVtlf6L7jw3lRfJcInpdm 9JZm5K/KZbUu73wGPhwlTXj45F8ZhpOG//G5S1bKl5sd2Bhya6n9YnNFLb3KJTUHRWyHLTx+V2l 6m7O0XdXgX/02xsirnYtDD5hv1OTxK/D3FC6bNydm79dSdA/liZj7vhOrSM+5LzfvA++fTdImFq l+eJvowfpc1DeI7m+C45AlTSuZv/zB34b0ndnx5+SXOOb/8jHn28YdbfvP3hEk/F63e71Sp/aGM hetMrp74z2Lf/WIZHYZJqz7222SHete83//RU2RCuD0A
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
 drivers/pwm/pwm-bcm-kona.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-bcm-kona.c b/drivers/pwm/pwm-bcm-kona.c
index 47acae8d7478..022c078aae84 100644
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
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 6, sizeof(*kp));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
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


