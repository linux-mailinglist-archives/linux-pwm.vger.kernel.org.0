Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF916A9FB4
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Mar 2023 19:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbjCCSzY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Mar 2023 13:55:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbjCCSzS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Mar 2023 13:55:18 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236E21F4A2
        for <linux-pwm@vger.kernel.org>; Fri,  3 Mar 2023 10:55:04 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYY-0006KJ-41; Fri, 03 Mar 2023 19:55:02 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYX-001cUP-BY; Fri, 03 Mar 2023 19:55:01 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYV-001ukQ-QA; Fri, 03 Mar 2023 19:54:59 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>
Cc:     kernel@pengutronix.de, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 13/30] pwm: lpc18xx-sct: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 19:54:28 +0100
Message-Id: <20230303185445.2112695-14-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303185445.2112695-1-u.kleine-koenig@pengutronix.de>
References: <20230303185445.2112695-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1775; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=I71n/M4JjXwoVG498QigfPTCYZOxyVxtqldIZMXZh3M=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAkIM3roj9ZCzs68PbczbWFcAOh0/cqrPMGaiI BGTSYD8ozWJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAJCDAAKCRDB/BR4rcrs CZ5GCACWc8IzdPPmgPAk8/Bi+2azigSbL4wWxh9u48mKkmlChFqf94bbV51BnQp6P7bjHY0Ht/N aOlOr/C+sVm59tFCqPnzP/kl7BoF78s/Q/GRu5Ffr0C14grcLi/YJWIEWVUihEVKsHhlkMbqj6I 3uMRNaU+1344ld8ZSGM3zoRiAQ4DYh/jQ4gdSVnCXUxSB7yFaNXuBVymRGeT0JgW3vYBobdkjcz QxlBlPpZ6lRgXQeUObqz/Ov9qSBR5yzfJFlj3wrRAWB7C0RfctSVne2Svfo3xdD1ro+2J7Ut0vO 3vsjJRaxI+B0RvgF5dhBl0DClrb2EZdbHFPyCzwYK0H2Xk0A
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
 drivers/pwm/pwm-lpc18xx-sct.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-lpc18xx-sct.c b/drivers/pwm/pwm-lpc18xx-sct.c
index 378e1df944dc..b9bf5b366f4b 100644
--- a/drivers/pwm/pwm-lpc18xx-sct.c
+++ b/drivers/pwm/pwm-lpc18xx-sct.c
@@ -449,7 +449,7 @@ static int lpc18xx_pwm_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int lpc18xx_pwm_remove(struct platform_device *pdev)
+static void lpc18xx_pwm_remove(struct platform_device *pdev)
 {
 	struct lpc18xx_pwm_chip *lpc18xx_pwm = platform_get_drvdata(pdev);
 	u32 val;
@@ -461,8 +461,6 @@ static int lpc18xx_pwm_remove(struct platform_device *pdev)
 			   val | LPC18XX_PWM_CTRL_HALT);
 
 	clk_disable_unprepare(lpc18xx_pwm->pwm_clk);
-
-	return 0;
 }
 
 static struct platform_driver lpc18xx_pwm_driver = {
@@ -471,7 +469,7 @@ static struct platform_driver lpc18xx_pwm_driver = {
 		.of_match_table = lpc18xx_pwm_of_match,
 	},
 	.probe = lpc18xx_pwm_probe,
-	.remove = lpc18xx_pwm_remove,
+	.remove_new = lpc18xx_pwm_remove,
 };
 module_platform_driver(lpc18xx_pwm_driver);
 
-- 
2.39.1

