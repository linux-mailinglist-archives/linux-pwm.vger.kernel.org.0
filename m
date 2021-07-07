Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 629893BEC1F
	for <lists+linux-pwm@lfdr.de>; Wed,  7 Jul 2021 18:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbhGGQbZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 7 Jul 2021 12:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbhGGQbY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 7 Jul 2021 12:31:24 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFA5C061574
        for <linux-pwm@vger.kernel.org>; Wed,  7 Jul 2021 09:28:43 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1APh-0003qC-QG; Wed, 07 Jul 2021 18:28:41 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1APh-0002aq-0f; Wed, 07 Jul 2021 18:28:41 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1APg-0006HE-WB; Wed, 07 Jul 2021 18:28:40 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 02/47] pwm: mxs: Don't modify HW state in .probe() after the PWM chip was registered
Date:   Wed,  7 Jul 2021 18:27:50 +0200
Message-Id: <20210707162835.1772882-3-u.kleine-koenig@pengutronix.de>
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
consumer's back is bad. So reset before calling pwmchip_add().

Note that reseting the hardware isn't the right thing to do if the PWM
is already running as it might e.g. disable (or even enable) a backlight
that is supposed to be on (or off).

Fixes: 4dce82c1e840 ("pwm: add pwm-mxs support")
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-mxs.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-mxs.c b/drivers/pwm/pwm-mxs.c
index a22180803bd7..558dc1de8f5d 100644
--- a/drivers/pwm/pwm-mxs.c
+++ b/drivers/pwm/pwm-mxs.c
@@ -145,6 +145,11 @@ static int mxs_pwm_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/* FIXME: Only do this if the PWM isn't already running */
+	ret = stmp_reset_block(mxs->base);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "failed to reset PWM\n");
+
 	ret = pwmchip_add(&mxs->chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to add pwm chip %d\n", ret);
@@ -153,15 +158,7 @@ static int mxs_pwm_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, mxs);
 
-	ret = stmp_reset_block(mxs->base);
-	if (ret)
-		goto pwm_remove;
-
 	return 0;
-
-pwm_remove:
-	pwmchip_remove(&mxs->chip);
-	return ret;
 }
 
 static int mxs_pwm_remove(struct platform_device *pdev)
-- 
2.30.2

