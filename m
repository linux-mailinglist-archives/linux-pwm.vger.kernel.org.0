Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBE16A9FAA
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Mar 2023 19:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbjCCSzS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Mar 2023 13:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbjCCSzQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Mar 2023 13:55:16 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900EA1E9C7
        for <linux-pwm@vger.kernel.org>; Fri,  3 Mar 2023 10:55:02 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYW-0006Ci-9R; Fri, 03 Mar 2023 19:55:00 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYV-001cTv-II; Fri, 03 Mar 2023 19:54:59 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYU-001uk1-FV; Fri, 03 Mar 2023 19:54:58 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     kernel@pengutronix.de,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 07/30] pwm: brcmstb: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 19:54:22 +0100
Message-Id: <20230303185445.2112695-8-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303185445.2112695-1-u.kleine-koenig@pengutronix.de>
References: <20230303185445.2112695-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1649; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=rKGg1AFdTpXfdMk4E8fz3PQ1JfukEUGH6p/w4jTHcvU=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAkH5ONEXWOjOJ5GhOx8Kqs76r9uXfCMfWB1yI rGIxxYEE5uJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAJB+QAKCRDB/BR4rcrs Cak/B/4s1P/7vq2xWpDIjBiVqXQY5mLJX0+7hsRE1RxmHM4Z2qSNyjNWgnynNGvmxboEhGCUHDq cGMMluwN9EJaRJxENVxKgp8Bzw4VCFC8ayR4Dym19gByyREvCgnNhuNjOfjV8Xr6UV2GpJzPAgb 6Ozoaan9bSLsBpkIzm6b/uZLI+W+YJOtv5ybYJWTYPNwMXgciCmPp1AdmMXkLKdeMqZv3Eav9mE qyqCSACdxixxgYdaQFlhu6t+gGFqxUp0eioDTfMi+Mf1E6/VKxKPfyGy7yKNGoNTuZVbqTmVviE E8NKSVnyGfOYpiohn6yUMczL4QsjhvikmA85T7DDE0ngSkJi
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
 drivers/pwm/pwm-brcmstb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-brcmstb.c b/drivers/pwm/pwm-brcmstb.c
index 3db3f96edf78..a3faa9a3de7c 100644
--- a/drivers/pwm/pwm-brcmstb.c
+++ b/drivers/pwm/pwm-brcmstb.c
@@ -275,14 +275,12 @@ static int brcmstb_pwm_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int brcmstb_pwm_remove(struct platform_device *pdev)
+static void brcmstb_pwm_remove(struct platform_device *pdev)
 {
 	struct brcmstb_pwm *p = platform_get_drvdata(pdev);
 
 	pwmchip_remove(&p->chip);
 	clk_disable_unprepare(p->clk);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -310,7 +308,7 @@ static SIMPLE_DEV_PM_OPS(brcmstb_pwm_pm_ops, brcmstb_pwm_suspend,
 
 static struct platform_driver brcmstb_pwm_driver = {
 	.probe = brcmstb_pwm_probe,
-	.remove = brcmstb_pwm_remove,
+	.remove_new = brcmstb_pwm_remove,
 	.driver = {
 		.name = "pwm-brcmstb",
 		.of_match_table = brcmstb_pwm_of_match,
-- 
2.39.1

