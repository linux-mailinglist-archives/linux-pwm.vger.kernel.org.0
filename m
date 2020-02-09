Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA4ED156CBE
	for <lists+linux-pwm@lfdr.de>; Sun,  9 Feb 2020 22:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgBIVbU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 9 Feb 2020 16:31:20 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34661 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgBIVbT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 9 Feb 2020 16:31:19 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1j0uAe-0006zK-9R; Sun, 09 Feb 2020 22:31:16 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1j0uAb-0005Km-N4; Sun, 09 Feb 2020 22:31:13 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] pwm: imx27: fix clk handling in pwm_imx27_apply()
Date:   Sun,  9 Feb 2020 22:31:06 +0100
Message-Id: <20200209213106.5067-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.24.0
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

pwm_imx27_apply() enables the clocks if the previous PWM state was
disabled. Given that the clocks are supposed to be left on iff the PWM
is running, the decision to disable the clocks at the end of the
function must not depend on the previous state.

Without this fix the enable count of the two affected clocks increases
by one whenever pwm_apply changes from one disabled state to another.

Fixes: bd88d319abe9 ("pwm: imx27: Unconditionally write state to hardware")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-imx27.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index 35a7ac42269c..7e5ed0152977 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -289,7 +289,7 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	writel(cr, imx->mmio_base + MX3_PWMCR);
 
-	if (!state->enabled && cstate.enabled)
+	if (!state->enabled)
 		pwm_imx27_clk_disable_unprepare(chip);
 
 	return 0;
-- 
2.24.0

