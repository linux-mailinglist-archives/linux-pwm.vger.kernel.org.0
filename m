Return-Path: <linux-pwm+bounces-1020-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECADA83C1FC
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3DF91F224FB
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C0A1CA83;
	Thu, 25 Jan 2024 12:11:01 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A354439A
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184661; cv=none; b=lhXBuQvYhwZIBDyLqnT/qCBdbAso9YZ1Cw0G9ykdGGmEPizE3RZVivPP63yTKFyESN+XZmNgPiWqUuT9Ft7gh83Pv20552F5sTgKm85xofBEpBsn5wLwFlMDlARabhMu7Jy1EOAJAEFTKwVUKD+x3f+AHRdr5vVazxJERsmd2V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184661; c=relaxed/simple;
	bh=tWPOjHNk9l4NhNA+9uRaG4wPayVZWs3awqdiQXOLgME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=stDX1oJio+rmLVgoRf9kfw9ccXV8oFqpiMBDTKCgrR7JVKh9Folevxl2hDQkkz15frQza4I4jjuQf0yGqbaVBlZFnrqutiAKG2pGQCOrc01oREzGsKWfN3Bax+cYn6bSAQdEszB5ZVSP0Y47A9kK1I1hLtIvnb7q9OmRIK9dghs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZN-0004WE-S6; Thu, 25 Jan 2024 13:10:57 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZM-002HU7-EH; Thu, 25 Jan 2024 13:10:56 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZM-007n3k-1B;
	Thu, 25 Jan 2024 13:10:56 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v5 084/111] pwm: rz-mtu3: Make use of devm_pwmchip_alloc() function
Date: Thu, 25 Jan 2024 13:09:46 +0100
Message-ID:  <b7dc391ff166ce5ee865e0b5e6391f740aa4d110.1706182805.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3793; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=tWPOjHNk9l4NhNA+9uRaG4wPayVZWs3awqdiQXOLgME=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk+dT5dzrY+VWcHIJu3DV/f9YB2WDrW4rZshp KcOqQxdKWmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPnQAKCRCPgPtYfRL+ TgXeB/4jhQiFwC+QNN74JLTg5qkmc9sxOCNvMy58Ia5W4+s6nuoSvvQUjMgsMCpKD897AVtW9/j j8fFmouHOi6/NA+DQdnZpnLY10YLOnTtIifJhLxGz0SqihqPk8mOBEC/kX8aoH8iDpCAe760fOU WWgyQeWdlL0/mwK2xJFeB35aJPyFTVWZ+H3PYpg6lS8hzKgA+Eg/Jnhsfzm/IHh92NiKlQZpZdI hIjU0IgNerYej9B5QB0rOVXOKDO9SxMv2l8qmCD2sgWsBVjjiKwoDwEKoQNha+C5SSqhoIbgfCj N/1T5M+rt2nNaXWBZLxHsgqNH2oyOkDK5iaNG4te2nC9EVH5
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-rz-mtu3 driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-rz-mtu3.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/pwm/pwm-rz-mtu3.c b/drivers/pwm/pwm-rz-mtu3.c
index 45d075560a21..809c7f32b928 100644
--- a/drivers/pwm/pwm-rz-mtu3.c
+++ b/drivers/pwm/pwm-rz-mtu3.c
@@ -61,7 +61,6 @@ struct rz_mtu3_pwm_channel {
 /**
  * struct rz_mtu3_pwm_chip - MTU3 pwm private data
  *
- * @chip: MTU3 pwm chip data
  * @clk: MTU3 module clock
  * @lock: Lock to prevent concurrent access for usage count
  * @rate: MTU3 clock rate
@@ -72,7 +71,6 @@ struct rz_mtu3_pwm_channel {
  */
 
 struct rz_mtu3_pwm_chip {
-	struct pwm_chip chip;
 	struct clk *clk;
 	struct mutex lock;
 	unsigned long rate;
@@ -92,7 +90,7 @@ static const struct rz_mtu3_channel_io_map channel_map[] = {
 
 static inline struct rz_mtu3_pwm_chip *to_rz_mtu3_pwm_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct rz_mtu3_pwm_chip, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static void rz_mtu3_pwm_read_tgr_registers(struct rz_mtu3_pwm_channel *priv,
@@ -219,7 +217,7 @@ static int rz_mtu3_pwm_enable(struct rz_mtu3_pwm_chip *rz_mtu3_pwm,
 	u8 val;
 	int rc;
 
-	rc = pm_runtime_resume_and_get(rz_mtu3_pwm->chip.dev);
+	rc = pm_runtime_resume_and_get(pwmchip_parent(pwm->chip));
 	if (rc)
 		return rc;
 
@@ -265,7 +263,7 @@ static void rz_mtu3_pwm_disable(struct rz_mtu3_pwm_chip *rz_mtu3_pwm,
 
 	mutex_unlock(&rz_mtu3_pwm->lock);
 
-	pm_runtime_put_sync(rz_mtu3_pwm->chip.dev);
+	pm_runtime_put_sync(pwmchip_parent(pwm->chip));
 }
 
 static int rz_mtu3_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -462,24 +460,27 @@ static DEFINE_RUNTIME_DEV_PM_OPS(rz_mtu3_pwm_pm_ops,
 
 static void rz_mtu3_pwm_pm_disable(void *data)
 {
-	struct rz_mtu3_pwm_chip *rz_mtu3_pwm = data;
+	struct pwm_chip *chip = data;
+	struct rz_mtu3_pwm_chip *rz_mtu3_pwm = to_rz_mtu3_pwm_chip(chip);
 
 	clk_rate_exclusive_put(rz_mtu3_pwm->clk);
-	pm_runtime_disable(rz_mtu3_pwm->chip.dev);
-	pm_runtime_set_suspended(rz_mtu3_pwm->chip.dev);
+	pm_runtime_disable(pwmchip_parent(chip));
+	pm_runtime_set_suspended(pwmchip_parent(chip));
 }
 
 static int rz_mtu3_pwm_probe(struct platform_device *pdev)
 {
 	struct rz_mtu3 *parent_ddata = dev_get_drvdata(pdev->dev.parent);
+	struct pwm_chip *chip;
 	struct rz_mtu3_pwm_chip *rz_mtu3_pwm;
 	struct device *dev = &pdev->dev;
 	unsigned int i, j = 0;
 	int ret;
 
-	rz_mtu3_pwm = devm_kzalloc(&pdev->dev, sizeof(*rz_mtu3_pwm), GFP_KERNEL);
-	if (!rz_mtu3_pwm)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, RZ_MTU3_MAX_PWM_CHANNELS, sizeof(*rz_mtu3_pwm));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	rz_mtu3_pwm = to_rz_mtu3_pwm_chip(chip);
 
 	rz_mtu3_pwm->clk = parent_ddata->clk;
 
@@ -514,15 +515,13 @@ static int rz_mtu3_pwm_probe(struct platform_device *pdev)
 
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
-	rz_mtu3_pwm->chip.dev = &pdev->dev;
 	ret = devm_add_action_or_reset(&pdev->dev, rz_mtu3_pwm_pm_disable,
-				       rz_mtu3_pwm);
+				       chip);
 	if (ret < 0)
 		return ret;
 
-	rz_mtu3_pwm->chip.ops = &rz_mtu3_pwm_ops;
-	rz_mtu3_pwm->chip.npwm = RZ_MTU3_MAX_PWM_CHANNELS;
-	ret = devm_pwmchip_add(&pdev->dev, &rz_mtu3_pwm->chip);
+	chip->ops = &rz_mtu3_pwm_ops;
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
 
-- 
2.43.0


