Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7256A9FC3
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Mar 2023 19:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbjCCSzd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Mar 2023 13:55:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbjCCSzV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Mar 2023 13:55:21 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B1615579
        for <linux-pwm@vger.kernel.org>; Fri,  3 Mar 2023 10:55:09 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYb-0006TX-Vc; Fri, 03 Mar 2023 19:55:06 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYa-001cVU-IZ; Fri, 03 Mar 2023 19:55:04 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYZ-001ulT-0f; Fri, 03 Mar 2023 19:55:03 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org
Subject: [PATCH 29/30] pwm: vt8500: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 19:54:44 +0100
Message-Id: <20230303185445.2112695-30-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303185445.2112695-1-u.kleine-koenig@pengutronix.de>
References: <20230303185445.2112695-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1531; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=lSSpWyWkk4FqHIeTkf1JcZ0FMOqxNIHwY0d0Ixch0qs=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAkJqZXL1ZdAMoJkgaYL8L7Wm73ntFwCZeVxqY n2WMQrjsMyJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAJCagAKCRDB/BR4rcrs CbJHCACMY4/yjYLfeuiYZMsFezT59lwsH4vvt/ZnVO0H4B9UFrCikyiRw6Iki02J3L6HboezBt8 WO6LZt68/fVGyqHbhOK4Nh6spS/Sh3mu99SJ27KsaAbMkyyqNHOWZSH9skWy/a5m0VETasYaOhd n0u+CJJkqo20aX5f6X+338UVL9VtjiRgPohzir0bsLxJywvg2C8/wUGkS+cCXhtnJ9BUFVqwTtm p8VgWiAQLtSH4567xD5zw1SeW+MYmJUZkIt0eP0rPsuEykQ5WlA9FWyNyjfYyARRBrlMst66EqO 63SiHMZOYCsaxZgOnmcHij9n7Kelwlog5KwMKgXkq98GMSQJ
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is (mostly) ignored
and this typically results in resource leaks. To improve here there is a
quest to make the remove callback return void. In the first step of this
quest all drivers are converted to .remove_new() which already returns
void.

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-vt8500.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-vt8500.c b/drivers/pwm/pwm-vt8500.c
index f1ff9940b37c..d2c48fd98706 100644
--- a/drivers/pwm/pwm-vt8500.c
+++ b/drivers/pwm/pwm-vt8500.c
@@ -279,20 +279,18 @@ static int vt8500_pwm_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int vt8500_pwm_remove(struct platform_device *pdev)
+static void vt8500_pwm_remove(struct platform_device *pdev)
 {
 	struct vt8500_chip *vt8500 = platform_get_drvdata(pdev);
 
 	pwmchip_remove(&vt8500->chip);
 
 	clk_unprepare(vt8500->clk);
-
-	return 0;
 }
 
 static struct platform_driver vt8500_pwm_driver = {
 	.probe		= vt8500_pwm_probe,
-	.remove		= vt8500_pwm_remove,
+	.remove_new	= vt8500_pwm_remove,
 	.driver		= {
 		.name	= "vt8500-pwm",
 		.of_match_table = vt8500_pwm_dt_ids,
-- 
2.39.1

