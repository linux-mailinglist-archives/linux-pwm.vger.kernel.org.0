Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 098EFF701F
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Nov 2019 10:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbfKKJEN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 11 Nov 2019 04:04:13 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:54311 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbfKKJEN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 11 Nov 2019 04:04:13 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iU5cG-0007lo-QV; Mon, 11 Nov 2019 10:04:08 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iU5cG-0003Yz-HP; Mon, 11 Nov 2019 10:04:08 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, Neil Brown <neilb@suse.de>,
        Markus Elfring <elfring@users.sourceforge.net>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 3/4] pwm: omap-dmtimer: put_device() after of_find_device_by_node()
Date:   Mon, 11 Nov 2019 10:03:56 +0100
Message-Id: <20191111090357.13903-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191111090357.13903-1-u.kleine-koenig@pengutronix.de>
References: <20191111071952.6pbswbboqreen6im@pengutronix.de>
 <20191111090357.13903-1-u.kleine-koenig@pengutronix.de>
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

This was found by coccicheck:

	drivers/pwm/pwm-omap-dmtimer.c:304:2-8: ERROR: missing put_device;
	call of_find_device_by_node on line 255, but without a corresponding
	object release within this function.

Reported-by: Markus Elfring <elfring@users.sourceforge.net>
Fixes: 6604c6556db9 ("pwm: Add PWM driver for OMAP using dual-mode timers")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-omap-dmtimer.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index e36fcad668a6..88a3c5690fea 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -256,7 +256,7 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
 	if (!timer_pdev) {
 		dev_err(&pdev->dev, "Unable to find Timer pdev\n");
 		ret = -ENODEV;
-		goto put;
+		goto err_find_timer_pdev;
 	}
 
 	timer_pdata = dev_get_platdata(&timer_pdev->dev);
@@ -264,7 +264,7 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
 		dev_dbg(&pdev->dev,
 			 "dmtimer pdata structure NULL, deferring probe\n");
 		ret = -EPROBE_DEFER;
-		goto put;
+		goto err_platdata;
 	}
 
 	pdata = timer_pdata->timer_ops;
@@ -283,19 +283,19 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
 	    !pdata->write_counter) {
 		dev_err(&pdev->dev, "Incomplete dmtimer pdata structure\n");
 		ret = -EINVAL;
-		goto put;
+		goto err_platdata;
 	}
 
 	if (!of_get_property(timer, "ti,timer-pwm", NULL)) {
 		dev_err(&pdev->dev, "Missing ti,timer-pwm capability\n");
 		ret = -ENODEV;
-		goto put;
+		goto err_timer_property;
 	}
 
 	dm_timer = pdata->request_by_node(timer);
 	if (!dm_timer) {
 		ret = -EPROBE_DEFER;
-		goto put;
+		goto err_request_timer;
 	}
 
 	omap = devm_kzalloc(&pdev->dev, sizeof(*omap), GFP_KERNEL);
@@ -352,7 +352,14 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
 err_alloc_omap:
 
 	pdata->free(dm_timer);
-put:
+err_request_timer:
+
+err_timer_property:
+err_platdata:
+
+	put_device(&timer_pdev->dev);
+err_find_timer_pdev:
+
 	of_node_put(timer);
 
 	return ret;
@@ -372,6 +379,8 @@ static int pwm_omap_dmtimer_remove(struct platform_device *pdev)
 
 	omap->pdata->free(omap->dm_timer);
 
+	put_device(&omap->dm_timer_pdev->dev);
+
 	mutex_destroy(&omap->mutex);
 
 	return 0;
-- 
2.23.0

