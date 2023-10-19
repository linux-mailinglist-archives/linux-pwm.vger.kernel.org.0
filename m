Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF28D7D0303
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Oct 2023 22:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjJSUHz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 19 Oct 2023 16:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjJSUHy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 19 Oct 2023 16:07:54 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62F7124
        for <linux-pwm@vger.kernel.org>; Thu, 19 Oct 2023 13:07:52 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qtZJ7-0000Bd-8J; Thu, 19 Oct 2023 22:07:49 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qtZJ6-002rg4-RO; Thu, 19 Oct 2023 22:07:48 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qtZJ6-001veT-I0; Thu, 19 Oct 2023 22:07:48 +0200
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
Subject: [PATCH 5/5] pwm: stm32: Fix enable count for clk in .probe()
Date:   Thu, 19 Oct 2023 22:07:04 +0200
Message-ID: <20231019200658.1754190-12-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231019200658.1754190-7-u.kleine-koenig@pengutronix.de>
References: <20231019200658.1754190-7-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2288; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=WvXDNthRYYY+rxaLHuzNpUXyl/hU4Ew/1JV88Z5oCuQ=; b=owGbwMvMwMXY3/A7olbonx/jabUkhlTDngzbO2sdlbKje6JKXSKKw/xPvCubItBbH8P/58UVq a+TPzR0MhqzMDByMciKKbLYN67JtKqSi+xc++8yzCBWJpApDFycAjARdR0OhtmvilU+nr2s2aUT aNz4P2RZ+hZTA8v8WZG5DVIn5pim7Q2drbVg7/UbKcL5phekTgf9EWf+u1honmszx4yHGfylfOf NeATCc68qOxw/lGAcHdXwuvxoCGvsxUUnJmTUJ/gmvf8aobk67bx4/71Z2w/lvfcMYJ5naXPrNu 8M+fx5QtZv1rm4hRuz5PQV3uZttToxWyk9cJWB71PPsmjGrPCeOWsKsk5IX2S4WHZLuu2nSbPnM Znpl3uaWH3Wam9K68iNXpespFYbM+3c9vLO1gBz42vL97lWtPv5zN3EMPNE+NprHZmR+9/fPr0x 65vRx73fNq/b3/DiMm+Nkiqf0aFLUWoqN7xP9C2bZb4eAA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Philipp Zabel <p.zabel@pengutronix.de>

Make the driver take over hardware state without disabling in .probe()
and enable the clock for each enabled channel.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
[ukleinek: split off from a patch that also implemented .get_state()]
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-stm32.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index 68239567a564..97a2c3c09b69 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -605,17 +605,21 @@ static void stm32_pwm_detect_complementary(struct stm32_pwm *priv)
 	priv->have_complementary_output = (ccer != 0);
 }
 
-static unsigned int stm32_pwm_detect_channels(struct stm32_pwm *priv)
+static unsigned int stm32_pwm_detect_channels(struct stm32_pwm *priv,
+					      unsigned int *num_enabled)
 {
-	u32 ccer;
+	u32 ccer, ccer_backup;
 
 	/*
 	 * If channels enable bits don't exist writing 1 will have no
 	 * effect so we can detect and count them.
 	 */
+	regmap_read(priv->regmap, TIM_CCER, &ccer_backup);
 	regmap_set_bits(priv->regmap, TIM_CCER, TIM_CCER_CCXE);
 	regmap_read(priv->regmap, TIM_CCER, &ccer);
-	regmap_clear_bits(priv->regmap, TIM_CCER, TIM_CCER_CCXE);
+	regmap_write(priv->regmap, TIM_CCER, ccer_backup);
+
+	*num_enabled = hweight32(ccer_backup & TIM_CCER_CCXE);
 
 	return hweight32(ccer & TIM_CCER_CCXE);
 }
@@ -626,6 +630,8 @@ static int stm32_pwm_probe(struct platform_device *pdev)
 	struct device_node *np = dev->of_node;
 	struct stm32_timers *ddata = dev_get_drvdata(pdev->dev.parent);
 	struct stm32_pwm *priv;
+	unsigned int num_enabled;
+	unsigned int i;
 	int ret;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
@@ -648,7 +654,11 @@ static int stm32_pwm_probe(struct platform_device *pdev)
 
 	priv->chip.dev = dev;
 	priv->chip.ops = &stm32pwm_ops;
-	priv->chip.npwm = stm32_pwm_detect_channels(priv);
+	priv->chip.npwm = stm32_pwm_detect_channels(priv, &num_enabled);
+
+	/* Initialize clock refcount to number of enabled PWM channels. */
+	for (i = 0; i < num_enabled; i++)
+		clk_enable(priv->clk);
 
 	ret = devm_pwmchip_add(dev, &priv->chip);
 	if (ret < 0)
-- 
2.42.0

