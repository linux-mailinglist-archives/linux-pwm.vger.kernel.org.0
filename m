Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE8E6A9FA6
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Mar 2023 19:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjCCSzP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Mar 2023 13:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbjCCSzP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Mar 2023 13:55:15 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094D61C7EE
        for <linux-pwm@vger.kernel.org>; Fri,  3 Mar 2023 10:55:02 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYW-0006Ce-35; Fri, 03 Mar 2023 19:55:00 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYV-001cTs-Ew; Fri, 03 Mar 2023 19:54:59 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYU-001ujy-9T; Fri, 03 Mar 2023 19:54:58 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     kernel@pengutronix.de, linux-pwm@vger.kernel.org
Subject: [PATCH 06/30] pwm: berlin: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 19:54:21 +0100
Message-Id: <20230303185445.2112695-7-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303185445.2112695-1-u.kleine-koenig@pengutronix.de>
References: <20230303185445.2112695-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1641; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=QS/pQG4+MrXvDWpBcB/IWKCmIkUObE4yhCDXqkRvdS8=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAkH1JT/GnD7i/7iKkY8HSEiW1cQLSfEFbbCwh nc5HuYUuSKJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAJB9QAKCRDB/BR4rcrs CWl+B/9LFgIQI2V52SjKEZ4I3ojYfyr0iCB+X55iLqbZ4wGFAwbf6PwI6xBoQbI23wFMvurWW2k qXLG3/jqprpI2O5beC/YH7XmpwkWI5ndKfRSySkBB5A9vb6ki2O/FOn6/G/qz48hUKYN9FNL59v oAhPLwGazEzkAzCTfE8ce3awQOBolESTF4MecuU1d7dSULPmWBYTHjmIHOA42/4cXaNm3cvOQhg eR8v3gZdlDqiYzYU0Lx5624MBfBcHKiBmSxc+4WmrqmXA5Gry/YrrPQAq1PISf8sEghl4OP3o1p dVn1r7YKb2I5Q9ksUIWjS6MMEAWFC8id9VVVrNGJhXgul/dq
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
 drivers/pwm/pwm-berlin.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-berlin.c b/drivers/pwm/pwm-berlin.c
index e157273fd2f7..0c5992a046b2 100644
--- a/drivers/pwm/pwm-berlin.c
+++ b/drivers/pwm/pwm-berlin.c
@@ -250,15 +250,13 @@ static int berlin_pwm_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int berlin_pwm_remove(struct platform_device *pdev)
+static void berlin_pwm_remove(struct platform_device *pdev)
 {
 	struct berlin_pwm_chip *bpc = platform_get_drvdata(pdev);
 
 	pwmchip_remove(&bpc->chip);
 
 	clk_disable_unprepare(bpc->clk);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -317,7 +315,7 @@ static SIMPLE_DEV_PM_OPS(berlin_pwm_pm_ops, berlin_pwm_suspend,
 
 static struct platform_driver berlin_pwm_driver = {
 	.probe = berlin_pwm_probe,
-	.remove = berlin_pwm_remove,
+	.remove_new = berlin_pwm_remove,
 	.driver = {
 		.name = "berlin-pwm",
 		.of_match_table = berlin_pwm_match,
-- 
2.39.1

