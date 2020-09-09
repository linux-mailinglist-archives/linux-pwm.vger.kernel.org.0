Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53B86262F9F
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Sep 2020 16:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730277AbgIIOM2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 9 Sep 2020 10:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730276AbgIINHq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 9 Sep 2020 09:07:46 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB98C061786
        for <linux-pwm@vger.kernel.org>; Wed,  9 Sep 2020 06:07:52 -0700 (PDT)
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1kFzpB-0002t3-5r; Wed, 09 Sep 2020 15:07:45 +0200
Received: from mfe by dude02.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1kFzp9-0004Uy-Ib; Wed, 09 Sep 2020 15:07:43 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, Anson.Huang@nxp.com,
        michal.vokac@ysoft.com, l.majewski@majess.pl
Cc:     linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
Subject: [PATCH 1/3] pwm: imx27: track clock enable/disable to simplify code
Date:   Wed,  9 Sep 2020 15:07:37 +0200
Message-Id: <20200909130739.26717-2-m.felsch@pengutronix.de>
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

Introduce a simple clock state so we can enable/disable the clock
without the need to check if we are running or not.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/pwm/pwm-imx27.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index c50d453552bd..3cf9f1774244 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -91,6 +91,7 @@ struct pwm_imx27_chip {
 	 * value to return in that case.
 	 */
 	unsigned int duty_cycle;
+	bool clk_on;
 };
 
 #define to_pwm_imx27_chip(chip)	container_of(chip, struct pwm_imx27_chip, chip)
@@ -99,6 +100,9 @@ static int pwm_imx27_clk_prepare_enable(struct pwm_imx27_chip *imx)
 {
 	int ret;
 
+	if (imx->clk_on)
+		return 0;
+
 	ret = clk_prepare_enable(imx->clk_ipg);
 	if (ret)
 		return ret;
@@ -109,13 +113,20 @@ static int pwm_imx27_clk_prepare_enable(struct pwm_imx27_chip *imx)
 		return ret;
 	}
 
+	imx->clk_on = true;
+
 	return 0;
 }
 
 static void pwm_imx27_clk_disable_unprepare(struct pwm_imx27_chip *imx)
 {
+	if (!imx->clk_on)
+		return;
+
 	clk_disable_unprepare(imx->clk_per);
 	clk_disable_unprepare(imx->clk_ipg);
+
+	imx->clk_on = false;
 }
 
 static void pwm_imx27_get_state(struct pwm_chip *chip,
@@ -223,6 +234,10 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	int ret;
 	u32 cr;
 
+	ret = pwm_imx27_clk_prepare_enable(imx);
+	if (ret)
+		return ret;
+
 	pwm_get_state(pwm, &cstate);
 
 	clkrate = clk_get_rate(imx->clk_per);
@@ -254,10 +269,6 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (cstate.enabled) {
 		pwm_imx27_wait_fifo_slot(chip, pwm);
 	} else {
-		ret = pwm_imx27_clk_prepare_enable(imx);
-		if (ret)
-			return ret;
-
 		pwm_imx27_sw_reset(chip);
 	}
 
-- 
2.20.1

