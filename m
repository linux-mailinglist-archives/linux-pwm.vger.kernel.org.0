Return-Path: <linux-pwm+bounces-381-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53519806EAF
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 863931C20B79
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3B33455C;
	Wed,  6 Dec 2023 11:48:57 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1BA18F
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:40 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOL-0007IW-Qe; Wed, 06 Dec 2023 12:48:37 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOI-00Dwwk-Tk; Wed, 06 Dec 2023 12:48:34 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOI-00FR2D-Kt; Wed, 06 Dec 2023 12:48:34 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	linux-pwm@vger.kernel.org
Subject: [PATCH v4 087/115] pwm: rz-mtu3: Make use of devm_pwmchip_alloc() function
Date: Wed,  6 Dec 2023 12:44:41 +0100
Message-ID:  <36b677868023c40bfe90fea01ec37c54787a4b29.1701860672.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1701860672.git.u.kleine-koenig@pengutronix.de>
References: <cover.1701860672.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3530; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=FtXGfMmcsXm4AX7OCNI/4XrVkT/oAKv6x1Ki3bjLRrw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcF8MnExHMbyCyntmzFbcA6qUKpcRA8Dy/f0dn bkMQ0mgPLuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXBfDAAKCRCPgPtYfRL+ Tu7jB/4kMCcSOmtzeoX3/IuL5S/jd5+vWc8TxM88tTxyzGQ9v7pJ1++wXt/3SKxKLqlUNCO84NF 86klNqImONZIW18s19CaiKEXqoQAVVVUg7FWjEpE3vOtw1F7iYhZynIZjwuKC+IvOqnd3/VJJZ7 GpbUg9uWRw9I3Dvw2VasbjbCHZeWauAEByRlYqp/Hm4s95tT9LEc1A5bFGbrcHOWqg+CfzR5pv5 BgbB8yinYZjVgz+i+GHkYSZEv3M/EYD12q0BptJVEZ0LmNr37hzctObT4jfNuUtDZ+6o7JYrjzg sQEFK7BLaazEfdDmTDiUlKyHoDOD4bsZ6vipNKJ5n5OnAtvz
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
 drivers/pwm/pwm-rz-mtu3.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/pwm/pwm-rz-mtu3.c b/drivers/pwm/pwm-rz-mtu3.c
index 45d075560a21..a6c75f708abf 100644
--- a/drivers/pwm/pwm-rz-mtu3.c
+++ b/drivers/pwm/pwm-rz-mtu3.c
@@ -72,7 +72,6 @@ struct rz_mtu3_pwm_channel {
  */
 
 struct rz_mtu3_pwm_chip {
-	struct pwm_chip chip;
 	struct clk *clk;
 	struct mutex lock;
 	unsigned long rate;
@@ -92,7 +91,7 @@ static const struct rz_mtu3_channel_io_map channel_map[] = {
 
 static inline struct rz_mtu3_pwm_chip *to_rz_mtu3_pwm_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct rz_mtu3_pwm_chip, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static void rz_mtu3_pwm_read_tgr_registers(struct rz_mtu3_pwm_channel *priv,
@@ -219,7 +218,7 @@ static int rz_mtu3_pwm_enable(struct rz_mtu3_pwm_chip *rz_mtu3_pwm,
 	u8 val;
 	int rc;
 
-	rc = pm_runtime_resume_and_get(rz_mtu3_pwm->chip.dev);
+	rc = pm_runtime_resume_and_get(pwmchip_parent(pwm->chip));
 	if (rc)
 		return rc;
 
@@ -265,7 +264,7 @@ static void rz_mtu3_pwm_disable(struct rz_mtu3_pwm_chip *rz_mtu3_pwm,
 
 	mutex_unlock(&rz_mtu3_pwm->lock);
 
-	pm_runtime_put_sync(rz_mtu3_pwm->chip.dev);
+	pm_runtime_put_sync(pwmchip_parent(pwm->chip));
 }
 
 static int rz_mtu3_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -462,24 +461,27 @@ static DEFINE_RUNTIME_DEV_PM_OPS(rz_mtu3_pwm_pm_ops,
 
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
 
@@ -514,15 +516,13 @@ static int rz_mtu3_pwm_probe(struct platform_device *pdev)
 
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
2.42.0


