Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4937C8C83
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Oct 2023 19:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjJMRmg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 13 Oct 2023 13:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjJMRmd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 13 Oct 2023 13:42:33 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF97ECF
        for <linux-pwm@vger.kernel.org>; Fri, 13 Oct 2023 10:42:31 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qrMBA-0004W5-5f; Fri, 13 Oct 2023 19:42:28 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qrMB9-001Rgt-7B; Fri, 13 Oct 2023 19:42:27 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qrMB8-00Fim8-U2; Fri, 13 Oct 2023 19:42:26 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pwm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 09/11] pwm: stm32: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
Date:   Fri, 13 Oct 2023 19:42:14 +0200
Message-ID: <20231013174204.1457085-22-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231013174204.1457085-13-u.kleine-koenig@pengutronix.de>
References: <20231013174204.1457085-13-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1966; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=8LOtNenmZF8wkliwgTRGuRDknwBK+eJm9E5HUGBysKU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKYF31hWc33CRR/2b76E9SKmrA340sicAvYfa4 67mDAktmeCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSmBdwAKCRCPgPtYfRL+ TslDCACq68fONJQpm9wTYhKsRdckUMaZ2l50fTJlGwjxlrBJV0yrBIe/2VRyDaC961gEjp3MShG mNDlg5VA7i0Ydi4ikY326E3GCWSFO5MXbkDY3TP1UVERTDxMgSZy7mSZjLHUl3OmDdCu5p5XZ2F +GSVg1aN2RpjgbyTOaNMxoWi8ldCWf5fn/jwpv9QcxetmEDup0ikDOodsatsFZ2uQKsWRJlEd8i l9YO1C7y47Kopsz8KM47IebvnPEgpdys0Yh03CsyafASLBAv0bq1BPtG6JDIahfE+v1V2wrge7F gk0+ApkSQ2/syWIuEERbKyipwOGHmEXwkHjztNt7a5DO2SB6
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
 drivers/pwm/pwm-stm32.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index 3303a754ea02..8be037757b8b 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -645,7 +645,7 @@ static int stm32_pwm_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __maybe_unused stm32_pwm_suspend(struct device *dev)
+static int stm32_pwm_suspend(struct device *dev)
 {
 	struct stm32_pwm *priv = dev_get_drvdata(dev);
 	unsigned int i;
@@ -666,7 +666,7 @@ static int __maybe_unused stm32_pwm_suspend(struct device *dev)
 	return pinctrl_pm_select_sleep_state(dev);
 }
 
-static int __maybe_unused stm32_pwm_resume(struct device *dev)
+static int stm32_pwm_resume(struct device *dev)
 {
 	struct stm32_pwm *priv = dev_get_drvdata(dev);
 	int ret;
@@ -679,7 +679,7 @@ static int __maybe_unused stm32_pwm_resume(struct device *dev)
 	return stm32_pwm_apply_breakinputs(priv);
 }
 
-static SIMPLE_DEV_PM_OPS(stm32_pwm_pm_ops, stm32_pwm_suspend, stm32_pwm_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(stm32_pwm_pm_ops, stm32_pwm_suspend, stm32_pwm_resume);
 
 static const struct of_device_id stm32_pwm_of_match[] = {
 	{ .compatible = "st,stm32-pwm",	},
@@ -692,7 +692,7 @@ static struct platform_driver stm32_pwm_driver = {
 	.driver	= {
 		.name = "stm32-pwm",
 		.of_match_table = stm32_pwm_of_match,
-		.pm = &stm32_pwm_pm_ops,
+		.pm = pm_ptr(&stm32_pwm_pm_ops),
 	},
 };
 module_platform_driver(stm32_pwm_driver);
-- 
2.42.0

