Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB10F701C
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Nov 2019 10:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbfKKJEM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 11 Nov 2019 04:04:12 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:49959 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbfKKJEM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 11 Nov 2019 04:04:12 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iU5cG-0007ll-O0; Mon, 11 Nov 2019 10:04:08 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iU5cG-0003Yt-3c; Mon, 11 Nov 2019 10:04:08 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, Neil Brown <neilb@suse.de>,
        Markus Elfring <elfring@users.sourceforge.net>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 1/4] pwm: omap-dmtimer: remove pwmchip in .remove before making it unfunctional
Date:   Mon, 11 Nov 2019 10:03:54 +0100
Message-Id: <20191111090357.13903-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191111071952.6pbswbboqreen6im@pengutronix.de>
References: <20191111071952.6pbswbboqreen6im@pengutronix.de>
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

In the old code (e.g.) mutex_destroy() was called before
pwmchip_remove(). Between these two calls it is possible that a pwm
callback is used which tries to grab the mutex.

Fixes: 6604c6556db9 ("pwm: Add PWM driver for OMAP using dual-mode timers")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-omap-dmtimer.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index 00772fc53490..bdf94c78655f 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -351,6 +351,11 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
 static int pwm_omap_dmtimer_remove(struct platform_device *pdev)
 {
 	struct pwm_omap_dmtimer_chip *omap = platform_get_drvdata(pdev);
+	int ret;
+
+	ret = pwmchip_remove(&omap->chip);
+	if (ret)
+		return ret;
 
 	if (pm_runtime_active(&omap->dm_timer_pdev->dev))
 		omap->pdata->stop(omap->dm_timer);
@@ -359,7 +364,7 @@ static int pwm_omap_dmtimer_remove(struct platform_device *pdev)
 
 	mutex_destroy(&omap->mutex);
 
-	return pwmchip_remove(&omap->chip);
+	return 0;
 }
 
 static const struct of_device_id pwm_omap_dmtimer_of_match[] = {
-- 
2.23.0

