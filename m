Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05B26A9FA9
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Mar 2023 19:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbjCCSzS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Mar 2023 13:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjCCSzP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Mar 2023 13:55:15 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D1A1E1D1
        for <linux-pwm@vger.kernel.org>; Fri,  3 Mar 2023 10:55:02 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYV-0006Bu-L7; Fri, 03 Mar 2023 19:54:59 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYU-001cTm-W9; Fri, 03 Mar 2023 19:54:59 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYU-001uju-1U; Fri, 03 Mar 2023 19:54:58 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     kernel@pengutronix.de,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-pwm@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 05/30] pwm: bcm2835: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 19:54:20 +0100
Message-Id: <20230303185445.2112695-6-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303185445.2112695-1-u.kleine-koenig@pengutronix.de>
References: <20230303185445.2112695-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1639; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=9OzSbnnYC8iqzuXktA0f1ZFDPb+5PHPMNNM8l/0ysls=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAkHyZu2ripSOcvZAf/TF6l5MSMPNEDRVpEEOn Rr/Mhr1JgGJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAJB8gAKCRDB/BR4rcrs CcveB/4q24CIpseUQ2ovZENwAbeFS7H7sVt7kKkv3vLcVJNdOQqbMhi1IIUyRQWRppggvR0PDaj 8j2ObYKL6Ezjm7WA3LVPn3cLHCn2tmSlbequ54vIKlrLlv9zFycjOXKHklNbhFDIoYr1ssYZ+VP JYhSVWtLakIfPMehH4IPA7m+Xx7szUuvl6dyxnRzmpTijrYuEcZs6fhQHlflnc99nzsVz4qE9JF J5qdlFj1+kFafnWbYk0e8uI89ljCZWkW1T3bOa5n4IE16Oqpn8fPTnWcMqTNvHFt60dcRBlcePm ywmpWm3e3IHhzBoF3Q42q0Q5Mz0NIRCkI5hckt4HdPlNSQaR
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
 drivers/pwm/pwm-bcm2835.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
index 50b8594be31d..bdfc2a5ec0d6 100644
--- a/drivers/pwm/pwm-bcm2835.c
+++ b/drivers/pwm/pwm-bcm2835.c
@@ -173,15 +173,13 @@ static int bcm2835_pwm_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int bcm2835_pwm_remove(struct platform_device *pdev)
+static void bcm2835_pwm_remove(struct platform_device *pdev)
 {
 	struct bcm2835_pwm *pc = platform_get_drvdata(pdev);
 
 	pwmchip_remove(&pc->chip);
 
 	clk_disable_unprepare(pc->clk);
-
-	return 0;
 }
 
 static const struct of_device_id bcm2835_pwm_of_match[] = {
@@ -196,7 +194,7 @@ static struct platform_driver bcm2835_pwm_driver = {
 		.of_match_table = bcm2835_pwm_of_match,
 	},
 	.probe = bcm2835_pwm_probe,
-	.remove = bcm2835_pwm_remove,
+	.remove_new = bcm2835_pwm_remove,
 };
 module_platform_driver(bcm2835_pwm_driver);
 
-- 
2.39.1

