Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDC1758476
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jul 2023 20:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjGRSTR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 18 Jul 2023 14:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjGRSTO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 18 Jul 2023 14:19:14 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D54310F5
        for <linux-pwm@vger.kernel.org>; Tue, 18 Jul 2023 11:19:05 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLpHp-0001rR-KG; Tue, 18 Jul 2023 20:19:01 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLpHm-000QnN-NQ; Tue, 18 Jul 2023 20:18:58 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLpHl-005uoF-RE; Tue, 18 Jul 2023 20:18:57 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
Subject: [PATCH 14/18] pwm: mxs: Make use of devm_pwmchip_alloc() function
Date:   Tue, 18 Jul 2023 20:18:45 +0200
Message-Id: <20230718181849.3947851-15-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230718181849.3947851-1-u.kleine-koenig@pengutronix.de>
References: <20230718181849.3947851-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2381; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=KHdukM7y9tLEkAsVsVB4PPKuE2LqGo16JWGz2nyvVLM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkttb3EsCWwrAa4GToMMx6iQnR+dBd+5wX9tNh7 skq8TfbQBOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZLbW9wAKCRCPgPtYfRL+ TlpKCACMx0htP9A5s+fAWSvfdln/ZMsKNg53ZEX7fuE7tGuoKbdgOrC6TQr3PpvuC0pt10OzMDW Wy6PpvpP/SYMFXTTrCf11+K8xuH10fUL7ej1u3lV3+qZwkg1PZgaaR/baz0F33+HMdEUG36u4AO UoPaA/A7p65NRiRC7kIP+DRlusX9IHvfjjKUW3FIOcf7+XO6AQZK+rCgHMDtXoqTKEeoUsagpvo RiOc9dlh4GoU2z9XH1wWXbYnPK7tId7sbJZ+ZjNJxaZQnj0hoFdhJrSZmJf3wMvzshxWUvVL8Id RNKPCzRLyuXuDF9Fqqs3ODmuDP6KEfEb9KcI2INI1TBlrQOU
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This prepares the pwm-mxs driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-mxs.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-mxs.c b/drivers/pwm/pwm-mxs.c
index 766dbc58dad8..62f8ab499d44 100644
--- a/drivers/pwm/pwm-mxs.c
+++ b/drivers/pwm/pwm-mxs.c
@@ -37,12 +37,14 @@ static const u8 cdiv_shift[PERIOD_CDIV_MAX] = {
 };
 
 struct mxs_pwm_chip {
-	struct pwm_chip chip;
 	struct clk *clk;
 	void __iomem *base;
 };
 
-#define to_mxs_pwm_chip(_chip) container_of(_chip, struct mxs_pwm_chip, chip)
+static inline struct mxs_pwm_chip *to_mxs_pwm_chip(struct pwm_chip *chip)
+{
+	return pwmchip_priv(chip);
+}
 
 static int mxs_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			 const struct pwm_state *state)
@@ -121,12 +123,14 @@ static const struct pwm_ops mxs_pwm_ops = {
 static int mxs_pwm_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
+	struct pwm_chip *chip;
 	struct mxs_pwm_chip *mxs;
 	int ret;
 
-	mxs = devm_kzalloc(&pdev->dev, sizeof(*mxs), GFP_KERNEL);
-	if (!mxs)
+	chip = devm_pwmchip_alloc(&pdev->dev, sizeof(*mxs));
+	if (!chip)
 		return -ENOMEM;
+	mxs = to_mxs_pwm_chip(chip);
 
 	mxs->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(mxs->base))
@@ -136,10 +140,9 @@ static int mxs_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(mxs->clk))
 		return PTR_ERR(mxs->clk);
 
-	mxs->chip.dev = &pdev->dev;
-	mxs->chip.ops = &mxs_pwm_ops;
+	chip->ops = &mxs_pwm_ops;
 
-	ret = of_property_read_u32(np, "fsl,pwm-number", &mxs->chip.npwm);
+	ret = of_property_read_u32(np, "fsl,pwm-number", &chip->npwm);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to get pwm number: %d\n", ret);
 		return ret;
@@ -150,7 +153,7 @@ static int mxs_pwm_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret, "failed to reset PWM\n");
 
-	ret = devm_pwmchip_add(&pdev->dev, &mxs->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to add pwm chip %d\n", ret);
 		return ret;
-- 
2.39.2

