Return-Path: <linux-pwm+bounces-85-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2670C7F2FA6
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6409281A38
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A175381D;
	Tue, 21 Nov 2023 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19591703
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:52:08 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAc-0006Nn-4V; Tue, 21 Nov 2023 14:52:06 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAZ-00Ab20-Im; Tue, 21 Nov 2023 14:52:03 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAZ-004xgz-9g; Tue, 21 Nov 2023 14:52:03 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-pwm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v3 090/108] pwm: stmpe: Make use of devm_pwmchip_alloc() function
Date: Tue, 21 Nov 2023 14:50:32 +0100
Message-ID: <20231121134901.208535-91-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
References: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2448; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=9B7qqzhgfjxbe1H5uS6z3zQNzl3U1yIC6YrSepVecLc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXLWv+rF2TO83TDSJ2CfHci7IsQAcjoNFuQ7Rp vdocCUBBGCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVy1rwAKCRCPgPtYfRL+ TtZBCACgv2MrNeViSq1OXJkuk9JJ2nnExD93h/BY+cSIZyqMcWsr9xab3H+Iyroepr2BEJJIxzw weacrB0KOz7MAsKbU7WfjqZs2FgWA28rints+RIL1KFQYHzFHrfKUOCRH7mMqKmCkX4v+hoVO58 +UQU8ICb2/nvIjuQ8lEKnO4cS14RQA3sZqg9pmVnZKlnMYizPd1YCcQtW9yXZXts3o3UElDjQlq h2GzQr1k0Go5WPjXjvK0IOfLhn6FsSkLPojAMkO8RsEf20WHmwKjJ68LfIIIq8ssp5vsYPCqtX5 i2Dzrge19/rx2qrN8r3gTYvl17D/G235qtYr8RVjuT62hKNy
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
index 492494b73a87..dc9c7b69ab54 100644
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
+	return pwmchip_priv(chip);
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
2.42.0


