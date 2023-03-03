Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2276A9FBD
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Mar 2023 19:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbjCCSza (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Mar 2023 13:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbjCCSzT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Mar 2023 13:55:19 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64021514C
        for <linux-pwm@vger.kernel.org>; Fri,  3 Mar 2023 10:55:06 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYY-0006L2-Bg; Fri, 03 Mar 2023 19:55:02 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYX-001cUW-I6; Fri, 03 Mar 2023 19:55:01 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYV-001ukL-Jl; Fri, 03 Mar 2023 19:54:59 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     kernel@pengutronix.de, Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 12/30] pwm: imx-tpm: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 19:54:27 +0100
Message-Id: <20230303185445.2112695-13-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303185445.2112695-1-u.kleine-koenig@pengutronix.de>
References: <20230303185445.2112695-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1636; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Qx3j68BkfD/inPzXPLkyEHJTkWgDH4hTeZjQhIpua2k=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAkIJilaNHTBmhLsR421lCA0fK+5fFSKiSv8ZO VfDZLfEJ3OJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAJCCQAKCRDB/BR4rcrs CXRhB/0S/KfGDbb92ohYi6b7UoXH+6zB1nebbd3NjtbCr4bv7kvQZwLBGZIU8Q69k3RluRQc0H5 qh9ym2X1WLr09r1PAv5pH5QO04/tOVBhGkL472Z7Drv+ckVcRbvNLln5hl2t6JZspaqo387l5qd 55jdc5efgGtxv2tRhqZ3cI2GHkUxn2j45jq9bEUZ4vwFbiBoJDnUhGyO4BEngxSAaNDw8LsZxHI X0UaCfn+H/AiaCRPuS10GGPyjajFx0jxD+5E1WMCKzA2YyY+DGO54/AwzBCT7M6eWDYyx21mqxI nsiD/zgn7hnlScxwV7PL9WMJ7tTqMKWIe6dNFS2V3m2nvFWm
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
 drivers/pwm/pwm-imx-tpm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
index ed1aad96fff0..5e2b452ee5f2 100644
--- a/drivers/pwm/pwm-imx-tpm.c
+++ b/drivers/pwm/pwm-imx-tpm.c
@@ -381,15 +381,13 @@ static int pwm_imx_tpm_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int pwm_imx_tpm_remove(struct platform_device *pdev)
+static void pwm_imx_tpm_remove(struct platform_device *pdev)
 {
 	struct imx_tpm_pwm_chip *tpm = platform_get_drvdata(pdev);
 
 	pwmchip_remove(&tpm->chip);
 
 	clk_disable_unprepare(tpm->clk);
-
-	return 0;
 }
 
 static int __maybe_unused pwm_imx_tpm_suspend(struct device *dev)
@@ -432,7 +430,7 @@ static struct platform_driver imx_tpm_pwm_driver = {
 		.pm = &imx_tpm_pwm_pm,
 	},
 	.probe	= pwm_imx_tpm_probe,
-	.remove = pwm_imx_tpm_remove,
+	.remove_new = pwm_imx_tpm_remove,
 };
 module_platform_driver(imx_tpm_pwm_driver);
 
-- 
2.39.1

