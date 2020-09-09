Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6BDA262F96
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Sep 2020 16:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730276AbgIIOMk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 9 Sep 2020 10:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730275AbgIINHq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 9 Sep 2020 09:07:46 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67CAC061755
        for <linux-pwm@vger.kernel.org>; Wed,  9 Sep 2020 06:07:51 -0700 (PDT)
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1kFzpB-0002t4-5p; Wed, 09 Sep 2020 15:07:45 +0200
Received: from mfe by dude02.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1kFzp9-0004Vk-K3; Wed, 09 Sep 2020 15:07:43 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, Anson.Huang@nxp.com,
        michal.vokac@ysoft.com, l.majewski@majess.pl
Cc:     linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
Subject: [PATCH 2/3] pwm: imx27: move static pwmcr values into probe() function
Date:   Wed,  9 Sep 2020 15:07:38 +0200
Message-Id: <20200909130739.26717-3-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200909130739.26717-1-m.felsch@pengutronix.de>
References: <20200909130739.26717-1-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The STOPEN, DOZEN, WAITEN, DBGEN and the CLKSRC bit values never change.
So it should be save to move this bit settings into probe() and change
only the necessary bits during apply(). Therefore I added the
pwm_imx27_update_bits() helper.

Furthermore the patch adds the support to reset the pwm device during
probe() if the pwm device is disabled.

Both steps are required in preparation of the further patch which fixes
the "pwm-disabled" state for inverted pwms.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/pwm/pwm-imx27.c | 41 +++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index 3cf9f1774244..30388a9ece04 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -96,6 +96,16 @@ struct pwm_imx27_chip {
 
 #define to_pwm_imx27_chip(chip)	container_of(chip, struct pwm_imx27_chip, chip)
 
+static void pwm_imx27_update_bits(void __iomem *reg, u32 mask, u32 val)
+{
+	u32 tmp;
+
+	tmp = readl(reg);
+	tmp &= ~mask;
+	tmp |= val & mask;
+	return writel(tmp, reg);
+}
+
 static int pwm_imx27_clk_prepare_enable(struct pwm_imx27_chip *imx)
 {
 	int ret;
@@ -183,10 +193,8 @@ static void pwm_imx27_get_state(struct pwm_chip *chip,
 	pwm_imx27_clk_disable_unprepare(imx);
 }
 
-static void pwm_imx27_sw_reset(struct pwm_chip *chip)
+static void pwm_imx27_sw_reset(struct pwm_imx27_chip *imx, struct device *dev)
 {
-	struct pwm_imx27_chip *imx = to_pwm_imx27_chip(chip);
-	struct device *dev = chip->dev;
 	int wait_count = 0;
 	u32 cr;
 
@@ -232,7 +240,7 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	unsigned long long c;
 	unsigned long long clkrate;
 	int ret;
-	u32 cr;
+	u32 cr, mask;
 
 	ret = pwm_imx27_clk_prepare_enable(imx);
 	if (ret)
@@ -269,7 +277,7 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (cstate.enabled) {
 		pwm_imx27_wait_fifo_slot(chip, pwm);
 	} else {
-		pwm_imx27_sw_reset(chip);
+		pwm_imx27_sw_reset(imx, chip->dev);
 	}
 
 	writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
@@ -281,10 +289,7 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	 */
 	imx->duty_cycle = duty_cycles;
 
-	cr = MX3_PWMCR_PRESCALER_SET(prescale) |
-	     MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_WAITEN |
-	     FIELD_PREP(MX3_PWMCR_CLKSRC, MX3_PWMCR_CLKSRC_IPG_HIGH) |
-	     MX3_PWMCR_DBGEN;
+	cr = MX3_PWMCR_PRESCALER_SET(prescale);
 
 	if (state->polarity == PWM_POLARITY_INVERSED)
 		cr |= FIELD_PREP(MX3_PWMCR_POUTC,
@@ -293,7 +298,9 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (state->enabled)
 		cr |= MX3_PWMCR_EN;
 
-	writel(cr, imx->mmio_base + MX3_PWMCR);
+	mask = MX3_PWMCR_PRESCALER | MX3_PWMCR_POUTC | MX3_PWMCR_EN;
+
+	pwm_imx27_update_bits(imx->mmio_base + MX3_PWMCR, mask, cr);
 
 	if (!state->enabled)
 		pwm_imx27_clk_disable_unprepare(imx);
@@ -364,10 +371,20 @@ static int pwm_imx27_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	/* keep clks on if pwm is running */
+	/* Keep clks on and pwm settings unchanged if the PWM is already running */
 	pwmcr = readl(imx->mmio_base + MX3_PWMCR);
-	if (!(pwmcr & MX3_PWMCR_EN))
+	if (!(pwmcr & MX3_PWMCR_EN)) {
+		u32 mask;
+
+		pwm_imx27_sw_reset(imx, &pdev->dev);
+		mask = MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_WAITEN |
+			MX3_PWMCR_DBGEN | MX3_PWMCR_CLKSRC;
+		pwmcr = MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_WAITEN |
+			MX3_PWMCR_DBGEN |
+			FIELD_PREP(MX3_PWMCR_CLKSRC, MX3_PWMCR_CLKSRC_IPG_HIGH);
+		pwm_imx27_update_bits(imx->mmio_base + MX3_PWMCR, mask, pwmcr);
 		pwm_imx27_clk_disable_unprepare(imx);
+	}
 
 	return pwmchip_add(&imx->chip);
 }
-- 
2.20.1

