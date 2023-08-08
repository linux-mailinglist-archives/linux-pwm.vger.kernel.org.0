Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522AC774541
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 20:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbjHHSjk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 14:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbjHHSjQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 14:39:16 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C431175DF5
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:20:02 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN3-00072h-0b; Tue, 08 Aug 2023 19:19:49 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN1-00224i-UY; Tue, 08 Aug 2023 19:19:47 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN0-00BTBf-F0; Tue, 08 Aug 2023 19:19:46 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 024/101] pwm: imx-tpm: Make use of devm_pwmchip_alloc() function
Date:   Tue,  8 Aug 2023 19:18:14 +0200
Message-Id: <20230808171931.944154-25-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2597; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=9tQyN3idoh7NtDVGf/T/Zz28QZpaBvTAsrUt4Z54kAw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0njLwB18Em/m0sLF/MtXGm/d4u6ijCJjdLCL/ yURNvpg71WJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ4ywAKCRCPgPtYfRL+ TgcuCACeJ7Heig11O8t4vGeJBvgT+JZFOz3vGND10uEXY/bnXeXe5f277Y2pjJ9Nizp2fmV0m0u Xg9vvMlLxNdT0teELt/EgKSxwNN4HijtPaZWwtZaZUtzVjSx+BqBRcZyaWjZ30SHw7n7YZfnL/7 YR5Ghx8i/4/83yAb/gGxEjP6E8AWin1PGlELe+iR+eF0Vaxo781fk3mIbwCDpRAclopwyWQxhmB W6iifYVnnHB9d0rSHtfQ30qWlpxJfeRt1k+7G2Hm9QtCT1AcvOB9Hl/h2et9cnLvRAgUbUw2j1D 7py5WltDrfddkaFOCLjvr4I0gj2uofmRJ83eAjf9m41Beb3d
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This prepares the pwm-tmp driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-imx-tpm.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
index dc6aafeb9f7b..6c668c78f849 100644
--- a/drivers/pwm/pwm-imx-tpm.c
+++ b/drivers/pwm/pwm-imx-tpm.c
@@ -57,7 +57,6 @@
 #define PWM_IMX_TPM_MOD_MOD	GENMASK(PWM_IMX_TPM_MOD_WIDTH - 1, 0)
 
 struct imx_tpm_pwm_chip {
-	struct pwm_chip chip;
 	struct clk *clk;
 	void __iomem *base;
 	struct mutex lock;
@@ -75,7 +74,7 @@ struct imx_tpm_pwm_param {
 static inline struct imx_tpm_pwm_chip *
 to_imx_tpm_pwm_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct imx_tpm_pwm_chip, chip);
+	return pwmchip_priv(chip);
 }
 
 /*
@@ -336,35 +335,40 @@ static const struct pwm_ops imx_tpm_pwm_ops = {
 
 static int pwm_imx_tpm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct imx_tpm_pwm_chip *tpm;
+	void __iomem *base;
 	int ret;
+	unsigned int npwm;
 	u32 val;
 
-	tpm = devm_kzalloc(&pdev->dev, sizeof(*tpm), GFP_KERNEL);
-	if (!tpm)
-		return -ENOMEM;
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	/* get number of channels */
+	val = readl(tpm->base + PWM_IMX_TPM_PARAM);
+	npwm = FIELD_GET(PWM_IMX_TPM_PARAM_CHAN, val);
+
+	chip = devm_pwmchip_alloc(&pdev->dev, npwm, sizeof(*tpm));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	tpm = to_imx_tpm_pwm_chip(chip);
 
 	platform_set_drvdata(pdev, tpm);
 
-	tpm->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(tpm->base))
-		return PTR_ERR(tpm->base);
+	tpm->base = base;
 
 	tpm->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(tpm->clk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(tpm->clk),
 				     "failed to get PWM clock\n");
 
-	tpm->chip.dev = &pdev->dev;
-	tpm->chip.ops = &imx_tpm_pwm_ops;
-
-	/* get number of channels */
-	val = readl(tpm->base + PWM_IMX_TPM_PARAM);
-	tpm->chip.npwm = FIELD_GET(PWM_IMX_TPM_PARAM_CHAN, val);
+	chip->ops = &imx_tpm_pwm_ops;
 
 	mutex_init(&tpm->lock);
 
-	ret = devm_pwmchip_add(&pdev->dev, &tpm->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
 
-- 
2.40.1

