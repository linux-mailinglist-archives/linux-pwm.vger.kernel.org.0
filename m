Return-Path: <linux-pwm+bounces-389-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18196806EBD
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1C0F281C07
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0A634559;
	Wed,  6 Dec 2023 11:48:59 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17A110DB
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:43 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqON-0007Vn-GE; Wed, 06 Dec 2023 12:48:39 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOL-00DwxK-AA; Wed, 06 Dec 2023 12:48:37 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOL-00FR2k-12; Wed, 06 Dec 2023 12:48:37 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-pwm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 094/115] pwm: stm32-lp: Make use of devm_pwmchip_alloc() function
Date: Wed,  6 Dec 2023 12:44:48 +0100
Message-ID:  <08caf1d4a05831c7372d5f9c888dd495c01ddb26.1701860672.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2375; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=fUvyGLEsmdMLS9fUd3TDhVk3pL+KBTfDCccgiYGomQI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcF8j9+D52Bo6wMkF+nbCxh26G6YrEXw1s8xhE OOBGvElwj6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXBfIwAKCRCPgPtYfRL+ TnSqB/95x30HM0fSMYu4cFoDcq1fkeemIN0qStKihS5vGg2r7f4QBzukXXhlmtpmyc2/Ut2YWGu mnrzdBzy1VIV9ENbMp2eNztK+xqaJ08iFu7/D/Yd/jL4jxNZHeuod0JJ8gtnYIqG8+sbrSG9hsL Yh7lWfpw7JEnnoe4F5AR5J0cq2jrXQgKtGQIRqscxpUSlHlhpk6n6DlP8yMoWFO/11AnHiDRzKK 8uL5+5T0d4hTdQ5kfBsn5qwprAjfL6+LrF5gGdOpPxi8dTszsCXsyKcgkVF/CwrBTnB6WEOWufK bir+a0TShU1kP0p1ogfA1A7yMDbH71xTS1L6lKDjVGMC3q4P
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-stm32-lp driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-stm32-lp.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
index 3754faeca838..579fea9a0da4 100644
--- a/drivers/pwm/pwm-stm32-lp.c
+++ b/drivers/pwm/pwm-stm32-lp.c
@@ -18,14 +18,13 @@
 #include <linux/pwm.h>
 
 struct stm32_pwm_lp {
-	struct pwm_chip chip;
 	struct clk *clk;
 	struct regmap *regmap;
 };
 
 static inline struct stm32_pwm_lp *to_stm32_pwm_lp(struct pwm_chip *chip)
 {
-	return container_of(chip, struct stm32_pwm_lp, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 /* STM32 Low-Power Timer is preceded by a configurable power-of-2 prescaler */
@@ -196,20 +195,20 @@ static const struct pwm_ops stm32_pwm_lp_ops = {
 static int stm32_pwm_lp_probe(struct platform_device *pdev)
 {
 	struct stm32_lptimer *ddata = dev_get_drvdata(pdev->dev.parent);
+	struct pwm_chip *chip;
 	struct stm32_pwm_lp *priv;
 	int ret;
 
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*priv));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	priv = to_stm32_pwm_lp(chip);
 
 	priv->regmap = ddata->regmap;
 	priv->clk = ddata->clk;
-	priv->chip.dev = &pdev->dev;
-	priv->chip.ops = &stm32_pwm_lp_ops;
-	priv->chip.npwm = 1;
+	chip->ops = &stm32_pwm_lp_ops;
 
-	ret = devm_pwmchip_add(&pdev->dev, &priv->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0)
 		return ret;
 
@@ -220,13 +219,13 @@ static int stm32_pwm_lp_probe(struct platform_device *pdev)
 
 static int stm32_pwm_lp_suspend(struct device *dev)
 {
-	struct stm32_pwm_lp *priv = dev_get_drvdata(dev);
+	struct pwm_chip *chip = dev_get_drvdata(dev);
 	struct pwm_state state;
 
-	pwm_get_state(&priv->chip.pwms[0], &state);
+	pwm_get_state(&chip->pwms[0], &state);
 	if (state.enabled) {
 		dev_err(dev, "The consumer didn't stop us (%s)\n",
-			priv->chip.pwms[0].label);
+			chip->pwms[0].label);
 		return -EBUSY;
 	}
 
-- 
2.42.0


