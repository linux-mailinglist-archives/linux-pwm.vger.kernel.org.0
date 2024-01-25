Return-Path: <linux-pwm+bounces-1029-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B741183C22C
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FDADB24B37
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEF14123F;
	Thu, 25 Jan 2024 12:11:04 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B047E3A27E
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184664; cv=none; b=lvvR3KHsHV47xkPiAcMkrh6I/6Rodye5cCHXh02MIt9bwozkddrOIMJ3Sm4F0vG7uFsEx1T7iEhcK1oHuB3PygP6xi6AvPYMP3fdllZEAk3HxbyTgsMhHgDZhBXNKN+R06Ub6T12hi0zoNCdDHwVrIxsX/x6qPw/JSyPT0nmnlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184664; c=relaxed/simple;
	bh=vidtE9CgEuAi+9yLI9nc75r2oHZCcD5MypZmUOpuSi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AstCrI7K3FsFkcs0kpBErHWX/fCxtoeKWAbRR4fi+WdDfIKNvjh8JL8C/uINnWpeDknsE2kDm5zzm/KRJQ8cV3eQR75+1b3A2Z3qwzxAg1Smlvljghu02keT/j1cBOEP4PSLBtvgEEag8VGrLaUrqzu24q80VZVR7g8Ur2ZTD1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZP-0004Yz-7P; Thu, 25 Jan 2024 13:10:59 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZN-002HUf-UG; Thu, 25 Jan 2024 13:10:57 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZN-007n4O-2l;
	Thu, 25 Jan 2024 13:10:57 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-pwm@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v5 093/111] pwm: stmpe: Make use of devm_pwmchip_alloc() function
Date: Thu, 25 Jan 2024 13:09:55 +0100
Message-ID:  <0c1f5268c8045c2b4cb6e00bd2d81a20d0df53c9.1706182805.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2455; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=vidtE9CgEuAi+9yLI9nc75r2oHZCcD5MypZmUOpuSi0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk+n+E9fw0hJYqoDvom0/6h63yfF5ktdkZ3gq BUOhlhqrpGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPpwAKCRCPgPtYfRL+ TiGNB/9vGzi2NfwWEhEY8IsXVwdtspOXHyJ9JsxWnZWBaSRVmeveEwNu/pAElgGNlz96XlhCTFK PZQkr8+IvGngLHmJIxPT9+oQedpXPKKRE/iiUwq2zmhsfQsAqkOA0BCZgf+NIQjEajZFrIeqpbA 3RdXG0IwKieoDKAJ/s859qy/fJk30M4yqIs/33TzHway4PPGpFkM6feTDCD9xrZiHsrZImKmvdK DFPQhlGemU67ANopPFqYtR0iquQ4/XhwZpajZBt1SyAizEpw2rxriikpBdDamPoSdpf8eKOz7vm 1itx7NWHoCux6w8FmvfGbPLfxb1tejG8p6VJZUCtFmHZzO5q
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-stmpe driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-stmpe.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/pwm/pwm-stmpe.c b/drivers/pwm/pwm-stmpe.c
index 05f3f38031ee..319c6ad6a79b 100644
--- a/drivers/pwm/pwm-stmpe.c
+++ b/drivers/pwm/pwm-stmpe.c
@@ -27,13 +27,12 @@
 
 struct stmpe_pwm {
 	struct stmpe *stmpe;
-	struct pwm_chip chip;
 	u8 last_duty;
 };
 
 static inline struct stmpe_pwm *to_stmpe_pwm(struct pwm_chip *chip)
 {
-	return container_of(chip, struct stmpe_pwm, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static int stmpe_24xx_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
@@ -292,33 +291,36 @@ static const struct pwm_ops stmpe_24xx_pwm_ops = {
 static int __init stmpe_pwm_probe(struct platform_device *pdev)
 {
 	struct stmpe *stmpe = dev_get_drvdata(pdev->dev.parent);
+	struct pwm_chip *chip;
 	struct stmpe_pwm *stmpe_pwm;
 	int ret;
 
-	stmpe_pwm = devm_kzalloc(&pdev->dev, sizeof(*stmpe_pwm), GFP_KERNEL);
-	if (!stmpe_pwm)
-		return -ENOMEM;
+	switch (stmpe->partnum) {
+	case STMPE2401:
+	case STMPE2403:
+		break;
+	case STMPE1601:
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "STMPE1601 not yet supported\n");
+	default:
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "Unknown STMPE PWM\n");
+	}
+
+	chip = devm_pwmchip_alloc(&pdev->dev, 3, sizeof(*stmpe_pwm));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	stmpe_pwm = to_stmpe_pwm(chip);
 
 	stmpe_pwm->stmpe = stmpe;
-	stmpe_pwm->chip.dev = &pdev->dev;
 
-	if (stmpe->partnum == STMPE2401 || stmpe->partnum == STMPE2403) {
-		stmpe_pwm->chip.ops = &stmpe_24xx_pwm_ops;
-		stmpe_pwm->chip.npwm = 3;
-	} else {
-		if (stmpe->partnum == STMPE1601)
-			dev_err(&pdev->dev, "STMPE1601 not yet supported\n");
-		else
-			dev_err(&pdev->dev, "Unknown STMPE PWM\n");
-
-		return -ENODEV;
-	}
+	chip->ops = &stmpe_24xx_pwm_ops;
 
 	ret = stmpe_enable(stmpe, STMPE_BLOCK_PWM);
 	if (ret)
 		return ret;
 
-	ret = pwmchip_add(&stmpe_pwm->chip);
+	ret = pwmchip_add(chip);
 	if (ret) {
 		stmpe_disable(stmpe, STMPE_BLOCK_PWM);
 		return ret;
-- 
2.43.0


