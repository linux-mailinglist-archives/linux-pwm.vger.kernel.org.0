Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5F221584AA
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Feb 2020 22:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbgBJVXD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 10 Feb 2020 16:23:03 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59611 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727414AbgBJVXC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 10 Feb 2020 16:23:02 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1j1GWC-0000yK-HW; Mon, 10 Feb 2020 22:23:00 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1j1GWA-00042s-V8; Mon, 10 Feb 2020 22:22:58 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/3] pwm: imx27: Simplify helper function to enable and disable clocks
Date:   Mon, 10 Feb 2020 22:22:38 +0100
Message-Id: <20200210212240.25513-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200210212240.25513-1-u.kleine-koenig@pengutronix.de>
References: <20200209213106.5067-1-u.kleine-koenig@pengutronix.de>
 <20200210212240.25513-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

pwm_imx27_clk_prepare_enable() took a pointer to a struct pwm_chip just
to convert it to a struct pwm_imx27_chip pointer while all callers
already have the latter. Ditto for pwm_imx27_clk_disable_unprepare().

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-imx27.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index 7e5ed0152977..e04ae566bbf9 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -96,9 +96,8 @@ struct pwm_imx27_chip {
 
 #define to_pwm_imx27_chip(chip)	container_of(chip, struct pwm_imx27_chip, chip)
 
-static int pwm_imx27_clk_prepare_enable(struct pwm_chip *chip)
+static int pwm_imx27_clk_prepare_enable(struct pwm_imx27_chip *imx)
 {
-	struct pwm_imx27_chip *imx = to_pwm_imx27_chip(chip);
 	int ret;
 
 	ret = clk_prepare_enable(imx->clk_ipg);
@@ -114,10 +113,8 @@ static int pwm_imx27_clk_prepare_enable(struct pwm_chip *chip)
 	return 0;
 }
 
-static void pwm_imx27_clk_disable_unprepare(struct pwm_chip *chip)
+static void pwm_imx27_clk_disable_unprepare(struct pwm_imx27_chip *imx)
 {
-	struct pwm_imx27_chip *imx = to_pwm_imx27_chip(chip);
-
 	clk_disable_unprepare(imx->clk_per);
 	clk_disable_unprepare(imx->clk_ipg);
 }
@@ -130,7 +127,7 @@ static void pwm_imx27_get_state(struct pwm_chip *chip,
 	u64 tmp;
 	int ret;
 
-	ret = pwm_imx27_clk_prepare_enable(chip);
+	ret = pwm_imx27_clk_prepare_enable(imx);
 	if (ret < 0)
 		return;
 
@@ -175,7 +172,7 @@ static void pwm_imx27_get_state(struct pwm_chip *chip,
 	state->duty_cycle = DIV_ROUND_CLOSEST_ULL(tmp, pwm_clk);
 
 	if (!state->enabled)
-		pwm_imx27_clk_disable_unprepare(chip);
+		pwm_imx27_clk_disable_unprepare(imx);
 }
 
 static void pwm_imx27_sw_reset(struct pwm_chip *chip)
@@ -259,7 +256,7 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (cstate.enabled) {
 		pwm_imx27_wait_fifo_slot(chip, pwm);
 	} else {
-		ret = pwm_imx27_clk_prepare_enable(chip);
+		ret = pwm_imx27_clk_prepare_enable(imx);
 		if (ret)
 			return ret;
 
@@ -290,7 +287,7 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	writel(cr, imx->mmio_base + MX3_PWMCR);
 
 	if (!state->enabled)
-		pwm_imx27_clk_disable_unprepare(chip);
+		pwm_imx27_clk_disable_unprepare(imx);
 
 	return 0;
 }
@@ -361,7 +358,7 @@ static int pwm_imx27_remove(struct platform_device *pdev)
 
 	imx = platform_get_drvdata(pdev);
 
-	pwm_imx27_clk_disable_unprepare(&imx->chip);
+	pwm_imx27_clk_disable_unprepare(imx);
 
 	return pwmchip_remove(&imx->chip);
 }
-- 
2.24.0

