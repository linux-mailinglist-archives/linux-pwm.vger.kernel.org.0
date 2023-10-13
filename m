Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B747C8C7E
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Oct 2023 19:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjJMRme (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 13 Oct 2023 13:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjJMRmd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 13 Oct 2023 13:42:33 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1B6CA
        for <linux-pwm@vger.kernel.org>; Fri, 13 Oct 2023 10:42:31 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qrMB9-0004Va-VX; Fri, 13 Oct 2023 19:42:27 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qrMB8-001Rgj-JT; Fri, 13 Oct 2023 19:42:26 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qrMB8-00Filw-A0; Fri, 13 Oct 2023 19:42:26 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 06/11] pwm: imx-tpm: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
Date:   Fri, 13 Oct 2023 19:42:11 +0200
Message-ID: <20231013174204.1457085-19-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231013174204.1457085-13-u.kleine-koenig@pengutronix.de>
References: <20231013174204.1457085-13-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1940; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=8EISHAXwEtIwr6wjsRmQoHPERXhBycmKFvzjTKS2ZXo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKYF00bE+v7fm+H4G8usm8c7qoo3fyfufM4GAT 85ewwuGHE6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSmBdAAKCRCPgPtYfRL+ TgZsB/9p5fIIBCkTMLRoCP3mboFdEZS1dd/ydpGtLw2+OcGIPXL/trH0UixCholvAvJZVkQng1E hz+bVQUyVx1iQnWRmbzALXCwYKXP5sIL/CqFy2sGBF0ZFTaNILLLIwegXw7zBc6GgE0/ATTmvFN vv/699IlDekjYp0knmeKdXrFwQMRV6GO5gQJPlv8t3dJCrWgd8nOzigiGOZ91VT1y8FdXd+9ugH RIribVeGruv5aqFFoHDd8Up8NFpNzuYm+UZEKq4C0/Awjw4lScj2M0nSR7r49Qs1DkFJx5Mu3xc r+I6ZOsWYGxhuVXq2hsJv4RMxV2PFPQ48ZRfJa3sVOfye5S5
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
__maybe_unused can be dropped.

Also make use of pm_ptr() to discard all PM related stuff if CONFIG_PM
isn't enabled.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-imx-tpm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
index dc6aafeb9f7b..9fc290e647e1 100644
--- a/drivers/pwm/pwm-imx-tpm.c
+++ b/drivers/pwm/pwm-imx-tpm.c
@@ -371,7 +371,7 @@ static int pwm_imx_tpm_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __maybe_unused pwm_imx_tpm_suspend(struct device *dev)
+static int pwm_imx_tpm_suspend(struct device *dev)
 {
 	struct imx_tpm_pwm_chip *tpm = dev_get_drvdata(dev);
 
@@ -390,7 +390,7 @@ static int __maybe_unused pwm_imx_tpm_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused pwm_imx_tpm_resume(struct device *dev)
+static int pwm_imx_tpm_resume(struct device *dev)
 {
 	struct imx_tpm_pwm_chip *tpm = dev_get_drvdata(dev);
 	int ret = 0;
@@ -402,8 +402,8 @@ static int __maybe_unused pwm_imx_tpm_resume(struct device *dev)
 	return ret;
 }
 
-static SIMPLE_DEV_PM_OPS(imx_tpm_pwm_pm,
-			 pwm_imx_tpm_suspend, pwm_imx_tpm_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(imx_tpm_pwm_pm,
+				pwm_imx_tpm_suspend, pwm_imx_tpm_resume);
 
 static const struct of_device_id imx_tpm_pwm_dt_ids[] = {
 	{ .compatible = "fsl,imx7ulp-pwm", },
@@ -415,7 +415,7 @@ static struct platform_driver imx_tpm_pwm_driver = {
 	.driver = {
 		.name = "imx7ulp-tpm-pwm",
 		.of_match_table = imx_tpm_pwm_dt_ids,
-		.pm = &imx_tpm_pwm_pm,
+		.pm = pm_ptr(&imx_tpm_pwm_pm),
 	},
 	.probe	= pwm_imx_tpm_probe,
 };
-- 
2.42.0

