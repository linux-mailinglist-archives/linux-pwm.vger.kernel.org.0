Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80407D0309
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Oct 2023 22:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjJSUIK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 19 Oct 2023 16:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjJSUIJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 19 Oct 2023 16:08:09 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7CB124
        for <linux-pwm@vger.kernel.org>; Thu, 19 Oct 2023 13:08:07 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qtZJ6-0000Ag-V6; Thu, 19 Oct 2023 22:07:48 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qtZJ5-002rfs-Jv; Thu, 19 Oct 2023 22:07:47 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qtZJ5-001ve3-AL; Thu, 19 Oct 2023 22:07:47 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pwm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: [PATCH 1/5] pwm: stm32: Replace write_ccrx with regmap_write
Date:   Thu, 19 Oct 2023 22:07:00 +0200
Message-ID: <20231019200658.1754190-8-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231019200658.1754190-7-u.kleine-koenig@pengutronix.de>
References: <20231019200658.1754190-7-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1768; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=XJO2ggFWysOn0g4wuN+uvCKU8+S2R3VmfphxGItb/Jo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlMYxjGVnCbg0gnva3opb6gZdeiT1Ots7MkwFf4 acaYa6X76aJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZTGMYwAKCRCPgPtYfRL+ Tp3NB/0eTOzkcQ5HvaeR4sNjFj4/tyNZ2XaSKgaGZDhGXGsPvIm40b/R/RBUVGETXKfZb3/ojf7 phq2p79AeVXuiyYbXEC03lDjBqGWn9bK0FzawYBRiiQvDYJnddPN/bs4+dmbdwzTSoSr36qZnWD bo8hfhA0uqdfacHt0XHJ7gNmmlfHIMftD9WYEA1DuMyR/WIKCFlPicla3N7XTotNwyHNZt5AGJe PEVp3EY3Mr5sTMzRAbCbgjb1LeREooFYGNGhOQaVj9/u5P6FunyH+RDTgvPuVsErjNBJuKphwI7 rLAIFSz/8H12vhu8paiknEmseAFnk+CwqYwrSO3vXJuTlVLK
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Philipp Zabel <p.zabel@pengutronix.de>

The TIM_CCR1...4 registers are consecutive, so replace the switch
case with a simple calculation. Since ch is known to be in the 0...3
range (it is set to hwpwm < npwm <= 4), drop the unnecessary error
handling. The return value was not checked anyway. What remains does
not warrant keeping the write_ccrx() function around, so instead call
regmap_write() directly at the singular call site.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-stm32.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index 3303a754ea02..5e48584e3bd4 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -52,21 +52,6 @@ static u32 active_channels(struct stm32_pwm *dev)
 	return ccer & TIM_CCER_CCXE;
 }
 
-static int write_ccrx(struct stm32_pwm *dev, int ch, u32 value)
-{
-	switch (ch) {
-	case 0:
-		return regmap_write(dev->regmap, TIM_CCR1, value);
-	case 1:
-		return regmap_write(dev->regmap, TIM_CCR2, value);
-	case 2:
-		return regmap_write(dev->regmap, TIM_CCR3, value);
-	case 3:
-		return regmap_write(dev->regmap, TIM_CCR4, value);
-	}
-	return -EINVAL;
-}
-
 #define TIM_CCER_CC12P (TIM_CCER_CC1P | TIM_CCER_CC2P)
 #define TIM_CCER_CC12E (TIM_CCER_CC1E | TIM_CCER_CC2E)
 #define TIM_CCER_CC34P (TIM_CCER_CC3P | TIM_CCER_CC4P)
@@ -369,7 +354,7 @@ static int stm32_pwm_config(struct stm32_pwm *priv, int ch,
 	dty = prd * duty_ns;
 	do_div(dty, period_ns);
 
-	write_ccrx(priv, ch, dty);
+	regmap_write(priv->regmap, TIM_CCR1 + 4 * ch, dty);
 
 	/* Configure output mode */
 	shift = (ch & 0x1) * CCMR_CHANNEL_SHIFT;
-- 
2.42.0

