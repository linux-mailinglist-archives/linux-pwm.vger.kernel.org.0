Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7123BEC21
	for <lists+linux-pwm@lfdr.de>; Wed,  7 Jul 2021 18:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhGGQbZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 7 Jul 2021 12:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbhGGQbY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 7 Jul 2021 12:31:24 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBACC061764
        for <linux-pwm@vger.kernel.org>; Wed,  7 Jul 2021 09:28:44 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1APh-0003qB-Tu; Wed, 07 Jul 2021 18:28:41 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1APg-0002an-SM; Wed, 07 Jul 2021 18:28:40 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1APg-0006H5-Rc; Wed, 07 Jul 2021 18:28:40 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Sylvain Lemieux <slemieux@tycoint.com>
Subject: [PATCH 01/47] pwm: lpc32xx: Don't modify HW state in .probe() after the PWM chip was registered
Date:   Wed,  7 Jul 2021 18:27:49 +0200
Message-Id: <20210707162835.1772882-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210707162835.1772882-1-u.kleine-koenig@pengutronix.de>
References: <20210707162835.1772882-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This fixes a race condition: After pwmchip_add() is called there might
already be a consumer and then modifying the hardware behind the
consumer's back is bad. So set the default before.

(Side-note: I don't know what this register setting actually does, if
this modifies the polarity there is an inconsistency because the
inversed polarity isn't considered if the PWM is already running during
.probe().)

Fixes: acfd92fdfb93 ("pwm: lpc32xx: Set PWM_PIN_LEVEL bit to default value")
Cc: Sylvain Lemieux <slemieux@tycoint.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-lpc32xx.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-lpc32xx.c b/drivers/pwm/pwm-lpc32xx.c
index 2834a0f001d3..719e8e913656 100644
--- a/drivers/pwm/pwm-lpc32xx.c
+++ b/drivers/pwm/pwm-lpc32xx.c
@@ -117,17 +117,17 @@ static int lpc32xx_pwm_probe(struct platform_device *pdev)
 	lpc32xx->chip.ops = &lpc32xx_pwm_ops;
 	lpc32xx->chip.npwm = 1;
 
+	/* If PWM is disabled, configure the output to the default value */
+	val = readl(lpc32xx->base + (lpc32xx->chip.pwms[0].hwpwm << 2));
+	val &= ~PWM_PIN_LEVEL;
+	writel(val, lpc32xx->base + (lpc32xx->chip.pwms[0].hwpwm << 2));
+
 	ret = pwmchip_add(&lpc32xx->chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to add PWM chip, error %d\n", ret);
 		return ret;
 	}
 
-	/* When PWM is disable, configure the output to the default value */
-	val = readl(lpc32xx->base + (lpc32xx->chip.pwms[0].hwpwm << 2));
-	val &= ~PWM_PIN_LEVEL;
-	writel(val, lpc32xx->base + (lpc32xx->chip.pwms[0].hwpwm << 2));
-
 	platform_set_drvdata(pdev, lpc32xx);
 
 	return 0;
-- 
2.30.2

