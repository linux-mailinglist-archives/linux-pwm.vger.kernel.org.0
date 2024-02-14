Return-Path: <linux-pwm+bounces-1356-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A978D8545AA
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 140C5B22A5A
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A6314015;
	Wed, 14 Feb 2024 09:34:31 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D6F1863B
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903271; cv=none; b=IBCRfxt26qau90beYZvZRIs/suIYqfaXq7VU04JrUtYxi2y9Jojz3IYig74s923ePn0G33IQYByAT5ZQK6AJPJPMLFUU0rHUPTIkThcF3ELHe0rW2wvSjtJn9E6O7gF3VgifDQT50yrkiekXJAMoP+TKPJs1Z8hbJdXQCFfeHGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903271; c=relaxed/simple;
	bh=NGI4f/O27bDdWqiTxX59BIzQ7kMifE+Op4tqWuQH41Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fdp/5Z6FH2nCvhO3jxSHFUJrnHmSLRrm4MRZQxF2t5jVeCLhIRD5e+nudND0r1GGYLUIsdMMZhQk/2BaN/mWbIL0zepaITw9WLq7kSZ2c3K+3ibO8OsXwuGptWuhRCdIHCz+vDH649Sdxk+wo9wI7uDmZMT2ACEsSkm/ZynQUm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBer-0004if-MN; Wed, 14 Feb 2024 10:34:25 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBer-000fBl-5H; Wed, 14 Feb 2024 10:34:25 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBer-004Y2r-0F;
	Wed, 14 Feb 2024 10:34:25 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	linux-pwm@vger.kernel.org
Cc: Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v6 047/164] pwm: imx1: Make use of devm_pwmchip_alloc() function
Date: Wed, 14 Feb 2024 10:31:34 +0100
Message-ID:  <c6995e0d281255a7514edf9f25a561302dcaf65f.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2190; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=NGI4f/O27bDdWqiTxX59BIzQ7kMifE+Op4tqWuQH41Q=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtQzHQ219XNCZ61bIZnSdtW+gGnxjm29WT9Vp2d0mUx8M +dNRXlJJ6MxCwMjF4OsmCKLfeOaTKsqucjOtf8uwwxiZQKZwsDFKQATieHnYFgyr7n2iWeF/Lal QqINXMpvJuxTPe08T2bGpYpfk/jYfsb4PU16Xx58rZvr1NZD2YWa3JNty6wtVmlp3s6LDW/yv1t 3duY09Rlqq82bA/b6nfeUe5T2iOu5UMrjhQysarNtrOP8HoQfcv5Zys8543dD8t3IX5ZJcgl3kn Y7+3Iw+WoaK8msW/CHfarveot1ItmT1O/qduQynhOKWpc2d4ajycuoLuXzpaeURTnvRHVv+huxn I3berebWEqT5YragnclTbOd9DhKnZYa+v/XCGv747+/zPvAg+dXyxOLZtWcvCPtzvz76+aIby+l a7jPltz1eCC9wfKe2J7ISyHn1u+1Mp74IMbmcf3emsk7AA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-imx1 driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Also convert the to_pwm_imx1_chip() helper macro to a static inline to
get some type safety.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-imx1.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-imx1.c b/drivers/pwm/pwm-imx1.c
index d175d895f22a..1d2aae2d278f 100644
--- a/drivers/pwm/pwm-imx1.c
+++ b/drivers/pwm/pwm-imx1.c
@@ -28,10 +28,12 @@ struct pwm_imx1_chip {
 	struct clk *clk_ipg;
 	struct clk *clk_per;
 	void __iomem *mmio_base;
-	struct pwm_chip chip;
 };
 
-#define to_pwm_imx1_chip(chip)	container_of(chip, struct pwm_imx1_chip, chip)
+static inline struct pwm_imx1_chip *to_pwm_imx1_chip(struct pwm_chip *chip)
+{
+	return pwmchip_get_drvdata(chip);
+}
 
 static int pwm_imx1_clk_prepare_enable(struct pwm_chip *chip)
 {
@@ -156,11 +158,13 @@ MODULE_DEVICE_TABLE(of, pwm_imx1_dt_ids);
 
 static int pwm_imx1_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct pwm_imx1_chip *imx;
 
-	imx = devm_kzalloc(&pdev->dev, sizeof(*imx), GFP_KERNEL);
-	if (!imx)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*imx));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	imx = to_pwm_imx1_chip(chip);
 
 	imx->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
 	if (IS_ERR(imx->clk_ipg))
@@ -172,15 +176,13 @@ static int pwm_imx1_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(imx->clk_per),
 				     "failed to get peripheral clock\n");
 
-	imx->chip.ops = &pwm_imx1_ops;
-	imx->chip.dev = &pdev->dev;
-	imx->chip.npwm = 1;
+	chip->ops = &pwm_imx1_ops;
 
 	imx->mmio_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(imx->mmio_base))
 		return PTR_ERR(imx->mmio_base);
 
-	return devm_pwmchip_add(&pdev->dev, &imx->chip);
+	return devm_pwmchip_add(&pdev->dev, chip);
 }
 
 static struct platform_driver pwm_imx1_driver = {
-- 
2.43.0


