Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64F8A278D3D
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Sep 2020 17:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbgIYPxn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 25 Sep 2020 11:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729048AbgIYPxn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 25 Sep 2020 11:53:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7BCC0613D3
        for <linux-pwm@vger.kernel.org>; Fri, 25 Sep 2020 08:53:42 -0700 (PDT)
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1kLq2S-0000oS-Ke; Fri, 25 Sep 2020 17:53:36 +0200
Received: from mfe by dude02.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1kLq2Q-0008QI-U5; Fri, 25 Sep 2020 17:53:34 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, Anson.Huang@nxp.com,
        michal.vokac@ysoft.com, l.majewski@majess.pl
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 3/5] pwm: imx27: reset the PWM if it is not running
Date:   Fri, 25 Sep 2020 17:53:28 +0200
Message-Id: <20200925155330.32301-4-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200925155330.32301-1-m.felsch@pengutronix.de>
References: <20200925155330.32301-1-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Trigger a software reset during probe to clear the FIFO and reset the
register values to their default. According the datasheet the DBGEN,
STOPEN, DOZEN and WAITEN bits should be untouched by the software reset
but this is not the case.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
v2:
- new patch

 drivers/pwm/pwm-imx27.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index b761764b8375..3b6bcd8d58b7 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -183,10 +183,8 @@ static void pwm_imx27_get_state(struct pwm_chip *chip,
 	pwm_imx27_clk_disable_unprepare(imx);
 }
 
-static void pwm_imx27_sw_reset(struct pwm_chip *chip)
+static void pwm_imx27_sw_reset(struct pwm_imx27_chip *imx, struct device *dev)
 {
-	struct pwm_imx27_chip *imx = to_pwm_imx27_chip(chip);
-	struct device *dev = chip->dev;
 	int wait_count = 0;
 	u32 cr;
 
@@ -266,7 +264,7 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (imx->enabled)
 		pwm_imx27_wait_fifo_slot(chip, pwm);
 	else
-		pwm_imx27_sw_reset(chip);
+		pwm_imx27_sw_reset(imx, chip->dev);
 
 	writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
 	writel(period_cycles, imx->mmio_base + MX3_PWMPR);
@@ -370,19 +368,23 @@ static int pwm_imx27_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	mask = MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_WAITEN |
-	       MX3_PWMCR_DBGEN;
-	pwmcr = MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_WAITEN |
-		MX3_PWMCR_DBGEN;
-	pwm_imx27_update_bits(imx->mmio_base + MX3_PWMCR, mask, pwmcr);
-
 	/* keep clks on and clk settings unchanged if pwm is running */
 	pwmcr = readl(imx->mmio_base + MX3_PWMCR);
 	if (!(pwmcr & MX3_PWMCR_EN)) {
-		mask = MX3_PWMCR_CLKSRC;
-		pwmcr = FIELD_PREP(MX3_PWMCR_CLKSRC, MX3_PWMCR_CLKSRC_IPG_HIGH);
+		pwm_imx27_sw_reset(imx, &pdev->dev);
+		mask = MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_WAITEN |
+		       MX3_PWMCR_DBGEN | MX3_PWMCR_CLKSRC;
+		pwmcr = MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_WAITEN |
+			MX3_PWMCR_DBGEN |
+			FIELD_PREP(MX3_PWMCR_CLKSRC, MX3_PWMCR_CLKSRC_IPG_HIGH);
 		pwm_imx27_update_bits(imx->mmio_base + MX3_PWMCR, mask, pwmcr);
 		pwm_imx27_clk_disable_unprepare(imx);
+	} else {
+		mask = MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_WAITEN |
+			MX3_PWMCR_DBGEN;
+		pwmcr = MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_WAITEN |
+			MX3_PWMCR_DBGEN;
+		pwm_imx27_update_bits(imx->mmio_base + MX3_PWMCR, mask, pwmcr);
 	}
 
 	return pwmchip_add(&imx->chip);
-- 
2.20.1

