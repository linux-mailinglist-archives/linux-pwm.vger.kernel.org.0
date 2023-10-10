Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16FAD7BF4CC
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Oct 2023 09:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442572AbjJJHvc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 10 Oct 2023 03:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442599AbjJJHvY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 10 Oct 2023 03:51:24 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C74A4
        for <linux-pwm@vger.kernel.org>; Tue, 10 Oct 2023 00:51:22 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qq7WR-00087P-3k; Tue, 10 Oct 2023 09:51:19 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qq7WQ-000bjD-4I; Tue, 10 Oct 2023 09:51:18 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qq7WP-00Cvn3-RF; Tue, 10 Oct 2023 09:51:17 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pwm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        Florian Fainelli <florian.fainelli@broadcom.com>
Subject: [PATCH 09/11] pwm: stm32: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
Date:   Tue, 10 Oct 2023 09:51:10 +0200
Message-Id: <20231010075112.755178-10-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231010075112.755178-1-u.kleine-koenig@pengutronix.de>
References: <20231010075112.755178-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1905; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=J3d8GcPNU2JxszGotBSV8ACakmJafzp5yz5XcHiQaD0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlJQJm44pduhUOh3aCddSM3B/P4UVVaobbygE6l PzBHz6cq3mJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSUCZgAKCRCPgPtYfRL+ Ttx5B/49/KWR8RJARvVqld2wmoZpAKyXjgurfzNnviwVQFJQM+/rLjfSK0agiFekdEWjBpVSafI lFTXT1N8uZyDciIu+oQJuaeyfSWBvIruNaaWMw3cr/WHagipYYcApQG3rLg3p1hcd/6U+m0p5/l 95aiQVEhxDs0ABlwM4qh5NAflNSTzdkNT4MgeHAdQZZsN0UTs4gGKXrlSocIlyVOMk5UQlrKr5h H9mRdqdIp7lbr09q4O0uNITV/yY2abY3g8VRHAeMJ7FkGFtT7TcnK7pc6703kZAUIybpoPlsO/T G1X7NCDPAVzkiwIUt+68oOjW60G5vkwQV8qI2Kvs4/B5m1+a
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
 drivers/pwm/pwm-stm32.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index 3d6be7749e23..a9c7b5b6ab23 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -646,7 +646,7 @@ static int stm32_pwm_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __maybe_unused stm32_pwm_suspend(struct device *dev)
+static int stm32_pwm_suspend(struct device *dev)
 {
 	struct stm32_pwm *priv = dev_get_drvdata(dev);
 	unsigned int i;
@@ -667,7 +667,7 @@ static int __maybe_unused stm32_pwm_suspend(struct device *dev)
 	return pinctrl_pm_select_sleep_state(dev);
 }
 
-static int __maybe_unused stm32_pwm_resume(struct device *dev)
+static int stm32_pwm_resume(struct device *dev)
 {
 	struct stm32_pwm *priv = dev_get_drvdata(dev);
 	int ret;
@@ -680,7 +680,7 @@ static int __maybe_unused stm32_pwm_resume(struct device *dev)
 	return stm32_pwm_apply_breakinputs(priv);
 }
 
-static SIMPLE_DEV_PM_OPS(stm32_pwm_pm_ops, stm32_pwm_suspend, stm32_pwm_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(stm32_pwm_pm_ops, stm32_pwm_suspend, stm32_pwm_resume);
 
 static const struct of_device_id stm32_pwm_of_match[] = {
 	{ .compatible = "st,stm32-pwm",	},
@@ -693,7 +693,7 @@ static struct platform_driver stm32_pwm_driver = {
 	.driver	= {
 		.name = "stm32-pwm",
 		.of_match_table = stm32_pwm_of_match,
-		.pm = &stm32_pwm_pm_ops,
+		.pm = pm_ptr(&stm32_pwm_pm_ops),
 	},
 };
 module_platform_driver(stm32_pwm_driver);
-- 
2.40.1

