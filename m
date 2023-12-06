Return-Path: <linux-pwm+bounces-405-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 817CC806ED1
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 378911F2169E
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D8B35880;
	Wed,  6 Dec 2023 11:49:04 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CB610E4
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:41 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOL-0007LU-U1; Wed, 06 Dec 2023 12:48:37 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOJ-00Dwwt-AX; Wed, 06 Dec 2023 12:48:35 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOJ-00FR2M-1Z; Wed, 06 Dec 2023 12:48:35 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-pwm@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v4 089/115] pwm: sifive: Make use of devm_pwmchip_alloc() function
Date: Wed,  6 Dec 2023 12:44:43 +0100
Message-ID:  <500a4f39531bd5fc61eb8ac0092e34d4b1ae2cc0.1701860672.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3195; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=o6rhBlavP1G4sD6ilBFg/xAZ7zerFcGXPH8hYzLL2oM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcF8O3CicVdLVjfFqkGuk09ZhGKvN/EkTIYnHk Caq7gZBXJyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXBfDgAKCRCPgPtYfRL+ TjwcB/9Av4b+3WV78h6voXb5a747xNA+gK+JnqAx8lSwANpz4mfPNFThkVS6CC7xagANDaj8VcQ Fpo4O0EoBaCniS3b/PatFEdWmG0tL9uCa4d8LxqHwcd5XorNjI7ZAPclpcWNpmCVdJ0sdoXDtan 0EMPyMUj37Cp6cJVRuRqHRH6r0WmDCeVGB+08NZ7jNfk9fVeP/0nGlWkvveYhIBEmbdBaA8paEr gkebz3zuKi6OljGN84+IJHb6g1eRLyGsY5sC7czQH0T8lMSJbTVKGhu3OJ84n283DKjanweFAyj JcMybUKyh1xhcHPuUbs23RRIeEQct4WTEwBNhrAsV5vsn89/
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-sifive driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-sifive.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index c1b412905d9e..cf3fcffe7b3a 100644
--- a/drivers/pwm/pwm-sifive.c
+++ b/drivers/pwm/pwm-sifive.c
@@ -41,7 +41,7 @@
 #define PWM_SIFIVE_DEFAULT_PERIOD	10000000
 
 struct pwm_sifive_ddata {
-	struct pwm_chip	chip;
+	struct pwm_chip *chip;
 	struct mutex lock; /* lock to protect user_count and approx_period */
 	struct notifier_block notifier;
 	struct clk *clk;
@@ -54,7 +54,7 @@ struct pwm_sifive_ddata {
 static inline
 struct pwm_sifive_ddata *pwm_sifive_chip_to_ddata(struct pwm_chip *chip)
 {
-	return container_of(chip, struct pwm_sifive_ddata, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static int pwm_sifive_request(struct pwm_chip *chip, struct pwm_device *pwm)
@@ -102,7 +102,7 @@ static void pwm_sifive_update_clock(struct pwm_sifive_ddata *ddata,
 	/* As scale <= 15 the shift operation cannot overflow. */
 	num = (unsigned long long)NSEC_PER_SEC << (PWM_SIFIVE_CMPWIDTH + scale);
 	ddata->real_period = div64_ul(num, rate);
-	dev_dbg(pwmchip_parent(&ddata->chip),
+	dev_dbg(pwmchip_parent(ddata->chip),
 		"New real_period = %u ns\n", ddata->real_period);
 }
 
@@ -230,15 +230,14 @@ static int pwm_sifive_probe(struct platform_device *pdev)
 	u32 val;
 	unsigned int enabled_pwms = 0, enabled_clks = 1;
 
-	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
-	if (!ddata)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(dev, 4, sizeof(*ddata));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	ddata = pwm_sifive_chip_to_ddata(chip);
+	ddata->chip = chip;
 
 	mutex_init(&ddata->lock);
-	chip = &ddata->chip;
-	chip->dev = dev;
 	chip->ops = &pwm_sifive_ops;
-	chip->npwm = 4;
 
 	ddata->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(ddata->regs))
@@ -296,7 +295,7 @@ static int pwm_sifive_probe(struct platform_device *pdev)
 		goto unregister_clk;
 	}
 
-	platform_set_drvdata(pdev, ddata);
+	platform_set_drvdata(pdev, chip);
 	dev_dbg(dev, "SiFive PWM chip registered %d PWMs\n", chip->npwm);
 
 	return 0;
@@ -314,15 +313,16 @@ static int pwm_sifive_probe(struct platform_device *pdev)
 
 static void pwm_sifive_remove(struct platform_device *dev)
 {
-	struct pwm_sifive_ddata *ddata = platform_get_drvdata(dev);
+	struct pwm_chip *chip = platform_get_drvdata(dev);
+	struct pwm_sifive_ddata *ddata = pwm_sifive_chip_to_ddata(chip);
 	struct pwm_device *pwm;
 	int ch;
 
-	pwmchip_remove(&ddata->chip);
+	pwmchip_remove(chip);
 	clk_notifier_unregister(ddata->clk, &ddata->notifier);
 
-	for (ch = 0; ch < ddata->chip.npwm; ch++) {
-		pwm = &ddata->chip.pwms[ch];
+	for (ch = 0; ch < chip->npwm; ch++) {
+		pwm = &chip->pwms[ch];
 		if (pwm->state.enabled)
 			clk_disable(ddata->clk);
 	}
-- 
2.42.0


