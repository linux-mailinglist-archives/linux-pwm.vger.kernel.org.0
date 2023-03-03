Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F265A6A9FB7
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Mar 2023 19:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbjCCSz1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Mar 2023 13:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbjCCSzS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Mar 2023 13:55:18 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC651F5C8
        for <linux-pwm@vger.kernel.org>; Fri,  3 Mar 2023 10:55:05 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYZ-0006NZ-6o; Fri, 03 Mar 2023 19:55:03 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYY-001cUh-Cb; Fri, 03 Mar 2023 19:55:02 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYW-001ukX-7i; Fri, 03 Mar 2023 19:55:00 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     kernel@pengutronix.de,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 15/30] pwm: mtk-disp: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 19:54:30 +0100
Message-Id: <20230303185445.2112695-16-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303185445.2112695-1-u.kleine-koenig@pengutronix.de>
References: <20230303185445.2112695-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1609; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Grb01OXJBD2d5JT37ohCwJo6sMsGmbgBXYbL/lnoknQ=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAkIvMhJdzniXalqUQKDk24lFD0q7kY/mf3jae eQlBbcwrxOJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAJCLwAKCRDB/BR4rcrs CeR8B/4l+YurH0oWACkangTyL1EWM2oTqVAdR7h7cKltjsPubrV3TuSVXLvaSu8U0O3XnAKg2Wy o2G2ICQ09IyP+svx1qWq4iLrhYFgskwY4kE/7RrPoO+5Go1zAh0Wgv4or996e+07jv0azrhZ4Ar q4TDDTLTNaoW8VUkZZseUMJRLMGSvE+/zVoC1Oi2MgwtvVUprU40tOhHMTJX9YxKHCY5gkXo9bk tuec1wTPgX8VOPzql2sr/7N9TtwlNMT2uK2F6AJ4q/v+OK9UiPpnWEpuBGeknqPqTwxe+26bmYo ep77xiexknEGKbQB3IPEBdo7rclJsWVV74XPuYb1NOymtBuf
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
 drivers/pwm/pwm-mtk-disp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-mtk-disp.c b/drivers/pwm/pwm-mtk-disp.c
index 692a06121b28..4cfe88d54652 100644
--- a/drivers/pwm/pwm-mtk-disp.c
+++ b/drivers/pwm/pwm-mtk-disp.c
@@ -260,13 +260,11 @@ static int mtk_disp_pwm_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int mtk_disp_pwm_remove(struct platform_device *pdev)
+static void mtk_disp_pwm_remove(struct platform_device *pdev)
 {
 	struct mtk_disp_pwm *mdp = platform_get_drvdata(pdev);
 
 	pwmchip_remove(&mdp->chip);
-
-	return 0;
 }
 
 static const struct mtk_pwm_data mt2701_pwm_data = {
@@ -314,7 +312,7 @@ static struct platform_driver mtk_disp_pwm_driver = {
 		.of_match_table = mtk_disp_pwm_of_match,
 	},
 	.probe = mtk_disp_pwm_probe,
-	.remove = mtk_disp_pwm_remove,
+	.remove_new = mtk_disp_pwm_remove,
 };
 module_platform_driver(mtk_disp_pwm_driver);
 
-- 
2.39.1

