Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C4F6A9FC1
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Mar 2023 19:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbjCCSzb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Mar 2023 13:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbjCCSzV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Mar 2023 13:55:21 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979FD1EFE2
        for <linux-pwm@vger.kernel.org>; Fri,  3 Mar 2023 10:55:08 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYb-0006TN-KO; Fri, 03 Mar 2023 19:55:05 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYa-001cVV-Im; Fri, 03 Mar 2023 19:55:04 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYY-001ulM-QE; Fri, 03 Mar 2023 19:55:02 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     kernel@pengutronix.de, linux-pwm@vger.kernel.org
Subject: [PATCH 28/30] pwm: tiehrpwm: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 19:54:43 +0100
Message-Id: <20230303185445.2112695-29-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303185445.2112695-1-u.kleine-koenig@pengutronix.de>
References: <20230303185445.2112695-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1666; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Qvp5qnHAGwN8L5yOMH5xhh0Cj34js3G/2cPXhens94c=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAkJmNUguFuaZ/ojQv7rbiYMDqmhPFWma8InPY 9iDlDBO2iyJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAJCZgAKCRDB/BR4rcrs CcKmB/0fgExezk0vXqwwOXkivi0GwA+Z8TJ+DX8jUCc04wSVIS2t1M9KgXH88/7HhqI+FTpCoJV ETKgC2u4C58Fzofi0QF6Uad8taWSptQAVe74thEwW21wpKa6MySvhlEfTSEAD6soN3xf3e+HxKx nySLDY59P09VT/IdlLm13OuzVWHdpomB++iTMuIwy34WCHNa8AK4ZdrIlT0UTyYqY0+4c3/oM3k fFv8f+9XN0fTnLBqNEs6PvMhK19GjbyXkcRC8lQA0Ulb+GS2ywsJvJlMqGtClKNAjDVcY2xurTc KL9uzeLlC1GkhQz9O+0mbU9IbizVfFU8mavj55fAXQumHfXo
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
 drivers/pwm/pwm-tiehrpwm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index 48ca0ff690ae..bb3959ace6b4 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -511,7 +511,7 @@ static int ehrpwm_pwm_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int ehrpwm_pwm_remove(struct platform_device *pdev)
+static void ehrpwm_pwm_remove(struct platform_device *pdev)
 {
 	struct ehrpwm_pwm_chip *pc = platform_get_drvdata(pdev);
 
@@ -520,8 +520,6 @@ static int ehrpwm_pwm_remove(struct platform_device *pdev)
 	clk_unprepare(pc->tbclk);
 
 	pm_runtime_disable(&pdev->dev);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -604,7 +602,7 @@ static struct platform_driver ehrpwm_pwm_driver = {
 		.pm = &ehrpwm_pwm_pm_ops,
 	},
 	.probe = ehrpwm_pwm_probe,
-	.remove = ehrpwm_pwm_remove,
+	.remove_new = ehrpwm_pwm_remove,
 };
 module_platform_driver(ehrpwm_pwm_driver);
 
-- 
2.39.1

