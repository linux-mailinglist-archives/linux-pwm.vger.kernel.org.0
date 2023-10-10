Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402E97BF4CA
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Oct 2023 09:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442600AbjJJHva (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 10 Oct 2023 03:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442572AbjJJHvY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 10 Oct 2023 03:51:24 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11489F
        for <linux-pwm@vger.kernel.org>; Tue, 10 Oct 2023 00:51:22 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qq7WR-00087G-3k; Tue, 10 Oct 2023 09:51:19 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qq7WP-000bj9-U6; Tue, 10 Oct 2023 09:51:17 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qq7WP-00Cvn0-Km; Tue, 10 Oct 2023 09:51:17 +0200
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
Subject: [PATCH 08/11] pwm: stm32-lp: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
Date:   Tue, 10 Oct 2023 09:51:09 +0200
Message-Id: <20231010075112.755178-9-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231010075112.755178-1-u.kleine-koenig@pengutronix.de>
References: <20231010075112.755178-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1865; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Ie2lp5jK0RCijQw0QeInl/FaAgYLDxQHke+dn88ClU8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlJQJl2mAn/jl4uOMOspFvPR6S+3oYZDPCWeC6L +OuWe3zDvWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSUCZQAKCRCPgPtYfRL+ TvIEB/9ABMEJUE/NOby37gCqrb4KC3z5SDOZIZPoBsVrQXbXcDwwsK+H8/ecRTHXKyHnaNicyVL GCPexNj4ZyC4hkYEdBPEgPZPR1wrQ68gKC49hqL9W/r0sqBwYY2Nv//EHG7DviaEjz5XCQWPPPj oheWF3hZoo5CrK+uQuU1nB4bKu+gjtuTzZVmvtRQPeFvlMuv7sCM7nYc4vjwYYOcPnFI+avhJa7 q+TLTRwmKHqyESxWAT5GkhjWr7Gps3eU73sKJF7UBTkAat7iyKRHnh3bFdpccIqfr1t3YgdP+s0 3T4QK5bdDvVEWbkOxhskn7DT5eeAy+Enj971PGAr5mVe2+HN
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
 drivers/pwm/pwm-stm32-lp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
index bb3a045a7334..ac00f9224bda 100644
--- a/drivers/pwm/pwm-stm32-lp.c
+++ b/drivers/pwm/pwm-stm32-lp.c
@@ -219,7 +219,7 @@ static int stm32_pwm_lp_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __maybe_unused stm32_pwm_lp_suspend(struct device *dev)
+static int stm32_pwm_lp_suspend(struct device *dev)
 {
 	struct stm32_pwm_lp *priv = dev_get_drvdata(dev);
 	struct pwm_state state;
@@ -234,13 +234,13 @@ static int __maybe_unused stm32_pwm_lp_suspend(struct device *dev)
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
@@ -253,7 +253,7 @@ static struct platform_driver stm32_pwm_lp_driver = {
 	.driver	= {
 		.name = "stm32-pwm-lp",
 		.of_match_table = stm32_pwm_lp_of_match,
-		.pm = &stm32_pwm_lp_pm_ops,
+		.pm = pm_ptr(&stm32_pwm_lp_pm_ops),
 	},
 };
 module_platform_driver(stm32_pwm_lp_driver);
-- 
2.40.1

