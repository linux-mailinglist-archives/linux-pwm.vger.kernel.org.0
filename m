Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3FE6A9FB8
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Mar 2023 19:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbjCCSz1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Mar 2023 13:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbjCCSzS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Mar 2023 13:55:18 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47951F5CB
        for <linux-pwm@vger.kernel.org>; Fri,  3 Mar 2023 10:55:05 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYZ-0006OB-Pd; Fri, 03 Mar 2023 19:55:03 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYZ-001cV1-1y; Fri, 03 Mar 2023 19:55:03 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYW-001ukg-RA; Fri, 03 Mar 2023 19:55:00 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     kernel@pengutronix.de, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH 18/30] pwm: rockchip: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 19:54:33 +0100
Message-Id: <20230303185445.2112695-19-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303185445.2112695-1-u.kleine-koenig@pengutronix.de>
References: <20230303185445.2112695-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1721; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=BA5tBz3RDO+orps9Y8Wko0quf5LMj8+YSMYVNzVlmtU=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAkI/53UCg8nISaMHiQ4+6ZzNDpKtLgpeheIWj JXmDV1274mJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAJCPwAKCRDB/BR4rcrs CRYnB/956EuHuoq0uYM1tAohD8oJ5deZmHNw5BQU3ZYryxd5Qgo/oR3pqM+6lVF1esDKM5dP07h 9HcJngDvvnuZ09M+m1HvcrgBIe/1mF9b+y7qKwO7vGfXZHR+CA39vVepDQa0WbIG5bWo8JFF4wd RbtnaijBEOZVb3fApvM7qeGW+nFWrr9Fvx17XDNAIlXIHtf2BnFPAgJ4NVuugGhTJdp6epBAouY 2pskEFCFb4W+0zKrrdo1c+ezjfqW6EFWdDSwLOSvCtoxfxHKesGBcbq63iOvcTtWltA7/FHuVPo awIhMIyGoxrrBBbAth5LDK1TGe6WqTEiASb0IqRH9IKGA6Ke
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
 drivers/pwm/pwm-rockchip.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index 7f084eb34092..c1a1f2d864b5 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -376,7 +376,7 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int rockchip_pwm_remove(struct platform_device *pdev)
+static void rockchip_pwm_remove(struct platform_device *pdev)
 {
 	struct rockchip_pwm_chip *pc = platform_get_drvdata(pdev);
 
@@ -384,8 +384,6 @@ static int rockchip_pwm_remove(struct platform_device *pdev)
 
 	clk_unprepare(pc->pclk);
 	clk_unprepare(pc->clk);
-
-	return 0;
 }
 
 static struct platform_driver rockchip_pwm_driver = {
@@ -394,7 +392,7 @@ static struct platform_driver rockchip_pwm_driver = {
 		.of_match_table = rockchip_pwm_dt_ids,
 	},
 	.probe = rockchip_pwm_probe,
-	.remove = rockchip_pwm_remove,
+	.remove_new = rockchip_pwm_remove,
 };
 module_platform_driver(rockchip_pwm_driver);
 
-- 
2.39.1

