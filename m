Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4717E7D3E38
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Oct 2023 19:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjJWRq4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 23 Oct 2023 13:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjJWRqv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 Oct 2023 13:46:51 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68FAC5
        for <linux-pwm@vger.kernel.org>; Mon, 23 Oct 2023 10:46:49 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1quz0q-0001O0-4P; Mon, 23 Oct 2023 19:46:48 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1quz0p-003lQ3-OF; Mon, 23 Oct 2023 19:46:47 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1quz0p-004VDS-FB; Mon, 23 Oct 2023 19:46:47 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v3 10/11] pwm: tiecap: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
Date:   Mon, 23 Oct 2023 19:46:27 +0200
Message-ID: <20231023174616.2282067-23-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023174616.2282067-13-u.kleine-koenig@pengutronix.de>
References: <20231023174616.2282067-13-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1416; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=OqRLW9aRLKFiiMBJBiBmU5M8wPPGP922TZa5WDkCoOY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlNrF0DTjNcDe+czirCjJ4CgLepgfT8ZFAUwY6/ +uZ+c+Ov/iJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZTaxdAAKCRCPgPtYfRL+ Tl33B/0WyOfhPzX9alpsPx/Jww10LW4jCI7N6MdL34FiwRNJt5BJRCGbPZ7RQk3fziwFaS3nZVT LH0lGVTw3VrzEKg5v1DWb3qDD4MvUJ38Yw6yN8MzsmkNkWBayAd4iDHy1Y4M1wrwkVk1hrqJYD4 DC+YCM6uY4HMoUdhoulcbXtLu7W4RonSADo8+nKfKzYEfYpebsvNFkRjJ4ScaAsJqtTYmNbxo+b zZxewIHwrT0Rot7NC21Aut9Ssf8feiJgcXoUcj+eM00Y2QZDMXX0eAQ1Y0iiTvQ0vMwyGTNZJ5d v9weSEd4YTlkupJjbl9NdsFghHuoHJz+aQeXNxEQ6xEZWFKV
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
 drivers/pwm/pwm-tiecap.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-tiecap.c b/drivers/pwm/pwm-tiecap.c
index 11e3549cf103..d974f4414ac9 100644
--- a/drivers/pwm/pwm-tiecap.c
+++ b/drivers/pwm/pwm-tiecap.c
@@ -269,7 +269,6 @@ static void ecap_pwm_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static void ecap_pwm_save_context(struct ecap_pwm_chip *pc)
 {
 	pm_runtime_get_sync(pc->chip.dev);
@@ -312,15 +311,14 @@ static int ecap_pwm_resume(struct device *dev)
 	ecap_pwm_restore_context(pc);
 	return 0;
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(ecap_pwm_pm_ops, ecap_pwm_suspend, ecap_pwm_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(ecap_pwm_pm_ops, ecap_pwm_suspend, ecap_pwm_resume);
 
 static struct platform_driver ecap_pwm_driver = {
 	.driver = {
 		.name = "ecap",
 		.of_match_table = ecap_of_match,
-		.pm = &ecap_pwm_pm_ops,
+		.pm = pm_ptr(&ecap_pwm_pm_ops),
 	},
 	.probe = ecap_pwm_probe,
 	.remove_new = ecap_pwm_remove,
-- 
2.42.0

