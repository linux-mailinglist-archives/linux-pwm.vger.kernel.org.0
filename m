Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C46641584A8
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Feb 2020 22:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbgBJVXC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 10 Feb 2020 16:23:02 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39637 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbgBJVXC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 10 Feb 2020 16:23:02 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1j1GWC-0000yM-HV; Mon, 10 Feb 2020 22:23:00 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1j1GWB-00042y-Bp; Mon, 10 Feb 2020 22:22:59 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/3] pwm: imx27: Ensure clocks being on iff the PWM is on
Date:   Mon, 10 Feb 2020 22:22:40 +0100
Message-Id: <20200210212240.25513-4-u.kleine-koenig@pengutronix.de>
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

Up to now the .probe function didn't enable clks and relied on the core
to call the .get_state() callback to have the clk running. The latter
enabled the needed clocks and kept them running if the PWM is enabled.

This only works correctly if the .get_state() callback is called exactly
once and this single call happens before unused clocks are disabled by
the clk core.

The former wasn't true for a short period while commit 01ccf903edd6
("pwm: Let pwm_get_state() return the last implemented state") applied
and not not reverted yet and might become wrong in the future.

The latter isn't true any more since commit cfc4c189bc70 ("pwm: Read
initial hardware state at request time") which results in a running PWM
being stopped at boot time if for example the consumer lives in a kernel
module that is only loaded after the clk core disabled unused clocks.

So ensure .probe() is left with the clocks on if the PWM is running and
.get_state() disables everything it enabled.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-imx27.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index fb142813d455..e83c077bb7cc 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -171,8 +171,7 @@ static void pwm_imx27_get_state(struct pwm_chip *chip,
 	tmp = NSEC_PER_SEC * (u64)(val);
 	state->duty_cycle = DIV_ROUND_CLOSEST_ULL(tmp, pwm_clk);
 
-	if (!state->enabled)
-		pwm_imx27_clk_disable_unprepare(imx);
+	pwm_imx27_clk_disable_unprepare(imx);
 }
 
 static void pwm_imx27_sw_reset(struct pwm_chip *chip)
@@ -307,6 +306,8 @@ MODULE_DEVICE_TABLE(of, pwm_imx27_dt_ids);
 static int pwm_imx27_probe(struct platform_device *pdev)
 {
 	struct pwm_imx27_chip *imx;
+	int ret;
+	u32 pwmcr;
 
 	imx = devm_kzalloc(&pdev->dev, sizeof(*imx), GFP_KERNEL);
 	if (imx == NULL)
@@ -349,6 +350,15 @@ static int pwm_imx27_probe(struct platform_device *pdev)
 	if (IS_ERR(imx->mmio_base))
 		return PTR_ERR(imx->mmio_base);
 
+	ret = pwm_imx27_clk_prepare_enable(imx);
+	if (ret)
+		return ret;
+
+	/* keep clks on if pwm is running */
+	pwmcr = readl(imx->mmio_base + MX3_PWMCR);
+	if (!(pwmcr & MX3_PWMCR_EN))
+		pwm_imx27_clk_disable_unprepare(imx);
+
 	return pwmchip_add(&imx->chip);
 }
 
-- 
2.24.0

