Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69DF7D3E37
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Oct 2023 19:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjJWRq4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 23 Oct 2023 13:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjJWRqw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 Oct 2023 13:46:52 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2294D94
        for <linux-pwm@vger.kernel.org>; Mon, 23 Oct 2023 10:46:50 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1quz0q-0001OX-DN; Mon, 23 Oct 2023 19:46:48 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1quz0p-003lQ8-Vz; Mon, 23 Oct 2023 19:46:48 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1quz0p-004VDW-Mr; Mon, 23 Oct 2023 19:46:47 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v3 11/11] pwm: tiehrpwm: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
Date:   Mon, 23 Oct 2023 19:46:28 +0200
Message-ID: <20231023174616.2282067-24-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023174616.2282067-13-u.kleine-koenig@pengutronix.de>
References: <20231023174616.2282067-13-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1444; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=zKNx627VcZI0Zve5kENW6QIzT+3jlPN65f9VZpkUp/8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlNrF171FkrEJjLxirSboGiNDHJBqu2t2bF1b5y NhSg+lZU2GJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZTaxdQAKCRCPgPtYfRL+ TjV1B/9HfE6akzL0YNFExg7hAOR3/xHHATJwKV9BiTauFisvUtXqrI9757R+cuBTReytfAdX2IT EaPTgcB/MvteXLvFpAMSBM9BnAdBtb2haQg61DZid/eUS4ljV/nEULnhdlVFdskdM2rXuL5A+tG 3nCiU3VRQqLBhNiuw8ykKdCrTpMxkWwLqmbQ8RM9G3JTosjuXTuz5lmewuFc+3GLH53MMyRS0+z eByIUeIDWTs9uOS1qTHwiXZYWycrPy4+nCn5vejbQAIuo1/A31L0XSxO72E/R/oRKrR1tbkMwa2 87hy11bWvcSL/YjtRG6VFJq23QYyAErpo1SzNSHXwi9uCZZ8
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This macro has the advantage over SIMPLE_DEV_PM_OPS that we don't have to
care about when the functions are actually used, so the corresponding
#ifdef can be dropped.

Also make use of pm_ptr() to discard all PM related stuff if CONFIG_PM
isn't enabled.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-tiehrpwm.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index 66ac2655845f..af231fa74fa9 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -521,7 +521,6 @@ static void ehrpwm_pwm_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static void ehrpwm_pwm_save_context(struct ehrpwm_pwm_chip *pc)
 {
 	pm_runtime_get_sync(pc->chip.dev);
@@ -589,16 +588,15 @@ static int ehrpwm_pwm_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(ehrpwm_pwm_pm_ops, ehrpwm_pwm_suspend,
-			 ehrpwm_pwm_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(ehrpwm_pwm_pm_ops, ehrpwm_pwm_suspend,
+				ehrpwm_pwm_resume);
 
 static struct platform_driver ehrpwm_pwm_driver = {
 	.driver = {
 		.name = "ehrpwm",
 		.of_match_table = ehrpwm_of_match,
-		.pm = &ehrpwm_pwm_pm_ops,
+		.pm = pm_ptr(&ehrpwm_pwm_pm_ops),
 	},
 	.probe = ehrpwm_pwm_probe,
 	.remove_new = ehrpwm_pwm_remove,
-- 
2.42.0

