Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7887BF4C4
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Oct 2023 09:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442598AbjJJHv1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 10 Oct 2023 03:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442603AbjJJHvW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 10 Oct 2023 03:51:22 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A02EC1
        for <linux-pwm@vger.kernel.org>; Tue, 10 Oct 2023 00:51:20 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qq7WP-00085w-3D; Tue, 10 Oct 2023 09:51:17 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qq7WO-000bij-D6; Tue, 10 Oct 2023 09:51:16 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qq7WO-00CvmT-3j; Tue, 10 Oct 2023 09:51:16 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de,
        Florian Fainelli <florian.fainelli@broadcom.com>
Subject: [PATCH 01/11] pwm: atmel-hlcdc: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
Date:   Tue, 10 Oct 2023 09:51:02 +0200
Message-Id: <20231010075112.755178-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231010075112.755178-1-u.kleine-koenig@pengutronix.de>
References: <20231010075112.755178-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1713; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=C4+umzVxT2rhBws90sGSAPmmXJWOYZzV3E3d1iM1tTE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlJQJdwNkD9AMb8h1TC1gu+ZrmsYpEiuwEXqh9v H/K2AFahRaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSUCXQAKCRCPgPtYfRL+ TixFB/4lnF/5hqEn9S3Evs6U8C0xcsfz6ni6ffDR2wLn4rfdDZUcP9bqwPI6y9qSDqRPEv7cYUC Hp8OrgOPWmMUEVBDHD3Ujb/+Myu0ylE+GlaUB9MrfkXyZAfZaSM8z9l7jTITGaR7rfH7pTfy61b LA/qRvx0PiUyU6irtUn9F6YScW3VSI7Wgfcvjhjn3tOY6DQt1Vetm3SG1UHth5FlM5fuVcS4RFl tv6EqdH5b1D01YyqnRAEiyHgIBWyF6URUHdbmdnJvmBgW10hDuQu74vZRCQ2JZac9Q2W1gJHkg4 4WSmwPh3H0VaPA3ZDBUnaKOmYKuDmi78hTXY21WfKoRL6zdj
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
#ifdef can be dropped.

Also make use of pm_ptr() to discard all PM related stuff if CONFIG_PM
isn't enabled.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-atmel-hlcdc.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-atmel-hlcdc.c b/drivers/pwm/pwm-atmel-hlcdc.c
index e271d920151e..95a806c7f623 100644
--- a/drivers/pwm/pwm-atmel-hlcdc.c
+++ b/drivers/pwm/pwm-atmel-hlcdc.c
@@ -181,7 +181,6 @@ static const struct atmel_hlcdc_pwm_errata atmel_hlcdc_pwm_sama5d3_errata = {
 	.div1_clk_erratum = true,
 };
 
-#ifdef CONFIG_PM_SLEEP
 static int atmel_hlcdc_pwm_suspend(struct device *dev)
 {
 	struct atmel_hlcdc_pwm *atmel = dev_get_drvdata(dev);
@@ -211,10 +210,9 @@ static int atmel_hlcdc_pwm_resume(struct device *dev)
 	return atmel_hlcdc_pwm_apply(&atmel->chip, &atmel->chip.pwms[0],
 				     &state);
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(atmel_hlcdc_pwm_pm_ops,
-			 atmel_hlcdc_pwm_suspend, atmel_hlcdc_pwm_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(atmel_hlcdc_pwm_pm_ops,
+				atmel_hlcdc_pwm_suspend, atmel_hlcdc_pwm_resume);
 
 static const struct of_device_id atmel_hlcdc_dt_ids[] = {
 	{
@@ -298,7 +296,7 @@ static struct platform_driver atmel_hlcdc_pwm_driver = {
 	.driver = {
 		.name = "atmel-hlcdc-pwm",
 		.of_match_table = atmel_hlcdc_pwm_dt_ids,
-		.pm = &atmel_hlcdc_pwm_pm_ops,
+		.pm = pm_ptr(&atmel_hlcdc_pwm_pm_ops),
 	},
 	.probe = atmel_hlcdc_pwm_probe,
 	.remove_new = atmel_hlcdc_pwm_remove,
-- 
2.40.1

