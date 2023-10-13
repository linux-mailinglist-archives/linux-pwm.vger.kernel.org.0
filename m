Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5603C7C8C82
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Oct 2023 19:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjJMRmg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 13 Oct 2023 13:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbjJMRmd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 13 Oct 2023 13:42:33 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D66CE
        for <linux-pwm@vger.kernel.org>; Fri, 13 Oct 2023 10:42:31 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qrMBA-0004W4-5g; Fri, 13 Oct 2023 19:42:28 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qrMB9-001Rgq-0j; Fri, 13 Oct 2023 19:42:27 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qrMB8-00Fim4-NM; Fri, 13 Oct 2023 19:42:26 +0200
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
Subject: [PATCH v2 08/11] pwm: stm32-lp: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
Date:   Fri, 13 Oct 2023 19:42:13 +0200
Message-ID: <20231013174204.1457085-21-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231013174204.1457085-13-u.kleine-koenig@pengutronix.de>
References: <20231013174204.1457085-13-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1926; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=j6pb/bV7NFfh0Gqb+2QiCXxN6H2/hM95jTbHcSXTb7s=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKYF2tiOf3cCM+SIIMQgzW7RHIZJ8t/7gucUMF KUWAaeslESJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSmBdgAKCRCPgPtYfRL+ ToQ/B/0ZP+Ojsss1ccantAsWfMMbvxwIjjoC4Qmk0jd/49Xix8m9bnzf5lTPtt3ws1F5J410PqU pkRrF5uy8BVPZ8YS5u9hMohL/8wzWCHpUabLCfcsSVzwwk4p9wiav4mXefoWjhsTSJYXlcj5SwJ xsDEa5RlEyAUVm6tHDsEuSm2jo5zlZhZ/z1EWRBpZC6MxLnhg9uvklk67kQuUhUcmIpcWAItvcz PpPoQdPIRxMRkC2so5SKluFibKZ+obxSuPPyF1/Gdm8b5YbfZQAjO+5iEaGJ2RNriaIDsLjyveS fYkRJGpqlYaL4HCyPx+CyrbPG065b3OYJcAH/2kR0NCpftiF
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
 drivers/pwm/pwm-stm32-lp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
index b67974cc1872..439068f3eca1 100644
--- a/drivers/pwm/pwm-stm32-lp.c
+++ b/drivers/pwm/pwm-stm32-lp.c
@@ -218,7 +218,7 @@ static int stm32_pwm_lp_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __maybe_unused stm32_pwm_lp_suspend(struct device *dev)
+static int stm32_pwm_lp_suspend(struct device *dev)
 {
 	struct stm32_pwm_lp *priv = dev_get_drvdata(dev);
 	struct pwm_state state;
@@ -233,13 +233,13 @@ static int __maybe_unused stm32_pwm_lp_suspend(struct device *dev)
 	return pinctrl_pm_select_sleep_state(dev);
 }
 
-static int __maybe_unused stm32_pwm_lp_resume(struct device *dev)
+static int stm32_pwm_lp_resume(struct device *dev)
 {
 	return pinctrl_pm_select_default_state(dev);
 }
 
-static SIMPLE_DEV_PM_OPS(stm32_pwm_lp_pm_ops, stm32_pwm_lp_suspend,
-			 stm32_pwm_lp_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(stm32_pwm_lp_pm_ops, stm32_pwm_lp_suspend,
+				stm32_pwm_lp_resume);
 
 static const struct of_device_id stm32_pwm_lp_of_match[] = {
 	{ .compatible = "st,stm32-pwm-lp", },
@@ -252,7 +252,7 @@ static struct platform_driver stm32_pwm_lp_driver = {
 	.driver	= {
 		.name = "stm32-pwm-lp",
 		.of_match_table = stm32_pwm_lp_of_match,
-		.pm = &stm32_pwm_lp_pm_ops,
+		.pm = pm_ptr(&stm32_pwm_lp_pm_ops),
 	},
 };
 module_platform_driver(stm32_pwm_lp_driver);
-- 
2.42.0

