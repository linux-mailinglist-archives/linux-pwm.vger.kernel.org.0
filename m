Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E907774826
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 21:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233244AbjHHT1d (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 15:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236432AbjHHT1V (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 15:27:21 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4725C7585F
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:20:20 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQND-0007UP-IE; Tue, 08 Aug 2023 19:19:59 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNC-00228o-AQ; Tue, 08 Aug 2023 19:19:58 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNB-00BTF7-LP; Tue, 08 Aug 2023 19:19:57 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 077/101] pwm: imx27: Store parent device in driver data
Date:   Tue,  8 Aug 2023 19:19:07 +0200
Message-Id: <20230808171931.944154-78-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1944; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=UHH3PdRPx/Y1bJld3KGcdkySKcjv7Mvh0pckiS+01Xs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0nkH5RNSSv4zdbIvKld86ICP8EOh2ahk/zpA1 iV6SPzSnz+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ5BwAKCRCPgPtYfRL+ TpRMB/9N0CLe+17r/xEFEFrsqJoV+9lEjIIVM1n1eMbsEa9AHkz04UwDBoAOdX0Of1AwZKQ84FJ tjW7u+8/6S7OOfUyAJKBJX5ppSe/mV75uTm/sf0umTVbZu2voPi/C3/v+8aA5+Nkgcy74taqgfl 76Xx+F1X4pTHFsPE/yhUQgeEKiTOXN5U9b8OwHjQBKmTsDoiqFitLNN7RZ10FswdsDugLxQ5sP9 9v/Y4wbXNYFYLCv+pw8aVaJNXZYie3tmDV3ercgwXBOsC79wcanzXEDj1tGJcxQgjWrc3D+zW2M yejuxtfQL52dGKKPjzR6MI3b2r7CXeiH9Chlu+3jABMMYqGk
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

struct pwm_chip::dev is about to change. To not have to touch this
driver in the same commit as struct pwm_chip::dev, store a pointer to
the parent device in driver data.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-imx27.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index 79af72fbcec3..cdda3967c6c0 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -80,6 +80,7 @@
 #define MX3_PWMPR_MAX			0xfffe
 
 struct pwm_imx27_chip {
+	struct device *parent;
 	struct clk	*clk_ipg;
 	struct clk	*clk_per;
 	void __iomem	*mmio_base;
@@ -147,7 +148,7 @@ static int pwm_imx27_get_state(struct pwm_chip *chip,
 		state->polarity = PWM_POLARITY_INVERSED;
 		break;
 	default:
-		dev_warn(chip->dev, "can't set polarity, output disconnected");
+		dev_warn(imx->parent, "can't set polarity, output disconnected");
 	}
 
 	prescaler = MX3_PWMCR_PRESCALER_GET(val);
@@ -179,7 +180,7 @@ static int pwm_imx27_get_state(struct pwm_chip *chip,
 static void pwm_imx27_sw_reset(struct pwm_chip *chip)
 {
 	struct pwm_imx27_chip *imx = to_pwm_imx27_chip(chip);
-	struct device *dev = chip->dev;
+	struct device *dev = imx->parent;
 	int wait_count = 0;
 	u32 cr;
 
@@ -198,7 +199,7 @@ static void pwm_imx27_wait_fifo_slot(struct pwm_chip *chip,
 				     struct pwm_device *pwm)
 {
 	struct pwm_imx27_chip *imx = to_pwm_imx27_chip(chip);
-	struct device *dev = chip->dev;
+	struct device *dev = imx->parent;
 	unsigned int period_ms;
 	int fifoav;
 	u32 sr;
@@ -318,6 +319,7 @@ static int pwm_imx27_probe(struct platform_device *pdev)
 		return PTR_ERR(chip);
 	imx = pwmchip_priv(chip);
 
+	imx->parent = &pdev->dev;
 	imx->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
 	if (IS_ERR(imx->clk_ipg))
 		return dev_err_probe(&pdev->dev, PTR_ERR(imx->clk_ipg),
-- 
2.40.1

