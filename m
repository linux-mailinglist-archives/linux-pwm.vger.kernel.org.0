Return-Path: <linux-pwm+bounces-1324-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C76854585
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98D7B1C22DF5
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC861805A;
	Wed, 14 Feb 2024 09:34:26 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7531758D
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903266; cv=none; b=RNb+fgr3RH7Shh+oRtJMxSY7vdedvF73q1bM30Lf9jDk9xOFsRpNtmR5iTRdHOJUIFCRZB5oZwB63GO7KrMx7bvOt+AQ+hDgRUsuD5vKqfcUVojefy/sUjM1eQH2qnIN6BDuWgHXXAl5UifahsTrs04H1vdc5m1BabQcJKzganM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903266; c=relaxed/simple;
	bh=KnJ19DF+WYdolraq2C+RV1Rwrj5TWFY7glRMFg+qlK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jtdu6BniETmXtEjrUTtF3kvD1VU7mSLd0KLqs5a9ZR1EhRvhXpqVoRieYFgkRIcfO7PA/o99qw3pnG4LKJA/PG9E4BecFmWUaL0f5RaCG6blk0PONwyVI8lRPF6duKcpqs3zzcgUe+0mP61vs19WoWC2AwUpq9wHs7BVVRYZ2eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBen-0004UT-8u; Wed, 14 Feb 2024 10:34:21 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBem-000f8e-Ep; Wed, 14 Feb 2024 10:34:20 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBem-004Y0l-1E;
	Wed, 14 Feb 2024 10:34:20 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	linux-pwm@vger.kernel.org
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v6 017/164] pwm: bcm-iproc: Make use of devm_pwmchip_alloc() function
Date: Wed, 14 Feb 2024 10:31:04 +0100
Message-ID:  <cdc6136b94f685c85a615e9e5ccbd7ebb2f91cfc.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2342; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=KnJ19DF+WYdolraq2C+RV1Rwrj5TWFY7glRMFg+qlK4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIheKEVCvLf3W1vo7atdEGBV8Qi8xXrKZ/eME FZYt9i8PuiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIXgAKCRCPgPtYfRL+ TqPhCACkRtK8KG9coWWk42cklp0ktcb66RYZrRbGZjg1wuD5N8S87cZLU/PKMPwaF/ABq0G5eLD zhfC1A5UHvXXyP9Fyot9cod5HVYJauIRVms+VH/Yp5Be9qIt4zerV9xkQgtUcUXrupRHiOZ8rFB En+40kLR8OuWUSFrNKqd19EXYGEZNVT6JmvPyu5j0Wt4xS2UX0cZPVDPIM/WKZcg8GYhFIbwzTn 3OSk3bAS/TqzatTjYfMLACUhH1dC1Umm23xcRn4Qoz2wZDGc/D4Fguqkb19miWdrYp92Kyt+1vi 2EQ97qFUbzH+TwpWEGNm+54KVPBlS1jbS+jPkrO50tr3QBXD
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-bcm-iproc driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-bcm-iproc.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-bcm-iproc.c b/drivers/pwm/pwm-bcm-iproc.c
index 758254025683..f4c9f10e490e 100644
--- a/drivers/pwm/pwm-bcm-iproc.c
+++ b/drivers/pwm/pwm-bcm-iproc.c
@@ -34,14 +34,13 @@
 #define IPROC_PWM_PRESCALE_MAX			0x3f
 
 struct iproc_pwmc {
-	struct pwm_chip chip;
 	void __iomem *base;
 	struct clk *clk;
 };
 
 static inline struct iproc_pwmc *to_iproc_pwmc(struct pwm_chip *chip)
 {
-	return container_of(chip, struct iproc_pwmc, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static void iproc_pwmc_enable(struct iproc_pwmc *ip, unsigned int channel)
@@ -187,20 +186,20 @@ static const struct pwm_ops iproc_pwm_ops = {
 
 static int iproc_pwmc_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct iproc_pwmc *ip;
 	unsigned int i;
 	u32 value;
 	int ret;
 
-	ip = devm_kzalloc(&pdev->dev, sizeof(*ip), GFP_KERNEL);
-	if (!ip)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 4, sizeof(*ip));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	ip = to_iproc_pwmc(chip);
 
 	platform_set_drvdata(pdev, ip);
 
-	ip->chip.dev = &pdev->dev;
-	ip->chip.ops = &iproc_pwm_ops;
-	ip->chip.npwm = 4;
+	chip->ops = &iproc_pwm_ops;
 
 	ip->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(ip->base))
@@ -214,14 +213,14 @@ static int iproc_pwmc_probe(struct platform_device *pdev)
 	/* Set full drive and normal polarity for all channels */
 	value = readl(ip->base + IPROC_PWM_CTRL_OFFSET);
 
-	for (i = 0; i < ip->chip.npwm; i++) {
+	for (i = 0; i < chip->npwm; i++) {
 		value &= ~(1 << IPROC_PWM_CTRL_TYPE_SHIFT(i));
 		value |= 1 << IPROC_PWM_CTRL_POLARITY_SHIFT(i);
 	}
 
 	writel(value, ip->base + IPROC_PWM_CTRL_OFFSET);
 
-	ret = devm_pwmchip_add(&pdev->dev, &ip->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0)
 		return dev_err_probe(&pdev->dev, ret,
 				     "failed to add PWM chip\n");
-- 
2.43.0


