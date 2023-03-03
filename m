Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342A46A9FA7
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Mar 2023 19:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjCCSzQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Mar 2023 13:55:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbjCCSzP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Mar 2023 13:55:15 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1B41CF66
        for <linux-pwm@vger.kernel.org>; Fri,  3 Mar 2023 10:55:02 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYV-0006BC-G2; Fri, 03 Mar 2023 19:54:59 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYU-001cTh-P9; Fri, 03 Mar 2023 19:54:58 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYT-001ujq-R7; Fri, 03 Mar 2023 19:54:57 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     kernel@pengutronix.de,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 04/30] pwm: bcm-iproc: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 19:54:19 +0100
Message-Id: <20230303185445.2112695-5-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303185445.2112695-1-u.kleine-koenig@pengutronix.de>
References: <20230303185445.2112695-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1634; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=v5siBRk+roV0XcgHA/dyf3arbYbF5pDLxnAQyx5oTK4=; b=owEBbAGT/pANAwAKAcH8FHityuwJAcsmYgBkAkHuZGfuddGOC54yaimNSDalHklk4cEaRulgA ACiUrWljC2JATIEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAJB7gAKCRDB/BR4rcrs CShvB/jw5sBOB9w0PIvJc+/NPs4hKIn9wG1PtS4dZ71YwNSzHevuD19JpAD+gbdOfheT+4r61Bh 09FXBcmTjSEJZz1Qy8ChPq+0819TiOLE6MG7RrWiJ6SsAlTK+oVDoxsLqK+buZqiwzSH4oeueRk pSRzBbYLJu5yT7g3cJ7MAjwk9c8tiKaAKlrgOjhqDx4zz39TZr5HtHCK/+ADFyAoHjv5Tl3jafB Oj4zkeYg7kiIvbpO1LvLBh5uE2mgEiGPB8UJCp6LOpOjZC1lNuEur4USOAHKRtu10NtTqcXjVGL RCO8oCLo0W6cZPYEWiqvkL9ufy88M+PrTcEazBNqs53jpM8=
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
 drivers/pwm/pwm-bcm-iproc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-bcm-iproc.c b/drivers/pwm/pwm-bcm-iproc.c
index 97ec131eb7c1..7d70b6f186a6 100644
--- a/drivers/pwm/pwm-bcm-iproc.c
+++ b/drivers/pwm/pwm-bcm-iproc.c
@@ -239,15 +239,13 @@ static int iproc_pwmc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int iproc_pwmc_remove(struct platform_device *pdev)
+static void iproc_pwmc_remove(struct platform_device *pdev)
 {
 	struct iproc_pwmc *ip = platform_get_drvdata(pdev);
 
 	pwmchip_remove(&ip->chip);
 
 	clk_disable_unprepare(ip->clk);
-
-	return 0;
 }
 
 static const struct of_device_id bcm_iproc_pwmc_dt[] = {
@@ -262,7 +260,7 @@ static struct platform_driver iproc_pwmc_driver = {
 		.of_match_table = bcm_iproc_pwmc_dt,
 	},
 	.probe = iproc_pwmc_probe,
-	.remove = iproc_pwmc_remove,
+	.remove_new = iproc_pwmc_remove,
 };
 module_platform_driver(iproc_pwmc_driver);
 
-- 
2.39.1

