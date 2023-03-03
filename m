Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4280B6A9FC6
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Mar 2023 19:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbjCCSzf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Mar 2023 13:55:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbjCCSzW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Mar 2023 13:55:22 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE85C1F49C
        for <linux-pwm@vger.kernel.org>; Fri,  3 Mar 2023 10:55:10 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYc-0006Vq-Rn; Fri, 03 Mar 2023 19:55:06 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYb-001cVe-3B; Fri, 03 Mar 2023 19:55:05 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYZ-001ulY-6Z; Fri, 03 Mar 2023 19:55:03 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sean Anderson <sean.anderson@seco.com>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     kernel@pengutronix.de, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 30/30] pwm: xilinx: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 19:54:45 +0100
Message-Id: <20230303185445.2112695-31-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303185445.2112695-1-u.kleine-koenig@pengutronix.de>
References: <20230303185445.2112695-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1746; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=MKB4+uwkQqA+k9JUtan/pHZH4wXxap5m9+j+9N4rxck=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAkJuO+pZ4UJmsCo5fjz2lmSwede4sGVFTfNxZ Hzg4MFIZuSJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAJCbgAKCRDB/BR4rcrs CUHcB/4wVIc34KvwflBIA6WPxs+hWpsLUhJi8XPRSet9W/rrTPuvKia2kWq4EdmAvU2fj5PDf0r DcyN3bncqthO5XYydcqHpYUoqSfPTxn4w8hQiLrIrqCwXNcDRkhlvLkZ+Lo80hj4GB0oGYweeyz fccrCUdKaI+gkgKaoJtEIYiVQNsuWlbKm4EFNFW+UnUnjyRzYGxDaBtohcpeGhPh5I7aZdUtfqO 5SKXxZBkL3fzO2lhbLdPdjg8Y0AlnrYuUTHHeqEEjQXJDkVTup7lIzbUot6/ck/y1BIQ/v7rmSl ncyAZqoCpIvZxP+gJogFmARUz2UFUtglkrIdppcqtRBntJkm
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
 drivers/pwm/pwm-xilinx.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-xilinx.c b/drivers/pwm/pwm-xilinx.c
index f7a50fdcd9a5..85153ee90809 100644
--- a/drivers/pwm/pwm-xilinx.c
+++ b/drivers/pwm/pwm-xilinx.c
@@ -292,14 +292,13 @@ static int xilinx_pwm_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int xilinx_pwm_remove(struct platform_device *pdev)
+static void xilinx_pwm_remove(struct platform_device *pdev)
 {
 	struct xilinx_pwm_device *xilinx_pwm = platform_get_drvdata(pdev);
 
 	pwmchip_remove(&xilinx_pwm->chip);
 	clk_rate_exclusive_put(xilinx_pwm->priv.clk);
 	clk_disable_unprepare(xilinx_pwm->priv.clk);
-	return 0;
 }
 
 static const struct of_device_id xilinx_pwm_of_match[] = {
@@ -310,7 +309,7 @@ MODULE_DEVICE_TABLE(of, xilinx_pwm_of_match);
 
 static struct platform_driver xilinx_pwm_driver = {
 	.probe = xilinx_pwm_probe,
-	.remove = xilinx_pwm_remove,
+	.remove_new = xilinx_pwm_remove,
 	.driver = {
 		.name = "xilinx-pwm",
 		.of_match_table = of_match_ptr(xilinx_pwm_of_match),
-- 
2.39.1

