Return-Path: <linux-pwm+bounces-1468-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A4D85462A
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04D091C21797
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9F312E72;
	Wed, 14 Feb 2024 09:34:53 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698E31B802
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903293; cv=none; b=NOGa9DytNtJHrnsig7RFh0JQb8XsN2MJdIrSzXoz413b3L6SmC6f7nXNtaHXiO11/uJihKdzJgg5ya5TXZ2tVLPiH+xLoRq+O9eJehB1AZOF+Eckw+HvOIzlYUXikWGnftQSnn9ErD5srnuRJ4hVcTNLY7G3flzlkSj5mFa1pMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903293; c=relaxed/simple;
	bh=JwSksdiJKkUTA0XrBQphtQHWlG5cvgFNT9pJVNJ3gmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ITRJ1iV6ks5sgWULkzPrT4DOMZceENmCznWHDtVcdWJUvfXhC8Aea/vLPFKdOu9fyUqfEipgdan2BGk1yp3GRXp6eeccwDZXk5ZrIv+KMObHngG1ecDpK621EufVCpcXg+J32EN37QGduF/JaCnBW5GDXGs4zOZassHMKyn4YwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf9-0006Bv-UK; Wed, 14 Feb 2024 10:34:43 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf6-000fI7-RH; Wed, 14 Feb 2024 10:34:40 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf6-004Y9z-2T;
	Wed, 14 Feb 2024 10:34:40 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Sean Anderson <sean.anderson@seco.com>,
	Michal Simek <michal.simek@amd.com>,
	linux-pwm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v6 150/164] pwm: xilinx: Make use of devm_pwmchip_alloc() function
Date: Wed, 14 Feb 2024 10:33:17 +0100
Message-ID:  <7cbc32771e94103b8c1c817cfdd613d7a2fc01b9.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2314; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=JwSksdiJKkUTA0XrBQphtQHWlG5cvgFNT9pJVNJ3gmQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIj3OiCxJq+FqmglVST//DPQ6+PrTwjBgJPA4 gSt5mi22ByJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyI9wAKCRCPgPtYfRL+ TlQAB/9yGImmfJaZP5NL32Fv2T2P5dZmh+bVB+3++o/KOSLqtlEhk5NNCZ8hGzgX7IE2ksPQ8MH tj3Z0pBySlC6Aoi/aa2ZmCkMZ4cyatgeqafEtC2YZdT4xgAcFJ+Y1P9Ux0AAlj+HtI3q5p0aKdd 1vC67hcN+We44BMzY/Dequ4T/P4+ZHQlaCcAFDuFybnDpCWgKNHnzvHQKQKIlxgJpD0O0E2zipD sUB1215Z8evKttQuU5+L54zOI07GVIPU5N22pvPJJ7siyhMKriH7qdhjFJSCfRNTEKU8VAIjm7S ZnnpraI8plw3zlj3Ou/bHcb7I04I38bgoDOIMRJnpn/ShgNY
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-xilinx driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-xilinx.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/pwm/pwm-xilinx.c b/drivers/pwm/pwm-xilinx.c
index 0ca79fe8c105..3a7deebb0d0c 100644
--- a/drivers/pwm/pwm-xilinx.c
+++ b/drivers/pwm/pwm-xilinx.c
@@ -80,15 +80,10 @@ unsigned int xilinx_timer_get_period(struct xilinx_timer_priv *priv,
 #define TCSR_PWM_CLEAR (TCSR_MDT | TCSR_LOAD)
 #define TCSR_PWM_MASK (TCSR_PWM_SET | TCSR_PWM_CLEAR)
 
-struct xilinx_pwm_device {
-	struct pwm_chip chip;
-	struct xilinx_timer_priv priv;
-};
-
 static inline struct xilinx_timer_priv
 *xilinx_pwm_chip_to_priv(struct pwm_chip *chip)
 {
-	return &container_of(chip, struct xilinx_pwm_device, chip)->priv;
+	return pwmchip_get_drvdata(chip);
 }
 
 static bool xilinx_timer_pwm_enabled(u32 tcsr0, u32 tcsr1)
@@ -215,7 +210,6 @@ static int xilinx_pwm_probe(struct platform_device *pdev)
 	struct device_node *np = dev->of_node;
 	struct xilinx_timer_priv *priv;
 	struct pwm_chip *chip;
-	struct xilinx_pwm_device *xilinx_pwm;
 	u32 pwm_cells, one_timer, width;
 	void __iomem *regs;
 
@@ -226,11 +220,10 @@ static int xilinx_pwm_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "could not read #pwm-cells\n");
 
-	xilinx_pwm = devm_kzalloc(dev, sizeof(*xilinx_pwm), GFP_KERNEL);
-	if (!xilinx_pwm)
-		return -ENOMEM;
-	priv = &xilinx_pwm->priv;
-	chip = &xilinx_pwm->chip;
+	chip = devm_pwmchip_alloc(dev, 1, sizeof(*priv));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	priv = xilinx_pwm_chip_to_priv(chip);
 	platform_set_drvdata(pdev, chip);
 
 	regs = devm_platform_ioremap_resource(pdev, 0);
@@ -280,9 +273,7 @@ static int xilinx_pwm_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, ret, "Clock enable failed\n");
 	clk_rate_exclusive_get(priv->clk);
 
-	chip->dev = dev;
 	chip->ops = &xilinx_pwm_ops;
-	chip->npwm = 1;
 	ret = pwmchip_add(chip);
 	if (ret) {
 		clk_rate_exclusive_put(priv->clk);
-- 
2.43.0


