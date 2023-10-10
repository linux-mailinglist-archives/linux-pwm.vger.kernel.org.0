Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD56B7BF4C9
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Oct 2023 09:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442606AbjJJHv3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 10 Oct 2023 03:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442602AbjJJHvW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 10 Oct 2023 03:51:22 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE57A9
        for <linux-pwm@vger.kernel.org>; Tue, 10 Oct 2023 00:51:21 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qq7WP-00086l-UT; Tue, 10 Oct 2023 09:51:17 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qq7WP-000bj1-GX; Tue, 10 Oct 2023 09:51:17 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qq7WP-00Cvms-7H; Tue, 10 Oct 2023 09:51:17 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de,
        Florian Fainelli <florian.fainelli@broadcom.com>
Subject: [PATCH 06/11] pwm: imx-tpm: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
Date:   Tue, 10 Oct 2023 09:51:07 +0200
Message-Id: <20231010075112.755178-7-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231010075112.755178-1-u.kleine-koenig@pengutronix.de>
References: <20231010075112.755178-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1936; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=G63sXWp1uiBNn/DBIlnt1enYAQXeqGMDNyswG5BF2RI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlJQJimPi7RUjt8eOzKBzv+gWTAKJ8E5IoqdUzd 5BLYv5R9K2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSUCYgAKCRCPgPtYfRL+ TuVpCAC5A7YTHW6fWGzymID5WHsQ6e0xL4/LF+o+kccuuVrxkuLy/jZYdvgRjxvVdDeGmY42L+/ sKwU9bhkmA2wdOM3YbbRKe/WMToGE1q516oOR/UHC0ojXTz4eumN31ozyhYTeJyOmhgL5LzjgVe G+b+AecZHGQh0DncCLEtWbhB+dxLRsCuNqADMjieAF91BS3OfmdL1jveW77ONm//lifQB4DsduX qldQVUsxjBSllG3/8x3Qzzb8I0+vOnM9XI82r1BXbqo75SAlvRdkVP5tAqMFGaI3UafAZKKhDKT MYg05ElaQnUwbfrNUx3y1HG38e7vQc7B2nhNPOluyOe9ITvF
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This macro has the advantage over SIMPLE_DEV_PM_OPS that we don't have to
care about when the functions are actually used, so the corresponding
__maybe_unused can be dropped.

Also make use of pm_ptr() to discard all PM related stuff if CONFIG_PM
isn't enabled.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-imx-tpm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
index 98ab65c89685..da22f9bb367e 100644
--- a/drivers/pwm/pwm-imx-tpm.c
+++ b/drivers/pwm/pwm-imx-tpm.c
@@ -390,7 +390,7 @@ static void pwm_imx_tpm_remove(struct platform_device *pdev)
 	clk_disable_unprepare(tpm->clk);
 }
 
-static int __maybe_unused pwm_imx_tpm_suspend(struct device *dev)
+static int pwm_imx_tpm_suspend(struct device *dev)
 {
 	struct imx_tpm_pwm_chip *tpm = dev_get_drvdata(dev);
 
@@ -409,7 +409,7 @@ static int __maybe_unused pwm_imx_tpm_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused pwm_imx_tpm_resume(struct device *dev)
+static int pwm_imx_tpm_resume(struct device *dev)
 {
 	struct imx_tpm_pwm_chip *tpm = dev_get_drvdata(dev);
 	int ret = 0;
@@ -421,8 +421,8 @@ static int __maybe_unused pwm_imx_tpm_resume(struct device *dev)
 	return ret;
 }
 
-static SIMPLE_DEV_PM_OPS(imx_tpm_pwm_pm,
-			 pwm_imx_tpm_suspend, pwm_imx_tpm_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(imx_tpm_pwm_pm,
+				pwm_imx_tpm_suspend, pwm_imx_tpm_resume);
 
 static const struct of_device_id imx_tpm_pwm_dt_ids[] = {
 	{ .compatible = "fsl,imx7ulp-pwm", },
@@ -434,7 +434,7 @@ static struct platform_driver imx_tpm_pwm_driver = {
 	.driver = {
 		.name = "imx7ulp-tpm-pwm",
 		.of_match_table = imx_tpm_pwm_dt_ids,
-		.pm = &imx_tpm_pwm_pm,
+		.pm = pm_ptr(&imx_tpm_pwm_pm),
 	},
 	.probe	= pwm_imx_tpm_probe,
 	.remove_new = pwm_imx_tpm_remove,
-- 
2.40.1

